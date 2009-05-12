In-Reply-To: <20090512130622.GB20371@kallisti.us>
References: <OF6C9DD85E.5F51CD2D-ONC12575B0.002E85F9-C12575B0.002F0604@transmode.se>
	<20090508090226.70d23727@nehalam>
	<OFD8A6DCB5.C299BC0C-ONC12575B2.006169DD-C12575B2.0061B705@LocalDomain>
	<OFE9F41029.741448FE-ONC12575B4.003524B7-C12575B4.0035670C@transmode.se>
	<20090512130622.GB20371@kallisti.us>
Message-ID: <OF7FA32E47.F66BC1F6-ONC12575B4.004BFE38-C12575B4.004D2DFD@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 12 May 2009 16:03:00 +0200
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
To: Ross Vandegrift <ross@kallisti.us>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

Ross Vandegrift <ross@kallisti.us> wrote on 12/05/2009 15:06:22:
>
> On Tue, May 12, 2009 at 11:43:17AM +0200, Joakim Tjernlund wrote:
> > Looking into this I got a question:
> > Should the bridge forward the whole bridge multicast group except PAUSE
> > or only the STP multicast address?
>
> If you're implementing that, it should only forward the STP address.
>
> 802.1X and LACP will be very suprised (and very broken) when their
> PDUs start being forwarded to entities on other bridges...
>
> Ross

I just sent a patch "bridge: relay bridge multicast pkgs if !STP" to
the list. Let me know what you think.

 Jocke

