Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dMAP5qZPgNkGYL/Es8e27wkRPcvMrbRpgL3nt2uv/U8=;
 b=DQpUmHoSUZ9Cd93537ypZkM+1dvS3gvkMWCoz3Qx13NPmBpmH4L+gKmanA4eodPVK+
 J04ciTphvC/32YS6/AsssAWJdCiJyeCIKz5NoES6FsgkNTeTMfBHwpqq/Y0st/RDULz1
 s90EGRs+oMbXy9wM0GoUZ2naiDEY9gSop5clWt0kv0vvi10hVW8C4NrFvOqm1/nyfGwr
 VqSlZFKNcLXmFmS3OPykN7Q7FfMF/aurchj96d1DyX+1/jlWq3xFkaX+jAweuOZ3N1oM
 Ffdz2TlQJTZ6E/1rQ7Nne2iW8IWlgbGeezgGumjp1cbCy0+8cSqHHZTwHyvW2HGy+2Gh
 Cg/Q==
References: <20200731162616.345380-1-nikolay@cumulusnetworks.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <07823615-29a8-9553-d56b-1beef55a07bc@gmail.com>
Date: Fri, 31 Jul 2020 11:27:03 -0600
MIME-Version: 1.0
In-Reply-To: <20200731162616.345380-1-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: clear bridge's private skb
	space on xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 7/31/20 10:26 AM, Nikolay Aleksandrov wrote:
> We need to clear all of the bridge private skb variables as they can be
> stale due to the packet being recirculated through the stack and then
> transmitted through the bridge device. Similar memset is already done on
> bridge's input. We've seen cases where proxyarp_replied was 1 on routed
> multicast packets transmitted through the bridge to ports with neigh
> suppress which were getting dropped. Same thing can in theory happen with
> the port isolation bit as well.
> 
> Fixes: 821f1b21cabb ("bridge: add new BR_NEIGH_SUPPRESS port flag to suppress arp and nd flood")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
>  net/bridge/br_device.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 8c7b78f8bc23..9a2fb4aa1a10 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -36,6 +36,8 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  	const unsigned char *dest;
>  	u16 vid = 0;
>  
> +	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
> +
>  	rcu_read_lock();
>  	nf_ops = rcu_dereference(nf_br_ops);
>  	if (nf_ops && nf_ops->br_dev_xmit_hook(skb)) {
> 

What's the performance hit of doing this on every packet?

Can you just set a flag that tells the code to reset on recirculation?
Seems like br_input_skb_cb has space for that.
