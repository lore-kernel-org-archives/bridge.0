Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971411D52B
	for <bridge@lists.linux.dev>; Sun,  7 Jul 2024 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720387003; cv=none; b=TcZTfJYgicjutncCrLK2PDf7d8o4OBY5HMQuA4YVukMl8RZqCB5jStUhGYtRakStBzn2jmxgd9BrPyKzcr7ek8/fMIscuVsGtY69wd26t5Bvdn7nsGqMmRoRUX2r8WGP/EwlpXtjYluFWJaplZ1463PfEhjT+aQEr59UiuXWCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720387003; c=relaxed/simple;
	bh=iRmFCJ5phnOkgFFJS/eCRl7vqEuLMfaGgJ074lBD2QU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aO6i9JFn1c7FIVG+jWLfq3XtSztS/xNfVP3K/uwJm8qt188u3+o8uQKGYagn0O/N/7bcJYz4Sq3948MHTFV/4uVj/iCH3lKk2Umcbb7CB7mpWEQ9aOgVaeN1Wc5BwD0cNjBpu0j3cen4nToSwXl+9YExTFsoVloKnyrGwYPjUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=N/woqYXn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="N/woqYXn"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb0d7e4ee9so21249855ad.3
        for <bridge@lists.linux.dev>; Sun, 07 Jul 2024 14:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720387001; x=1720991801; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7rujIh7kUtCTFUJXB9kK3k8vU8XwkXhSTPtNGzN56s=;
        b=N/woqYXnz1rOE6mMz4pr/4MKGr3Vx9CNXba7PrvVqdsleZAYPevkDmpbX+Vzkxe0sb
         zqzT1zufXPYVyCATYnBJEVhfaOlHGIVrkQZH3EgqgPP7t08Y5iiPybAwbH8DzLnxCZi+
         Behf90o1/+yoDyV6A28ouw1QAaApORizLBDLEIOQFR3kYsD31QvS2SKwUqTbJRN1QJtP
         GRpuj/kXYMg+EaWmTpICfnqVWJ8poQmLICFVEm9x2bh3y8U1Pm6v1xIuYSIv526OM38F
         YuRGsacZxFMr5CuSYoeasafE3f9A87FfNB62jlaYOLwxGsdE1WYGUgnW1HQXym3caqZL
         F0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720387001; x=1720991801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7rujIh7kUtCTFUJXB9kK3k8vU8XwkXhSTPtNGzN56s=;
        b=ng/43F2grJX1MKm/ZrSclogJPH3m1CvVEjCpuc02uYw1g73hrfdq/sBwTmGn0Bgrgm
         UBWFls1WcOHRqp8hkKpwdVin9n8K1vInw99wsUEjRMXRulrQ3wHYJvlsSIgltwK2jq0C
         fJlpBm6gzRGzzm0oibbZW+BsXLgj/nqyAzfAC18GoM+8gzn8qHJ1ylZMdvcTLDlOpfNJ
         fPIcWKFkHk9m7pNKFUybM0pqo3NuCbNlUc1B9B0HXkKmtC1Zr3nb1tJpNfD4kf2iG1Yj
         90i08fgP23LT6z13vSyZh1r/dTtB16w/9AltosDIV2HepFl4TJ2BdAWIBk1vHu4YR5vT
         OD6A==
X-Forwarded-Encrypted: i=1; AJvYcCUMii3OcwLv9qs4fnSovpo/ZWKLwmJAN6OPySCZJsWNq3FAFdOfXPNgbNxzYJA9WAy6LFPEpknnyH7JxJjWzAbCC34tgfs0
X-Gm-Message-State: AOJu0YxxDfVyffOd/H1yrA7IcLMyysiUmGJvnj2+O1rWyAriojqy/MhC
	xR+u+y6512OoUNDjCj2EHnZFsQt0EKrh6QapqPtlJkqldJzkieIvJT9qBxTYHEo=
X-Google-Smtp-Source: AGHT+IE8Z8fZB6kUhyPOMHUOeNTaoPytTCqOQNgAm87ZwnmIJz9NCQrVtvYpbTmjX0IBivQi/6hTSg==
X-Received: by 2002:a17:902:d2c8:b0:1f7:2293:1886 with SMTP id d9443c01a7336-1fb33e05413mr81267495ad.12.1720387000805;
        Sun, 07 Jul 2024 14:16:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb64a608d6sm29879215ad.176.2024.07.07.14.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 14:16:40 -0700 (PDT)
Date: Sun, 7 Jul 2024 14:16:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@kernel.org>
Cc: roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, liuhangbin@gmail.com, Tobias Waldekranz
 <tobias@waldekranz.com>
Subject: Re: [PATCH v3 iproute2 0/4] Multiple Spanning Tree (MST) Support
Message-ID: <20240707141638.799ac0b5@hermes.local>
In-Reply-To: <c83bb901-686e-4507-b4b1-020ae86d2381@kernel.org>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
	<172020068352.8177.8028215256014256151.git-patchwork-notify@kernel.org>
	<d6e8ce6e-53f4-4f69-951e-e300477f1ebe@kernel.org>
	<20240705204915.1e9333ae@hermes.local>
	<547c13c8-c3c3-495e-8ca9-d87156bfe3f5@kernel.org>
	<20240706125616.690e7b98@hermes.local>
	<c83bb901-686e-4507-b4b1-020ae86d2381@kernel.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Jul 2024 10:16:11 -0600
David Ahern <dsahern@kernel.org> wrote:

> On 7/6/24 1:56 PM, Stephen Hemminger wrote:
> > The original point was to have kernel -next and iproute2 -next branches
> > and have support arrive at same time on both sides. The problem is when
> > developers get behind, and the iproute2 patches arrive after the kernel cycle
> > and then would end up get delayed another 3 to 4 months.  
> 
> Then the userspace patches should be sent when the kernel patches are
> merged. Period. no excuses. Any delay is on the developer.

I would suggest that the netdev maintainers not accept any new
feature to net-next (that uses iproute2) until/unless the iproute2 update
patch has been posted. This prevents this problem, and the problem of
getting userspace API wrong.

> 
> > 
> > Example:
> > 	If mst had been submitted during 6.9 -next open window, then
> > 	it would have arrived in iproute2 when -next was merged in May 2024 and
> > 	would get released concurrently with 6.10 (July 2024).
> > 	When MST was submitted later, if it goes through -next, then it would
> > 	get merged to main in August 2024 and released concurrently with 6.11
> > 	in October. By merging to main, it will be in July.  
> 
> Same exact problem with netkit and I told Daniel no. We have a
> development policy for new features; it must apply across the board to
> all of them.
> 
> > 
> > I understand your concern, and probably better not to have done it.  
> 
> You applied patches for a new feature just a week or two before release.
> It is just wrong. It would be best to either back up the branch or
> revert them.

Will backup the branch since these are the the last patches merged.

