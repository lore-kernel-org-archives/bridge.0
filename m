From: Bart De Schuymer <bdschuym@pandora.be>
Date: Mon, 29 Sep 2003 21:38:13 +0200
References: <5.1.0.14.0.20030929112307.01d49ec8@127.0.0.1>
In-Reply-To: <5.1.0.14.0.20030929112307.01d49ec8@127.0.0.1>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309292138.13585.bdschuym@pandora.be>
Subject: [Bridge] Re: [Ebtables-user] Trying to do gigabit
	bridging+firewalling
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: DarthPeter <peter@darthpeter.com>, ebtables-user@lists.sourceforge.net
Cc: bridge@lists.osdl.org

On Monday 29 September 2003 20:44, DarthPeter wrote:
> Hi everyone,

Hello, I'm CC-ing the bridge mailing list since there are more people on that 
one and they might be able to shed more light.

> We are trying to build a powerful firewall that could handle
> several hundred megabits of traffic and we are running into a problem
> with it. We'd like to be able to accomplish this so as to proof
> such performance is possible with Linux.
>
> When we put this firewall on our live network, which is currently
> handling about 60mbps of traffic, traffic slows down tremendously.
> A download from an external location that usually goes at 100k/s,
> slows down to 3k/s.
>
> The first hardware we tried for this firewall was:
>
> - supermicro X5SSE-GM
> - 1GB of RAM
> - 1 Xeon CPU
> - 2 Intel 1000MT with dual ports
>
> Thinking it might be a bus problem since that motherboard is not Intel
> and the bus is PCI66, we switched to:
>
> - Supermicro X5DPA-GG (Intel 7501 chipset)
> - 1GB of RAM
> - Dual Xeon
> - 2 integrated 82541 Intel gigabit
>
> The problem continued though.
>
> We've used kernel 2.4.21 and 2.6.0-test5. On 2.4.21, both bridge
> and ebtables are enabled. On 2.6.0, only bridging and iptables.
>
> There are no iptable or ebtable rules during these live tests.
>
> On our test environment, the bridge is able to handle several
> hundred megabits of traffic with no slowdown. The test environment
> is 5 desktops constantly downloading files from a server with
> a gigabit port sitting behind the firewall.
>
> Of course, this is nowhere close to the live environment. The live
> environment is handling traffic coming from thousands of locations
> directed to thousands of IPs and ports on our network. We have
> about 19 class Cs in use. On a slow Saturday night, tcpdump can
> print 2,000 lines of stat per second.
>
> The CPU consumption and load on the firewall during these live
> tests is literally zero.
>
> Unfortunately, during these tests, we only have a few minutes
> to try things out before customers begin complaining about slow
> access to their servers.
>
> Also, there's no VLANs in the middle. The firewall is connected
> to a 100 meg hand off from one of our upstreams, then from the
> firewall it goes to our Cisco 7200 router. We had thought of
> putting the firewall within the network, but didn't want to mess
> with VLANing on the firewall.
>
> Any suggestions as to what may cause the slowdown? Is it just
> too many IPs to handle? If so, I assume iptables or the bridge
> is somehow tracking all of that and can't handle so much at
> the same time? Maybe another kernel module might be causing it?
> Maybe the e1000 drivers? Or the fact that it is connected directly
> to our upstream between their router and ours?
>
> There's no QoS set on the server, though I believe the modules
> are compiled in.
>
> We'd like to know if someone has seen this kind of behavior, or if
> anyone has been able to get more traffic through bridge+firewall
> with so many IPs involved and no slowdowns?
>
> Our next step would be to strip down the kernel of all networking
> modules related to other features and to change the NICs. But don't
> want to go through that if someone out there already knows what
> the cause might be.
>
> Thanks in advance for any help you can provide,
>
> Peter :)

My guess would be it's connection tracking that eats your performance. What 
happens if you disable it (compile time option)?
Unless I'm mistaken, Jozsef Kadlecsik <kadlec_at_blackhole.kfki.hu> wrote a 
target that lets you disable connection tracking for certain packets. Check 
out the netfilter devel mailing list. Connection tracking on a bridging 
firewall is extra slow because packets that won't be bridged (because they're 
destined for the same side of the bridge) will be tracked too by connection 
tracking. You could prevent that using the abovementioned target.
If connection tracking is the problem, you're probably better off asking for 
more details in netfilter-devel@lists.netfilter.org.
If you will have lots of iptables filter rules, you should check out 
http://www.hipac.org/ (if you haven't already).

cheers,
Bart

