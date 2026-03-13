Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E0175A84
	for <bridge@lists.linux.dev>; Fri, 13 Mar 2026 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773371029; cv=none; b=FIDQHw3jyO9rEeAvFiTbkiFDJpElfnBEyeTSrrEqDQQObhym4qsG4pMZxKPtisXMK6q9k7/7s6roPsPtDvKPTGeqjrrm2MQrJlZOL7y4NiETDL7qm16wgoblU3tT7FaeHY1h6KTtEeJeWrO88ov1F7GZuybbQ6bu2Cqh1Ks2Pv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773371029; c=relaxed/simple;
	bh=j7tVW9zGV8oXmoLeTvHG6D3Jq9SYP8Wv5IU1r0Pb1+I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A0x2iraVFAM39RVWzmyFTnm/dSC0X/6MU5M+rRkkhZ5x2Dx8Qk1eVKCPtniaNIiIoyNi9IgQKuiqfGSRDGj++buqe9rfIAjX1MecPbZLWdMgn4/u0U6DfWGf4SnIhpnzW4n88C26ck8ls2Gnoy3JzDxsjw1HZ0nTn++nuTicCBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTQhj3AK; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTQhj3AK"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-359fea895b5so993514a91.0
        for <bridge@lists.linux.dev>; Thu, 12 Mar 2026 20:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773371027; x=1773975827; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTHg3LXjfzPV5AkfTvIAZXI/emA8+u1EQzwENzgt9Gk=;
        b=WTQhj3AK6bPAwniByPZcWY1826zS6wti3j6DRZtJ50hzHSuy73hUQaWP92Sz4T91Xh
         83GS6NymcIPE0Rn3cza7pUd7rnHVVNnSaAlySlwi4ZlJbUBJeuUkfhC54BGQJbWIu9FD
         qS/QmGuOhu8KkjjM0H1xt/CH1PfG3ZU4kMpkstV4SQ4/FqAhR135WY0Kou3X8vOPilnk
         Bvc7jaLY5b7Ngt00QpcXeJRtux3NO+TO2VeGv899Fd40OTlCW8NMK41UR7sXkF19HGwY
         yHcHedIG+kF/KL/MVdNKQVOBeZ9Ii4f7MQtFtahU33XTgFljveN8skv2YRsH/lmkxDAk
         fwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773371027; x=1773975827;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTHg3LXjfzPV5AkfTvIAZXI/emA8+u1EQzwENzgt9Gk=;
        b=WpQL9xJshPl3hysAQEz/FUeWpj3lMUVx2CInLw2hbD1w1EEd0o7l8wQdwJvZjiNiOp
         BzOoOPfvKA98gGzkcGCbYueHUlTNGE3heluMIpnqefGgj8Z9J+QDpX8WW4v8weAYAwCt
         YLlx3XTRc25Hlrsi60nV8QwygBBysKsHCvfpthkX70PWGcOwfc30mgQ2rFtPx2dJ0nMK
         cabT0l7nIKW2F+a028mDZF8NSgnLcbr/PgshDLUKOW4TTowjhEc15v1jIV750A3CQR8a
         aJCTk7+XsPbut0r/GXeRQkUCsBM2aRUOij+8KlNyaSs3YFDRftaTJ3g+jzdujMmEgNgr
         jh6w==
X-Forwarded-Encrypted: i=1; AJvYcCWxneSZjMKzQzYcZU3PCIlwmMRnIiVmrgggEy6P1DgjUNhEk+5f0iJZ6rHtSceUAPNoq/TQcPA=@lists.linux.dev
X-Gm-Message-State: AOJu0YyXl/yu/DHpSmCeBzwekKFgOHARAh+NI7mY3/oemnzlauJ7ua5B
	G2rXPq7E+uIrF9Apv5/di7VnGLC4aZyGabttAknhxqb3CJHoAoB0LSNu
