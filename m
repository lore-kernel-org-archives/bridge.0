Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF9D379993
	for <bridge@lists.linux.dev>; Tue,  6 Oct 2026 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294296; cv=none; b=ptRIrVam4I8TK50dWwZ/F/PsvuqdOaa5lrwfqG/9uefadb+cc418Y+aurDRMy5qL00ytIC5+GB5H+yfYsLVDtGE1QPi/r1ek7ZLGWMix4BbMTHnIXTEm6SeH4r1kcf89TTBYrnU2IYb05DaOEbcaF17fYV4r4VTNdfoCfASymZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294296; c=relaxed/simple;
	bh=V6D+x0smronF3g8z0odwioKw+hnp+0IegOI8i9Pr8zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqTauzSjqSJZbKIL78xskew2fmsYHwbITFHvh1eJG8OVrtVMcl5ksWHHfpz1OS1k1qNdE5S34K7vLN3FCGxcVCvC7oa1NeK8KOg6sKHAxGF6ZwLjxWtfmM/Cql9rAAiH53g05JYMV7CtBNZbX8lLJUsjPmR1SfOVjQVTZ9o2bvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+HvqN9S; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+HvqN9S"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso1968136a12.3
        for <bridge@lists.linux.dev>; Tue, 06 Oct 2026 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791294294; x=1791899094; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6D+x0smronF3g8z0odwioKw+hnp+0IegOI8i9Pr8zs=;
        b=q+HvqN9STc0iLD34lhJ3TjO8Q11bjVxEcK2ksctqOiLyofNI6e27oPHvf+ID8d3bPf
         1btAPZiO8ApdvTYsVkeQgpUYhk8EUnTYkFNMdKVb3RWaaUiyXRapFlHCdof6w3dyyYxY
         XWu/uY1zo7JraTMVSDyMaIocL8NsWo+iGQ1Y7PWRQIdgGwYEvk38lUttAtFpVjgobC2j
         S52qaQ9RDs7DKAQpAoLU2AJzBAM58NymFxF//oP4/oqtwnqCblJ0RIr5r7RxNf7+TZWl
         qcmGFwABuUm5twcHjRROZTKFj4IJD3jKMjqZ1AgbI2qPxQ16VAZsr66MUAWOFLD5+XHa
         1Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791294294; x=1791899094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6D+x0smronF3g8z0odwioKw+hnp+0IegOI8i9Pr8zs=;
        b=qHa4k0iUY8WSAu6o07Zre2jGvUYxrUAcsICH0pTABMAF1IG5hhH2B/erfQx9YUaw2m
         R6tDwQ7l+ULghkMmPhNOOYOfOe8rzINTnGUVfbEz8shDu8iBHMYsbRMK0j48tqknZBHX
         4gLt9mdTiqhkksqtlvCdpmy7swqIajIt5m4lQDGudSUqnCVrGmVaYMvB3CWxlRSZ+uhK
         4spGzgQB3xuXCEgC4KoZvegKBAgI0Shipgz3ngoyfoK731uFlBdW1E6NoX8avB/76irA
         nuXh+0IlWMEN/ry64mjsylta9j7lhauS6G4zNBmRoICuXMhzWuUfDY4M7dYmQ04amlNq
         nH6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzig+MIPx8zjPLxxLk+tF34UNWzDmdC8/2INZMIJve1u6k6Dyt+J6SdUr9OyfEGDZfB+k8IrGc=@lists.linux.dev
X-Gm-Message-State: AFuF++m2PpqrGHqbLwjffVfB9/wXNo8lsCfOjnQbGU5xvO0h7aowhRfe
	LqpOEmGP1qNXUMBY9C896OcilZIvSDsCsLOUc85rx1N2YtFn6sb67vgi
X-Gm-Gg: AYBFou339qGrJv3t7nLwjYWjl93Gs4WqZElnCh9vc2zxxu1nzh4XCIDFteYfR4T3WKQ
	hA0ovSfdDR0MElo7/5RXbV+Ur5DfwoJXAh2fgcQpPe5Saj9M2ehS0COKlzzXVk65yX+CI+o77aj
	etmv3G0TnbyYfNpYIJSSuGXG5bq3suNpMFqH1CmIAHcklF2NKWcuGN8UpFsicdC2J/4lRgcQWgN
	1JVse1YiGRPMceT95itiQmG0IBbKoQFs+GGhgMgMCI1Wffir41Ull+jT0QhSU93Rqh1eOWkjvH6
	3c+F3qkdvF95qAB4HPmNPjtp9LlO3hO8VqkF0r2IytdeCvgPdstJCHc0WOeGjKKCvuXkyxDi/PM
	8S5JO6wuuu2lFRaqG6+YKFLc0ijwJ0PigVm9SU2/pDBF+Z2EHJMaZTP2eDLahX/vsdtOHXGUr0+
	QclzLVXVYfxuOEc8khFy4Us7rbh4Uxw0TdC3Xa9izxsSTisek4frMEPKPudDT9trqjFGDY+N7aP
	UpjAmZUeq5xJQZUBA==
X-Received: by 2002:a05:6a21:1b8a:b0:3dd:a197:ede6 with SMTP id adf61e73a8af0-3e0d6b61e4dmr9572185637.53.1791294293744;
        Tue, 06 Oct 2026 06:44:53 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0968d432sm4911520b3a.6.2026.10.06.06.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:44:53 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	razor@blackwall.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev
Subject: Re: [PATCH iproute2-next 0/2] bridge: add cfm command
Date: Tue,  6 Oct 2026 13:44:41 +0000
Message-ID: <20261006134441.3696739-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006104249.GA643161@shredder>
References: <20261006104249.GA643161@shredder>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 06, 2026 at 10:42:49AM +0000, Ido Schimmel wrote:
> Please elaborate on the motivation: What is your interest in CFM? Are
> you using it in production? Does anyone? Who needs this in iproute2?
> What is missing from Microchip's cfm tool?
>
> Looking at the kernel log, since CFM was merged six years ago, no new
> features were added and the only bug fixes are for issues found by
> static checkers and LLMs with no reviews from the original authors.
> There are also no selftests.
>
> If nobody cares about CFM or uses it, then I would prefer to start
> deprecating it instead of accumulating more code that needs to be
> maintained and that nobody is going to use.

Hi Ido,

Thanks for asking directly. Short answer: I don't run CFM in
production and I don't know anyone who does.

How I got here: I work on BFD (FRR's bfdd and an XDP BFD data plane)
and was looking at how other liveness protocols are handled on Linux.
CFM in the bridge had no iproute2 support, so I wrote it. I didn't
check first whether anyone needed it, and I should have.

Testing it, I found the bridge CFM does not keep its own timing at the
short intervals: with a 3.3 ms CCM interval it sends every ~5 ms and
declares loss after about 8 intervals instead of 3.5, because the
timers are delayed works in jiffies. The ccm-tx period also overflows
a u32 above 4294 s, and interval "none" with CC enabled rearms the work
with no delay. I think that fits what you describe: anyone running
the short intervals would have hit the first one.

Microchip's cfm tool covers configuration and show; what it does not
have is being packaged anywhere and a monitor for events. That alone
is not a strong reason to carry 1300 lines in iproute2.

So I'm fine with dropping this series. Horatiu, do you know of anyone
using bridge CFM? If nobody does, I'm also fine with deprecating it,
and I can help with that if you want.

The same goes for my net-next series "net: bridge: cfm: notify
userspace on CFM config changes", which only makes sense if CFM
stays; I'll leave it until this is settled.

Thanks,
Abdul Wasey
