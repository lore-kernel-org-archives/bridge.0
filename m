Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39732EAB7E
	for <bridge@lists.linux.dev>; Fri, 17 Oct 2025 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672529; cv=none; b=uNidrlyPIXBcTWr2hSzEEj6Mufrsm1bWNLwyJAuB3Exr9mYG/rvNz2tSWvOyU0Wl7/rr20hL709Gzz8EeQNpDQ+GM0eRUyLu6XOQ6NRgJJWjxS8CsZ7kSprMyf5bb/iXUMr336I9SV6Ky3FJZs8e2sFbMhwbqIgWPJThHSkz0jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672529; c=relaxed/simple;
	bh=nSAbBo6hmHwIzWG43Awnhvd+dCEILV9ltGpKqgnBzoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYWgrnGi73IXCu7Zk/LbPxUWEi7WZsLEW7DKuDp5YyrSbJTe6Kgt5I9QpshVtBj3Jjxbh1ObXytOjVTFMfkuaB00rx6cC5wSNEQwyyzxS4x7IPAWyeahKnLucKaigSY/ek4/avuA7N0xMqQKcpwOeWJM7PMf3uUMN86B/5uQiYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5T2WJxi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5T2WJxi"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2698d47e776so10872405ad.1
        for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 20:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760672527; x=1761277327; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fq128VBkLabfOGmarayrZTkCSwx/rnhK1ahk6nrKeko=;
        b=O5T2WJxigTMzIt0FaxMunZwc9VOEVnVUhR10VMA3wzWd/FVqHDLzgEDsVPMAx/slj3
         xNvguEvcezbj6Bmo3ZCNOPDBjpTZvmbTrpW4B0IoeatFMUEbxXfmJ9uHzxIT43LPaGkG
         G5ewVJ5gfRPfCf1uxBv4OGhJtxTJkuEmmWzgh7+0tSZROX6XAJO+jA1z89BIbiuBFVYF
         7EQ5XYYu+jZkeTx2AL9UUJx/yyjtaWkwTqErlXin3VuUhnX94GEUBF+ga+0uQ19U9F8L
         Jji3hEwvw0TjSUFhREug/df2nLc+m+ltsoWKR/0b79FIqh1TJW6cMv3Udmv8LvYkRLcT
         dr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760672527; x=1761277327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fq128VBkLabfOGmarayrZTkCSwx/rnhK1ahk6nrKeko=;
        b=ugfUemi3rirAUsW762B9S9mLSa8CN6F1AY2o37lK3LnL0Pm7TCmL1mLpcK55Mg7uP3
         rtmsfUOUxgj2lT8QBnTuNvR/oXrsprkaV3AnnIufNalVRaYHPR11bVweA4uB4IAA4NxA
         r+sTFsfz8BRTqPEUGkuxH5/kQJOCRHBmylw7Np2mXFrfIgaQfUFBB/xIO0cFtzp/en9t
         fsm+1W5Rp5lhVSmZBhKJAVxYuUP1eZAJTpjoJ/qIQsCczeIu46cpd9j7vx1p8qqIy8Co
         zRymXTVbrLcUGKbXxv4N0zgNHGmOBsCw/rFlw0eEuf/4JYxUYWpO07RdwiB8/BGRu9g+
         67/w==
X-Forwarded-Encrypted: i=1; AJvYcCWCUIMvO4ybK0Ua/xTym3sxpWbaVHNSQDPW3bLBp4em0USDcZk6Fvc9zYbjY0wz4sfhtNBWUBM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxtEA0RnoQRgZbJHV8Gk6RCXNB8qRs/3KfkMbukoLcQyP4UCupo
	nuMNfhFk8upBSJoaGx9I4sIEm7EKqp2ZxHbolEU3X4TYpMyocwIIZc+7
