References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
	<de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
	<m33aa5bykm.fsf@ursa.amorsen.dk>
	<OFEA0D61B2.8B351FDC-ONC12575D3.0034AA26-C12575D3.00354697@transmode.se>
	<20090612125214.GA7461@kallisti.us>
	<OF0314F87C.B7A0780D-ONC12575D3.00476B7B-C12575D3.00484E73@transmode.se>
	<2e59e6970906120619u589ed8dfy8bb327efa305b742@mail.gmail.com>
	<OF32E45445.B5790A30-ONC12575D3.004B77E2-C12575D3.004BBABD@transmode.se>
	<2e59e6970906121231x7278360u19bcc58646116469@mail.gmail.com>
	<OFB9321502.79301BE7-ONC12575D3.0075D3D1-C12575D3.00765847@transmode.se>
From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Sat, 13 Jun 2009 01:54:30 +0200
In-Reply-To: <OFB9321502.79301BE7-ONC12575D3.0075D3D1-C12575D3.00765847@transmode.se>
	(Joakim Tjernlund's message of "Fri\,
	12 Jun 2009 23\:32\:39 +0200")
Message-ID: <m3eitpovnt.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] RFC: Simple Private VLAN impl.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:

> But why should I not be able to add both 4043 and 4044 to the same bridge?

Of course you should. And they should behave as a proper bridge, letting
packets flow as they were meant to. Unless you decide that local policy
does not permit packets to flow freely, and then you use ebtables to
apply that local policy.

> I just sent a patch to add split horizon support to the linux bridge. Have
> a look. More power to the linux bridge that way.

You have already been shown that you can achieve what you want with the
existing kernel code, at the cost of a somewhat complicated rule setup.
You have also been shown ways to simplify this rule setup.

I really hope that your patches are not accepted. Sorry if this is
harsh, but the company I work for has in the past depended on the
flexibility of the existing code. While that company is currently
migrating to proprietary solutions because PC's don't get faster at the
rate which traffic grows, it seems ridiculous that Linux should copy the
limitations of less capable platforms.


/Benny

