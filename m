Message-ID: <47D19BC9.6060702@navigue.com>
Date: Fri, 07 Mar 2008 14:47:21 -0500
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge, vlan and *no* stp/bpdu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello list,

I've posted here about this before, but I realise that it may have been 
assumed that the bridged vlans simply put a switch port in a blocking 
state and left my question ignored.  So to recap.

I have two tg3 interfaces named 'in' and 'out' and a bridge named 'br0'

My vlan trunk is on the 'in' side of the network, and set as in.2, in.3 
...  The 'out' side goes straight to an ipv4 gateway on untagged plain 
ethernet.

Putting 'in.2' and 'out' on the bridge works quite well and is roughly 
what I've been using so far.

# brctl show
bridge name     bridge id               STP enabled     interfaces
br0             8000.00e081342870       no              out
                                                        in.2

If I add in.3 to the bridge, trouble starts.  The bridge keeps 
forwarding packets just like it should, with the exception of ARP 
replies from the gateway to machines in vlan 2.  Machine that had ARPed 
the gateway prior to adding in.3 to the bridge keep working fine.

Here's the strange thing however.  Running a tcpdump on 'out' 'br0' or 
in.2 shows me the arp requests *and replies* for the machines that do 
not work, however, if I look on the wire leaving the 'in' interface 
itself (using a hub and another box), the arp replies are nowhere to be 
found.

So the arp replies get eaten *before* they make it onto the wire, but 
*after* tcpdump saw them on in.2.  It's driving me nuts...  I thought it 
might have to do with the tg3 hardware doing some funky vlan 
acceleration, but I've seen the same on plain dumb NICs too.

I'm willing to pay for a solution to this...  Or even for just someone 
knowledgeable enough with the code taking interest in the issue.

Thanks,

Jonathan
