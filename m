Message-ID: <4B52011F.9020805@pandora.be>
Date: Sat, 16 Jan 2010 19:10:39 +0100
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <8cad0aa1001150016n46d622b4wd806440a84d91a54@mail.gmail.com>	
	<4B51A8A0.2080202@pandora.be>
	<8cad0aa1001160948r37f19d43v3ab090110574e3d3@mail.gmail.com>
In-Reply-To: <8cad0aa1001160948r37f19d43v3ab090110574e3d3@mail.gmail.com>
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
> 2010/1/16 Bart De Schuymer <bdschuym@pandora.be>:
>   
>> Jean-Michel Hautbois schreef:
>>     
>>> Hi everybody !
>>>
>>> I am trying to understand the "PacketFlow.png" image from the website.
>>> I have several misunderstanding, especially on the "Bridging Decision" circles.
>>>
>>> I would like to understand which way a packet takes when the rule on
>>> -A INPUT -j ACCEPT is on, for example. When looking at the packet
>>> flow, I would say it is going to the "routing decision" circle, but, I
>>> am not sure...
>>>
>>>
>>>       
>> It is handed to the IP layer, which includes a routing decision.
>>     
>
> But this is only true for L3 layer ?
> Or routing decision is at a L2 level, in order to decide whether to
> bridge should route a packet up to the IP layer or not. That's it ?
>
>   
The packet flow picture describes the detailed IP packet flow. This is
clearly mentioned in the accompanying document. If you don't know on
what layer routing is done, please try looking it up.
>>> I would also like to understand what is necessary in order to have a
>>> packet transparently directed from one interface to the other. I would
>>> say that only the "-A FORWARD -j ACCEPT" rule is necessary, but
>>> Wireshark doesn't agree with me...
>>>
>>>
>>>       
>> Ebtables is used to filter bridged traffic. You can't use ebtables to
>> direct a packet to another interface.
>>     
>
> Well, when a bridge is between two interfaces, this is quite the same
> than saying it is forwarded from one to the other, in my point of
> view. No ?
>
>   
The bridge indeed forwards the packets, not ebtables. You don't need
ebtables for that unless you want to filter the traffic.

Bart

-- 
Bart De Schuymer
www.artinalgorithms.be