X-Gm-Gg: ASbGnctOI7sQdyKHJ2GVNBhgTBBWw0WiMwh4IMeJVo02Hxuc7oK8TEywxpvyuCCRSCB
	CfY+pa3B4cOk7kOE6ooHmVMaldnBvwTciI8sbyguPJbWqDEBk4Pu2ts7FCsnHHmBU7aJyZEbHVX
	KBmTlx6Apz7jybHXB4jdqAwU90XjNymx08SetG9YpgAW40tqAqo0LQr1KbIzEePC3ndiRGNxFnJ
	AsmtVT4nzzuX5Hw/rubp5Nvr7pmvO2Onsnl+KImVYwsWqOYmT/tcfA0R7LhejyxWE35Zh2Tjiwd
	V90EABgskKsOr2kVNI1WHhGqWQc7MeSnkAMk7IBCxeth1mD/nrG1iUmLv2nD65URqrMOm+rpk5w
	VclwSDCllAiz29WcQCcswPkwCqUkhjHS89j3MchODeektg1Wdk4OvJtj9f6ELlhP3F4RaESP7lJ
	wLnUcy1xJL1D5lyCM=
X-Google-Smtp-Source: AGHT+IEFDBuvqFtMO0ZbsNIV5j5E3bGqWNZuk8b5nqzr523R1CYo8BkrMi08LdYVPMbxUUEHQjkCWw==
X-Received: by 2002:a17:902:e806:b0:290:5601:9d56 with SMTP id d9443c01a7336-290cb27af33mr27618355ad.46.1760672526629;
        Thu, 16 Oct 2025 20:42:06 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab4715sm46695165ad.93.2025.10.16.20.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:42:06 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv6 net-next 0/4] net: common feature compute for upper interface
Date: Fri, 17 Oct 2025 03:41:51 +0000
Message-ID: <20251017034155.61990-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some high-level virtual drivers need to compute features from their
lower devices, but each currently has its own implementation and may
miss some feature computations. This patch set introduces a common function
to compute features for such devices.

Currently, bonding, team, and bridge have been updated to use the new
helper.

v6:
  * no update, only rename UPPER_DEV_* to MASTER_UPPER_DEV_* (Jiri Pirko)

v5:
  * rename VIRTUAL_DEV_* to UPPER_DEV_* (Jiri Pirko)
  * use IS_ENABLED() instead of ifdef (Simon Horman)
  * init max_headroom/tailroom (Simon Horman)
  * link: https://lore.kernel.org/netdev/20251016033828.59324-1-liuhangbin@gmail.com

v4:
  * update needed_{headroom, tailroom} in the common helper (Ido Schimmel)
  * remove unneeded err in team (Stanislav Fomichev)
  * remove selftest as `ethtool -k` does not test the dev->*_features. We
    can add back the selftest when there is a good way to test. (Sabrina Dubroca)
  * link: https://lore.kernel.org/netdev/20251014080217.47988-1-liuhangbin@gmail.com

v3:
  a) fix hw_enc_features assign order (Sabrina Dubroca)
  b) set virtual dev feature definition in netdev_features.h (Jakub Kicinski)
  c) remove unneeded err in team_del_slave (Stanislav Fomichev)
  d) remove NETIF_F_HW_ESP test as it needs to be test with GSO pkts (Sabrina Dubroca)

v2:
  a) remove hard_header_len setting. I will set needed_headroom for bond/team
     in a separate patch as bridge has it's own ways. (Ido Schimmel)
  b) Add test file to Makefile, set RET=0 to a proper location. (Ido Schimmel)

Hangbin Liu (4):
  net: add a common function to compute features for upper devices
  bonding: use common function to compute the features
  team: use common function to compute the features
  net: bridge: use common function to compute the features

 drivers/net/bonding/bond_main.c | 99 ++-------------------------------
 drivers/net/team/team_core.c    | 83 ++-------------------------
 include/linux/netdev_features.h | 18 ++++++
 include/linux/netdevice.h       |  1 +
 net/bridge/br_if.c              | 22 +-------
 net/core/dev.c                  | 88 +++++++++++++++++++++++++++++
 6 files changed, 120 insertions(+), 191 deletions(-)

-- 
2.50.1

