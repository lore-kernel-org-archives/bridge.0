Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105430E82D
	for <bridge@lists.linux.dev>; Fri,  1 May 2026 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656704; cv=none; b=HHaIoFW3wGgLyO9z3zips2WA+drjC0strKwLqSvIEb3yIXLXGSG8tBS80/s+TjX3/0v7E9/6LHkonQbv8Ae9WhbNudVP5/l1AwhQ+EaxRSa2lHVyZUogAh5fl8kJc3a4RXqhbKLyvJOpPRUXB8ekPK8tFygd24yyBwMHziBys5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656704; c=relaxed/simple;
	bh=GPJn3apAiATfWozyMoTFurVezJt7ECoPiWTiUW2+1Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onDepB3+53KLI0fuEsa7b8PF+0eT8VTY9mE4WkEWP4vDFEjdqjTrfp18xZ9RK3XnEp2GHAjASLQXshU2ZiXFuU4Sn9SavxN72Uo7XAV+KvBI8kjcLWFFvdPey7OMihHkN3zlLHbDe1HwPHm7d4kCQHKfcr1ME7GBpHbGzyvcaeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaxZqT5D; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaxZqT5D"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35e576110adso1570263a91.0
        for <bridge@lists.linux.dev>; Fri, 01 May 2026 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656702; x=1778261502; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMiYNnBeGWnD4tEnQiWJxALYagtWxwAZ6KTfja4eTyg=;
        b=PaxZqT5DUVbdslP5bfHIsMUExLSU4CkRbHrycM6/pJk4sHoqhSHhjZwQPQWGHWAVVX
         StWJvTkb90TdqPwd3FVJz/7NzuYoqaOFkEu4GN63cX91llhAo/xc/qgBNymfXaq7A8KR
         mlrnUkRqS8o4V0o14FPErDBks58kS4p1VHRFJBsqOwUwzJOT3T2TAsct25U4r7JZZang
         hYrhK6bVGxRv3AvCIRooko74Nq5YdOYB1hOPosdizJDW/HU/4J5AH00lvBmo9RrMLB/r
         WLbSJTN4UZCJEH9a8pb/uCd1PcuoRujv5gvGQ2H5t6EHo/GOLh8v4g1K3RFpfhXHrfuo
         if0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656702; x=1778261502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMiYNnBeGWnD4tEnQiWJxALYagtWxwAZ6KTfja4eTyg=;
        b=PXr/eFPlcgHiAI1GWx/Zkszd6j/Ekbma39rZAmc6eAqyoUHUQvdV9MVnqJoPXQ0PqV
         mOdhOBFTq0qgqKNjWNtym72d+hlqs7aowL484ORc2AmAq/Bdyu/8K3ogexMP+wLuTVOZ
         e4CJ95kiJSHwQ9Hnknm30GoSY0XerRAjHgcsrSpN9MN5QrXV+hTa1sX4oi5i+VhYSJWi
         3TPQ8b1etCfNZ98TV2tfKi4wqDZNRMWGyDC1igwmFOQHOaqqhdw6Zc2M3l93yyomJFjo
         0Sc/Vp0el5vHPz9CD99o8V4m7K5gmtI4EAvVQHQ1V+1kF30F4h+eBcIof9452Czhgsj3
         8IyQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PWb2Nop6Zi3RkufVmUUtPt3IqZnAfXd1HcFbZ1kM+LGZxUa4psMVFOU3h0zBxmJTDRa0JX1w=@lists.linux.dev
X-Gm-Message-State: AOJu0YyCWsVXE0YCUmJLYrCAcFS0v8cP5SKLXFb+kBc5rtFFcslZ4yCw
	gV0UyEK5KgUhNSTiWJZGIzcc8RESMsDXDbj3LB6r9r+IIP6Iq4k2rX0l
