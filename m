Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=H0dBiMlIz57i5a6OQd6NNT0qs7e4FvnqEbY3KZH5hD8=;
 b=CdFIz0ffcFB5FT8t5IaEhDZyUUp01nVtQqvO1mpda5BxsFn2930XF2Z2oE2exxz4wn
 l7XKnvQC3uMablm/vg23TOUkkdnchyDUsIDZcmMkE88p5vjGI/eQhYjCk2qARTMEzSB7
 TGa0jTtLBjq/jNgaLRuSK9wALpCB3Y9hy0Dds=
References: <20200705182234.10257-1-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <093beb97-87e8-e112-78ad-b3e4fe230cdb@cumulusnetworks.com>
Date: Sun, 5 Jul 2020 21:33:13 +0300
MIME-Version: 1.0
In-Reply-To: <20200705182234.10257-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net] bridge: mcast: Fix MLD2 Report IPv6
 payload length check
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: Martin Weinelt <martin@linuxlounge.net>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On 05/07/2020 21:22, Linus Lüssing wrote:
> Commit e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in
> igmp3/mld2 report handling") introduced a small bug which would potentially
> lead to accepting an MLD2 Report with a broken IPv6 header payload length
> field.
> 
> The check needs to take into account the 2 bytes for the "Number of
> Sources" field in the "Multicast Address Record" before reading it.
> And not the size of a pointer to this field.
> 
> Fixes: e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in igmp3/mld2 report handling")
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

I'd rather be more concerned with it rejecting a valid report due to wrong size. The ptr
size would always be bigger. :)

Thanks!
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 83490bf73a13..4c4a93abde68 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1000,21 +1000,21 @@ static int br_ip6_multicast_mld2_report(struct net_bridge *br,
>  	num = ntohs(icmp6h->icmp6_dataun.un_data16[1]);
>  	len = skb_transport_offset(skb) + sizeof(*icmp6h);
>  
>  	for (i = 0; i < num; i++) {
>  		__be16 *_nsrcs, __nsrcs;
>  		u16 nsrcs;
>  
>  		nsrcs_offset = len + offsetof(struct mld2_grec, grec_nsrcs);
>  
>  		if (skb_transport_offset(skb) + ipv6_transport_len(skb) <
> -		    nsrcs_offset + sizeof(_nsrcs))
> +		    nsrcs_offset + sizeof(__nsrcs))
>  			return -EINVAL;
>  
>  		_nsrcs = skb_header_pointer(skb, nsrcs_offset,
>  					    sizeof(__nsrcs), &__nsrcs);
>  		if (!_nsrcs)
>  			return -EINVAL;
>  
>  		nsrcs = ntohs(*_nsrcs);
>  		grec_len = struct_size(grec, grec_src, nsrcs);
>  
> 

