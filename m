Date: Wed, 4 Aug 2010 16:32:20 +0200 (CEST)
From: Jan Engelhardt <jengelh@medozas.de>
In-Reply-To: <A1D32A25DAAD1A46D6CC68BE@Ximines.local>
Message-ID: <alpine.LSU.2.01.1008041630390.19791@obet.zrqbmnf.qr>
References: <AANLkTikUczLiyxy3A5eVv7bg1XWhH-ggN1yUv2-EwLYM@mail.gmail.com>
	<4C5953C8.2040708@free.fr> <51AC42EFFBC60FE7E630D78B@Ximines.local>
	<alpine.LSU.2.01.1008041432380.6031@obet.zrqbmnf.qr>
	<A1D32A25DAAD1A46D6CC68BE@Ximines.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Bridge] ebtables PREROUTING -drop
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>
Cc: bridge@lists.linux-foundation.org, Netfilter mailing list <netfilter@vger.kernel.org>


On Wednesday 2010-08-04 16:25, Alex Bligh wrote:
>
>>>> Did you read http://ebtables.sourceforge.net/br_fw_ia/br_fw_ia.html and
>>>> http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png ?
>>>
>>> A useful improvement to those would be documenting where libpcap
>>> (which does both input and, less well known, output) samples/injects
>>> packets. I /think/ sampling is right on the left and injection right
>>> on the right.
>>
>> pcap grabbing and injection is completely outside any of the graphs
>> currently floating around.
>
> If by 'outside' you mean 'to the extreme left or extreme right'
> that was my conclusion. But the absence of any documentation means
> this makes debugging with tcpdump (for instance) harder
> because you don't know where you are sampling.

Well perhaps not extreme. If you inject into a tunnel, it may well
walk through Xtables after all - but then of course, only in its
encapsulated form.

> I'm not 100% sure it is completely outside though. For instance,
> if you do tcdump on a bridge device (as opposed to the corresponding
> physical participant interface), isn't that after ingress ebtales
> processing, but before egress? IE is in the graph somewhere.

Huh, all once investigated already. See
http://jengelh.medozas.de/images/nf-packet-flow.png for where
in/egress happen to be. :)
