From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] Bridge and PACKET-socket
Date: Tue, 6 Jan 2004 00:13:38 +0100
References: <lhznd2do0m.fsf@dodo.bluetail.com>
In-Reply-To: <lhznd2do0m.fsf@dodo.bluetail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401060013.38748.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Luke Gorrie <luke@member.fsf.org>, bridge@osdl.org

On Monday 05 January 2004 23:33, Luke Gorrie wrote:
> My interpretation is that ETH_P_ALL handlers are expected to be
> programs like tcpdump which can safely be fed all packets, whereas
> more specific handlers are expected to be actual protocol
> implementations that shouldn't run directly on enslaved ports.
>
> Is that correct?

Well, with the ebtables BROUTING chain it is possible to have an enslaved port 
as input device for the protocol handlers. In the case of IP, to make any 
sense, this enslaved port should then have its own IP address.

> In my case I am implementing a specific protocol in userspace (via
> PACKET-socket) and this protocol must run directly on enslaved
> ports. It's an old layer-2 neighbour-discovery protocol that has to
> operate on physical ports, below other abstractions like
> bridges. ("don't ask.") It looks like I can't do this today, unless I
> use ETH_P_ALL, perhaps with a BPF filter -- but I'm fearful of
> introducing overhead on all packets.

Well, if you're sending all IP packets to userspace I doubt that's faster than 
an ebtables kernel module...

> I was thinking of adding an extra hashtable in dev.c, like ptype_base
> but processed before offering packets to the bridge. Then an ioctl to
> have a PACKET-socket moved into this table if it's supposed to receive
> packets on enslaved interfaces.
>
> Does that sound like a good solution?

I don't know the details, but can't you hook some kernel function onto 
ETH_P_ALL that only sends IP packets to userspace?

cheers,
Bart

