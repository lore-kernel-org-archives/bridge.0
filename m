Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD701C6FFD
	for <bridge@lists.linux.dev>; Thu,  6 Feb 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851661; cv=none; b=M+nCCyS4JkCsMG/T20fEuWxK9wefYdexlZIhyHXC3K3hjAa4SKg6RigNx/AHI+66f4Qwu6QmRG2lb9G5mJxXycZCg+OeOCKYJkUv4uEHjn1M6vKVyb6g5U+IfaXweXgh49deuAQZ5ghGTtBdG1K+4dOIICOApUm3VIO/QknSZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851661; c=relaxed/simple;
	bh=GUKOfJix9NBXsxH+M69y63dFCyCl1cade5SQsOM6nME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZ40ruzRKgTz3DXWq4O3hPbGpQ36Q5B9ZBIBbMxqnvKzxoyH62tI78x84e7z3uBJMi/Vo0QAhFcA+XDRd5HIvCdXSZ9Nw0fj+GKswEjPxc0hRrBIr52/Qr7DgmrLkT7Riz++M5Jlg4AQEYXODlxp/admnNZBdiazHJknBznbwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=JIK/1RTZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="JIK/1RTZ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab698eae2d9so175756366b.0
        for <bridge@lists.linux.dev>; Thu, 06 Feb 2025 06:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738851658; x=1739456458; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjndcfyqjqX0suK3BJwJI5MpJWEUcpM/zhKh9Jt/IFw=;
        b=JIK/1RTZ6d7opH7Uzwixw1AUr5EaGfAt5TSUKEXMvF4DbL1OZh1YgO29nEVxQaFaPi
         z9/Qag+PfnZx0Dc32Oij4EyGdQEB6tiGgzzZJSxuXNXPIC/zDzwOF35/qPQfGokZzoz0
         pGtB22M4Mttm8QUmP4bzHslOefoxxBI8nULm9fA9ng8BkOtVSfUOROiiZQfgPIuGuDLh
         wxOHPuGPdFSBNm6cUNsUVvWWE7o0/CJFiH8MuQvK4UD4sRPbrYM6pIz/CTN99ES4IYdz
         UDj/+fgXmdIHGzVuxGs2S9CVFDJefG0nTw1FSzt2gH3WEJiXL/38IH7w2lRJDFi2EHv3
         HhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851658; x=1739456458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjndcfyqjqX0suK3BJwJI5MpJWEUcpM/zhKh9Jt/IFw=;
        b=J9h+RpGFbij3KTIHyRy3rnznmTJUVkbvLcgjhU0AXyG54k0nqW0LPXDVupfkI4IhHR
         LbnF02AcyyxGq8lv0A3OTF0R8JDMTuYoW/dam3FBHrxw1MI0VOPQo9IrUM7ohswROS5E
         w5cBuqsxb70gQ4GjArmV5GxN5xoUg6Q/w92YfaayGvQPyBUQESqxt4lPFr45flNg0ojl
         MNoCpfZQjFf9zaoFSC0NaStIoqHXHLs3AKAJq4j/PKMvaMR06xk/UnTZnG/+eh3Et5Vd
         Ey2dqGadxvTTDpjiBuYjPEAQ4jPYegBOvqN8ztiqdCCwp+vsolg5fPa24mImBRClrDpd
         a4yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdA2px7rSj5fY6HJerhuT+4pGl9egSLKcaH5LH+4iEI5X/JXpHpWfrg3dfwDKxU+oL6pW1WVs=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw31Y9YWdbx3vYQ/zxrvrqrY76hCBSdZ+BDimScKPw8iqYsahTI
	bWVZm3v/1pl43MWxFcYj74D2V4Bg6R52IXWpXucJoScn8fQONJsT8XQ7PrRZ4W4=
X-Gm-Gg: ASbGncu2mvEPYtw+CsvJo9eN0q/H0Bwtj1VFZsC9N1ZGvrtYJZ3vUOpy4ecLISO/iFZ
	mlgxe7+RZSn83/QiN7KughMqDSYBK8rmVCNG1j8S0M+axrJg4t7eYX6I8cH5aH3FT2/SpnlJBwd
	Kp6hPVQw+OYz7+VjRhGuP5JsYysG+INCGjmxro0wy+eIjshn2DsS3gqakmtomIZcmZCckRYaboU
	AKDJMVnrlcK006tAVRL2/vrW/Yglud8Qu9A6NgPNJoO8O8A4noMMkZLqEnNG673oiIbbgjlzW9h
	AsKNLt/fl+BS63k5CZgOms1izn9D2P8foexsYbsfXAITLyo=
X-Google-Smtp-Source: AGHT+IEtj41Y5GMmmjFUnay2iogZtTrhXfr7uhOofHHSDx3vmcnEYXA/d41IrDMa8vkMQ4WmCAfDEQ==
X-Received: by 2002:a17:907:7e8e:b0:ab7:4262:686b with SMTP id a640c23a62f3a-ab75e2f2a97mr822408166b.40.1738851657921;
        Thu, 06 Feb 2025 06:20:57 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b7ade9sm931494a12.25.2025.02.06.06.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:20:57 -0800 (PST)
