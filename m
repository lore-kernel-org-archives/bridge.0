Message-ID: <4BD05EA2.1040709@kpi.ua>
Date: Thu, 22 Apr 2010 17:35:14 +0300
From: Yavetskiy Yuriy <yavetskiy@kpi.ua>
MIME-Version: 1.0
References: <4BCC12FD.9060802@kpi.ua>
In-Reply-To: <4BCC12FD.9060802@kpi.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] 10 gigabit linux bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Ignore my problem, it works fine on centos.


> Hello.
>
> I'm using 10 Gigabit Ethernet cards Intel 82598EB.When I use them for 
> routing, everything is OK.But when I tried to add them to bridge several 
> problems occured.I had already configured bridge from 2 gigabit Ethernet 
> cards intel 82576. I added a single 10-Gigabit interface in there and 
> got following result:
> - packets are going from gigabyt to gigabyt port without any problems
> - packets are coming ang going from 10 gigabyt to gigabyt port(ARP 
> request is seen by tspdamp on destination), but the arp response does 
> not reach the source host (ARP response is not seen by tspdamp on the 
> original host).
> At the same time at the bridge it can be seen by tspdamp that the 
> arp-answer came from the Gigabit port, and thus can be seen that the 
> package left at 10 gigabit ethernet port.
> - ARP-requests are going from gigabyt port, they are seen by tcpdamp 
> (tspdamp at gigabit port sees an incoming packet, tspdamp 10-Gigabit 
> sees outgoing packet). But these packets are not visible at destination.
> Everything is OK with the hosts at the ends of bridge , because if you 
> replace the Linux bridge on FreeBSD bridge, the packets arrive.
> If you are using only 10-Gigabit ports the same problem occurs, incoming 
> packet is seen by tcpdamp on bridge on the incoming 10G interface and 
> outgoing packet seen on an outgoing 10G port , but packets are is not 
> visible at destination.
> I checked MTU everywhere, everywhere the same. Tried to increase it's 
> value on bridge interfaces- and got nothing.
> All iptables and ebtables rules are permissive, default policy anywhere 
> is ACCEPT.
> I'm using Debian with vanilla kernel 2.6.32.2.
> In what may be the problem?
>
>   


-- 
WBR
Yavetskiy Yuriy
ULTI-RIPE

