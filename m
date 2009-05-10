Message-ID: <4A06F520.3060304@free.fr>
Date: Sun, 10 May 2009 17:39:12 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>
	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>
	<49FF4AF8.1050801@free.fr> <49FF58EC.2090902@gmail.com>
	<49FFDABF.4030500@free.fr> <4A007103.4010501@gmail.com>
	<4A00B327.6080705@free.fr> <4A01BF38.4080704@gmail.com>
	<4A01EDEA.8040106@free.fr> <4A056646.5050909@gmail.com>
In-Reply-To: <4A056646.5050909@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Cc: bridge@lists.linux-foundation.org

Jochen Hebbrecht wrote:
> I had a "chat" with somebody of the support site of Linksys. The WRT54GS 
> enables WDS. So we can say this is my problem. My wifi adapter is a WMP54G

OK. Until the driver for this adapter support WDS, it would be 
impossible to bridge between Ethernet and Wifi.

>> If that fail, I think we have two options :
>>
>> - Try to setup a very special bridge configuration, with some sort of 
>> masquerading of the MAC address. This would require at least to use 
>> ebtables to replace the source MAC address in the header (and in the 
>> payload for ARP) of packets sent on the wifi interface, to route 
>> packets in the server, to stop the server from sending ICMP redirect 
>> in the wifi interface and to setup a proxy_dhcp on the server. It 
>> would be hard to setup, hard to debug and impossible to maintain... 
>> Probably not a good idea... Funny to try, but not a good target.
> This really sounds like Chinese in my ears :-D

It is ! :-D

 From a theoretical point of view, it is possible to build such a setup, 
but really, you should keep away from that. I didn't tested it and won't 
have enough time to support you on this way.

>> - Setup a simple router configuration on the server, using another 
>> private subnet on location B. Using a simple NAT/Masquerading 
>> configuration (with iptables), it could be possible to hide the subnet 
>> of location B from location A, but still allow access to the printer 
>> of location B from location A and access to location A and to Internet 
>> from location B. If you don't have a really good reason to stick to 
>> bridge (like using a non-IP protocol), I suggest you try this.

> I was thinking on this situation too. But how will be somebody in subnet 
> A able to reach someone of subnet B? We are gonna have to change the 
> routing tables on the client side too?

Yes, you are right.

If the network you are talking about is your home network (not a company 
network), why don't you create a different subnet for both location 
(let's say 192.168.0.0/24 and 192.168.1.0/24) ? You just need to add a 
static route to the subnet of location B, through UBUNTU SERVER, in the 
main router at location A. In location B, you need to setup every hosts 
to use UBUNTU SERVER as the default route.

If you don't have access to the routing table of the main router in 
location A, you can try to run a ripd daemon in UBUNTU SERVER, to inform 
the main router of location A that UBUNTU SERVER is a router to the 
subnet of location B. You can find ripd in the quagga package, for 
example. (The documentation is in the quagga-doc package).

It would be by far the simplest way to achieve your goal.

	Nicolas.
