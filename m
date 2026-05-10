Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D4C33F580
	for <bridge@lists.linux.dev>; Sun, 10 May 2026 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778407529; cv=none; b=k6QDNFWxPEop16DRGIfviCg3kDOwAF6Hs2llnLMb3zSKnH64FL7ondbz4c2rfYN7X5wXEQzMFC32el2gXJ/a2/qnOTdiXUXjsWlMJ/sc2fwsUf8SGvmDVPT961AyqV9zZbgcgTFNphr5gZfYG1T71bKRg5VNdoLRkODaQqIBzU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778407529; c=relaxed/simple;
	bh=jl9mMb2xNoQTkvMYCnG85fJgeQuVdezGK14MCgT4Wg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCSEVuOQyLXgbDbBt+HcXk8PxdlOlv6FKP2t3jluQ3cTbq3gveRxHs9j4xcXUHkReQd8l3V36dS/f4LKnaurjhmSrdE0Wt7+fvsB97Ljngcctei++Ztl8gbV9ryA3b32hEJo+bD/NlprtfdOUVg5AvMahqZOUP9udM0wOG9lqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Dt/2LxWN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Dt/2LxWN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso29935645e9.3
        for <bridge@lists.linux.dev>; Sun, 10 May 2026 03:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1778407526; x=1779012326; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fjf6lHgwzOVnsX45ANVQd7FGC8MgEKFi4DF4O0Gwyz0=;
        b=Dt/2LxWNT49N/Bf671ruOGDMeZtySPFhyhRHRPc5YEJs6/ttxpuGuxU7PsxfADdWIN
         1ip3p1vkIMsEuYJsRgJjB9EVEvtx5LpxhgoszRdfK2Kcmh8W/4yQsFtwLo7i1DfVeP+b
         XNHRHzj2zAtCk0LhaQ0dshivQ7bi6IQWprBC3i8mzTR2hovrl3JoSVt+Hz5WdKT8Lspv
         9O3NLMBr4WnU8NE/b1z6LXrdNzHMsDINU+LJ6HaZKggsdLALoJJeIPfEJwJaxTwoaSQW
         I+xibERkfJsIttShdkutHSG4HNcX1qnu6K4vxGvFA29EA+nSOhpKHjE7aE9pVvtuIfJt
         /Dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778407526; x=1779012326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fjf6lHgwzOVnsX45ANVQd7FGC8MgEKFi4DF4O0Gwyz0=;
        b=gbsRotSNyWKdFH0LWXZKKxI0qzPBsfFh3oAMPdRA0Ciq85uK8vyT6VDhMRyguSQgRS
         7iM5kNM/jyzQ8wmD07Cwc8mAsQ4jmeK4xUj7IWJQxlzVqxi7BEGOLeFrWtQNgZcdfYKO
         tPQMOkzthaoJWyD/kVj9DADqSZoEb69fq9i+5ejLjGZua1AZIEobXFcMpQFcIJfLPwRU
         fI/Z4sV/RM2jmbnAJ5EJU9uGnZ2Nalg32mpSCPpq7ARGcP9Vsej3+RkFZ3GEKpqaBr4U
         EuEm+To7lQMp+rKoOTKt4nYfjq5LlPnZHUiXMWxonGejiYqwXd88M5m70+qkzeayVeqg
         3mRA==
X-Forwarded-Encrypted: i=1; AFNElJ+G8MhFKy41APxm6NzM1+MA1AUgfvQ8GShhQBLCyNLgZxxg39IubCzlT7JxvnGcaFdtRGF9NU0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwUOlvlEcD3vKjBTJAeKIwqtcKSNtnzyyyuStPs3Wni4HWjNtzt
	kArfUj0rXi/dcVYD6oubeWEXLIZBBZXqvatqhW9/6ezel9JxeCr1xUZbGLEPVQB8QUE=
X-Gm-Gg: Acq92OFF3O0qG60mfxodvwtVBqKruIS1rFPFFIVfsQ8026Yk8iUPR15CFdG/8VEraDd
	mlqz5EtzGKymb3O82nqOKGedDghF5BMbbluGU8EgQIragjtD+PmdL9qV6H86WbIg1+UheY+4dHs
	ys+BHe5SY+Q/2r+kr4ZEuYL9zTkTu1b1fWB5GQL8aEmho1A6htrUJV8HCGXBIOw8nMgM9D2qWu/
	AAhPvJNGrMdYwIRb4EKO2buO8sJUUPLprFKNEkarv2f+y8vekIFDA2I+88b3FxHVmkDQkhJ+KRA
	Wde6HabNcT5Ol0E1kFa15tUyGrtMcU9ZPKPoR0k4PjZbWyNLmcU5m+KIxRMZG+YJxU5dxZNHje8
	hhBUUZGIQ6YHHD20bA9jt1tTz9Ct3wEk8tXl3McF1TPpxbwHH0/UWeowsjloG+sWjQF+5n9jjLZ
	rgHHiyU++1PVZgUqENTheTJSABcvKr77t37cSiQ7rzcCRs3pRHDQxfHg==
