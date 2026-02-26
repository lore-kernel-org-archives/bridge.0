Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D58831961B
	for <bridge@lists.linux.dev>; Thu, 26 Feb 2026 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106194; cv=none; b=r0ki/PTqKAIJ9Hon1t60W6nacwurw84qQQ9hId9xZJcnqA0qjK8OmXFMNuUlW2K+ShEOpWLgx2AhlD7bRlqRsFzPWBqoSSamtq8hJk5Uax+dxkn7bHfDjVFaFcjU5ZdP2n0KYYbCWu2q+d/Pdvl5hCcbp9sfsMY8BCYc7nWyHYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106194; c=relaxed/simple;
	bh=dJjhH8ryVeN8VbL+ettl5uMr2GTzSV/PrDSmpGn4P1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QahZAHkkWN9hiPkhclnJUG0Tm20KTEQswM/yna61JTUZfowJUfApwcceIxTj7HW3nH2PoLOyPCiN1A/tpsOTjOUAhLxjOHd6SjwLNhz6vEOeMIR+oRnj8qc5CNmQbZNnNbPHH01/vNbr3D7RCpNcZFuQ72uAiUuWHnjthZCrRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWqxfwOH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWqxfwOH"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a9296b3926so5846535ad.1
        for <bridge@lists.linux.dev>; Thu, 26 Feb 2026 03:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772106192; x=1772710992; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EdgMvJCRheKq92C1xI4uXJcoc9Cjrdybv0fSGYfTngw=;
        b=JWqxfwOHWD5snmJanroJPv5WSSFydjF1bG7JDJpjfQWQXp+p8UkqdB1xTQtRANIeFk
         fApJmBGgwfIHe/8uscPcaAtSz51Qj7kKxtjAyoyiTusgcd+RL+98eGHSXKwwceW25C66
         6YPu1gldV/Gq4RqIGL9jZFCAS0KoI1ucI/hWb+xIqclNZR095S44VYDMbEGlhy3y7ltN
         hxfNDM/hksGLXIYA8K5xIexttlAVQN3iMdXbJcmCuVW0jDvJmScwhDNax4AG39qau67P
         3bNHzlocqNVYt1BmTiUWQRUVzaAxvtbnM+pm8nLs3dK0jOSwVWrgCqop7YBam08N2CIb
         vgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106192; x=1772710992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdgMvJCRheKq92C1xI4uXJcoc9Cjrdybv0fSGYfTngw=;
        b=ptQ6jpPhkIds16iAWypWKOL4xC7wvSlT6hULWdgzYSJuZo3dxnZHH7A43463e41s7H
         iJCDZUn8+d4Kyp/AjEOcpzMfYIcPiS5KtLEpKUvBQhn+yIkk6gNRQewb/MgaCpTxcAui
         rOpSQXyXeEA5fvXw1ktlsZE464IYv1hWJ5NZOi/XDwGmLcei4ufI8IS1gQ49fRYRWsLD
         OyKTjecJSbV9IODC8wLl1Z73q4YPdI077dZjqJFGtziCTa1KXVWBspFi1+NB5h0+Mnu+
         6tmN8wxH36hmXFyTLd4zFGLbGcJZSRV4dwaZYPIT+UKQhCWlpDGsTchUrkSQSSMbAzrF
         6V6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEJycvEuU689rk8jZpSSiqMhv8oU5D+O/gaU8GDv2NmeG9/OdgxikrETu4k6kPG8LfGhX6suo=@lists.linux.dev
X-Gm-Message-State: AOJu0YywlIq4H1eKG+maaX/8R/bw1eY6/3AbneWV9dmjIIj61blEzqBe
	OIgGtfWUh949mYY+VuSdxoT+CkXDh14XdoAOUTen/V4z3oxMf6ZprQF7
X-Gm-Gg: ATEYQzw6+yeXRTYeapDVUl/GxNHXoT0x6lQfFfPICK4FfQm6p9U2BboGp/BcqjEFIW0
	XpvzdluVSkLgpD3XKDOS0dVXsj0DS6jokxG1Phjgf6oGhBq4h6ExBsvDaGF8Hz1fFAi3KyMEY0d
	DcGK5rfm2f4ESSdpLRvJTjMnJFIX1zGNnR0cPsTpKZBe6VxmQupsTpjlqITTtI5FG07gxzcVdjb
	AloP+5ySCMKDficKMwpjlX1j9Gb61y5m0k0lGS/8veo2xCOh+IORqC+M2yt22tdfZV+INGSHMPK
	RcvY9Wgdc6rVutuKDBalSglBQ+znoNPybq7AZctU4e9S/vB7M1hOGIj08CMVgQuEqtYExXUTION
	dur4bngjMyE3YZBcKS/rhdyZj5glNSYhsoVlG2Cjz7VjyoJJ2B7PZ/hZwUBHY020inFSs7vUHTu
	dSZ645HCIu/Lpj68T8cro4jpwMiKyjArR3/+g33A==
X-Received: by 2002:a17:902:ce03:b0:2aa:ea3d:a37b with SMTP id d9443c01a7336-2ae0305ebeamr20234825ad.2.1772106191620;
        Thu, 26 Feb 2026 03:43:11 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbac7sm34131545ad.37.2026.02.26.03.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 03:43:10 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC PATCH net-next 0/3] net: add ndo_update_offloads for offload computation
Date: Thu, 26 Feb 2026 11:42:05 +0000
Message-ID: <20260226114208.27774-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, master devices (bonding, bridge, team) manually call
netdev_compute_master_upper_features() scattered throughout their port
add/remove operations. This approach requires each driver to remember
to update features at the right times and leads to code duplication.

The series adds a new ndo_update_offloads callback that is automatically
invoked during feature updates when upper/lower device relationships change.
This centralizes the feature computation flow and removes the burden
from individual drivers.

Changes:
1. Patch 1: Add ndo_update_offloads callback to net_device_ops and invoke
   it from __netdev_update_features()
2. Patch 2: Convert bonding, bridge, and team drivers to use the new
   callback, removing manual feature computation calls
3. Patch 3: Convert net_failover driver, significantly simplifying its
   feature management code

*Discuss*:
1. Should we set ndo_update_offloads after ndo_set_features? Or maybe just
   call netdev_compute_master_upper_features() in ndo_set_features?
2. Do we need to compute the offload feature for hsr?


Hangbin Liu (3):
  net: add ndo_update_offloads
  net: use ndo_update_offloads for bonding/bridge/team
  failover: use .ndo_update_offloads for failover

 drivers/net/bonding/bond_main.c | 10 ++++--
 drivers/net/net_failover.c      | 64 ++++-----------------------------
 drivers/net/team/team_core.c    | 11 +++---
 include/linux/netdevice.h       |  7 ++++
 include/net/net_failover.h      |  7 ----
 net/bridge/br_device.c          |  6 ++++
 net/bridge/br_if.c              |  4 ---
 net/core/dev.c                  | 11 ++++--
 8 files changed, 42 insertions(+), 78 deletions(-)

-- 
2.50.1

