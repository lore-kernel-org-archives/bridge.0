Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri+SD2Yc1KXe7XVzan10Kk/GAeyQKExgjuIbCygDU9w=;
 b=d710FNp1UMItE8gjhxc9o0moyh44p6Am9BDvB7cWRLiHaZODlTFNCMAi9Pd9KqbnPOo5ivnZpfx0W9PMMo1Zajbr6vE/DY4Q4+68g1wIhxTXqAu0erXpE0rBZNIybvhu0PaG363BJhSkeaOF2DTVbR133M88G3YU7MHsOfjXxHg=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 3 Aug 2021 18:15:35 +0000
Message-ID: <20210803181534.qgbcjow4ketd4yio@skbuf>
References: <20210803143624.1135002-1-vladimir.oltean@nxp.com>
 <00acb107-8ff6-9c98-e6c3-f6718d5ce9f4@ti.com>
In-Reply-To: <00acb107-8ff6-9c98-e6c3-f6718d5ce9f4@ti.com>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <5EBB01D20F46D54F874D3AB13112056B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 0/2] Convert switchdev_bridge_port_{,
 un}offload to notifiers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Arnd Bergmann <arnd@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Tue, Aug 03, 2021 at 08:11:56PM +0300, Grygorii Strashko wrote:
> I've tested builds, but was not able to test bridge itself on TI am57x pl=
atform.
>=20
> 1) See warning
> [    3.958496] ------------[ cut here ]------------
> [    3.963165] WARNING: CPU: 0 PID: 1 at lib/refcount.c:25 fib_create_inf=
o+0xae8/0xbd4
> [    3.970855] refcount_t: addition on 0; use-after-free.
> [    3.976043] Modules linked in: autofs4
> [    3.979827] CPU: 0 PID: 1 Comm: systemd Not tainted 5.14.0-rc4-next-20=
210802-00002-g5003e4ac441d-dirty #5
> [    3.989440] Hardware name: Generic DRA72X (Flattened Device Tree)
> [    3.995574] [<c0111098>] (unwind_backtrace) from [<c010b834>] (show_st=
ack+0x10/0x14)
> [    4.003356] [<c010b834>] (show_stack) from [<c09da808>] (dump_stack_lv=
l+0x40/0x4c)
> [    4.010986] [<c09da808>] (dump_stack_lvl) from [<c0137b44>] (__warn+0x=
d8/0x100)
> [    4.018341] [<c0137b44>] (__warn) from [<c09d6368>] (warn_slowpath_fmt=
+0x94/0xbc)
> [    4.025848] [<c09d6368>] (warn_slowpath_fmt) from [<c08f68d4>] (fib_cr=
eate_info+0xae8/0xbd4)
> [    4.034332] [<c08f68d4>] (fib_create_info) from [<c08f99c4>] (fib_tabl=
e_insert+0x5c/0x604=A2=B7=86A=CB=D5=EC=CD_=A1
>=20
> 2) see warnings and "ip link add name br0 type bridge" just stuck
> [  158.032135] unregister_netdevice: waiting for lo to become free. Usage=
 count =3D 3
>=20
> It might not be related to this series.

100% not me.

See if you have David Ahern's bug fix, and if you do, try to see what
other refcount conversion patches Yajun Deng did, revert them one by one
and see if any one fixes the issue:
https://patchwork.kernel.org/project/netdevbpf/patch/20210802160221.27263-1=
-dsahern@kernel.org/=
