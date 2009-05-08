In-Reply-To: <20090508121439.GA21719@kallisti.us>
References: <OF6C9DD85E.5F51CD2D-ONC12575B0.002E85F9-C12575B0.002F0604@transmode.se>
	<20090508121439.GA21719@kallisti.us>
Message-ID: <OFEB9EBA67.E2DADD61-ONC12575B0.00437206-C12575B0.004466FF@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 8 May 2009 14:27:08 +0200
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
Cc: bridge@lists.linux-foundation.org

Ross Vandegrift <ross@kallisti.us> wrote on 08/05/2009 14:14:39:

> On Fri, May 08, 2009 at 10:33:37AM +0200, Joakim Tjernlund wrote:
> > We have noticed that when STP is off in the linux bridge, it won't
> > relay STP pkts received from other bridges.
> > This feels like a bug(a bad one too). I hope this isn't
> > intentional behaviour?
>
> IEEE 802.1D specifies that no bridge should ever forward packets
> destined to the bridge multicast groups.  See requirement 7.12.6 in
> 802.1D-2004.

uhh, that was a surprise. My impression is that normal switches
do forward the bridge multicast group, is this true? If so
can we add an option to the linux bridge to allow forwarding of
bridge multicast groups?

 Jocke

