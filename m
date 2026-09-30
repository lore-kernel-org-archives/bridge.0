Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322F449EB8
	for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752495; cv=none; b=F0Y1OrwislCDww0LLZwRuvF8f8M/Y9KWYmb36QKEVUv0fHRAWDrTmX738cXNZr0cbr0BAHnWPB4eNdWTsI38x4ML626EeAq8SY0CV+1FHdvjuke0ltrylRNS0dDh6W5OrkqsixxIXhogknZMdvtY+v5oWmRZVYgo5gDxpMANPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752495; c=relaxed/simple;
	bh=r4WBstP8E1wpz6/uG5wDcPqY6nEpJ2c97HTH1sCETKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9KbRKiQPjBQ+/p3TUw/Jziaf4cSDGSaipyPhmnlAEXjhwCqr1+SF1gFTt4ZRbQu3MY+0mhYKX7UZJVEgN8wgTz+ar87bhhbunc4IkD8eaLR8IHfyz1HL/QmNoGpwYWLXg+cfjmXFLnktO0ghfFWxNeB+O4zcSR4rTw894srQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=iJi/7xNZ; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="iJi/7xNZ"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48afe3b2383so406195f8f.1
        for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752491; x=1791357291; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8k3N5NCfHWljQVwTPRV950V+62uw1NSwz7X6rrxFOfs=;
        b=iJi/7xNZv3/VlbdiUNjugJoWryoAeA9DuX6/9xhZ54AoLBNFVmd17uDk4oczfULY2w
         ifLqng/wYsFD6dafbd6J1c8GTPrpayJXA+dGAoASZT8dnlakuO55vpZ0Ouc9zPF89NPi
         OvmGqsywSeHnQYkInyOGE4XwOoj9lreJmGqJTA9srOjBI2Hw+yifngVoFT+dySQMvJcZ
         nW9T2Zw13KNNWULHdgTqq0JS+yhTTux4ZbfNcNJbhgTO0SrU34HMmteUka4EmzDep6vZ
         Gu8dqNfW1qleGTrkwMdbqKdDqrOo2Kd6cvS7lxpzTnZefSOkjyaPSybZGvKmyY6IZqlB
         U84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752491; x=1791357291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8k3N5NCfHWljQVwTPRV950V+62uw1NSwz7X6rrxFOfs=;
        b=dcUhhIeXTIyO/An5Dj+RFDUvZMHpP83fQqVICzqcQ94Y0FrYb2geE0nkx7p3QK9Boe
         1x8Dk6mHoZF+QuXCfIF9Em7tmD2juyWannEOi5EIN/SkfdBQdzZRy6H2znU5YY5cqUZJ
         7oHy5TXL1PbXVtvdsVKFaVNNFvd21GEe1pRR7JL9SqsnRTQbn5I0kazc2YV7KBxHwhj7
         dg/R9Q76itjSPvnHd4jds0tcjiM8oxAuKx+Dxc61pe7/tX+H9NFp3jVXVSbQXodLeBaj
         qPK2caA22BRbXdMi/xVwaOlr5G8Whfnyef8ErTjD35UEJ7368ytn4lTbqo/OGOzY589P
         PiMA==
X-Forwarded-Encrypted: i=1; AKwUvBwennge3BxLed/waJ8W56/GYafV3v62HdYY6E14FQT8brNwiE91Pc1yg4yHvBPuALoZBCLNT6U=@lists.linux.dev
X-Gm-Message-State: AFuF++m/3AsEQlHDXSjg87czlNldSYfxFeBVFWcAZIUyMOqqZ8R4Y7V4
	0SayRLe6oIH7o/5A5Qq1S0TT+zNNuJH9QNErEq0+Y9wd6f2u3SK7LtM1xk5Tks/vRi4=
