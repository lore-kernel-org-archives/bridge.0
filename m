In-Reply-To: <1244905945.3175.25.camel@ursa.amorsen.dk>
References: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<m3ab4dovgi.fsf@ursa.amorsen.dk>
	<OFCE5E72FE.D082AB78-ONC12575D4.005256D7-C12575D4.0052B193@transmode.se>
	<1244905945.3175.25.camel@ursa.amorsen.dk>
Message-ID: <OF6DCC73C6.20F5C539-ONC12575D4.00562ACB-C12575D4.00569683@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 13 Jun 2009 17:45:47 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Content-transfer-encoding: quoted-printable
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

Benny Amorsen <benny+usenet@amorsen.dk> wrote on 13/06/2009 17:12:25:
>
> l=F8r, 13 06 2009 kl. 17:03 +0200, skrev Joakim Tjernlund:
> > Benny Amorsen <benny+usenet@amorsen.dk> wrote on 13/06/2009 01:58:5=
3:
> > >
> > > Joakim Tjernlund <Joakim.Tjernlund@transmode.se> writes:
> > >
> > > > Currently the bridge does not impl. split horizon which will ea=
sily
> > > > cause loops when 2 or more VLANs are added from the same physic=
al interface.
> > >
> > > Why would they cause loops? If your topology isn't loop free, run=

> > > spanning tree in the VLAN's. Yet another thing most hardware swit=
ches
> > > can't do, incidentally.
> >
> > ehh, connect two Linux bridges that have 2 VLANs in common on the i=
nterswitch connection.
> > What happens?
>
> "If your topology isn't loop free, run spanning tree in the VLAN's."

That would just disable one of the VLANs so the bride won't receive
any more pkgs over that VLAN.

I would really like to read up on the claim that each VLAN is also a ph=
ysical port.
Any pointers?

 Jocke=


