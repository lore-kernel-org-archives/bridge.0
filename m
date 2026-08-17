Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D6424D6D
	for <bridge@lists.linux.dev>; Mon, 17 Aug 2026 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977397; cv=none; b=efQyJM1k1amtIOqr59Z6dmh8fQiTLVVptXOXnfpT/rS9WV0rAwM9ZnLH00jXDDeMW3W6VSajxEnFQSjF9kNXwCF9NWgSu4roEHtCGGxWCN6dAKA5a7Ry7uilkQwBZVZZwiIEyCwuK+XSxCo09NP6qB0lMYVgIGmqHkfgeg0IZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977397; c=relaxed/simple;
	bh=WRRnItr7pg26V/wsrPUd/63682Kla4MReH7VKQppslw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0Iw1IdBDAPS477otUzvJHzg+FsVe0oOhuj/9a4uEqgznzI0yb8dz635qESDmwQzUxmHf3QNvDNWdlbOAHLcr58SuyhLrsdN1F5TDudISRz2rNQr9vB30wHY25sHOMPyn4faVe4ptsO+aRIW/YcXdYrLNeUnyl1o4GJogLcggZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=VCWQ5+vf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="VCWQ5+vf"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f633e6058so3063839f8f.0
        for <bridge@lists.linux.dev>; Mon, 17 Aug 2026 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786977394; x=1787582194; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e/5GT416qLvLcakCe9GiPOyaENUM/ilgobKMMfIItiY=;
        b=VCWQ5+vfKISMeFsrxqZycWNBXTq1LPXbSgR7LWdB2tdAh/UBUJBntiKlQ64l85Vv90
         men/XjUZEcD/6SyZP24pgHOjQmi5zj44Mc0VlUIqxP78cFBh5WvYZ4212IBSHNJoBFKV
         lc7JpHkSO+jW4KHpykFLYLpY7aK5bE0pk4ceY5loK/S18xuIyO3jENQKYaFj9ap08XnH
         4Bxhyf/P3LZIJn2gtMWIN4prbZIZ7RveM+orPXmXzEqRk2tJDcj/0y2S/0qkdHUgPpyZ
         GM1AgeUMs0srpZ+wMRufpxmx8JBTQA3xHiwRB62UY72af4WxFVFB/Irok343g9agOKTG
         s46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786977394; x=1787582194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e/5GT416qLvLcakCe9GiPOyaENUM/ilgobKMMfIItiY=;
        b=i7y+Zqu25jivic0q8vG8dejqE2hPmIhe2Q7o1CthlvlaxNW7Do6lc11Ms8pwHmDFPk
         /7ZDQCRjOL3dSBZIzzP7knejQFbJ2X7NGOAHaDF83nAN6z/fzGnD2i/GPQV5E2bhAPMr
         Yvp1RJ4mOEFmw5asVvzT0JE3tUl5bwQzNxlThy/tiZyPpwQcebIQqOuZbjcoXXwswjob
         QiCZ0xCytip18K0TDvqG85XB0AHCEkzrRZqAhav36OP50fC3gD+VVMgngb3fNM8qav0U
         RwALyr2b6dJTQzUj2UegvcPWvMIszvxaDaxNyzAI7cUoHbaNWU2JoJfVD8le3qZUZaKm
         RXyQ==
X-Forwarded-Encrypted: i=1; AHgh+RpiDiobuqLkFobPKTKAufbAsipHxbdNW4zOsVETIKwtlGFGtcjlBAb9lM56bvDuqCKtH3/iuYE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy28Ry4By4EShy2/p+P/OWjRI41htM4z4/HftCFg14KMxtKxwu0
	6u2akOAntnZ7B1QUl+Iv2zRQStRtGGbznay+ZmLE+wHQ1Cp3gKMILmMfkEPorKLvcSk=
X-Gm-Gg: AR+sD108C+ooagyNVfXWcm7C7ZBig0iunbM7gIlMSISYA/Sbln8pVWOnL6Ido7vQ1kC
	XsiNlrCdJhUOse0ETuqyqGobTJ6yi+mY0mfTEehvpAYrB4yseHuU/p1FuGiIE4NRe6fUXYrdqGP
	SWVWnhWSuIP8pjDO1v/yXs1nHzLzkTxkOpWlqntjoWuV6hYcOrYMZXgo4fjXxKAOEIT8i2ZfP+I
	dzMth71a3xiFWS6oQzowaabLe+wfUzV6iK4xEOSfVJXBvOPpae/zPslfw3LahtSLoM+6S72Lh4m
	JL3U8V31PP5gyGaxa+JTtxmWsMFJQvWBeooEOJpNGF7p+m4gWGJSv4M6JkFk/Hu7vJqsquF62IT
	rkWQk7cBYUpa92I5NmDuVUFuSiOsXcqlTSRB7Vyfu2UI0WZymxgFc1xpa+tDnRLuRjSZqm0AGHQ
	eb8zIg0MZdkyFb8yd/FT8zJA4jPhd7Gbn7yDrDY8tM2RLqj1Ut1fEKte5Rq7lUtXmSn/zSGQtJY
	2Gku4O2lTQ=
X-Received: by 2002:a05:6000:65b:b0:47f:943a:45fa with SMTP id ffacd0b85a97d-481607c0725mr40944539f8f.29.1786977393558;
        Mon, 17 Aug 2026 07:36:33 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-482a5b816f7sm4128002f8f.34.2026.08.17.07.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:36:33 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	andrew+netdev@lunn.ch,
	dlstevens@us.ibm.com,
	amwang@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 0/2] bridge/vxlan: fix reading neigh ha without synchronization
Date: Mon, 17 Aug 2026 17:36:11 +0300
Message-ID: <20260817143613.685769-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Neigh ha address must be read using the seqlock to get a stable snapshot.
Both the bridge and vxlan read it directly and can see partial updates.
I reproduced both issues with running neigh updates and exercising these
paths in parallel and saw partial addresses, e.g. updating between
neigh A: 02:00:00:00:00:00 neigh B: fe:ff:ff:ff:ff:ff was able to observe
02:00:ff:ff:ff:ff and fe:ff:00:00:00:00 in packets. Noticed this initially
in the bridge, then checked vxlan and its arp/neigh_reduce functions have
the same bug, route_shortcircuit is doing the right thing already.

Cheers,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: arp/nd proxy: fix reading neigh ha
  vxlan: fix reading neigh ha

 drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
 net/bridge/br_arp_nd_proxy.c   | 24 ++++++++++++++----------
 2 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.47.3

