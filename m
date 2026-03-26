Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C73890F2
	for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537672; cv=none; b=qakWpZ2h5soracITNroy0PPODNhvOBu9n5UESF8gZjHt1MrAUo7X1y9t/sA/boHzubNzOWEX1sPD/wSOULE7diyewxpKlX/4mYvJi66WJbT2hsazE4jWT3WahMSp3LctpZQoMwwwGwki9ZqOHQBMx6JXzCIVcxKF4yFrOOpDEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537672; c=relaxed/simple;
	bh=jhUluxnOnXLTYrExMH2GUBs0GFaV+n3AxshVQjkfG5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWRPbXe4OjfDKJ9PVOoatukSRQgAnOqcE6IbaBiP893eWhRSlIWdOL8VOPxQAmPq/LD6Vn3IUzHnMwm9Idy/beO9rR5MJEZRJfwXbsradGWHzd3e4FHvLYWrv4b6hdUT03ZNH0PcbobWzOsoDYMRKVdlDzbZuaX4YlqCknQt5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNugOuDf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNugOuDf"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a871daa98fso8671945ad.1
        for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774537670; x=1775142470; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCoW6mouvlV/2Yp7iZzyAAghySisJwNrZrFcduzYkY0=;
        b=HNugOuDfLBF9FnhL7iONo3+PkDCFLIga+tQeM7Zswj8hpFsQ1L34/YPfi6qZcT7PKu
         AI73dKj4MelfZU8D2h4zmKLL5q5KxLSyn2tSLW38OFn99ylXofDFl0JK92+Xhfmjc9dA
         WmYCMt6sKqBuxjoggiHjZ5KIRQJrlphgtCzCV0Iuk3hV16kWHe2rO2EtDLfcHT2kA+zh
         A6SjtMG3BWlEgepGYDWSV5ZWWnyTi5wsj/f8/5dPfNu9Mc1N7trhlNuTpN9f9xlMH+4y
         Ep6PmzAdsIcQHRYrxk7+TgJWbNEeYTMOD5R0wA1ZysS/VGL62VmoFo484FKvY4/AE2VT
         bKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774537670; x=1775142470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCoW6mouvlV/2Yp7iZzyAAghySisJwNrZrFcduzYkY0=;
        b=dnl9aSf7xPZ4ua/3xpK4EyKPFMyfW8eLMDVl+ha+2u2y/MlNdHq652v7NcWlk/gCFy
         NbLYdZQYTf6S3ePMFDnbcAZsS964pKpizF68Z/Xsfc/H/u1yaUjt2uTzedd5P7zgfXcO
         9vgMkcewVOhhM6SlVpfDr7I+zk4pcCPsWYFHMqskNh6Qh1CplAcrg0JpAD/tSQLTCfog
         MUcmFFBkGof31OZWtVVVsrg8T/c0x+zNEzi9pb8GIj/Bv7iN9dxE9oDjEdIGwDVGgnsm
         T6NZBFaZ1RAZMPKn+Zt05ic7N9ti9tb+oIMruAlzvgx5DcKun7935NxEc8vJwG7FwALm
         llbw==
X-Forwarded-Encrypted: i=1; AJvYcCX/TIlljzXID6qsvxO9c6v50iNFUaGLqo139ED+ctGlyTKkSLFeK5YEAjuo9BoeYG5PkGdwbhc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzOM8VylWs5VWxT8mkW9V4oaC9HLGxwxfFe92ADf1RzWzu70Aur
	TKtzppudIWSqZplTTgn8MZ+nIzXmwucoQTIZ+/LXio8MzyyoaceoLxjV
X-Gm-Gg: ATEYQzwS/AY5FxyQn/h97hc+a13AbMK/P9lPQa4QUo6VXJLmC8laXzKoB1yYGidjtkd
	YkSHZqWmOJyEj27TFNGrrjZ9Sozw0SqdpRFGoTrkT+FTAMT/Kmb26qFDPI4bzql6yZ4QWPr0lO9
	ja/9Dp3FSrXPedhfthiSBqhZmfOMUcKNyskNyVnmbTSRHVODvF1kJ82Fbn/1APGKEvkvoDMRurd
	z0DSDPaWrzClWZtZ06C6URbR5x7HC4DtJpScQvEREWHYPV0tO1EzBph1lht8FvLbQcWu4C9Funl
	/0vZzCXCySBqdE6MuZhK0NKHPM/tLP4CGtmICY4eWMwNa+lozgsNT6wKRW4vY6mBkPZAjqu/lLO
	08OuqzFID69iiV/dWddWym+QkRXMNYYFFPuY9l7SBY/tti2eA8eKvj5aSe+AiIN3VqcQp+2GU+I
	1sdxjrF1+vn94MfoBF2ZGhBaUekZU9YA/I1SAk+fiHCBON3L7q9cs=
X-Received: by 2002:a17:902:e951:b0:2b0:665b:c7de with SMTP id d9443c01a7336-2b0b0aef15cmr88760115ad.40.1774537670058;
        Thu, 26 Mar 2026 08:07:50 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8bb5fasm33146375ad.59.2026.03.26.08.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:07:49 -0700 (PDT)
From: Ujjal Roy <royujjal@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>
Cc: Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] net: bridge: mcast: add multicast exponential field encoding
Date: Thu, 26 Mar 2026 15:07:38 +0000
Message-ID: <20260326150742.50289-1-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Description:
This series addresses a mismatch in how multicast query
intervals and response codes are handled across IPv4 (IGMPv3)
and IPv6 (MLDv2). While decoding logic currently exists,
the corresponding encoding logic is missing during query
packet generation. This leads to incorrect intervals being
transmitted when values exceed their linear thresholds.

The patches introduce a unified floating-point encoding
approach based on RFC3376 and RFC3810, ensuring that large
intervals are correctly represented in QQIC and MRC fields
using the exponent-mantissa format.

Key Changes:
* ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
  Removes legacy macros in favor of a cleaner, unified
  calculation for retrieving intervals from encoded fields,
  improving code maintainability.

* ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
  Standardizes MLDv2 terminology by renaming mldv2_mrc()
  to mldv2_mrd() (Maximum Response Delay) and introducing
  a new API mldv2_qqi for QQI calculation, improving code
  readability.

* ipv4: igmp: encode multicast exponential fields
  Introduces the logic to dynamically calculate the exponent
  and mantissa using bit-scan (fls). This ensures QQIC and
  MRC fields (8-bit) are properly encoded when transmitting
  query packets with intervals that exceed their respective
  linear threshold value of 128 (for QQI/MRT).

* ipv6: mld: encode multicast exponential fields
  Applies similar encoding logic for MLDv2. This ensures
  QQIC (8-bit) and MRC (16-bit) fields are properly encoded
  when transmitting query packets with intervals that exceed
  their respective linear thresholds (128 for QQI; 32768
  for MRD).

Impact:
These changes ensure that multicast queriers and listeners
stay synchronized on timing intervals, preventing protocol
timeouts or premature group membership expiration caused
by incorrectly formatted packet headers.

Ujjal Roy (4):
  ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
  ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
  ipv4: igmp: encode multicast exponential fields
  ipv6: mld: encode multicast exponential fields

 include/linux/igmp.h      | 158 +++++++++++++++++++++++++++++++--
 include/net/mld.h         | 179 ++++++++++++++++++++++++++++++++++++--
 net/bridge/br_multicast.c |  22 +++--
 net/ipv4/igmp.c           |   6 +-
 net/ipv6/mcast.c          |  19 +---
 5 files changed, 336 insertions(+), 48 deletions(-)

-- 
2.43.0