X-Received: by 2002:a05:600c:3055:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-48e51f4e492mr198370365e9.27.1778407526198;
        Sun, 10 May 2026 03:05:26 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548bb51d40sm17103719f8f.0.2026.05.10.03.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 03:05:25 -0700 (PDT)
Message-ID: <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org>
Date: Sun, 10 May 2026 13:05:24 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
To: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org
Cc: idosch@nvidia.com, horatiu.vultur@microchip.com, kuba@kernel.org,
 henrik.bjoernlund@microchip.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, ronbogo@outlook.com,
 zylzyl2333@gmail.com
References: <cover.1778378864.git.zylzyl2333@gmail.com>
 <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/05/2026 12:15, Ren Wei wrote:
> From: Yilin Zhu <zylzyl2333@gmail.com>
> 
> CFM registers a bridge frame handler when the first MEP is created and
> unregisters it when the last MEP is deleted. The registered object also
> contains the hlist_node used by the bridge-local frame_type_list.
> 
> The CFM frame type is currently global, so enabling CFM on multiple
> bridges links the same hlist_node into multiple bridge-local lists. A
> later unregister on one bridge can then operate on list state belonging
> to another bridge.
> 
> Move the CFM frame type into struct net_bridge and register/unregister
> the bridge-owned object. This keeps frame handler list membership local
> to the bridge while preserving the existing first-MEP/last-MEP lifetime.
> 
> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>   net/bridge/br_cfm.c     | 14 ++++++--------
>   net/bridge/br_private.h | 18 +++++++++++-------
>   2 files changed, 17 insertions(+), 15 deletions(-)
> 

I think MRP suffers from the same bug, but I also think we can contain the
fix within the packet type structure instead of making the already huge
struct net_bridge even bigger. Also, linking a struct within net_bridge
to a list within the same net_bridge looks weird.

IMO br_add_frame should take a type & a frame_handler, allocate a br_frame_type
dynamically and link it, then br_del_frame should take a type instead of a ptr
and remove that frame type and free it with kfree_rcu. That would require
br_add_frame return value to be checked in the respective cfm/mrp functions.
Warnings for already existing types on add or missing types on del should be
added.

Would you please take care of MRP as well?

Cheers,
  Nik

> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> index 118c7ea48c35..547c7415c0ea 100644
> --- a/net/bridge/br_cfm.c
> +++ b/net/bridge/br_cfm.c
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
> @@ -558,8 +553,11 @@ int br_cfm_mep_create(struct net_bridge *br,
>   	INIT_HLIST_HEAD(&mep->peer_mep_list);
>   	INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
>   
> -	if (hlist_empty(&br->mep_list))
> -		br_add_frame(br, &cfm_frame_type);
> +	if (hlist_empty(&br->mep_list)) {
> +		br->cfm_frame_type.type = cpu_to_be16(ETH_P_CFM);
> +		br->cfm_frame_type.frame_handler = br_cfm_frame_rx;
> +		br_add_frame(br, &br->cfm_frame_type);
> +	}
>   
>   	hlist_add_tail_rcu(&mep->head, &br->mep_list);
>   
> @@ -588,7 +586,7 @@ static void mep_delete_implementation(struct net_bridge *br,
>   	kfree_rcu(mep, rcu);
>   
>   	if (hlist_empty(&br->mep_list))
> -		br_del_frame(br, &cfm_frame_type);
> +		br_del_frame(br, &br->cfm_frame_type);
>   }
>   
>   int br_cfm_mep_delete(struct net_bridge *br,
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index bed1b1d9b282..a3ed9ee826f5 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -61,6 +61,9 @@ typedef struct bridge_id bridge_id;
>   typedef struct mac_addr mac_addr;
>   typedef __u16 port_id;
>   
> +struct net_bridge_port;
> +struct sk_buff;
> +
>   struct bridge_id {
>   	unsigned char	prio[2];
>   	unsigned char	addr[ETH_ALEN];
> @@ -70,6 +73,13 @@ struct mac_addr {
>   	unsigned char	addr[ETH_ALEN];
>   };
>   
> +struct br_frame_type {
> +	__be16			type;
> +	int			(*frame_handler)(struct net_bridge_port *port,
> +						 struct sk_buff *skb);
> +	struct hlist_node	list;
> +};
> +
>   #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>   /* our own querier */
>   struct bridge_mcast_own_query {
> @@ -585,6 +595,7 @@ struct net_bridge {
>   	struct hlist_head		mrp_list;
>   #endif
>   #if IS_ENABLED(CONFIG_BRIDGE_CFM)
> +	struct br_frame_type	cfm_frame_type;
>   	struct hlist_head		mep_list;
>   #endif
>   };
> @@ -926,13 +937,6 @@ int nbp_backup_change(struct net_bridge_port *p, struct net_device *backup_dev);
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
>   void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
>   void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
>   

