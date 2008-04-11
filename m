Message-ID: <47FFA849.7050103@navigue.com>
Date: Fri, 11 Apr 2008 14:04:57 -0400
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
References: <96CF49BD8B56384395D698BA99007FA32FA187@exchange.pacwire.local>
	<47E12A1B.9020201@navigue.com>
In-Reply-To: <47E12A1B.9020201@navigue.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.osdl.org
Cc: ebtables-user@lists.sourceforge.net

Hello Leigh and the lists,

I've had time to do some more tests on this today and here are my results.

First, I tried an ebtables rules as suggested by you and that link you 
offered:
  ebtables -t broute -A BROUTING -p 802_1Q -i in -j DROP

It did not seem to affect the issue at all, perhaps I did it wrong and 
would like some suggestions on that.

Now I figured I might try to find out exactly where the arp reply 
vanishes.  So I added this:

ebtables -t broute -A BROUTING -p arp --arp-opcode 2 --arp-mac-src 
00:18:18:62:3e:80 --arp-mac-dst 08:10:17:0D:70:61 --log

where 00:18:18:62:3e:80 is the gateway on the untagged (out) side of the 
bridge and 08:10:17:0D:70:61 is a host in vlan2 that never recieves its 
arp replies from the gateway as soon as I add in.3 to the bridge.

I added in.3 to the bridge, then I pinged 08:10:17:0D:70:61 from the 
outside (beyond the gateway) to have it arp the gateway.  Sure enough, I 
saw arp requests and replies on interface 'out' of the bridge but not in 
or in.2, as described in my previous post.

Here's what I got in the log:

Apr 11 11:56:18 bridgehost IN=out OUT= MAC source = 00:18:18:62:3e:80 
MAC dest = 08:10:17:0d:70:61 proto = 0x0806

Note the 'OUT=' field...  If things worked, I'd expect to see 'OUT=in.2' 
there.

So I put the bridge back in its 'working' state, removed 'in.3' so that 
I had only 'in.2' and 'out' as part of the bridge.

I ran another test and now the arp reply reached my host, it was able to 
reach the gateway and reply to my ping.  Time to check the logs...

Apr 11 11:59:03 ordralphabetix IN=out OUT= MAC source = 
00:18:18:62:3e:80 MAC dest = 08:10:17:0d:70:61 proto = 0x0806

Why don't I see 'OUT=in.2'.  If the arp reply reached my host, it 
obviously had to go through the bridge.  That is in the 'out' interface 
and out the 'in.2' interface.  It's pretty strange to me, I'd really 
like to know what's going on here.

Thanks a lot,

Jonathan
> Leigh Sharpe wrote:
>   
>> Hi Jonathan,
>>  Let me make sure I understand your situation properly:
>>
>> You have an interface on which you have two vlans:
>>
>> Vconfig add in 2
>> Vconfig add in 3
>>
>> You have created a bridge and assigned interface out and interface in.2
>> to the bridge:
>>
>> Brctl addbr br0
>> Brctl addif br0 out
>> Brctl addif br0 in.2
>> Ifconfig out up
>> Ifconfig in.2 up
>>
>> Then, when you add in.3 to the bridge with this command,
>>
>> Brctl addif br0 in.3
>>
>>   
>>     
> Correct until now.
>   
>> Things start to break, and devices connected to in.3 cannot talk to
>> devices on interface 'out'.
>>
>> Does this look correct?
>>
>>   
>>     
> No.  There are no devices connected to in.3 at all.  Devices connected 
> to in.2 stop being able to reach the gateway which is connected to 
> 'out'.  Actually, it's more a matter of being unable to ARP the gateway 
> connected to 'out'.  The arp request reaches the gateway, but the reply 
> never reaches the machine connected to in.2.  If the machine on in.2 
> already has the gateway's mac in its arp table, then it can talk to it 
> fine.  So far, the only thing that doesn't work with my setup is *arp 
> replies*.
>   
>> I'm presuming that the MAC of interest is 00:18:18:62:3e:80
>>
>> I suspect that your bridge is seeing this mac coming in, VLAN tagged, on
>> interface 'in', and is learning it on that interface, before you add
>> in.3 to the bridge. Once that happens, any replies coming in on
>> interface 'out' will not be sent to in.3, as they should.
>>
>>   
>>     
> That's interesting.  Interface 'in' is not part of the bridge however, 
> in.2 is (and at that point, in.3).  My assumption was that a 'vlan 
> interface' spits out packets untagged rather than the raw (tagged) 
> packets coming on the real physical interface, which would make logical 
> sense.
>
> Also of note is that I do see the reply show up on in.2 (you see it in 
> my tcpdump -i in.2 log) as it should be with tcpdump, so I don't think 
> the problem is that it goes to the wrong interface.  The problem is that 
> it doesn't come *out* of the physical interface at all, tagged or not, 
> onto the vlan trunk.  If it came out on vlan3 or untagged, I would still 
> see it.
>
> It shows up locally if I tcpdump -i in, but it never shows up on the 
> wire (tcpdump -i eth1 on a box connected to the trunk right next to the 
> bridge, no vlan switch involved, just a dumb hub acting as a repeater so 
> I can sniff the traffic).  And that is before it gets to any vlan-aware 
> switch.  So the problem at that point is not a matter of a switch not 
> knowing how to deal with this peculiar situation.
>
>
>               |   bridge   |       +-| 00:18:18:62:3e:80 & all other |
> gateway-|(out)|out-br0-in.2|(in)|-hub
>         |     |      +-in.3|    |  +-|(eth1)                         |
>         | linux box with bridge |    | linux box used to sniff trunk |
>
> The arp reply, from the gatway, shows up on 'in.2', it shows up on 'in', 
> but it never shows up on 'eth1'.  I seriously doubt the hub is smart 
> enough to notice that in.3 has been added to the bridge and suddently 
> stop passing *only* arp replies as I see all other traffic just fine. I 
> also see those arp replies when in.3 isn't part of the bridge.  So my 
> fair assumption is that the arp reply packets never make it onto the hub 
> at all.
>
> As far as I can tell, they vanish between 'in' and the hub.
>
>   
>> I recall reading somewhere that if you add an ebtables rule to 'in',
>> which drops all VLAN tagged packets, it will then be redirected to the
>> correct sub-interface (ie in.3). I envisage it would be something like 
>>
>> Ebtables -t broute -A BROUTING -p 8021_Q -I in -J DROP
>>
>>   
>>     
> I will give that a try for sure.  From reading the post you refer to, it 
> makes a bit of sense, but I'm not entirely sure it covers the whole 
> problem.  A problem such as what it refers to seems like it would affect 
> all traffic instead of just arp replies.
>
> Thanks a bunch, I will update you on my results with that ebtables rule 
> shortly.
>
> Jonathan
>   
>> Have a good look at this post if you need further details:
>>
>>  http://osdir.com/ml/linux.drivers.vlan/2006-07/msg00011.html
>>
>>
>> Hope this helps.
>> Regards,
>>              Leigh
>>  
>> Leigh Sharpe
>> Network Systems Engineer
>> Pacific Wireless
>> Ph +61 3 9584 8966
>> Mob 0408 009 502
>> Helpdesk 1300 300 616
>> email lsharpe@pacificwireless.com.au
>> web www.pacificwireless.com.au
>>
>>  

