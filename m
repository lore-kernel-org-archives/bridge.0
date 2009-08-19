From: Benny Amorsen <benny+usenet@amorsen.dk>
References: <OFC22455CD.B877C9CD-ONC1257617.00347B02-C1257617.0037885E@transmode.se>
	<m3prasm0uy.fsf@ursa.amorsen.dk>
	<OF1FFD7F2D.3373FC10-ONC1257617.0048E18B-C1257617.004AB048@transmode.se>
	<m3hbw3nb11.fsf@ursa.amorsen.dk>
	<OF411B404D.656FBE43-ONC1257617.004F6098-C1257617.004FD6C4@transmode.se>
Date: Wed, 19 Aug 2009 18:40:10 +0200
In-Reply-To: <OF411B404D.656FBE43-ONC1257617.004F6098-C1257617.004FD6C4@transmode.se>
	(Joakim Tjernlund's message of "Wed, 19 Aug 2009 16:32:03 +0200")
Message-ID: <m3ab1v92qd.fsf@ursa.amorsen.dk>
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

> trying to do private VLAN, http://tools.ietf.org/html/draft-sanjib-private-vlan-10,
> using ebtables. It does not seem to be enough to only filter
> pkgs. Isolated port are special and, as I understand it, they only
> receive pkgs from the uplink via the primary VLAN and only
> TX onto the isolated VLAN on the uplink(forget about other ports, it is
> the uplink that is the problem)

You are trying to make private VLAN's, and at the same time you're
mixing in 802.1q tagging... I think you should start with making
everything work using physical interfaces only.


/Benny

