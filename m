References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<1258497551-25959-2-git-send-email-arnd@arndb.de>
	<4B03949D.4000908@gmail.com> <200911181047.07974.arnd@arndb.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 18 Nov 2009 06:37:50 -0800
In-Reply-To: <200911181047.07974.arnd@arndb.de> (Arnd Bergmann's message of
	"Wed\, 18 Nov 2009 10\:47\:07 +0100")
Message-ID: <m1pr7fdhkx.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] [PATCH 1/3] macvlan: Reflect macvlan packets meant for
	other macvlan devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@linux-foundation.com, Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 18 November 2009, Eric Dumazet wrote:
>> > -     skb->dev = dev;
>> > -     skb->pkt_type = PACKET_HOST;
>> > +     skb->protocol = eth_type_trans(skb, dev);
>> > +     eth = eth_hdr(skb);
>> >  
>> > -     netif_rx(skb);
>> > -     return NULL;
>> > +     skb_dst_drop(skb);
>> 
>> Why do you drop dst here ?
>> 
>> It seems strange, since this driver specifically masks out IFF_XMIT_DST_RELEASE
>> in its macvlan_setup() :
>> 
>> dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
>> 
>> If we really want to drop dst, it could be done by caller, if IFF_XMIT_DST_RELEASE
>> was not masked in macvlan_setup().
>> 
>
> That must be my fault, it is the only change I did to Eric B's patch when
> forward-porting to 2.6.32. The original patch did
>
> 	skb->protocol = eth_type_trans(skb, dev);
> 	eth = eth_hdr(skb);
> 	dst_release(skb->dst);
> 	skb->dst = NULL;
> 	skb->mark = 0;
>
> and I tried to convert that in the same way that other drivers did, but I
> have to admit that I did not understand the mechanics of IFF_XMIT_DST_RELEASE.

Please copy and ideally share code with the veth driver for recycling a skb.
There are bunch of little things you have to do to get it right.  As I recally
I was missing a few details in my original patch.

Eric
