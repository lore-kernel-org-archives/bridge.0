Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADAD33C9
	for <bridge@lists.linux.dev>; Mon, 14 Oct 2024 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887733; cv=none; b=GnQUSDkAoccVWeTUKCT8aoGmR0My9kDaXDgud53mykxZu5TEi/tlqOYbt/WyReC2fDOxboG0xGLxI36WQV4XEY07kOIxYb8LKgMHzh7rmhbXPNoE2JwVxXBdQj22O3fSyHpCgAML3Zo9d9LcXBQsqM+OgiRHmm4BdxTWB73dXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887733; c=relaxed/simple;
	bh=ZGBoVdbwgat/NxUEjyYnv4uZ19nNnybh9UIeSIN7bUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOpU/VrioEgcmr6aQmniyj6uwVaX7xuZQSVfcBF0dwRUwn/ufKmUw7UN++aUjTYlSbfNHApI815/excB/sEHov8R8nsTuK+4q/8c+6e7h4DJc1rdb45UaNNHDWTRtM6b3Juhun3SkcgNQJSmYVW36nxaAOM5eigNXx++mvZ5UPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=TJwJffll; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="TJwJffll"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c973697b52so1161544a12.0
        for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 23:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728887729; x=1729492529; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzkqcrvTVaKqpqDByKdgad826mxzpVo//v8QIefMOL8=;
        b=TJwJffllp2wosYGKSSck/s8xtED5IgAIv6t5b9V/i3IWSqW1us4NZ/YWj4J+N81Tti
         8zVOdqSOxwwc3X6LXx5etiY0EoeKN/LyyfsIgw4vL0QwUHC4iWFO8zOB+/INkuB4yARV
         PfQFoOJ16DyT84RZI3GtVRQDsBPvgW+CldyhWaIp6HZUGY2nuao7WZktENStnLNGA109
         B5lCj8ZzzdFQQ/MF4ct2YdTaHyApw2RrUHLUX6TvcMTjjsW/LMXOqpc1ol4jGcpbeDxJ
         EvitWeGX02z2qpvD2x6GKL20NDIoChKnnb6ZmBBZg+TbdY6xBcrprmMOeIs7/xlgXqRT
         8/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728887729; x=1729492529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzkqcrvTVaKqpqDByKdgad826mxzpVo//v8QIefMOL8=;
        b=M1Sy++GSnrRhG6ID/5IFQe2jfvQspWMkBinYya2rk3G4JX0PIzQKV6B4ZGrIxHsdb2
         5GtOIWWuAGMnjQgPTX1FTexr0uwYokWuWWgDXIxqJeFh5L54691uY2DQdTh4IhaIIOxR
         I3XRfd7+ZMrupMqWfAV1wxecWNZtwCk/ee4o9XLvP2Pim9264Dnmud/6y6KKzC2yofVY
         9gAq3Cz7CjwzoEpZ36Kvhn0yVHZUZdL2sCzNV3k/Z9WrxMMgbWZ52JQyddd8zFuw+UZy
         B/X+X8s2xUb+bbYL606S80OblXBASgEaSUGPw1mvCAv4SUxlLdGmROiazAGj+kjzJZnN
         3P7A==
X-Forwarded-Encrypted: i=1; AJvYcCWNKZj0WAMVzkrGpxAhnCe0w975zmJUeKZCSXsfK5t+7VFbG1cGCN6avqFnhg3ToGMo09mZFGg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx66NBCm0bUUV+I7bIvu0KXXIdzwc1GP4TwYSCpkL4hdl1ZXj6a
	oxaoajiam7hQ9r6/vMQE8IkTwrqUXMR3NWnyZRocC+7LDX2pCZIn0QvB6tKBB6c=
X-Google-Smtp-Source: AGHT+IHtsfhY77d2hmhJ/UeBZXQQAahrdwUCAyfXzQzRvrPqdSAngDAVOM6fkmoaHNagJzIo6u/AkQ==
X-Received: by 2002:a17:907:d01:b0:a99:403e:2578 with SMTP id a640c23a62f3a-a99b9313475mr1017156666b.5.1728887728814;
        Sun, 13 Oct 2024 23:35:28 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99ee8da1besm278784766b.216.2024.10.13.23.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 23:35:28 -0700 (PDT)
Message-ID: <9f9f3cf0-7a78-40f1-b8d5-f06a2d428210@blackwall.org>
Date: Mon, 14 Oct 2024 09:35:26 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 net-next 00/12] bridge-fastpath and related
 improvements
