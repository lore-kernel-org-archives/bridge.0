Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C093C73C5
	for <bridge@lists.linux.dev>; Fri,  3 Apr 2026 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228462; cv=none; b=kRkLArhpna5E7G1oaH4H4KtFZ4Ow9Dxp9FYZ9CBcsZYKjoGLE0X1aQQQpdbA6klKyf6LzJrequlLkdPhFJ9di/l7n0laC1Q7kymdS5artZoUOq6yv1t9iPzQm/qfcfir/6JjMet3Bnb+jqV1hYTgJQDXYsJqz9WmWjj7DjSIfok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228462; c=relaxed/simple;
	bh=4T03tU+HgJyUNh24jwyBJCtFpN1e7T9GXw7WPkcUWAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YY5BQo8k2Tr4CLa1zdgV2krIxqwhQ2mpSKkBDS2THHD62M0XqXRclDdNysEiNp8x25O5U2EwSGZOqcJ3zIDaOyH0811polPwySwTWzXXf+krsT5DC8K/j4IIKyPTsIctFyDmICILy9VZo34BiSZpOupNxbN2lOtPklm4BkLacfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WK/YXEL+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK/YXEL+"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82c68339cf0so1839339b3a.0
        for <bridge@lists.linux.dev>; Fri, 03 Apr 2026 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228460; x=1775833260; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nYEKwooYgSKsCFZiHLlPAB+cRjNKV5UWBUUDOOvo/B8=;
        b=WK/YXEL+jpf0AMnCdp1Xj+Lek1GySEjBwNVZTlGGlbIHS1P5VJ5hM/idfxsxvd/f6q
         AjC5tCnOIiL+HH/7+iiNf6Tjg5cGf56tLLWMUPvJvtIunHCjaRRDMdHzt6mFvHmIlJzC
         o5efjrRbO5ggPHvtC+HYH/r+cIscuCIaJ1db7alrnlxyueRUNtfjsx7yaY5JRMDiO7vB
         TmVlMbmehxCIVAp5+mZxKaBFqkIuiHrkxm5r4FULpXds71TwmtGRBmpe+Rrz9tMC6TS3
         zNm3SBmwEMd+B5GhdfggyYNb1aGRcvU2BKFHKBaVPeLUqwreVrI193pJbBNtrmnT656A
         gCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228460; x=1775833260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYEKwooYgSKsCFZiHLlPAB+cRjNKV5UWBUUDOOvo/B8=;
        b=dPHVZ8WLDHAfAU2k0KXmBEDSXkJFFXY7wvwotTXdRhKnPlMLwnMElxSFzBbWU6yQ51
         S+GziLznHlfM34PSKfHaa1uusFqWFxDA6QUYMDDgghY3gIDo69KsKg9fXtFz6uRMmvCj
         /3fCQWvhsan1VWfjoQfUcWeUzvcuNcYU8bRVyLPkpGKByC6w7li3Ho3kQpB7L6HV6HzG
         Jq903pqqC5KXEPTpd1tqbcXA6Ua7E7CpMGlsaW98GxixmLR2zaaXNCtps6VNRYATGYDk
         h+8Vnedq5kmmVjl8mNStRt7rHucOL6dlfDCrnKphwXCmoHP7KfLnIwTjFwvPNB7v4VGu
         427Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwd8WYtQ3uTLf2ogEoiQflFVvzL3MHBV1luOlkv6HWnwPbKSZzhU+gNzC8BzkSZp3vz699xro=@lists.linux.dev
X-Gm-Message-State: AOJu0YxazmeTPUgTa26/IKmtNEutVy6SCNpc0PzSZy446H1GxXCODdcS
	n7Sxy17+nh/j9ZX+vagoG8UqyuIktKdMPaaEUmSvU78WBj6QF5ftc3ml