X-Gm-Gg: AYBFou3e4fpC6Vfd1oGIr1a1/wZviV1/Ct4+xAVcWQ82JL75MHy0Mb7+lhWa5HUJuxL
	NPN2PbAJaUI4x5MiUSCzxZ/CbqiDD9AjYxvWFDvxOlIO70rejl/GzxuEuedbxAqkdWuVPDM2UMl
	kO2FF+0nJVAZzGSd6R+hXADGvKA8GcpBCP3uow9PULSQB6646o8PpOIGHg7uA/khsbHKzFnzH8O
	vSNeIBUo9KtNpwZ+NVuQ2F4ndwXs/RN2wsTTHTfAqyrdUCmNe+1aT5OMB/7VDkKbycepPAiaST3
	9dmqg+Z1J13MfZFtVdmrzcxtuqcfx1aFlwGtqAlQ8VqIGynpCNBQlc6yKvWjzEQx5q5l2ThgTjN
	BfIz/qZHPuAik6ihnx66cz2Lg95X5L0uhcKIrwXZRtZFzj+GUooaI+3gfrF5tVpcWDF/RLDVUCN
	ZIUzAbPRnpxSi74I39H0V7m4XGJEIbBKX7zXMv21v2yXlVZhSy9w2m+KQQzvqetVei1ooas8MW4
	OAGwOlwbkLrKpIR4z8N
X-Received: by 2002:a05:600c:1d0d:b0:4a0:151e:f743 with SMTP id 5b1f17b1804b1-4a01b00fba0mr5657535e9.19.1790752491395;
        Wed, 30 Sep 2026 00:14:51 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a0175025b5sm17893405e9.0.2026.09.30.00.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:14:50 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 00/12] net: bridge: vlan: optimize standard fdb fwding path
Date: Wed, 30 Sep 2026 10:13:59 +0300
Message-ID: <20260930071411.2786201-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
This patch-set is a follow-up after the bridge flood fwding path
optimizations and applies the same idea to the standard fdb fwding path.
We are able to remove 2 vlan hash lookups in the standard fdb fwding
path by caching the port-VLAN pointer in the fdb, to do that we switch the
fdb dst to an opaque type that can be either a port pointer or vlan pointer
differentiated by a bit. The field is a struct and also has a __private tag
so we can catch direct users, it should be used only via the helpers.
Sharing a field makes it easier to pass it around and also allows us to
save struct space for the fast-path. Interesting case is when an fdb is
promoted from a raw port to port-VLAN on the same port, it needs to be
handled carefully so we use cmpxchg to make sure we don't generate
deletion/replace notifications because it doesn't change the port.
I tested VLAN deletion after these changes (we now wait a grace period for
every delete) and the hit was ~20% reduction in deleted VLANs / sec
deleting 4k VLANs took 14ms more and on my VM the VLANs deleted / sec went
from 63k to 52k / sec. The complexity to batch them is not worth it.

Note again internal sashiko finds some pre-existing issues - I will take
care of those separately as usual.

Overall the improvement is +10% Mpps and -10% cycles spent in fdb fwding:
 64 byte vlan packets, 4k randomized fdb hits with 4k fdbs, 5 million
 packets passed 5 times for every case
     VIDs  Ports       Mpps                 Gbps             CPU1 cycles/input
                  before   after     gain    before  after   before  after  reduction
       64    8/2  2.375486 2.635811  11.0%   1.216   1.350   1724.6  1553.7    9.9%
       64    8/4  2.376731 2.636459  10.9%   1.217   1.350   1714.8  1554.7    9.3%
       64    8/8  2.376621 2.635783  10.9%   1.217   1.350   1722.6  1553.2    9.8%
       64   32/2  2.375876 2.637897  11.0%   1.216   1.351   1726.7  1552.3   10.1%
       64  32/16  2.376442 2.636426  10.9%   1.217   1.350   1721.3  1554.2    9.7%
       64  32/32  2.376763 2.636268  10.9%   1.217   1.350   1726.8  1553.5   10.0%
       64   64/2  2.375678 2.638707  11.1%   1.216   1.351   1725.0  1552.1   10.0%
       64  64/32  2.376681 2.637359  11.0%   1.217   1.350   1725.1  1555.9    9.8%
       64  64/64  2.376787 2.638396  11.0%   1.217   1.351   1722.8  1550.9   10.0%
     1024    8/2  2.263768 2.498881  10.4%   1.159   1.279   1808.5  1637.1    9.5%
     1024    8/4  2.264519 2.499075  10.4%   1.159   1.280   1807.6  1638.8    9.3%
     1024    8/8  2.263551 2.499231  10.4%   1.159   1.280   1812.0  1640.2    9.5%
     1024   32/2  2.263841 2.499120  10.4%   1.159   1.280   1806.8  1639.6    9.3%
     1024  32/16  2.263990 2.499562  10.4%   1.159   1.280   1806.1  1639.2    9.2%
     1024  32/32  2.263719 2.498905  10.4%   1.159   1.279   1807.7  1639.3    9.3%
     1024   64/2  2.263635 2.501889  10.5%   1.159   1.281   1809.4  1635.6    9.6%
     1024  64/32  2.264467 2.500359  10.4%   1.159   1.280   1806.5  1633.0    9.6%
     1024  64/64  2.240494 2.470246  10.3%   1.147   1.265   1810.0  1637.1    9.6%

