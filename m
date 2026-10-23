Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733183;
	b=E3iXC4rUO6R5q2PU/Zv/u95FKW4IYiMCKFt65TOC2/TWjym+C0cj0KbBVqhkC2xld/Re
	 9kP38Eb/ydUkaMxD+dUMrZWbBuaO2fWWZTvDqztjAGABXSz2ScPjjiw2k6+PpxOu+bQ8p
	 99R6ABDisPw70oYNSS+si+FXi9H0iETN/9kEeOXsJ5J+pg998ue22SqxxYeIftWtsKiij
	 Z24RLKM6CCJDv15JYWlhZt79Xk1DvnuUF/7jPID5mMsgqSGSW/Twn7oCzOxoprRCBagpk
	 XiTVTjIObaNrtWHiGIp8xyYT8bu15LRt3jbndR3+cXFx0AuHrDxJ4pQmJO73Q5Gafiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pZB4THbsnV6kIGtfvTG9sDlt1qcRS7qvS8+h0JwzfVI=;
	b=lfnxVSYvsuDiNV60HpJy5hB+FfyRxSsH0mRn8dcU1qE28TCW6hoPd1pVcizh+/FyeCni
	 Z5cupoqI0WziZv8kLY8BxIQydks8aoq8RImI66uTgY7s4VFg9FLfgy6PjoD5CxHUAMrJt
	 XUfMMRZ0rHN8gJXVUyV7R2aCsEIZY9UkKM6McgS14vNhQyyrTCkpcD8oDFHSaLqnmPPQ2
	 y14WGJcY1FNxTTPkex7jFfPTN77xE+5fpTni38n/eDPXyBC6Wcj2pM4JmAIjiqejpxZao
	 WCHtHHAZirNCMV4mFFnDHM3+SbjUsDnuRCpefVLjKMcLz8LN7JE8/gOvR1Bspa/adAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=eDVQUgI7;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29076606A31B
	for <bridge@lists.linux.dev>; Fri, 23 Oct 2026 05:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29076606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=eDVQUgI7
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-535f9de49fcso2844021cf.0
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 22:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792733182; x=1793337982; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pZB4THbsnV6kIGtfvTG9sDlt1qcRS7qvS8+h0JwzfVI=;
        b=eDVQUgI7HkQbWo2E9w5hiByVvok3GClrsy8pOqShJVbL2hPcpIGAqgv9IWCTzjC0Ba
         sll7aOTYLDPanj/Pzb053dtfwrBXgHGCyALAVFDaj9yNjEJq6sXiGUsxKEiz9gbCWz8c
         TTkFoQ5vGurcNHYluVp6PTfyuy+bBqSIW94R2P7q3r8YVPKtDdjYPgBUHXzh7UjNvUhy
         z1HpLAZr13pPFstwaWoQbBJuw2gDDjTTiJgJqIIa6S0cuDBNRl0pil3cfHOam8gi21pU
         9eaPqwH3gDYcfq/YbbX714rxc4nXzNOLKBLbivBfHwOrAWBz8+BxJ6zi1haH+nF5lnOE
         sDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792733182; x=1793337982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pZB4THbsnV6kIGtfvTG9sDlt1qcRS7qvS8+h0JwzfVI=;
        b=2gADwysAHqNxNgSLWyMfP08CZwxX4kQvWvXisaGHhGAWfgwNU0p7G4OLUbDclYmX+P
         gWYvVUy1stVR1yTlzxKmLbSCbx0XPxE2iuy7Toi22SllEWibZM5nTtauahoSmEOQeIF3
         vnCCGmJxUUoqBT9d3zNS/y86Sgy7ZsWg6jLDLIRbCVxbI8rO/c+kndFUlS39oEVWzA6O
         oltoXGTzOdcLGg7KgArBnefV3Tyocg4TjOIWzmTn3OXbDehpURG0dq65sozzHpCncq+r
         AmRj6wINtULwkZXiIhLSROaoQ+Mpnu244Wohs7e7uxh5Kc7IXHPdvb/xAsqpIsO8ZAyw
         0mbw==
