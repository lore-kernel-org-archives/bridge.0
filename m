Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnpcQ1pvINaBye+rVVK//nhqwlrHhjEmEDNVc2g0n9g=;
 b=HpVgc3zhfvWQHMh2+NzBKJlxOpge2j6lF9MjL4bKUt89hq1nAWZkoxgmyNA8eQsHvLEH517EnmxmDyhNSgz7FDhwttLl1lNUwUO9paqLx4QEV/eErSWABez1pV3j78mc+JqvBSNvt7aZuq5gpTxaumesQCQQvtkSscFB8GPL1vY=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 20 Jul 2021 14:46:18 +0000
Message-ID: <20210720144617.ptqt5mqlw5stidep@skbuf>
References: <20210720134655.892334-1-vladimir.oltean@nxp.com>
 <YPbXTKj4teQZ1QRi@shredder> <20210720141200.xgk3mlipp2mzerjl@skbuf>
 <YPbcxPKjbDxChnlK@shredder>
In-Reply-To: <YPbcxPKjbDxChnlK@shredder>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1FF4337113BC444A8384B060DAC2F3B@eurprd04.prod.outlook.com>
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

I mean, I could guard br_{vlan,mdb,fdb}_replay() against NULL notifier
block pointers, and then make mlxsw pass NULL for both the atomic_nb and
blocking_nb.

But why? How do you deal with a host-joined mdb that was auto-installed
while there was no port under the bridge? How does anyone deal with
that? What's optional about it? Why would driver X opt out of it but Y
not (apart for the case where driver X does not offload MDBs at all,
that I can understand).=
