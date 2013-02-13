Return-Path: <chris.friesen@genband.com>
Message-ID: <511BC9D8.1020200@genband.com>
Date: Wed, 13 Feb 2013 11:14:00 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
References: <511ACE16.3080906@genband.com> <32261.1360713746@death.nxdomain>
	<511ADEBB.1000701@genband.com>
In-Reply-To: <511ADEBB.1000701@genband.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] how to handle bonding failover when using a bridge
	over the bond?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jay Vosburgh <fubar@us.ibm.com>
Cc: netdev <netdev@vger.kernel.org>, Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, bonding-devel@lists.sourceforge.net

On 02/12/2013 06:30 PM, Chris Friesen wrote:
> On 02/12/2013 06:02 PM, Jay Vosburgh wrote:
>> Chris Friesen<chris.friesen@genband.com> wrote:

>>> I have a physical host with two ethernet links that are bonded
>>> together (active/backup). Each link is connected to a separate L2
>>> switch, which are in turn connected with a crosslink for
>>> redundancy.
>>>
>>> The physical host is running multiple virtual machines each with
>>> a virtual adapter. The virtual adapters and the bond are all
>>> bridged together to allow communication between the virtual
>>> machines, the host, and the outside world.
>>>
>>> Now suppose one of the slave links fails. The bond device will
>>> failover to the other slave and send out a gratuitous arp on the
>>> newly active slave. This will cause the L2 switches to update
>>> their lookup tables for the MAC address associated with the bond
>>> (so it now points to the newly active slave), but doesn't update
>>> the MAC addresses associated with the various virtual machines.
>>> If someone on the network sends a packet to one of the virtual
>>> machines, the switch will try to send it over the failed slave.
>>
>> If the link failure is such that there is no carrier on the switch
>> port, the switch will drop the forwarding entry for the virtual
>> machine's MAC address from that port. The traffic for the VM's MAC
>> would then flood to all ports, presumably including the link to
>> the other switch, which wouldn't have a forwarding entry for the
>> MAC, either (or it would be the switch link port), and would also
>> flood it to all ports, one of which is the correct one.

I talked with our networking guy.  Apparently what is happening is that 
if we pull the link to switch A it drops the forwarding entries for all 
MACs on the downed link, but switch B still has stale entries pointing 
to the inter-switch link.

If a packet destined for the VM that arrives at switch B, it will send 
it across to switch A.  (Which is pointless since A no longer has a 
working link to the MAC in question.)

If a packet destined for the VM that arrives at switch A, it will 
broadcast it to all ports, including the inter-switch link to switch B. 
  However, switch B still thinks the MAC address is connected to switch 
A, so it drops the packet.

Once the VMs send out packets switch B will update its tables, but if 
the VMs are event-driven and mostly only respond to incoming packets 
they could end up waiting a long time.

Chris
