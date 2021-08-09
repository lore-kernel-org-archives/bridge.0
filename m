Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zGxz6hlDKFKLDM0lkTsn4+5vr2DoX6Vg4i1fG9WQHI=;
 b=GGjcID9zyVdnsQVzk/dx/ir/d8IQ2NWOxbuD7sBTvs/Eus4DGIwi8NDX+oBHW+mV0uwkfnddBKWb20AOvFyHI+SbsBSHxBoM8ZZQ120mIdP/WfVk2C+RPHCtmFQo5ogLv1jh0kTGmFmFG2KuGNnSmXj4ejyrzsW3QUTfBBgPoKQ=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 9 Aug 2021 16:05:22 +0000
Message-ID: <20210809160521.audhnv7o2tugwtmp@skbuf>
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
 <YREcqAdU+6IpT0+w@shredder>
In-Reply-To: <YREcqAdU+6IpT0+w@shredder>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <538578EEE12AF14992003D542A780495@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] net: bridge: validate the NUD_PERMANENT
 bit when adding an extern_learn FDB entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: "syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com" <syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com>, Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, "nikolay@nvidia.com" <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Aug 09, 2021 at 03:16:40PM +0300, Ido Schimmel wrote:
> I have at least once selftest where I forgot the 'static' keyword:
>
> bridge fdb add de:ad:be:ef:13:37 dev $swp1 master extern_learn vlan 1
>
> This patch breaks the test when run against both the kernel and hardware
> data paths. I don't mind patching these tests, but we might get more
> reports in the future.

Is it the 'static' keyword that you forgot, or 'dynamic'? The
tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh selftest
looks to me like it's testing the behavior of an FDB entry which should
roam, and which without the extern_learn flag would be ageable.=
