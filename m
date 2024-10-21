Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D581F4FA3
	for <bridge@lists.linux.dev>; Mon, 21 Oct 2024 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507474; cv=none; b=TKLlTvoe8YlbylC7AbxN3oE1+UHBwcH6nNV1DT2pYvk+iV2QqvuVL7gXjApgapxe39VunoB0DaQhPO4oxBgs2K4sJUVXgt74ngWAPhnLcbGiCYUIaRr/nWnQTZvQmlncqhmlG4sUx958evwy1OediVuhq47JwfFuh3Z/mzU55HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507474; c=relaxed/simple;
	bh=QszUSC+eDikLq/z2gASxiOYZierjrRupuXUewlv1aoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcvAEl4sAE7VezL4QVrzx3ztj3fcw95UBs59lLLIY+y+BqYMFNfpila2nvuYsvF2Uqedo7xOa1vKADmG5GOuXpUSIT3zx+qDM7nRYcIoI1w2SdULhI+IrJ8dgwxIXSUevyo4n9eHswGWl1Z7mOIrEuP5iBWS5euskvnVyqKutH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOD5v52F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOD5v52F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESVSTYYZIF0hJLrudzMovh5iFWIQNUs6HLNbYhgpPLs=;
	b=WOD5v52FaTR+5/VQVjJ7ldayZ2sCfn+cIhbFLeZRjAut1WEzX9ghu0Y2VWdVY3PzrT1Gdv
	1tsFdddnHe7Ml4tRpRBZiEy6RJkLB8X96cCN2DuUQQfZxY7cfBUYViXLiSTGBGcdIyQTtt
	HvXTVC9XtxqZz6IhWEID7g6zwNXVdmI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-_qBYA6qKMLa8QR-16MXQoQ-1; Mon, 21 Oct 2024 06:44:30 -0400
X-MC-Unique: _qBYA6qKMLa8QR-16MXQoQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d60f3e458so2830374f8f.1
        for <bridge@lists.linux.dev>; Mon, 21 Oct 2024 03:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507469; x=1730112269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESVSTYYZIF0hJLrudzMovh5iFWIQNUs6HLNbYhgpPLs=;
        b=dUhXrjwH7lA+zJpIEheGc+hu1WkG9EVUp92tMsgbsLIulIXGp4TGl1ehC19XydRzWP
         1nXW5vQXcIooea+kY9AWveyx8vV947/VAHzWfSA/wUP6dfMPNNbZaMiry6oYF4E0q48/
         v0oLFwEXGbOq+rRSS5EFuEfdhO6ddhqsKsdgtB4PJe/LKNJhYB12ERfj8tccTiZwJCub
         WbhFbXHJlW+Gp7gwRJYx3rHrCYu0oHc3sFKx/p491LLHexDEHUOs/7czu32Bp20/drCJ
         9AKaNK08WmxDra1gqPza7Sc7KyYwHzr8GVIsihxlyycCW06T0zUSNs9ABdbozavk+10l
         C7mA==
X-Forwarded-Encrypted: i=1; AJvYcCVLPaIYUTZSjrk9yR8tVM/hPYwZ9U+P2STZYSbAcvQsiSu7YeCdOwjralrBhEniuiumnTKYap0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwfgLevuQc419h4ObFWL0Bacj+KsuT8FF8U0IouEo3TOQmEsERX
	shRk14sKCGUZlk+ibXHsKDxLHtHGEFKgGLihGPTfS+F+evDXd1aBrzJGBzR2DrR1nGuISnAnfoG
	dXUFf6ZhrufTYUptp8aujp+2mlGu4m3jNxdgmguL2KqQT8bYbZ+g0kQ==
X-Received: by 2002:adf:e005:0:b0:37d:5042:c8de with SMTP id ffacd0b85a97d-37ea21d960cmr9407841f8f.22.1729507469430;
        Mon, 21 Oct 2024 03:44:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEjJ5g1Du8OWB8p2Bdce9qpXw/gQOJX9TgsNNH+Knj/WJjb8z0dN/BAeiBh4kBOoGsx2V9lw==
X-Received: by 2002:adf:e005:0:b0:37d:5042:c8de with SMTP id ffacd0b85a97d-37ea21d960cmr9407810f8f.22.1729507469018;
        Mon, 21 Oct 2024 03:44:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b07sm4049451f8f.1.2024.10.21.03.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:44:28 -0700 (PDT)
Message-ID: <c6e8f053-32bb-4ebd-871b-af416d0b0531@redhat.com>
Date: Mon, 21 Oct 2024 12:44:26 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/10] net: ip: make ip_route_input_noref()
 return drop reasons
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-8-dongml2@chinatelecom.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241015140800.159466-8-dongml2@chinatelecom.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 16:07, Menglong Dong wrote:
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index e0ca24a58810..a4652f2a103a 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -98,6 +98,7 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
>  		skb_dst_drop(skb);
>  		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
>  					   ip4h_dscp(iph), dev);
> +		err = err ? -EINVAL : 0;

Please introduce and use a drop_reason variable here instead of 'err',
to make it clear the type conversion.

Thanks,

Paolo

