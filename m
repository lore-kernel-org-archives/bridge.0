Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14663313E00
	for <bridge@lists.linux.dev>; Fri,  1 May 2026 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656741; cv=none; b=Lw/f2oxSlhQ7Q35oPVZFhf0z70eCR3ceuhRi3K3DnfTJuVR9ib3bn2IJR12QiIoe8mXd8Wm7rpfRsmopuAbrWUJwKaOhiATNdzyi9XeknfnjyHfgdq0U7LRP+cmTTzsYfDcdkJW74/fR5yEx9N8xrKuNCgLdnLByeFHWkLsiCuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656741; c=relaxed/simple;
	bh=UNdRW3uKisT5Fvi5K3/wNmEi4x6RxXCvZYWzNG8kchQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mH7nhprbttZNDxLMFnPEcOUmJvzG/9JzcrvehtrrU6SxdL51N0iEMqv0XcNAOeNvafLte+RmorU4lLziWrgAvHua/cBM8clsNRXmx2wnH4PAO9+yhFUGTy15fCWKlKJfxUQ/R8MF3FRa25L7SlMejPp1w+46mmiZj8Z8R/pFvxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=or1qu/Xo; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="or1qu/Xo"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-364d72f2986so1344161a91.3
        for <bridge@lists.linux.dev>; Fri, 01 May 2026 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656739; x=1778261539; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzwTHkm3utnnP48DK2qyC96JgeUzR2iB5DEneSRP2HI=;
        b=or1qu/XoNJsuVMQFI0uWLeaYzplP2gjBxNDO+fRKSBH/Eebq6NNbZ9rOLkeGFqfn4C
         dGB6oJO73Vd0ZMX2IyYThQ2e4VeYtxAUd45xAw3uwDqdQOSHr0f5Cc5JKl+hzfIZBV0b
         ysQ1G6J8LXpdt2HNRAGU10XGpTFCa1Wg/Xj1zVTDzWYXPLAH+M1FfT2dFbCyB6wlyzwF
         ZP3LIQ8wLLo7e3jYPohCzTjOU9Z/XFulcmaiI3nUatpBaMQasE+SOJ/k0sOQFf2appbn
         L8wBY93zlym2BukCr2eQzhtxluF8j/X2uGcxZCwK6mjDwB2ZEbrDvceEssv/Ml6toT9r
         2Gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656739; x=1778261539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IzwTHkm3utnnP48DK2qyC96JgeUzR2iB5DEneSRP2HI=;
        b=PTDZZ2nl3o/ZFOJWvpk4+riLifGptKCIRNW2Lmd5xkITlKEB/EjSPMuqorjXa9/Qux
         lMsLSq4x2iZ821iWp/hIigeu2NJiFJIIUNgRsfXiuTeOVetYzma7Y8OuicL+4FrRVj7Q
         aCQZ3FJEEN+dAzGrT/CjgFx89Nds8fJvae/T0Bk0UUh7RbsC/JleDv3hej5hXK4N0GqO
         QGpRfz/+UtemNB8kn5zlqbvtNtOcSpS+yesXAl/FVNc/LYDeTGucImhTQA/i0l1IyyLw
         xMISPkwHtHa6o/8HGJuR2rmSzxTGfkpUwHddolkdTHV3EK6JBYllFfur/LtoxZf1LVzp
         +PFg==
X-Forwarded-Encrypted: i=1; AFNElJ/z5J9VlQcgniJIiWtMvrnI+WNgFpyxmrvFk27dJBKGiXU9kBTysb24NBMY3u/53IZlH/GQHzk=@lists.linux.dev
X-Gm-Message-State: AOJu0YwsV/NptZehIaISje+eBMZhOgWtFlyE2x++LYg8VnCVJDJJlq6Q
	aD8wAZ49YyN9xvzb2GbyMjELTpaCsgSmb63gUVeRqGmDsiBH6L5m1O6t
