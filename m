Message-ID: <OFC22455CD.B877C9CD-ONC1257617.00347B02-C1257617.0037885E@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 19 Aug 2009 12:06:33 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: [Bridge] MAC learning and VLAN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


I got 2 VLANs:
 eth0.1, eth0.2
in a bridge br0

eth0.1 receives packages and learns the remote MAC addresses however
eth0.2 never receives any pkgs from the same hosts as eth0.1

Looking into the bride one can see that the bridge has not learned
any MAC addresses over eth0.2 so I cannot send any pkgs
back to the host over eth0.2(except broadcast).

Is this expected? I had hoped that the MAC learning in the bridge was global
so any MACs learned over eth0.1 could be used by eth0.2 too.

  Jocke

