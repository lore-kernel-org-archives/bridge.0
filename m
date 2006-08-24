Message-ID: <44EE22AB.1090903@dotr.com>
Date: Thu, 24 Aug 2006 23:05:31 +0100
From: Julian Lyndon-Smith <asterisk@dotr.com>
MIME-Version: 1.0
References: <44EDE259.4050009@dotr.com> <44EE094C.5080803@volunteermatch.org>
In-Reply-To: <44EE094C.5080803@volunteermatch.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] transparent bridge and proxies
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Melissa Meyer <melissa@volunteermatch.org>
Cc: bridge@lists.osdl.org

Thanks Melissa for responding

I was trying to play with physdev.

Ignoring all the inbound stuff, if I was on the console of this machine 
(Mybox)
                     MyBox
                +-----br0----+
                |            |
router<--->eth0+            +eth1<--->Lan

Where br0, eth0 and eth1 had no ip address, and I wanted to "yum update" 
  (which I presume uses port 80) what rules would I need to put in place 
? I was looking for something to do with 127.0.0.1 (the lo interface) 
and eth0.

If I got that to work, the squid proxy should automatically follow, no ?

Julian

Melissa Meyer wrote:
> 
> In the 2.6 kernel, there's an iptables module called physdev to match 
> the bridge's physical in and out devices so something like:
> 
> iptables -A FORWARD -m physdev -p tcp --dport 25
> --physdev-in eth0 -j ACCEPT
> 
> to allow smtp traffic through.
> 
> 
> Julian Lyndon-Smith wrote:
>> I want to be able to install a box that is a transparent bridge, but 
>> that is also running a transparent proxy, but with a twist ..
>>
>> i am a newbie in all things linux, so bear with me :)
>>
>> So far I have managed to install centos 4.3, and following various 
>> guides on the net, created a bridge between eth1 (connected to lan) and 
>> eth0 (connected to router). That works great.
>>
>> I also managed to install squid, get it running transparently and added 
>> a rule to iptables to make all that work just fine. So now, all my 
>> clients attached to the lan run through the squid proxy without them 
>> knowing.
>>
>> Now, for the twist. For development and testing, I assigned an ip 
>> address and gateway to the bridge. I need to be able for a "non-it" 
>> person to install this box without having to set it up at all , so it 
>> cannot have an ip address assigned, as it *may* be in use somewhere else 
>> on the lan or router.
>>
>> So, I changed the ip address to 0.0.0.0. Everything except squid still 
>> worked. I presume that's because it does not know how to route the data 
>> to get stuff.
>>
>> Can I add a rule to iptables or something to say "anything that's come 
>> from eth1 into the local box, after processing send to eth0" and 
>> vice-versa ?
>>
>> Julian.
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.osdl.org
>> https://lists.osdl.org/mailman/listinfo/bridge
>>   
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
> 
> 