X-Gm-Gg: AeBDievvgmXdsN41eOpugTySjmqI72B+B3ZYJjKbOBwDsxLI+oA5+E0zlXohI5CA1uN
	b9gahGdpWR71oja3KuBGpihy9SiBm0lL+ZEPHb+T2xZtgSNre8ROB3LDdDHKk8t3R/w1ey87OkE
	wsxvdjzpKT3nN1exRTLizo+1q79CoUAMInP+jApzONOn+AskpW7U1hTekHXITWxImanezuYzJKX
	BMRtB4l8hCNMfHgh/64pcUyMBUqB/G3vyJmTapvUTh+zM8cBJSDVdgyaV66jW7lPPV1hwm6KE7j
	mdnfPXU+Q5DyuXiyUmrLJ5cc8sd8cWCjupR1WYSKxM8pEN0+ZbE/ao3QivWaBlw5ED/sN2UaOu7
	e6qHF4pyFzUOmlMU79TxEQYNJA17tjVEKhxvzt3pQOkSY+FKFRvnCVH3/SbLee5DSRIJcoFtaLt
	q3tErq5fiDAMFAN26CHuvYZ0ycDtOV97IYG/3xNvpN
X-Received: by 2002:a05:6a00:340a:b0:827:2d7b:5038 with SMTP id d2e1a72fcca58-82d001e9e7amr6034017b3a.5.1775228460095;
        Fri, 03 Apr 2026 08:01:00 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca79basm7789483b3a.58.2026.04.03.08.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:00:59 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/5] net: bridge: mcast: support exponential field encoding
Date: Fri,  3 Apr 2026 15:00:45 +0000
Message-ID: <20260403150050.1235-1-royujjal@gmail.com>
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

* selftests: net: bridge: add tests for MRC and QQIC validation
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
    - Vlan 10 mcast_query_interval (QQIC) test cases:
    - TEST: Number of tagged IGMPv2 general query                         [ OK ]
    - TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
    - TEST: MLDv2 QQIC linear value 60                                    [ OK ]
    - TEST: IGMPv3 QQIC non linear value 160                              [FAIL]
    -         Wrong QQIC in sent tagged IGMPv3 general queries
    - TEST: MLDv2 QQIC non linear value 160                               [FAIL]
    -         Wrong QQIC in sent tagged MLDv2 general queries
    - TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
    - Vlan 10 mcast_query_response_interval (MRC) test cases:
    - TEST: IGMPv3 MRC linear value 60                                    [ OK ]
    - TEST: IGMPv3 MRC non linear value 160                               [FAIL]
    -         Wrong MRC in sent tagged IGMPv3 general queries
    - TEST: MLDv2 MRC linear value 30000                                  [ OK ]
    - TEST: MLDv2 MRC non linear value 60000                              [FAIL]
    -         Wrong MRC in sent tagged MLDv2 general queries
With these patchset, here is the result.
    * TEST: Vlan multicast snooping enable                                [ OK ]
    * TEST: Vlan mcast_query_interval global option default value         [ OK ]
    * Vlan 10 mcast_query_interval (QQIC) test cases:
    * TEST: Number of tagged IGMPv2 general query                         [ OK ]
    * TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
    * TEST: MLDv2 QQIC linear value 60                                    [ OK ]
    * TEST: IGMPv3 QQIC non linear value 160                              [ OK ]
    * TEST: MLDv2 QQIC non linear value 160                               [ OK ]
    * TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
    * Vlan 10 mcast_query_response_interval (MRC) test cases:
    * TEST: IGMPv3 MRC linear value 60                                    [ OK ]
    * TEST: IGMPv3 MRC non linear value 160                               [ OK ]
    * TEST: MLDv2 MRC linear value 30000                                  [ OK ]
    * TEST: MLDv2 MRC non linear value 60000                              [ OK ]

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
  selftests: net: bridge: add tests for MRC and QQIC validation

 include/linux/igmp.h                          | 171 +++++++++++++++-
 include/net/mld.h                             | 190 +++++++++++++++++-
 net/bridge/br_multicast.c                     |  22 +-
 net/ipv4/igmp.c                               |   6 +-
 net/ipv6/mcast.c                              |  19 +-
 .../selftests/net/forwarding/.gitignore       |   2 +
 .../testing/selftests/net/forwarding/Makefile |  10 +
 .../net/forwarding/bridge_vlan_mcast.sh       | 157 ++++++++++++++-
 .../selftests/net/forwarding/mc_decode.c      |  73 +++++++
 .../selftests/net/forwarding/mc_encode.c      |  78 +++++++
 10 files changed, 675 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/net/forwarding/mc_decode.c
 create mode 100644 tools/testing/selftests/net/forwarding/mc_encode.c


base-commit: 8b0e64d6c9e7feec5ba5643b4fa8b7fd54464778
-- 
2.43.0

