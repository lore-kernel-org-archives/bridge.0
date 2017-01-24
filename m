Return-Path: <davem@davemloft.net>
Date: Tue, 24 Jan 2017 12:41:19 -0500 (EST)
Message-Id: <20170124.124119.2246238373876916746.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170121200133.1864-1-linus.luessing@c0d3.blue>
References: <20170121200133.1864-1-linus.luessing@c0d3.blue>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next v5] bridge: multicast to unicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@c0d3.blue
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, nbd@nbd.name

From: Linus L=FCssing <linus.luessing@c0d3.blue>
Date: Sat, 21 Jan 2017 21:01:32 +0100

> From: Felix Fietkau <nbd@nbd.name>
> =

> Implements an optional, per bridge port flag and feature to deliver
> multicast packets to any host on the according port via unicast
> individually. This is done by copying the packet per host and
> changing the multicast destination MAC to a unicast one accordingly.
> =

> multicast-to-unicast works on top of the multicast snooping feature o=
f
> the bridge. Which means unicast copies are only delivered to hosts wh=
ich
> are interested in it and signalized this via IGMP/MLD reports
> previously.
> =

> This feature is intended for interface types which have a more reliab=
le
> and/or efficient way to deliver unicast packets than broadcast ones
> (e.g. wifi).
> =

> However, it should only be enabled on interfaces where no IGMPv2/MLDv=
1
> report suppression takes place. This feature is disabled by default.
> =

> The initial patch and idea is from Felix Fietkau.
> =

> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> [linus.luessing@c0d3.blue: various bug + style fixes, commit message]=

> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

I'm not completely happy that things have progressed this way, however
I don't have a better solution to suggest.
