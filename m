Return-Path: <xiyou.wangcong@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=GkFO7Q7UonN9BZgOB0923Fvp/CmoNWpOLUgZ4vq0GPc=;
	b=z5+VCI8l+f57WAYQyJEZeT7CkRDdKByNAE+w+48IBqWfwW+q13lprS6Se4Evcy+hb4
	f136SObpoA23wgRi5ybXIVQQbE6Cf32YM4Y+/DhwKnVDBVHwsdOV7M6NjbaF1Be5ZJbc
	Qtab7dKAqAocOOOwhF8j9g81PodNngiDPTNNsrfYoAIl1SO1gHod316raIBu3Ku1L21c
	MKN5LEtzCgMx3mXvqf277Zaxf5ug7DK90oDrpFoOdFhhDCPnvnVfsskXV+v+o0ajP0wB
	qjRKdhU+yO/kHFglDBGez5Jg01lSlvXRabOXpo/uIrN0KRruZ4WHs84Figz+rzzkJlum
	+0Yg==
MIME-Version: 1.0
In-Reply-To: <1468465802-4571-3-git-send-email-nikolay@cumulusnetworks.com>
References: <1468465802-4571-1-git-send-email-nikolay@cumulusnetworks.com>
	<1468465802-4571-3-git-send-email-nikolay@cumulusnetworks.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 15 Jul 2016 10:35:16 -0700
Message-ID: <CAM_iQpXXoprcz48c-AYgOridkQWSv+5+7v4V5pT1rUu4_FoXMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH net-next 2/4] net: bridge: rearrange flood vs
 unicast receive paths
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

On Wed, Jul 13, 2016 at 8:10 PM, Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
> This patch removes one conditional from the unicast path by using the fact
> that skb is NULL only when the packet is multicast or is local.
>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
>  net/bridge/br_input.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 0b6d32619468..c20c5be6fc22 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -134,10 +134,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>         struct net_bridge_port *p = br_port_get_rcu(skb->dev);
>         const unsigned char *dest = eth_hdr(skb)->h_dest;
>         struct net_bridge_fdb_entry *dst = NULL;
> +       bool mcast_hit = false, unicast = true;
>         struct net_bridge_mdb_entry *mdst;
>         struct net_bridge *br;
>         struct sk_buff *skb2;
> -       bool unicast = true;
>         u16 vid = 0;
>
>         if (!p || p->state == BR_STATE_DISABLED)
> @@ -177,30 +177,29 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>                 if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
>                     br_multicast_querier_exists(br, eth_hdr(skb))) {
>                         if ((mdst && mdst->mglist) ||
> -                           br_multicast_is_router(br))
> +                           br_multicast_is_router(br)) {
>                                 skb2 = skb;
> -                       br_multicast_forward(mdst, skb, skb2);
> -                       skb = NULL;
> -                       if (!skb2)
> -                               goto out;
> +                               br->dev->stats.multicast++;
> +                       }
> +                       mcast_hit = true;
>                 } else {
>                         skb2 = skb;
> +                       br->dev->stats.multicast++;
>                 }
>                 unicast = false;
> -               br->dev->stats.multicast++;


Looks like you change the unconditional increment of this counter,
is this intended?
