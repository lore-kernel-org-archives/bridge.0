Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660586;
	b=vmQeLhBOIO2/ilsXfY/SZKvf9seknH2ymMJhVjsSBJWXjLjIfIdo8lFYEEGAXb1Gh4wr
	 GrRaEUzI2x2uKKrDw3gT1XQCdG0Nne+d7MtPOJ4yb9gOx8MjJwSBhlwRBkj/z9VKMD8eT
	 VbEH4cckQCGGuiefVaOyUaT3T+ZGeIDvzdh1kz4yDf0B6NdkFlZ1ZhW3XMEGxa97uJPIf
	 kxM8qSJwJ6ilvFu6j63YhZMRDzUXGdY4/y+hueq+BDrHyHIExwS0gFlCpmP6SN3y3uKay
	 2MjpGgeJ7bz1ei5as24NYv7MCgDGFsKeVTlG1vdM4/Ccc3EKWyT8KY0df5S5IpQtAIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=s3Hbpdq8bJvy97QquSYSmiPRVKUjmKCEWWHbHnrtGGY=;
	b=bPSCizF2C4MiJ7agel6w7sJRDemEAcLUgWUbMFzBK+SCK0XO4SF5hFuVFalYAaW5J86e
	 c11QGrD0Opi5KWjrSHufp9YKMSynHDpJf5Z1JkzRtMPHqeBJc8L0n8J93aI7cWjESBPaQ
	 464kCk35d3fno1sywZgb3nS9Rrs4RVdNF7IwaBl99USJmf0K/h8F7yzerCM3PttyPYGlo
	 weWmkxRviu8Ts9EAc7pkGrA/YuezoSKmnGX9+1n/+7RB1BTDxSJtDz84LE7urSJc5pVg0
	 A3TfwWwiz2w+rIo3aIF20n+WqvidnwZfCi8ma+OQfYHb+5jnyjqHp7BNeOZXvhbfOrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X0kEKiKp;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC9606A323
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACAC9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X0kEKiKp
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-181516de561so326275c88.1
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660585; x=1793265385; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3Hbpdq8bJvy97QquSYSmiPRVKUjmKCEWWHbHnrtGGY=;
        b=X0kEKiKpWdfiA+oJSPHfS7pOGr/HyPev34+0VSzRaYFksik+GmU+1Tebn3xfkT+cut
         tMAUiWAJleUXXHkakCSznqJGhD5lgdn8xWLPOY0VuMDuG1M3UwlPie7BNPWeyBL3pYJf
         PGqGIohKt1/GIOoR2+2kaRgf+CWzTIsAwZSeh79lrHsw2UpRSzT/j2lwixkwea761ZF1
         Z8pzyV4x/0AY2fBnUL3twYVcHqBCBv//BFwpjmuQQOHd0/Jt5B1JXzhDyqCYCBDUc6m7
         5ulFraBH2kxOqiljdHohWEjip+/mWIsDB8zqzo4POKdv4t+uQHn60SZLGtOYUBI5okWJ
         MsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660585; x=1793265385;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s3Hbpdq8bJvy97QquSYSmiPRVKUjmKCEWWHbHnrtGGY=;
        b=Mng+D2/FreGkDBgcKpTnSbzd4f/2JtoULMgTJeJMyFQgVE2tmfwAuRyKCDgXqYJhJa
         a1hFhe4i9INOprzYTbPQMwamFqlKDHvjAvUrlDZbd9RCP4G/vO+JAlLy+GRmglcqtv8h
         tbIinHVJsddn1bM4qi1IfjoyXKog4+rTIGNfjEV95km6hQaZi9lLGHSDF4O6ZNiuHaHV
         dnBj/kIAX3fhalDOLZLh/k2D7YBjzWWsjtWVsKkSfGW5LNfTFS31ecpjo6S9Y+oksBzN
         4Mjlh+amPymzdk1JUE1N/lK8HPDnBQmIo72GqsKG1QveXBtaEqI/twS8tHu8W/0EPo/Z
         PxPA==
