MIME-Version: 1.0
In-Reply-To: <4B323EE8.6000206@pandora.be>
References: <00163600ce448e8674047b65d7bf@google.com>
	<4B323EE8.6000206@pandora.be>
Date: Mon, 4 Jan 2010 12:35:36 +0100
Message-ID: <8cad0aa1001040335n78bd9f2tce071d9eece11b8e@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Bridge] Re :Re: ebtables, PF_PACKET and other stuff
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

Hi there, and my best wishes for this new year !

>> Mmh, ok, but from the userspace point of view, how can I get them ? A
>> SOCK_RAW ?
>>
> See http://ebtables.sourceforge.net/examples/basic.html#ex_ulog
>
> cheers,
> Bart

Thanks for your reply, but it is not exactly what I am looking for...
I have two rules, that enable the bridging between two of my
interfaces. When I receive IP or VLAN, these packets are droped by the
broute table.
I tried to add the rule :
ebtables -A FORWARD --ulog-nlgroup 5 -j DROP

But it seems  to send me all packets, when I am listening with a
netlink socket...
I have for example an interface connected the internet, that receives
packets, and these packets are received by my netlink socket...
I think I have to tell the Forward rule that I only want the packets
from my eth2 interface (which is the one where I receive my VLAN
packets) ?

Thanks again.
Best Regards,
JM
