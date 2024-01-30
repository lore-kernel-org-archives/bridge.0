Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DC6087E
	for <bridge@lists.linux.dev>; Tue, 30 Jan 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609173; cv=none; b=k09Af95fNC296QaP4yQPQteQ/6hnMl+vBjI++l/0rLFVILS+7rImZbkZcWrTM1/aBwls/Fu72IXpAe8pcMGw0s/ok+h88rQPGlAzchMSA25RtZH9rBtNb1RjyrS3US0On+kZY/JJMIifP8AJ8xKbUGYrpJSiEg3oWz8+X9Gb3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609173; c=relaxed/simple;
	bh=mN24du69dfpVsjxf9h64v6haXtXcEvje0y/RHCPRKdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKj1kVGyk0cYpgP95TkFpW+cuBli9lkKwJcwIpPOW7d0HogeB9/EMFDI2oUv+z3vJActjRweSz7YXSbCgo7fBBFxuI3SG9Pp8gE4sh/KytXtzl/Qv7uBDrvebUb4OGEkGmQsySqA2aat+nGhcrlgpGYnlaj+BNxze/xlGDDKoro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mnkwWgAw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mnkwWgAw"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f2b0c5ae9so1398432a12.2
        for <bridge@lists.linux.dev>; Tue, 30 Jan 2024 02:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706609168; x=1707213968; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=77QGicsthLBoZ1ghB2R2tu5urtPmZmFpryoMl9wbInE=;
        b=mnkwWgAwR5k52gmzvUy7kMIJfChM6RUHuFlFY5NDrwq9x4rTunkhZk6pq+jWzWXUBO
         bTVWTC9n9gbo03jAeeRP3syZuCRjLGAC2khX/5HMUsatSzCZdEjZ7S9RDlz04LxBWcWQ
         ORENNG9Iu3gg64jkZuDSY5TDpWhtcyxvqoj/MnsNLj2D3YgV3WMAtdQXSiel/b8mySXa
         5FR0Cwu3HH8s4/QHATAGskMzjnRyDnqPEnSXnNh0a6lLgTiEhDP2iikp1KC03TlFSmsI
         9l43e+OtZXUJ4oO0KdsP8uigL1QSzvzDZkLtfHyRfMmvEDHvUBzAvwJxdW1N7p8m8NoT
         Js9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706609168; x=1707213968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77QGicsthLBoZ1ghB2R2tu5urtPmZmFpryoMl9wbInE=;
        b=QIsWT+qPwvqLPM+F3AyHr1onEhB7O7Y+zyPzdOBLKGtko/DJFJpIVZATvYEPTNreVy
         EkoM9cPfsqArFLHGuAMb0hGy1YoSt5/XwhBx0aZCsF5nJoQzsMW3ykmbXGOht/Q6hRaY
         B0YUVz+lSJm0b9pchDljN8g7KUU8BGr7wX7xDs9DFkJDbD3Hsb7tin/1yTUV41wcfjDp
         F9vTYzMQzhkLT7D1kS06gxZkGQ+HzjInfuGoYlWyysd4r0va8UNxWHpO8w0B7cVt3fA1
         BX5hZZGmxLOtgdFpUI1tRrV5874xDoKLpBauKmSY+bgII71PNpBtdKuvlhfN/ETLVvdD
         ftyA==
X-Gm-Message-State: AOJu0YywzSTRm1ivYZhWKUvXOtEoxtRJ7zn7fTjh6DubELH2fDikewly
	xOTsbqWUhlB0D0QGfAtAnIRYSIQG0MvEBoj31/xuk9YA1gAMd3KnPrX/j20n7+Q=
X-Google-Smtp-Source: AGHT+IEFGJwTV8iQxLqYycNi0re0c/Uh0a05u4IOgDhPC5KHMClkENdc+BnOMwOQQuUgVXt12gmVJg==
X-Received: by 2002:a05:6402:281:b0:55f:3975:209c with SMTP id l1-20020a056402028100b0055f3975209cmr899981edv.18.1706609168242;
        Tue, 30 Jan 2024 02:06:08 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k11-20020a056402340b00b0055f11bd3564sm1523017edc.8.2024.01.30.02.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:06:07 -0800 (PST)
Date: Tue, 30 Jan 2024 11:06:04 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bridge: Use KMEM_CACHE instead of
 kmem_cache_create
Message-ID: <ZbjKDLtbiKXYpKew@nanopsycho>
References: <20240130092536.73623-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130092536.73623-1-chentao@kylinos.cn>

Tue, Jan 30, 2024 at 10:25:36AM CET, chentao@kylinos.cn wrote:
>commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
>introduces a new macro.
>Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>to simplify the creation of SLAB caches.
>
>Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>---
> net/bridge/br_fdb.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>index c622de5eccd0..c77591e63841 100644
>--- a/net/bridge/br_fdb.c
>+++ b/net/bridge/br_fdb.c
>@@ -35,10 +35,7 @@ static struct kmem_cache *br_fdb_cache __read_mostly;
> 
> int __init br_fdb_init(void)
> {
>-	br_fdb_cache = kmem_cache_create("bridge_fdb_cache",
>-					 sizeof(struct net_bridge_fdb_entry),
>-					 0,
>-					 SLAB_HWCACHE_ALIGN, NULL);
>+	br_fdb_cache = KMEM_CACHE(net_bridge_fdb_entry, SLAB_HWCACHE_ALIGN);

Same remark as to the previous patch, the name would change.



> 	if (!br_fdb_cache)
> 		return -ENOMEM;
> 
>-- 
>2.39.2
>
>
