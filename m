From: Luke Gorrie <luke@member.fsf.org>
Message-ID: <lhznd2do0m.fsf@dodo.bluetail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Luke Gorrie <lgorrie@nortelnetworks.com>
Subject: [Bridge] Bridge and PACKET-socket
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Mon, 05 Jan 2004 22:33:20 -0000
To: bridge@osdl.org

Ahoy,

I've encountered some confusing semantics with using PACKET(7) sockets
on bridge-enslaved interfaces. Specifically, if my socket accepts all
types of frame (bind() to ETH_P_ALL) then it gets all packets; but if
it accepts any specific type (e.g. ETH_P_IP), then it receives no
packets at all.

That is how it's coded in net/core/dev.c's netif_receive_skb(). First
ETH_P_ALL handlers are called, then the bridge, and then -- only if
the bridge declines the packet -- the protocol-specific handlers are
called.

My interpretation is that ETH_P_ALL handlers are expected to be
programs like tcpdump which can safely be fed all packets, whereas
more specific handlers are expected to be actual protocol
implementations that shouldn't run directly on enslaved ports.

Is that correct?

In my case I am implementing a specific protocol in userspace (via
PACKET-socket) and this protocol must run directly on enslaved
ports. It's an old layer-2 neighbour-discovery protocol that has to
operate on physical ports, below other abstractions like
bridges. ("don't ask.") It looks like I can't do this today, unless I
use ETH_P_ALL, perhaps with a BPF filter -- but I'm fearful of
introducing overhead on all packets.

I was thinking of adding an extra hashtable in dev.c, like ptype_base
but processed before offering packets to the bridge. Then an ioctl to
have a PACKET-socket moved into this table if it's supposed to receive
packets on enslaved interfaces.

Does that sound like a good solution?

Cheers,
Luke

