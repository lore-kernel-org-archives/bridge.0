Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6322E3373
	for <bridge@lists.linux.dev>; Tue,  4 Nov 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257803; cv=none; b=ZJ3Hbw5Ism5pRtnT79k9/Ga4NhmTYlUmmHm7E32WsqVrE+zzPJGQU6YSHXHF3g7jCZG2701w6aUc7xhbnwwI+UnyJ9mnnk6Rf31kUdfsbGohTwhJBhOBa864BeUHhc/0G9/PHUSjp0B8t28/NCLw668wKtkIKHd1H1XI2A8eb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257803; c=relaxed/simple;
	bh=r/A1fEgxd7CLHCCecKoxs1s58LlXAFQLXZW7PU/nfNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpfxGSr/yB2TkOLBMVyFghsEWDxbbhsOIK4kmR8elRa8TvH8Hg+QIJ+mo3SU+XBn8FLtjQdtjpWlzbJGOHIC8oxiIrX+/EYlYcooAkL1UlqwgqGyNbEcdQ9Rz7xjc3X9RAt7WurWnyloWzGLtsgZbPf/EMpEj6g6w5pT9ToZlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=iqZIjFS9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="iqZIjFS9"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b725ead5800so11305266b.1
        for <bridge@lists.linux.dev>; Tue, 04 Nov 2025 04:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762257798; x=1762862598; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+nlqde12JvrajErEGkMt8OTpsJbP6JIY2MTLZXG730=;
        b=iqZIjFS9+OukxE8SY57imjAMmdO3PPEgrQoYGdcn35euPos6y1fULbMeoJ9VOkqL2z
         SE+s7xbQU4mofRML7f3A7hm2bhaDO2d5OEfqz6aGcFY9iYEJcMiOkW78PPCW1uzmRR/O
         Q3jR2ePP1RRrPBAGl1VOruuyhRFcmoJSNLbiE6pOjG+hhQLor42Vaov//hawXUQJRe+Q
         DD2T3qPjISoDRbCYVgqmlJfBva2nN/6bR5fE7cjuOHvzB+mEnlVzSy3j6+YZjNS/ygpW
         kCLy/g5a7pQUQ0o5PdNtvVi5ByjZDjblF30yYFGH1X5iUzhuf/6y6hJFJLnekxYQLJKC
         0pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257798; x=1762862598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+nlqde12JvrajErEGkMt8OTpsJbP6JIY2MTLZXG730=;
        b=plH30ud/X/1g19KwRcJAxmAjtCF3harr/A7RMyny+l+sIo0+rJGpISbnIe+TjVqBLk
         2xvmxCCMn3vL9kGc7MDYesUdLjAEEks26+rwOZsl8aX9rvrvWusL+1ogt44foPMZfUpK
         X62JNA7QSPifLBICa25EZV6QKuM04ziumV534RoFH0HxfAQAYLfTrnND1U7ULj5HmOpp
         0KehN8UW1D9RUOiePdowzBcTPNrBJ4XCb41buzlk7T2CyppyDYw/8zq24a9qwqQ7C+PZ
         hfQxr3JUh9dUr/pJlR8xpxnwuxSpL2ZsAHswhz4fnWitY7natxzeKO4RblWG3st6uySd
         he6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6eYO36+wQtc4a92ZdxSj1H0WtUiHHrpNKJFAnvZ6ZK8oTud1tIPeRIYhDK9j2KvajwlfAlBw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxiOLYcMLNob7YGamc3YAHuJ9D0WdukqGnwBCxsEnK9NqjjeniQ
	3kN5nPXFjXE9lYu6Egl55h0Ne86PsKyZao+gLcWh251ehxY/F0U1vAvIWYdyWCHI528=
X-Gm-Gg: ASbGncuXmj7c2R5kGFhI/Cb3OWB7lrUhu/3KYnQJIWvPvw8wt2agCaQ+EW7vh9oRn9+
	HBg2kwf7dy4JrPgw9w34QAhsggSxjZaQi05yxGbhXfQ7MzZGWFTPy08Er1InUx5ZU37CXLpXTcV
	CxUvtK17YWpfDFcpbZIj7G3NsRR/OtD9bYvPKt+uyWeaV7vPUnV0fHJ+9moCXBtltyADDR23Bp4
	0xjY1dSJHTHVs/u1YeVTG0CbxapGF1N2M4f/r24VRyq8awqI25+ccqrGQETem7uHEYMB136+GLY
	ClMwdFlNqLPOztJm/14zp/08l/OWI2iMZ11IRcPz6EDc9DViiVHpJnJEx7oMCiWmBrhL+clGJLY
	gCmuRHy3RsWikrSSo8FUqp7pbZDHPR90Bo5WJpA1EewpVHRJTZCmHJLiHPa04d20fhL8nEHr1Cx
	JW02VVsbqF+6nJo+uFu5j4wn6VJWqqJR8cGA==
X-Google-Smtp-Source: AGHT+IF8WOhdpwiTQR+BceMSuOGIT8IEumRExm7hI7+Yf6DfRqnzF9lS4wTtkLhrejzbcQOrOYF63A==
X-Received: by 2002:a17:907:1c93:b0:b6d:608c:838b with SMTP id a640c23a62f3a-b707063e284mr1699931866b.45.1762257797028;
        Tue, 04 Nov 2025 04:03:17 -0800 (PST)
Received: from debil.nvidia.com (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a3082sm195032166b.11.2025.11.04.04.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:03:16 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	davem@davemloft.net,
	bridge@lists.linux.dev,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 0/2] net: bridge: fix use-after-free due to MST port state bypass
Date: Tue,  4 Nov 2025 14:03:11 +0200
Message-ID: <20251104120313.1306566-1-razor@blackwall.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Patch 01 fixes a race condition that exists between expired fdb deletion
and port deletion when MST is enabled. Learning can happen after the
port's state has been changed to disabled which could lead to that
port's memory being used after it's been freed. The issue was reported
by syzbot, more information in patch 01. Patch 02 adds a selftest to
make sure port state bypass doesn't happen when we have VLAN filtering
disabled, regardless of MST state.

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: fix use-after-free due to MST port state bypass
  selftests: forwarding: bridge: add a state bypass with disabled VLAN
    filtering test

 net/bridge/br_mst.c                           | 18 +++++++---
 net/bridge/br_private.h                       |  5 +++
 net/bridge/br_vlan.c                          |  1 +
 .../net/forwarding/bridge_vlan_unaware.sh     | 35 ++++++++++++++++++-
 4 files changed, 53 insertions(+), 6 deletions(-)

-- 
2.51.0

