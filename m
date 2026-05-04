Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB39630B514
	for <bridge@lists.linux.dev>; Mon,  4 May 2026 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880540; cv=none; b=C+L2IC4MjvEnStFyMTMPVsfL/zuGe7Ph+eiBR4at1g6rq1n3Fm2bF4neN+GFsz7p9GwS08nL5MCCcFHj6fcOUVu7vJDiMFe8YrqemxRixeSixlrGMWcJIkv2wWNeUylPkv5EDFnh7eu2xZoDRoC2+0ojN6Hr0Xgm8d/ThTWmCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880540; c=relaxed/simple;
	bh=hHzDI6EMEZ3+srDe6h4vdcHCJcs8q+VRUhyZDMfJZv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8IwQiR2SUg3a2yBVNQylp7777f4ACZ3XKhkA5P1k+daLdQQLI44xb87U4OnDLJ+UjN2UdQyI4FLh66bH8g4hPDbuusj6Rf1W43pSiv9qYd8Mib6RfdQ3iDA+Y6in2OxOjoWx42KpjqzQKBlb8dBuuzNxLpqFr1DuW0D2MCvZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Za/FSb4Q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Za/FSb4Q"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48d102471a4so2944565e9.2
        for <bridge@lists.linux.dev>; Mon, 04 May 2026 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777880537; x=1778485337; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNrn/1ULknS0mXajard4wubGCARfDXT/OU6gNTwLGDM=;
        b=Za/FSb4QcLbMHwOyHIWxPRT3TTv+28yZuzE5nVttVzoFuWlcZ7YaRqkcRaZ5shV9lN
         MVgdszPey2bKR+jtBv3wCDnQ83uqkDbEkTM01KvQJO4MHlyB6LPxGjLAjWTDNbhTsajF
         mnjnexrS5LbHGl7EYvqnJUgEa93VvL5FzCs8UEd+pAYLIGdPh+oR++betoyFRWjpoNpz
         bza0ezkwI1nmZHI/gvA0pnfyBWW+at21PEh2CRUxzwmbSB3JE0rOYvfOveazJYnpRJLY
         WeqdiBioj7Zye7AtEdI8tQQrBwzguVCH6oS81WnSiCk0qGEAG+RH5N51o9/hzS8zg5Y+
         0UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880537; x=1778485337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNrn/1ULknS0mXajard4wubGCARfDXT/OU6gNTwLGDM=;
        b=NiDU0MaPnX2IM0ThLmRhoHZ3iLFah4ojdT6xzf0esodAqcxmhd9BWR+/MJCBqGxXYg
         BGeX1W/jXwGQhb7LonC5OIn0IX4b1AWbEYOIva5sbcGyadFmZkVSnMNyCTm4rWf4yGMQ
         137Qf5JwlFPNZERZMzDVG3YcVjUp3JIxy3LsPIl87JUsLuctMMX27y49FEm6TI4PslBz
         iR1/zamHfuSRm/4OQOmSp6lU+c6+A3xKh/NtH12SCR0y2nVyaCBCNgwQAaPTht8hT/pG
         vGKsdXtsQ8+wbG0uX1C2NETdPAFOaMEHLRwFNicp7HcO+XXnAhH/vCdBxDu92wR6PrKU
         Z6rA==
X-Forwarded-Encrypted: i=1; AFNElJ/i2sNxo0A7O+Uj47+qeFSo6lKHA6ynUcj37STno2aeOB384bZ/bWjWV35z1riPKxQsDrNZxWw=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywz/XFfC189phCRlvQS6tQ+K6DQgl+an4qIthwN6+2npz8nVDF8
	BTa0IKKFMh0ZwlS5eXM4D14C94XfdSYUudXqsv4voe4mOJnaMo0OURluczden1QGXyw=
X-Gm-Gg: AeBDievMgrJL9uHqdf0+wud6/1lfVuS2epdnUG9/iiyaLlWzqr6WseKR5+1X65bE8bd
	fPg6cTM2JpsqJwawLAb88L1GsmAOvoBJWOFz6uUR+yoQTjC/Rvs5OJlpocmDbO5tmS1q+qd53sO
	mpAUsP19U4V4t7Ww4MBdSByZc9uVQwbX1GnwSREBcBfTRSXOQv9tEejBYoK5eNicwnpmaC2wuiT
	P/2Au9Og7iiiWqrxwHxyrjhBZcYeF9S1W0IVOwDFeLRQ+rTmyad5ByIepfI0hbkluPrFaBklj0F
	2OjdnuNvfPE8FjWEVGI3jzbN1gqV7O+NzmO6qGKs2AnWLq0hR60XyCt/Uuvqi9JesvMJ1EaN5XI
	87hVswg/aFvNE6UD98+qYb/uuJBmepZlEDyjwWWxQs48AzquskBlkqa76/yel0l+iaYCvRV2pBI
	4G92VF3r5G/1q8a8iYG42Mjbv9WdH6TDi3t5cGbf4wR3RoUP/zBXlI1vR8VhSlOfMygLbbvP/GI
	iU=