This information has been also included in the commit that removes the
lookups.

Quick patch overview:
Patch 01 - adds the new opaque destination type with its basic helpers
Patch 02 - uses the new dsts for standard port fdb destinations
Patch 03 - adds port-VLAN pointer support to the destination type
Patch 04 - changes ingress helpers so we can get rid of the vid argument
           and pass a vlan pointer around
Patch 05 - passes VLAN pointers instead of vid to br_fdb_update
Patch 06 - consolidates vlan fdb cleanups, that will allow us to clean
           entries in one pass later on
Patch 07 - splits vlan unpublishing from hash and flood array from deletion
           that will be needed to optimize bulk deletes and flushes
Patch 08 - makes sure that readers cannot publish the vlan dst before
           cleaning up all fdbs that use it
Patch 09 - factors out the fdb update path to prepare it for port-VLAN dsts
Patch 10 - the first port-VLAN publishing, fdbs can now have port-VLAN dsts
Patch 11 - port-VLAN dst publishing for configured entries
Patch 12 - remove 2 vlan hash lookups in fdb fwding fast-path

For sashiko:
 [Severity: High]
 Could nbp_vlan_delete() in net/bridge/br_vlan.c avoid waiting for a network
 RCU grace period once per VLAN while RTNL is held?

 Nik: Yes, it could but the complexity this brings is not worth it.
      See above.

 [Severity: High]
 Could this synchronize_net() in
 net/bridge/br_vlan.c:nbp_vlan_delete() be batched by its callers?

 Nik: Yes, it could but again same thing - it is not worth the complexity
      and deleting VLANs is still fast enough.

Thanks,
 Nik


Nikolay Aleksandrov (12):
  net: bridge: introduce a bridge destination type
  net: bridge: use net_bridge_dst for fdb destinations
  net: bridge: add VLAN support to bridge destinations
  net: bridge: vlan: return VLAN entries from ingress helpers
  net: bridge: fdb: pass VLAN entries to learning updates
  net: bridge: fdb: consolidate port-VLAN cleanup
  net: bridge: vlan: split unpublishing from deletion
  net: bridge: vlan: quiesce readers before freeing port VLANs
  net: bridge: fdb: factor out existing entry updates
  net: bridge: fdb: cache port VLANs in learned entries
  net: bridge: fdb: cache VLAN destinations in configured entries
  net: bridge: fdb: avoid VLAN lookups in unicast forwarding

 include/trace/events/bridge.h            |   7 +-
 net/bridge/br.c                          |   2 +-
 net/bridge/br_arp_nd_proxy.c             |   4 +-
 net/bridge/br_device.c                   |   9 +-
 net/bridge/br_fdb.c                      | 270 +++++++++++++++--------
 net/bridge/br_forward.c                  |  24 +-
 net/bridge/br_if.c                       |  13 +-
 net/bridge/br_input.c                    |  26 ++-
 net/bridge/br_mrp.c                      |   6 +-
 net/bridge/br_netlink.c                  |   2 +-
 net/bridge/br_private.h                  | 157 ++++++++++++-
 net/bridge/br_stp_if.c                   |   2 +-
 net/bridge/br_switchdev.c                |   2 +-
 net/bridge/br_sysfs_if.c                 |   3 +-
 net/bridge/br_vlan.c                     | 107 +++++----
 net/bridge/netfilter/nft_reject_bridge.c |   8 +-
 16 files changed, 448 insertions(+), 194 deletions(-)

-- 
2.47.3

