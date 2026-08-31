Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A23438AD
	for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178341; cv=none; b=HbyKIS5lOuc7vG49jhzszcUU8UCSuuRklb6hdhCcbnUxuSQV1JnvDpSaerCltPMx6YZguovN5l1d/yfCt6c/ZhGzr6uU7Lx9r3IitAUQQ7g05r8TFsvpNO0hrj04UCssQcRHkJNI7bCErYXcdNIdTiuwlBmjkj7zxBbpK8LHhAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178341; c=relaxed/simple;
	bh=P4UI4r9U8+0A/lz0cD753YKPKkVDryKpPXsda1kdsMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I62cR2HKmEbZYNYI5H+HXU3nzF04inca6TU/ya37pq15AdvYawELTZQ1hwrBX8KLKiacjg7zkUzzFjd7LbhHkNnyzKT73gE+GJ5VQaPxPjH3JQxq07V2tvYldRL/xIkTua5Rc5inflI7L4+mTPST30SAhzg42lrt4c2ZjQYd8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=em/Cb8AD; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="em/Cb8AD"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1712a04ddaso553232566b.2
        for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 05:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788178338; x=1788783138; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IdHlUEflbKe66wiG2HC6SK0wPoPdW7zv/s3LzgjChYk=;
        b=em/Cb8ADPwxNCxVZsDeynRVmSR6onaUffsFtQ2I8JNHW9G85/zxBcbPSZHOhXJ2avg
         Mw83HlA8azbl9wIdFyeTEfy/IobMfAPDXjUNWk4OSSz9YmlWoQ8iyZ2VHLFIWaVuL8GE
         4XyRmRMy55pmnqt3kLA1piPRIXEbmzpgljEHBcJhb8lhsLrA4Is1Q0b6gW+58e1Lyezq
         OUcudTsUtrDZM6bOIvWmhFDE/62ZKO37ZOym3Idj6oEbyHXDR8bZSdpP0UxgWyGHPPDb
         h4BcQZ3D7hmF1DFEaLv0vxAI+RUR34BOx/fZMaLo0fPS90+FkHane7Z8jeEDmIRmMugO
         MaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788178338; x=1788783138;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IdHlUEflbKe66wiG2HC6SK0wPoPdW7zv/s3LzgjChYk=;
        b=V9nrSfH+NAlBaCJcR2r5qEPGodxVumHnfOEX7LzxrcfVh06fUf++E7Td4MNKlyCpuX
         SMA5aTNmwC4+orWCVvD+hJj2NYIORM0WxyyC9VQAeSuJJ2vMUnouTSsjHRUIv9hIzQRr
         Sj/SZNSyggUt4oFNfLrosNde/TTGQhP2HT5JT73S8GVGof4AUSqO/XNnx7IUWsOQrWWF
         GCk5yHLQYAhPU8sVJQQq/ZFKyElEdHDKCV2UzIIHHmb1tg/jIka1Vh4/NgykACM4xy3C
         kuryyxlUN+cS8xC7GQ8Ss7LQq0UyymC21zFfgTqNETsm+vR0MI7xUXcjNWtn1YPnebi8
         1CeQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxMEPl6dJaPJ06fN2aBj/hMhABngrm0PlJ2pl+4JkVU9bR/8awPc+n77G1wXF6AuaY9Cz65Js=@lists.linux.dev
X-Gm-Message-State: AFuF++mVUctG6bINhAX0hrNLBKK8PDBWNU2PJTb52RHkvLxQ+mXd0KQM
	dVBNcMp9URKaJEJJZtSCejQh+fA3tXdbNqT7O3DbVFUAi+9YeChOOKWyRYIr8fc4E9c=
X-Gm-Gg: AR+sD11u2maYNVQop4AzbdKtKBwSd3WCOdGuwQ7xBjD7sZckj3KRMArOjvcIjjgTiyW
	0Ex9GjWOp6xtt0qD0aTcIxDAmVQe5JNzRkvT+yddJika50Z4/IeL7li6FRegfOTrd2kQlpp4x0I
	2+PKBq1O/J0ZglpK/aKNE6M4hJw97IJipfYPrsmau6v0vEsGlQhy5fphuet4E6U5l3rJcBcPGHE
	v+RtQJKkxQjG7SbyUDH3cNhQUKLdW/6zqn29joF7OpYy2Pk14pEivIiHWz7B8WTv7QKMohUNWgc
	hvKNZxgIZu4G5pIePXhX3XHO3P7ll1jf/AIGtdRWtX45PLbo8xv3fEsMyC8/G+WAATFEeoCeSTQ
	/TNglfCEE7/brrj9G5YhPhhjKO9PcdVojlHfwGL9EtY7PE1T1aKJHCGzo39qeTC7q6vgZjdMKSK
	yYThtizuLEcvf/oeZHDmWh3+SRiY43mf0F+qX/KyI5hjdj+BnsMzpFi6+GgXtbvt0auGewjKdqD
	ntkt/4vblxcb6C15EM=
