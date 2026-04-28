Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B3449ECB
	for <bridge@lists.linux.dev>; Tue, 28 Apr 2026 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385452; cv=none; b=P0svDdNAd88cSlSLg6o9+31p3+mWsUG7CrufEt1ISQedygGtxyiSKbp5wdk6MzQWoutoTk75JvUirYvZM3ygsHgTDGW9YaEQ1csZemquP3CE8ms84KZsR0ZGZogSRCg0PrOAg3NGFB28op8WcD28QuDCEJHeIFomCt6ipEKPpUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385452; c=relaxed/simple;
	bh=s3do0e5rCtxlTF9/cwVfZsB+RqqAZt5EnzhjSA6Ajvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gckvPhUV+/rJbIPu18dCqB8IdcNNtly7SbSRyMDfVZR2zsUEoX653rmS6kmrAhPYhDxqZU+CRWnEmW51vBHiK36ZY48ZWd1nKMNGnyHR1sIkMlhVuLLYTP+Yr7o1lukmQOuYJ6HjkrlZhbj5wh3yf/mOgyQMX/x0xfAeU9qco0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzwF+35K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzwF+35K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777385449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tP7oo7RDQoK7h0JXxV4QJ2IDSooBXQffesJO77KHtBA=;
	b=RzwF+35KS2Pf/e8ubnaObSyT+epeZji7atgnu1uOA9hhJbly2Yn2JGFXhY+IvZcXTD1cgF
	oI2uaY8VfFUBdjB+ApfoWvhUHXr4bqKbeVrbI2sri9wX8pyogfxhtWTMvrJ+nc4+an53+7
	K9hYmGv99L7FmvEqB1h080j0zWmuMq0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-a_5Kxw06MW2pWPouOoxKVQ-1; Tue, 28 Apr 2026 10:10:48 -0400
X-MC-Unique: a_5Kxw06MW2pWPouOoxKVQ-1
X-Mimecast-MFC-AGG-ID: a_5Kxw06MW2pWPouOoxKVQ_1777385448
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd722c1a69so2059639085a.0
        for <bridge@lists.linux.dev>; Tue, 28 Apr 2026 07:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777385448; x=1777990248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tP7oo7RDQoK7h0JXxV4QJ2IDSooBXQffesJO77KHtBA=;
        b=b0FzIEnxMsGu8eheQV93FJ1CC7XJml0JTtMxfJofgvGJ6SuGK04pk2PST+FuC/ZvL1
         XGPSNjjaLfhrESKmDOj55myhsxpT3haIWeEPPG3NgzFb9E6GT5oS9z757S7Il6BZV4qo
         I+x4WUFEX8CfyY3UeryxuNzWHpqHBPR5qzyei6jCY0bUJ3eAKXqfjrlwARxs/um6PioZ
         wbOQ4ZEG7EQ9eTLIXhtSYHFtKruzVIPWZCx1SiCNHzzjw2btJQEsKRoupbth1RPgiQmx
         7e2LL+25/QTbPY/eMnYc2RaR17fMvViaVUsM2TBGrCpHEqlgRk83N83JvtfP4UuzBiF0
         Ofaw==
X-Forwarded-Encrypted: i=1; AFNElJ8hzaz3GZ07GCLYRMJniMrlpmM/Fqfgh8hZ0J5fj6Qco2COxPpqmRRlxUHAkfuZMBjfVuHX+w8=@lists.linux.dev
X-Gm-Message-State: AOJu0YxYOZ5FYK6kshvEqqQUaHQeKZG+9HdEwc/cyrEg7tFZYmyDy4yb
	ZPWNomr2tNnMRU1GWzTRJhCp1be0TdEQNKzMDOxnXWoc0NPT0fhvcBvFBcnj91P4UXOqFdleh8m
	foonCitJD4KuvbVk0y0z8KhZfgzwue2UMehPty9T5ix7iAmfFF/FyEEuyEg==
