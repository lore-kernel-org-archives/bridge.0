Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 01 Oct 2018 20:54:08 +0200
Message-ID: <2473404.DTJdS9eVm5@blindfold>
In-Reply-To: <20181001184821.GA29148@splinter>
References: <1420505776-26827-1-git-send-email-bernhard.thaler@wvnet.at>
	<2327925.x0GQ7AZp12@blindfold> <20181001184821.GA29148@splinter>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Bridge] [PATCH 1/1] bridge: remove BR_GROUPFWD_RESTRICTED for
	arbitrary forwarding of reserved addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: David Gstir <david@sigma-star.at>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, bernhard.thaler@wvnet.at, "David S. Miller" <davem@davemloft.net>

Am Montag, 1. Oktober 2018, 20:48:21 CEST schrieb Ido Schimmel:
> > This is my plan b, having a u32 classifier that transports STP directly
> > to the other interface.
> > But IMHO this all is a bit hacky and a "forward anything" bridge mode
> > sounds more natural to me.
> 
> But "forwarding STP and PAUSE if the number of slaves is restricted to
> 2" is a hack. The Linux bridge (like other networking equipment) needs
> to conform to standards and to the best of my knowledge what you're
> requesting is explicitly forbidden by IEEE standards.
> 
> Also, if what you need is "forward anything", then Florian's suggestion
> should work for you.

Agreed, both variants are hacks. Depending on the point of view one might seem
less hacky than the other. :-)

As I said, netfilter is also part of the game. Unless I miss something, netfilter
won't see any packets if tc-mirred is used.
So the only option is having a bridge and transport STP via tc-mirred
or patching the bridge code (what we do right now).
 
Thanks,
//richard



