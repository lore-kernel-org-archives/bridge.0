Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6B14A4DB
	for <bridge@lists.linux.dev>; Tue,  9 Sep 2025 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405946; cv=none; b=VpdEtRa9/95KOPjscLWqhQ/E7ttlN+ZRcYwecqb+Pqm8Pdd6XfzRaUfOj+cdrHFpoVut981dI9cECBoXeezcwDvwrM2jy/nuhivLlzsQDDaAWBx5OmBZhKrPYjSU+H87XHo2Xu3Egf1LKYLdcgjlqShBZY5hE+cVuWDN+qZMC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405946; c=relaxed/simple;
	bh=UOs1D2zaTKzVNvaXvVUug3+A+pozaCT5dX8It7FgCbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7xvtSZGvTbW2WejUt+O2dO+3ipT2oWuwMUtIZBayCUGnDFetYE90CvLD8pGcJqSlC7iXmWI+g9pMC1UbaDwhX7nWAE4G881a39e0V9D8/b3DsEsShFuk4rI0H0bVCnK2M3YBD+/tb8aS1GyAMVIdIchecnQWeW6h1Sfcvwjrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkwYd3nf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkwYd3nf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2445805aa2eso52087635ad.1
        for <bridge@lists.linux.dev>; Tue, 09 Sep 2025 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757405945; x=1758010745; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQCVIQ4ZNeoL3O3c1h4pVx8WIYjn5htIpwze/ZKsILQ=;
        b=HkwYd3nfy/67H4gjB7J58iTmC2aoABwprv5DnyokV8nyEp/ueXVgRPOT/w/2g7y63n
         LITKDAKi3AsKZOR6+UbehTqed3LpAfPAiCC4OipbW7fKiU12eAq98rz4LB3sfIxm+W0n
         lrRZTbh9F84pE+jR0++Iq/QVjORJox0PHtI2dlpTMPQ3CQJ+zBOFRR8uHuLgwrOOIrFa
         Yl8utbDTkX0mm272XEsydGrNSPdv58yy80dQd85ACd+u62hVrA0WPgKQ9gCHwT6FpCr6
         jEpwnVi7fTD7qIiXdogN4kUB12d5e9a7gcl2HAtw5LYGHTgGPkXLs9CQHCf5d/SbbPLT
         /GeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405945; x=1758010745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQCVIQ4ZNeoL3O3c1h4pVx8WIYjn5htIpwze/ZKsILQ=;
        b=VQbb1zEJsmBJBxZghecEQhiKwj/wO9MjA24gukAEgqwGkK3YfDx+7v8w37YosQ70CP
         /XdpM4qxigUxvFM+UJUE/+dsEdL0TkopGKul9kSGEsSSTXt8oaz1mVLD34yEwD1x4nXp
         HtOPkP8llTP/xBrUd42Dn7fpHJMVv8DyY/SXybH5Sw+JbuSAmHKYkEflFkQFCBW+cyae
         UcMSXMH1MjHmdEyp1P0X2TF3ChRTfPQU/x/aX8kpVoA/WWtMQXRr8Xsl4mYX8tqN05Oe
         rDXKCSsh86nEEmVNwmejOev86fHMdnlhQGiP3oFOhevcIOchZ3bwEsXOOselXNO37nFq
         3Tfw==
X-Forwarded-Encrypted: i=1; AJvYcCXtHmusY/oBm9x7ARqGajJZxvi5YJSuse6p1HRq584uDOeUzCebdGOBgY0azr/GC6IJX4aBchs=@lists.linux.dev
X-Gm-Message-State: AOJu0YzA/NR/uTTB1uSLRV+CWvfXI/5EtKGbQSEXVxwOvfALuRtQqqKp
	xuX95bd3kZaXYV68OspOYSFhyxNgUNXQfI2eNJKyKeM0B8wBvfij57+6
X-Gm-Gg: ASbGnctJJyjay9TSjr2uiz8t4RxOmV56J8MTbl/Hl3EQoe8MYTB9pGkeN3nIHRWvsTh
	0yOvvjqycXqygsEUFvUSu8LSxRyLed6SJaEJITN9bSMlpdSKBzTij560q37joOYPwGFh1htTyI6
	9dHDexR22gsZnPVn233Mbi42eIxG2ljJg6feL9lQ6Zp8TnlGe6jTLBG3iS6pG6N/b1UsOKde9RD
	FV1g//40PmuldoBLnNxXunmWQThP3ZTs1ugiShO0y+k4OXjJmmsXsWFyI44UuV2YrP8H2fAHIxv
	YOO7Q1bLaSBjitcudQCTz8SfOgTfjUG60vHF0HIL1O/ixfsC7f8Shzv5XJs4s3KvFDWO2yRBRnW
	y2XqP5dw6hL6UIOScR+5wKauUeYnoSH/sZA75i/S36giX+q19TplY
X-Google-Smtp-Source: AGHT+IHOwAF6ey8JXaYopBWq9/Uhe7RT1srRJ5PBZryhDlCcrPMiCboRAz+KtxEzy/adPCaSbItKSw==
X-Received: by 2002:a17:903:b8b:b0:246:620:a0b9 with SMTP id d9443c01a7336-25176729c6fmr119760875ad.61.1757405944709;
        Tue, 09 Sep 2025 01:19:04 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7ecd9cafsm174370575ad.83.2025.09.09.01.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:19:04 -0700 (PDT)
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 0/5] net: common feature compute for upper interface
Date: Tue,  9 Sep 2025 08:18:47 +0000
Message-ID: <20250909081853.398190-1-liuhangbin@gmail.com>
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

v3:
a) fix hw_enc_features asign order (Sabrina Dubroca)
b) set virtual dev feature defination in netdev_features.h (Jakub Kicinski)
c) remove unneeded err in team_del_slave (Stanislav Fomichev)
d) remove NETIF_F_HW_ESP test as it needs to be test with GSO pkts (Sabrina Dubroca)

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

 drivers/net/bonding/bond_main.c             |  99 +-------------
 drivers/net/team/team_core.c                |  78 +----------
 include/linux/netdev_features.h             |  18 +++
 include/linux/netdevice.h                   |   1 +
 net/bridge/br_if.c                          |  22 +---
 net/core/dev.c                              |  76 +++++++++++
 tools/testing/selftests/net/Makefile        |   1 +
 tools/testing/selftests/net/config          |   1 +
 tools/testing/selftests/net/vdev_offload.sh | 137 ++++++++++++++++++++
 9 files changed, 246 insertions(+), 187 deletions(-)
 create mode 100755 tools/testing/selftests/net/vdev_offload.sh

-- 
2.50.1

