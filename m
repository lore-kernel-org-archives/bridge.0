Return-Path: <ser@man.szczecin.pl>
References: <571F6F45.7070000@man.szczecin.pl>
	<CAOaVG17inj4fb8R42q5PTMPUtgS0SQHErZmoNEUGFsJeXFdB=A@mail.gmail.com>
From: Seweryn Niemiec <ser@man.szczecin.pl>
Message-ID: <5720BBCD.2070009@man.szczecin.pl>
Date: Wed, 27 Apr 2016 15:17:01 +0200
MIME-Version: 1.0
In-Reply-To: <CAOaVG17inj4fb8R42q5PTMPUtgS0SQHErZmoNEUGFsJeXFdB=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PROBLEM] mac address learned on wrong port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge <bridge@lists.linux-foundation.org>

On 26.04.2016 18:49, Stephen Hemminger wrote:
> This usualy happens when you either have a loop or packet leaks in from other port.

Yeah, it looks like a loop, but p2p1 is connected to a production network with 
running MSTP, so I was sure there is no loop, but I have double checked it today 
and I'm still sure there is no loop in the net outside of the server. To make it 
super sure I have connected p2p1 to a dead end port (vlan with this one port 
only) on a switch and the effect was the same - container's mac is learned on p2p1.

Could you explain what you mean by packet leaking in from other port?

I have one more clue:

when I do:

# arping -c1 ip-of-gateway

inside the container, then on host I can observe:

tcpdump -en -i vethV05BAQ ether src host 00:16:3e:aa:aa:66

14:57:17.528848 00:16:3e:aa:aa:66 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), 
length 42: Request who-has 212.14.1.33 tell 212.14.1.42, length 28
14:57:17.528915 00:16:3e:aa:aa:66 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), 
length 60: Request who-has 212.14.1.33 tell 212.14.1.42, length 46

Two packets of same content, but different sizes. Difference is a padding of eth 
frame to 64 bytes.

Does it mean something?

-- 
Best regards,
Seweryn Niemiec
