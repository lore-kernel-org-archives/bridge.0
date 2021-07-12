Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLY1ujMdI/kkthaVeuepns6SGIIxkE1PEYyt7hAFFBU=;
 b=CAo1d4StJSoY7yos3IzXJd3w3JrMKviA29XGd8qkIGrwRwfOheXXc5cbxPpBdAQbCk5vveLUI8dbZgY3k7h9OSo/w4F9E1BPf7GGjjri8gMcExDa5/Kmchpta4gXMKfgf0HoySYnHjbsrbixIXViIBjTsclGgHsuhZ2/YjN2/+4=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 13:03:23 +0000
Message-ID: <20210712130321.ovf2xnvmpgyfs4im@skbuf>
References: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
 <20210703115705.1034112-5-vladimir.oltean@nxp.com>
 <3686cff1-2a80-687e-7c64-cf070a0f5324@ti.com>
 <20210709140940.4ak5vvt5hxay3wus@skbuf> <87r1g37m2t.fsf@waldekranz.com>
In-Reply-To: <87r1g37m2t.fsf@waldekranz.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <106A336E09E7384599E455D27E3AEE7F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH v2 net-next 04/10] net: bridge: switchdev:
 allow the data plane forwarding to be offloaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Alexander Duyck <alexander.duyck@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Jul 12, 2021 at 02:28:42PM +0200, Tobias Waldekranz wrote:
> > After cutting my teeth myself with Tobias' patches, I tend to agree wit=
h
> > the idea that the macvlan offload framework is not a great fit for the
> > software bridge data plane TX offloading. Some reasons:
>
> I agree. I was trying to find an API that would not require adding new
> .ndos or other infrastructure. You can see in my original RFC cover that
> this was something I wrestled with.
>
> > - the sb_dev pointer is necessary for macvlan because you can have
> >   multiple macvlan uppers and you need to know which one this packet
> >   came from. Whereas in the case of a bridge, any given switchdev net
> >   device can have a single bridge upper. So a single bit per skb,
> >   possibly even skb->offload_fwd_mark, could be used to encode this bit
> >   of information: please look up your FDB for this packet and
> >   forward/replicate it accordingly.
>
> In fact, in the version I was about to publish, I reused
> skb->offload_fwd_mark to encode precisely this property. It works really
> well. Maybe I should just publish it, even with the issues regarding
> mv88e6xxx. Let me know if you want to take a look at it.

I am on it already, I have a 25-patch series that is currently
undergoing testing (yes, it changes all switchdev drivers to call
switchdev_bridge_port_offload() and switchdev_bridge_port_unoffload(),
and it also moves the switchdev object replay helpers to push mode, and
only then it hooks a "bool tx_fwd_offload" argument to the
switchdev_bridge_port_offload() call).
If all goes well and I still have some time today I will publish it for
review. Naturally the final submissions, when net-next reopens, will be
in much smaller chunks.=
