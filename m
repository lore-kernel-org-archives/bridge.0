In-Reply-To: <m3vdn1aili.fsf@ursa.amorsen.dk>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>	<de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
	<m33aa5bykm.fsf@ursa.amorsen.dk>	<OFEA0D61B2.8B351FDC-ONC12575D3.0034AA26-C12575D3.00354697@transmode.se>
	<m3vdn1aili.fsf@ursa.amorsen.dk>
Message-ID: <OFF358E54A.548A3EE5-ONC12575D3.0040450B-C12575D3.00409F4C@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 12 Jun 2009 13:45:51 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] RFC: Simple Private VLAN impl.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benny Amorsen <benny+usenet@amorsen.dk>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

Benny Amorsen <benny+usenet@amorsen.dk> wrote on 12/06/2009 11:48:09:
>
> Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:
>
> > Add them to a bridge and the bridge will pass pkgs between them, right?
>
> Of course.
>
> > However no real switch I know would do that because they are on
> > the same physical interface.
>
> True, and this is very problematic.

why? I can't think of any usage pattern.

>
> > I think the bridge needs to check the physical interface too and don't
> > forward pkgs back on the same physical interface.
>
> Certainly not. Real-world configurations are made impossible by doing
> that.
>
> Linux doesn't need to limit itself to the myopic views of traditional
> switch designers. Their hardware is broken, ours isn't.

Broken? If only Linux does this, perhaps it is Linux that is broken.
New users could be very surprised by this so perhaps it could default to
off?

 Jocke

