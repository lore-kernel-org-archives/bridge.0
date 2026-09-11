Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E10A3DCD90
	for <bridge@lists.linux.dev>; Fri, 11 Sep 2026 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121235; cv=none; b=SSb8QroMOHxQqaXI/X5aCwHngW+3fEEihKB9fsHAyWhwwtFjoU2nibkw1CkRVFWgqtq5JIm81NtNFvkQysE5BEJsccA7vDD2KY9siRWWYy34PNGD/fte1JtOJxlOcfFFPueLIlvfMZy3xzLOnMfVUgfjHtffFAEj9GbHfAYc6Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121235; c=relaxed/simple;
	bh=9Du5D+9bTvjoHkuLEaSKOMC8T6i+9gzrDjZZ2+4P0L4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qk25zJmKjBgQSDNXXBIUs7ENtLwWusoSDmzmAcWpuGR7mT0p5Ss+IU5AfSnFnBE5de0xY7glDW3MYw19sbNRyuDujj6GUTAj9+xz9vYLXnkntdNTSqzzhXqBPAbPMm3k+hnsQbHK2JgR5JfcH52cjp7wj/6Opj0alAP2vBUdZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JP6IMJEd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JP6IMJEd"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4843e9c5960so655850f8f.0
        for <bridge@lists.linux.dev>; Fri, 11 Sep 2026 03:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789121229; x=1789726029; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uMDFH7uEtER5Syx5bBRkse+NVD7Crdwd3os5D/thx0U=;
        b=JP6IMJEdNYdcbAw307cs1/BsY0S6a+GOlu+e4prM63vUo6lDanOj7rhzGbvkbxfXOz
         vOLxFsngLPV0fwquB52SCQ3rnf/uITYaQzg3teYxliIN2Be1KWcl4M39mhZifuxkEEBx
         8gKLDlRmh2lYXOdTUbnqf+Ggpllap+mPfL2C5O8YYuhGs/RsGvEcOuPda49bzJYz+cKs
         x9d0tlWHFRD34KvKEiNJkn1EHe9Qj+aUKjME5/XyiwtjlrrGwwaAnwAP6xlN8+QxHifq
         15FCnLg7J6kjfAStVLKaN1s5C4QCZ5oviJeGP2+uO6N5cbdnNGIByUhq73mVOxvAT4HM
         V/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789121229; x=1789726029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMDFH7uEtER5Syx5bBRkse+NVD7Crdwd3os5D/thx0U=;
        b=B7Psojk0ZkeDu5zk14ZdTR+0zcNg2/qLGJXAVjCkNAq7cqQYjXn6LQ0B1oCGVssca0
         ZmVVq5roZFxrwANXQBEOogIBq1/iF6S27lESLX+npwAOXzQBZ+vZjxgS0qL+xq38Pu9J
         19Z50wkUqpp457RWmoTBN4g7vwXVAjZIXAEzb/ICkD6HXMDxjHdYO4zdaYT5BMQavrQR
         ViEFO2agjMKKOQ+IaX6ZAHjjQxfkaK+FivyJY48Op31yHkuEPX+lRHVMWdu96T+OSZSl
         oY2S/NxfIYIcWq87wqNW7DC4p689mavWVNDw9t1fW721F+7lvZ7IEchjNtK5xMKc7XL0
         GUHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZm8ZHnCQXlHD+xiFrLb0Crds+/s5drNL3nlaQ1/4Cg8ycDxmQf4woqqJ36KdaEAVDP1++IQw=@lists.linux.dev
X-Gm-Message-State: AFuF++mTgMGE2xSywY9TYZ+bEzQMpdPJjEQuS45oNkekA5TRZ5RlTjox
	P/o217bGfkxwOfndkjSugZ6v71X+m0RVocOqapxNflIlGDVgVkef2wHuPOeYfBkK8sk=
X-Gm-Gg: AYBFou3rwf9VwBSv+AGgSAP1metk8qf9Ltm2bRskBnFy7XauFQms6tBSLqwZaLSMzPP
	tuFtymd7sD4vns4TmOIGs3m+ugK5DHH2eUr+T6gpxqOKMiuDdB7UH4dahVYqWD5Rm8AkGza5108
	UOPNUGU6mKFKIq8Xq3uTxuxqAcxutNvFYzwhR3KcgAiZvAfI4r09sMChka1Om/5BsT5R9PwLRCI
	d3xcaGNdd/mc/4N1fyMdjGJJQXb9cTlq8eIYrIGJcmpfeYkpOHWj4ySoqgLNgugHXerKlYwghdM
	3aiJEQUVXkf45MiOVljdsOhfkrGM+Tmt0k3poDtiIDRibHMNmmUkmDqY4r5yb+iEBHCuCC59iAe
	yzVHW1vRTDxa88utxLfrN+6eWc2wv6a3arWcdEcu4afyucdiwCt+pZCPkLYUfaI1qGRCt9eVv9Q
	l4jpdk6xYKnVWApBuoeWyZaWWQkdfgC5ycyoGXbeAFugofynTcQZzVWMyfRhzTx6JlCpCFxkZNk
	NB6y5iuYt2WxTmQq4vgBbJVdTfkntaN
X-Received: by 2002:a05:600c:1c29:b0:49d:15f8:2bdb with SMTP id 5b1f17b1804b1-49e619806cemr37745745e9.7.1789121229167;
        Fri, 11 Sep 2026 03:07:09 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49e60ac411asm62868685e9.8.2026.09.11.03.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:07:08 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	petrm@mellanox.com,
	vladimir.oltean@nxp.com,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 0/2] net: bridge: vlan: fix memory leak & null pointer deref
Date: Fri, 11 Sep 2026 13:06:43 +0300
Message-ID: <20260911100645.1360386-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
These are two issues I found while reworking the bridge vlan fast-path.
I need to fix them before I can post my larger patch-sets because they
will make these bugs more visible and easy to trigger.

Patch 01 fixes memory leaks on the vlan flush path (teardown). These have
existed since I converted the VLAN code to use rhashtables, but are hard
to hit because they require __vlan_vid_del or switch dev error to hit.
It is ok to abort vlan deletion when removing a single vlan, but we must
free their resources on teardown otherwise they're left dangling.

Patch 02 fixes a NULL pointer deref that is a consequence of patch 01's
bug. If the vlan delete fails when removing a bridge device vlan, the
error printing will try to dereference the port which is NULL.

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: vlan: fix leaks on switchdev deletion errors
  net: bridge: vlan: avoid NULL dereference on flush errors

 net/bridge/br_vlan.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

-- 
2.47.3

