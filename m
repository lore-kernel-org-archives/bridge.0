Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F13254B8
	for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 03:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585921; cv=none; b=dPIWrJCEiiLEERi0rH09fv+cu8etpXn/2qYkAj/CjtvaszSSOusXgoyJag5GojSE0Jz3AtRTN5GhVkszUTwZGItwZ94MXbdaQFD2MXtOlYp4G43ZCc6aAZYOw4mEwzTgY2LDFFo8tvH3VI4d+1NV4kyjvKomIlOOFlFZCTe4f5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585921; c=relaxed/simple;
	bh=fT5EgAbqNy2gpcNA1b90qen7H9ypoH4TcZnfcN1+l8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifeWYY3zwp1lXQ1RIA+BuKupOPyhBe0KnV+yZ3dtLGXLzsUD7E0saAMh1lavoB34FlCIdIsneOvZxy093C4bvWV2Tb2CUmooZIEXkUCzxKfeKOyNzngg4eztl2Aa/peJ3dGLmAaT2uejWX6llD3o1y8NPwkjcaU1H2mVVqZ5Rjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KESQh2JT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KESQh2JT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-28832ad6f64so3113135ad.1
        for <bridge@lists.linux.dev>; Wed, 15 Oct 2025 20:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760585919; x=1761190719; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OkwCTPQicy3JSZBUTa3pajCwqzOFe6iOfTYWO6fwi88=;
        b=KESQh2JTnGTJ8F5hl+UnHd1TvD7FTw4P4tYTKfCRGHKl+3DhZzrSiKwEpIfi2ZUhX2
         J2Cy71gVw4YzpQBiROcJQn9JhKMnAF7DciTOT+aGyhCP1LxxeSoGlI4ztKpVdrr4azSS
         J0l8ZMcw5SrL9Rq/9n0w20AxuhgoreovERjQbPZZV8JAC0JY2g7g2NKffPqtx/UoN84e
         jlmw0iDAk3RZzLytu/mhCOUR986exR1G/ZKzKXYgbDF3aGwjaYak+07ctijmtilWPVtH
         SFBqFzvHrWBhQYqOnXNUM+C475l9mcQ7HKiPy3HN59QtVukJ0vaJGn7ceoeiN07OC+g8
         Tr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760585919; x=1761190719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkwCTPQicy3JSZBUTa3pajCwqzOFe6iOfTYWO6fwi88=;
        b=C+7IxWAuvmHl3I6DNAGab+gcZ6tlbD4/gvxlH6xCQle8x37NUZp9f2uyDGliOsmU71
         p7cSPh4Y9Xrcgoeyuw9roTyPBIlQzNl4p1J1fbota76MICX5qUu93Wi7eYpWkfp9GA7b
         PC3tsthMuUG5/vleca6fvLx2SxItew7RZbIQKRbDLxXC+4VTG3OriJc3gBpVcjskSYCp
         GXSIkQjYSeF+ClEKsZ8YJf0l4NHfWL1W0qz42aIxcAaBxEyVB8DCcxzQRpo45b5wemV9
         t+Rc+zflipb3/Kw4tZiR4r+N67N4+lcQ4bXgZZO7L/km5bk0qYSuOpxTnLD5LkZ6qvjh
         2dCg==
X-Forwarded-Encrypted: i=1; AJvYcCW8IsedCfzuh82U7qDqpTvt2PktIwjNKrbUiGnHDvysPqScoLOqnrxGbvdxDoGu+rV8Lef6iCA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3CBjIcajt+dqVIHR8mz3qb/0zVWZbZ2Bu9DiTGaC8DXb4ndHV
	CM3s+8jqikfCAGgCjGH0uZHgKTd/c/Ow15XY4H0xrQor378s0N0ewu/O
X-Gm-Gg: ASbGncssdZ8Exi9Z7Idpm6ZqcUQDCSYfl1HBpar1tipTydBzGMncZ2HHfSulsMuIFrf
	hDOy1Xn5yjRXqaN0GKA4CLE/ZthQQ0ycSk1eHxOUFF3J3Zcnd4dwlXgF9PJOWTxXAYltx03p99X
	mRS9bb2OkwB7T0y9hlasMqL2KzQrUHkwaVltR25YmTMrBq/4Pi2VOnGTvtxVr+TnoUCUjbDrlsD
	l668crG+EYYeGn6OQdgVzKL22qqNTyJ7OANpB2sUvsbz6WHdx5jQlgpuoSahLoAzqA8uqQI27Ib
	agOEkIh9jVay4ypTZ3rxAB2v4jEGmmm3yWGq7Hh6WWxWTKiN7kbIa/APgGCGpmp31Rhkjdck3Tq
	0zcPBne3KHp/aIq2qGoxP2LFFyqoZXjer0fli5k+Xa29ZHD73rQ5BKgniHhzf+AmX9LI0YeFIVZ
	KhL8LI
X-Google-Smtp-Source: AGHT+IGjtGxKJtL0FErTK/8j5Cc934yIVxzEaZBkQ6rShVkfbq1WeABh2CW2MFgBJPfgICcf9mHFuw==
X-Received: by 2002:a17:902:cf41:b0:267:776b:a315 with SMTP id d9443c01a7336-290272c2019mr371384375ad.32.1760585919218;
        Wed, 15 Oct 2025 20:38:39 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343065sm12507925ad.26.2025.10.15.20.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:38:38 -0700 (PDT)
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
Subject: [PATCHv5 net-next 0/4] net: common feature compute for upper interface
Date: Thu, 16 Oct 2025 03:38:24 +0000
Message-ID: <20251016033828.59324-1-liuhangbin@gmail.com>
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

v5:
* rename VIRTUAL_DEV_* to UPPER_DEV_* (Jiri Pirko)
* use IS_ENABLED() instead of ifdef (Simon Horman)
* init max_headroom/tailroom (Simon Horman)

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