X-Gm-Gg: AeBDietxNZCTblePuTY8boTVjf9TeJTu9j0Xa5aJ05Jjt+Ba8HSW60xf+zeAY23xqcD
	f1yVRXzNeMIFMhZ3/e0zWSN99aT+EKblfOUMjTvrZT09WFs9XlxEEKds2sKvSlWfntPKHvHjAce
	g1pulPwBH5IHdL9wwqo890LRWgQU/wYn54d7nSqKXeGsqQJcnxmcK7m3p34jEqB4dFGsINDTtX0
	PeLRJE2XSb6ajwdXtmpjdKLbPasuT+iwIhTuvRPuBmubHw1NeVZfyN13xPit+Awr7+OPV75mzdC
	pG9PS3yaPRZ5FOc5s7ikiSzfszqs3PgP88sbJirw/2BQEQT00iKSkNAP/TSDgt+Ydr1F1ezZsTi
	1rLDKTd8bEGdA6S2P7yDpT40/IFEefb2nWxsAadeh0KNvQA+ecXLDL9qBmotsWWPSeGWtA3+Emx
	N/dZw9NG0d3Lr/1+7v9jPSgEgB28ccdBUVxQABcqLp5KUkWfYpMg==
X-Received: by 2002:a17:90b:278f:b0:35c:30a8:32a with SMTP id 98e67ed59e1d1-3650cdb8085mr166497a91.9.1777656739170;
        Fri, 01 May 2026 10:32:19 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm2908906a91.2.2026.05.01.10.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:32:18 -0700 (PDT)
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
Subject: [PATCH net-next v5 5/5] selftests: net: bridge: add MRC and QQIC field encoding tests
Date: Fri,  1 May 2026 17:31:29 +0000
Message-ID: <20260501173130.3486-6-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501173130.3486-1-royujjal@gmail.com>
References: <20260501173130.3486-1-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance vlmc_query_intvl_test and vlmc_query_response_intvl_test in
bridge_vlan_mcast.sh to validate IGMPv3/MLDv2 protocol compliance for
MRC and QQIC field encoding across both linear and exponential ranges.