X-Gm-Gg: AeBDieuDrhpSAZMUne8HU5twvFsMuCC2gsXF2aVMyuKAC+4r41KFpVn4XHqWJ0RqfAd
	tPu+twNeXDpmlP3qRJ4yGHZL6hNc6aCQcLzAocHPckkOPTb9F9eLnuRdVgtn4cecgnf6tOLluRE
	s/6Jb9GJGNqLHUEtk4YkjvpbAkbyvHt1qIKLirr7kAr6MmcksDIsXe4OtcCgwN3BagOw3w8MKpE
	qKWpsDRNpO32Q8GtQbaprEbLMfviKaHpsEiMbPmDYF5uUnpM4rCpbZXYe7GkLA7iGIEbpmcERz2
	XCAvJYv841O030HkJLdGCKdiiBV8VD687SblK+AM1RmwpQkcUKNOM+JBGNGGq6AjnqnQadP+6BG
	r0/Yu88SUVXL3Q45p9ct0UXpygEFeS9hoMebOKEKsiYji2dUKJWz5ULyhbiHM76+D0QlAVtmjyg
	Yd++R6b8dF8E2Eg67fgJdC+p/puxy1szLdnz/lHWmuvlGEzam9mw==
X-Received: by 2002:a17:90b:54cc:b0:35f:c6bf:2bba with SMTP id 98e67ed59e1d1-364c49a1ccemr7557565a91.11.1777656701718;
        Fri, 01 May 2026 10:31:41 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm2908906a91.2.2026.05.01.10.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:31:40 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/5] net: bridge: mcast: support exponential field encoding
Date: Fri,  1 May 2026 17:31:24 +0000
Message-ID: <20260501173130.3486-1-royujjal@gmail.com>
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
Giving results only from modified API vlmc_query_intvl_test() and
vlmc_query_response_intvl_test() of the script bridge_vlan_mcast.sh.

Using old Linux code, here is the result:
    - TEST: Vlan multicast snooping enable                                [ OK ]
    - TEST: Vlan mcast_query_interval global option default value         [ OK ]
    - TEST: Number of tagged IGMPv2 general query                         [ OK ]
    - TEST: IGMPv3 QQIC linear value 60(s)                                [ OK ]
    - TEST: MLDv2 QQIC linear value 60(s)                                 [ OK ]
    - TEST: IGMPv3 QQIC non linear value 160(s)                           [FAIL]
    -         Wrong QQIC in generated IGMPv3 general queries
    - TEST: MLDv2 QQIC non linear value 160(s)                            [FAIL]
    -         Wrong QQIC in generated MLDv2 general queries
    - TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
    - TEST: IGMPv3 MRC linear value of 60(x0.1s)                          [ OK ]
    - TEST: MLDv2 MRC linear value of 24000(ms)                           [ OK ]
    - TEST: IGMPv3 MRC non linear value of 240(x0.1s)                     [FAIL]
    -         Wrong MRC in generated IGMPv3 general queries
    - TEST: MLDv2 MRC non linear value of 48000(ms)                       [FAIL]
    -         Wrong MRC in generated MLDv2 general queries

Linux code with this patchset, here is the result:
    * TEST: Vlan multicast snooping enable                                [ OK ]
    * TEST: Vlan mcast_query_interval global option default value         [ OK ]
    * TEST: Number of tagged IGMPv2 general query                         [ OK ]
    * TEST: IGMPv3 QQIC linear value 60(s)                                [ OK ]
    * TEST: MLDv2 QQIC linear value 60(s)                                 [ OK ]
    * TEST: IGMPv3 QQIC non linear value 160(s)                           [ OK ]
    * TEST: MLDv2 QQIC non linear value 160(s)                            [ OK ]
    * TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
    * TEST: IGMPv3 MRC linear value of 60(x0.1s)                          [ OK ]
    * TEST: MLDv2 MRC linear value of 24000(ms)                           [ OK ]
    * TEST: IGMPv3 MRC non linear value of 240(x0.1s)                     [ OK ]
    * TEST: MLDv2 MRC non linear value of 48000(ms)                       [ OK ]

v5:
- Added 'Reviewed-by:' as requested
- Modified script to fix AND logic in classifiers and updated comments
- Passed expected value as argument rather than hard coding in script
- Added minor comments for macros

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
 include/net/mld.h                             | 185 +++++++++++++++++-
 net/bridge/br_multicast.c                     |  22 +--
 net/ipv4/igmp.c                               |   6 +-
 net/ipv6/mcast.c                              |  19 +-
 .../net/forwarding/bridge_vlan_mcast.sh       | 140 ++++++++++++-
 6 files changed, 483 insertions(+), 56 deletions(-)


base-commit: edf4bee4215a173c0534d1851d7523d827149f9e
-- 
2.43.0

