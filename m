Message-ID: <4B534D4A.3020707@pandora.be>
Date: Sun, 17 Jan 2010 18:47:54 +0100
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <8cad0aa1001150016n46d622b4wd806440a84d91a54@mail.gmail.com>	
	<4B51A8A0.2080202@pandora.be>	
	<8cad0aa1001160948r37f19d43v3ab090110574e3d3@mail.gmail.com>	
	<4B52011F.9020805@pandora.be>
	<8cad0aa1001170926n42bcdde1w48968e9335aa35b2@mail.gmail.com>
In-Reply-To: <8cad0aa1001170926n42bcdde1w48968e9335aa35b2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [ebtables]Explanation of the packet flow...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: bridge@lists.linux-foundation.org

Jean-Michel Hautbois schreef:
>>> Well, when a bridge is between two interfaces, this is quite the same
>>> than saying it is forwarded from one to the other, in my point of
>>> view. No ?
>>>
>>>
>>>       
>> The bridge indeed forwards the packets, not ebtables. You don't need
>> ebtables for that unless you want to filter the traffic.
>>     
>
> Well, let's take my example.
> I have a bridge between eth0 and eth1. This bridge is stp disabled,
> and the ebtables filter table accepts input, forward and output.
>
> I didn't specify any filtering rule.
> When I send a packet (LACP for me), it is not going from one eth to the other.
> I have to say, explicitly, that the packet with ethertype 0x8809 are
> accepted in "forward".
>
> This is why I have some difficulties understanding the packetFlow,
> because, depending on the protocol, the behaviour doesn't seem to be
> the same...
>
>   
You don't provide enough information for us (at least for me) to tell
you what's wrong. It's probably something as simple as changing the
default policy of the FORWARD chain from DROP to ACCEPT. Just rmmod the
ebtables kernel module if you don't need it...

Bart

-- 
Bart De Schuymer
www.artinalgorithms.be