TEST: Vlan multicast snooping enable                                [ OK ]
TEST: Vlan mcast_query_interval global option default value         [ OK ]
TEST: Number of tagged IGMPv2 general query                         [ OK ]
TEST: IGMPv3 QQIC linear value 60(s)                                [ OK ]
TEST: MLDv2 QQIC linear value 60(s)                                 [ OK ]
TEST: IGMPv3 QQIC non linear value 160(s)                           [ OK ]
TEST: MLDv2 QQIC non linear value 160(s)                            [ OK ]
TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
TEST: IGMPv3 MRC linear value of 60(x0.1s)                          [ OK ]
TEST: MLDv2 MRC linear value of 24000(ms)                           [ OK ]
TEST: IGMPv3 MRC non linear value of 240(x0.1s)                     [ OK ]
TEST: MLDv2 MRC non linear value of 48000(ms)                       [ OK ]

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 .../net/forwarding/bridge_vlan_mcast.sh       | 140 +++++++++++++++++-
 1 file changed, 132 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index e8031f68200a..07a377652a59 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -162,14 +162,27 @@ vlmc_query_cnt_setup()
 {
 	local type=$1
 	local dev=$2
+	local match=($3)
 
 	if [[ $type == "igmp" ]]; then
-		tc filter add dev $dev egress pref 10 prot 802.1Q \
+		# This matches: IP Protocol 2 (IGMP)
+		tc filter add dev "$dev" egress pref 10 prot 802.1Q \
 			flower vlan_id 10 vlan_ethtype ipv4 dst_ip 224.0.0.1 ip_proto 2 \
+			action goto chain 1
+		# AND Type 0x11 (Query) at offset 0 of IGMP header
+		# 20 bytes IPv4 header + 4 bytes Router Alert option + IGMP[offset 0]
+		tc filter add dev "$dev" egress pref 20 chain 1 prot 802.1Q u32 \
+			match u8 0x11 0xff at 24 "${match[@]}" \
 			action pass
 	else
-		tc filter add dev $dev egress pref 10 prot 802.1Q \
+		# This matches: ICMPv6
+		tc filter add dev "$dev" egress pref 10 prot 802.1Q \
 			flower vlan_id 10 vlan_ethtype ipv6 dst_ip ff02::1 ip_proto icmpv6 \
+			action goto chain 1
+		# AND Type 0x82 (Query) at offset 0 of MLD header
+		# 40 bytes IPv6 header + 8 bytes Hop-by-hop option + MLD[offset 0]
+		tc filter add dev "$dev" egress pref 20 chain 1 prot 802.1Q u32 \
+			match u8 0x82 0xff at 48 "${match[@]}" \
 			action pass
 	fi
 
@@ -181,7 +194,39 @@ vlmc_query_cnt_cleanup()
 	local dev=$1
 
 	ip link set dev br0 type bridge mcast_stats_enabled 0
-	tc filter del dev $dev egress pref 10
+	tc filter del dev "$dev" egress pref 20 chain 1
+	tc filter del dev "$dev" egress pref 10
+}
+
+vlmc_query_get_intvl_match()
+{
+	local type=$1
+	local version=$2
+	local test=$3
+	local enc_val=$4
+
+	if [ "$test" = "qqic" ]; then
+		# QQIC is 8-bit floating point encoding for IGMPv3 and MLDv2
+		if [ "${type}v${version}" = "igmpv3" ]; then
+			# QQIC is at offset 9 of IGMP header
+			# 20 bytes IPv4 header + 4 bytes Router Alert option + IGMP[offset 9]
+			echo "match u8 $enc_val 0xff at 33"
+		elif [ "${type}v${version}" = "mldv2" ]; then
+			# QQIC is at offset 25 of MLD header
+			# 40 bytes IPv6 header + 8 bytes Hop-by-hop option + MLD[offset 25]
+			echo "match u8 $enc_val 0xff at 73"
+		fi
+	elif [ "$test" = "mrc" ]; then
+		if [ "${type}v${version}" = "igmpv3" ]; then
+			# MRC is 8-bit floating point encoding at offset 1 of IGMP header
+			# 20 bytes IPv4 header + 4 bytes Router Alert option + IGMP[offset 1]
+			echo "match u8 $enc_val 0xff at 25"
+		elif [ "${type}v${version}" = "mldv2" ]; then
+			# MRC is 16-bit floating point encoding at offset 4 of MLD header
+			# 40 bytes IPv6 header + 8 bytes Hop-by-hop option + MLD[offset 4]
+			echo "match u16 $enc_val 0xffff at 52"
+		fi
+	fi
 }
 
 vlmc_check_query()
@@ -191,9 +236,13 @@ vlmc_check_query()
 	local dev=$3
 	local expect=$4
 	local time=$5
+	local test=$6
+	local enc_val=$7
+	local intvl_match=""
 	local ret=0
 
-	vlmc_query_cnt_setup $type $dev
+	intvl_match="$(vlmc_query_get_intvl_match "$type" "$version" "$test" "$enc_val")"
+	vlmc_query_cnt_setup "$type" "$dev" "$intvl_match"
 
 	local pre_tx_xstats=$(vlmc_query_cnt_xstats $type $version $dev)
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_querier 1
@@ -201,7 +250,7 @@ vlmc_check_query()
 	if [[ $ret -eq 0 ]]; then
 		sleep $time
 
