MIME-Version: 1.0
In-Reply-To: <4B52011F.9020805@pandora.be>
References: <8cad0aa1001150016n46d622b4wd806440a84d91a54@mail.gmail.com>
	<4B51A8A0.2080202@pandora.be>
	<8cad0aa1001160948r37f19d43v3ab090110574e3d3@mail.gmail.com>
	<4B52011F.9020805@pandora.be>
Date: Sun, 17 Jan 2010 18:26:21 +0100
Message-ID: <8cad0aa1001170926n42bcdde1w48968e9335aa35b2@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Bridge] [ebtables]Explanation of the packet flow...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: bridge@lists.linux-foundation.org

>> Well, when a bridge is between two interfaces, this is quite the same
>> than saying it is forwarded from one to the other, in my point of
>> view. No ?
>>
>>
> The bridge indeed forwards the packets, not ebtables. You don't need
> ebtables for that unless you want to filter the traffic.

Well, let's take my example.
I have a bridge between eth0 and eth1. This bridge is stp disabled,
and the ebtables filter table accepts input, forward and output.

I didn't specify any filtering rule.
When I send a packet (LACP for me), it is not going from one eth to the other.
I have to say, explicitly, that the packet with ethertype 0x8809 are
accepted in "forward".

This is why I have some difficulties understanding the packetFlow,
because, depending on the protocol, the behaviour doesn't seem to be
the same...

Regards,
JM