Message-ID: <5de3c769-68b8-4f59-8a76-1b81d51040b1@blackwall.org>
Date: Thu, 6 Feb 2025 16:20:55 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 03/14] netfilter: bridge: Add conntrack double
 vlan and pppoe
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250204194921.46692-1-ericwouds@gmail.com>
 <20250204194921.46692-4-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-4-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
> packets that are passing a bridge.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/bridge/netfilter/nf_conntrack_bridge.c | 81 ++++++++++++++++++----
>  1 file changed, 69 insertions(+), 12 deletions(-)
> 
> diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
> index 816bb0fde718..6411bfb53fad 100644
> --- a/net/bridge/netfilter/nf_conntrack_bridge.c
> +++ b/net/bridge/netfilter/nf_conntrack_bridge.c
> @@ -242,53 +242,110 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
>  {
>  	struct nf_hook_state bridge_state = *state;
>  	enum ip_conntrack_info ctinfo;
> +	int ret, offset = 0;
>  	struct nf_conn *ct;
> -	u32 len;
> -	int ret;
> +	__be16 outer_proto;
> +	u32 len, data_len;
>  
>  	ct = nf_ct_get(skb, &ctinfo);
>  	if ((ct && !nf_ct_is_template(ct)) ||
>  	    ctinfo == IP_CT_UNTRACKED)
>  		return NF_ACCEPT;
>  
> +	switch (skb->protocol) {
> +	case htons(ETH_P_PPP_SES): {
> +		struct ppp_hdr {
> +			struct pppoe_hdr hdr;
> +			__be16 proto;
> +		} *ph = (struct ppp_hdr *)(skb->data);
> +
> +		offset = PPPOE_SES_HLEN;
> +		if (!pskb_may_pull(skb, offset))
> +			return NF_ACCEPT;

You should reload ph because pskb_may_pull() may change the skb and it can
become invalid

> +		outer_proto = skb->protocol;
> +		switch (ph->proto) {
> +		case htons(PPP_IP):
> +			skb->protocol = htons(ETH_P_IP);
> +			break;
> +		case htons(PPP_IPV6):
> +			skb->protocol = htons(ETH_P_IPV6);
> +			break;
> +		default:
> +			nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
> +			return NF_ACCEPT;
> +		}
> +		data_len = ntohs(ph->hdr.length) - 2;
> +		skb_pull_rcsum(skb, offset);
> +		skb_reset_network_header(skb);
> +		break;
> +	}
> +	case htons(ETH_P_8021Q): {
> +		struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data);
> +
> +		offset = VLAN_HLEN;
> +		if (!pskb_may_pull(skb, offset))
> +			return NF_ACCEPT;

ditto about vhdr, should be reloaded after the may pull

> +		outer_proto = skb->protocol;
> +		skb->protocol = vhdr->h_vlan_encapsulated_proto;
> +		data_len = U32_MAX;
> +		skb_pull_rcsum(skb, offset);
> +		skb_reset_network_header(skb);
> +		break;
> +	}
> +	default:
> +		data_len = U32_MAX;
> +		break;
> +	}
> +
> +	ret = NF_ACCEPT;
>  	switch (skb->protocol) {
>  	case htons(ETH_P_IP):
>  		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> -			return NF_ACCEPT;
> +			goto do_not_track;
>  
>  		len = skb_ip_totlen(skb);
> +		if (data_len < len)
> +			len = data_len;
>  		if (pskb_trim_rcsum(skb, len))
> -			return NF_ACCEPT;
> +			goto do_not_track;
>  
>  		if (nf_ct_br_ip_check(skb))
> -			return NF_ACCEPT;
> +			goto do_not_track;
>  
>  		bridge_state.pf = NFPROTO_IPV4;
>  		ret = nf_ct_br_defrag4(skb, &bridge_state);
>  		break;
>  	case htons(ETH_P_IPV6):
>  		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
> -			return NF_ACCEPT;
> +			goto do_not_track;
>  
>  		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
> +		if (data_len < len)
> +			len = data_len;
>  		if (pskb_trim_rcsum(skb, len))
> -			return NF_ACCEPT;
> +			goto do_not_track;
>  
>  		if (nf_ct_br_ipv6_check(skb))
> -			return NF_ACCEPT;
> +			goto do_not_track;
>  
>  		bridge_state.pf = NFPROTO_IPV6;
>  		ret = nf_ct_br_defrag6(skb, &bridge_state);
>  		break;
>  	default:
>  		nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
> -		return NF_ACCEPT;
> +		goto do_not_track;
>  	}
>  
> -	if (ret != NF_ACCEPT)
> -		return ret;
> +	if (ret == NF_ACCEPT)
> +		ret = nf_conntrack_in(skb, &bridge_state);
>  
> -	return nf_conntrack_in(skb, &bridge_state);
> +do_not_track:
> +	if (offset) {
> +		skb_push_rcsum(skb, offset);
> +		skb_reset_network_header(skb);
> +		skb->protocol = outer_proto;
> +	}
> +	return ret;
>  }
>  
>  static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,

