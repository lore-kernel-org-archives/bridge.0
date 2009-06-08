From: Ross Vandegrift <ross@kallisti.us>
Date: Mon, 8 Jun 2009 11:50:32 -0400
Message-ID: <20090608155032.GA8923@kallisti.us>
References: <OF468ECA85.09186D4C-ONC12575CF.00554E83-C12575CF.0055AFA2@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF468ECA85.09186D4C-ONC12575CF.00554E83-C12575CF.0055AFA2@transmode.se>
Subject: Re: [Bridge] Looking at impl. Private VLAN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org

On Mon, Jun 08, 2009 at 05:35:55PM +0200, Joakim Tjernlund wrote:
> 
> I am looking into impl Private VLAN(or part thereof) as specified by
>  http://www.rfc-editor.org/internet-drafts/draft-sanjib-private-vlan-10.txt
> 
> Would that be a welcome addition to the linux bride or is there
> a better method for doing "Private VLAN"?

It should be pretty simple to cook up a private VLAN setup using
ebtables.  At the simplest level, you could simply write policy to
only permit frames between specified interfaces.  In this way, each
group of interfaces would represent a private VLAN.

But ebtables is pretty flexible - with the right ruleset, you should
be able to cook up all kinds of crazy, fun stuff!

-- 
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie
