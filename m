In-Reply-To: <m3eitpovnt.fsf@ursa.amorsen.dk>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>	<de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
	<m33aa5bykm.fsf@ursa.amorsen.dk>	<OFEA0D61B2.8B351FDC-ONC12575D3.0034AA26-C12575D3.00354697@transmode.se>
	<20090612125214.GA7461@kallisti.us>	<OF0314F87C.B7A0780D-ONC12575D3.00476B7B-C12575D3.00484E73@transmode.se>
	<2e59e6970906120619u589ed8dfy8bb327efa305b742@mail.gmail.com>	<OF32E45445.B5790A30-ONC12575D3.004B77E2-C12575D3.004BBABD@transmode.se>
	<2e59e6970906121231x7278360u19bcc58646116469@mail.gmail.com>	<OFB9321502.79301BE7-ONC12575D3.0075D3D1-C12575D3.00765847@transmode.se>
	<m3eitpovnt.fsf@ursa.amorsen.dk>
Message-ID: <OFB7E26281.4BA910B4-ONC12575D4.00514656-C12575D4.00524AF2@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 13 Jun 2009 16:58:52 +0200
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

Benny Amorsen <benny+usenet@amorsen.dk> wrote on 13/06/2009 01:54:30:
>
> Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:
>
> > But why should I not be able to add both 4043 and 4044 to the same bridge?
>
> Of course you should. And they should behave as a proper bridge, letting
> packets flow as they were meant to.

You have some other definition of a "proper bridge". A common bridge would not
care about the VLANs and never return a pkg on the same interface.

> Unless you decide that local policy
> does not permit packets to flow freely, and then you use ebtables to
> apply that local policy.
>
> > I just sent a patch to add split horizon support to the linux bridge. Have
> > a look. More power to the linux bridge that way.
>
> You have already been shown that you can achieve what you want with the
> existing kernel code, at the cost of a somewhat complicated rule setup.
> You have also been shown ways to simplify this rule setup.

Yes, I have already worked around this, but it doesn't make it right.
I just want the bridge to do the right thing and I think the current behavior
isn't it.

>
> I really hope that your patches are not accepted. Sorry if this is
> harsh, but the company I work for has in the past depended on the
> flexibility of the existing code. While that company is currently
> migrating to proprietary solutions because PC's don't get faster at the
> rate which traffic grows, it seems ridiculous that Linux should copy the
> limitations of less capable platforms.

You still have that flexibility. Turn it off and you are free to shoot yourself
in the foot.