X-Gm-Gg: AeBDiesU4ATzPqkZdaLQwYJMvav8iH7YqyqW8dDja7W3Kb2ySR+CoaoXEoU7e/7VRcI
	KGjT+2e6B7Kyhhz2dhvcLmYQWF+Ag55zxC7nglZb92TkJIeI97R4fqAtN/grgASrhM/S63rzCkJ
	6YqwNTNnnkgs8FTpPvqbLs0jTZI+lObISFkKzRIjrtsz9B/+rffEZKlLL4DO6FAT56Sg6FU73Cw
	VTWuF5URd7apTcRcUF7Xzny316B82q35FplIlKUErBgRTApdnA2P8B6vmUiSv6m4Bp3DfoCbnF9
	uvyREojDT1LA4vFdcyQeku+heZEmAEGeUYpms0MPqUMdtlSXRR06GnP5yV030ETPB7G2jGTuyNm
	iSYw1fGzFJM4WSNyGZ3NSvGwhKh393nYi5F0A5MC2CnUP1mxUKhpUgXoi00k3sDIcJw==
X-Received: by 2002:a05:620a:4493:b0:8ea:addd:892e with SMTP id af79cd13be357-8f7d9a0f618mr406785485a.49.1777385447459;
        Tue, 28 Apr 2026 07:10:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4493:b0:8ea:addd:892e with SMTP id af79cd13be357-8f7d9a0f618mr406778585a.49.1777385446785;
        Tue, 28 Apr 2026 07:10:46 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c19ae61bsm204783085a.0.2026.04.28.07.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 07:10:46 -0700 (PDT)
Message-ID: <ba420053-c201-47a1-83af-6b092e46d6fb@redhat.com>
Date: Tue, 28 Apr 2026 16:10:43 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: mcast: Fix a false positive lockdep splat
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 razor@blackwall.org, horms@kernel.org, herbert@gondor.apana.org.au,
 linus.luessing@c0d3.blue
References: <20260426133435.207006-1-idosch@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260426133435.207006-1-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VCMEbHckesHQLtuK3SYalLZPaHBwC09N8pgiZeVbSNE_1777385448
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/26 3:34 PM, Ido Schimmel wrote:
> Connecting two bridges on the same system [1] can result in a lockdep
> splat [2].
> 
> The report is a false positive. Multicast queries are built and
> transmitted under the bridge multicast lock. When the outgoing port of
> one bridge is configured on top of another bridge, the transmit path
> re-enters bridge code and acquires the other bridge's multicast lock in
> order to snoop the query. Both lock instances share a single lockdep
> class, so lockdep flags the nested acquisition as an AA deadlock.
> 
> Giving each bridge its own lock class will not solve the problem: the
> reverse topology would produce an ABBA splat with the same pair of
> classes. It also consumes a lockdep key per bridge.
> 
> Instead, fix the problem by deferring the transmission of the queries to
> a workqueue. Build the skb and update querier state under the lock as
> before, then enqueue the skb on a per multicast context queue and
> schedule the work.

I must admit that introducing an additional WQ to fix a false positive
feels a bit overkill to me - even if I can't think of a better solution
on top of my head.

> Flush the work when the multicast context is de-initialized. At this
> stage the work cannot be requeued. There is no need to take a reference
> on skb->dev since the work cannot outlive the bridge or the bridge port.
> 
> Use the high priority workqueue to reduce the delay between the enqueue
> time and the transmission time. With default settings (i.e., querier
> interval - 255 seconds, query interval - 125 seconds) the extra delay
> should not be a problem.
> 
> [1]
> ip link add name br1 up type bridge mcast_snooping 1 mcast_querier 1
> ip link add name br0 up type bridge mcast_snooping 1 mcast_querier 1
> ip link add link br0 name br0.10 up master br1 type vlan id 10
> 
> [2]
> ============================================
> WARNING: possible recursive locking detected
> 7.0.0-virtme-gb50c64a58a90 #1 Not tainted
> --------------------------------------------

checkpatch reports that the above separator may break tool. Possibly
just remove it from the commit message.

