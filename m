Message-ID: <478E102C.8050006@satca.net>
Date: Wed, 16 Jan 2008 15:09:48 +0100
From: Marian Jancar <m.jancar@satca.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Bridge] MAC addresses on ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I need some explanation/help with a probably bit uncommon bridge setup. I have
devices that come with their manufacturer MAC addresses, and I need to create
a bridge that uses my MAC address instead and has to look about like this:

br0:    unique MAC address from my range
wlan0:  same MAC as br0
        (madwifi supports 4 MAC frames in STA mode so the actual bridging works,
        just if you are curious :p)
eth0:   any MAC address higher than the br0 MAC,
        and as long as the assumptions below hold, unique in just this bridge,
eth1:   ditto
...
ethN:   ditto


Now, the only reason I can think about from my naive point of view, why the bridge
cares about port MAC address at all, is maintaining a reliable and persistent
connection between the logical port and the actual physical device for STP
purposes.

So if I'm right, I can assign any MAC addresses to the ethernet ports, as long
as they are higher than the wlan0 address, to ensure that the bridge selects
the wlan0 MAC as its own, and as long as they are locally unique.
The MAC addresses of the ethernet ports will not appear in any non-STP
packets and don't have to be globally unique, because they identify ports in
just this bridge and STP handles that, just a port has always to have the
same address and not a random one.

Is this correct? If not, is there any other way to create a bridge and
not to have to allocate a unique MAC to each port?

Any comments and/or pointers to relevant documentation are highly appreciated.


Best Regards
Marian

