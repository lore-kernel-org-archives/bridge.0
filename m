Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2769943
	for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693238; cv=none; b=mBV0NJ3a7LoDKiO3rAUcG9HginsAZeejGRBITmQ4K4272lGX2YKpkhtXZERU/bsP++NQrIToZ3YnzIdjTUeID+pG1RTSJDIg50V4ORVUs+61mg6GGCua/xEBnGQsRrC4uqM5dNCbLx8nwEtHcavNScaxrrg4CXBhzVvnR8VVTLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693238; c=relaxed/simple;
	bh=Y8OInFyezrqdukb/GwASp6AxHMdhZSdbYSe2C0Yjdp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXPaXccih6M0YN1zMRHxNGK8M0nQ7sCxHG2eQCvq3EgssihlWUZcUGQMFX7TLEKkdC+Bznl54VfSTVEt3v1aG2uee7C/z72MD2g0DWk1YKKaxDWVK490DsM+OKihV5ad+548f/7E6uHV50oyOmOsnaSoUEiD5g2LMSxlINYfDjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jXX1wpvX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jXX1wpvX"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so12790405e9.0
        for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 01:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706693235; x=1707298035; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8OInFyezrqdukb/GwASp6AxHMdhZSdbYSe2C0Yjdp4=;
        b=jXX1wpvXg0S8TkF1JOe6s9+sZv2ixmGlGZh1tS79CtWN4XrrgEDNFOdJV0sVC6R3Wx
         nPmg8GPsntArGwZ72mkc9UOlgFzMTaKwdE7ZYu20lXnAugMkXArWeyNa+kfBY4pMvT9C
         cE7X44MfUEi0usYMcIw4ziqwljrWiiDGNkyuSqi7ZCST+1nXR4B65SxTOt68ZEBFiPfo
         sDZg85HiefcscSJGW5VDTcUTdTRvvxDhfxSbTK4SVbhTCoaYWV6tTS521ETHKnzaiT6C
         HQccVxu8UrTQJYTtEdL3M4xVgt0kIH1vuB0wjQj70LA5bsRSzezQc1inNTrQwyDKg15u
         GAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706693235; x=1707298035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8OInFyezrqdukb/GwASp6AxHMdhZSdbYSe2C0Yjdp4=;
        b=J7K/haLMPb8CObfZfmw0xSpxN1WshGQC+dkeYCI8vlvybWK8aCgMGHno4zUhs8GnCe
         3nKU5mHJBQsJUyxyQ2WhFpVk27vOP7FnCV5BqkH9oiPeb0ADNNWfBLaaGMruNqoxS9hq
         6+fnS6bFJaSfs7eiPMbLkodmdSpyIHuX8g642MAHeIhXkjFE3RT+MDJ/Gudem8tMaEgj
         d+H5k9awhp5+qgFDT9DCuMK3HkqBRJgfKWoT+lhGcUPok4FqqOnDSilwk4LQMZPQL1is
         o5KNPJlpkWphYiyrvPrrpXWJr1bLLtvwtzgUDQcFQ9qDi2zCnJ+p+vL1QYZQYd0JUr2j
         RhyQ==
X-Gm-Message-State: AOJu0Yy/1TFVBgXbF0WAlSJ/4x1GX2rIwYMo/hD/w+VXYLEcHtM5rBk3
	u9ki7jQdvoRXqCiBDnjRYcGtVasqzIuslonnphXWOx0WOy9RzbgMD2IX9ekQ/zY=
X-Google-Smtp-Source: AGHT+IFEk3sXmo/8nD37OajxhjHLoj3FvLxRBfdiUIX11PVK7l6akHuoOCda1RllApfdmRYPKnPpQA==
X-Received: by 2002:a05:600c:3b96:b0:40e:b17d:2f56 with SMTP id n22-20020a05600c3b9600b0040eb17d2f56mr726511wms.23.1706693235314;
        Wed, 31 Jan 2024 01:27:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU3tVoRf/Ilhag6NTF8xmvYPAjW7Ho+rPuOSGXzo2RiQEFRuGtN0xOmS+da8+LcJrxmdn5MKjeVtUW+ZnS+VLMbG3ZfPhW3u3Vu5L0BY0XM0aFTV7d0ySdY8fJ9TLTBlUpUmpPBCHhZOGL2Fc9eJuHE0ZolsRPLsT7e3HYJRzsgTBbUhpo1wUoKHLSgOqabOybMBJ6UVHYoquBpUlz0XBX3p4u0ZTPhgHGY9+1jO+DyTvn6KXFbv+W6yLabqTmTXTu9VoUcA2+6492GlezZpHV3yPQNwYqR1GvQWH5eL0bE75HEA6k5WtrE+bSB9R2XkIq2
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bh23-20020a05600c3d1700b0040d5a9d6b68sm1018522wmb.6.2024.01.31.01.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:27:14 -0800 (PST)
Date: Wed, 31 Jan 2024 10:27:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bridge: Use KMEM_CACHE instead of
 kmem_cache_create
Message-ID: <ZboScAVsNwqwiLIg@nanopsycho>
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

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
