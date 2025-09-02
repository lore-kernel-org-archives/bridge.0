Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6382E03FD
	for <bridge@lists.linux.dev>; Tue,  2 Sep 2025 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797987; cv=none; b=TwE936pgt3ibTxf/NrqYJV+Fq4v1GPGAWDsqaqUH393ghTJtfo6Z0SE6te7U2mR++Nau5fFMo70i/hjJ9Vrl0wbkJrQ+VQGxAeGjpZyVo3n9VnUO0aHj6AqiLYAzW5AAvztz1HddDMQ0CXYP4SVha0sVdOPbNiQbvUHOQNt2Cnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797987; c=relaxed/simple;
	bh=2G4EzO9fxCGzAIacSHn8bEFZC6l+QFGRKXVPv/xSaZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/pa005sToW8jPSKY3F8uXLMmug6KBEebBmUgWKjqC4yDdoi3ZYxXjxYYyZSU8AD+QJGxx/jJbpo2B3CUiNthzskZUEWlCq101v/L5lPMFTxcSl7BVdL21mrAfyRSZ72EnhbTKrZbtVLcJAL6nXr89AVAn5vA3wqs6ME2pD/syk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=av++gG34; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="av++gG34"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-329b760080fso1130169a91.1
        for <bridge@lists.linux.dev>; Tue, 02 Sep 2025 00:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756797985; x=1757402785; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fdkwcPLZcouh+xTI91hgt1W1VAbAdyW6Tw3FCKoqM1Q=;
        b=av++gG340XxHb6rcAbGOssJ+mpePnbXXZIX+wemzrfa+J8NHFPGu9uZXA1Q2Cytjhv
         RBtnqzauQxkexzUIKeTtJvj39l2D/hoIxCbTnAI7pUaosqx8Jhr1xNblEPX1PKNGv/G8
         BhBjqXf0eETbED5UQat9M6uAaz2zJEQxFk06XbXrSoLPxP0p9sXHTu6kGNGxoE140fB4
         JkWAFNFNsFBpC4JBc1TV63xqAU7l+pq/TsKhC2pqD0Vf2j5gpFU3IJhAmkA5zOaWsgMs
         fWtG4ibGupZq9WXbisTvo7wZ8DdBtgSkgwixYv0UEalZpUGtlgGiJ35s/fxOkMkt3EoV
         5oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797985; x=1757402785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdkwcPLZcouh+xTI91hgt1W1VAbAdyW6Tw3FCKoqM1Q=;
        b=O3TNbLVISOdshuIBXykvSFrdAiL2ZqfON5SsbkdZ1YqiUZ+QuLtjcfaq+NSacZUojK
         q/zU0Uqit5bCdPJmxCGqWb05kB5Tab962qt4vmz6Td0pramf8JvIu6nITG2XjDGElEWh
         IjAzLMzcumrY/YMebT3O16d0burhAhbbMFbcKrSnDQ+gyBftOTNJdfjn4tBL0KX774PR
         XK2mH2jtlMqngGx+wOgzIzDfWAN7nD5xz33ARhVeZCZ2XnJ3/y3OD9zw4YmTmXjkcSsD
         rAeWJlZzmIjLv9t40ptlKkaljgoWoKt2WQhpuN2cAlRu230RPuhQDy1nGAZ0NGEx4C2K
         oGPA==
X-Forwarded-Encrypted: i=1; AJvYcCUWpPyJZw8GYQipPlbph4ser7GOQFeyBM7LX+VAi6MXA4jRlDcsAY0RzEFKJbjO4MxWieoXMuQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/E940/L9HpS2g5fJ8v34Y7YtPxezPcbabQQS5Xmu8W2h1QgoA
	xi9CwBwk6/WUqecBfKb/sdrEfKP0m1cISKjtPFaWvTEIV+ERK1ZPsynV
X-Gm-Gg: ASbGncsUCfSzZWjRgHhyJaoxyCFeyM3YO6cHAgV5zJhd8tJApyxve5/E0/O+jXLbpp+
	AN+zTOKy+D1fNpkfc9slLSzC8ZIoz9Iqp41f8udQZLQ1tGsXR7xCEvi22zZBFakml+5wodg5uNp
	fqo8Mu69owXTsI6L4f6c5bbNm2qDveVcRCABVHpllwHg9By0a2ZKxkqvRoFX1ddMTW10j+tFtp8
	cKrVNsanXfe8V/Nd+jlQ4HSVUR9mHwy/kYHchfdJerp6HBiCR5FgjinwgwKUmVCuk5JhdQhMiAT
	72miXKi8Lr0ZuI76Fslg0UKn4rDhq144Y240P6NKJKaxkWFwz1KOvGeCWM52ENOLBR7iFDWI87x
	zkZy+dDjIezossxg9zajRv7pOY9dnbLXzE3vR2xfaPUqOWQn5lgty
X-Google-Smtp-Source: AGHT+IE1KISoARlLW0+j+MAOmFpdoWDFESZ1JRv6Xjut65WaWwicfsrhz+hd0ssorH+TrEY56RunSg==
X-Received: by 2002:a17:90b:3c8d:b0:328:d94:179 with SMTP id 98e67ed59e1d1-328156dfa69mr14438586a91.26.1756797984934;
        Tue, 02 Sep 2025 00:26:24 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d9347189sm13416648a91.9.2025.09.02.00.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:26:24 -0700 (PDT)
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 0/5] net: common feature compute for upper interface
Date: Tue,  2 Sep 2025 07:25:57 +0000
Message-ID: <20250902072602.361122-1-liuhangbin@gmail.com>
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

v2:
a) remove hard_header_len setting. I will set needed_headroom for bond/team
   in a separate patch as bridge has it's own ways. (Ido Schimmel)
b) Add test file to Makefile, set RET=0 to a proper location. (Ido Schimmel)

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
 net/core/dev.c                              |  76 +++++++++
 tools/testing/selftests/net/Makefile        |   1 +
 tools/testing/selftests/net/config          |   2 +
 tools/testing/selftests/net/vdev_offload.sh | 176 ++++++++++++++++++++
 8 files changed, 285 insertions(+), 183 deletions(-)
 create mode 100755 tools/testing/selftests/net/vdev_offload.sh

-- 
2.50.1

