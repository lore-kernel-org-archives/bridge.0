Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA36217F27;
	Tue, 28 Apr 2026 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383340; cv=none; b=l2Z5ZC43B0r5zyb8lSwurVuRHmDaK9NorE6IGkFQvbnAqNDVKDhtcIMYYftIrXH3EOYrPL5JQwSJcSGmrG93hEWg4sq5vOmp9NqXPidNvLq8DgllXObEv/+JnhqXupfH0w3manwKw9e3csREsB20V71usaDCmtpOBlKtn9aDVVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383340; c=relaxed/simple;
	bh=Ra0veIFQ1tCfMufKmtFI29V/mH1Q5JGW0chyOGSq15g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOr+pEB6xxOo0qJHWYLWq2iGLiPGzXB8XXp8tyqnZ1a0XqZDNxAxb5odOeq+SIIfCiFsx7zPTP/hV8rm8NE85MOAUBCcjXtK9JMesnfCmzqJ5o1YuckrzDRQz08sari6fRBl3WZhKWWXjY08SiTlCsnXUmGK5EzkSxIDyXZ8BUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0AqR9O1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0AqR9O1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6181CC2BCAF;
	Tue, 28 Apr 2026 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777383340;
	bh=Ra0veIFQ1tCfMufKmtFI29V/mH1Q5JGW0chyOGSq15g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0AqR9O1zYoKDaYE25RXOXUj1QDpNc4ktm2+kZb1sEC+eMtprhQojeT0rJvwAlhpM
	 AhF+BfNxV1T9DsEC45FqiVyBYC/DsPS0i5tN3AGHk+AbMzxOaIMLTFsT3Js7QlWJ8R
	 /wjlhuu9sEyr1RNl/AKVQRqRMqt9g5h8tPBr54YCDYK7iVTh8SlLMbfOeQ7wQ4h6hG
	 bTqCgXzUAbpGkUBoUDd9FMhA7ZYanDlh15Gnozcs7tFL5jE1FQPs2+iUou/JYKBZXS
	 3PLCPkdVx5xZvvOMybTgEeW/u2RtgjaIYrati6DEvpEoAbcKujq4bH6/D2CstXrjOV
	 eaz02OrzOWFTw==
From: Simon Horman <horms@kernel.org>
To: idosch@nvidia.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	razor@blackwall.org,
	herbert@gondor.apana.org.au,
	linus.luessing@c0d3.blue
Subject: Re: [PATCH net] bridge: mcast: Fix a false positive lockdep splat
Date: Tue, 28 Apr 2026 14:35:23 +0100
Message-ID: <20260428133523.1321335-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426133435.207006-1-idosch@nvidia.com>
References: <20260426133435.207006-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
bridge: mcast: Fix a false positive lockdep splat

This commit defers the transmission of multicast queries to a high priority
workqueue to avoid a false positive lockdep splat caused by nested bridge
multicast lock acquisitions. It queues skbs to a per-context query_queue
and flushes them asynchronously.

Closes: https://lore.kernel.org/netdev/000000000000c4c9d405f2643e01@google.com/

> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 881d866d687a..252c46977ed5 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c

[ ... ]

> @@ -1804,9 +1826,8 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
>  		skb->dev = pmctx->port->dev;
>  		br_multicast_count(brmctx->br, pmctx->port, skb, igmp_type,
>  				   BR_MCAST_DIR_TX);
> -		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT,
> -			dev_net(pmctx->port->dev), NULL, skb, NULL, skb->dev,
> -			br_dev_queue_push_xmit);
> +		skb_queue_tail(&pmctx->query_queue, skb);
> +		queue_work(system_highpri_wq, &pmctx->query_queue_work);

Can this code cause an out-of-memory condition if flooded with IGMP/MLD
Leave packets?

In the IGMP data path, br_multicast_leave_group() is triggered for each
received Leave packet. If the bridge is the active querier, it directly calls
__br_multicast_send_query() for each packet, which allocates a new query skb
and queues it here using skb_queue_tail().

Because the workqueue execution handles TX networking overhead, could softirq
RX packet processing outpace the workqueue's ability to dequeue them?

Since skb_queue_tail() does not impose any limits on the queue length, it
looks like this might result in an unbounded accumulation of skbs in the
query queue, potentially bypassing standard qdisc backpressure mechanisms and
exhausting system memory.

>  
>  		if (over_lmqt && with_srcs && sflag) {
>  			over_lmqt = false;
> @@ -1816,7 +1837,8 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
>  		br_multicast_select_own_querier(brmctx, group, skb);
>  		br_multicast_count(brmctx->br, NULL, skb, igmp_type,
>  				   BR_MCAST_DIR_RX);
> -		netif_rx(skb);
> +		skb_queue_tail(&brmctx->query_queue, skb);
> +		queue_work(system_highpri_wq, &brmctx->query_queue_work);
>  	}
>  }
