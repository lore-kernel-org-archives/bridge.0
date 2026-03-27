Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FF43AEF4A
	for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593483; cv=none; b=SUlMGdZ04bIfOjeFreuCcFCG117kulorppt/QyEh5ZGAGjcc9Vp694EqYAKW5ssuEDn7FP7XMlgsp6573w5Ide/aZnvlrdOr1T452l3K9IQRmg1hpmuWxDCFQrJAtZI6x6R47EbeGF4rOjphsUcAVhHwpygO5NYpEOxfztVz7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593483; c=relaxed/simple;
	bh=+4LgBG2lPnteLEva5q5EV8krPKKJf5AzHFIuy/FUdK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gB2q6Lk8TBcOxx9lXSZSGTmv8SmnLxVRlZekXjbEse3TRFe9UZ6NbGhnJ5SQdbXDWDN/CoSr5purc5dkG5ojrX6rl2pYi5cE5GTn9m2c5s8jWbvr+/0I0LNt4IBsjrkvl2hDBst7wrseU5IkllqaHtn7UJwT1Dqd8Gvt32NFT2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Zo9NOj5n; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Zo9NOj5n"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48374014a77so20968385e9.3
        for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 23:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774593471; x=1775198271; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eglRAgY65J6K+hGvowI7XYpmAYRuD59HMwb8erAafGE=;
        b=Zo9NOj5n0+HBDSzTEpX3vLha+vWWcyO4ybBtYDQg2CTfRBsSwo17z1VLY3B/3Ly3dy
         mlElHVqRT6a0KFQxsAYChMIPHPH+joA7VCSsd6h8rjEWUYRpHpKli1tB+JULpd33dy93
         l5ohoXLDfnh2Xx+9/Ai0UqJKkgZ0PkMFPwOVbhDpneP+viTSanc0H6/GESQconIWLl2F
         Da3F2/tlMQf44U/YaERwKUyEVI/M3IZAKFT6CNa1jV/kqTRxwJSOHGBDM7vROFWNBLMK
         FsUTW7phnevcXb7r5YNe8+8gXXVHXkCO3QwmcwJWtQDPQy/11jH7lLi7mzBHxlR/IAeD
         FZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774593471; x=1775198271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eglRAgY65J6K+hGvowI7XYpmAYRuD59HMwb8erAafGE=;
        b=C09ASkm9yIXaql35/iLteiOmfFJzQM0mQv//OM7UZBLHkItWLue4RdielB5mhiZRJb
         RhUBFFElSkaAf5RxCI+AjnqC7clxHrXlve5EgnSHxZHcLhpJ9YqqZkYOX7tl6g7jlddD
         XtUHiUe7csbedb4Ju6R31r18WIMKcLAuzCXYQ0I0sdZzaxzEoMBOqBYRyOErdxbdWe0D
         plliVErj/iZKLNFanSIcaMaNMCPl2BljckFKzmo9F1C6qKb96kKV0Q6rh1/yFL59y+BY
         nGAdEoj9/F6hbwGDWf16lsrs8efU5YHmKnQQmLICMd3zYjN2mh+XrzB+tN5YCiR906N/
         8+fw==
X-Forwarded-Encrypted: i=1; AJvYcCVPqwbYjET/Kk2CaJwi0KtCTFv5OYdgypgG7UFYTTpOXMISO3cX87CNRSHPmrv1V4rFKAaL8jo=@lists.linux.dev
X-Gm-Message-State: AOJu0YyacZSnslLQjxQfIhld9DSDqFU9gBTXQNfCUX+wpX1zuvCOrdYs
	YfClCEZcvmd/5KAXLkreXaycubAq9azvGV5+IkN7EGRmRBgTe64+HInwVBK+XD6TLmM=
