Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E916288C34
	for <bridge@lists.linux.dev>; Sun, 12 Apr 2026 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775992263; cv=none; b=ffjmlfvLdqFAColMQQkynNTsLpjLBoAWuC4jyHEXikXGbi0YmCvynsoe1pMF45ZaG2pb58HZaoZI+de3ATVDM0yqMD9kmn8Mxpp795s4gJ29xvS94aXUd0SedI66duuA1fvy+a6GuwCjUZVe31GSBcU8LbkFoUjc7via3aXz1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775992263; c=relaxed/simple;
	bh=DN1YYPSHImU/U5TMNDB5Ec47OLtn6flhiZP9gVoHmi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYFEx4hzUvOC0xfEm1FpIMhbjEoX1be0qssDZlhlDVI6dVUNImMkjryX6ZeiuHEdnfJxzZASsbKrD/36GVtDNIWKN4aRC8MYw2EwAGdKvIyg/XOIcLOK2PoSGzoMjolK1SpbBNZ3J20P0V0gVFBqqeN6evVxuWsHE6tE8BOzQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfkrBZM2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfkrBZM2"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76b0cda2aeso1432804a12.2
        for <bridge@lists.linux.dev>; Sun, 12 Apr 2026 04:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775992261; x=1776597061; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=akueeEYc2Me3zisgTMBqzXUfPeZV9sXVNUmdWR6Vztk=;
        b=GfkrBZM2tkj9etG20+F2bZOayJHmVlpj/YkIegbpUm265BXZosNT8djVs/IF2jLoM3
         cRRcRfMU6iGju7vVtvE0zo4XKDSLG5zxhQTS/FHND6BEbdQmdxu7WBnEWi/DUJDIE4+6
         HXaunVpRJY3U8/Rf2oQaKTkgulwQdglBZ7kxXDTuCGaFX4FKf+6x1Zt0/pO6+srxF28g
         9EDkf418KrUyRyDer5dn3hkMmTSZujWRvKWP1e3NtMtAF7f5JRW7FxxkKsdhV3orHaiz
         57yJe9SkvSypimDSJ3KfjUthEiwx4BXrez0XfbXUDhsLkZpYGZ1qeA41KVWla/VwmVSe
         nDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775992261; x=1776597061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akueeEYc2Me3zisgTMBqzXUfPeZV9sXVNUmdWR6Vztk=;
        b=Fi6wFTc1lU4A+2oxYlgauFQQcvzfNFVgPiiGd5Pk6cNWiBmdKxcO6v9yGy0TJRW/vo
         ArOUDspmE4rz78BP3Nu4lQ+hx4FUmOBbjbSALnav/Mb8O1wi2ji0nuJVvB0dGBRe8zS0
         bf27uSBx8VywOO+blEqKjQxqK5pSo3JHpEJ+QxsCCh63l8OzIYK/BS96rlw10Bcy/fmq
         5T2xrdr2NQvZ/uodU4+P/Elf6DFL237fHEdcRlH4fZ09WZfs+hV75iFtluUrPu+ZsqFW
         x1yZJ/NdZmU5K5AQLQ3S459qMTKMN0SYZOG32QVuyBQQDBGKHOaTB42vVQXtpiswlWql
         N2PA==
X-Forwarded-Encrypted: i=1; AJvYcCU1CnFSvD26JsrrzqUp32HMA8aeI70NA2X4dJpxddigkFWQv/il5HBDREy5hygIntZNiRttXxE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/BbfZL4ypjm20px0v/M5OcwQOsEQkftDLwjEirL093gTtPknu
	o/KXKnHI1sbYhPe5yCxJpYcI6VUij2YgIpggfWTyLult04nWCtBkDjPQ
X-Gm-Gg: AeBDievxDtWhEywETSXCUkmuuK+biDoi84XEwYD1k/LnLjRc5mD+0XJL3r62405dkOZ
	iEBBIaLUVAb+96MdtIj7NPesmkvxDn6o+pd4gspBwT7PZ2RiJpxQiTBlv+Gj1sTJu9G5Fo5uSKC
	ARu+K+4vs+ZDRfgwXusWXF11+Xt9xeWu2jlBPQc6uiSIoVWfTmIPensL+SL23mtmm7bND9DhIAw
	WQIXVH3aAHVoL0GgVVK82hbpciLgFcIFu1fDfrXo/PoEt9o4xpaps1w5daPvfVC8XZVFJG9LVYx
	Pb0n28LTcKgaQQpZ9zfE8pKX41tXEpJqsJw1jiVLSEIquEjpxCIbo/LZO4E8ViFN87lZKnhbf6b
	xgzGLLGubMvX3hbTOrfhtus8whydSY6RkncALK/BS9QIGUKQHt2IDj+4ZYBatEEtNgFACzUQrPk
	J8EH0/N6faRQtadIwChhQQ14L7iILE5Ag8QS6Ufiyz
