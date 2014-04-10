Return-Path: <giuseppe@eppesuigoccas.homedns.org>
Message-ID: <5346246A.5090704@eppesuigoccas.homedns.org>
Date: Thu, 10 Apr 2014 06:56:10 +0200
From: Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge only forward packets on one interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,
I do have a problem with a new bridge I created for making a virtual
machine connect to the Internet. The physical machine only have one
interface, named eth0, so I create a bridge using this interface. Then I
created a virtual machine with KVM and select using the bridge for
ethernet networking. The machine has been installed and the network
connection between the machines works great.

But, when the virtual machine tries to connect to its default gateway,
nothing works. I used tcpdump in order to see what packet are
transmitted on the bridge *br0*: when I ping the gateway I see an ARP
packet "who-has" from the VM and its reply ARP "is-at". If I use tcpdump
on the phisical interface *eth0* I still see both packets, but when I
check it on the virtual interface *vnet0* I only see the first packet.

I think the problem could be about arp tables, but how may I better
investigate this problem?

Thanks,
Giuseppe
