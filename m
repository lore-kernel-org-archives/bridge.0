From: Ross Vandegrift <ross@kallisti.us>
Date: Sat, 13 Jun 2009 12:56:40 -0400
Message-ID: <20090613165640.GA15903@kallisti.us>
References: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<m3ab4dovgi.fsf@ursa.amorsen.dk>
	<OFCE5E72FE.D082AB78-ONC12575D4.005256D7-C12575D4.0052B193@transmode.se>
	<1244905945.3175.25.camel@ursa.amorsen.dk>
	<OF6DCC73C6.20F5C539-ONC12575D4.00562ACB-C12575D4.00569683@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6DCC73C6.20F5C539-ONC12575D4.00562ACB-C12575D4.00569683@transmode.se>
Subject: Re: [Bridge] [PATCH] [bridge] Add split horizon
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org, Benny Amorsen <benny+usenet@amorsen.dk>

On Sat, Jun 13, 2009 at 05:45:47PM +0200, Joakim Tjernlund wrote:
> I would really like to read up on the claim that each VLAN is also a physical port.
> Any pointers?

Note that you added the VLAN tagged subinterface to the bridge.  Using
brctl's functions, you'll be able to see the port numbers assigned to
each port.  You'll be able to display the MACs learned on each port,
along with each port's ID.

Ross

-- 
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie
