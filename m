Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660035;
	b=MIZdKBQIWDMG8DCVu73hxENXjKZlOnng7GKUzjUYTcUS4DGdC4lj01hHcqIxH752m7h9
	 0Rmhc1aPLo7Ub9+Wt/z+Fx2devnJKc9nJ8hswv1WZHaEpyKfsmW4XsMkQ8ga3pejNdB1Y
	 FYLPphwZ/bJVcBl9X+g2+DPXNAW4YNMSg0NBV8OrWt/1Z31wV0xi0c5Vore1l7WmlsVrX
	 3Aq7ZhmQhDEiQxUUYZDrafTlFogRvSf455GeJ3xeThpi8lqUL5iMYuG3SbdKGCvoCmtB8
	 lkF1S754z2nDDf1lwq4nhULoB5K4oULNyu1mG7CYG8HVNlI1XcSAHHlm3igRm//XlQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/tMNXcr5k0x0ZqGSCg5kBGjjTxYYU7yHe7YyZnPL11k=;
	b=duvErApNsMjO6nGblsxbdTGtUUeyaDfKWx7zszwXAn0JtjC4e57jXq5lMoXRNQuzULPK
	 ZIumHW1CksFxQQb75Q/NGo4JArGyo9/SyPvBCe3UlYPI7fEzDdWS04m0Rwe6SyxR5Tfk0
	 21J0UlxjItHOEl62LSezw/afj4mVVbQZm/wN7GlKyY7jpPwwbf1PvJAtzuFnAmP3FQvVU
	 zLL/hmoh3s0OowvGKPbJHl9p2Ly0+cqyz1d8LP1YgpVM/y3ZugfxaNIyI06gyAx1Rh6o9
	 p76kyx870JUeHrzbSiKxVwxPjvTvcuBUXcKaTjzOP1F3YpnesaU8LGkQqg1dJKw/O5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IHm33Q3W;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F0606A31D
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 258F0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IHm33Q3W
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3535a54bed9so2339258eec.1
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660034; x=1793264834; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/tMNXcr5k0x0ZqGSCg5kBGjjTxYYU7yHe7YyZnPL11k=;
        b=IHm33Q3WeEUE1uMmlrW+OYcr5Q7ZTWfozp/ADwnDOtZ7Kxg4LmJGrFunqCGLJKHgiq
         8WcafzDpGnRjXegIvL4K9hJyvynpmY4e/TsYMicOESH3HOin1bfFShg5NMkJIw7Zdwap
         hM9o++oulhdeVSBtp+bnHKD+eATx4lAYjxm6S1JmEgToHc0ghLmFOht5urcKj+V/iL+U
         ZLU4SYyPfxkaaIqapFBUGqm4IApatphEhXw6qiEtxdL2JTSHs4/B6x2p4s5sbydBRPLO
         YaXQRll4Q4AS7z6U3258ooOkpNRUrmF8hcvIITkjDNqdTATlAHzkytJCqG+RP4f41/Hq
         uD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660034; x=1793264834;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/tMNXcr5k0x0ZqGSCg5kBGjjTxYYU7yHe7YyZnPL11k=;
        b=SUG1hJO7B4efBIyDHx2Ile2oiDw3S/6pj1P1vapOML6Kkp66OWGKHww9TEGk/LQlmu
         Yd92OOfCMHN2Jsv0TNzzXaXNvoNCcxCqLIKVxI84H2zx3b0RNeYB1gfQKurBAW7e2owK
         ioGiDO+x4yn1RsCNFcD8/sUpCZB3qE2/Xyxkhk0xJ2wT65dWvvXH8zZMv+kd5Kcz0tqt
         iu04oqxkagLPeXoY5xMph3MryMWyqC1A7IncPSk7RQquMCSVHPx/h5VCalQXU/5gEvyg
         x1ecFFzZs1HTemSpjcXcibSVkMu+bVcBFzyojTnWjO+lIsCutfM+LjY42jt0dA0o94oW
         U88A==
X-Forwarded-Encrypted: i=1; AKwUvBwpiZLq6o/BvzF3Kv9ffVTWPXyaLIsWXaNlXZLZwVbMkaBguBtF5MgQQRNOOahnGNlZcT3dYPw=@lists.linux.dev
X-Gm-Message-State: AFq9FYLJwwpq7DU9+fA+IDgf1tWRqQyiq4n/1ACuRCDuuNvpIC/c9RQQ
	m/G3MENwdoi3hpyHo35RqUsnl5DotlJWAqjG/kR9ZRqpxtv/GM7Bq4PS
X-Gm-Gg: AYBFou0Le+qycYGB6Z1o6u9HxrIWZQXcXE4flCEloacc/bQBHMEVGYBl10kIqXZGKys
	n6auhZ6pFaG0Jj/s+XV/qJyMr3Tu3p9a2NIWCk4MwPS+NCYccka53q0dxpyv8/5uvki4f62BuWh
	GKR9gSvwZT6esCw8H785U6NympZDMCNm0958oFKXVPcoyMCte1D3pVH+M2rwAIFs8ClRywakVTA
	vkFx+8+7tVRx2ogSCdecX08N/I5madJQRrymjhdJtjr95XsROxNx8kmIJCA4UZow1sskXg1VHNJ
	PXX17bbLGN9LXYSxKTKQuXG3k/QUJSUmCG5WYWnwAqBx/SsIjFcvJGa5P0nTAvjon1VlUrLjo3x
	ro/daYTBMXb9R0CjZF/mFRRMMPn7FGeiqnhE4v27kUjRKC1kR8aDPt+aXCOJCVq4Hl3i2x2cS8V
	SthI2FNhMLURgsISXR29rgaAc+cVMzMr8qdTVbZ0J95PxOnC/RWkAAjzhovj9xfHHZ8wcyVWpo9
	Pjfs39aTpYhP1ZOvM4Lis6nZFpo3pYzKdDiVlPaFJc2DaF4mjJisVqHd+SDA0jjcp/EOfGdEa2Q
	JPalrWzxvbP3AOTrgOE=
X-Received: by 2002:a05:7300:8a18:b0:35b:c1d2:eab9 with SMTP id 5a478bee46e88-3674df4ef40mr6319732eec.39.1792660033972;
        Thu, 22 Oct 2026 02:07:13 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm30337818eec.26.2026.10.22.02.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:07:13 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: DSA LAG self-match leaves hwdom zero
Date: Thu, 22 Oct 2026 02:07:06 -0700
Message-Id: <20261022090706.3643840-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

When a DSA LAG member joins a bond that is already present in
br->port_list, nbp_switchdev_hwdom_set() can iterate over the joining
port itself.  The self-match leaves hwdom at the unassigned sentinel 0
while the port is marked offloaded and tx_fwd_offload is enabled.
No busy_hwdoms bit is reserved.

DSA frames may still carry offload_fwd_mark.  If another port also has
hwdom 0, nbp_switchdev_allowed_egress() treats the two ports as the
same hardware domain, so an otherwise valid forwarded frame is
suppressed at bridge egress.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  The exact DSA LAG route ran:

  dsa_port_lag_join
  dsa_port_bridge_join
  switchdev_bridge_port_offload

After the join:

  offload_count=1 hwdom=0 busy_hwdoms=0 tx_fwd_offload=1

With a second port using a different switch parent ID and also left at
hwdom 0:

  unmarked control frame:                 delivered 8/8
  identical frame with offload_fwd_mark=1: delivered 0/8

The result repeated with two independent netdevsim switch IDs.  There
was no KASAN report, oops, or panic; the defect is packet suppression.

The target bridge and DSA core code were unchanged.  The test VM has no
physical DSA driver, so an in-tree dsa_loop build was exposed as an
external module with only port_lag_join/port_lag_leave and
tx_fwd_offload behavior.  A diagnostic hook set the same
offload_fwd_mark bit a hardware switch would set.

hwdom allocation must exclude the joining port, or publication must
occur only after a nonzero domain is reserved.  Candidate BR-031 is a
different error-path leak in the same bridge switchdev code, not a
duplicate of this packet path.

I found no matching self-match allocation fix.  A 2024 generic
offload_fwd_mark/hwdom-0 comparison patch is also absent from the target
source, but that patch does not fix the unassigned-domain state created
here.

The module sources, PoC, and full logs are available on request.

This was found with AI-assisted source analysis and fuzzing; the
packet-drop differential was reproduced in QEMU.

Thanks,
Cheng Yongkang
