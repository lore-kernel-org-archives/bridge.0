Return-Path: <davem@davemloft.net>
Date: Fri, 06 May 2016 12:56:42 -0400 (EDT)
Message-Id: <20160506.125642.581240999988344349.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1462375502-8381-1-git-send-email-linus.luessing@c0d3.blue>
References: <1462375502-8381-1-git-send-email-linus.luessing@c0d3.blue>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCHv2 net] bridge: fix igmp / mld query parsing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@c0d3.blue
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sw@simonwunderlich.de

From: Linus L=FCssing <linus.luessing@c0d3.blue>
Date: Wed,  4 May 2016 17:25:02 +0200

> With the newly introduced helper functions the skb pulling is hidden
> in the checksumming function - and undone before returning to the
> caller.
> =

> The IGMP and MLD query parsing functions in the bridge still
> assumed that the skb is pointing to the beginning of the IGMP/MLD
> message while it is now kept at the beginning of the IPv4/6 header.
> =

> If there is a querier somewhere else, then this either causes
> the multicast snooping to stay disabled even though it could be
> enabled. Or, if we have the querier enabled too, then this can
> create unnecessary IGMP / MLD query messages on the link.
> =

> Fixing this by taking the offset between IP and IGMP/MLD header into
> account, too.
> =

> Fixes: 9afd85c9e455 ("net: Export IGMP/MLD message validation code")
> Reported-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Applied and queued up for -stable, thanks.