-		local tcstats=$(tc_rule_stats_get $dev 10 egress)
+		local tcstats=$(tc_rule_stats_get "$dev" 20 egress)
 		local post_tx_xstats=$(vlmc_query_cnt_xstats $type $version $dev)
 
 		if [[ $tcstats != $expect || \
@@ -448,8 +497,46 @@ vlmc_query_intvl_test()
 	# 1 is sent immediately, then 2 more in the next 5 seconds
 	vlmc_check_query igmp 2 $swp1 3 5
 	check_err $? "Wrong number of tagged IGMPv2 general queries sent"
-	log_test "Vlan 10 mcast_query_interval option changed to 200"
+	log_test "Number of tagged IGMPv2 general query"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 3
+	check_err $? "Could not set mcast_igmp_version in vlan 10"
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 2
+	check_err $? "Could not set mcast_mld_version in vlan 10"
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 6000
+	check_err $? "Could not set mcast_query_interval in vlan 10"
+	# 1 is sent immediately, IGMPv3 QQIC should match with linear value 60 (0x3c)
+	# which is 8-bit encoded value of 60 [units of seconds]
+	vlmc_check_query igmp 3 $swp1 1 1 qqic 0x3c
+	check_err $? "Wrong QQIC in generated IGMPv3 general queries"
+	log_test "IGMPv3 QQIC linear value 60(s)"
+
+	RET=0
+	# 1 is sent immediately, MLDv2 QQIC should match with linear value 60 (0x3c)
+	# which is 8-bit encoded value of 60 [units of seconds]
+	vlmc_check_query mld 2 $swp1 1 1 qqic 0x3c
+	check_err $? "Wrong QQIC in generated MLDv2 general queries"
+	log_test "MLDv2 QQIC linear value 60(s)"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 16000
+	check_err $? "Could not set mcast_query_interval in vlan 10"
+	# 1 is sent immediately, IGMPv3 QQIC should match with non linear value 132 (0x84)
+	# which is 8-bit encoded value of 160 [units of seconds]
+	vlmc_check_query igmp 3 $swp1 1 1 qqic 0x84
+	check_err $? "Wrong QQIC in generated IGMPv3 general queries"
+	log_test "IGMPv3 QQIC non linear value 160(s)"
 
+	RET=0
+	# 1 is sent immediately, MLDv2 QQIC should match with non linear value 132 (0x84)
+	# which is 8-bit encoded value of 160 [units of seconds]
+	vlmc_check_query mld 2 $swp1 1 1 qqic 0x84
+	check_err $? "Wrong QQIC in generated MLDv2 general queries"
+	log_test "MLDv2 QQIC non linear value 160(s)"
+
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 2
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 1
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 2
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 12500
 }
@@ -469,10 +556,47 @@ vlmc_query_response_intvl_test()
 	log_test "Vlan mcast_query_response_interval global option default value"
 
 	RET=0
-	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 200
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 3
+	check_err $? "Could not set mcast_igmp_version in vlan 10"
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 2
+	check_err $? "Could not set mcast_mld_version in vlan 10"
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 600
+	check_err $? "Could not set mcast_query_response_interval in vlan 10"
+	# 1 is sent immediately, IGMPv3 MRC should match with linear value 60 (0x3c)
+	# which is 8-bit encoded value of 60 [units of 0.1s = 6 seconds]
+	vlmc_check_query igmp 3 $swp1 1 1 mrc 0x3c
+	check_err $? "Wrong MRC in generated IGMPv3 general queries"
+	log_test "IGMPv3 MRC linear value of 60(x0.1s)"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 2400
+	check_err $? "Could not set mcast_query_response_interval in vlan 10"
+	# 1 is sent immediately, MLDv2 MRC should match with linear value 0x5dc0 (24000)
+	# which is 16-bit encoded value of 24000 [units of ms / 24 seconds]
+	vlmc_check_query mld 2 $swp1 1 1 mrc 0x5dc0
+	check_err $? "Wrong MRC in generated MLDv2 general queries"
+	log_test "MLDv2 MRC linear value of 24000(ms)"
+
+	RET=0
+	# 1 is sent immediately, IGMPv3 MRC should match with non linear value 142 (0x8e)
+	# which is 8-bit encoded value of 240 [units of 0.1s = 24 seconds]
+	vlmc_check_query igmp 3 $swp1 1 1 mrc 0x8e
+	check_err $? "Wrong MRC in generated IGMPv3 general queries"
+	log_test "IGMPv3 MRC non linear value of 240(x0.1s)"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 4800
 	check_err $? "Could not set mcast_query_response_interval in vlan 10"
-	log_test "Vlan 10 mcast_query_response_interval option changed to 200"
+	# 1 is sent immediately, MLDv2 MRC should match with non linear value 0x8770 (34672)
+	# which is 16-bit encoded value of 48000 [units of ms / 48 seconds]
+	vlmc_check_query mld 2 $swp1 1 1 mrc 0x8770
+	check_err $? "Wrong MRC in generated MLDv2 general queries"
+	log_test "MLDv2 MRC non linear value of 48000(ms)"
 
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 2
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 1
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 2
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 1000
 }
 
-- 
2.43.0

