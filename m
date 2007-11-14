Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [Bridge] Rx Buffer sizes on e1000
Date: Wed, 14 Nov 2007 12:34:14 +1100
Message-ID: <96CF49BD8B56384395D698BA99007FA32D50@exchange.pacwire.local>
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

>I'll re-run that oprofile. The last set of tests I did was with
ebtables disabled, and it was still dropping packets. Ultimately,
however, I need ebtables (and tc) running. 

And here it is. Ebtables is loaded but not running.

----

CPU: P4 / Xeon, speed 2400.15 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 100000
GLOBAL_POWER_E...|
  samples|      %|
------------------
 17230723 56.7305 e1000
  8142695 26.8090 vmlinux
  2439000  8.0302 bridge
  1036770  3.4135 ip_tables
   468590  1.5428 ebtables
   215775  0.7104 oprofiled
 
----

This was with about 121Mbps of traffic on the entire box (11 bridges,
11Mbps on each of them), with irqbalance.
The results are better with irqbalance, but still not quite there yet.



-----Original Message-----
From: bridge-bounces@lists.linux-foundation.org
[mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of Leigh
Sharpe
Sent: Wednesday, 14 November 2007 10:11 AM
To: Stephen Hemminger
Cc: bridge@lists.linux-foundation.org
Subject: RE: [Bridge] Rx Buffer sizes on e1000

Hi Steven,

>You are using ebtables, so that adds a lot of overhead processing the
rules. The problem is that each packet means a CPU cache miss.  What is
the memory bus bandwidth of the Xeon's?


I'll re-run that oprofile. The last set of tests I did was with ebtables
disabled, and it was still dropping packets. Ultimately, however, I need
ebtables (and tc) running.

 Memory is DDR333. 

Having installed irqbalance as you suggested, initial tests look
promising....

Leigh. 

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@linux-foundation.org] 
Sent: Wednesday, 14 November 2007 9:47 AM
To: Leigh Sharpe
Cc: bridge@lists.linux-foundation.org
Subject: Re: [Bridge] Rx Buffer sizes on e1000

On Wed, 14 Nov 2007 09:24:18 +1100
"Leigh Sharpe" <lsharpe@pacificwireless.com.au> wrote:

> >First, make sure you have enough bus bandwidth!
> 
> Shouldn't a PCI bus be up to it? IIRC, PCI has a bus speed of 133MB/s.
> I'm only doing 100Mb/s of traffic, less than 1/8 of the bus speed. I
> don't have a PCI-X machine I can test this on at the moment.

I find regular PCI bus (32bit) tops out at about 600 Mbits/sec on most
machines. For PCI-X (64 bit/133) a realistic value is 6 Gbits/sec. The
problem is arbitration and transfer sizes.

Absolute limit is:
PCI32 33MHz = 133MB/s
PCI32 66MHz = 266MB/s
PCI64 33MHz = 266MB/s
PCI64 66MHz = 533MB/s
PCI-X 133MHz = 1066MB/s 

That means for for normal PCI32, one gigabit card or 
6 100Mbit Ethernet interfaces can saturate the bus. Also, all that
I/O slows down the CPU and memory interface.

> >Don't use kernel irq balancing, user space irqbalance daemon is smart
> 
> I'll try that.
> 
> >It would be useful to see what the kernel profiling (oprofile) shows.
> 
> Abridged version as follows:
> 
> CPU: P4 / Xeon, speed 2400.36 MHz (estimated)
> Counted GLOBAL_POWER_EVENTS events (time during which processor is not
> stopped) with a unit mask of 0x01 (mandatory) count 100000
> GLOBAL_POWER_E...|
>   samples|      %|
> ------------------
>  65889602 40.3276 e1000
>  54306736 33.2383 ebtables
>  26076156 15.9598 vmlinux
>   4490657  2.7485 bridge
>   2532733  1.5502 sch_cbq
>   2411378  1.4759 libnetsnmp.so.9.0.1
>   2120668  1.2979 ide_core
>   1391944  0.8519 oprofiled 
> 

You are using ebtables, so that adds a lot of overhead
processing the rules. The problem is that each packet means a CPU
cache miss.  What is the memory bus bandwidth of the Xeon's?

> --------------------------
> (There's more, naturally, but I doubt it's very useful.)
> 
> 
> >How are you measuring CPU utilization?
> 
> As reported by 'top'.
> 
> >Andrew Morton wrote a cyclesoaker to do this, if you want it, I'll
dig
> it up.
> 
> Please.
> 
> >And the dual-port e1000's add a layer of PCI bridge that also hurts
> latency/bandwidth.
> 
> I need bypass-cards in this particular application, so I don't have
much
> choice in the matter.
> 
> Thanks,
> 	Leigh




-- 
Stephen Hemminger <shemminger@linux-foundation.org>

_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge

