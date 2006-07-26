Date: Wed, 26 Jul 2006 08:34:55 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060726083455.08989fc6@localhost.localdomain>
In-Reply-To: <44C77FD2.2030208@seskion.de>
References: <44C77FD2.2030208@seskion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Juergen Pfeiffer <j.pfeiffer@seskion.de>
Cc: bridge@lists.osdl.org, uclinux-dev@uclinux.org

On Wed, 26 Jul 2006 16:44:34 +0200
Juergen Pfeiffer <j.pfeiffer@seskion.de> wrote:

> Hi
> 
> I didn't get bridgeing to work with Linux kernel 2.6.10 (coldfire 5485) 
> yet. When i try to configure bridgeing
> with "brctl", everything seems to be ok, but i if i try to ping through 
> my bridge, i see ARP-Request arriving on the other side, but the
> ARP-Responses do not go back through the bridge.

Did the bridge get set up right? Did the interfaces come up (look at 'brctl showstp br0')
The bridge is sensitive to the network devices reporting carrier properly,
so a bad network driver or card will make it not work.

> Now i could read in 
> "http://www.tldp.org/HOWTO/Ethernet-Bridge-netfilter-HOWTO-2.html#ss2.1"
> that "Use of kernel 2.6 is not yet a good idea".

That's crap. 2.6 works great.
2.4 is now in frozen hibernation mode, there are bugs in
there that are not going to ever be fixed.

> So do i have a change to get it working?
> 
