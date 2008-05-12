From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>	<2e59e6970805071916r701987fdx49bab341420ba2d@mail.gmail.com>	<1210233718.32216.121.camel@gentoo-jocke.transmode.se>	<4822C20B.3050303@sysnetsistemi.it>	<1210240896.32216.146.camel@gentoo-jocke.transmode.se>	<4822EE5C.8030404@sysnetsistemi.it>	<1210251508.32216.160.camel@gentoo-jocke.transmode.se>	<1210585065.32216.218.camel@gentoo-jocke.transmode.se>
	<20080512105011.7070c249@extreme>
In-Reply-To: <20080512105011.7070c249@extreme>
Date: Mon, 12 May 2008 19:54:12 +0200
Message-ID: <02b301c8b459$2fe4c530$8fae4f90$@Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: sv
Subject: Re: [Bridge] STP bug, loop not detetcted
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'Stephen Hemminger' <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org

> -----Original Message-----
> From: Stephen Hemminger [mailto:shemminger@vyatta.com]
> Sent: den 12 maj 2008 19:50
> To: joakim.tjernlund@transmode.se
> Cc: bridge@lists.linux-foundation.org; Francesco Dolcini
> Subject: Re: [Bridge] STP bug, loop not detetcted
> 
> On Mon, 12 May 2008 11:37:45 +0200
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> 
> >
> > On Thu, 2008-05-08 at 14:58 +0200, Joakim Tjernlund wrote:
> > > On Thu, 2008-05-08 at 14:13 +0200, Francesco Dolcini wrote:
> > > > Joakim Tjernlund wrote:
> > > > > On Thu, 2008-05-08 at 11:04 +0200, Francesco Dolcini wrote:
> > > > >> cisco and others solved this kind of problem using proprietary
> > > > >> unidirectional link detection protocols (see cisco informational rfc
> > > > >> 5171 for example). No standard exists as far as I know (BFD rfc does not
> > > > >> consider the layer 2 case).
> > > > >
> > > > > Are these proprietary unidirectional link detection protocols the only
> > > > > way to solve the problem?
> > > > spanning tree protocol, in the various IEEE incarnation (802.1D, 802.1Q)
> > > > and cisco (PVSTP) does not handle this problem, so an external mechanism
> > > > is needed.
> > >
> > > Do they explicitly ban it? Otherwise I don't see why not the kernel STP
> > > can be enchanted. You could even view it as an external mechanism.
> > >
> > > >
> > > > > Would STP break if the interface was set to "non forwarding" in this
> > > > > case until the bridge stops seeing its own STP messages?
> > > > At least this will not solve the more general problem of a
> > > > unidirectional link (rx working and tx broken).
> > >
> > > hmm, if TX is broken there won't be a loop anyway?
> > >
> > > Anyhow, even if my proposed change doesn't solve all cases it seems like
> > > a useful, very simple, ad don to STP. I am just concerned that it can
> > > break some other aspect of STP. So far it seems OK.
> > >
> > > What is the bridge maintainers view on this?
> >
> > Stephen, whats is your view about extending the bridge code according to
> > above? Also, after looking at the bride code I don't see where this
> > should be added, I must be getting old :(
> >
> >         Jocke
> 
> If you want to make STP vlan aware, then fine, a good place to start
> is getting a version of new RSTP and making it vlan aware.

No, that is not what I meant, forget about VLAN just consider what
happens if you loop 2 or more interfaces which is connected to the
same bridge. The loop is such that each TX is connected to its own
RX.

      Jocke


