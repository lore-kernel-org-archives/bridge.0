Message-ID: <4A66C14C.4090300@ipfire.org>
Date: Wed, 22 Jul 2009 09:35:40 +0200
From: Michael Tremer <michael.tremer@ipfire.org>
MIME-Version: 1.0
References: <4A6638A5.208@ipfire.org> <4A668C49.7080209@superduper.net>
In-Reply-To: <4A668C49.7080209@superduper.net>
Content-Type: text/plain; charset=ISO-8859-1
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
To: simon@superduper.net
Cc: bridge@lists.linux-foundation.org

Thanks for your answers.

In this mail on
http://www.mail-archive.com/bridge@lists.osdl.org/msg01440.html
there is the following sentence: "- Add native support for an untagged
vlan.  Currently an untagged
  vlan can be implimented using ebtables or similar."

Do you know how to do this? Seems to be the easiest way for me, because
I don't
think that I would be able to port this patch to 2.6. (But may be there
is somebody who
would like to do this. I want to put all these things into a linux
firewall www.ipfire.org, though there
is an efford for the open source community.)

Have you ever submitted this patch to the kernel developers?

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