> ip/339 is trying to acquire lock:
> ffff888104f0b480 (&br->multicast_lock){+.-.}-{3:3}, at: br_ip6_multicast_query (net/bridge/br_multicast.c:3584)
> 
> but task is already holding lock:
> ffff888104f03480 (&br->multicast_lock){+.-.}-{3:3}, at: br_multicast_port_query_expired (net/bridge/br_multicast.c:1904)
> 
> [...]
> 
> Call Trace:
> [...]
> br_ip6_multicast_query (net/bridge/br_multicast.c:3584)
> br_multicast_ipv6_rcv (net/bridge/br_multicast.c:3988)
> br_dev_xmit (net/bridge/br_device.c:98 (discriminator 1))
> dev_hard_start_xmit (./include/linux/netdevice.h:5343 ./include/linux/netdevice.h:5352 net/core/dev.c:3888 net/core/dev.c:3904)
> __dev_queue_xmit (./include/linux/netdevice.h:3619 net/core/dev.c:4871)
> vlan_dev_hard_start_xmit (net/8021q/vlan_dev.c:131 (discriminator 1))
> dev_hard_start_xmit (./include/linux/netdevice.h:5343 ./include/linux/netdevice.h:5352 net/core/dev.c:3888 net/core/dev.c:3904)
> __dev_queue_xmit (./include/linux/netdevice.h:3619 net/core/dev.c:4871)
> br_dev_queue_push_xmit (net/bridge/br_forward.c:60)
> __br_multicast_send_query (net/bridge/br_multicast.c:1811 (discriminator 1))
> br_multicast_send_query (net/bridge/br_multicast.c:1889)
> br_multicast_port_query_expired (./include/linux/spinlock.h:390 net/bridge/br_multicast.c:1914)
> call_timer_fn (./arch/x86/include/asm/jump_label.h:37 ./include/trace/events/timer.h:127 kernel/time/timer.c:1749)
> [...]
> 
> Fixes: eb1d16414339 ("bridge: Add core IGMP snooping support")
> Reported-by: syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/000000000000c4c9d405f2643e01@google.com/
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_multicast.c | 39 +++++++++++++++++++++++++++++++++++----
>  net/bridge/br_private.h   |  4 ++++
>  2 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 881d866d687a..252c46977ed5 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1776,6 +1776,28 @@ static void br_multicast_select_own_querier(struct net_bridge_mcast *brmctx,
>  #endif
>  }
>  
> +static void br_multicast_port_query_queue_work(struct work_struct *work)
> +{
> +	struct net_bridge_mcast_port *pmctx;
> +	struct sk_buff *skb;
> +
> +	pmctx = container_of(work, struct net_bridge_mcast_port,
> +			     query_queue_work);
> +	while ((skb = skb_dequeue(&pmctx->query_queue)))
> +		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, dev_net(skb->dev),
> +			NULL, skb, NULL, skb->dev, br_dev_queue_push_xmit);
> +}
> +
> +static void br_multicast_query_queue_work(struct work_struct *work)
> +{
> +	struct net_bridge_mcast *brmctx;
> +	struct sk_buff *skb;
> +
> +	brmctx = container_of(work, struct net_bridge_mcast, query_queue_work);
> +	while ((skb = skb_dequeue(&brmctx->query_queue)))
> +		netif_rx(skb);
> +}
> +
>  static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
>  				      struct net_bridge_mcast_port *pmctx,
>  				      struct net_bridge_port_group *pg,
> @@ -1804,9 +1826,8 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
>  		skb->dev = pmctx->port->dev;
>  		br_multicast_count(brmctx->br, pmctx->port, skb, igmp_type,
>  				   BR_MCAST_DIR_TX);
> -		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT,
> -			dev_net(pmctx->port->dev), NULL, skb, NULL, skb->dev,
> -			br_dev_queue_push_xmit);
> +		skb_queue_tail(&pmctx->query_queue, skb);
> +		queue_work(system_highpri_wq, &pmctx->query_queue_work);

Also the AI reported concerns vs unbounded queue len looks relevant.
Usually the RX path is slower than TX, but i.e. asymmetric filtering
rules could reverse the scenario.

/P

