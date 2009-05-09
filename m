MIME-Version: 1.0
In-Reply-To: <20090508204233.4aaed9ec@nehalam>
References: <de7adc5e0905081431v58989abch5e7271de302afd99@mail.gmail.com>
	<20090508155418.7acc7fbf@nehalam>
	<de7adc5e0905081620s69f3e874xa50636b0b6fc65d3@mail.gmail.com>
	<20090508162719.6cbc3022@nehalam>
	<de7adc5e0905081808h43e5ef84m113c4dd868077bf1@mail.gmail.com>
	<20090508204233.4aaed9ec@nehalam>
Date: Sat, 9 May 2009 00:34:11 -0600
Message-ID: <de7adc5e0905082334t25b9e645mdbd1878ce0f8d6db@mail.gmail.com>
From: Daniel Robbins <drobbins@funtoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] 2.6.27: persistent MAC assignment to bridge not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org, "Pavel V. Emelianov" <xemul@sw.ru>

OK, I think I understand:

The MAC of the bridge is what the bridge uses to communicate with
other machines on the LAN, an IP address has been assigned to the
bridge. So the bridge's MAC setting affects the contents of the ARP
replies that are sent out from the Linux host.

When an external machine sends traffic to the Linux host, the MAC of
the bridge (in the external machine's ARP cache) must match one of the
Linux host's slave interfaces, so that the incoming traffic bound for
the Linux host is processed locally and funnels up from layer 2 to
layer 3.

If the bridge were configured with a MAC address that was not also the
MAC of one of the slave interfaces, the layer 2 traffic will remain in
layer 2 and will be forwarded to the other slave interfaces, so that
it can find its final destination, which is presumably not on the
local Linux host.

So having the bridge use a MAC from one of the slave interfaces allows
the bridge to "catch" the traffic that would otherwise be forwarded.

So the important thing from my particular use of bridging is that:

1) My bridge should use a MAC of one of the slave interfaces

2) I should ensure the MAC is "sticky" so that adding/removing
interfaces from the bridge does not cause the MAC to change and thus
invalidate the ARP caches on external machines, resulting in an
intermittent pause in network activity until the external machine's
ARP cache is updated with the new MAC address.

Does this sound right?

-Daniel

On Fri, May 8, 2009 at 9:42 PM, Stephen Hemminger <shemminger@vyatta.com> wrote:
> On Fri, 8 May 2009 19:08:06 -0600
> Daniel Robbins <drobbins@funtoo.org> wrote:
>
>> Your code in 2.6.27 works perfectly.
>>
>> Let me tell you what I was doing wrong, and if you could tell me why
>> it didn't work, I'd really appreciate it :) (Might also be a good
>> addition to the Net:Bridge FAQ):
>>
>> # brctl addbr br0
>> # brctl addif br0 eth0
>> # ifconfig br0 10.0.1.220 netmask 255.255.255.0
>> # brctl addif br0 veth100.0
>> # brctl addif br0 veth102.0
>>
>> Now, the zinger:
>>
>> # ifconfig br0 hw ether "12:34:56:78:90:ab"
>>
>> ^^ By using a unique MAC address, this command totally disables my
>> bridge, and the machine can no longer send or receive data.
>>
>> If I use a MAC that is already in use by my bridge's sub-interfaces,
>> however, (ie. from eth0, veth100.0 or veth102.0) then there's no
>> problem, and everything works, and the MAC address is sticky as it
>> should be.
>>
>> So this was the mistake I was making - I was using a user-generated
>> MAC for my testing rather than choosing a MAC from one of the bridge's
>> interfaces.
>>
>> So, my question is: why doesn't a user-generated MAC work? On the
>> surface, it seems like all devices on the same LAN should have
>> different MAC addresses. Yet, with Linux bridging, it appears that (at
>> least in certain conditions, like if there is an IP assigned to the
>> bridge,) then the bridge *must* share a MAC with one of its
>> sub-interfaces in order to function properly. This is very
>> counter-intuitive and a mystery to me and probably quite a few other
>> bridging newbies (which is why an explanation would make a great
>> addition to the Net:Bridge FAQ :)
>
> The problem is that the bridge only thinks a packet is "local" if
> it arrives with destination hw addr == incoming device address.
>
