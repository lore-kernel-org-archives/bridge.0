From: Benny Amorsen <benny+usenet@amorsen.dk>
References: <OFC22455CD.B877C9CD-ONC1257617.00347B02-C1257617.0037885E@transmode.se>
Date: Wed, 19 Aug 2009 14:42:13 +0200
In-Reply-To: <OFC22455CD.B877C9CD-ONC1257617.00347B02-C1257617.0037885E@transmode.se>
	(Joakim Tjernlund's message of "Wed, 19 Aug 2009 12:06:33 +0200")
Message-ID: <m3prasm0uy.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] MAC learning and VLAN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org

Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:

> Is this expected? I had hoped that the MAC learning in the bridge was global
> so any MACs learned over eth0.1 could be used by eth0.2 too.

eth0.1 and eth0.2 are entirely separate interfaces. The behaviour is
exactly the same whether you use two VLAN's or two physical interfaces.

Imagine replacing eth0.1 with eth1 and eth0.2 with eth2. If a certain
MAC address is learned on eth1, it would be wrong to send packets
destined for that MAC address through eth2. That's pretty much the point
of bridging.


/Benny