X-Received: by 2002:a05:600c:4342:b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-48c6d455f69mr68414675e9.2.1777880537124;
        Mon, 04 May 2026 00:42:17 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fe3cae3sm100998215e9.0.2026.05.04.00.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:42:16 -0700 (PDT)
Message-ID: <ed569c78-129b-4db4-8a73-e1728a6d5032@blackwall.org>
Date: Mon, 4 May 2026 10:42:14 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] bridge: Add port-level netlink handling for
 neigh_forward_grat
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, ast@fiberby.net,
 liuhangbin@gmail.com, daniel@iogearbox.net, aroulin@nvidia.com,
 fmaurer@redhat.com, sdf.kernel@gmail.com, sd@queasysnail.net,
 kees@kernel.org, nickgarlis@gmail.com, amorenoz@redhat.com,
 alasdair@mcwilliam.dev, johannes.wiesboeck@aisec.fraunhofer.de,
 petrm@nvidia.com, linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260503073532.2138165-1-danieller@nvidia.com>
 <20260503073532.2138165-5-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260503073532.2138165-5-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/05/2026 10:35, Danielle Ratson wrote:
> Add netlink handlers for the port-level neigh_forward_grat option via
> IFLA_BRPORT_NEIGH_FORWARD_GRAT attribute.
> 
> The default value of OFF preserves existing behavior, i.e. gratuitous ARP
> and unsolicited NA are suppressed when neigh_suppress is enabled. Users can
> explicitly set it to ON to allow these packets through.
> 
> Example for enabling control via 'bridge link' command:
>   # bridge link set dev eth0 neigh_suppress on
>   # bridge link set dev eth0 neigh_forward_grat on
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/bridge/br_netlink.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 6fd5386a1d64..898326c201ef 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -190,6 +190,7 @@ static inline size_t br_port_info_size(void)
>   		+ nla_total_size(1)	/* IFLA_BRPORT_LOCKED */
>   		+ nla_total_size(1)	/* IFLA_BRPORT_MAB */
>   		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_VLAN_SUPPRESS */
> +		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_FORWARD_GRAT */
>   		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_ROOT_ID */
>   		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_BRIDGE_ID */
>   		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_DESIGNATED_PORT */
> @@ -282,7 +283,9 @@ static int br_port_fill_attrs(struct sk_buff *skb,
>   	    nla_put_u8(skb, IFLA_BRPORT_LOCKED, !!(p->flags & BR_PORT_LOCKED)) ||
>   	    nla_put_u8(skb, IFLA_BRPORT_MAB, !!(p->flags & BR_PORT_MAB)) ||
>   	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
> -		       !!(p->flags & BR_NEIGH_VLAN_SUPPRESS)))
> +		       !!(p->flags & BR_NEIGH_VLAN_SUPPRESS)) ||
> +	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_FORWARD_GRAT,
> +		       !!(p->flags & BR_NEIGH_FORWARD_GRAT)))
>   		return -EMSGSIZE;
>   
>   	timerval = br_timer_value(&p->message_age_timer);
> @@ -902,6 +905,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
>   	[IFLA_BRPORT_MCAST_MAX_GROUPS] = { .type = NLA_U32 },
>   	[IFLA_BRPORT_NEIGH_VLAN_SUPPRESS] = NLA_POLICY_MAX(NLA_U8, 1),
>   	[IFLA_BRPORT_BACKUP_NHID] = { .type = NLA_U32 },
> +	[IFLA_BRPORT_NEIGH_FORWARD_GRAT] = NLA_POLICY_MAX(NLA_U8, 1),
>   };
>   
>   /* Change the state of the port and notify spanning tree */
> @@ -970,6 +974,8 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
>   	br_set_port_flag(p, tb, IFLA_BRPORT_MAB, BR_PORT_MAB);
>   	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
>   			 BR_NEIGH_VLAN_SUPPRESS);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_FORWARD_GRAT,
> +			 BR_NEIGH_FORWARD_GRAT);
>   
>   	if ((p->flags & BR_PORT_MAB) &&
>   	    (!(p->flags & BR_PORT_LOCKED) || !(p->flags & BR_LEARNING))) {

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

