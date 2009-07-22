Message-ID: <4A67795F.2030906@ipfire.org>
Date: Wed, 22 Jul 2009 22:41:03 +0200
From: Michael Tremer <michael.tremer@ipfire.org>
MIME-Version: 1.0
References: <4A6638A5.208@ipfire.org> <4A668C49.7080209@superduper.net>
In-Reply-To: <4A668C49.7080209@superduper.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridging untagged and tagged VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Simon Barber <simon@superduper.net>, bridge@lists.linux-foundation.org

Well, I think the kernel patch is the easier way, but ebtables is more easy.

So I tried with the following command:
ebtables -t broute -A BROUTING -p 802_1Q -i eth0 -j DROP

Then, the VLAN 30 and the untagged (V)LAN can be bridged (Well I tried 
it with
arping -I br0 192.168.181.1 and got a MAC from the machine 192.168.181.1 
on VLAN 30).

But I still cannot do the following:

brctl addbr br0
brctl addif br0 eth0

brctl addbr br1
brctl addif br1 eth0.30

br0 works.
br1 doesn't work. Not even ARP.
ebtables rule was set.

Any ideas?!

Thanks for the great help up to now.

Michael


Simon Barber wrote:
> To do this seamlessly you need a VLAN aware bridge - the kernel has 
> separate support for VLAN and bridging, but not integrated. I posted a 
> patch a while back to fix this - see here:
>
> http://www.mail-archive.com/bridge@lists.osdl.org/msg01440.html
>
> It was for a 2.4 kernel, but shouldn't take too much work to port to 2.6.
>
> Simon
>
>
> Michael Tremer wrote:
>> Hello everybody,
>> I got a weird problem but don't know if it is expected to work.
>>
>> brctl addbr br0
>> vconfig add eth0 30
>> brctl addif br0 eth0.30
>>
>> Until here, everythink works well... I can access the VLAN with id 30.
>> But when I run the following:
>>
>> brctl addif br0 eth0
>>
>> Then, I can't access the VLAN any more but the untagged LAN.
>> But instead of adding eth0:
>>
>> vconfig add eth0 40
>> brctl addif br0 eth0.40
>>
>> It works.
>>
>> It would be nice if you can me give a short advice...
>> Is it not possible to bridge an untagged LAN with a tagged VLAN or
>> is this a bug?
>>
>> Sincerely,
>>
>> Michael
>>
>> Kernel 2.6.29, brctl 1.4
>>
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>>   
>

