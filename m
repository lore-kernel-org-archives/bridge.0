Message-Id: <200501180547.j0I5lZ7r032126@fire-1.osdl.org>
From: "Dan Grigsby" <dan@unpossible.com>
Subject: RE: [Bridge] Packet loss / performance
Date: Mon, 17 Jan 2005 23:47:37 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050114101957.2404d01c@dxpl.pdx.osdl.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Stephen Hemminger' <shemminger@osdl.org>, dan-linuxbridge@unpossible.com
Cc: bridge@lists.osdl.org

Stephen,

Thanks for the response.  My reply follows:

> I assume this is 64-bit/66Mhz PCI.

Actually, it's a PCI-X @ 133Mhz.  

> Did you try affiniting both eth's to same CPU.

Yep, I tried with both on a single CPU, but the problem is that the eth
interfaces generate interrupts, so you need to spread the load between the
two.  Of course, NAPI helps.

> Are you always forwarding from/to same MAC address.

Yes, same MAC.

> Then figure out where they are being dropped 
> (in board, e1000 driver ring, or bridge).

I would love to know how to better determine this.  It's a little opaque to
me at the moment.  Where can I determine this?  I've been using
/proc/net/dev to see the packet numbers, but don't know how to determine
where the packets are dropped.  If you could shed light here that would be
great!

> oprofile output might help to identify CPU hot spots.

I'll check it out.  Never used oprofile before.

-- 
Stephen Hemminger	<shemminger@osdl.org>