X-Received: by 2002:a17:907:5c3:b0:c16:4df6:176b with SMTP id a640c23a62f3a-c255741620bmr1691027466b.20.1788178337380;
        Mon, 31 Aug 2026 05:12:17 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b2049sm440887666b.36.2026.08.31.05.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:12:16 -0700 (PDT)
Message-ID: <168acc7a-521c-4620-a81d-ebafae94e146@blackwall.org>
Date: Mon, 31 Aug 2026 15:12:15 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net: bridge: use option bits for CFM/MRP frame
 handlers
Content-Language: en-US, bg
To: Zhiling Zou <zhilinz@nebusec.ai>, bridge@lists.linux.dev,
 netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, horatiu.vultur@microchip.com,
 henrik.bjoernlund@microchip.com, vega@nebusec.ai, zylzyl2333@gmail.com
References: <cover.1788159904.git.zhilinz@nebusec.ai>
 <a43fdd12ad2fbb708c090dc4ead60f3e4aa8c0ac.1788159904.git.zhilinz@nebusec.ai>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <a43fdd12ad2fbb708c090dc4ead60f3e4aa8c0ac.1788159904.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 14:20, Zhiling Zou wrote:
> CFM and MRP register a global br_frame_type whose hlist_node is linked
> into the per-bridge frame_type_list when the first MEP/MRP instance is
> created. Enabling the protocol on multiple bridges therefore inserts the
> same node into multiple lists. Unregistering it on one bridge then
> corrupts list state belonging to another.
> 
> These handlers can only be installed once per bridge, and they are
> uncommon. Track their per-bridge enable state with net_bridge option
> bits, which already live on the Rx hot cache line, and dispatch the
> matching handler directly from the receive path. Check both bits
> together first as an unlikely case.
> 
> Remove the generic frame_type_list and br_frame_type helpers, which
> have had no other users since CFM and MRP were added. That shrinks
> struct net_bridge by 8 bytes and drops the list walk from the fast
> path. When neither protocol is compiled in, the new checks are compiled
> out completely.
> 
> Fixes: 90c628dd47ff ("net: bridge: extend the process of special frames")
> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Co-developed-by: Yilin Zhu <zylzyl2333@gmail.com>
> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v2:
>    - Replace the per-bridge br_frame_type object with net_bridge option
>      bits.
>    - Dispatch CFM/MRP handlers from the receive path. Check both option
>      bits together first as an unlikely case.
>    - Cover MRP, which has the same shared hlist_node bug.
>    - Remove frame_type_list so CFM/MRP do not affect the fast path when
>      they are disabled in .config.
>    - v1 Link: https://lore.kernel.org/all/7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com/
> 

Hi,
I might've been a bit overzealous on the fast-path comments, so these options will
almost always be enabled by distros, that's what they usually do. So a few minor
changes would make the code more readable below...

