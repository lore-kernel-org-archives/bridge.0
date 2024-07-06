Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7120B33
	for <bridge@lists.linux.dev>; Sat,  6 Jul 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720295781; cv=none; b=Sw4wHZL2XYvwORaIT7Vo/VlVU40wKr+tDh7FKUwVWY2FfUfJ/79ufumbYBGIYjpGBc5GXs4QB/0D3NTSwXWZ+lnUZ8i1YxBRnBGwIrHqnaR3WrvDzmtjPb1cEYHVroDBofUZ8DFV25ZMWggCrXaLr7yv/2c/8kaBB8WG7lZ4KeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720295781; c=relaxed/simple;
	bh=ABamVRk+WKBdPkS3Nr1R+yq9+y8SA7oZNui2ovWzqng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQnJVEtt8BZCdqnanZls+IOSRyhC44sgSLGLNUuy7U10KjyLDinCzvRUCqg8HSW2RcGg9bXID/ZxG6M98KDVYvVjlZ0pl5kfS4AS6qaJRtKexzKE/8Aug7R+cn1eQo/4wBRWHmV3kM2WL/80WTr0LhXkk6mvQm7rHALi9kGUVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=DkaKWe/f; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="DkaKWe/f"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d92aa6b62bso114130b6e.2
        for <bridge@lists.linux.dev>; Sat, 06 Jul 2024 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720295779; x=1720900579; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmKC/6dx3mlxXNLCeWHfcXH8XN1JAAa8PHgB5ApKUK4=;
        b=DkaKWe/fZil/iHsg10srTwwB72wozMEOIEetBYbW8yt0OpC/lkyC+8Qz3jKKbyGAQr
         fuWYwE4g4MO/eGO9cemLXcDChMu7abCi1G8t4DPiApmX1x+zYS+RwLEkcoEYIdIVKfHa
         jKJxkoGcgw6EYqca2Nn3Ji7ivCuwlqtm3BFEE+TuyWjYNxBx3eNLogZt22ONmowC5+tm
         5L3o34j9/ywPdldsObpGygo/KPPB5jtgqadOQ8hhHgepSgHOlOUovjBXgNHMPwovOKnC
         EqhMXOvbE+WYQ6JaEz3nE8HpBdAdYCBjml4pk94EAU9AEfh6VivX7S8dY0kUTfDiwG9B
         jlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720295779; x=1720900579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmKC/6dx3mlxXNLCeWHfcXH8XN1JAAa8PHgB5ApKUK4=;
        b=v4eevilPBCSieqhpQN0+eqDHiCWGq2n+cTXYHnCnyOZvtki+h0PZtguMwtxB1lHw6D
         4ho5tEGkM/6WdQlwHlKojeXCW2DBzPYPs91By8e9DnhRbqda426bxxeTb/QV5q+zAAcH
         wV47EtQRxHIzfvwe2el8AqGqIEvcpNhoctaP1Yg4/O4/1uReRWCdrvLV/GcSkMVAG0VU
         ayAz5dRN5EYaNrejz9YpiuT8wP9HmTFV7HBmsUajRsbYyZTKna2ADovZI1MUEnaiqHtg
         kSZ+ZhoBe/uzLCpI5I+8n5+6YJ1mrKhgg5QO9XP3ncR/Yvhae8Mhv6GGj5EGeR+zfJ49
         w1IA==
X-Forwarded-Encrypted: i=1; AJvYcCXG9tgpZBghGSzx4azjUZp+8umM7+8AzrwPF3nY466WpuhPkrGNDynh4+yqinfQixalb9AEI/JWYBrKh1aUFJhGGIztPcO/
X-Gm-Message-State: AOJu0Yy63LxZnaPJbwGn4gVS3bNSbuCAndm0GHSEwCAx2xImt0fLY0to
	zlsO0PyCyq1LfOUyIqlbcTJI5uCTDPfiLZZ4q1vIarvzBKzV237E6uZFaJ2xFMw=
X-Google-Smtp-Source: AGHT+IGqmw155Q3yIZQQnkRDwG/nqm14bMzVG6d+hLJ9DIXKp3mUoZo96llflZNaLnVzFoL5uauEag==
X-Received: by 2002:a05:6808:2227:b0:3d9:2190:9d56 with SMTP id 5614622812f47-3d92190a02cmr3701431b6e.59.1720295779119;
        Sat, 06 Jul 2024 12:56:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-76c7a4c4741sm1467746a12.45.2024.07.06.12.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 12:56:18 -0700 (PDT)
Date: Sat, 6 Jul 2024 12:56:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@kernel.org>
Cc: roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, liuhangbin@gmail.com, Tobias Waldekranz
 <tobias@waldekranz.com>
Subject: Re: [PATCH v3 iproute2 0/4] Multiple Spanning Tree (MST) Support
Message-ID: <20240706125616.690e7b98@hermes.local>
In-Reply-To: <547c13c8-c3c3-495e-8ca9-d87156bfe3f5@kernel.org>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
	<172020068352.8177.8028215256014256151.git-patchwork-notify@kernel.org>
	<d6e8ce6e-53f4-4f69-951e-e300477f1ebe@kernel.org>
	<20240705204915.1e9333ae@hermes.local>
	<547c13c8-c3c3-495e-8ca9-d87156bfe3f5@kernel.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Jul 2024 09:26:46 -0600
David Ahern <dsahern@kernel.org> wrote:

> On 7/5/24 9:49 PM, Stephen Hemminger wrote:
> > On Fri, 5 Jul 2024 18:53:47 -0600
> > David Ahern <dsahern@kernel.org> wrote:
> >   
> >> On 7/5/24 11:31 AM, patchwork-bot+netdevbpf@kernel.org wrote:  
> >>> Hello:
> >>>
> >>> This series was applied to iproute2/iproute2.git (main)
> >>> by Stephen Hemminger <stephen@networkplumber.org>:
> >>>     
> >>
> >> Why was this merged to the main repro? As a new feature to iproute2 this
> >> should be committed to next and only put in main on the next dev cycle.  
> > 
> > Because the kernel support was already added, I prefer to not force waiting
> > for code that is non-intrusive and kernel support is already present.  
> 
> I have told multiple people - with you in CC - that is not how iproute2
> branching works. People need to send userspace patches for iproute2 in
> the same dev cycle as the kernel patches. You are now selectively
> undermining that process. What is the point of -next branch then?
 
The original point was to have kernel -next and iproute2 -next branches
and have support arrive at same time on both sides. The problem is when
developers get behind, and the iproute2 patches arrive after the kernel cycle
and then would end up get delayed another 3 to 4 months.

Example:
	If mst had been submitted during 6.9 -next open window, then
	it would have arrived in iproute2 when -next was merged in May 2024 and
	would get released concurrently with 6.10 (July 2024).
	When MST was submitted later, if it goes through -next, then it would
	get merged to main in August 2024 and released concurrently with 6.11
	in October. By merging to main, it will be in July.

I understand your concern, and probably better not to have done it.
The problem with accepting things early is the review process gets
truncated, and new features often have lots of feedback.

