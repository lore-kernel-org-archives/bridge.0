Date: Wed, 4 Aug 2004 23:04:47 +0200 (CEST)
From: Henrik Nordstrom <hno@marasystems.com>
In-Reply-To: <200408042254.41978.bdschuym@pandora.be>
Message-ID: <Pine.LNX.4.44.0408042300540.18907-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bridge] Re: Any way of knowing a packet's been defragmented
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: netfilter-devel <netfilter-devel@lists.netfilter.org>, bridge <bridge@osdl.org>

On Wed, 4 Aug 2004, Bart De Schuymer wrote:

> Due to a recent change in the bridge code, we now need a way of knowing if
> a packet has been defragmented. The bridge code now checks on the packet
> size and drops packets that are too big for the output port. Defragmented
> packets will get refragmented later, so they shouldn't be dropped.

Well.. iptables does not really care why the packet is oversized. It
fragments any oversized packets.

Why does the bridge need to?

Regards
Henrik

