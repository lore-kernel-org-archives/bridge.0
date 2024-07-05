Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14313FD99
	for <bridge@lists.linux.dev>; Fri,  5 Jul 2024 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160366; cv=none; b=QBpgb14p0pZlvpC5LDWu2ivn7fgxAaAK6wsB1ZHUiLBYv8p+DCJZ6lK/CPTZKyyQn4PgoBzvE96Tnhf0DLoeLkxT41739YKxMZ6gZFICPLVgJmg8a35j8ag4Sre4kmexzO+T+yuwdKYapaG3ZTVssWLyICngxD8TOafe0feMshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160366; c=relaxed/simple;
	bh=NuBcaZBXyaib8wjHT9yk4FJ5ZvdCAVX8JNjlI0ndxKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEsLdyf89//Hol6jzAMk9/E4w4aQWyE7KXvaruOdHUWzotoVxEBP8+Rs6yOmv+tfvXHXykMyo5ilu0euoS4yjXuCsn+GXONEmvGSy8ZYRufnJSV/jQyQK8B3czrIbeuNzfmCPbcELsjDgrB2HiucpghjK++f4AoUQ9zqQjrXw6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=0DBeF8B4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0DBeF8B4"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77c4309fc8so90988766b.3
        for <bridge@lists.linux.dev>; Thu, 04 Jul 2024 23:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1720160362; x=1720765162; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwsffRzyhXVoC3K5uOT5OFHBsBv3WDoaAysWJVFt7KU=;
        b=0DBeF8B4TGnMknHGXncDG96/hH0wPPcYecqgMYyYZOywMJl6ZT7/2ZaHyW1Rlimdln
         laK4Z655Mg0Q7TEVdnldef3Hf8Sr1G59LRPaZxDHlz2KGHyopbPllgPFHez9e9MihuLe
         vtGKiiVnDTRmsqf7nJSHH8qejN6i0gcXEoE/QthbhgwFmqIrori2QQXTukJklpegswpc
         MIYgz7vyzqRF1w0LDOuj5w/Lnwiikwz3j0UVA3EIOJ9hwVvqhW3fHidx2l8xLzLRKC6G
         dS5+nAsgmbdyQwb1GJY/E+AvcZmihf2tm73mctfVzcwwuhJJqv5b8QADw1pXej+z2LqJ
         7Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720160362; x=1720765162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwsffRzyhXVoC3K5uOT5OFHBsBv3WDoaAysWJVFt7KU=;
        b=hcpgmZCwkDcvXYcTO53DVS2Y9xGHGaUyfp9jmeq/uytBGqfZ157+4jNeJyE/lB/zje
         rP6Gz+UT2KeZFpbAYfDiHKT353zKjp+dRw1wnu8puCsba/Zgndlqky50TZCDDV0eUTGv
         LDZERitcqOfZx4Be3ncYKTeAOUUli8HMuifuEjNeO8KWhYbMubkk4agHFsomhfY4GvlC
         8ivl0eDUuxCr8ZEqQ2NBBDwEaDSVT/PBCJhBYJXD9J3YWbJHeNHieg9mym3CyZiVCdOB
         Ki4TRMtpl8ebGj7BWKc/AFdPhGcSLEbRvCJdwbKJ/3AexCfBDroMzzEp27Zo0cudz11r
         qchg==
X-Forwarded-Encrypted: i=1; AJvYcCUBjpHjbVqA9RhEey8GMR//bQ1XKudPDVfDfop/X9QtzutQm3NmnAFK7LVpwgzISqOC1YyT29v+SlEvv94n1PXlbNfQBBe8
X-Gm-Message-State: AOJu0Yxbvf34kEv3r1c4afR3HKjJDdIo4humfVGaPBL/j0GV/WPf8CIy
	AvXUbGC4sRlVNDMM7n0+CaEcEXMaSUBeir4KjtwsAl99xxW2PJU5B7tYUGRqftA=
X-Google-Smtp-Source: AGHT+IHYGWxgJcxU2JtXZe2SYuFdQkZAhNQBf2vwDFlVHIX1WeUVW/S7nDMmVDMT9pyEI4qfY0LaVw==
X-Received: by 2002:a17:907:97c8:b0:a77:b410:b1ed with SMTP id a640c23a62f3a-a77ba48325cmr317201666b.36.1720160362091;
        Thu, 04 Jul 2024 23:19:22 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf184fdsm653369866b.3.2024.07.04.23.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 23:19:21 -0700 (PDT)
Message-ID: <8f3fe53c-0bee-44d9-9c23-6fdd3362ebe4@blackwall.org>
Date: Fri, 5 Jul 2024 09:19:20 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: mst: Check vlan state for egress
 decision
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>, davem@davemloft.net
Cc: Roopa Prabhu <roopa@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 06:00, Elliot Ayrey wrote:
> If a port is blocking in the common instance but forwarding in an MST
> instance, traffic egressing the bridge will be dropped because the
> state of the common instance is overriding that of the MST instance.
> 
> Fix this by temporarily forcing the port state to forwarding when in
> MST mode to allow checking the vlan state via br_allowed_egress().
> This is similar to what happens in br_handle_frame_finish() when
> checking ingress traffic, which was introduced in the change below.
> 
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
>  net/bridge/br_forward.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index d97064d460dc..911b37a38a32 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -22,10 +22,16 @@ static inline int should_deliver(const struct net_bridge_port *p,
>  				 const struct sk_buff *skb)
>  {
>  	struct net_bridge_vlan_group *vg;
> +	u8 state;

state = p->state
...

> +
> +	if (br_mst_is_enabled(p->br))
> +		state = BR_STATE_FORWARDING;

...
and you can drop the else clause

> +	else
> +		state = p->state;
>  
>  	vg = nbp_vlan_group_rcu(p);
>  	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
> -		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
> +		state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
>  		nbp_switchdev_allowed_egress(p, skb) &&
>  		!br_skb_isolated(p, skb);
>  }
