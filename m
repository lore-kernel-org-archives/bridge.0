Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD83DD87B
	for <bridge@lists.linux.dev>; Sun, 20 Sep 2026 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789902570; cv=none; b=kuta4fx/CX6GUfIy9KhkYeex9D7K2g2tBq+d+CSbBJgBXg64s+RkEgOOJTefMrXGBT0lP76+Owbo9tXdpV6vzisXxBg1s90b5IMZUciOlAb5EA9J9X3zNatxLcfeD8dLooNaowYd+AfQ028YmS4m3rWG7rkuiZxzpULUN53j8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789902570; c=relaxed/simple;
	bh=4E9blRxoQ+Mbf6v+LjIyEQhWnu1g7D/3yBtZLpQUJSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZsBPF7Hhp7HBRDQJfdWN8qFmFTv2VbYJSgvaXAaQERpGe5qS66+LDLq6PZXZv1m7N/HBbpMccJlscFzSF6stjWJ8eyt2Xqd2SC4IynjLiLOUQSQTf8sqU2HTh4IQtkMyzrk8Vwqb5S1ySAej0P0pN/jZ6Znhsv/iokBOjULjynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtdAXqCI; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtdAXqCI"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8674704dab1so3071479b3a.2
        for <bridge@lists.linux.dev>; Sun, 20 Sep 2026 04:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789902567; x=1790507367; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Ye5pnKqTEfaV7Vck0LFhJMVfU4j6jzeEid83vd2NXk=;
        b=DtdAXqCI+oR61stTwnj1UFMjbZOuhFng4s7bCnw50lChuknYqWtXZvGQtDd2An5lxX
         3Zrwe4Akb3Lr1Oxci8ghWuW+32PmMVfGsimTb4dhWo5860ql4uBAgEnUXXql1muTxJt2
         n4Ub13mdFm0euM8MeodbmVwRZ9/jiDHZkn0B15exv1st8hZTUf7QFkuTHp1bTF4Gf9Qd
         /8XYqnrLabb+JU0hMJttIDdx/RLbNVan3X5IP09QQlJBQiEcelT42tezTGVSF1Gr0ZXO
         VgVQqItZLYMEb8ZhBMuCmGTzbS5YXFf+qavYrVvHYZYzaT07B3j/csZbb8eSMdV3kL0n
         XWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789902567; x=1790507367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Ye5pnKqTEfaV7Vck0LFhJMVfU4j6jzeEid83vd2NXk=;
        b=beJHmzfCJMeZUM62GKVzeHHVLdyiZK/ukHz9oz5d/5kL/0xs3syN5kDqCTE0DZC6mH
         8vCyrHAX29bBwQiOfg/byXBSMHeFe/TEn17Y+6B8OHF7ynTv2O3oliRu8ZdtTMwXUDqj
         qqVl/XDO5qAH7MqkHBOxoQGYEkXaRrXBoPq6j9m9/y/to1/6nbeP4W0MZaUyY6Gt+oPS
         5CbT064Q+zB9Nc0Dgwm6wU4rv/2V8wuDpxlDHmGjQoHhlqy3QA/cjAENKL8ASNNPEe2d
         dQmlw5DyKvckubTBgXXS9LyRjaF27Vry1x16/MtfRU+e2pLVwvVlIiTTT/5Gz4D4LJRT
         gxcw==
X-Forwarded-Encrypted: i=1; AKwUvBxzvauAECPWMqoGyf6EJTc+nZXysgfrsJYO5ALi+CR1avnPMb2IG0nDh6GP9EHss954U/UjbTc=@lists.linux.dev
X-Gm-Message-State: AFuF++lG/G/fls/8nlmhaIKLUjdb3II8M/X5SmEL9N9wUACLga/7YIM6
	eumYtt2cBU7tY9gdpn5TpLm3Heqn75mFF106XRJOB7cZxoMTzw+63R+R
X-Gm-Gg: AYBFou2LvsGhHawkldTWY+jfmX+gwLYuafkNVbVh7neWp2BO7ys8Sia9u0ULrAS+OVe
	WEOdaVu81boc6xd/AW3dP3VIBo5tdDOHLTOkvgAAvP2SAJTLADboKZ/1/w0H9WngyYvoalCQVZa
	k6ebkO2vbnVhi+uiys39hyYoBrIH5UWqlc7agjUEknRjPJjZYxNqQp+KPaaQSpaov+3gw/sIPc9
	f6F4H9L1Qsxwuc3LYxT3LZz6PflPDL2thj4hjdsU2fjOS3i/r8r8dnm5zBksMRe5uAkZe3f0DOS
	cRCLMHta3S33WZVU32E729yh0me4+mQB4DCXMsL8139p/Bxud/m1iaWAGYU3T73bG17hJobua0+
	HAoLS1IZdxVlZxpCjmMVr+4Del8pp+8m+g6VdaBaZtDgDqnriVxPmD7tgHJSlMc9Cbtz6X7Wfzu
	AF8ydKwBxeCL2pDyfjZSflGjfdNF4iH9TCo3A+V6OEhzGMyAmT6xIVstW4/U5QzxsNEy+fFDjV9
	T9/
X-Received: by 2002:a05:6a00:4ac8:b0:874:708d:b63b with SMTP id d2e1a72fcca58-874dedfe00fmr11626090b3a.28.1789902567446;
        Sun, 20 Sep 2026 04:09:27 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9b0c55dsm1897536b3a.37.2026.09.20.04.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 04:09:27 -0700 (PDT)
From: Fourie Zhang <littleddfu@gmail.com>
X-Google-Original-From: Fourie Zhang <fouriezhang@tencent.com>
To: netdev@vger.kernel.org
Cc: TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	bridge@lists.linux.dev
Subject: [PATCH net] net: bridge: mdb: restart port group walk after deletion
Date: Sun, 20 Sep 2026 19:08:43 +0800
Message-ID: <20260920110852.60293-1-fouriezhang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_mdb_flush_pgs() keeps a pointer-to-pointer cursor while walking
mp->ports. br_multicast_del_pg() can re-enter the same MDB entry through
br_multicast_sg_del_exclude_ports() and unlink other port groups. If the
cursor points into one of those groups, the next iteration dereferences a
stale cursor and can leave mp->ports pointing at freed memory.

A following RTM_GETMDB exposes the dangling pointer:

  BUG: KASAN: slab-use-after-free in br_mdb_dump
  Read of size 8
    br_mdb_dump
    rtnl_mdb_dump
    rtnl_dumpit
    netlink_dump

Reset the cursor to mp->ports after every deletion. The deletion removes at
least the selected group, so the restarted walk always makes progress.

Fixes: a6acb535afb2 ("bridge: mdb: Add MDB bulk deletion support")
Cc: stable@vger.kernel.org
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
---
A reproducer for this issue is available if requested.

 net/bridge/br_mdb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index e0c7020b1..a01bd280c 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1523,6 +1523,8 @@ static void br_mdb_flush_pgs(struct net_bridge *br,
 		}
 
 		br_multicast_del_pg(mp, p, pp);
+		/* br_multicast_del_pg() can remove other groups from this list. */
+		pp = &mp->ports;
 	}
 }
 
-- 
2.43.7
