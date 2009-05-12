In-Reply-To: <OFD8A6DCB5.C299BC0C-ONC12575B2.006169DD-C12575B2.0061B705@LocalDomain>
References: <OF6C9DD85E.5F51CD2D-ONC12575B0.002E85F9-C12575B0.002F0604@transmode.se>
	<20090508090226.70d23727@nehalam>
	<OFD8A6DCB5.C299BC0C-ONC12575B2.006169DD-C12575B2.0061B705@LocalDomain>
Message-ID: <OFE9F41029.741448FE-ONC12575B4.003524B7-C12575B4.0035670C@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 12 May 2009 11:43:17 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] brigde does not relay BPDU multicast pkgs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

Joakim Tjernlund/Transmode wrote on 10/05/2009 19:47:19:
>
> Stephen Hemminger <shemminger@vyatta.com> wrote on 08/05/2009 18:02:26:
>
> > On Fri, 8 May 2009 10:33:37 +0200
> > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> >
> > >
> > > Hi List
> > >
> > > We have noticed that when STP is off in the linux bridge, it won't
> > > relay STP pkts received from other bridges.
> > > This feels like a bug(a bad one too). I hope this isn't
> > > intentional behaviour?
> > >
> > >  Jocke
> > >
> > > _______________________________________________
> > > Bridge mailing list
> > > Bridge@lists.linux-foundation.org
> > > https://lists.linux-foundation.org/mailman/listinfo/bridge
> >
> > It is a debatable whether this is correct behaviour.
> > My current opinion is that it needs to forward STP packets if
> > STP is off. This would allow for loop detection by other bridges
> > doing STP.
>
> Exactly, I had a look at the bride code and it wasn't obvious
> too me where to add the code to make this happen. Any pointers?

Looking into this I got a question:
Should the bridge forward the whole bridge multicast group except PAUSE
or only the STP multicast address?

 Jocke

