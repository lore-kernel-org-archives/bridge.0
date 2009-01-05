From: Ross Vandegrift <ross@kallisti.us>
Date: Mon, 5 Jan 2009 17:31:00 -0500
Message-ID: <20090105223100.GA32533@kallisti.us>
References: <1789230353.79391231165863451.JavaMail.root@ken>
	<1604972349.79441231165919715.JavaMail.root@ken>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604972349.79441231165919715.JavaMail.root@ken>
Subject: Re: [Bridge] Bridging without forwarding? (not bonding)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Simon Detheridge <simon@widgit.com>
Cc: bridge@lists.linux-foundation.org

On Mon, Jan 05, 2009 at 02:31:59PM +0000, Simon Detheridge wrote:
> It's entirely possible that I'm going about this all the wrong
> way... I'm new here. :-)
> 
> What I'm trying to do is use a combination of vtun tap tunnels and
> bridging, to make my servers feel like they're on a LAN together.

Based on your description, what you really want is broadcast GRE.
Check out http://linux-ip.net/gl/ip-tunnels/node9.html for a basic
description.

If Amazon doesn't route multicast for you (which I'd imagine they
don't, there's info in the above doc on getting this going without
multicast.  Since you've got some way to discover neighbors for vtun,
do the same things to build your tunnel mesh.

Ross


-- 
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie
