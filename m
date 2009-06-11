From: Ross Vandegrift <ross@kallisti.us>
Date: Thu, 11 Jun 2009 19:44:13 -0400
Message-ID: <20090611234413.GA3432@kallisti.us>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
	<20090610162752.GB24563@kallisti.us>
	<OF4422F49E.33BDAF5C-ONC12575D1.005C802A-C12575D1.005E38A3@LocalDomain>
	<OF3035BFFB.A9837EFB-ONC12575D2.00451300-C12575D2.00468AB7@transmode.se>
	<m3fxe6trbj.fsf@ursa.amorsen.dk>
	<OFFE50FA9A.7AE82F0F-ONC12575D2.007EDC69-C12575D2.007F4D1F@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFFE50FA9A.7AE82F0F-ONC12575D2.007EDC69-C12575D2.007F4D1F@transmode.se>
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

On Fri, Jun 12, 2009 at 01:10:28AM +0200, Joakim Tjernlund wrote:
> Also, do we need to do anything if STP is running on the bridge?

No, you shouldn't.  The FORWARD chain only defines filters for frames
that are passing through the bridge, not frames that are sourced from
or destined to the bridge.

-- 
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie
