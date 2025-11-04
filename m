Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95F2459E5
	for <bridge@lists.linux.dev>; Tue,  4 Nov 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258870; cv=none; b=U4Qqu+htH8L8svbp9pNGBIMBGIUmGLbTwhZ42RD56+mNVO+BfGj5CvydFVhYeJf5oIVA4NBy6ERe9xgdhgcluwuVHA3cfLG96XqAFUgpXuEj+Ed2VP4ESCv5JFzyA2Y9WLD5Fp9/Z0N7aN5KxyZG7YqJQbDsQMpn8+edqZYW3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258870; c=relaxed/simple;
	bh=7/iFG5WAzUfDx6M3aJ8HMxRqjLannXvtDd7sxFaC5ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVG9WDuxU19udnp69jBU76slS0JCnT3hPlp8JrHIxP2sspo8zc3u+yJoOdko5UGmM7rwEiq/W0wyspbPW/2kqk85reLWO/uoaW6MXhzkK+9Q8qN+JkFICcBiOmoFTJbqXIo6mGduT/NxSLUkKAkpNneTU5iH12atrTZRWWIOEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bx4vjE/o; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="bx4vjE/o"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so3503631a12.0
        for <bridge@lists.linux.dev>; Tue, 04 Nov 2025 04:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762258865; x=1762863665; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIVUgC/iS+GQBOZrHTrQQryq92A92IQg/Ogu+NF5aA0=;
        b=bx4vjE/o9jOhv+9tQYTcY6lO3EQPzxCrQhFmjuy643FllylHg9x5VSM7zOrRdqWAjb
         vb3MMqcabXtb3o7QHWWbWlJK5lwJCjgHAovgLLSVOE6qVaSGJxk8mVxsPNGJqPxUcjF3
         C2muFlCMpqxKGq/rPxHysk0Rvoih59o3fHACIbPwkxJF6f2UaK1SQ5FF45AEJmM3V69k
         jN0XZCToERUaXYYDDNYdTg1mj0e0PPSShLo9nSiDmV14hcRZabLGqO+GnPIqssqrn7Mn
         glExXcFyAXH7116ZzcG1UryeJ3cA5HQ8B+tL+DoNjmaKtEF0QOzra7DTqsn26N1F/G+g
         95ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762258865; x=1762863665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIVUgC/iS+GQBOZrHTrQQryq92A92IQg/Ogu+NF5aA0=;
        b=BG7gkPO5lLW1Bs8HKID39yuUy3TAKt4cCIoO/ckaE+HmBMiA7Ku/slMRkDEHKMekBa
         dFTqFSQekFeP1cKNL5+16vj4QtI6uif9dJLebjOyRGxLaUf8IKW6XyniVRBSerJofSEJ
         bkCoci1MbA82W/XLDP+fLo23QdMcco6mfhzZzrqGD9stsJbSrhAa13AAlvLP9R2qSEsi
         h54Yfta5C0nif//LedbVWo+G2np4u510fuAZ4EOEQBHefBkxUB7y3ZbMzw5M6jxC1xVe
         LADM9D4CJTBFvgGTz4e7el6B11OlXwSLPPZ4CbVlg4gGBu3bGpnmyme1cC2x7TW2sD2N
         KjPA==
X-Forwarded-Encrypted: i=1; AJvYcCWtjBGkl+AD1/TYGFqulhmWznfCbvWDtHBYhjkJrpzoFMpzxnZC5W/1NS0dothPO5/eBbQbukc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwGB4zStE09LnG+riojoQkZ6s4RbWvMguaylJLo+koh9JT08q4k
	n345p8Kf4yxT+bdHCpd11l3zn9G2tSfhz03PntTsPh+bx1moMh29XByjwQm+6AbB1mA=
X-Gm-Gg: ASbGncuYVbY2b4m5KclR6sXSnSDLs1D0OD4ipyed8Lv64dqwsydhWa6THGi8CcGa1fJ
	acMKCK+0zXpsjgw610vyVQYC0wr++xdF5Uy1VsPDJJh9Jd6c1phExgnr3UAmX052yw4b67D01xI
	/8/bPmH+PtYytfM9ZM5go93ZTLiToiB+8zepTGlx5lNGVkn46RENyvuWesfEnSdK3P5UvQGzbIB
	QttjzyKRCGSOiIIaJaJUNWqy2xaw7XdtkBAFKQwakCoKMg0HzqygapPsKIAxHB0XZ+kQibr/bxp
	erMOEObV9ooRh/QzejMfVRaBTs69qCFGmtcPB7ZHSSw55Tit4ckmY0JMc56LLYEzx73xBaa1M6E
	D2s2aPJzc4x6IFB+LE9ONlhtPkIBYKzACHOKHwby7AxzuJvkaINTutSVdOnmA2fXt+Wpcwu4aKg
	3iTquSFyNGA30xqlyMk73c9iQ3fQG5svky
X-Google-Smtp-Source: AGHT+IENWRfmlV9P17N5ZlhgCIeMTm8nEfcZT9bxZ2XnEMDFm4tmpuNEJmNOAIW98mTrbihiyO83MQ==
X-Received: by 2002:a05:6402:13c5:b0:634:ce70:7c5 with SMTP id 4fb4d7f45d1cf-64077040ccbmr13947262a12.17.1762258865100;
        Tue, 04 Nov 2025 04:21:05 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640ff615e64sm46612a12.28.2025.11.04.04.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:21:04 -0800 (PST)
Message-ID: <87bb6973-26e5-46c7-8253-3a5eb636dd6a@blackwall.org>
Date: Tue, 4 Nov 2025 14:21:03 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: bridge: fix use-after-free due to MST port
 state bypass
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com, idosch@nvidia.com, kuba@kernel.org,
 davem@davemloft.net, bridge@lists.linux.dev, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org,
 syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
References: <20251104120313.1306566-1-razor@blackwall.org>
 <20251104120313.1306566-2-razor@blackwall.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251104120313.1306566-2-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 14:03, Nikolay Aleksandrov wrote:
> syzbot reported[1] a use-after-free when deleting an expired fdb. It is
> due to a race condition between learning still happening and a port being
> deleted, after all its fdbs have been flushed. The port's state has been
> toggled to disabled so no learning should happen at that time, but if we
> have MST enabled, it will bypass the port's state, that together with VLAN
> filtering disabled can lead to fdb learning at a time when it shouldn't
> happen while the port is being deleted. VLAN filtering must be disabled
> because we flush the port VLANs when it's being deleted which will stop
> learning. This fix avoids adding more checks in the fast-path and instead
> toggles the MST static branch when changing VLAN filtering which
> effectively disables MST when VLAN filtering gets disabled, and re-enables
> it when VLAN filtering is enabled && MST is enabled as well.
> 
> [1] https://syzkaller.appspot.com/bug?extid=dd280197f0f7ab3917be
> 
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Reported-by: syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69088ffa.050a0220.29fc44.003d.GAE@google.com/
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
> Initially I did look into moving the rx handler
> registration/unregistration but that is much more difficult and
> error-prone. This solution seems like the cleanest approach that doesn't
> affect the fast-path.
> 
>  net/bridge/br_mst.c     | 18 +++++++++++++-----
>  net/bridge/br_private.h |  5 +++++
>  net/bridge/br_vlan.c    |  1 +
>  3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
> index 3f24b4ee49c2..4abf8551290f 100644
> --- a/net/bridge/br_mst.c
> +++ b/net/bridge/br_mst.c
> @@ -194,6 +194,18 @@ void br_mst_vlan_init_state(struct net_bridge_vlan *v)
>  		v->state = v->port->state;
>  }
>  
> +void br_mst_static_branch_toggle(struct net_bridge *br)
> +{
> +	/* enable the branch only if both VLAN filtering and MST are enabled
> +	 * otherwise port state bypass can lead to learning race conditions
> +	 */
> +	if (br_opt_get(br, BROPT_VLAN_ENABLED) &&
> +	    br_opt_get(br, BROPT_MST_ENABLED))
> +		static_branch_enable(&br_mst_used);
> +	else
> +		static_branch_disable(&br_mst_used);
> +}
> +
>  int br_mst_set_enabled(struct net_bridge *br, bool on,
>  		       struct netlink_ext_ack *extack)
>  {
> @@ -224,11 +236,7 @@ int br_mst_set_enabled(struct net_bridge *br, bool on,
>  	if (err && err != -EOPNOTSUPP)
>  		return err;
>  
> -	if (on)
> -		static_branch_enable(&br_mst_used);
> -	else
> -		static_branch_disable(&br_mst_used);
> -
> +	br_mst_static_branch_toggle(br);
>  	br_opt_toggle(br, BROPT_MST_ENABLED, on);
>  	return 0;
>  }
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 16be5d250402..052bea4b3c06 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1952,6 +1952,7 @@ int br_mst_fill_info(struct sk_buff *skb,
>  		     const struct net_bridge_vlan_group *vg);
>  int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
>  		   struct netlink_ext_ack *extack);
> +void br_mst_static_branch_toggle(struct net_bridge *br);
>  #else
>  static inline bool br_mst_is_enabled(struct net_bridge *br)
>  {
> @@ -1987,6 +1988,10 @@ static inline int br_mst_process(struct net_bridge_port *p,
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline void br_mst_static_branch_toggle(struct net_bridge *br)
> +{
> +}

oh, just realized this is actually unnecessary since MST relies on bridge vlan filtering
to be enabled, I will wait 24h for feedback and post v2 without this

>  #endif
>  
>  struct nf_br_ops {
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index ce72b837ff8e..636d11f932eb 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -911,6 +911,7 @@ int br_vlan_filter_toggle(struct net_bridge *br, unsigned long val,
>  	br_manage_promisc(br);
>  	recalculate_group_addr(br);
>  	br_recalculate_fwd_mask(br);
> +	br_mst_static_branch_toggle(br);
>  	if (!val && br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
>  		br_info(br, "vlan filtering disabled, automatically disabling multicast vlan snooping\n");
>  		br_multicast_toggle_vlan_snooping(br, false, NULL);

