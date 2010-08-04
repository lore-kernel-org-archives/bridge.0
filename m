Date: Wed, 4 Aug 2010 18:40:59 +0200 (CEST)
From: Jan Engelhardt <jengelh@medozas.de>
In-Reply-To: <4C5997DD.8080200@free.fr>
Message-ID: <alpine.LSU.2.01.1008041840310.10301@obet.zrqbmnf.qr>
References: <AANLkTikUczLiyxy3A5eVv7bg1XWhH-ggN1yUv2-EwLYM@mail.gmail.com>
	<4C5953C8.2040708@free.fr> <51AC42EFFBC60FE7E630D78B@Ximines.local>
	<alpine.LSU.2.01.1008041432380.6031@obet.zrqbmnf.qr>
	<A1D32A25DAAD1A46D6CC68BE@Ximines.local>
	<alpine.LSU.2.01.1008041630390.19791@obet.zrqbmnf.qr>
	<4C5997DD.8080200@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] ebtables PREROUTING -drop
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Nicolas_de_Peslo=C3=BCan?= <nicolas.2p.debian@free.fr>
Cc: Netfilter mailing list <netfilter@vger.kernel.org>, bridge@lists.linux-foundation.org, Alex Bligh <alex@alex.org.uk>


On Wednesday 2010-08-04 18:39, Nicolas de Pesloüan wrote:
>>> I'm not 100% sure it is completely outside though. For instance,
>>> if you do tcdump on a bridge device (as opposed to the corresponding
>>> physical participant interface), isn't that after ingress ebtales
>>> processing, but before egress? IE is in the graph somewhere.
>>
>> Huh, all once investigated already. See
>> http://jengelh.medozas.de/images/nf-packet-flow.png for where
>> in/egress happen to be. :)
>
> Nice work!
>
> May be just missing other netif_receive_skb() magic, like bonding for example.

Well, bonding is not really part of Netfilter.
Then again, neither is ingress/xfrm ;-)
