Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amM3FE/4ZsPyf1At5EyS/WADEq3F0q294fG/XxbsPgc=;
 b=kmkEGD7JDqjSRpOarCHkrb8LIW2KH8zvBxN7caexAqVlGSdOenv60MRSZDW8Zk9bmbUA6/66VmX3buJuFyZ5oZTRfEfUs0UrMqid8O2C4+GA4/t7a3zS5db3+oV9pj6lDuWZ1uP7XIlr7sbc1kqxA7S8bL4sN6SK5D3nsg3SkrY=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 20 Jul 2021 15:36:37 +0000
Message-ID: <20210720153636.pabfdzznzfuiinfs@skbuf>
References: <20210720134655.892334-1-vladimir.oltean@nxp.com>
 <YPbXTKj4teQZ1QRi@shredder> <20210720141200.xgk3mlipp2mzerjl@skbuf>
 <YPbcxPKjbDxChnlK@shredder> <20210720144617.ptqt5mqlw5stidep@skbuf>
 <YPbi7NSsdDEdvmcA@shredder>
In-Reply-To: <YPbi7NSsdDEdvmcA@shredder>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17DEA3A2C6DEE74BB8461C5E632D3F6D@eurprd04.prod.outlook.com>
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

On Tue, Jul 20, 2021 at 05:51:24PM +0300, Ido Schimmel wrote:
> On Tue, Jul 20, 2021 at 02:46:18PM +0000, Vladimir Oltean wrote:
> > On Tue, Jul 20, 2021 at 05:25:08PM +0300, Ido Schimmel wrote:
> > > If you don't want to change the order, then at least make the
> > > replay/cleanup optional and set it to 'false' for mlxsw. This should
> > > mean that the only change in mlxsw should be adding calls to
> > > switchdev_bridge_port_offload() / switchdev_bridge_port_unoffload() i=
n
> > > mlxsw_sp_bridge_port_create() / mlxsw_sp_bridge_port_destroy(),
> > > respectively.
> >=20
> > I mean, I could guard br_{vlan,mdb,fdb}_replay() against NULL notifier
> > block pointers, and then make mlxsw pass NULL for both the atomic_nb an=
d
> > blocking_nb.
> >=20
> > But why? How do you deal with a host-joined mdb that was auto-installed
> > while there was no port under the bridge?
>=20
> mlxsw does not currently support such entries. It's on my TODO list.
> When we add support for that, we will also take care of the replay.

Okay, that I can do. I had the impression that mlxsw does - I knew for
certain that DSA isn't the only driver offloading SWITCHDEV_OBJ_ID_HOST_MDB
so I looked it up right now, and I remembered. cpsw was the other driver,
and it does a pretty funny thing: the same thing as for
SWITCHDEV_OBJ_ID_PORT_MDB.

I guess I'll just provide NULL pointers for every driver except those I
already received acks for (dpaa2-switch, ocelot) and DSA. Then driver
maintainers can take it from there as they wish. Hopefully this should
also make the patches slide in easier.=
