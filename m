Subject: Re: [Bridge] Bridge not working on arm embedded platform
From: Bart De Schuymer <bdschuym@pandora.be>
In-Reply-To: <34d8b2fe050531121736623672@mail.gmail.com>
References: <34d8b2fe05053002387a1942bf@mail.gmail.com>
	<20050531094024.75098a16@dxpl.pdx.osdl.net>
	<34d8b2fe050531121736623672@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 07:03:40 +0000
Message-Id: <1117609420.3384.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Louis Croisez <louis.croisez@gmail.com>
Cc: bridge@lists.osdl.org, Stephen Hemminger <shemminger@osdl.org>

Op di, 31-05-2005 te 21:17 +0200, schreef Louis Croisez:
> I am currently debugging. To have idea of where is the network packet
> in the stack, I use the ebtables/iptables log feature, that show the
> traject of a packet.
> Here is the result of my last test.
> Goal:
>             [PC_A] ping [PC_B] thru [ARM].
> Result:
>             icmp request is even not sent, because first an arp
> request is broadcast on the lan to resolve PC_B hw address. Problem is
> that this arp request never reach PC_B. It is stopped inside ARM.
> Here is the path followed by this packet:
> ebt:BRoute:BRouting
> ebt:Nat:PreRouting
> ipt:Mangle:PreRouting
> ipt:Nat:PreRouting
> ebt:Filter:Input
> 
> I don't understand this behavior of the Bridgin Decision... The arp
> request is a broadcast. It should  not be kept only by br0.
> 
> To workaround this, I have set br0 to promisc mode.
> The result of the test is the following:
> ebt:BRoute:BRouting
> ebt:Nat:PreRouting
> ipt:Mangle:PreRouting
> ipt:Nat:PreRouting
> ebt:Filter:Input
> ebt:Filter:Forward
> ipt:Mangle:Forward
> ipt:Filter:Forward
> ebt:Nat:PostRouting
> 
> The packet is stopped here. I don't know why!!
> 
> I feel there is a config problem, because it cannot be a bridge source
> problem, or a bug.
> I thing about some /proc configuration related to arp. Do you have an
> idea?

Just my 2 cents: make sure arptables doesn't drop the ARP packets...

cheers,
Bart


