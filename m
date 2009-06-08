In-Reply-To: <20090608155032.GA8923@kallisti.us>
References: <OF468ECA85.09186D4C-ONC12575CF.00554E83-C12575CF.0055AFA2@transmode.se>
	<20090608155032.GA8923@kallisti.us>
Message-ID: <OF14547733.EE776676-ONC12575CF.005BCB77-C12575CF.005CB0B5@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 8 Jun 2009 18:52:25 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] Looking at impl. Private VLAN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ross Vandegrift <ross@kallisti.us>
Cc: bridge@lists.linux-foundation.org

Ross Vandegrift <ross@kallisti.us> wrote on 08/06/2009 17:50:32:
>
> On Mon, Jun 08, 2009 at 05:35:55PM +0200, Joakim Tjernlund wrote:
> >
> > I am looking into impl Private VLAN(or part thereof) as specified by
> >  http://www.rfc-editor.org/internet-drafts/draft-sanjib-private-vlan-10.txt
> >
> > Would that be a welcome addition to the linux bride or is there
> > a better method for doing "Private VLAN"?
>
> It should be pretty simple to cook up a private VLAN setup using
> ebtables.  At the simplest level, you could simply write policy to
> only permit frames between specified interfaces.  In this way, each
> group of interfaces would represent a private VLAN.

hmm, I have never used ebtables, will have to look into that. Could
you give men an example on how to configure(using ebtables) the following:
br0 with one I/F(eth_master) in Promisc(as defined in the Private VLAN spec above) mode
and two I/F's( eth_client1 and eth_client2) in Isolated mode?

>
> But ebtables is pretty flexible - with the right ruleset, you should
> be able to cook up all kinds of crazy, fun stuff!

Does this mean that you think "Private VLAN" support is unneeded in
the Linux bridge? From you comments it seems like one should be able to do most
things with ebtables, but is this also the preferred way?

 Jocke

