Date: Sat, 19 Jan 2008 13:16:12 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] trying to bridge eth0 & usb0 but arp requests go to
	the wrong network
Message-ID: <20080119131612.1777e3e4@deepthought>
In-Reply-To: <Pine.LNX.4.62.0801182226450.20707@wadonga.seg>
References: <Pine.LNX.4.62.0801182226450.20707@wadonga.seg>
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
To: andreas@bunten.de
Cc: bridge@lists.linux-foundation.org

On Fri, 18 Jan 2008 22:35:59 +0100 (CET)
andreas@bunten.de wrote:

> Hello,
> 
> I'm trying to get bridging to work between eth0 and usb0:
> 
> 192.168.13.2  <--->  br0:192.168.13.47  <---> 192.168.13.1
>                       usb0         eth0
> 
> 192.168.13.2:~ # ping 192.168.13.1
> ... 100 % packet loss
> 
> On 192.168.13.1 I do see the arp requests but no icmp packet :-/
> 
> Just like "No traffic gets trough (except ARP and STP)" in the
> FAQ on http://www.linux-foundation.org/en/Net:Bridge
> 
> Except ...
> 
> I can ping 192.168.13.1 from the bridge (192.168.13.47)
> Trying to ping 192.168.13.2 from the bridge does not work
> I do see the arp requests for 192.168.13.2 on 192.168.13.1 (!)
> 
> I get the same result if if enable STP on the bridge.
> 
> What is going wrong here? :-/
> 
> Any hint appreciated!
> 
> Regards,
> andreas
> 
> 
> PS: The bridge system is a SUSE 10.2 with kernel 2.6.18.8-0.7-default 
> (incl. suse patches) usb0 is a MosChip usb nic using the mcs7830 driver 
> and eth0 is an on board intel nic. both work fine in non bridging mode.
> 
> my routing table (just ignore the vmnet stuff):
> 
> bibo:/proc/sys/net/ipv4 # route -n
> Kernel IP routing table
> Destination  Gateway      Genmask       Flags Metric Ref Use Iface
> 10.0.0.0     0.0.0.0      255.255.255.0 U     0      0     0 vmnet8
> 192.168.13.0 0.0.0.0      255.255.255.0 U     0      0     0 br0
> 10.0.10.0    0.0.0.0      255.255.255.0 U     0      0     0 vmnet1
> 127.0.0.0    0.0.0.0      255.0.0.0     U     0      0     0 lo
> 0.0.0.0      192.168.13.1 0.0.0.0       UG    0      0     0 br0

Please reproduce without the interference of the proprietary VMware
network. Since VM networking does it's own bridging, I suspect interference.

Or go bug SUSE support

-- 
Stephen Hemminger <stephen.hemminger@vyatta.com>
