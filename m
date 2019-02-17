Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=FkmYVtcxj8X/tS7DTWwDr0+msVviMTIn6EcmkMD1fgw=;
	b=ATpMOWL5N4uUWj/udhRoB21cPAmwOTRfopbSuJn3ypttKAyXxqk1YQ6jJtVGa1xgqx
	Ritzup57PvEvvq7lmcafivlOyASfMVDm47Bq6OZuTzs8w7U89QVvhGYQlCJngHGfXqGI
	AfKxis2pvwblTOVfk8TUExtWDQsyLBlkQGVNDTtmSC6QO67tYEo9X+vXxrUbR+nZxfe9
	9jgfwAFLUyM/mIDRojRtg6h4uBHbw9L7ltc8Luv2jVQXaxMuDJnn3wVFbNOBkp8g44ti
	S1tcdNhUtz3kH+buDE0UABUYIm/3nMQ/mL39yV+f1x+a8fTG93sxjwayD4rt/iX7rtb3
	HaGw==
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2bb7baaa-affb-451c-658d-bc5412a14c31@gmail.com>
Date: Sat, 16 Feb 2019 19:05:10 -0800
MIME-Version: 1.0
In-Reply-To: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH RFC] net: bridge: don't flood known multicast
 traffic when snooping is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net



On 2/15/2019 5:04 AM, Nikolay Aleksandrov wrote:
> The behaviour since b00589af3b04 ("bridge: disable snooping if there is
> no querier") is wrong, we shouldn't be flooding multicast traffic when
> there is an mdb entry and we know where it should be forwarded to when
> multicast snooping is enabled. This patch changes the behaviour to not
> flood known unicast traffic.

You mean multicast traffic in the last part of the sentence, right?

> I'll give two obviously broken cases:
>  - most obvious: static mdb created by the user with snooping enabled
>  - user-space daemon controlling the mdb table (e.g. MLAG)
> 
> Every user would expect to have traffic forwarded only to the configured
> mdb destination when snooping is enabled, instead now to get that one
> needs to enable both snooping and querier. Enabling querier on all
> switches could be problematic and is not a good solution, for example
> as summarized by our multicast experts:
> "every switch would send an IGMP query for any random multicast traffic it
> received across the entire domain and it would send it forever as long as a
> host exists wanting that stream even if it has no downstream/directly
> connected receivers"
> 
> Sending as an RFC to get the discussion going, but I'm strongly for
> removing this behaviour and would like to send this patch officially.
> 
> We could make this behaviour possible via a knob if necessary, but
> it really should not be the default.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
>  net/bridge/br_device.c | 3 +--
>  net/bridge/br_input.c  | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 013323b6dbe4..2aa8a6509924 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -96,8 +96,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  		}
>  
>  		mdst = br_mdb_get(br, skb, vid);
> -		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
> -		    br_multicast_querier_exists(br, eth_hdr(skb)))
> +		if (mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb))
>  			br_multicast_flood(mdst, skb, false, true);
>  		else
>  			br_flood(br, skb, BR_PKT_MULTICAST, false, true);
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 5ea7e56119c1..aae78095cf67 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -136,8 +136,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  	switch (pkt_type) {
>  	case BR_PKT_MULTICAST:
>  		mdst = br_mdb_get(br, skb, vid);
> -		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
> -		    br_multicast_querier_exists(br, eth_hdr(skb))) {
> +		if (mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) {
>  			if ((mdst && mdst->host_joined) ||
>  			    br_multicast_is_router(br)) {
>  				local_rcv = true;
> 

-- 
Florian
