Message-ID: <4BB0736F.9020300@pandora.be>
Date: Mon, 29 Mar 2010 11:31:27 +0200
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <OFB9EFBBE7.11608167-ONC12576F1.005B0C79-C12576F1.005BBE51@transmode.se>	<4BABCF8A.3040701@free.fr>	<OFDD80C4DC.137F4F61-ONC12576F2.002B1EE4-C12576F2.002B7EA6@transmode.se>	<4BAD1B85.6020807@free.fr>	<OFC6D98D54.CA7D4A8D-ONC12576F2.007212B2-C12576F2.00725708@transmode.se>	<2e59e6971003261442g77365b55sa624fe184e5003ac@mail.gmail.com>	<OFCA30CFD8.BFEED34E-ONC12576F3.003AD4F7-C12576F3.003B8B77@transmode.se>
	<20100327201752.51b6f7ad@nehalam> <4BAF5034.5060100@pandora.be>
	<OFDC6DBFAF.3C46B16B-ONC12576F4.00654457-C12576F4.00655D53@LocalDomain>
	<OF59D1A758.6E7DFF8C-ONC12576F4.0068613D-C12576F4.0068C11D@LocalDomain>
	<OF66063C34.9F68251B-ONC12576F5.0025FFA1-C12576F
	<4BB05AE7.10905@pandora.be> <OF35408968.E095E27C-ONC12576F5.
	<4BB06A0E.9000705@pandora.be>
	<OF0323A301.381F1C71-ONC12576F5.0030C5A5-C12576F5.00316BBA@transmode.se>
In-Reply-To: <OF0323A301.381F1C71-ONC12576F5.0030C5A5-C12576F5.00316BBA@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] IP address on physcial interface instead of bridge
	interface?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org

Joakim Tjernlund wrote:
> Bart De Schuymer <bdschuym@pandora.be> wrote on 2010/03/29 10:51:26:
>> Joakim Tjernlund wrote:
>>> Bart De Schuymer <bdschuym@pandora.be> wrote on 2010/03/29 09:46:47:
>>>> Joakim Tjernlund wrote:
>>>>> Joakim Tjernlund/Transmode wrote on 2010/03/28 21:04:11:
>>>>>> Joakim Tjernlund/Transmode wrote on 2010/03/28 20:27:10:
>>>>>>> Bart De Schuymer <bdschuym@pandora.be> wrote on 2010/03/28 14:48:52:
>>>>>>>> Stephen Hemminger schreef:
>>>>>>>>> If you read the network receive code path in the kernel, you
>>>>>>>>> will see that there is a special hook used. Basically,
>>>>>>>>>
>>>>>>>>>   if received_interface_is_part_of_bridge(incoming_interface)
>>>>>>>>>   then process_bridged_packet(packet)
>>>>>>>>>
>>>>>>>>> Then bridge looks at packet and decides whether it is local or forwarded.
>>>>>>>>> The problem is with your application if it wants to use eth0 directly.
>>>>>>>>>
>>>>>>>>>
>>>>>>>> The ebtables brouting chain was designed to enable you to do this.
>>>>>>> Can you give me an example?
>>>>>> Found this on the net:
>>>>>> ebtables -t broute -A BROUTING -p 0800  -i eth1 --ip-dst 192.168.1.16 -j DROP
>>>>>> ebtables -t broute -A BROUTING -p 0806  -i eth1 -d 00:06:9C:00:B2:FB -j DROP
>>>>>> ebtables -t broute -A BROUTING -p 0806  -i eth1 --arp-ip-dst 192.168.1.16 -j DROP
>>>>>>
>>>>>> 192.168.1.16 and 00:06:9C:00:B2:FB are the IP and MAC addresses of eth1.
>>>>>>
>>>>>> Then add eth1 to the bridge and it appears to be working as I want.
>>>>>> Are there any "gotcha's" with this method?
>>>>> What about other protocols such as pppoe and OSPF, will these work over eth1 too?
>>>>> Are outgoing pkgs from the host bridged or just sent out over eth1?
>>>>>
>>>>>     Jocke
>>>> The ebtables rules in the brouting chain see all traffic arriving on the
>>>> bridge port (currently unless the port is in learning state). So as long
>>>> as your setup is correct it should work with pppoe and OSPF too.
>>> Ah good. So the outgoing traffic will go out over the bridge port too and
>>> thereby be bridged?
>> If you want the ingoing traffic to go through eth1 I assume you want the
>> accompanying outgoing traffic to go through eth1 too. Your routing table
>> should be routing 192.168.1.0/24 to eth1. If this is not how you want it
>> to work, please explain.
> 
> I want eth1 to act as if was br0. Instead of having to set an IP address
> on br0 and eth1 to 0.0.0.0 I want to keep the IP address on eth1 and br0
> should be 0.0.0.0.

OK, that's how it will work. But note that this means the outbound IP
and ARP traffic isn't bridged.

>>> Still I wonder about OSPF. This protocol sends pks to multicast IP address
>>> 224.0.0.5/6 so how are these picked up by the broute rule?
>>>
>>> How is pppoe picked up by the broute rule? The ethertype is different from ipv4
>>> so I don't understand how it manages to do that.
>>>
>> You'll need additional ebtables rules.
> 
> Ah, but say I add
>  ebtables -t broute -A BROUTING -p 0800  -i eth1 --ip-dst 224.0.0.5 -j DROP
> then only the host receives these pkgs and the other members
> in the bridge wont get the multicast pkg?

Yes. I guess an ebtables module like the iptables TEE target could help
here, but it's not implemented.

But there's probably an easier solution to your problem: just never use
eth1 directly.
The case where you don't have a bridge is then replaced by using a
bridge (br0) with only one port member: eth1. The second case is then
simply achieved by adding another port to the bridge. All your
applications always use br0 as interface. This will have some inpact on
speed, though, because the incoming traffic is queued twice.

cheers,
Bart


-- 
Bart De Schuymer
www.artinalgorithms.be
