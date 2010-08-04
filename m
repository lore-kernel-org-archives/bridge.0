Date: Wed, 4 Aug 2010 14:33:10 +0200 (CEST)
From: Jan Engelhardt <jengelh@medozas.de>
In-Reply-To: <51AC42EFFBC60FE7E630D78B@Ximines.local>
Message-ID: <alpine.LSU.2.01.1008041432380.6031@obet.zrqbmnf.qr>
References: <AANLkTikUczLiyxy3A5eVv7bg1XWhH-ggN1yUv2-EwLYM@mail.gmail.com>
	<4C5953C8.2040708@free.fr> <51AC42EFFBC60FE7E630D78B@Ximines.local>
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

On Wednesday 2010-08-04 14:31, Alex Bligh wrote:
>
>> Did you read http://ebtables.sourceforge.net/br_fw_ia/br_fw_ia.html and
>> http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png ?
>
> A useful improvement to those would be documenting where libpcap
> (which does both input and, less well known, output) samples/injects
> packets. I /think/ sampling is right on the left and injection right
> on the right.

pcap grabbing and injection is completely outside any of the graphs 
currently floating around.
