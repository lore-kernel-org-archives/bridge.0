Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F4714A9B
	for <bridge@lists.linux.dev>; Tue, 14 Oct 2025 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428951; cv=none; b=ZdvkiTLt4pfJTZsID7vKK9amfNO3r4PeCEW+OG6pUqzfhLCB2r74XTFFpVU8mLQVnhXxE0PvpLscnJ99Mi6EZ94w+I+q38ROs/XYDW4O+6iG053mbUOnDCr+xNWIxlLqUfeZtTc+rVHwtXKAHJapyLz2NLL0R7kv6zr8sIkHPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428951; c=relaxed/simple;
	bh=zm7I7mmq5AscDvbVH2A6TlacZ/3e2PAL3DahCNCm4U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPPciohkxt/aydLCC7E2obxOgBrPBIYHDIs50KIZunxSyXhZtID3mGclRp+HdPYZ/YMEZ1UtAfUoqlvGTxQ7HAOWt0m70ZIfLcKjEMXl2mR1gigP7WlqT5U9hRyzmyBDMpoxYatTX9uuTC9tt9zWzQR9ZUdI7vJZlCIETgfk8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcOxxgFN; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcOxxgFN"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so4839257a91.2
        for <bridge@lists.linux.dev>; Tue, 14 Oct 2025 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760428949; x=1761033749; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6GyH1jrLC1slm1gXZQb4T5nA8guMeRrq7L+/TaRkyp8=;
        b=hcOxxgFNHMeU5UMpcH1JMWoQH9frvhBT6vZY7GVflCQGxHF91Pjo3MyRv6BSR2KAA4
         GQxhCaxxRT83UudxPGugzjkZ9KjxxwCggv3KsLQiu5y+ydXkNFL82rDq+QSMN2dAqVSF
         abl7XjJ4OVka6OMGWM1n5nuirOA3SyWRDquOFQ/Ek3ByCVwirSX/0f7PhxUb4gVkOe1x
         gblXxq4vRBnXHa/Elj17AQbexFVkg7M9hbQ1zTv616nW1bhj1ZaMqmMbcprDl03uLfEL
         eU7NoXa6pB6chxVJ7w8hdUmI2Q08howv8zt8wJkzphGgYhzB8OJG1BP1MhW57PJIKK2s
         Khyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428949; x=1761033749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GyH1jrLC1slm1gXZQb4T5nA8guMeRrq7L+/TaRkyp8=;
        b=Rgddk25fvztxjd8neDdfl0OEgSXzQyGUV5NO1v0nJ+NB2wX2cE/qt8Fq0Q1S8fFyIF
         mJ4ZCHtYmsHwownDTbwGFfewv+hUYuBTcVB1NNnEdRRa7GZ1tFyYAftRjklMyI2DrbPE
         ioMQwtWCc3Xl3jhjcB0afE3L21uqZZeVrEZrUAf1qf9Cwh7AFO2VMGQiEs87a8xWjv5I
         g6GrcIRMY9OJJARKaUnKvP8Yr+KaCKa+XQ977ZmvDOO9uN+brom8hKJcCFKae9DBl84G
         ILLl4eoiK1OP0+BDYN0yQGXrfGfPnQ4+V3rMXXHbFiIoE07T1OFBytdjnKnSl7DWEnwY
         kZMw==
X-Forwarded-Encrypted: i=1; AJvYcCXJwnX+4uaClnXcBdGxu80uHD/7vHA2xSR5cRSAp51oC24T8wOQXhdl+gtwJPRG95rodGr8O6Y=@lists.linux.dev
X-Gm-Message-State: AOJu0YzrzBApIuogfc5Pz3fwuogqaSNJXxYkncjv4DigYJXPx08SsK6x
	863ha81klPU52S+jUyhQGYJoEsnxJRAQNv469+TdfPKzXyrAr1vunLmU
X-Gm-Gg: ASbGnctfZYgzXJIzwKtBOmn5b1Z/O3U+TNS9+OGVkROobe5VStXK8VXr6Xbx5pI+Jrr
	eLAOlaTKJeezkMBJiwKgAXHPBD0WiScFZYFlRe/MtLW/kqStHr4evMFEmZphRN2lmuU/oWAsteC
	lvp+saDWqQvaG4PdCMQph1WQbSFflc1EZLN+IabnTflwVfQh5rVbsiPIiFZUs9iziCx6rYlFuk2
	/uIpbhS6x851cn/xP/M94oSp1k+wgjrsd01RT421J2t+WWIEOp3m2+JhhJs6s6vke8LcGBbuTXi
	7XxUFk03HM2eMyMteJpz1+AdX0g+/ywjI0PfrIN8pgbFw5187tTDjk7+F676F7DUWkORINfdtbY
	jALFTCXVq2fdNFdOvbpgq6OjDwWBwOLrUPDwH25jNDb98sktPfecd2eii
X-Google-Smtp-Source: AGHT+IHgLYdPneakAA8pkp65cfa+3QOkYNTGyvgYvXWd6kxyTFqG4Cd7C1Vhd1fBH4ZNLOQ1Qrmfhg==
X-Received: by 2002:a17:90b:3b84:b0:32d:d8de:191e with SMTP id 98e67ed59e1d1-33b51165115mr31684698a91.10.1760428949390;
        Tue, 14 Oct 2025 01:02:29 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626407c4sm14648210a91.6.2025.10.14.01.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:02:28 -0700 (PDT)
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
Subject: [PATCHv4 net-next 0/4] net: common feature compute for upper interface
Date: Tue, 14 Oct 2025 08:02:13 +0000
Message-ID: <20251014080217.47988-1-liuhangbin@gmail.com>
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

v4:
* update needed_{headroom, tailroom} in the common helper (Ido Schimmel)
* remove unneeded err in team (Stanislav Fomichev)
* remove selftest as `ethtool -k` does not test the dev->*_features. We
  can add back the selftest when there is a good way to test. (Sabrina Dubroca)

v3:
a) fix hw_enc_features asign order (Sabrina Dubroca)
b) set virtual dev feature defination in netdev_features.h (Jakub Kicinski)
c) remove unneeded err in team_del_slave (Stanislav Fomichev)
d) remove NETIF_F_HW_ESP test as it needs to be test with GSO pkts (Sabrina Dubroca)

v2:
a) remove hard_header_len setting. I will set needed_headroom for bond/team
   in a separate patch as bridge has it's own ways. (Ido Schimmel)
b) Add test file to Makefile, set RET=0 to a proper location. (Ido Schimmel)

Hangbin Liu (4):
  net: add a common function to compute features from lowers devices
  bonding: use common function to compute the features
  team: use common function to compute the features
  net: bridge: use common function to compute the features

 drivers/net/bonding/bond_main.c | 99 ++-------------------------------
 drivers/net/team/team_core.c    | 83 ++-------------------------
 include/linux/netdev_features.h | 18 ++++++
 include/linux/netdevice.h       |  1 +
 net/bridge/br_if.c              | 22 +-------
 net/core/dev.c                  | 95 +++++++++++++++++++++++++++++++
 6 files changed, 127 insertions(+), 191 deletions(-)

-- 
2.50.1

