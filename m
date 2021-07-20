Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FtfHsUJ0xVo6mBSS0eqRxwObXBZjq/upNin70ySGYI=;
 b=qFT8r5qs5R5dn1xb2pdtgllPZ7I3v5jBph5SVBcRVegWI4PEiWiWhSBU2p9RJJLbXmeslCxmH+v4sfKgcSaktLzuOXpSwGtZZm0eJwv8Kax/l6b9bQ8+zcEDhEFZXVuOoosL7IIdHzrFeRwryTLadA8rRFHTseRC5Fz7RA1kGmU=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 20 Jul 2021 14:12:01 +0000
Message-ID: <20210720141200.xgk3mlipp2mzerjl@skbuf>
References: <20210720134655.892334-1-vladimir.oltean@nxp.com>
 <YPbXTKj4teQZ1QRi@shredder>
In-Reply-To: <YPbXTKj4teQZ1QRi@shredder>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DD482720318ED4397DBBD6260B0C006@eurprd04.prod.outlook.com>
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

On Tue, Jul 20, 2021 at 05:01:48PM +0300, Ido Schimmel wrote:
> > The patches were split from a larger series for easier review:
>=20
> This is not what I meant. I specifically suggested to get the TX
> forwarding offload first and then extending the API with an argument to
> opt-in for the replay / cleanup:

Yeah, ok, I did not get that and I had already reposted by the time you
clarified, sorry.

Anyway, is it so bad that we cannot look at the patches in the order
that they are in right now (even if this means that maybe a few more
days would pass)? To me it makes a bit more sense anyway to first
consolidate the code that is already in the tree right now, before
adding new logic. And I don't really want to rebase the patches again to
change the ordering and risk a build breakage without a good reason.=
