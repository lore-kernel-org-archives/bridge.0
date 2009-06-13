In-Reply-To: <m3tz2koyvq.fsf@ursa.amorsen.dk>
References: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>	<m3ab4dovgi.fsf@ursa.amorsen.dk>
	<OFCE5E72FE.D082AB78-ONC12575D4.005256D7-C12575D4.0052B193@transmode.se>	<1244905945.3175.25.camel@ursa.amorsen.dk>
	<OF6DCC73C6.20F5C539-ONC12575D4.00562ACB-C12575D4.00569683@transmode.se>
	<m3tz2koyvq.fsf@ursa.amorsen.dk>
Message-ID: <OF0FD1F433.2EE7F805-ONC12575D4.0065DF68-C12575D4.006653AD@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 13 Jun 2009 20:37:41 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] [PATCH] [bridge] Add split horizon
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

Benny Amorsen <benny+usenet@amorsen.dk> wrote on 13/06/2009 18:57:13:
>
> Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:
>
> > Benny Amorsen <benny+usenet@amorsen.dk> wrote on 13/06/2009 17:12:25:
>
> >> "If your topology isn't loop free, run spanning tree in the VLAN's."
> >
> > That would just disable one of the VLANs so the bride won't receive
> > any more pkgs over that VLAN.
>
> Why don't you try it and find out?
>
> Make eth0.100 and eth0.101 on one machine, bridge them as br0, turn
> spanning tree on. Do the same thing on the second machine. Connect the
> two machines. Be enlightened.

I am not at work now so you will have to enlighten me.

>
> > I would really like to read up on the claim that each VLAN is also a physical port.
> > Any pointers?
>
> What claim?

Oh, I see that it was Ross who made that claim. You don't agree? If so how
do you explain that is OK to broadcast the same pkg back on that same physical interface?

 Jocke