>   net/bridge/br_cfm.c     | 11 +++--------
>   net/bridge/br_device.c  |  1 -
>   net/bridge/br_input.c   | 44 ++++++++++++++++++++---------------------
>   net/bridge/br_mrp.c     | 13 +++---------
>   net/bridge/br_private.h | 15 ++++----------
>   5 files changed, 32 insertions(+), 52 deletions(-)
> 
> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> index dea56fffa1c19..9dcc97d63a6fc 100644
> --- a/net/bridge/br_cfm.c
> +++ b/net/bridge/br_cfm.c
> @@ -367,7 +367,7 @@ static u32 ccm_tlv_extract(struct sk_buff *skb, u32 index,
>   }
>   
>   /* note: already called with rcu_read_lock */
> -static int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
> +int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
>   {
>   	u32 mdlevel, interval, size, index, max;
>   	const struct br_cfm_common_hdr *hdr;
> @@ -489,11 +489,6 @@ static int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
>   	return 1;
>   }
>   
> -static struct br_frame_type cfm_frame_type __read_mostly = {
> -	.type = cpu_to_be16(ETH_P_CFM),
> -	.frame_handler = br_cfm_frame_rx,
> -};
> -
>   int br_cfm_mep_create(struct net_bridge *br,
>   		      const u32 instance,
>   		      struct br_cfm_mep_create *const create,
> @@ -559,7 +554,7 @@ int br_cfm_mep_create(struct net_bridge *br,
>   	INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
>   
>   	if (hlist_empty(&br->mep_list))
> -		br_add_frame(br, &cfm_frame_type);
> +		br_opt_toggle(br, BROPT_CFM_ENABLED, true);
>   
>   	hlist_add_tail_rcu(&mep->head, &br->mep_list);
>   
> @@ -588,7 +583,7 @@ static void mep_delete_implementation(struct net_bridge *br,
>   	kfree_rcu(mep, rcu);
>   
>   	if (hlist_empty(&br->mep_list))
> -		br_del_frame(br, &cfm_frame_type);
> +		br_opt_toggle(br, BROPT_CFM_ENABLED, false);
>   }
>   
>   int br_cfm_mep_delete(struct net_bridge *br,
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index ff55dab736326..e01c44a90d84b 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -503,7 +503,6 @@ void br_dev_setup(struct net_device *dev)
>   	spin_lock_init(&br->lock);
>   	INIT_LIST_HEAD(&br->port_list);
>   	INIT_HLIST_HEAD(&br->fdb_list);
> -	INIT_HLIST_HEAD(&br->frame_type_list);
>   #if IS_ENABLED(CONFIG_BRIDGE_MRP)
>   	INIT_HLIST_HEAD(&br->mrp_list);
>   #endif
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index d87a5f9fa92b7..72892e5b40439 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -317,20 +317,33 @@ static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
>   	return RX_HANDLER_CONSUMED;
>   }
>   
> +#if IS_ENABLED(CONFIG_BRIDGE_CFM) || IS_ENABLED(CONFIG_BRIDGE_MRP)
> +/* CFM/MRP are uncommon; test both enable bits together first. */

drop the #if and the comment

> +#define BR_CFM_MRP_OPTS \
> +	((IS_ENABLED(CONFIG_BRIDGE_CFM) ? BIT(BROPT_CFM_ENABLED) : 0UL) | \
> +	 (IS_ENABLED(CONFIG_BRIDGE_MRP) ? BIT(BROPT_MRP_ENABLED) : 0UL))

always define this

> +
>   /* Return 0 if the frame was not processed otherwise 1
>    * note: already called with rcu_read_lock
>    */
>   static int br_process_frame_type(struct net_bridge_port *p,
>   				 struct sk_buff *skb)
>   {
> -	struct br_frame_type *tmp;
> -
> -	hlist_for_each_entry_rcu(tmp, &p->br->frame_type_list, list)
> -		if (unlikely(tmp->type == skb->protocol))
> -			return tmp->frame_handler(p, skb);
> +	struct net_bridge *br = p->br;
>   
> +#if IS_ENABLED(CONFIG_BRIDGE_CFM)

drop the #if
> +	if (skb->protocol == htons(ETH_P_CFM) &&
> +	    br_opt_get(br, BROPT_CFM_ENABLED))
> +		return br_cfm_frame_rx(p, skb);
> +#endif
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)

and this one

> +	if (skb->protocol == htons(ETH_P_MRP) &&
> +	    br_opt_get(br, BROPT_MRP_ENABLED))
> +		return br_mrp_process(p, skb);
> +#endif

instead follow what others are doing and make these functions noops in the headers
if these options are not defined, there are plenty of examples in br_private.h
The compiler should prune these when they're noops.

>   	return 0;
>   }
> +#endif
>   
>   /*
>    * Return NULL if skb is handled
> @@ -425,8 +438,11 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
>   		}
>   	}
>   
> -	if (unlikely(br_process_frame_type(p, skb)))
> +#if IS_ENABLED(CONFIG_BRIDGE_CFM) || IS_ENABLED(CONFIG_BRIDGE_MRP)

drop this #if

> +	if (unlikely((p->br->options & BR_CFM_MRP_OPTS) &&

always do the check, but read p->br->options with READ_ONCE because it might change
in case none of the options are defined we get & 0 so the compiler will prune the
branch entirely, otherwise we have a single fast check (we already had that with the list
anyway, but here it's better because this is in a hot cache line)

> +		     br_process_frame_type(p, skb)))
>   		return RX_HANDLER_PASS;
> +#endif
>   
>   forward:
>   	if (br_mst_is_enabled(p))
> @@ -467,19 +483,3 @@ rx_handler_func_t *br_get_rx_handler(const struct net_device *dev)
>   
>   	return br_handle_frame;
>   }
> -
> -void br_add_frame(struct net_bridge *br, struct br_frame_type *ft)
> -{
> -	hlist_add_head_rcu(&ft->list, &br->frame_type_list);
> -}
> -
> -void br_del_frame(struct net_bridge *br, struct br_frame_type *ft)
> -{
> -	struct br_frame_type *tmp;
> -
> -	hlist_for_each_entry(tmp, &br->frame_type_list, list)
> -		if (ft == tmp) {
> -			hlist_del_rcu(&ft->list);
> -			return;
> -		}
> -}
> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index ef16d07039241..dce6efa96c4c6 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -6,13 +6,6 @@
>   static const u8 mrp_test_dmac[ETH_ALEN] = { 0x1, 0x15, 0x4e, 0x0, 0x0, 0x1 };
>   static const u8 mrp_in_test_dmac[ETH_ALEN] = { 0x1, 0x15, 0x4e, 0x0, 0x0, 0x3 };
>   
> -static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
> -
> -static struct br_frame_type mrp_frame_type __read_mostly = {
> -	.type = cpu_to_be16(ETH_P_MRP),
> -	.frame_handler = br_mrp_process,
> -};
> -
>   static bool br_mrp_is_ring_port(struct net_bridge_port *p_port,
>   				struct net_bridge_port *s_port,
>   				struct net_bridge_port *port)
> @@ -486,7 +479,7 @@ static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
>   	kfree_rcu(mrp, rcu);
>   
>   	if (hlist_empty(&br->mrp_list))
> -		br_del_frame(br, &mrp_frame_type);
> +		br_opt_toggle(br, BROPT_MRP_ENABLED, false);
>   }
>   
>   /* Adds a new MRP instance.
> @@ -536,7 +529,7 @@ int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance)
>   	rcu_assign_pointer(mrp->s_port, p);
>   
>   	if (hlist_empty(&br->mrp_list))
> -		br_add_frame(br, &mrp_frame_type);
> +		br_opt_toggle(br, BROPT_MRP_ENABLED, true);
>   
>   	INIT_DELAYED_WORK(&mrp->test_work, br_mrp_test_work_expired);
>   	INIT_DELAYED_WORK(&mrp->in_test_work, br_mrp_in_test_work_expired);
> @@ -1241,7 +1234,7 @@ static int br_mrp_rcv(struct net_bridge_port *p,
>    * normal forwarding.
>    * note: already called with rcu_read_lock
>    */
> -static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
> +int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
>   {
>   	/* If there is no MRP instance do normal forwarding */
>   	if (likely(!test_bit(BR_MRP_AWARE_BIT, &p->flags)))
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index d337b1cfb980d..afe7c0b4f8fa7 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -495,12 +495,13 @@ enum net_bridge_opts {
>   	BROPT_MST_ENABLED,
>   	BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION,
>   	BROPT_FDB_LOCAL_VLAN_0,
> +	BROPT_CFM_ENABLED,
> +	BROPT_MRP_ENABLED,
>   };
>   
>   struct net_bridge {
>   	spinlock_t			lock;
>   	spinlock_t			hash_lock;
> -	struct hlist_head		frame_type_list;
>   	struct net_device		*dev;
>   	unsigned long			options;
>   	/* These fields are accessed on each packet */
> @@ -932,16 +933,6 @@ int nbp_backup_change(struct net_bridge_port *p, struct net_device *backup_dev);
>   int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
>   rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
>   
> -struct br_frame_type {
> -	__be16			type;
> -	int			(*frame_handler)(struct net_bridge_port *port,
> -						 struct sk_buff *skb);
> -	struct hlist_node	list;
> -};
> -
> -void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
> -void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
> -
>   static inline bool br_rx_handler_check_rcu(const struct net_device *dev)
>   {
>   	return rcu_dereference(dev->rx_handler) == br_get_rx_handler(dev);
> @@ -2080,6 +2071,7 @@ int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
>   bool br_mrp_enabled(struct net_bridge *br);
>   void br_mrp_port_del(struct net_bridge *br, struct net_bridge_port *p);
>   int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br);
> +int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
>   #else
>   static inline int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
>   			       struct nlattr *attr, int cmd,
> @@ -2111,6 +2103,7 @@ int br_cfm_parse(struct net_bridge *br, struct net_bridge_port *p,
>   		 struct nlattr *attr, int cmd, struct netlink_ext_ack *extack);
>   bool br_cfm_created(struct net_bridge *br);
>   void br_cfm_port_del(struct net_bridge *br, struct net_bridge_port *p);
> +int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb);
>   int br_cfm_config_fill_info(struct sk_buff *skb, struct net_bridge *br);
>   int br_cfm_status_fill_info(struct sk_buff *skb,
>   			    struct net_bridge *br,