To: Eric Woudstra <ericwouds@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241013185509.4430-1-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241013185509.4430-1-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/2024 21:54, Eric Woudstra wrote:
> This patchset makes it possible to set up a (hardware offloaded) fastpath
> for bridged interfaces.
> 

The subject and this sentence are misleading, you're talking about netfilter bridge
fastpath offload, please mention it in both places. When you just say bridge fast
path, I think of the software fast path.

> To set up the fastpath with offloading, add this extra flowtable:
> 
> table bridge filter {
>         flowtable fb {
>                 hook ingress priority filter
>                 devices = { lan0, lan1, lan2, lan3, lan4, wlan0, wlan1 }
>                 flags offload
>         }
>         chain forward {
>                 type filter hook forward priority filter; policy accept;
> 		ct state established flow add @fb
>         }
> }
> 
> Creating a separate fastpath for bridges.
> 
>          forward fastpath bypass
>  .----------------------------------------.
> /                                          \
> |                        IP - forwarding    |
> |                       /                \  v
> |                      /                  wan ...
> |                     /
> |                     |
> |                     |
> |                   brlan.1
> |                     |
> |    +-------------------------------+
> |    |           vlan 1              |
> |    |                               |
> |    |     brlan (vlan-filtering)    |
> |    +---------------+               |
> |    |  DSA-SWITCH   |               |
> |    |               |    vlan 1     |
> |    |               |      to       |
> |    |   vlan 1      |   untagged    |
> |    +---------------+---------------+
> .         /                   \
>  ------>lan0                 wlan1
>         .  ^                 ^
>         .  |                 |
>         .  \_________________/
>         .  bridge fastpath bypass
>         .
>         ^
>      vlan 1 tagged packets
> 
> To have the ability to handle xmit direct with outgoing encaps in the
> bridge fastpass bypass, we need to be able to handle them without going
> through vlan/pppoe devices. So I've applied, amended and squashed wenxu's
> patchset. This patch also makes it possible to egress from vlan-filtering
> brlan to lan0 with vlan tagged packets, if the bridge master port is doing
> the vlan tagging, instead of the vlan-device. Without this patch, this is
> not possible in the bridge-fastpath and also not in the forward-fastpath,
> as seen in the figure above.
> 
> There are also some more fixes for filling in the forward path. These
> fixes also apply to for the forward-fastpath. They include handling
> DEV_PATH_MTK_WDMA in nft_dev_path_info() and avoiding
> DEV_PATH_BR_VLAN_UNTAG_HW for bridges with ports that use dsa.
> 
> Conntrack bridge only tracks untagged and 802.1q. To make the bridge
> fastpath experience more similar to the forward fastpath experience,
> I've added double vlan, pppoe and pppoe-in-q tagged packets to bridge
> conntrack and to bridge filter chain.
> 
> Eric Woudstra (12):
>   netfilter: nf_flow_table_offload: Add nf_flow_encap_push() for xmit
>     direct
>   netfilter: bridge: Add conntrack double vlan and pppoe
>   netfilter: nft_chain_filter: Add bridge double vlan and pppoe
>   bridge: br_vlan_fill_forward_path_pvid: Add port to port
>   bridge: br_fill_forward_path add port to port
>   net: core: dev: Add dev_fill_bridge_path()
>   netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
>   netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
>   netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
>   netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to
>     nft_dev_path_info()
>   bridge: br_vlan_fill_forward_path_mode no _UNTAG_HW for dsa
>   netfilter: nft_flow_offload: Add bridgeflow to nft_flow_offload_eval()
> 
>  include/linux/netdevice.h                  |   2 +
>  include/net/netfilter/nf_flow_table.h      |   3 +
>  net/bridge/br_device.c                     |  20 ++-
>  net/bridge/br_private.h                    |   2 +
>  net/bridge/br_vlan.c                       |  24 +++-
>  net/bridge/netfilter/nf_conntrack_bridge.c |  86 ++++++++++--
>  net/core/dev.c                             |  77 +++++++++--
>  net/netfilter/nf_flow_table_inet.c         |  13 ++
>  net/netfilter/nf_flow_table_ip.c           |  96 ++++++++++++-
>  net/netfilter/nf_flow_table_offload.c      |  13 ++
>  net/netfilter/nft_chain_filter.c           |  20 ++-
>  net/netfilter/nft_flow_offload.c           | 154 +++++++++++++++++++--
>  12 files changed, 463 insertions(+), 47 deletions(-)
> 

