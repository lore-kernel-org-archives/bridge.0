Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4509BA3D
	for <bridge@lists.linux.dev>; Sat,  6 Jul 2024 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720237760; cv=none; b=tquILnT5AalW58uG/hV2IaaGCrN89Op+SOxKJ77hV3+d4s7gQAg8Xfo6ELM0tNvwa/HPUvGEoPUXJWMueybJOC+VI4s5gXIGsWPob2H0xEGl/GA71ivqtDvqq3JHGi+sNguC3XxM6uQZWfNomOYlufGAQydgrwSyxDKuokg7Z7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720237760; c=relaxed/simple;
	bh=Td3ciUT/XyAi2M1puJRtzByKWLl3qhelQxxg+L6wW4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQwkpvCpY3hjdwzW/bK9DV+XqxdjpQm0kgInLs2HHE9ZFrz/ruqGRiRZvYQ9U1CZjx0aDpX80LYT4wHzL8zDzf8Sgc9yJKPlG8IAnx3/cr0am0t55yDQw0u8OhrKl5iPUiOlrj+p7JMk3IAHOC54R5w+y/Iu1n75n5nVaP1ToyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=aGTyJxuL; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="aGTyJxuL"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-380bfd7cdbfso9586045ab.1
        for <bridge@lists.linux.dev>; Fri, 05 Jul 2024 20:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720237758; x=1720842558; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnOTAnErmcA1qOpFILyzTLPVRfVLxD4gpoXVgZ59Snc=;
        b=aGTyJxuLGjYjihb5UDvjf4MjON0yAEA8Ym34n7AUpI2kbknZIVKqHQ1JS9iviNv6TB
         UdFbQMu2o8JSdAQF3gOkW9my1f+4xP15EoWbsBn2mKYApvZrjXHHFD9SIvw9gAxGswdy
         7+d8IMf5A9hreDQ0374M+IfwFtc2rWNRcMcxdvj1GZ7x97gq3K3gqYfUn5+yfhDMrJQV
         qfWufkYWrTtiOJi0JNE7t70DLHqioHT5Vf/4LMPqm7dir3L80TVUC3ruCV8YdMALcwcL
         e6u1SdjXvVD2G5Seg82p7ij6PRY0Y+Cyyo9uihXTzlIQ39Xt4jfGChCTGNywhTWusmhO
         q6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720237758; x=1720842558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnOTAnErmcA1qOpFILyzTLPVRfVLxD4gpoXVgZ59Snc=;
        b=wBrU+r90f57LhUkNOXHA7Xq3uBIBagWdLTLVHF/CMKJHC4cLwEvTMlwnK6IaqB14G6
         seAlb7Jc58V5dqfPyOI1ollZ1d2ATh7+jDoEs/rsw+Ohn4PYyhhiJv+A2dA4sCH9/wcr
         VJ0nVnlSiGLY9Q7HIiNGw16QHrVnhEk7DSVmbjKxB6WFDJRDrF/8+gwLLdDoMoyR9kyC
         vRGifelMLssyU3Yung417YE0kUvgxr+2bNSZBxDyxcPZqY0i5S0wBssEY4GhJ3xUn0+O
         hIEmW6l7Im0J+nrO1D3fJHSK8uLceZ8WWJfThkNREWrdHyX3kbPv0xePgbddbQ9FZOw4
         ba5g==
X-Forwarded-Encrypted: i=1; AJvYcCWdY799kMG4vlxfbW4KycdRWIyD9UAM3e7hkICazcjtTZTgq8NB8SK0D+ktfF/Aj/G6o2t8ZYsjbq/0epikWxTxzn8UOYbF
X-Gm-Message-State: AOJu0YwMwVxrPYQ9s15gipXmuzt8BTRZc071iR0QQ9Vw9GqRI+CLDKry
	2vfIqNxTtx7Dpx+dwv0WravvdQXbMGXHbOZ2SJzzj+oV3iLlWg4/asP/9gcgtpE=
X-Google-Smtp-Source: AGHT+IEJT8B3fp7ZbV3Cscazd5MmRHLxO+U0IJP191tISQn9KRLT/SXoY7slWuVukOvYMOuX6NcD3Q==
X-Received: by 2002:a05:6e02:1b01:b0:375:da94:e46b with SMTP id e9e14a558f8ab-38398430abcmr73667595ab.5.1720237758380;
        Fri, 05 Jul 2024 20:49:18 -0700 (PDT)
Received: from hermes.local ([84.39.151.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb3e542ce1sm31958695ad.153.2024.07.05.20.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:49:18 -0700 (PDT)
Date: Fri, 5 Jul 2024 20:49:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@kernel.org>
Cc: roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, liuhangbin@gmail.com, Tobias Waldekranz
 <tobias@waldekranz.com>
Subject: Re: [PATCH v3 iproute2 0/4] Multiple Spanning Tree (MST) Support
Message-ID: <20240705204915.1e9333ae@hermes.local>
In-Reply-To: <d6e8ce6e-53f4-4f69-951e-e300477f1ebe@kernel.org>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
	<172020068352.8177.8028215256014256151.git-patchwork-notify@kernel.org>
	<d6e8ce6e-53f4-4f69-951e-e300477f1ebe@kernel.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jul 2024 18:53:47 -0600
David Ahern <dsahern@kernel.org> wrote:

> On 7/5/24 11:31 AM, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> > 
> > This series was applied to iproute2/iproute2.git (main)
> > by Stephen Hemminger <stephen@networkplumber.org>:
> >   
> 
> Why was this merged to the main repro? As a new feature to iproute2 this
> should be committed to next and only put in main on the next dev cycle.

Because the kernel support was already added, I prefer to not force waiting
for code that is non-intrusive and kernel support is already present.
