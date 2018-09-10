Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=FWZknVyegad0mZMZZgnD7h2HM13CUuUx6RRhu9pSmhw=;
	b=xB1+m3fZlcViu6jROaJtvA3rnbulafADQLVbxQBKbrq43qUtm7jBV10R7Rk++5S0Ix
	iwyVe2baieWKq9nLN7cXHqpv+fNUM0oCPZFoR/sPu6wtsYOb4ax2YlazHblTxktCCtQ6
	7zguywxr1e3QBpsMeFu3F35qQZXroImLmfLPiVeV7vhGB4KkQJlPPFZfK8t6IvluZdbc
	BrzB8HmSbY4WiX/nFQxrGKt7Kkag9dO04yv2kC6ZzBg8Ch/Va8gJLlk3Cok6ytL01/7r
	LxKuzzL+vvbuGSln/UBIZZ5K0GO4QO2LzNTqCvh16JVbYAk8fCHyooxP24Bjc6oukbAr
	eAYA==
Date: Mon, 10 Sep 2018 14:18:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180910141802.268e85c5@shemminger-XPS-13-9360>
In-Reply-To: <20180910101601.28073-1-nikolay@cumulusnetworks.com>
References: <20180910101601.28073-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add support for sticky
 fdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On Mon, 10 Sep 2018 13:16:01 +0300
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> Add support for entries which are "sticky", i.e. will not change their port
> if they show up from a different one. A new ndm flag is introduced for that
> purpose - NTF_STICKY. We allow to set it only to non-local entries.

Is there a name for this in other network switch API's?

> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> I'll send the selftest for sticky with the iproute2 patch if this one is
> accepted. We've had multiple requests to support such flag and now it's
> also needed for some eVPN and clag setups.
> 
>  include/uapi/linux/neighbour.h |  1 +
>  net/bridge/br_fdb.c            | 19 ++++++++++++++++---
>  net/bridge/br_private.h        |  1 +
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
> index 904db6148476..998155444e0d 100644
> --- a/include/uapi/linux/neighbour.h
> +++ b/include/uapi/linux/neighbour.h
> @@ -43,6 +43,7 @@ enum {
>  #define NTF_PROXY	0x08	/* == ATF_PUBL */
>  #define NTF_EXT_LEARNED	0x10
>  #define NTF_OFFLOADED   0x20
> +#define NTF_STICKY	0x40
>  #define NTF_ROUTER	0x80
>  
>  /*
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 502f66349530..26569ed06a4d 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -584,7 +584,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>  			unsigned long now = jiffies;
>  
>  			/* fastpath: update of existing entry */
> -			if (unlikely(source != fdb->dst)) {
> +			if (unlikely(source != fdb->dst && !fdb->is_sticky)) {
>  				fdb->dst = source;
>  				fdb_modified = true;
>  				/* Take over HW learned entry */
> @@ -656,6 +656,8 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
>  		ndm->ndm_flags |= NTF_OFFLOADED;
>  	if (fdb->added_by_external_learn)
>  		ndm->ndm_flags |= NTF_EXT_LEARNED;
> +	if (fdb->is_sticky)
> +		ndm->ndm_flags |= NTF_STICKY;
>  
>  	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->key.addr))
>  		goto nla_put_failure;
> @@ -772,7 +774,8 @@ int br_fdb_dump(struct sk_buff *skb,
>  
>  /* Update (create or replace) forwarding database entry */
>  static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
> -			 const __u8 *addr, __u16 state, __u16 flags, __u16 vid)
> +			 const u8 *addr, u16 state, u16 flags, u16 vid,
> +			 u8 is_sticky)

Why not change the API to take a full ndm flags, someone is sure to add more later.
