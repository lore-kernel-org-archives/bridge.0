Subject: Re: [Bridge] Bridge and PACKET-socket
References: <lhznd2do0m.fsf@dodo.bluetail.com>
	<200401060013.38748.bdschuym@pandora.be>
From: Luke Gorrie <luke@member.fsf.org>
In-Reply-To: <200401060013.38748.bdschuym@pandora.be>
Message-ID: <lhr7yedkfn.fsf@dodo.bluetail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Luke Gorrie <lgorrie@nortelnetworks.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Mon, 05 Jan 2004 23:50:40 -0000
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: bridge@osdl.org

Bart De Schuymer <bdschuym@pandora.be> writes:

> Well, if you're sending all IP packets to userspace I doubt that's faster than 
> an ebtables kernel module...

Right, I forgot to mention that in this case it's only 802.3 frames
that I'm interested in. I expect to get very few packets, and don't
want to impact the performance of the other IP-based traffic.

Also, I've already implemented the protocol in userspace and don't
wanna move it into the kernel ;-)

> I don't know the details, but can't you hook some kernel function onto 
> ETH_P_ALL that only sends IP packets to userspace?

This still sounds like packet-socket territory to me. Wouldn't it be
better to clarify/extend the packet-socket interface to cover bridged
ports?

-Luke