X-Received: by 2002:a05:6a21:338f:b0:398:787c:d2e4 with SMTP id adf61e73a8af0-39fe3d0e8e0mr10815770637.17.1775992261411;
        Sun, 12 Apr 2026 04:11:01 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7934c9ef38sm2522981a12.12.2026.04.12.04.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 04:11:00 -0700 (PDT)
From: Ujjal Roy <royujjal@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 0/5] net: bridge: mcast: support exponential field encoding
Date: Sun, 12 Apr 2026 11:10:42 +0000
Message-ID: <20260412111047.1326-1-royujjal@gmail.com>
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

* selftests: net: bridge: add MRC and QQIC field encoding tests
  Updates bridge selftests to validate both linear and non-linear
  (exponential) encoding for MRC and QQIC fields, ensuring
  protocol compliance across IGMPv3 and MLDv2.

Impact:
These changes ensure that multicast queriers and listeners
stay synchronized on timing intervals, preventing protocol
timeouts or premature group membership expiration caused
by incorrectly formatted packet headers.

Test results:
Giving results only from vlmc_query_intvl_test and vlmc_query_response_intvl_test
of the script bridge_vlan_mcast.sh.
Without patchset, here is the result.
    - TEST: Vlan multicast snooping enable                                [ OK ]
    - TEST: Vlan mcast_query_interval global option default value         [ OK ]
    - INFO: Vlan 10 mcast_query_interval (QQIC) test cases:
    - TEST: Number of tagged IGMPv2 general query                         [ OK ]
    - TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
    - TEST: MLDv2 QQIC linear value 60                                    [ OK ]
    - TEST: IGMPv3 QQIC non linear value 160                              [FAIL]
    -         Wrong QQIC in generated IGMPv3 general queries
    - TEST: MLDv2 QQIC non linear value 160                               [FAIL]
    -         Wrong QQIC in generated MLDv2 general queries
    - TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
    - INFO: Vlan 10 mcast_query_response_interval (MRC) test cases:
    - TEST: IGMPv3 MRC linear value 60                                    [ OK ]
    - TEST: IGMPv3 MRC non linear value 160                               [FAIL]
    -         Wrong MRC in generated IGMPv3 general queries
    - TEST: MLDv2 MRC linear value 30000                                  [ OK ]
    - TEST: MLDv2 MRC non linear value 60000                              [FAIL]
    -         Wrong MRC in generated MLDv2 general queries
With these patchset, here is the result.
    * TEST: Vlan multicast snooping enable                                [ OK ]
    * TEST: Vlan mcast_query_interval global option default value         [ OK ]
    * INFO: Vlan 10 mcast_query_interval (QQIC) test cases:
    * TEST: Number of tagged IGMPv2 general query                         [ OK ]
    * TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
    * TEST: MLDv2 QQIC linear value 60                                    [ OK ]
    * TEST: IGMPv3 QQIC non linear value 160                              [ OK ]
    * TEST: MLDv2 QQIC non linear value 160                               [ OK ]
    * TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
    * INFO: Vlan 10 mcast_query_response_interval (MRC) test cases:
    * TEST: IGMPv3 MRC linear value 60                                    [ OK ]
    * TEST: IGMPv3 MRC non linear value 160                               [ OK ]
    * TEST: MLDv2 MRC linear value 30000                                  [ OK ]
    * TEST: MLDv2 MRC non linear value 60000                              [ OK ]

v4:
- Removed binary application and related codes for selftests
- Decided hard coded match based on extra arguments for selftests
- Ran shellcheck on modified selftests code and fixed
- Updated comments on patch[1,2,3,4] as per review
- Added 'Reviewed-by:' as requested on patch4

v3:
- Updated the series title for better clarity; old one is here
  https://lore.kernel.org/all/20260326150742.50289-1-royujjal@gmail.com/
- Added key changes section for new selftests patch
- Updated netdev style comments and addressed review comments
- Fixed MLDv2 MRC conversion logic during query generation
- Mentioned intervals in units wherever applicable
- Dropped type casting and fixed indentations

v2:
- Retargeted the series to net-next as suggested
- Fixed a compilation warning in the MLD rename change
- Kept reverse xmas tree order in IGMP exponential encoding change
- Added bridge selftests to validate IGMPv3 Query MRC and QQIC handling

Ujjal Roy (5):
  ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
  ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
  ipv4: igmp: encode multicast exponential fields
  ipv6: mld: encode multicast exponential fields
  selftests: net: bridge: add MRC and QQIC field encoding tests

 include/linux/igmp.h                          | 167 +++++++++++++++-
 include/net/mld.h                             | 183 +++++++++++++++++-
 net/bridge/br_multicast.c                     |  22 +--
 net/ipv4/igmp.c                               |   6 +-
 net/ipv6/mcast.c                              |  19 +-
 .../net/forwarding/bridge_vlan_mcast.sh       | 150 +++++++++++++-
 6 files changed, 491 insertions(+), 56 deletions(-)


base-commit: 3f3a2aefbc661b837c8e344f944982d61c2ae037
-- 
2.43.0

