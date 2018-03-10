Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=WOYxNfCvqJbGxkDz7+4S6+Puyrj9u/UhPD++MyD4JRk=; 
	b=PX2VvR3b4wvVeFq4yAlId72dJIwT/O9zZfa+WyqM/5njSoDt7sa4dT25NMpPgpcYXv60i4/a0Shby8JDnHMIWMAXcjo90Vw5+esq+8FMbt9ApGdXU0CZkjuelsC+mjGwWitmzeXbwWEecNg3BZwd9jIeFGrCs2J23+8YVoVeUSw=;
Date: Sat, 10 Mar 2018 17:55:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20180310165540.GH29174@lunn.ch>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
	<20180310030308.12947-4-igor.mitsyanko.os@quantenna.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310030308.12947-4-igor.mitsyanko.os@quantenna.com>
Subject: Re: [Bridge] [RFC PATCH net-next 3/5] bridge: allow switchdev port
 to handle flooding by itself
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

On Fri, Mar 09, 2018 at 07:03:06PM -0800, Igor Mitsyanko wrote:
> Introduce BR_FLOOD_OFFLOAD bridge port flag that can be used by
> switchdev-capable hardware to advertize that it wants to handle all
> flooding by itself.
> In that case there is no need for a driver to set skb::offload_fwd_mark
> on each offloaded packet as it is implied by BR_FLOOD_OFFLOAD bridge
> port flag.

Is this sufficiently granular? There are a few different use cases for
flooding:

There is no fdb entry in the software switch for the destination MAC
address, so flood the packet out all ports of the bridge. The hardware
switch might have an entry in its fdb to the destination switch, so it
could unicast out the correct hardware port. If not, it should flood
the packet.

A point to remember here, the software switch and the hardware switch
can have different forwarding data bases.

A broadcast packet. Send it out all ports.

A multicast packet. If the hardware switch is capable of IGMP
snooping, it could have FDB entries indicating which ports it should
send the frame out of, and which is should not. Otherwise it needs to
flood.

Is one flag sufficient for all of these, and any other use cases i
might of missed?

As far as DSA switches go, i don't know of any of them which could
implement anything like this, so BR_FLOOD_OFFLOAD will never be
set. But maybe some of the TOR switches supported by switchdev can do
some of these, and not others....

     Andrew
