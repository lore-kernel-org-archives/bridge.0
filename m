Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [Bridge] Rx Buffer sizes on e1000
Date: Wed, 14 Nov 2007 09:24:18 +1100
Message-ID: <96CF49BD8B56384395D698BA99007FA32D4B@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

>First, make sure you have enough bus bandwidth!

Shouldn't a PCI bus be up to it? IIRC, PCI has a bus speed of 133MB/s.
I'm only doing 100Mb/s of traffic, less than 1/8 of the bus speed. I
don't have a PCI-X machine I can test this on at the moment.

>Don't use kernel irq balancing, user space irqbalance daemon is smart

I'll try that.

>It would be useful to see what the kernel profiling (oprofile) shows.

Abridged version as follows:

CPU: P4 / Xeon, speed 2400.36 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 100000
GLOBAL_POWER_E...|
  samples|      %|
------------------
 65889602 40.3276 e1000
 54306736 33.2383 ebtables
 26076156 15.9598 vmlinux
  4490657  2.7485 bridge
  2532733  1.5502 sch_cbq
  2411378  1.4759 libnetsnmp.so.9.0.1
  2120668  1.2979 ide_core
  1391944  0.8519 oprofiled 


--------------------------
(There's more, naturally, but I doubt it's very useful.)


>How are you measuring CPU utilization?

As reported by 'top'.

>Andrew Morton wrote a cyclesoaker to do this, if you want it, I'll dig
it up.

Please.

>And the dual-port e1000's add a layer of PCI bridge that also hurts
latency/bandwidth.

I need bypass-cards in this particular application, so I don't have much
choice in the matter.

Thanks,
	Leigh




-----Original Message-----
From: bridge-bounces@lists.linux-foundation.org
[mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of Stephen
Hemminger
Sent: Wednesday, 14 November 2007 5:05 AM
To: Marek Kierdelewicz
Cc: bridge@lists.linux-foundation.org
Subject: Re: [Bridge] Rx Buffer sizes on e1000

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
> thats the source of the problem. Did you notice anything unusual in
your
> logs concerning e1000 nics?
> 
> >...
> >CPU utilisation is hovering around 50%, and load average is
> >consistently
> >under 0.1, so I don't beleive I'm looking at a CPU bottleneck.
> 
> Is your box is multi-core (or HT-enabled)? Is your kernel SMP? If
thats
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
_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge

