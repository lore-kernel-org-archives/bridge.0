Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851234;
	b=D7ZY0J/GHaCC2MzNC8ZZqzqiJdaYVveeuycMo+WN5+O5QXAk8V0lIhczJZO07RCXYXlb
	 cCZBWnYOYkuslwtlN++hY5+oi/bwFgjcwutiaYFRsu+PGT0Re4W7ma2y8QfdlWaCGgign
	 vbdV3dLtSujs6zzhWxM96cV8IJwlOZ3KhnKyGYdV6+n55C1Fr6oUNwZ8vXz7lAvwZtzmO
	 t1sJzYv1o+fu7YKgUoMSUQNIdSpkYTsQxH45aDgtfi+qGE74lbCY7GyTHegsgtvqBvmMi
	 ZYLMa5kxloNz39MNcOx1+nNj5uBSUqOgKMHa1pshMB+v+aByzZCoVRewBHKzV3b/WHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NinjwXEZqsyLzVMLGtZx22X19MLQYYpk0oH7D7uxDoY=;
	b=jKZidcJkyqh3bViy4g/23/v3yzeYQ5Xi4P8x/W0duWXxyoSRJatJemcm12RCgHYS0+Fc
	 sIU08c91IfoQv1pykJ1ciWTFl+5sgn+9F5GGkk5OQzhsefteZZQrj4QX5CPqLvle7lXGk
	 hDRBmn4+uK+fPN9XQBiZXQqe9lh7NFfThqP8MM6CnNMujmOoBZ2HZtoCa/zrGtLVA8yXR
	 X5rE6P6jUiWPQWDEwjkVK3eNNWwDHd/pP3aJCHiderP7vihmLHo1loozMflw4h9c52o2L
	 KxaR2XZtQDOv5DK+YASoG3K7lf2e2+fel+hWmcdexCjbsJS6kGpyWX9Ysm/w+DwXH4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=W1Xf0SeB;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E76606A31D
	for <bridge@lists.linux.dev>; Sat, 24 Oct 2026 14:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89E76606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=W1Xf0SeB
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4395d31228so259040266b.1
        for <bridge@lists.linux.dev>; Sat, 24 Oct 2026 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792851232; x=1793456032; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NinjwXEZqsyLzVMLGtZx22X19MLQYYpk0oH7D7uxDoY=;
        b=W1Xf0SeBuXDgSXkw4AHrvgOjLu524QrySh80l4XS1YhiBF5QQ6re/amXH73IStcJca
         aqeAn+KY/2IkUwWRZvR5dju7M0wRPpqv1ddn6T4d9FL/yF7d7IpF3ybt/8sN5rgClFzR
         UmS6wkb3rPptF9BOaQa0iW5OBCp7St9a7UDs2VY9H4h/QHf6M8a8KdFJtdOCJbCPXbEY
         s1of3KKkizeREK53zHNbfSgdhZClLQxcIywlCEffvD3n/3kRYDmC8Il4R2xcvB74YjHW
         kfQRu/dU54A+9Os24UZstfK9QlmkU/vtCytMfJj8o62cmuHRgxwjcomlAq3ihjyea42+
         W20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851232; x=1793456032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NinjwXEZqsyLzVMLGtZx22X19MLQYYpk0oH7D7uxDoY=;
        b=b6RZu/j8L+RbsP1qZQ2X3KI9JpZTsALK7YGb5/IlWiX6/a1+BSG74McoPEjWmFd1+O
         94RF79x484UQejxbz9YZGKgcY0rDVNfBreXTh6S8OQkoxwaYqTbrGSeS0tjwXaSTy3Cm
         bc5aibfJ+4KHE2uGA2z+ttFu9P9sGtMpiDgi2FpAWryAqkJpV0mnn0JfkcQnFIqmdwtU
         eyArFlX7nfBHPcJjhlOKwpNR1lBOwtbX5WfvUdsKAUJ6ZX4h/i1kj5nv3Dy+Djr5vmoV
         rDEIiMJhpwwS2WTRbZHQj9LdeExdgmJ6JY/pZQQLwHuA4fCMrCdEgM8aIuaNPCd0iIvN
         FrJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKCZICUT8XP0OfFWw1izL3i0Yyd81pG6k2tjCtp8GpGTvA/rIvUVqjq0ngH3AoUnCIaFxzopg=@lists.linux.dev
X-Gm-Message-State: AFq9FYKG1yPEoXsIZbYeyyPzAQruhAy2Y5LKABlxfCSql8rcAQH3CIbJ
	naxshKd3Drz5CIaSOnr1VyaA6yALMoCn+Pu8UoqkVyuqhcBfiKITSWcB7E5okYg6xg==
X-Gm-Gg: AYBFou2vEBhmTFdAAYp4YJyQrIUJpw5g/UcG7JFIEzpeSOoFCovxpatFDyPge/Klhcq
	PF+zkNLVsRiteOhly2y4Itszj031s+okBouxI31wmdy+qywTAfqlyYfR48teZqysBVlsKPOvWLz
	H5fYlcq2hNV5pBtVIMm7veGkfKHc2hRgpRTTCQCGDjwUQnz5WLhSwc1PAg0ZVUIUC0LVIqq86Ex
	Bi+bRUgdnD1cBzRsikL/iYdYlF5XoYYDUqG9zWpTiKljRFb7lQ2Fq+pEBly1A5TKOSpGcVNGaCT
	ZI8epts4up+5lYMHiEUbJn3VTJg16+/Eo7Wx0K1rbWlraigRmoGGHG+uvM9UKySzaYNNb5v8qob
	86vmtZH4FYu8bHseuEoxzV1teJX/r+q/5G8E50T+KSKaxPNDSFKiwKjuScgH4USurEOs63DPaVS
	eh/6RNzceBLtDpiTJ4gLIzRVd2R2lJDvM2p0aLTD3s2OhZfITOniAyOppobwVFIVkB9in2HB/OG
	hpIU1J8q7q8MVJ9pvDou6hNFek1G284tUgGyYq3wj/iQy0rP9t5a8wmLVPPOO99Lr/vRHJUldMD
	zleYA6DBayjwI8VACDtjCcyYHhpdnTTFR6HiHzWU9gb0unUQcfiYgM15jJMsZEfyqrLHO/G5CvX
	YmWTU7roKZHdlb+HxxqR4GWTGhWhizUuuLSnD4+ErU+hNNp3hDG9s7AN3tf9TTjdsRAW+d1AhRI
	E8XpUS+qvtzKTllfh2B6tkXwLNiCs94YhVJYcx2L2Z2BnVweY+v2J18s693V9RlCzSUYevI2O2y
	P7O2jG97FjFhjniL3OnqYBxxBxb+g==
X-Received: by 2002:a17:907:6e86:b0:c3f:c878:7c1d with SMTP id a640c23a62f3a-c46bddb3308mr236179666b.9.1792851231288;
        Sat, 24 Oct 2026 07:13:51 -0700 (PDT)
Received: from Desktop (p54afff47.dip0.t-ipconnect.de. [84.175.255.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd34fbe6sm95461066b.10.2026.10.24.07.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:13:50 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	kadlec@netfilter.org,
	phil@nwl.cc,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	idosch@nvidia.com,
	Eric Woudstra <ericwouds@gmail.com>,
	dqfext@gmail.com,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf-next v8 1/2] netfilter: flowtable: tear down direct xmit flows when the fdb entry moves
Date: Sat, 24 Oct 2026 16:13:49 +0200
Message-ID: <20261024141349.2145994-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017235849.1066624-2-julius@bairaktaris.de>
References: <20261017235849.1066624-1-julius@bairaktaris.de> <20261017235849.1066624-2-julius@bairaktaris.de>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Pablo,

Please do not apply v8. Sashiko found an out-of-bounds read in it: with
a vlan device of one bridge enslaved to another bridge, port_vlans counts
the vlans below both bridges, so the gc looks up the bridge port from the
wrong device and reads past encap[]. Resetting port_vlans at each bridge
fixes it, and a selftest case covers it.

v9 has that fix, credits your patch as its author with your sign-off
and a note of my changes instead of Co-developed-by, and is rebased
onto nf-next. I will post it once nf-next reopens.

pw-bot: changes-requested

Julius
