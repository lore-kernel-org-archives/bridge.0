Message-ID: <003101c6378b$f5f65060$4a27b3d5@tungemaskin>
From: =?UTF-8?Q?J=C3=B8rgen_Hovland?= <jorgen@hovland.cx>
References: <01f701c63728$6203bef0$4a27b3d5@tungemaskin>
	<20060221141743.32d66879@localhost.localdomain>
Subject: Re: [Bridge] physical interface on a bridge
Date: Wed, 22 Feb 2006 09:42:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; format="flowed"; charset="utf-8"; reply-type="original"
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org


----- Original Message ----- 
From: "Stephen Hemminger" <shemminger@osdl.org>


> On Tue, 21 Feb 2006 21:50:00 +0100
> Jørgen Hovland <jorgen@hovland.cx> wrote:
>
>> Hi
>>
>> Is there a way to either:
>> Find the real ifindex/ifname a mac-address is bound to
>> or
>> Find the real ifindex/ifname of an incoming packet
>> ?
>>
>> I am writing a dhcp server and need to know what real interface the dhcp 
>> request packet came from. An acceptable solution would be to get the 
>> interface by the mac-address, but that can be faked so I would rather get 
>> the interface by knowing where the data actually came from. Data is IP, 
>> UDP broadcast.
>> I _could_ use raw sockets. The problem is when I do that, the program is 
>> using ~8% cpu on a 3.2ghz xeon64 just reading packets without doing 
>> anything due to the amount of traffic passing through the box (~200mbit 
>> and increasing) so that doesn't look like a good idea.
>
> Why should the app care. If forwarding database is working correctly, the 
> source mac
> of the incoming packet will be in the list and any response to it will go 
> out that interface.
>

Well there is no guarantee that the source mac isn't faked. Additionally, 
the hardware address of the dhcp client is put inside a dhcp-packet, which 
also can be faked. So I am stuck with two hardware addresses that I am 
suppposed to believe are correct but have no information about where I 
originally received them from.
I can live with this (I guess all the other dhcp servers do that too), but I 
can't find a way to map a hardware address to a physical interface when 
using bridgemode. I need to know this because the dhcp server will be 
limiting the amount of leases you can get per interface (eg max 5 ips per 
interface). It will also be assigning static IP-addresses based on what 
interface the dhcp packet came from. I will also be using iptables to only 
permit the IP+MAC traffic to/from the real physical interface so if you 
don't use dhcp at all times, the traffic won't be permitted.


>
>> brctl showmacs returns a list of port numbers, but they dont make much 
>> sense to me. They do not seem to be in the same order I added the 
>> interfaces? Is there a mapping here?
>>
>> Example,
>> jorgen@ams41:/$ /tmp/brctl showmacs test0
>> port no mac addr                is local?       ageing timer
>>   2     00:04:e2:a8:3b:d7       no                 0.24
>>   1     00:08:a1:85:39:fd       no                17.31
>> 133     00:0d:88:a3:61:4a       no                 9.90
>>   1     00:14:22:b0:cd:e0       yes                0.00
>> 133     00:16:c7:f5:8f:e2       no                 0.48
>>
>> Port 133 is the 901'th interface (0x385) I added to bridge test0. What 
>> does 133 point to?  The ifindex of this physical interface is 912 (0x390) 
>> (retrieved with SIOCGIFINDEX).
>
> Arbitrary index assigned by bridge for STP usage. Slots get reused as 
> ports are deleted and added.

So there is no way to get the physical interface from a mac address? Is 
there any way at all? Do you plan to add this functionality?
Would you accept a patch if I were to submit any (I can't guarantee anything 
atm) ?
As an example, Cisco IOS support mac lookup just fine.

>
>>
>> Secondly,
>> I seem to be unable to add more than around 1024 interfaces to a single 
>> bridge. Is there a way to increase this limit?
>
> Increase BR_PORT_BITS (you can go up to 15) but you will lose priority 
> bits on the spanning tree.
> Also, why? You performance is going to start to fall off with so many 
> interfaces.  Can't you
> partition to multiple machines?

Perhaps it would be better to split it into multiple bridges. I was planning 
on having 1 bridge per router, and one router will have ~3000 interfaces. I 
will reconsider this. Thank you.

Joergen 

