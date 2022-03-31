Return-Path: <wintera@linux.ibm.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dsx5ldU95Alojy9t4EAoOZs0FEpNz8tK6IzHtjOw/y0=;
 b=Jg6zzfez7uPfHvE2+PhZ43CYodkHOf17Suxa17jeULDaVUmy1JHKTl0kDR4+giGVbrO5
 lUcTV66FQKvyHZBMBkLSA4bSIxp/v3pTLays4R8omqmxZeewcOeRDnPE04/Ono+MoFRH
 3RiED0PseRU2eHLM3oEkkTxGCU4ZYRiO7ODmmJ8BP2MbTxuXoQ96XI7gWsnsqDhNIH/M
 2JyTobPsrTh8clNJ3ZE9JC19z8FP10FRZLGgk1SXs1i/4jdWmpoZMqkxG3vcBPCBT2Uq
 YiidMBs6QeAlac8af5N688CoumYA6ds64WrX91b3ElnOg1cLa0wx2/pw9BtDvcu2TwrA bQ== 
Message-ID: <fa420a98-fb7b-a56b-7e13-2fa55b6ff6a9@linux.ibm.com>
Date: Thu, 31 Mar 2022 11:59:47 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220329114052.237572-1-wintera@linux.ibm.com>
 <20220329175421.4a6325d9@kernel.org>
 <d2e45c4a-ed34-10d3-58cd-01b1c19bd004@blackwall.org>
 <c1ec0612-063b-dbfa-e10a-986786178c93@linux.ibm.com>
 <20220330085154.34440715@kernel.org>
 <c512e765-f411-9305-013b-471a07e7f3ff@blackwall.org>
 <20220330101256.53f6ef48@kernel.org> <2600.1648667758@famine>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <2600.1648667758@famine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] veth: Support bonding events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jay Vosburgh <jay.vosburgh@canonical.com>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Heiko Carstens <hca@linux.ibm.com>, Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@nvidia.com>

On Tue, 29 Mar 2022 13:40:52 +0200 Alexandra Winter wrote:
> Bonding drivers generate specific events during failover that trigger
> switch updates.  When a veth device is attached to a bridge with a
> bond interface, we want external switches to learn about the veth
> devices as well.
>
> Example:
>
> 	| veth_a2   |  veth_b2  |  veth_c2 |
> 	------o-----------o----------o------
> 	       \	  |	    /
> 		o	  o	   o
> 	      veth_a1  veth_b1  veth_c1
> 	      -------------------------
> 	      |        bridge         |
> 	      -------------------------
> 			bond0
> 			/  \
> 		     eth0  eth1
>
> In case of failover from eth0 to eth1, the netdev_notifier needs to be
> propagated, so e.g. veth_a2 can re-announce its MAC address to the
> external hardware attached to eth1.

On 30.03.22 21:15, Jay Vosburgh wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
>> On Wed, 30 Mar 2022 19:16:42 +0300 Nikolay Aleksandrov wrote:
>>>> Maybe opt-out? But assuming the event is only generated on
>>>> active/backup switch over - when would it be okay to ignore
>>>> the notification?
>>>
>>> Let me just clarify, so I'm sure I've not misunderstood you. Do you mean opt-out as in
>>> make it default on? IMO that would be a problem, large scale setups would suddenly
>>> start propagating it to upper devices which would cause a lot of unnecessary bcast.
>>> I meant enable it only if needed, and only on specific ports (second part is not
>>> necessary, could be global, I think it's ok either way). I don't think any setup
>>> which has many upper vlans/macvlans would ever enable this.
>>
>> That may be. I don't have a good understanding of scenarios in which
>> GARP is required and where it's not :) Goes without saying but the
>> default should follow the more common scenario.
> 
> 	At least from the bonding failover persective, the GARP is
> needed when there's a visible topology change (so peers learn the new
> path), a change in MAC address, or both.  I don't think it's possible to
> determine from bonding which topology changes are visible, so any
> failover gets a GARP.  The original intent as best I recall was to cover
> IP addresses configured on the bond itself or on VLANs above the bond.
> 
> 	If I understand the original problem description correctly, the
> bonding failover causes the connectivity issue because the network
> segments beyond the bond interfaces don't share forwarding information
> (i.e., they are completely independent).  The peer (end station or
> switch) at the far end of those network segments (where they converge)
> is unable to directly see that the "to bond eth0" port went down, and
> has no way to know that anything is awry, and thus won't find the new
> path until an ARP or forwarding entry for "veth_a2" (from the original
> diagram) times out at the peer out in the network.
> 
>>>>> My concern was about the Hangbin's alternative proposal to notify all
>>>>> bridge ports. I hope in my porposal I was able to avoid infinite loops.  
>>>>
>>>> Possibly I'm confused as to where the notification for bridge master
>>>> gets sent..  
>>>
>>> IIUC it bypasses the bridge and sends a notify peers for the veth peer so it would
>>> generate a grat arp (inetdev_event -> NETDEV_NOTIFY_PEERS).
>>
>> Ack, I was basically repeating the question of where does 
>> the notification with dev == br get generated.
>>
>> There is a protection in this patch to make sure the other 
>> end of the veth is not plugged into a bridge (i.e. is not
>> a bridge port) but there can be a macvlan on top of that
>> veth that is part of a bridge, so IIUC that check is either
>> insufficient or unnecessary.
> 
> 	I'm a bit concerned this is becoming a interface plumbing
> topology change whack-a-mole.
> 
> 	In the above, what if the veth is plugged into a bridge, and
> there's a end station on that bridge?  If it's bridges all the way down,
> where does the need for some kind of TCN mechanism stop?
> 
> 	Or instead of a veth it's an physical network hop (perhaps a
> tunnel; something through which notifiers do not propagate) to another
> host with another bridge, then what?
> 
> 	-J
> 
> ---
> 	-Jay Vosburgh, jay.vosburgh@canonical.com

I see 3 technologies that are used for network virtualization in combination with bond for redundancy
(and I may miss some):
(1) MACVTAP/MACVLAN over bond:
MACVLAN propagates notifiers from bond to endpoints (same as VLAN)
(drivers/net/macvlan.c:
	case NETDEV_NOTIFY_PEERS:
	case NETDEV_BONDING_FAILOVER:
	case NETDEV_RESEND_IGMP:
		/* Propagate to all vlans */
		list_for_each_entry(vlan, &port->vlans, list)
			call_netdevice_notifiers(event, vlan->dev);
	})
(2) OpenVSwitch:
OVS seems to have its own bond implementation, but sends out reverse Arp on active-backup failover
(3) User defined bridge over bond:
propagates notifiers to the bridge device itself, but not to the devices attached to bridge ports.
(net/bridge/br.c:
	case NETDEV_RESEND_IGMP:
		/* Propagate to master device */
		call_netdevice_notifiers(event, br->dev);)

Active-backup may not be the best bonding mode, but it is a simple way to achieve redundancy and I've seen it being used.
I don't see a usecase for MACVLAN over bridge over bond (?)
The external HW network does not need to be updated about the instances that are conencted via tunnel,
so I don't see an issue there.

I had this idea how to solve the failover issue it for veth pairs attached to the user defined bridge.
Does this need to be configurable? How? Per veth pair?

Of course a more general solution how bridge over bond could handle notifications, would be great,
but I'm running out of ideas. So I thought I'd address veth first.
Your help and ideas are highly appreciated, thank you.
Alexandra