X-Forwarded-Encrypted: i=1; AKwUvByS7QgY/fFmmbCU255uYql3Pv+FsX4Nkl8reMNARb2CFsgHIAE34a7PClyNyAC/OMUj3x/wzcA=@lists.linux.dev
X-Gm-Message-State: AFq9FYJsNFNZvga6enNU9OeMBDp9q1uXdv+nL1NFbJ0nwoJqKH0kWzc1
	V1egzynPRdLkrozz2UvXUhL3yeQRZ0WJLxAd273zgwbIZZXeUxHiJFvB
X-Gm-Gg: AYBFou2EcbtACLP8HbYnYyxbD1aooC/mNBGN5Gtl6wCW87an1h6PkFyzxP6n7vWGLrV
	Gu92FezCyOdhAfXnnxFXW+U7qJClery6KBwpgr9SUcosiKLhAPO+9EQBNbucY1qY4+gvri6Wivm
	zRp9pE7q8odER7XW0HT82MPXB8GMRBj+EKLSC4otHF6G+PPQqzNtYyicktrgDmRvzBETt8MevrI
	cKWKsfhNB8G6ADRMK19VugnhwYmfLAgmKa1dVsoxm9Vto8pWMKh4H5Ix6TynNezJDHiyhTkNIr2
	BwBk/oGoD1io66sD4H1J9YG73R2/5mwEDG9MqBtd8l2FaE67+w4C+Q2qBIgzcNmnV/N+4qt6/Ym
	70PP3mTE8aw26U14XBhHK50Wm4B0mRnT2ajwHz4RqbDaaOrljbNP5zBgdIrq2n3UCrQZPKF0Pq3
	ze3hYNYCKjhxlO/N//znVxYK4NPkBIljpAFLdDa4izaYs7O2JNrOXfS1fl1OJt/NJXkGaOmJbso
	eQ66CgI+DLZxc0Jr677vG2zgSi4lCyQ6DUi1QkjMYf+fud/29XfZQSy9UwY5Ry36YBwh9FXHdgF
	jGkWaQDdj7tlRBCcydE=
X-Received: by 2002:a05:7022:127:b0:14a:6a66:f6e3 with SMTP id a92af1059eb24-192f4fb0ed2mr3798839c88.20.1792660584630;
        Thu, 22 Oct 2026 02:16:24 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903ca044d4sm14095227c88.17.2026.10.22.02.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:16:24 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: VLAN operations emit wrong link event types
Date: Thu, 22 Oct 2026 02:16:18 -0700
Message-Id: <20261022091618.3651826-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

br_vlan_rtm_process_one() reuses the VLAN operation command map for
the RTNLGRP_LINK notification type.  A successful RTM_NEWVLAN therefore
multicasts RTM_SETLINK, while RTM_DELVLAN multicasts RTM_DELLINK even
though the target netdevice still exists.  br_fill_ifinfo() also omits
IFLA_PROTINFO unless the event is RTM_NEWLINK.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1:

  RTM_NEWVLAN -> ACK 0
  link notification nlmsg_type=19 (RTM_SETLINK)
  IFLA_PROTINFO absent

  RTM_DELVLAN -> ACK 0
  link notification nlmsg_type=17 (RTM_DELLINK)
  IFLA_PROTINFO absent

  target port still exists after the DELVLAN

The kernel's dynamic-debug output independently confirmed
br_fill_ifinfo event 19 and event 17 for the port.

The request handlers need RTM_SETLINK/RTM_DELLINK operation semantics,
but successful VLAN changes should emit RTM_NEWLINK, matching the older
br_setlink()/br_dellink() notification paths.  The 2015 notification
compatibility fix established that ABI, and the later RTM VLAN path
regressed it.

I found no matching upstream fix or CVE.

The self-contained PoC and full serial log are available on request.

This was found with a multi-agent workflow; both event
types were reproduced in QEMU.

Thanks,
Cheng Yongkang
