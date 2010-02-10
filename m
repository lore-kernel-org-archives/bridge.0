Message-ID: <4B731C01.6030104@interware.hu>
Date: Wed, 10 Feb 2010 21:50:09 +0100
From: Tamas Csillag <tcsillag@interware.hu>
MIME-Version: 1.0
References: <mailman.866.1251832314.18889.bridge@lists.linux-foundation.org>	
	<4B719997.5060700@interware.hu>
	<2e59e6971002091025p7cebdf47vbd4fdee31cad088e@mail.gmail.com>
In-Reply-To: <2e59e6971002091025p7cebdf47vbd4fdee31cad088e@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bnx2 doesn't transmit BPDU or Blade switches don't
 forward, them?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Yes, server1 has bridging enabled, br0 contains interfaces eth0 and 
eth1. STP enabled, port cost 4 for both ports, bridge priority 65535.
Yesterday i tested the same setup with e1000 cards instead of bnx2 
cards, same results.

If i lower the bridge priority on server1 to 2048, both switches 
recognize server1 as the root bridge, and if i connect another server 
(server2) in the same arrangement, priority 65535, it sees server1 as root.

Tamas


richardvoigt@gmail.com wrote:
> On Tue, Feb 9, 2010 at 11:21 AM, Tamas Csillag <tcsillag@interware.hu> wrote:
>> Hi!
>>
>> I'm faced with the same problem, and i'm not sure if it's a driver or
>> bridge problem.
>> I'm using 2 switches, connected on port16.
>>
>>  switch1-----switch2-----router
>>       \       /
>>        \     /
>>        server1
>>
>> Switch1 bridge priority: 4096
>> Switch2 bridge priority: 5120
>> Default bridge priority on servers: 65535
>>
>> If the switches are connected, STP forms just nice, switch1 becomes
>> root. If i disconnect the switch-switch cable, switch1 remains root, the
>> servers see switch1 as root, but switch2 declares itself as root. Guess
>> it's not receiving BPDU packets from the servers. If more than one
>> server is connected to both switches, loop forms, network goes down.
> 
> I guess the node you've labelled "server1" has bridging enabled?  Is
> STP enabled on the software bridges?  Bridges with STP disabled often
> eat BPDUs, which sounds like the symptom you're seeing.
> 
>> If i lower the bridgeprio on server1 to 2048, everybody accepts it as
>> the new root bridge, even switch2.
>>
>> I tested the switches, they play STP nicely in a mixed-vendor environment.
>>
>> Is it possible that the bridge/bnx2 don't propagate BPDUs from switch1
>> to switch2, while still receiving and transmitting BPDUs?
>>
>>
>> Regards,
>> Tamas
>>
>>
>> --
>> Tamas CSILLAG
>> IT consultant
>>
>> A+ Server+ MCSA CCNA
>> JNCIA JNCIS 3DP APS
>> DCCA BAIS QFCA
>>
>> tcsillag@interware.hu
>> +36 30 288 5488
>>
>>
>> -----Diego Woitasen wrote:
>>
>> Date: Sun, 30 Aug 2009 20:10:32 -0300
>> From: Diego Woitasen <diegows@xtech.com.ar>
>> Subject: [Bridge] bnx2 doesn't transmit BPDU or Blade switches don't
>>        forward them?
>> To: Bridge@lists.linux-foundation.org
>> Message-ID:
>>        <b10f571a0908301610v246a7ce2v8d43a98fda2242cd@mail.gmail.com>
>> Content-Type: text/plain; charset=ISO-8859-1
>>
>> Hi,
>>  I have two Blades in one enclosure. They receive the same VLAN trunk
>> to bridge the VLANs and I want to have two bridges enabled in each
>> server. I've configured the bridge and enabled STP but I don' t see
>> the BPDU multicast incoming from the interface (I see the outging
>> packets).
>>
>> xen198:~# tcpdump -i peth0 -enn ether dst 0180c2000000
>> tcpdump: WARNING: peth0: no IPv4 address assigned
>> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
>> listening on peth0, link-type EN10MB (Ethernet), capture size 96 bytes
>> 20:07:27.150902 00:23:7d:37:1a:82 > 01:80:c2:00:00:00, 802.3, length
>> 52: LLC, dsap STP (0x42) Individual, ssap STP (0x42) Command, ctrl
>> 0x03: STP 802.1d, Config, Flags [none], bridge-id
>> 0001.00:23:7d:37:1a:82.8001, length 35
>> 20:07:29.150876 00:23:7d:37:1a:82 > 01:80:c2:00:00:00, 802.3, length
>> 52: LLC, dsap STP (0x42) Individual, ssap STP (0x42) Command, ctrl
>> 0x03: STP 802.1d, Config, Flags [none], bridge-id
>> 0001.00:23:7d:37:1a:82.8001, length 35
>> 20:07:31.150879 00:23:7d:37:1a:82 > 01:80:c2:00:00:00, 802.3, length
>> 52: LLC, dsap STP (0x42) Individual, ssap STP (0x42) Command, ctrl
>> 0x03: STP 802.1d, Config, Flags [none], bridge-id
>> 0001.00:23:7d:37:1a:82.8001, length 35
>>
>> xen199:~# tcpdump -i peth0 -enn ether dst 0180c2000000
>> tcpdump: WARNING: peth0: no IPv4 address assigned
>> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
>> listening on peth0, link-type EN10MB (Ethernet), capture size 96 bytes
>> 20:07:35.115593 00:23:7d:37:08:78 > 01:80:c2:00:00:00, 802.3, length
>> 52: LLC, dsap STP (0x42) Individual, ssap STP (0x42) Command, ctrl
>> 0x03: STP 802.1d, Config, Flags [none], bridge-id
>> 0002.00:23:7d:37:08:78.8001, length 35
>> 20:07:37.115618 00:23:7d:37:08:78 > 01:80:c2:00:00:00, 802.3, length
>> 52: LLC, dsap STP (0x42) Individual, ssap STP (0x42) Command, ctrl
>> 0x03: STP 802.1d, Config, Flags [none], bridge-id
>> 0002.00:23:7d:37:08:78.8001, length 35
>> 20:07:39.115613 00:23:7d:37:08:78 > 01:80:c2:00:00:00, 802.3, length
>> 52: LLC, dsap STP (0x42) Individual, ssap STP (0x42) Command, ctrl
>> 0x03: STP 802.1d, Config, Flags [none], bridge-id
>> 0002.00:23:7d:37:08:78.8001, length 35
>>
>> Blade MACs are:
>> 00:23:7d:37:08:78
>> 00:23:7d:37:1a:82
>>
>> Is there some issue with bnx2 or Blade switches and Linux bridge?
>>
>> Regards,
>>  Diego
>> --
>> Diego Woitasen
>> XTECH
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>>
> 

