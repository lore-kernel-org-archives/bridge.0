Message-ID: <40A8DE8B.2060706@osdl.org>
Date: Mon, 17 May 2004 08:47:23 -0700
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
Subject: Re: [Bridge] bridge latency
References: <40A876DC.8060703@gmx.net>
In-Reply-To: <40A876DC.8060703@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Eicke Friedrich <tady@gmx.net>
Cc: bridge@lists.osdl.org

Eicke Friedrich wrote:

> Hi list,
>
> we did an investigation of a firewalling Linux bridge in terms of 
> latency and throughput using DAG 3.5E interfaces for precise 
> timestamping of ip packets [1]. The overall results are very good but 
> one fact we can't explain. The following URL points to an image of 
> such an measuring where we push 60MBits/s TCP traffic through the 
> bridge in one direction:
> http://kea.informatik.uni-leipzig.de/ipp2p/delay/color_60e_plain_out.png
>
> If you look at the image you'll see the max line showing regular (one 
> per minute) spikes. I've absolutly no idea where these spikes may come 
> from. So I want to ask you, if you could imagine a reason for these 
> spikes? These are only few packets but for us it's important to find 
> out why they get sometimes delayed this much longer.
>
> Some background about the bridging box:
> Hardware:
> Pentium4 1.7GHz, 1.024MB RAM, 2 x 3Com 3c905 [Boomerang] being br0, 
> 3Com 3c905B as management interface.
>
> Software:
> vanilla Linux Kernel 2.6.3 with patched in CONNMARK extension, STP was 
> disabled
>
> Other:
> The bridge was running in plain mode wich means no other modules like 
> iptables, ebtables or packet scheduler were loaded. It was running in 
> runlevel 3, multiuser networking without x-system.
>
> For comparison only this link shows what happens if we push as much 
> TCP traffic in one direction (~97.5 MBits/s) through the bridge, in 
> second image having iptables loaded:
> http://kea.informatik.uni-leipzig.de/ipp2p/delay/color_max_120c_delay-0.png 
>
> http://kea.informatik.uni-leipzig.de/ipp2p/delay/color_max_ipp2p_120c_delay-0.png 
>

It could be a NAPI scheduling delay. If that driver uses NAPI, it avoids 
doing all the receive work at interrupt,
by doing the work at softirq.  There is an upper bound of packets it 
will process in one interval, to avoid getting
stuck in the softirq.  If the mean number of packets per second arriving 
exceeed the softirq work rate, then
you might see something like this. You might try profiling to see if 
anything shows up.
