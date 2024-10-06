Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A555188721
	for <bridge@lists.linux.dev>; Sun,  6 Oct 2024 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728236542; cv=none; b=Ry5yslI8icOoLJZvto+An7XY6jyZU902Dg1Dg8xLJJ2hQzjfDrjtEUTtzZFJebfHLRfweXUkUAmxoF0FwvzGwntwVtGhfxH1r+3O9tn0oOo0Y+sXXxU9EWEFd0pyY8Ga7Z8anvMs5rwpiWKvItKLGtCnlbGypYSTpIKmyDj0mNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728236542; c=relaxed/simple;
	bh=bOvz4pYabcDoZLoEs0sff0Pn88xmVja7LCwJGlH+9Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjqOQDLvxVGNgAXEPJZn/arQgIbhQ92aXRsBzr1JMuTPdlemGQo0L3dl3JtLHteGLOUh2Jdt0ug1f/2yAIgaaqaRfANSPOA+dL8xscDlnohCPzDi/n/zLTAZ+sYoEI+jG+Uw06fbjSuzzh1xs7MwpDQFfS5oKkA4Oy82P95SmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=C37FvL6c; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="C37FvL6c"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cae102702so27867735e9.0
        for <bridge@lists.linux.dev>; Sun, 06 Oct 2024 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728236539; x=1728841339; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0ZI6ioZn3DighbuW3Kr9aBRm249nRfxXwsbXRgrMZs=;
        b=C37FvL6c+bOGcD+z8gY3neA47+x63fUxfv862tANSDhRL5rHaszEF1OXyUZKCzhkyN
         fHqsRocSIX2wePnfljtVyTJ706gLJ3j2vvJW7M/toISSazIt4MpsZlzs6oBruGpyQptp
         DSy+li4wTAUjg5uFgaBUADxLS/USMpHosO9HPPYymIo+Id25nedfeodcBu2pA6RbkgE7
         sXoyZxHHKAV6oz804hl2yiI4+R2UvFNVQxry2Iw0jt4JxisWOobJMJz3xaybWo3Yg3pk
         Uj5ggcu9IyQ8WA7JhMLf5nMYFd0Vw/N/rpsZMD0//YoEoK4BGHmtW55vhmytWk7Q/f8+
         Ik+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728236539; x=1728841339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0ZI6ioZn3DighbuW3Kr9aBRm249nRfxXwsbXRgrMZs=;
        b=LYC/1f9gJziwKkOv6rO01eflyZVfORtroS7jjOiVn3gVZ5aaGDKW3LEHKyT75rVrJ6
         BZL73jbSblPtC7SqrUkuPx2z0cSHupmMrB0+rcgNgIY/TfmQjRYMpqh0duNYrWAvLHMU
         vxeN8YxJ75RT3BbXaUzFZL7liA08oA/ceHPKKb+jLnjCG8THzhZaeJtkii1rWvn6nMU6
         b4tZngS6+sLEN3aJT0/imyfdGsHj6CRBmG9Bgps9nY92JTkkoXa/jpDM+H8zSzn4y5PR
         x3EdMdSZUgvc4NGHcN9vbxPgAqsCLW4dk6fKQMe1F1RAbBDOERG15hBOb0Q3l5Uy0kD7
         BnzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz3uoQdqYls87oNfAMWRGjY7ACYA27W0Q2tNxul4jpF6+m7DH2HhwnP55sdDeru7HSA4vCv1w=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5FlyItNtAgCit2LhC38KsCMTIxaX/i7XkXgEMH72zitfrkEAr
	/bP8/3gSgnHOaPQxtboP0mUfR6O64zaJ+bBpNCC+IUKl9hNaCF4wHd+OF5LpFOo=
X-Google-Smtp-Source: AGHT+IGoaSO8mXybmttjE0PjfTON2+lvsPgF+pKcE8RcfrFzGQ87t9Lb+0HugsiuUxPHtdIqWev3Uw==
X-Received: by 2002:a05:600c:4514:b0:42c:a802:a8b4 with SMTP id 5b1f17b1804b1-42f859b0f48mr64493895e9.0.1728236539304;
        Sun, 06 Oct 2024 10:42:19 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f8d133b73sm38697715e9.9.2024.10.06.10.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 10:42:18 -0700 (PDT)
Message-ID: <8f815f67-b0e7-4425-8c0e-6a6449ee35ca@blackwall.org>
Date: Sun, 6 Oct 2024 20:42:17 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: use promisc arg instead of skb flags
To: Amedeo Baragiola <ingamedeo@gmail.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>
References: <20241005014514.1541240-1-ingamedeo@gmail.com>
 <c06d9227-dcac-4131-9c2d-83dace086a5d@blackwall.org>
 <CAK_HC7bOe2KhVnDiG4Z3tpkodiCkewEct7r2gXanjGBC8WwFsQ@mail.gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAK_HC7bOe2KhVnDiG4Z3tpkodiCkewEct7r2gXanjGBC8WwFsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/10/2024 20:24, Amedeo Baragiola wrote:
> I agree, just patch actually changes the behaviour when a BR_FDB_LOCAL
> dst is found and drops the traffic because promisc is *always* set to
> false when a BR_FDB_LOCAL dst is found in br_handle_frame_finish().
> I guess the problem I was trying to solve was that since the
> introduction of the promisc flag we still use brdev->flags &
> IFF_PROMISC in br_pass_frame_up() which is essentially the value of
> promisc (except in the BR_FDB_LOCAL case above) instead of promisc
> itself.
> 
> Amedeo
> 
> 
[snip]

Please don't top post on netdev@. 
The current code works correctly, my question to Pablo was more about if the warn
can still be triggered by adding a BR_FDB_LOCAL fdb and setting bridge
promisc on, then we'll hit that codepath with promisc == false and it's
kind of correct because traffic would've been passed up anyway, but the
promisc flag can be actually set on the device..

Cheers,
 Nik


