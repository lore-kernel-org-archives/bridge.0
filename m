In-Reply-To: <m3prasm0uy.fsf@ursa.amorsen.dk>
References: <OFC22455CD.B877C9CD-ONC1257617.00347B02-C1257617.0037885E@transmode.se>
	<m3prasm0uy.fsf@ursa.amorsen.dk>
Message-ID: <OF1FFD7F2D.3373FC10-ONC1257617.0048E18B-C1257617.004AB048@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 19 Aug 2009 15:35:47 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] MAC learning and VLAN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benny Amorsen <benny+usenet@amorsen.dk>
Cc: bridge@lists.linux-foundation.org

Benny Amorsen <benny+usenet@amorsen.dk> wrote on 19/08/2009 14:42:13:
>
> Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:
>
> > Is this expected? I had hoped that the MAC learning in the bridge was global
> > so any MACs learned over eth0.1 could be used by eth0.2 too.
>
> eth0.1 and eth0.2 are entirely separate interfaces. The behaviour is
> exactly the same whether you use two VLAN's or two physical interfaces.

Yes, this appears how linux impl. VLANs but I wonder if this
is how VLAN aware switch would impl. it? Looing into 802.1Q it
sees this is referred to as SVL resp. IVL? I guess linux only
supports IVL?

>
> Imagine replacing eth0.1 with eth1 and eth0.2 with eth2. If a certain
> MAC address is learned on eth1, it would be wrong to send packets
> destined for that MAC address through eth2. That's pretty much the point
> of bridging.

Yes it would be wrong, but eth0.1 and eth0.2 are on the same physical LAN
and could share learned MAC addresses but as it is impl. in linux
it does not seem possible.

