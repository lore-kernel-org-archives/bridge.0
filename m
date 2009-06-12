From: Ross Vandegrift <ross@kallisti.us>
Date: Fri, 12 Jun 2009 08:52:14 -0400
Message-ID: <20090612125214.GA7461@kallisti.us>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
	<de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
	<m33aa5bykm.fsf@ursa.amorsen.dk>
	<OFEA0D61B2.8B351FDC-ONC12575D3.0034AA26-C12575D3.00354697@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFEA0D61B2.8B351FDC-ONC12575D3.0034AA26-C12575D3.00354697@transmode.se>
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
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, Benny Amorsen <benny+usenet@amorsen.dk>

On Fri, Jun 12, 2009 at 11:41:55AM +0200, Joakim Tjernlund wrote:
> Yes, sets would be nice. However I wonder if this case isn't a bug
> in any case:
> Consider these VLANS:
>  eth0.4042
>  eth0.4043
>  eth0.4044
> 
> Add them to a bridge and the bridge will pass pkgs between them, right?
> However no real switch I know would do that because they are on
> the same physical interface.

No, that's not a problem at all.  Any dot1q bridge would behave
exactly as Linux does if it supports VLAN bridging (which at least
Cisco, Nortel, and Juniper do in varying capcities).

Moreover, any dot1q bridge that doesn't support VLAN bridging can
(be careful!) have the feature added by adding one untagged port into
each VLAN and cabling them to a dot1d bridge.  Linux just saves you
cables.

The split-horizon rule is for flooding into a broadcast domain.  For
purposes of split-horizon flooding, each of your VLAN interfaces are
physical interfaces - a broadcast frame arrived on one of the ports
and needs to be flooded out all of the others.

Ross

-- 
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie
