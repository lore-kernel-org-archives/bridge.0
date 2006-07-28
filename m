From: Bart De Schuymer <bdschuym@pandora.be>
In-Reply-To: <20060726083455.08989fc6@localhost.localdomain>
References: <44C77FD2.2030208@seskion.de>
	<20060726083455.08989fc6@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 21:17:36 +0200
Message-Id: <1154114256.3053.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Is bridgeing possible with kernel 2.6.10
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: uclinux-dev@uclinux.org, bridge@lists.osdl.org

Op wo, 26-07-2006 te 08:34 -0700, schreef Stephen Hemminger:
> On Wed, 26 Jul 2006 16:44:34 +0200
> Juergen Pfeiffer <j.pfeiffer@seskion.de> wrote:
> 
> > Hi
> > 
> > I didn't get bridgeing to work with Linux kernel 2.6.10 (coldfire 5485) 
> > yet. When i try to configure bridgeing
> > with "brctl", everything seems to be ok, but i if i try to ping through 
> > my bridge, i see ARP-Request arriving on the other side, but the
> > ARP-Responses do not go back through the bridge.
> 
> Did the bridge get set up right? Did the interfaces come up (look at 'brctl showstp br0')
> The bridge is sensitive to the network devices reporting carrier properly,
> so a bad network driver or card will make it not work.
> 
> > Now i could read in 
> > "http://www.tldp.org/HOWTO/Ethernet-Bridge-netfilter-HOWTO-2.html#ss2.1"
> > that "Use of kernel 2.6 is not yet a good idea".
> 
> That's crap. 2.6 works great.
> 2.4 is now in frozen hibernation mode, there are bugs in
> there that are not going to ever be fixed.

That document is completely outdated and the author never got around to
updating it even after some correspondence with me (year(s) ago).

cheers,
Bart


