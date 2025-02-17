Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCEC21883E
	for <bridge@lists.linux.dev>; Mon, 17 Feb 2025 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793283; cv=none; b=WGHjwAGSqCqjFYi59TSON9y+sGZLLShNMIGoN+z3Bm/KzZ2TyQO4hmWA4UHi4jB3RuD+kGgQCVD/tIeeoE4J8EY+7wd+mAibDfGOK6fFur6XAyabQVycJCvkwMR40lMk8rtXnoSMv6sMjBd6mdfP/H20gYFB1O98N83pNyogV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793283; c=relaxed/simple;
	bh=CNZT+25ePdrVoRVjO98eXznFTfieoFVKs8XN57JBj0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7VB/Xnd1SwcbvrwmcXBnGK79FulTWNTWM2Lmmps219jgWadnUMZ1YCV9zu+Lzlw3Ac06Sgrfcp6PFVAV9T3VAOtoqOE7z8GaJJ7vHuv7JJAhCQuwb28sv5XbuUHcHAZhcM6UOuJY3vZgtVTnLTcAjLhf3fv2eYfKI9tQBI8lko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=V7VzAqEa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="V7VzAqEa"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb86beea8cso266399266b.1
        for <bridge@lists.linux.dev>; Mon, 17 Feb 2025 03:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1739793280; x=1740398080; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ODoUNIzhz8wbS9RlnqshxBZqUZSt9lnSSqoVHSSyPbo=;
        b=V7VzAqEa3dNkgo3N/n4en/q5xUPG/caBQHfBeEa97rEC6UslK1YlxKS0cgnjaQ4Lve
         iuPztiFvoHMQc/KAjRHPl6mIpVDaDPLQfBXIW1iefwr89vn188UKpqx/04bsnBi5RqHd
         Q3oyjlrBCNNZyXoWKs0fstnT86nidnQlJdafXHIkpk6LFtvBuOVst4wK8Z3KO0Z7meAE
         6f8UB1Y+XjJ0K2MtFuh6PXX69tmRRMmJ6108I4dytP75WBmdDndA7Nn8p4hbwHtTne1A
         XloQ1UV0S0oDQUj/1jb+x94PCR19FHehUtbq8Xj8h0a2nUpKfVXAo+VX89VKynqic8ob
         HS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739793280; x=1740398080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODoUNIzhz8wbS9RlnqshxBZqUZSt9lnSSqoVHSSyPbo=;
        b=R4I13yv7DVzOq+3tQzi6C3huPt+ZadPD1yaKKCdvmoJtcr9Ae8Q/eSwWukeR5Iedkd
         SZ2d+6OqHpYyhTqL4hFIfPJz3DObLVvaBAud8hrFQtaawYew0NqAFsBw7HqKg2I0hUwM
         KNLQkxk+wgOtEq1kYyl9H7RVGQvmRAth1JOGDZsgbn/cgi4aPRqCu7fUwdrn7pfjHGaE
         DK5OyHtLbTQSb71mLqzDCFaKOsM/3m0TCHuuxisIbNRuP5lcfJdCDL1c8C5n6RGGL3ao
         sN3e6MsOankwVhQaCKKyW1sgvr+lD4QPkLu9ULAVe60lPA3DIEKwAVjm35MQDIR4w4iZ
         4vjA==
X-Gm-Message-State: AOJu0Yx1qJrDOPPackafi/9ZaAFLN/qZSZIPAgFfwl5bAbGO7tli3Dcr
	ghqO5rmAV03kk1Gmt/wIu9SQ0QIU3k6r57AU96jT1j8+rbyFXOdr4lpJ1pT5dTE=
X-Gm-Gg: ASbGnctttX/jXW9i+G0zafWrOzQt/cX1DIClhiGJT7Ik4t1dTPRU0SPpL0O3gi5SIIU
	a4i6HNj6KlY+7GEz7/9DbJBx7LVYLbL7xbi9IYbLTRYtLSTGe7kOVVASlPwd7+P2VAej9fl6E3p
	psOc9nW++wd6h3T1j1kIgFeGcUTH2sOhRIWOU24Fxf2PNlGS1rYZ/6w8iccuFPlXjQK9olo9iHP
	1YqZcP99TiZZyKqJgz6QKRSFZG0aZDMD9zXSXwxRtZIssnkb3mtI/Ps/qD9ocyBNtuP6NFld4W3
	yLJoZV40Eacu9fIY8xpeuhx5T0AIS+txlDUYSK8EbW3pBtk=
X-Google-Smtp-Source: AGHT+IH5LYB6p/HXb8BGQs5I7Qwcm3npFyWcKGxO91RFb9WWl38/bVbziniG96GtqAkw2iimohL1RQ==
X-Received: by 2002:a17:907:72c8:b0:ab7:be66:792f with SMTP id a640c23a62f3a-abb7112e046mr1020984366b.49.1739793279612;
        Mon, 17 Feb 2025 03:54:39 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba9bd6e22sm71743666b.121.2025.02.17.03.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 03:54:39 -0800 (PST)
Message-ID: <37bf04ee-954e-461f-9e37-210a8c5a790a@blackwall.org>
Date: Mon, 17 Feb 2025 13:54:38 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: locally receive all multicast packets if
 IFF_ALLMULTI is set
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250217112621.66916-1-nbd@nbd.name>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250217112621.66916-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 13:26, Felix Fietkau wrote:
> If multicast snooping is enabled, multicast packets may not always end up on
> the local bridge interface, if the host is not a member of the multicast
> group. Similar to how IFF_PROMISC allows all packets to be received locally,
> let IFF_ALLMULTI allow all multicast packets to be received.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/bridge/br_input.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 232133a0fd21..7fa2da6985b5 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -155,6 +155,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  			pkt_type = BR_PKT_MULTICAST;
>  			if (br_multicast_rcv(&brmctx, &pmctx, vlan, skb, vid))
>  				goto drop;
> +			if (br->dev->flags & IFF_ALLMULTI)
> +				local_rcv = true;
>  		}
>  	}
>  

This doesn't look like a bug fix, IMO it should be for net-next.

Also you might miss a mcast stat increase, see the multicast code
below, the only case that this would cover is the missing "else"
branch of:
                       if ((mdst && mdst->host_joined) ||
                            br_multicast_is_router(brmctx, skb)) {
                                local_rcv = true;
                                DEV_STATS_INC(br->dev, multicast);
                        }

So I'd suggest to augment the condition and include this ALLMULTI check there,
maybe with a comment to mention that all other cases are covered by the current
code so people are not surprised.

By the way what is the motivation for supporting this flag? I mean you can
make the bridge mcast router and it will receive all mcast anyway.

Thanks,
 Nik

