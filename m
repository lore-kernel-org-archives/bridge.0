Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glUNLV58+8I+VGyntUpvxg8EqGk4oNpIuhBgucx9tSc=;
 b=afsJ1YYd6wftxP03OKI2rfGKavXWuuCimBmIRXDykby6jW2Z/lJxdSpgB2XQD3MbLrTrFtC6Ap29FJFEysTdwYPppFhnaW7xoUqwESpF3tkDpns16OXxbFYXATNkPeyJyqeD8HaxeoK7QNeMFZ77k/oeqh/utWFFtSXzIVhqgRc=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun, 13 Dec 2020 15:08:42 +0000
Message-ID: <20201213150841.ctp2njznfqvikj7x@skbuf>
References: <20201213140710.1198050-1-vladimir.oltean@nxp.com>
 <20201213140710.1198050-2-vladimir.oltean@nxp.com>
 <20201213145543.GA2539586@shredder.lan>
In-Reply-To: <20201213145543.GA2539586@shredder.lan>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C8AF35377E370438D117AF298DF8512@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v3 net-next 1/7] net: bridge: notify switchdev
 of disappearance of old FDB entry upon migration
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Marek Behun <marek.behun@nic.cz>, Vivien Didelot <vivien.didelot@gmail.com>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Tobias Waldekranz <tobias@waldekranz.com>

Hi Ido,

On Sun, Dec 13, 2020 at 04:55:43PM +0200, Ido Schimmel wrote:
> > As far as the switchdev driver is concerned, all that it needs to ensur=
e
> > is that traffic between Station A and Station B is not forever broken.
> > If it does nothing, then the stale rule to send frames for Station B
> > towards the control interface remains in place. But Station B is no
> > longer reachable via the control interface, but via a port that can
> > offload the bridge port learning attribute. It's just that the port is
> > prevented from learning this address, since the rule overrides FDB
> > updates. So the rule needs to go. The question is via what mechanism.
>=20
> Can you please clarify why the FDB replacement notification is not
> enough?

I didn't say it is not enough. I said it is a whole lot harder to track
from the listener side.

> Is it because the hardware you are working with manages MACs to
> CPU in a separate table from its FDB table? I assume that's why you
> refer to it as a "rule" instead of FDB entry? How common is this with
> DSA switches?

With DSA switches it's just more generic to use a static FDB entry as
the address trapping rule. But since FDB entries are global across the
switch and not really per source port, understandably other mechanisms
such as an ACL entry could be used just as well. And an ACL is what
other drivers (like drivers/staging/fsl-dpaa2/ethsw/) would use for this
purpose (of course, the code is not there yet; it's still in staging,
there are other issues to resolve first).

The mechanism does really not matter though, as long as it's "strong"
and not "weak" (i.e. the entry cannot be overridden by hardware address
learning on the front panel ports). So when the bridge gets any clue
that the L2 routing information is no longer up to date, the very least
we must do is we must delete this trapping rule to give the hardware a
chance to learn again. Where the address is migrated to is really not as
important as the fact that it migrated in the first place. [ ok, then
there's the case where it migrates from a foreign interface to another
foreign interface. For that scenario, we would delete the trapping rule
and then reinstall it, which is not ideal but also not incorrect. ]

> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks.=
