Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4866F466B70
	for <bridge@lists.linux.dev>; Tue, 30 Jun 2026 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834662; cv=none; b=fJzgaj1oxLCvuMdditq0aWaXsek3oz4Btxyvjltx7Puanx4ljlQB7ousdxFe+HtOubRIUICNpJk+B6TszsJO7HRLO9LgLMnoeZbSmvGrIHbR8QD0ue8Gahpfo30kAMaxdjKEtABcEaLcWUEywbrx/AfIkSjRn3NZHdLZF4eRTdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834662; c=relaxed/simple;
	bh=y7445ma5nY1rhw/uXHnIZ5XS0bGAch+rXU5qwFJ2m4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyQHBBZhudc8OySBKPlprNlT7UK3SIqyOZxbSBVYmKRrZdiGf9SvVCruFOzJfdqPLFu3oysF4eLPxsGfo/q1YVJVi6k7//6NYIITtqBh1NdgnpGC0HpLEIAyTKAmWmNURKhu7HAGhj8Pl1f/dXq/VNMVCz+H/T++bNMRoOSSnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RekldWY9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RekldWY9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782834656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwV1W6gFFKBGW/LHViHAoZIfwfYxa5BCshEu0mADzdg=;
	b=RekldWY9sqtiQt7reurE5gesgn5D1s3BOSXxmBaHL2tLXtDRAlUeCgrXMDzQOr4DQyabwS
	8YmzEJH188hfk/Mt3QMiaya0orP6B+RH1EgDShi7aF+NZbM/VwIdAWGsuZ2bZtvrZss4ti
	ggFkAPCWVqjygLj1esNrP5n70GAtbVc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-hbVgrz3zNyCMm9i5KLdT-Q-1; Tue, 30 Jun 2026 11:50:54 -0400
X-MC-Unique: hbVgrz3zNyCMm9i5KLdT-Q-1
X-Mimecast-MFC-AGG-ID: hbVgrz3zNyCMm9i5KLdT-Q_1782834653
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490bae3a39bso32289865e9.1
        for <bridge@lists.linux.dev>; Tue, 30 Jun 2026 08:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834653; x=1783439453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwV1W6gFFKBGW/LHViHAoZIfwfYxa5BCshEu0mADzdg=;
        b=cxWwQ49VaxO8ul7WZziWoO4Fc/5DAyILNy6IvVzRHPpsL98fYWggc4f4FNpJ/gPQf3
         UhI553f1ZVKKh3/uqzx4v74SUqMONJtWX6Y4ErlNqEJIDiX11V4qCNAaf5BjlR64lkWD
         rjAs8+kU2ARwIYE5L7ExrYQjDRd1Vo+Bw4fPbecceKkQBN/VDZoNCB2OMxEW0avCkSM6
         +rkANCv6VF7B37ictyQ2diqF8Zcgp06IRUQH3l31+q/+UxQv91MZ0Adv7ZCRmqd3m4a7
         nHshkhgq/eOkzRvqQznGOjBCClvagBI/vzcXcpvRJKi6c3Newq02/6i2CTX9DwyEMcf1
         QI9w==
X-Forwarded-Encrypted: i=1; AFNElJ+1Pw1q62x3ADY6gwLQBnobyBpGlQGkEbrpmzy+pYDnoKrODpFWaw0JFYndkU0cpJcLWcA0IbM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5jygyDMR7U5N5y5OJ9FIxxWiq35eU7f48lQHgqUw8b+cmafh8
	YNRDDmWSvDveH4sI6xevCojAkWamWxavpURL3hNe5EDpcbjXs0EczZaB2JUrTbv5NMQj+8OERk+
	qnL6jjY/v4UdvrHR2AzWKdCES8Xc+jIZ5a/CBPpm217cYw5flCgcTmOF/WqvfYviokg==
X-Gm-Gg: AfdE7clPE0ZWEM8t5txGiZe6kwP3T9IZIKFz/664+Zcqv8rSuA1R7fQFWYQh4TPLl+G
	gcb7byE1RE4HH9vSYnmCw1pTc+lgUhlqIUn7bO0u6YPhaNXMGyFl8ZIhmtkbD/rtWPdeOLvnye7
	ZtIoA6vDKpDpkypZBIf6wJv9lhTeO0UCd1P1bex2Vujpmm/6s/7XnsW8JqzS0Rd/3gOWfCG6iy3
	tyuHtJvrG/Uj4SSnhJPLXQHjpTvx739GLV5Y6bXyrFPlIMmNryh8Wpr6vsWyGLMhmPvhi7B4EKT
	MLaJGFegE44Y3QkU8OR4R92FuuzwffMrPT9C4/YTTXnC5Bzlarq4uWhGQ3z7l/Dy5ykiK+Yiwmd
	xPTRkfDReMCSUcGUGd1k0QJrA1UUxRADCoar4zqtVOouyEeDj+FsaV68rpRyVj/woahtJyP8q13
	scx6GevzNdXw==
X-Received: by 2002:a05:600c:6384:b0:493:a91c:37e7 with SMTP id 5b1f17b1804b1-493b82b8699mr62547135e9.28.1782834652777;
        Tue, 30 Jun 2026 08:50:52 -0700 (PDT)
X-Received: by 2002:a05:600c:6384:b0:493:a91c:37e7 with SMTP id 5b1f17b1804b1-493b82b8699mr62546705e9.28.1782834652326;
        Tue, 30 Jun 2026 08:50:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4540aesm5412535e9.0.2026.06.30.08.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:50:51 -0700 (PDT)
Message-ID: <5446388d-40be-43e0-8a55-eddd79ce71e3@redhat.com>
Date: Tue, 30 Jun 2026 17:50:50 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: stp: Fix a potential use-after-free when
 deleting a bridge
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 razor@blackwall.org, horms@kernel.org
References: <20260629072117.497959-1-idosch@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260629072117.497959-1-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HOopWLwVL1SnufXGAUAapEBLqQRw658hFNr-mXmy42s_1782834653
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 9:21 AM, Ido Schimmel wrote:
> The three STP timers are not supposed to be armed while the bridge is
> administratively down. They are synchronously deactivated when the
> bridge is put administratively down and the various call sites check for
> 'IFF_UP' before arming them.
> 
> This check is missing from br_topology_change_detection() and it is
> possible to engineer a situation in which the topology change timer is
> armed while the bridge is administratively down, resulting in a
> use-after-free [1] when the bridge is deleted.
> 
> Fix by adding the missing check and for good measures synchronously
> shutdown the three timers when the bridge is deleted.
> 
> [1]
> ODEBUG: free active (active state 0) object: ffff88811662b9b0 object type: timer_list hint: br_topology_change_timer_expired (net/bridge/br_stp_timer.c:120)
> WARNING: lib/debugobjects.c:629 at debug_print_object+0x1bc/0x450, CPU#9: ip/359
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
> Reported-by: Neil Young <contact@ssd-disclosure.com>
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

The PW bot is on holiday, no automated notifications for a while.

Applied, thanks!

/P

