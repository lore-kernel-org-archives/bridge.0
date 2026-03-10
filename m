Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EBF35BDD7
	for <bridge@lists.linux.dev>; Tue, 10 Mar 2026 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128811; cv=none; b=pSddNkOBUuaRdoJzbtlpMIPhjqPzaAoWHSVhvg3hZQynvU+y1OcgZF3h4Z4DcOWpKzAfV9uZ7et6MdaI6Hq6p+7vF5GcaM/VaIcxGhEhY9Tfo7hcvGM0vo5e+c0zW86ihfQopGreWE03L4zsQ489AVMbIuwMMoYs13lJS6/zPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128811; c=relaxed/simple;
	bh=y5XzetB4YEUxDGYWaox1//ktFSCOhbUw8j0VGPuKSo4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jFEGNHu0YACNYsl8DdVqg8T5vj/xvbJpQurh41QDe/XTyB1rXRiSjUPHBrmbfaIh1+w2NxRo52kT88J+pmornW0L90T6bTKUkpku3meajRuDNAtx8Rf4GXKvCODqhHhYLzw/7zjFY9PjRZqVF8zHTAe0EkU2EzPwKsk/xXA8XHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXfiulTW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXfiulTW"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-359832fc558so7278769a91.0
        for <bridge@lists.linux.dev>; Tue, 10 Mar 2026 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773128808; x=1773733608; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWYg+gxn/dmjCA3qJdokJ8/AsXnstVtMxLRaCKRYAgQ=;
        b=BXfiulTWMpKI+9rwSA019uwE7dmDno1/OZsak+ep4OSXtrJI5ai+sUZRQP1ZkU1DW/
         DM8ZBQ+tDO4ifsIH/zxu/yA1+Bq7xw8v9RafgAa63JMQyaK1Vrfaha0F7L6e4vnOdyia
         YJooU8yLFF2nte3glHO/gqhusA9vLaInT9FDkkpJErKvXOegBAHhv+VC9MafUijILEKj
         gnrQpFBH7j6vra95QIxIp46Jm1FQwFs+yQ0kvweH9P3PDvjwZ4J0sa4z+0roezV3kVyu
         dyaqylN17oyonSnscrL82QxbvPuZVVAy+2OQjzYkwt9p297XDg76DUmW57Rux+ZcBW0j
         TFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128808; x=1773733608;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWYg+gxn/dmjCA3qJdokJ8/AsXnstVtMxLRaCKRYAgQ=;
        b=qpZiyoTOdThnCt22aP+itAXJOEEU+ISMuigYvs9aQ/nRCtL89kGbJvT6eJUpDq3Tzx
         magAxWfEDmo2SdoeJsJZ47cfArgW5MHP6+3pBWBCCdNbR0Ks4pVQUw9IpexUDXEDrCfP
         Vc+82G75U5gGAIr8+ENviUTZITzg+NkORUPBURbgJYxf+gzW9p3VqCrfl1paViobnkNy
         KCHrewAp9w9i7+a3atrvFbsMmaLJHoMVjVqxMIn/HtMzyn4ttNq0axN4it9lT063dimg
         hgiTAKuzdA455FskFT5jgRJmOCsLBzZ7htn7O3Z5eoPrbhbef2qOAD+xVT5YUx/hbwl4
         KxIA==
X-Forwarded-Encrypted: i=1; AJvYcCWI2AahlW16KRM1NT8m+bAiUp7PB6V1bK63nJ+nlgoJ9S35+KGWFoANaPNlMXjaqxshSo7joT8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2pxY1dPItzlpJsPhMj0uT+IF8hmliSlNEbrZz2rO/OCdkEndR
	j86wsI+Sd9uV/HX8M7CUF3ewfHTgf9MV2+85ZWR2F3tHwb3cloC/rQD6
X-Gm-Gg: ATEYQzznZQBexgD5x+IBjLjyIL/tQir0mxKKkryRrZCljh5KYwGomhdIwECprVdHp3L
	/6Iwworfibf45JsdbczvtaehVOXMmpB7vZx2p4sJK67sAR5h/KluQ8dSFknJqQvDG7+3DkXs187
	/SZ6K0Vgpcjntc8IxbUTXBfJumj+cjKfzGB7GZGNNm40aTaLCUZSwQR+WKQIF1TOPmGloD4+BYn
	S0ipSzvyoyaGDanFWNCWX7py7zGrRQfG4j3jZhq34ZYH9cz8OmJH+kHgWsteiMaYvyd/JfaC24T
	oIyPL0mn4S1HehocP+JHnWBf1YUNFilJsU504TRK+VNZD7l2yX8YSL2jtrCAegH9qgUuvVjY6Va
	TD6JgIi4+727oBR/MaHtoyzeIhgyhEXMxtSKc8BW8Q3fohycka7Cqttay6QKidXkeJm/+DJucvb
	1g6zIfaMf/RP6p8OKBhKWSmpAla+Ym44VM8mjISLd8Aywbeh1rfC1HtP+i4Fe/vtSJwA9GWxR4b
	IqHtn8K8fK954QIKs+X1AVtvVPszwcjyChl8IQcnLJCyLRlgj0+AQ==
X-Received: by 2002:a17:90b:1e4d:b0:359:8230:abcc with SMTP id 98e67ed59e1d1-359be275fdemr13516086a91.8.1773128807946;
        Tue, 10 Mar 2026 00:46:47 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bc7ef38csm7260607a91.2.2026.03.10.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:46:47 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/3] net: move
 netdev_compute_master_upper_features to ndo_set_features
Date: Tue, 10 Mar 2026 15:45:04 +0800
Message-Id: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrA2Mo3TRq4hIGv+0A20iSSyCe
 HeDy2/x3kEZSZHp2RyU8NesMVR0bUPuY8MbRpdqEpYH9x2b6P032mV28bduBWZw/LLeCliEarU
 meN3v40gBxQTshabzvABf+ipoawAAAA==
X-Change-ID: 20260310-offload_compute-4c0bafa2e022
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
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
Hangbin Liu (3):
      net: use ndo_set_features to set offload features for bonding/bridge/team
      failover: use ndo_set_features for failover offload compute
      net: no need to disable LRO specifically

 drivers/net/bonding/bond_main.c | 14 +++++----
 drivers/net/net_failover.c      | 67 +++++------------------------------------
 drivers/net/team/team_core.c    | 15 ++++-----
 include/net/net_failover.h      |  7 -----
 net/8021q/vlan.c                |  2 --
 net/bridge/br_device.c          |  7 +++++
 net/bridge/br_if.c              |  6 ----
 net/core/dev.c                  |  8 +++--
 net/hsr/hsr_slave.c             |  1 -
 9 files changed, 37 insertions(+), 90 deletions(-)
---
base-commit: 52ede1bce557c66309f41ac29dd190be23ca9129
change-id: 20260310-offload_compute-4c0bafa2e022

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>

