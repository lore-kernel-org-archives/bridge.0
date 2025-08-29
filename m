Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946FF1DF256
	for <bridge@lists.linux.dev>; Fri, 29 Aug 2025 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461285; cv=none; b=pwkKO3nNEDqYV1sziJlSli5/aynNX1Ru2jhzkdWokQBrkdl3FSKGc2PBzt3DYoqvli850eMZNjehs4psCCP/AyhlVdv9FzC87OmXWlZ34wSEgWzXFOlQtrvxDR6nOTBmbJWag3T5xscO9ZuBN8YrHS6l0VSIEQpl8i5ZJ9v6VD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461285; c=relaxed/simple;
	bh=bgh1fzFvQFuUXkGTaWOtXdt8WEKPCTaLk/N19SRXgA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zx+xhlKtCny4JZ8pTma08ppq+qJ9JKKZM/dEhwaUMjGNj/amOAwQM9lyhPTj9M32VZa80F/y5qDWe6NFHM4BBS47nrXv+KXEhQYGFk9VyuIMfzS6Ob3AZQsbIri3/kEa+bYlaFRsJDuh4wPK18wVCuwQhu8NCEHsLjPjCelxpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLt/U75r; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLt/U75r"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-327b657924dso1335403a91.0
        for <bridge@lists.linux.dev>; Fri, 29 Aug 2025 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461283; x=1757066083; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v80YyVMFDbV3jWpWkWNkuwYjTqzPpq5yZ0PoHTDS4og=;
        b=eLt/U75rcOXdInn1D7VL4M7dUWYOI3yDnqGLpuLoWaqPyCkB4KbT0f8kkrSfXJrZqi
         5NkNeepoSVIldJSepmIrMym1f3ffbR1mQgDZwfha5E9zpyiFYlncPA6vO4aqta5MrbYX
         DWmPmK1nFHsAGXNN7SeaFTmxbfK2sFXj1DvI2KGRHD1AZReWtkITq2o5FUH17kAqSG12
         Vx3pzN5Cpou9VMzFdzTsozqiCEYCeTHDc0bra17/ycqS0+Uxs7kus9/awQvfecbh1PUD
         VH0fjxRH3+dVcRl4zPhRMVYkeuVVPFZJoplsxz21L24C1AMOD8qyjj5qHZ1Z8SgQekiG
         cbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461283; x=1757066083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v80YyVMFDbV3jWpWkWNkuwYjTqzPpq5yZ0PoHTDS4og=;
        b=tCS3In9woxC1nu+6mLI1YqhyVgdpPR4sp2ou2yVUND/I8gGLZUf5gHL5BtiJIn8pRo
         SYSvRYrEk6O86ZV5woXAOsJ2enrqkS19c2YN8q0ZO3H5FSlYcJfiZc2nGtSmguFAgjnJ
         l4wo1XkF86pAyFDMDhBR/dcPsxgWNc08LTou2eeKU9mJ5ax/6CKPvHea+TZ6ruNCGchp
         1QvrkgjMpSixN5yYGXwQK0fLTCuuM770aX8QbQ0TOM3gxy66+nx24/ZOE6FKqQwWWAPm
         e7NNUSfsq0lPsL5FZ0kM6Df1PmgYUl/2mFQux/c7pP99d3s1CqYmb39CBr5+Lh3Ws3oo
         dADw==
X-Forwarded-Encrypted: i=1; AJvYcCX9Zr6fKEh9m/mAtptQsekE0LlNhUk4n446rDs0jgDLuB9pYQ6R75LvQ/PhhrKsO+ozfTWe4I0=@lists.linux.dev
X-Gm-Message-State: AOJu0YyHwSbyp7YX+MThLw/wge99SlIq7NLh3EIgMuUdf2wpZ8XUbMeS
	jIYS79UL95VSiZRBLsLKBGdxtjqg/UGbYiTA+KQ8aDL8uNZC8p+l5GP+
X-Gm-Gg: ASbGnculCv3Ld7hqdz0sf3lcVQHOcfV1cu10IebgwpLxxjqAvCJx5MouiPJlDI+tOAU
	hkvFDUX6aYey20DhzrkUKHCUJ2REM1rZm1raKvp+fnXQ0KPLzBlE+wuo8dUBjH4lenDWYOx9fs8
	fGOUVAMeVY/XDG9B8EhmdGpHY5L7MBfpKdcxC/zEEp2JYsdoC1su1lWvjKbvS5LvnvN6+Dommwg
	WuvcKGu04enS4p0IA89KeYH3JMzv1D7h/mQk39S5nRE0eX4aX/bB3miaO+2PoAr0lC/kn+NA9kb
	+/43QoyHXSyewGvUMMv7X3hIVJNjW2qHUaLw4BfAutVl+g6UK3dIXh/in6bZKNMWBXjAv/UOXCD
	4Woc1PMxwkCvNLjSF2cVjnO191es3CJsV+8HiIUfotCcoSI/9lvVS
X-Google-Smtp-Source: AGHT+IG76pnCoDXhKAMPqyxKq/qZ6RUOF7vchrK3Wz4WO1MA0dj3LEo47BFWemGqy9Y/5U94MnUqmg==
X-Received: by 2002:a17:90b:4ccd:b0:327:f21b:7734 with SMTP id 98e67ed59e1d1-327f21b794fmr1329447a91.21.1756461282723;
        Fri, 29 Aug 2025 02:54:42 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd347db1fsm1751528a12.47.2025.08.29.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:54:42 -0700 (PDT)
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
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/5] net: common feature compute for upper interface
Date: Fri, 29 Aug 2025 09:54:25 +0000
Message-ID: <20250829095430.443891-1-liuhangbin@gmail.com>
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

Hangbin Liu (5):
  net: add a common function to compute features from lowers devices
  bonding: use common function to compute the features
  team: use common function to compute the features
  net: bridge: use common function to compute the features
  selftests/net: add offload checking test for virtual interface

 drivers/net/bonding/bond_main.c             |  99 +----------
 drivers/net/team/team_core.c                |  73 +-------
 include/linux/netdevice.h                   |  19 +++
 net/bridge/br_if.c                          |  22 +--
 net/core/dev.c                              |  79 +++++++++
 tools/testing/selftests/net/config          |   2 +
 tools/testing/selftests/net/vdev_offload.sh | 174 ++++++++++++++++++++
 7 files changed, 285 insertions(+), 183 deletions(-)
 create mode 100755 tools/testing/selftests/net/vdev_offload.sh

-- 
2.50.1

