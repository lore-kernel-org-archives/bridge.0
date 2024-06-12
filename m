Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515112C544
	for <bridge@lists.linux.dev>; Wed, 12 Jun 2024 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232783; cv=none; b=WUKva0SWWmrViVtstZJIofKwg3giUS8nS2ZzZurhQjrXMWD+x3Miaa6Ds/f0K1v5JLjm39A4iYt3wcTj3YariVlu3yyv9m1QxDiaGsXjyzzrHevsxAaWD4o9/E8DCYDYhSOyPjYOhmUm1Jqse5+LzfMZun9sxq7Nf1eWX3evV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232783; c=relaxed/simple;
	bh=L3qaXQNUUVxh4Q0Q3RMUhGqp7sJ7EFx4+fzYvA3H52A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnhABadrxbBGOFToVx7B8LkVH78mkG5MUei6ePJj+BDmVyp1ds4KlQFsDj0AsFMdegpc5X3YPQqpAzTqNI+n+SH0fYpM70/Ams3QApC73bQSnz5L56hJGGE8S8AslywrOSorzShcwC+QZBimQin3/5dSclXZpi85WJ8laDbi9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aywWeOVU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aywWeOVU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f6f23e9377so441805ad.3
        for <bridge@lists.linux.dev>; Wed, 12 Jun 2024 15:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718232780; x=1718837580; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCKGfocKzBU0+xeBiPtl1Ex5TwQcMh3k2EBSdA3xSn0=;
        b=aywWeOVUGrIkRg4/5l8metH/8VJZjdCaRlh7qwjZPBrH9f+qTtXLN+T3v1rajTLB4J
         VC5lrrzbznLDMlvRocm05xim/PNY9RCFjHdx7TYO+IYWqQNNRUlONkeqXP1LUuvYLP1A
         pmG+l/2s3VOIuVpxjEygfi9m5RZ7oUGG2ve/0b9kba7+GmOtFn0OohtroOu8YDnQCa0n
         fckUfSpsQC3QkOzTP9m1xw1LKnKoLSnAcyB+LD676KqOvInMm4fuBIdr0PWTKozmkXb3
         vb1axFIZiYFQ6/mP3QcGxvrxlLV50bDh+2G32ATxV/96bG7KIV+BNsfWpECXFHrk5wB8
         RVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718232780; x=1718837580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCKGfocKzBU0+xeBiPtl1Ex5TwQcMh3k2EBSdA3xSn0=;
        b=w7lZOm4RLEJJOlSrrNN+Lh6/vT59zK5gyTQuc4/22A5wSgqswGh6JJgWrgVaGOxKk3
         YbTzROM6rJkzSFXXlLByk9GLcom++qbh+KFr/7l7VjsU1Q/WyyNWwRyAjolj15xuufyH
         uzgeUZCtCRu9+hJNBftmP49vzEPXbJGlPDDSUv+AoOPXE5ii+ZgzKylu5mZuEZAWtXIo
         aBs+4USGqRgm45cJm1wTMnslJ2iLWMLmNn55hhC3ZgCPsiKM/V9N0MwVLDFXTBkMVcJR
         pTVUvbpZwd6buTNfmlN/DOJ6CfzrGspEjd7cdrCtk4ltQZKjHLCTZjG0PHQdgOUUCJhe
         2AXg==
X-Forwarded-Encrypted: i=1; AJvYcCUpaSiaQZ9tirG9NvowPHn5I7XyLaxCaubrEJc2cHO+pM6I0YCaGY3Rui5//PZmvYKgFs7j/MM=@lists.linux.dev
X-Gm-Message-State: AOJu0YydukFKfX/4Kqwqw2OhDerubYyVtzN6fa/6DVA6y8xuUhd/IOEK
	uguxPnyHkeEGXyYAyicHvaHV/khVQrOfxLm2j8kia8FMvwPiTR9/RJIIMkYLaw8=
X-Google-Smtp-Source: AGHT+IH5UZSMoyLCwmMYbQsnXovMsmtOxcZgzfit4qNG1yAnUakar4EveGlx5xiJfFg6llU0rCt4rg==
X-Received: by 2002:a05:6a20:5647:b0:1af:acda:979d with SMTP id adf61e73a8af0-1b8a9b4e85fmr2859600637.1.1718232780575;
        Wed, 12 Jun 2024 15:53:00 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d2c5sm73821b3a.105.2024.06.12.15.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 15:53:00 -0700 (PDT)
Message-ID: <7e58e73d-4173-49fe-8f05-38a3699bc2c1@kernel.dk>
Date: Wed, 12 Jun 2024 16:52:57 -0600
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: paulmck@kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, linux-block@vger.kernel.org,
 kernel-janitors@vger.kernel.org, bridge@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Nicholas Piggin <npiggin@gmail.com>, netdev@vger.kernel.org,
 wireguard@lists.zx2c4.com, linux-kernel@vger.kernel.org,
 ecryptfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-can@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 Vlastimil Babka <vbabka@suse.cz>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240612143305.451abf58@kernel.org>
 <baee4d58-17b4-4918-8e45-4d8068a23e8c@paulmck-laptop>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <baee4d58-17b4-4918-8e45-4d8068a23e8c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/24 4:37 PM, Paul E. McKenney wrote:
> [PATCH 09/14] block: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
> 	I don't see a kmem_cache_destroy(), but then again, I also don't
> 	see the kmem_cache_create().  Unless someone can see what I am
> 	not seeing, let's wait.

It's in that same file:

blk_ioc_init()

the cache itself never goes away, as the ioc code is not unloadable. So
I think the change there should be fine.

-- 
Jens Axboe