X-Gm-Gg: ATEYQzx7bE9wvJ8xIUz7neGJBF08Ih7pTaKwFqa0324nURCgTFQX74ok1LF1LBKXqf2
	2OO8SA+xzVxLdBlSdG2JZFkvPhaYovLwZki1gulXgwOndDUTI9QUcRBUrxY624zXK3UfdeR1J0M
	2rHKvwkptom7hBfYrwGg5OOtybByAUnUOCG/fx/f9LVzDPTuy3y7ihQeBY+nuVnj8YRFAqM4cYs
	xhJs67j9gBKry5P3Di6aIGc/NnadoF516Us/vxgS/KHyG/el9IEOlAFuUu8QBZyyrpDjg8sITAE
	dpTMylDJwHVzrCQqbDp/cJUrvMLJNJVYfTkEIqbuwctCkURrJZCf5HjvGeBO2zu4tH8hHKIgedG
	STx7hAyvHZfc60gNvP7Y33jrbI8BDeL0ts3RExUbg9CE2cEEFCZxYfxgcQHyl+VGkmRYq9YwL9/
	47noKGogdSv7Cv1jCESop3S75eismHSSVtiCxBCmu0OApqKGLtDbssV2Z9RqEvnxwwOUgGjkI+w
	QlwxFBD1vNPXiemQBCNViOhdzCRt9I5jENer+3buHl6tIGjivCgWCfgfeyhElA=
X-Received: by 2002:a17:90b:28ce:b0:359:8190:eede with SMTP id 98e67ed59e1d1-35a21e795e2mr1526915a91.9.1773371027407;
        Thu, 12 Mar 2026 20:03:47 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:adb0:54b3:92b9:a11b:1cae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a24a7dc1csm293967a91.1.2026.03.12.20.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 20:03:46 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v2 0/4] net: move
 netdev_compute_master_upper_features to ndo_set_features
Date: Fri, 13 Mar 2026 11:03:08 +0800
Message-Id: <20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQqDMBBFryKzbsoYW4td9R5FShonOqCJJGmwS
 O7e4L7Lx+O/v0MgzxTgXu3gKXFgZwvIUwV6UnYkwUNhkChbbGoUzpjZqeGl3bJ+IomLxrcyShJ
 KCWW1ejK8HcUnWIrC0hahL2biEJ3/HlepPvzfaqoFimYwt05jR6q9PsZF8XwuHvqc8w88iJjQu
 AAAAA==
X-Change-ID: 20260310-offload_compute-4c0bafa2e022
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3

Currently, master devices (bonding, bridge, team) manually call
netdev_compute_master_upper_features() scattered throughout their port
add/remove operations. This approach requires each driver to remember
to update features at the right times and leads to code duplication.

The series moves netdev_compute_master_upper_features() to callback
ndo_set_features so that the offload compute could automatically
invoked during feature updates when upper/lower device relationships
change. This centralizes the feature computation flow and removes the
burden from individual drivers.

---
Changes in v2:
- Fix macsec Security Entity uninitialized issue (Sabrina Dubroca)
  - Tested with macsec-offload-sh, rtnetlink-sh, link-netns-py, all pssed
- Link to v1: https://lore.kernel.org/r/20260310-offload_compute-v1-0-3df79c09ea65@gmail.com

---
Hangbin Liu (4):
      net: use ndo_set_features to set offload features for bonding/bridge/team
      macsec: move netdev_upper_dev_link() after macsec_changelink_common()
      failover: use ndo_set_features for failover offload compute
      net: no need to disable LRO specifically

 drivers/net/bonding/bond_main.c | 14 +++++----
 drivers/net/macsec.c            | 23 +++++++-------
 drivers/net/net_failover.c      | 67 +++++------------------------------------
 drivers/net/team/team_core.c    | 15 ++++-----
 include/net/net_failover.h      |  7 -----
 net/8021q/vlan.c                |  2 --
 net/bridge/br_device.c          |  7 +++++
 net/bridge/br_if.c              |  6 ----
 net/core/dev.c                  |  8 +++--
 net/hsr/hsr_slave.c             |  1 -
 10 files changed, 49 insertions(+), 101 deletions(-)
---
base-commit: 06fc88a6973fa6203c7c0cd3f5cef9d3405928ca
change-id: 20260310-offload_compute-4c0bafa2e022

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>

