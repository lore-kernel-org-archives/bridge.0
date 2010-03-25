Message-ID: <OFB9EFBBE7.11608167-ONC12576F1.005B0C79-C12576F1.005BBE51@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 25 Mar 2010 17:42:04 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: [Bridge] IP address on physcial interface instead of bridge
	interface?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


Currently it isn't possible to to have an IP address on one of interfaces
attached to a bridge, one must always put the IP address on the bridge interface itself.

I wonder if there is a technical reason for that? I would love to be able
to be able to chose any ONE interface attached to the bridge.
Example:
Assume br0 bridge with two interfaces attached, eth0 and eth1.
Then I would like to assign the IP address to eth0 instead of
br0. Ideally one should be able to just attach eth0 with an existing IP address
to br0.

    Jocke

