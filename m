Date: Tue, 13 Nov 2007 10:04:52 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Rx Buffer sizes on e1000
Message-ID: <20071113100452.2d0debc3@freepuppy.rosehill>
In-Reply-To: <20071113101203.1e0235c3@catlap>
References: <96CF49BD8B56384395D698BA99007FA32D4A@exchange.pacwire.local>
	<20071113101203.1e0235c3@catlap>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Marek Kierdelewicz <marek@piasta.pl>
Cc: bridge@lists.linux-foundation.org

On Tue, 13 Nov 2007 10:12:03 +0100
Marek Kierdelewicz <marek@piasta.pl> wrote:

> >Hi All,
> 
> Hi,
> 
> > I have a box with 24 e1000 cards in it. They are configured as 12
> >bridges, each with 2 ports.
> 
> 24 ports of e1000 nics means 24 interrupts used (or shared). Maybe
> thats the source of the problem. Did you notice anything unusual in your
> logs concerning e1000 nics?
> 
> >...
> >CPU utilisation is hovering around 50%, and load average is
> >consistently
> >under 0.1, so I don't beleive I'm looking at a CPU bottleneck.
> 
> Is your box is multi-core (or HT-enabled)? Is your kernel SMP? If thats
> the case then check per core CPU utilisation (press "1" when watching
> top). You may be hitting roof only on one of the cores while avg.
> utilisation is around 50%. If you're not familiar with "smp_affinity",
> then you should read the following:
> http://bcr2.uwaterloo.ca/~brecht/servers/apic/SMP-affinity.txt
> 
> cheers,
> Marek Kierdelewicz
> KoBa ISP
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

First, make sure you have enough bus bandwidth!
What kind of box, you really need PCI-express to get better bus
throughput. MSI will also help. Memory speeds also matter.
And the dual-port e1000's add a layer of PCI bridge that also
hurts latency/bandwidth.

Don't use kernel irq balancing, user space irqbalance daemon is smart
enough to recognize network device's and do the right thing (assign
them directly to processors).

It would be useful to see what the kernel profiling (oprofile) shows.

How are you measuring CPU utilization? The only accurate way is to 
measure time with an idle soaker program versus, time under load.
Andrew Morton wrote a cyclesoaker to do this, if you want it, I'll
dig it up.


-- 
Stephen Hemminger <shemminger@linux-foundation.org>
