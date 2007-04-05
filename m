Message-ID: <4614ED97.8090002@endian.it>
Date: Thu, 05 Apr 2007 14:37:43 +0200
From: Peter Warasin <peter@endian.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] strange networking behaviour with a bridge in game
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

hi list

I have a strange problem here. Maybe it is normal behavior and i search
within the wrong direction. Probably someone here can give me a hint.

I have a device (rhel4 kernel 2.6.9) with 3 interfaces. 2 interfaces
(eth0, eth2) are bridged together (br0) and the bridge device has an ip
address assigned (192.168.11.15).
Another interface (eth1) has assigned 10.7.0.10.


So far so good. Everything is working well if traffic passes from
192.168.11.0/24 out to 10.7.0.0/24 if both networks are on different
switches.

The thing begins to become strange if both eth0 and eth1 are connected
on the same switch (eth2 is not connected). So i have both subnets on
the same switch (for testing purposes).
If i then would like to access 192.168.11.15, packets reach the device
through the interface eth1 instead of eth0/br0, which in fact is wrong.
The arp table on the client shows this also. 192.168.11.15 is assigned
to the mac adress of the interface eth1.

Needless to say that this happens only from time to time. If i cleanup
the arp table sometimes it went alright.

What's wrong with my installation?

Thank you in advance!

peter


-- 
:: e n d i a n
:: open source - open minds

:: peter warasin
:: http://www.endian.com   :: peter@endian.com
