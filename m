Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755062E06EF
	for <bridge@lists.linux.dev>; Sat, 25 Jul 2026 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991093; cv=none; b=K0qw8aTqJaB7UVzuPl6e98/cN8ZgqAD0gZP+LCyADkjbCqKiasbeFoXxhacv7JQpsJErZqZ9sllmokehKFUh4DiQVR3bY0es5Okoqp+risFP91WU4rQkxLVf/SrYqE3aWmLbABYmLGgsHk+mxeTGZEdVAtXI853MmIijs2xR/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991093; c=relaxed/simple;
	bh=KZs1Us200zaSsvqhZvrAFPnlls04ZdqH5I5VmDa9ki4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBfxXBtnbMHxmEHECod7Hq5AeMKdtS7TD49T0pX32asyWmbcCQKWsJg+NP18F68mCa0+/MYIgjtSlMZnYTogF2Hgt2yQ1H3bbzelVmz9AHxrAWSlJeBtPh7Mk43P+GFe6mAuqGQSCxzqBspNesEfWb5u/C89TQAhP4lzYUaXP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HTEcM1ZN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HTEcM1ZN"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso1261394f8f.0
        for <bridge@lists.linux.dev>; Sat, 25 Jul 2026 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784991089; x=1785595889; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZgrPUXs+4puy9cY0msWgnbxd1bLXilsXJgyDMqCeWgM=;
        b=HTEcM1ZNBxpZixKcpA/cyGCOSiLpYH+hRKqvmG9ZajPWXO6BczypfJXddxmCLYA8eh
         1RUoRFGcJrfNaxZHfw9+CsCAd5rjNhrhZ2LlNzXRev7MvQflShL+BTbQMT354rRf7Dmn
         oUF/7o45jGCBwpezlFzLocisoXR7YOWh5q1rGIgJIaxoWb7rPNPnbM+0fEMm8mP2lZ0C
         Gdm5+jXhm1lN8NmNP+S7naZH6XhD3DQpjV7tVHWRLg2Wa8i5JaB9JWKfzuwVCXpToxuY
         K/3yxanuEha3nJt4QxpCaoyFzJfhzUwNECPKPs6mHDeK83FknB+2qCsp8wmYiYI+GFcT
         ZCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991089; x=1785595889;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZgrPUXs+4puy9cY0msWgnbxd1bLXilsXJgyDMqCeWgM=;
        b=Q67TccGGS0edTbN518zfJFGbAnDHfrgFm+m/GJ7HGmb8Opi+PfVPhVGHY0NLwfD9wg
         A3rxvX0yDTP1SqePkqsglCoLQe/DL7QrZc2Cnwqkz6zWLyDaAs3k43XhwrpMZEEnMCNM
         vm2D/xcgwia0hjjochz6pMNWxEDAnLfW4VonJo/J09JclKFv/3CdhAUdMq2x4UUskwma
         mkksMTsGSAedMOQ99U/vahtM2Oubk4hkOqnNYoTZ7R6Q2/RYtPdB28p09cpEzW5/kIFj
         XtMzi2RB9SGCRl+wWwrxlL/P6gxnx0bwP13EwWrnLYE7iXrt5z1HimQrfc15oYW9oY7j
         In4A==
X-Forwarded-Encrypted: i=1; AHgh+RpDlV/Wos2njURDiUQJNq8MaEIGkvzR/9TDlSJeVOyvMpVucXYcf0Dhhbvj9WynSmvLKfZ9Sms=@lists.linux.dev
X-Gm-Message-State: AOJu0YzNJWnYumtnLSw06t1MWV+vQ0nvc0DZIMdlShuajWwiNW0+gYFy
	nDEhJGKecldx6FHN9ga+Us9ec38Q4hIdu+Ny3WHYh5OiPFgsxJaROwzfEr1+FbWOKtM=
X-Gm-Gg: AR+sD118JqJx1gAUdY1TrJkGfzrjsvMEFmYU796i31kQow1zOTGRFBlyL+Tzuh+yCQ0
	zLsOBFzwG4ARtvaBIzlh7jouwqRuG5l1IAxTYPDdFOeihQUBSa1PWc9yUA0Cuy/6cE1BKBCJbgX
	M4GpRpa27helzgtI6Zcf/4CsAB76WcrX0UkrihlWARemczVx2AB0lm1Oxy7nn1zsw+8O+cg4TlC
	bP7Q0JX7gFeL1d6X9FvDdV5Jyj2LKq0YhMgeAZZS1PsuU8aYN+PNmM5jORu2ETFLpPsPnIEtogi
	Oe4Y4EKL1l5Ztb5L6FOxIiruD4EdWa5+6YsEZFTyMXDQ35MFFq73qElqzq3m56ah3WDY7l2W6Gr
	LyuGkfoBvYxw1ZOwmNnDMd3VmjF2DpuHTP7RqvT+KQWO53DU43mQX23h5rPs1bHVeJdtbL75Amw
	==
X-Received: by 2002:a05:600c:3551:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-496b56bf01emr30334965e9.10.1784991089051;
        Sat, 25 Jul 2026 07:51:29 -0700 (PDT)
Received: from localhost ([83.222.177.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499cc49sm83072585e9.9.2026.07.25.07.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:51:28 -0700 (PDT)
Date: Sat, 25 Jul 2026 17:51:21 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: David Corvaglia <david@corvaglia.dev>
Cc: Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] bridge: mrp: fix MRP_Test option TLV length
Message-ID: <amTNacya_ZXLjoDn@penguin>
References: <20260724051202.61946-1-david@corvaglia.dev>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724051202.61946-1-david@corvaglia.dev>

On Fri, Jul 24, 2026 at 05:12:02AM +0000, David Corvaglia wrote:
> oui is a pointer, so sizeof(oui) is the pointer size. The MRA
> Option TLV thus advertises a wrong length (15 vs 10 on x86_64),
> causing misparsing of the frame on peers. Fix is to replace
> with sizeof(*oui).
> 
> Signed-off-by: David Corvaglia <david@corvaglia.dev>
> ---
>  net/bridge/br_mrp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index 3f7126a7d720..179d2470b724 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -215,7 +215,7 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
>  		struct br_mrp_oui_hdr *oui = NULL;
>  		u8 length;
>  
> -		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(oui) +
> +		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(*oui) +
>  			MRP_OPT_PADDING;
>  		br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_OPTION, length);
>  
> -- 
> 2.55.0
> 

This is clearly a fix and looks like it is needed for proper parsing.
I think it should be targeted at -net with a fixes tag, probably
f7458934b0791 ("net: bridge: mrp: Update the Test frames for MRA")

Cheers,
 Nik
