Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1ouXLdGHZwaizv4bOA7F+GT7eaUR3+joA04k/M4mmk=;
 b=SaEHQwnZF58NHirdywzgR11iKZ2G68seDn4u5eXl+GbSYIV9uTCMim8N/vRyLIuZnv9/dWLlOevcXNlb+8QaetXMiwt4rovO4VPIvjGq4dWzgQRPySYFxGWKin1RwWoFtgruFolz7e/BFY4FGIxyGpunLyO2g72ImAnaYUSaSrg=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 20 Jul 2021 19:47:18 +0000
Message-ID: <20210720194717.qbdz5mmmxqbn3y3z@skbuf>
References: <20210720134655.892334-1-vladimir.oltean@nxp.com>
 <YPbXTKj4teQZ1QRi@shredder> <20210720141200.xgk3mlipp2mzerjl@skbuf>
 <YPbcxPKjbDxChnlK@shredder>
In-Reply-To: <YPbcxPKjbDxChnlK@shredder>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC03F5D2718ECA408BDB5BCBDFA065AD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v5 net-next 00/10] Let switchdev drivers
 offload and unoffload bridge ports at their own convenience
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Vivien Didelot <vivien.didelot@gmail.com>, DENG Qingfang <dqfext@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Marek Behun <kabel@blackhole.sk>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Tue, Jul 20, 2021 at 05:25:08PM +0300, Ido Schimmel wrote:
> If you don't want to change the order, then at least make the
> replay/cleanup optional and set it to 'false' for mlxsw. This should
> mean that the only change in mlxsw should be adding calls to
> switchdev_bridge_port_offload() / switchdev_bridge_port_unoffload() in
> mlxsw_sp_bridge_port_create() / mlxsw_sp_bridge_port_destroy(),
> respectively.

Is there any specific reason why you suggested me to move the
switchdev_bridge_port_offload() call from the top-level
mlxsw_sp_port_bridge_join() into mlxsw_sp_bridge_port_create()
(and similarly, from _pre_bridge_leave to _destroy)?

Even if you don't support replays right now, you'd need to move a bunch
of code around before you would get them to work. As far as I can see,
mlxsw_sp_bridge_port_create() is a bit too early and
mlxsw_sp_bridge_port_destroy() is a bit too late. The port needs to be
fairly up and running to be able to process the switchdev notifiers at
that stage.

Do you mind if I keep the hooks where they are, which is what I do for
all drivers? I don't think I am missing to handle any case.=
