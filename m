Date: Wed, 19 Jan 2005 02:33:17 +0100
From: Jody Belka <lists-bridging@pimb.org>
Subject: Re: [Bridge] bridge in 'hub' mode possible?
Message-ID: <20050119013317.GA22664@faith.gentoo.org>
References: <41B03950.5000106@web.de> <017001c4d957$f0f29b70$0100a8c0@raider>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017001c4d957$f0f29b70$0100a8c0@raider>
Sender: "Jody Belka,,,,knew@pimb.org" <jmb@mccarroll.org.uk>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

On Fri, Dec 03, 2004 at 11:48:35AM -0500, Roman Chertov wrote:
> > I wonder if it would be worth to introduce some kind of "monitor
> > interface" for a brigde (as can be found on switches, don't know if
> > "monitor port" would be the correct term for it).
> > 
> I have already made one for the 2.4.20 kernel module and the 1.0.4
> bridge-utils.  Since I was making this for the Emulab testbed I also had
> to change the src/dst MACs that were going to the tap; otherwise, the
> underlying switch would drop the mirrored packets as their MAC's were
> not registered on the VLAN where the tap sat.  
> 
> If people have any interest in this I can share with the code.

I'd be interested in something like this. Maybe something along the lines of:

brctl addtap <bridge> <device>    # only allow 1 tap? i'd guess so, but if not
brctl deltap <bridge>             # then add a <device> param to deltap

This would be very useful for me, as it would make hooking up snort
to a linux bridge very nice and easy.


J

-- 
Jody Belka
knew (at) pimb (dot) org
