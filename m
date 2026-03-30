Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6086396D13
	for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898189; cv=none; b=Ep5AIud1KD9b6ipjRsGlCJXCOkiJhcvYxallIuhvCM4CaJ52yeYSBR4kXMUgsASAkrZWXUuN/aEQKjx1dF3R4ifvqwOz+7Ie54tJU5PK1VTs2qntNBCGenCZlaGCRAHl85t6aVWWlQMV2n82OU5QiquPTXEgTGhk6Hx85VVQnWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898189; c=relaxed/simple;
	bh=BOuU4kLSFj0T3OadxVFJ/Pv96MAovOPfw0gN6reRqiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9yj2dElExq8+j1nm39r/T8DVmHrUzwEn9YkJvWg/hb0BzT5Qgt+nY6oX455WAC+6biN9XdlhP5nHK4sddT49DuZrNOrJf+ld/5rav3qxLzUkMZa4HyW3gOv9/xGAKk/iDuIv6dPVdVccXrnKS/cYpCmIDSZKqfO3HMwNahzRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uny1fBGm; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uny1fBGm"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35c124d2613so3184916a91.2
        for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 12:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774898187; x=1775502987; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaNyh4ecr42g5LIJwYY728KlnH3gHzvSwNNrUVP18Jg=;
        b=Uny1fBGmytO6mrakgN8E8Luv7G8WsuYCdqUX+ZMcct0kMXkHl3uMTT7Eeou52kBB7H
         JnvJj8eLJQUxXcdTGVedymtqjvspVpKDKfXJtIVxq5mtf9btAC3cSSoQi52DELz1Grs0
         AmvZ7lqKobS72If4AyDCRT3LhfJU0NTrXyAjbz7/G1AbMJMfnfcolFVRrlkQQsTxJ5bZ
         rID6JYPC5xGdPj7XRGqZYAPCUPV9JZSsYBNpNA6dDBL/wuU75ARCbTXhXi/iLHhjRLEk
         MohiLNtofktp1AXf02wOIl2jjIzUPfBa1ZOp0byqBoiU939vRnFAre7bIltdRpwqXm/m
         yx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774898187; x=1775502987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PaNyh4ecr42g5LIJwYY728KlnH3gHzvSwNNrUVP18Jg=;
        b=h40I8UhZUvWtNnB7dX5+bxxpI4wt/U+QUlRdyLkQ/dwHI0WCJRJxAZclmZdi9EfYPU
         cZKjaheQhDKOvlMNAo85dn5YvHjS78WikJ2SgE8LqiwDReHJfcIqIajI2ujFvwLQoeGR
         YC33PQA1nD9Lw26j/QUP7FAloTcxv2qufwjYzykC7jgwk5fdL3ZLsUdGN3aU4HiX70M0
         vJywuOG00+NL1Y0G6sTkjJkmt1doxkLnr69E0IeUtIfPptaKeSI4WpizoUCZSy3j1ygZ
         BB6Mk8MWaTzKvp/4w4u9Oa2z9nrUUe4UOaANocuPOzJ7xy3TElAZxdGFv1kcA9XUCFbr
         btbA==
X-Forwarded-Encrypted: i=1; AJvYcCWcZYlV4KObVWqq0tm9HN1n5/+AXj5NDvo2HLyz2KjFIdKaGerYxFcSs8l8nOHEmYXvRXsAuZk=@lists.linux.dev
X-Gm-Message-State: AOJu0YzACJODe6yVqzlTbjlS5ItboiI6vMaHHy2FV2eqb8v5bs+kh7zM
	7yU9fhG58Ild5WFy8ueerqZJucw8fxQfQz2MB4NeiZyzmaRAwLqmkRRP
X-Gm-Gg: ATEYQzxqB+5oo32NFB9ldOabtPFdElF2n6zD9tG8KY98KjdVRK6JKUaZu3+rqPoJ6E7
	x5YYTtNgn1zfH9Q3SM1Kn1+iqjT9gsl2aV5BbYUVudz6KT9Ya3O+/2c/4TXVKTqGLGHBvK3mhp9
	79r/ktTJE7/EXdCJIqbnVHqoGf1IRtVMkhGx5KMs7M8olUixSnF5hHV+JsiIFQ5bS+DS/IJeRDF
	AgHie+XhRYAoVO2EF6VVrE2I4TJL3UqNX9Wm3O71juSrqice/7o9onAXLpXGWJvK71k9P90afBG
	waVLOV6JIfNvLQZp9gV36GpneCAv7ZBzUrwHIoTGSnaCtrIo937UKzaTL0F7WRa4SIQ556i9PFC
	U4elKW7YQJ2n0FpbATeT+iWBU+JpDMl2I4WSftnV6asIP4lUrvhI4CciTkxeNkVw/m+271FKW+s
	q3v/LfiK4SqnPVkXk7M2Obxo5d7AlhDNERKZHEvSs4
X-Received: by 2002:a17:90a:e70d:b0:35b:90e7:c453 with SMTP id 98e67ed59e1d1-35c2ffaf73emr12904875a91.6.1774898186798;
        Mon, 30 Mar 2026 12:16:26 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950d9b12sm9627178a91.17.2026.03.30.12.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:16:26 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/5] net: bridge: mcast: add multicast exponential field encoding
Date: Mon, 30 Mar 2026 19:16:06 +0000
Message-ID: <20260330191611.16929-1-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
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
  selftests: net: bridge: add tests for igmpv3 MRC and QQIC validation

 include/linux/igmp.h                          | 158 +++++++++++++++-
 include/net/mld.h                             | 179 +++++++++++++++++-
 net/bridge/br_multicast.c                     |  22 +--
 net/ipv4/igmp.c                               |   6 +-
 net/ipv6/mcast.c                              |  19 +-
 .../selftests/net/forwarding/.gitignore       |   2 +
 .../testing/selftests/net/forwarding/Makefile |  10 +
 .../selftests/net/forwarding/bridge_igmp.sh   | 109 +++++++++++
 .../selftests/net/forwarding/mc_decode.c      |  38 ++++
 .../selftests/net/forwarding/mc_encode.c      |  40 ++++
 10 files changed, 535 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/net/forwarding/mc_decode.c
 create mode 100644 tools/testing/selftests/net/forwarding/mc_encode.c


base-commit: cf0d9080c6f795bc6be08babbffa29b62c06e9b0
-- 
2.43.0

