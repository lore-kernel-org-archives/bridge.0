Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36CC15B57B
	for <bridge@lists.linux.dev>; Tue,  2 Jul 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922113; cv=none; b=ml2LJqLiE8lqfZFiN0X4RoQSSDaWIim7uVW0mbYh7bKdie1Scg+/kE8+wFHYnbcloXvxUlTHe31QFYdz/a7FmIBDgjWs/BqD+5KgJXomsRrti+i96p7MFwBElqsjm5iMcue7mPQsSbIkVzpD5DMb9sdjIng8dm3QXqD7Cj0Le78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922113; c=relaxed/simple;
	bh=AV/QCdqqveccrEjG930COx+0FWJe2qq37AE1VjY+c3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JUbdvmQQAoNTWjxx5SEmMPvAz211Fhv3GcKE2/jY/yg44TBfwYrdC79kCGugjA/22WkoOSw6fCNiyYwGoZ+vZjj1qB3jgTIlMwOFPNohKTh6L3XLqVHvn+H354LlXohVlVWL0AzdUnv/E+bLd+gaiiCPAO6gYlE4SAasbnFzz6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=IFlgJhL5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="IFlgJhL5"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52cf4ca8904so6702045e87.3
        for <bridge@lists.linux.dev>; Tue, 02 Jul 2024 05:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1719922109; x=1720526909; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2FVSsT8prLQ7MVGouFoIi4BXqmr6LX7dsLflRdyCT6A=;
        b=IFlgJhL5YnwzlJiOcg3iLNGDDDP2kCPcifjoeVas9+GDn9w5WjXAGRfpnPeJsYRhW6
         UB5VzWW4mbUAqBWmEaJHTjsUDv0wAM4J5gSoglW3T0uSH7LReusutD7HHo7kmtMRYEKW
         3rJxcXiWP1BeYM3oJ13S46n3eqXI0TstpKQNd7FVKqIMgw5UtrHZ2bbYcGgPmRF0m1q6
         kTy8McJ+WVZtAgDXiaE3drV0KVvmt/u6EVKYiNptYVBtUmRs0RVozJ0gLTo3d4dkf8Go
         NV8HK+LaDsICoL0giboFlubf9lvzLmnhTK0h30hailYoIB19oA1QSft5uAZwaVJVoY54
         Lp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719922109; x=1720526909;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FVSsT8prLQ7MVGouFoIi4BXqmr6LX7dsLflRdyCT6A=;
        b=CWYFux4SQeZ0l+oMTOvXFahIynDcAKUJCjG1/cfQiVHDScxl0Dku6JDDU1f6wedIMg
         BG2Q1yeCp0ZX2R2XH7EWQBX4qDNmUyzx2Zadv5wKkUiIrGG6AH5AguRF13LoJRbXngDN
         sEC3DGVmoHix/RIjdhYMsDon6atQC7f+fSs5gDNP6cllffN452OGPUKYhI1i9lhXqesO
         1rVVLqCwP+bdZ8bAwreSrgNMcVC9M8+wSkxTYDcQGiy3rBfVapw+LV+azM7Hk/toF8uO
         2Znp5vGNBDtARGvdfydC0mzpid+5TPRNvqV98UsH8ROIF7sU9L94C85v6QHDdopYliC5
         uvgw==
X-Forwarded-Encrypted: i=1; AJvYcCV9l4DTpv7pRYgM5DPOteTBdKVzgn/0tpZ6YzzIlhsBMrG98OTxv0MplIl9QwUqVNzbTQvPUH+gGgJGF1YKlvJ0Kwami+cR
X-Gm-Message-State: AOJu0Ywx9P2vk0ukGYK0Bs8/ld3qk1fR1z+hFevAs2NhsSW72Qm7AA0j
	KzVdZL9xUwJIuu+G/1uPTiEii+ks4lUvQQZ/DXqD1sFYJbR1mNJQ37iJOZ2DWQY=
X-Google-Smtp-Source: AGHT+IGtsdUj9+nIPgGr5SjmSPLeNICk1p6RCIZgZ3IAIzh2Nqtag0T9Kf4QiKe57HdtxX82XSHkGg==
X-Received: by 2002:a05:6512:3f5:b0:52e:8018:279b with SMTP id 2adb3069b0e04-52e82747e45mr3482568e87.69.1719922107944;
        Tue, 02 Jul 2024 05:08:27 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-176-10-146-181.NA.cust.bahnhof.se. [176.10.146.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab1064asm1799414e87.103.2024.07.02.05.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:08:27 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: liuhangbin@gmail.com
Subject: [PATCH v3 iproute2 0/4] Multiple Spanning Tree (MST) Support
Date: Tue,  2 Jul 2024 14:08:01 +0200
Message-Id: <20240702120805.2391594-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This series adds support for:

- Enabling MST on a bridge:

      ip link set dev <BR> type bridge mst_enable 1

- (Re)associating VLANs with an MSTI:

      bridge vlan global set dev <BR> vid <X> msti <Y>

- Setting the port state in a given MSTI:

      bridge mst set dev <PORT> msti <Y> state <Z>

- Listing the current port MST states:

      bridge mst show

NOTE: Multiple spanning tree support was added to Linux a couple of
years ago[1], but the corresponding iproute2 patches were never
posted. Mea culpa. Some time ago, this was brought to my attention[2],
which is why you are seeing them now.

[1]: https://lore.kernel.org/netdev/20220316150857.2442916-1-tobias@waldekranz.com/
[2]: https://lore.kernel.org/netdev/Zmsc54cVKF1wpzj7@Laptop-X1/

v2 -> v3:
- Added 2/4 bridge: Remove duplicated textification macros (Nikolay)
- Fold a conditional in to a switch mst.c (Nikolay)
- Give the full command to set a VLAN's MSTI in the man page (Nikolay)
- Use proper type for stp state (Stephen)

v1 -> v2:
- Require exact match for "mst_enabled" bridge option (Liu)

Tobias Waldekranz (4):
  ip: bridge: add support for mst_enabled
  bridge: Remove duplicated textification macros
  bridge: vlan: Add support for setting a VLANs MSTI
  bridge: mst: Add get/set support for MST states

 bridge/Makefile       |   2 +-
 bridge/br_common.h    |   1 +
 bridge/bridge.c       |   3 +-
 bridge/mst.c          | 258 ++++++++++++++++++++++++++++++++++++++++++
 bridge/vlan.c         |  54 +++++----
 bridge/vni.c          |  15 +--
 ip/iplink_bridge.c    |  19 ++++
 man/man8/bridge.8     |  66 ++++++++++-
 man/man8/ip-link.8.in |  14 +++
 9 files changed, 398 insertions(+), 34 deletions(-)
 create mode 100644 bridge/mst.c

-- 
2.34.1

