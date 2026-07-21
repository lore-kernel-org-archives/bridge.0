Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1CB3803E9
	for <bridge@lists.linux.dev>; Tue, 21 Jul 2026 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642969; cv=none; b=SiTEPHXVM1w568PNFRGtVc9bqP5d+I39zc5ezCw0x7j7QwqpRettqz/k1Ua+oU3p82IzDnCibb36pGu4Fn7qHaVYuoVnDKSe93xv5NRcaq/XJwfhjqG8W3LBpYO0bs9+y7qx+jbI94xRfvR2ig1MVsAPfEMyBuafBl/fosZZQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642969; c=relaxed/simple;
	bh=DtEzZV/8p1ax+Tms2T+d8b3c66vl40iyvkvQKRBD86g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tx1LI3dSTyqnjD+EuC86J+EIsU+Ow7L1+fmOKBO6H8I02F2pBMOXIGhHupESsfS8cTe44wdFGMdX3aAfi9OWrRwzjpMfoXQo14WmmT8mnfkmN060ZBD1kzXothWdQlaJ6T8VUH4LerB+LB2kWj6MVS24ljaXfYw0dNy2EgPB2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ZCH5moyN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ZCH5moyN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954aff6088so27613175e9.3
        for <bridge@lists.linux.dev>; Tue, 21 Jul 2026 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784642966; x=1785247766; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oMgr/GyC0oliwpxvZ7bfPAMw7Bu99ta4H5Xc1BeDdt4=;
        b=ZCH5moyNjhlrd7dx5sLYL4lUfdWFh7T19iT0cNvEJtFpAHHm31gxORhL/zWN8WgdIS
         Nz41mVdkXRdLWagvioBQg5x6xpVTYrl74lwDT7fGGdZT0D4HQ41IV1TMPbtA1Uc1dmXi
         2+X2c2toKmGw1nPTtrjqKWtOqp29H889UBvf8rWQANnS46wZ4hpcpS41194m9YRjdGh7
         iAUUVUt6HOZ+BrQmV+UXMA2NkGiGAewQEeDBLdOJNKdmMf+aXMFUHr1YdMg8z0T7zDfo
         hcd8PZSN5zYWI5swHIjq0Xx2n5Qmh/VDdvMM4utrXdT3WluU8PxVU71dbjJbZH3vAUsK
         mB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642966; x=1785247766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oMgr/GyC0oliwpxvZ7bfPAMw7Bu99ta4H5Xc1BeDdt4=;
        b=cLU76ylOJCzT06vSI86Ax4sIIuBL4FnKrtNYM17QKodBisxKpT+aCTe6DX9DHTRS6T
         ymkQdFEzAtyC6nuBZQeiujol6+HQv2NUMzIH3jufdza8TXNVLzpTVjdQWAbO5HQGmMB+
         AMFyzHjueTORf1SBemEq1KT8EhsDiRkyOZcRpaa1l+VxKdxoMqBpWY956LCDouNgYjgC
         enQht+LAoFjcz7kq7lTRP9OO2KYwAz33hfo59nv4Z7BQIteV6MZRJ94hgwrnPnpqpI20
         oce4YVeHX9ddtT2oavqVokeSwVdTSmYYtLdkzWbiPOM0GK1vYEyGTugWh4wbenggbcFX
         bcTQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUyXv3cRC5t3v8GGP9B2k6dWN+D/8AzkPg/XVRiZ/8hi09Bjwb+SIysomEWRklNUlXlSihnn0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzJmwhrqTEZcpwt3ADdPzWVjpRbJ48uIN9vKHdKWoMI30yd2Tdn
	RCRDfOEX3sPL8ic1E5F0n4KxUE8LMEGX9V+fzVclhkWevU/FTt+aj9QWuDgjTfSuBbE=
X-Gm-Gg: AfdE7cl9Xw/SseG/1Gz7qE05gWn9wStvVa+S7q+hoOvRaVODpCbEZ9fUCbkLwR40V2E
	q7RD6Qe6WhZRGEdfHVYqJpEsp8RD0eAXHyx6m/nth4MrJ9MqB0P6YOq8ZcA9iSFxRcIhb/KRazO
	56nhg8ChqRjKdPAaEwf0ZF+fo2loJ/BUCiZrWjupxNX3vCeGlJ4xmKDiVJJTNb7QEFxca3ksB5t
	mrnxlCGKkiejZDainPtV4fDBA/w0+xW6KMYpoMJpI/W78CeElCn4D+shA7RcI/6dqC6ls8YgtU3
	lRNpwJQjGxY2aRDu8OckGTKSn8PrWdgCgDE3L+G6Bnuu8dhxz/0483PRFesxpX+2ibQ8QBYJU6+
	jV74KJOOZ9WCAPUw9CU5PrCgr/FlwmGhfq87r90FSXhQ5e5G268zM5PsFYnB9cdQoDEXnzA8GM7
	qA/R4S5RlETVWgviM5oB85V7us
X-Received: by 2002:a05:600c:4ed1:b0:495:4732:1eb9 with SMTP id 5b1f17b1804b1-4954a402df8mr166586545e9.21.1784642965806;
        Tue, 21 Jul 2026 07:09:25 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49565482c5asm107807535e9.10.2026.07.21.07.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:09:25 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 0/2] net: bridge: fix vlan range dumps starting with a PVID
Date: Tue, 21 Jul 2026 17:09:20 +0300
Message-ID: <20260721140922.682265-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Patch 01 fixes a bug that can skip dumping VLANs which a part of a range
starting with a PVID VLAN and share the same flags. PVID VLAN should be
always on its own. Patch 02 adds a selftest for this case. More information
can be found in the respective patches.

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: vlan: fix vlan range dumps starting with pvid
  selftests: net: bridge: test ranges with PVID VLAN

 net/bridge/br_netlink_tunnel.c                |  3 ++-
 net/bridge/br_private.h                       |  6 +++--
 net/bridge/br_vlan.c                          | 10 ++++----
 net/bridge/br_vlan_options.c                  |  3 +--
 .../testing/selftests/net/bridge_vlan_dump.sh | 23 +++++++++++++++++++
 5 files changed, 36 insertions(+), 9 deletions(-)

-- 
2.47.3

