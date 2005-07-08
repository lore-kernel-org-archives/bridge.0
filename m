Message-ID: <42CEE78D.2080704@endian.it>
Date: Fri, 08 Jul 2005 22:52:29 +0200
From: Peter Warasin <peter@endian.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] tcp connection freezes when i dont ping the device first
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

hi

have a strange problem:
on a system with kernel 2.6.11.12 with some additional patches (fc-3 
patches and the actual netfilter patch-o-matic) i created a bridge 
containing 1 interface (eth0). (with stp enabled)
(i need this configuration with 1 inserted interface because i bridge 
together on demand the eth0 with a tap-device created by openvpn).

so far so good.. the setup does work as expected, but i always have to 
ping the device first before i can open some tcp connections to it.
without pinging the tcp connection freezes until timeout.

in a vmware-environment it's more strange. there i can't open tcp 
connections at all if i do not ping the device before.

is this normal behaviour because the bridge first has to learn the 
mac-address? i thought before tcp connections arp requests will be sent, 
too :)

ah.. the same behaviour on a system with kernel 2.4.29.

bye
peter

-- 
:: e n d i a n
:: open source - open minds

:: peter warasin
:: http://www.endian.it   :: peter@endian.it