X-Forwarded-Encrypted: i=1; AKwUvBxk5WKe1G7GED+CB2FSCg7/P5qb1+CVwn5PBgpV7+QmtnKVF4EST3ZU/DfGL7T4SRwxjKnokVA=@lists.linux.dev
X-Gm-Message-State: AFq9FYIZFhXantvfFwdAFfdteQmVXkARwgf952e0VC5GT99Cm6uQlYRz
	kfzviPstvzPfSGlUEJqLxH9B+cv9WJRn33eYtHPHkWH97+FvqHO1OozhRe2AGoAtCPf0
X-Gm-Gg: AYBFou1WsGDpXyPkvhz3QtdJDp25RGyrxG6se7b6LiU+K5HgMpj5oPsfV0ZMjcWYGKO
	1v1iQ2rm6HEkeu45RRNVI5lnDrl6jgGTiEpUF7IG0Za0ihXvITk8Hm3VfgtVQUkGoFRYCVJ3kz1
	4kRj+c+VemKDg5dlhurXkSnUDvxZ/9Qq13NlzOZxLUR1vDN1ctX3yAUQQfM0YjQ+kby93kVmLXl
	J9JBPzWvwjYbWQBr5Mb+794A9yJF4CFVEtl4isXW1pC54eGzrD+RJgmnjzEcaQkPFUM3X19zxEw
	9g7yPyLUG2yRjUOhoi9cB0UoYJ7ZWKpvgZvAq9F6UDESLipmQf1A8SYU3zzL1xwSEXUEUSZ44uh
	axbzQ/gw+TvDtc2uxFnzYAAFKXCAui2e8Rd2YcbWUerj66cyS5z67ZuxN94dFA+BqpFYA1Ekc9g
	jqOrUK2SNAcQyahBDstGLLyojjEVzHcVBaGLrfOxEBKf1VRhjEz9ahu6qPezwvnCYmIsqBdwEm0
	RINKk7CUU/oeSX4g/nWOnYpDI0kscSM6aZCoFg+dZePyLq8S7pTdpTZOOY+b+f8H9ZZM3mMaA3Z
	cVlb/cEfjw5Kc/0p
X-Received: by 2002:a05:622a:344:b0:532:9b14:96c5 with SMTP id d75a77b69052e-536c26d6904mr13467591cf.60.1792733182073;
        Thu, 22 Oct 2026 22:26:22 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536c17f4b5csm9255441cf.14.2026.10.22.22.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:26:21 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH nf 1/1] netfilter: ebtables: validate compat nentries
Date: Fri, 23 Oct 2026 13:26:08 +0800
Message-ID: <280a41badb424f8dc5fa22d03d6abf82025d539e.1792733039.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792733039.git.zhilinz@nebusec.ai>
References: <cover.1792733039.git.zhilinz@nebusec.ai>
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

compat_do_replace() allocates per-CPU counters from the compat header's
nentries before it parses the entries blob. A malformed request can claim
millions of rules while supplying only a single empty chain, causing a
large vmalloc() before the request is rejected by later validation.

Each rule occupies at least sizeof(struct ebt_entry) bytes in the input
blob. Reject a rule count that cannot fit in entries_size before the
compat path allocates counters.

Fixes: 81e675c227ec ("netfilter: ebtables: add CONFIG_COMPAT support")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/bridge/netfilter/ebtables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 0bf541936f601..e24b2c0698892 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2269,6 +2269,8 @@ static int compat_copy_ebt_replace_from_user(struct ebt_replace *repl,
 
 	if (tmp.entries_size == 0)
 		return -EINVAL;
+	if (tmp.nentries > tmp.entries_size / sizeof(struct ebt_entry))
+		return -EINVAL;
 
 	if (tmp.nentries >= MAX_EBT_ENTRIES)
 		return -ENOMEM;
-- 
2.55.0