X-Gm-Gg: ATEYQzy22a6/8x2uielN7+c4nZJWYXofITdgc4/T1cA2LtVOsHKRra0A/vXEXfnaXsN
	SXPZihVQppOtJclla+/T3XBH45+zjWMGfyeV2Nvgu09Ply0EF6cmGfolIGbp0fjnZ97HMYrJ+Qq
	rjlJaDoDJk4eSkYyIu9ezuJEnl+VYGVIn9b4jhM5Rt4L0vWRyKG3ud6qYixT+DcKAhDDeSfzV/2
	1RI9l19w1URIDHCfwvviwj4erJ/yGlSUS+icTt0Hsmwl0WH8SGxuDTRKRM99OtZtq36EsA3wZLV
	F/1XQC2tbhoLGlbNnqHrulXUywwP+d93zh8rnJG3GZoxFSWO9ZqSbrnn+aMnW824pmxkL5+7utc
	UoDU6NuprckAT9F63YIkaGCefwpa55/NKAWRK4CMxpdOnWZYaZggS9dgBIGb99kkqK4XZ0sref0
	2wGdXWfESthBm+gk6u9276JeOfYEaKvSP72vOrj190eo5pvH1J5pTYOA==
X-Received: by 2002:a05:600c:8485:b0:487:1fc:14f9 with SMTP id 5b1f17b1804b1-48727d77c8fmr19397525e9.15.1774593470767;
        Thu, 26 Mar 2026 23:37:50 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9134fsm123324635e9.9.2026.03.26.23.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 23:37:50 -0700 (PDT)
Message-ID: <cc0bf1a8-5bae-4e92-8b92-8b9038632990@blackwall.org>
Date: Fri, 27 Mar 2026 08:37:49 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] bridge: br_nd_send: linearize skb before parsing
 ND options
To: Yang Yang <n05ec@lzu.edu.cn>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com
Cc: andrew+netdev@lunn.ch, horms@kernel.org, florian.fainelli@broadcom.com,
 roopa@cumulusnetworks.com, dlstevens@us.ibm.com, nb@tipi-net.de,
 netdev@vger.kernel.org, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 tanyuan98@outlook.com, bird@lzu.edu.cn
References: <20260326034441.2037420-1-n05ec@lzu.edu.cn>
 <20260326034441.2037420-2-n05ec@lzu.edu.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260326034441.2037420-2-n05ec@lzu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2026 05:44, Yang Yang wrote:
> br_nd_send() parses neighbour discovery options from ns->opt[] and
> assumes that these options are in the linear part of request.
> 
> Its callers only guarantee that the ICMPv6 header and target address
> are available, so the option area can still be non-linear. Parsing
> ns->opt[] in that case can access data past the linear buffer.
> 
> Linearize request before option parsing and derive ns from the linear
> network header.
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
> Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
> Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
> ---
>   net/bridge/br_arp_nd_proxy.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index 1e2b51769eec8..af3d1e33f50b8 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -251,12 +251,12 @@ struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *msg)
>   
>   static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>   		       struct sk_buff *request, struct neighbour *n,
> -		       __be16 vlan_proto, u16 vlan_tci, struct nd_msg *ns)
> +		       __be16 vlan_proto, u16 vlan_tci)
>   {
>   	struct net_device *dev = request->dev;
>   	struct net_bridge_vlan_group *vg;
> +	struct nd_msg *na, *ns;
>   	struct sk_buff *reply;
> -	struct nd_msg *na;
>   	struct ipv6hdr *pip6;
>   	int na_olen = 8; /* opt hdr + ETH_ALEN for target */
>   	int ns_olen;
> @@ -264,7 +264,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>   	u8 *daddr;
>   	u16 pvid;
>   
> -	if (!dev)
> +	if (!dev || skb_linearize(request))
>   		return;
>   
>   	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
> @@ -281,6 +281,8 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>   	skb_set_mac_header(reply, 0);
>   
>   	daddr = eth_hdr(request)->h_source;
> +	ns = (struct nd_msg *)(skb_network_header(request) +
> +			       sizeof(struct ipv6hdr));
>   
>   	/* Do we need option processing ? */
>   	ns_olen = request->len - (skb_network_offset(request) +
> @@ -472,9 +474,9 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
>   				if (vid != 0)
>   					br_nd_send(br, p, skb, n,
>   						   skb->vlan_proto,
> -						   skb_vlan_tag_get(skb), msg);
> +						   skb_vlan_tag_get(skb));
>   				else
> -					br_nd_send(br, p, skb, n, 0, 0, msg);
> +					br_nd_send(br, p, skb, n, 0, 0);
>   				replied = true;
>   			}
>   

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

