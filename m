From: Aijaz Baig <aijazbaig1@gmail.com>
In-Reply-To: <1274773935.13015.36.camel@aijazbaig1-desktop>
References: <1274773935.13015.36.camel@aijazbaig1-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 25 May 2010 14:58:15 +0530
Message-ID: <1274779695.13015.41.camel@aijazbaig1-desktop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] vlan issue with bridge router,
 local virtual iface needs to be in same subnet
Reply-To: aijazbaig1@gmail.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello there,
there are a few errors in my post which I would like to point out:
In the figure at http://yfrog.com/83vlanp , PortC(LAN) shd be replaced
by PortA(LAN) and PortD(WAN) by PortB(WAN) for both the real and the
virtual interfaces. My linux machine is connected to LAN whereas the WAN
goes on to meet the router.

Thus, the ebtables rule changes to
ebtables -t broute -I BROUTING -p 0x8100 -i PortA -j redirect
--redirect-target DROP
 
On Tue, 2010-05-25 at 13:22 +0530, Aijaz Baig wrote:
> Hello people,
> 
> I have a Linux machine acting as a bridge although it has been updated
> to the 2.6.27 kernel and thus contains iptables, ebtables and also the
> br-nf code for iptables based filtering at the Link layer (please
> correct me if I have misunderstood anything). I have been trying to ping
> the bridge itself from a virtual interface on my local machine (also
> linux). So before we proceed heres my scenario. Please refer to the
> figure describing the scenario at http://yfrog.com/83vlanp
> 
> br0 - 192.168.5.104/20
> PortA - 0.0.0.0 (bridged port)
> PortB - 0.0.0.0 (bridged port)
> PortA.3 - 0.0.0.0 (bridged port)
> PortB.3 - 0.0.0.0 (bridged port)
> 
> eth0 - 192.168.4.237/20 (local)
> eth0.3 - 14.11.11.11/24 (local)
> 
> I have read the entire documentation with the title 'interaction of the
> ebtables and iptables on a linux bridge'. Alongwith that I have also
> read quite a few documents on using the iptables and the ebtables
> utilities.
> 
> Most of my questions concern the diagram at
> (http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png) which explains
> the movement of the packet flow. 
> 
> for this experiment, I have flushed all the rules in the iptables and
> ebtables for all the chains. Plus the default policy for all the chains
> in iptables and ebtables is set to ACCEPT. The only rule that I have on
> my machine is 
> 
> ebtables -t broute -I BROUTING -p 0x8100 -i PortC -j redirect
> --redirect-target DROP
> 
> My major analysis has been the ubiquitous tcpdump alongwith some
> utilities
> 
> Now my questions:
> 
> When I try 'arping' my brouter from eth0.3, the arp request which is
> untagged arrives on PortA. Now since the above rule has got nothing to
> do with untagged packets, it is not 'brouted' and according to the
> diagram, it then moves forward to the ebtables PREROUTING chain in the
> nat table. No rule there. Followed by prerouting chain in the nat and
> mangle tables of 'iptables' (due to br-nf at link-layer i suppose?).
> Finally reaches 'bridging decision'.
> 
> 1. what exactly happens @bridging decision? The target MAC address
> is a broadcast address. Now how does the bridging logic decide if it is
> to be bridged or to be routed for an ARP request? Does it do it by
> looking at the 'target protocol address' field for the arp packet? If
> this is indeed true then since in case of 'arping' the brouter, this
> field shd be = IP addr of the brouter. Thus the bridging logic instead
> passes it to the routing code from where it is sent to the ARP code if I
> interpret it correctly. Am I right on this one? Since I do get a reply
> from the bridge for the arp request even when sent from a tagged
> interface, I assume this is what might be happening. seeking
> clarifications though.
> 
> 2. Now I try to ping my brouter from eth0.3 as in 'ping -I eth0.3
> 192.168.5.104' .On running tcpdump on the brouter, I can see the
> following:
> 
> 13:17:53.822056 PortA.3, IN:  In 00:25:11:8f:c6:21 ethertype IPv4
> (0x0800), length 100: 14.11.11.11 > 192.168.5.104: ICMP echo request
>                    
> 13:17:53.822415 br0, IN:  In 00:25:11:8f:c6:21 ethertype IPv4 (0x0800),
> length 100: 14.11.11.11 > 192.168.5.104: ICMP echo request
> 
> 13:17:53.822740 br0, OUT: Out 00:0d:48:36:59:88 ethertype IPv4 (0x0800),
> length 100: 192.168.5.104 > 14.11.11.11: ICMP echo request
> 
> 13:17:53.822895 PortB, OUT: Out 00:0d:48:36:59:88 ethertype IPv4
> (0x0800), length 100: 192.168.5.104 > 14.11.11.11: ICMP echo reply
> 
> After pinging from eth0.3 with this IP, I see that an ARP entry for
> 14.11.11.11 has been registered at br0. 
> 
> I would be greatly obliged if you could shed some light on this. 
> 
> Regards,
> Aijaz Baig.


