Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6971C2032B
	for <bridge@lists.linux.dev>; Sun,  9 Jun 2024 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717923902; cv=none; b=BYk/OMTIy/M8btM8kBfvXegx56hzov9EyQJKR/xpZTb9T2D7hjZMZJDezWxfPy9g3k3vKDqG0vXkrdmfIab1FAGGl4RLI5IdzsqhZXJ/cybrwzjM1G+6ooEUZYxViQjtODbzqI5pZvnb4EwKKTLWSIXwD4gxqeujR77Ifx08kIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717923902; c=relaxed/simple;
	bh=Si71bFQFrRd4fbeR2nUXGk/jsEUgyn+WHHa500mVRsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asyPxg0YRIaTFkFDlXKUAIzDWZJqtKJ5ltcro124tz4lCE2DYHGrmdfRHl4hVoOclJCRvbx5L3olDumtONQI+nuSW9u5iYSTgkU3H7Ck9KSBOlbBdc75Z9FgeXEJaMwn4raGLgaOR00hcSsg+UrxvJuaEq9Znd293eeWMwWCQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=17nUzMIg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="17nUzMIg"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6efae34c83so132377266b.0
        for <bridge@lists.linux.dev>; Sun, 09 Jun 2024 02:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717923899; x=1718528699; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIh4lH8bQWGJqNihyQij8olrXP+SesotSW7Pq/JkSlw=;
        b=17nUzMIg/bJns+vtaf+MLoQ5+gwB+COETZzrJ7jBoF0GPZvp4u95OQ/vWvsoe67Pqy
         0kVDEb0vgEgHyLF3r+NaKsVAu3D5Qx9XiBwawmwBBmcIHNev3MYKdb4yY/xMWzUHApiX
         C3InjrnJTocpA0gFCuBUIwzaZaQiFwz8gFPPj7EwD5xYbUhD9+Nk3l3p2Szx4+WyvoYL
         rrPmSWVKbzDhV5EoSz/0gxYLpjoFHlqpIPeuAJ8qZ1Zz3ShRYnm8+QXpceM3yI/kSB0f
         AMuFzOzgWi+/hEC/ZCnTNukokbbWyYynEKlgbFbEJAfBHxk3+kq2N6fuAm5h4L0u22lq
         5MoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717923899; x=1718528699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIh4lH8bQWGJqNihyQij8olrXP+SesotSW7Pq/JkSlw=;
        b=FpI3qyJBxl0nw49KKxLZ6Mz58QyYBOQqfVpF1mGTzXwYMZlouotRo+BeKeYyZY0Bpv
         pmVM+ci8PEZtOPIeraqP/zhWS9EbcIGNsgOvNHf9MsmxWzz2c7Ep904AqaX2yQJZLf15
         wyLuFE5Xx5dseU+RX/r4btfxsFKbD1nMfWRuLofmFgoCdGVKANilTywHzQcyhtEdTbA5
         8J8icMgfxd401jbK3ktLdnZ1HCzePyxisT7CEoDJUZzOrdzclPAHbhLfP6YXryKeK56B
         nJUbU7KiO7viluYS/+63XhqjmwulHpMny/v/bflhGMHL0Fl5mE3h/guSSvM89KG9APye
         EmBw==
X-Forwarded-Encrypted: i=1; AJvYcCUlkgJRFjnzpLYSb/KKZXFpb/z2DpJfaMBQwVqKJiSk3TmDpQqKbjF/tC28isi2ftG4GGrR8kdVkEW1eNuba8S4dIm8FyT3
X-Gm-Message-State: AOJu0YznhHW+c26vOK9/n0/cP3N4Q0i/kizVIbWt2Rgxi0lxjLcaVw4V
	hqw3/JUg/1oorp1HHs8Kq03jFN3Gxi3CFPKi/Vd2hWAHDQDFP2IzRHMBdsTQjgY=
X-Google-Smtp-Source: AGHT+IFeE9HHbL43cW+IG9vH8TRTU8lt4FODOIbm9LfnJAHutw8/LXc+pVSYkTkSkQJY+mFvTLJ6lQ==
X-Received: by 2002:a17:906:3285:b0:a68:2f99:a3da with SMTP id a640c23a62f3a-a6cd5612575mr431690766b.16.1717923898631;
        Sun, 09 Jun 2024 02:04:58 -0700 (PDT)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef9100096sm247145366b.97.2024.06.09.02.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 02:04:58 -0700 (PDT)
Message-ID: <b2d17c74-86fd-4436-9156-271045ab1a45@blackwall.org>
Date: Sun, 9 Jun 2024 12:04:53 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] net: bridge: replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
To: Julia Lawall <Julia.Lawall@inria.fr>, Roopa Prabhu <roopa@nvidia.com>
Cc: kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Paul E . McKenney" <paulmck@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240609082726.32742-8-Julia.Lawall@inria.fr>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240609082726.32742-8-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/24 11:27, Julia Lawall wrote:
> Since SLOB was removed, it is not necessary to use call_rcu
> when the callback only performs kmem_cache_free. Use
> kfree_rcu() directly.
> 
> The changes were done using the following Coccinelle semantic patch.
> This semantic patch is designed to ignore cases where the callback
> function is used in another way.
> 
[snip]
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> ---
>  net/bridge/br_fdb.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
