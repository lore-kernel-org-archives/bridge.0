Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CD0259C82
	for <bridge@lists.linux.dev>; Sat,  2 May 2026 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777727998; cv=none; b=NAMBu2d5B88EXZDyeov7sQzf64Q+YzcSOXCjdg7+aoeEe1dKRTPDewY9sVrE3HQvMbVt/5RG2vizXLRX0gM5ZW96SOAUBXBlf6E2SG1WoqsTVmYEEa1hlGJlRw+vvzIsIBqEE02nj/f3Qyl7rdeBOKPs9ESBcr4YTPUgk4jArds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777727998; c=relaxed/simple;
	bh=lxcyWp12IdlZXXKd8Ugl4on7xBBXleJuqVt+0M1OoPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWXE/u47HEcX0saJPzAvYuNh/CvL0dW6+F7+eLN3YJbGDTFRutSoW87ZlTIG4dZER6vbOChvx53FCbXVSLWNI7oEt/o4YH3DD5NU5NMZ+c/253nO8+2poYzpXrtwq+Gu0NDC8b7+RtE+maf0M21RomfPCVAKMloPf3krI+gdh5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9SNX6Yi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9SNX6Yi"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-83538fbd0b2so67758b3a.0
        for <bridge@lists.linux.dev>; Sat, 02 May 2026 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777727996; x=1778332796; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gfGrYQ7AWXi3RXTSR0Z1BGRv06bnLTOB4wH+tsRKV8=;
        b=M9SNX6Yim3hKar0KmvV3E/h3e6KLvWm5VClj6p0i7TkFO7gkxQxMjsV8c9KIApKRh2
         YOi0+SppZT5KpOxpsRk3x54+ZI79CdopLLyZ2mOnNM6cHxctcj/JuPa8j8t/RB5pjnXs
         76rT7jxy32HvbVtZvojDXaD8L0Ce/OPmcHX+c0+EvmvxsgSXMLth3Tkvk5OkG7Lnlgzl
         7QkDPwetQLSw5u3kyDAd0kz4VlZ7dvkNM86ZSEPsn4gJl0UOPmU4fTwvtA9JE634YhCa
         DRLkES7GmssY0hB9NtkFNg5i7TtTNw+Ac47MQN8lBFUWJMaGTAgaTTsjjh+mGnyaXkl8
         WxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777727996; x=1778332796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gfGrYQ7AWXi3RXTSR0Z1BGRv06bnLTOB4wH+tsRKV8=;
        b=X7xm4mdEZ5Ti6X5+8UWbmS0+p+5ciFN+ALuQfVT992TZEHvxpKrdxFZ3rvdD1pJ3Lq
         dtqPbykf2SIZF1KbYbCqb1bcV/bsW5+QPiwXT/gS2EESEOh1oQAJNDNGGpAsNBrU8u6y
         7PxpQE/5rOf073PJKNagZw5DsloXdSv5MIVciBdVYREAvemoHRmllW8O15S1V0zcYEMp
         TgSmUszJ89KpLzga8i0i9YYeIkMEGrosghLECGK24P8RoorAzEjL7LCwSiGuw449DT5k
         5LSHZ0cXxESUnbXdfa16U2IS6QIQ0CiBiNVdowx8AV4/iuproyg0Jk5WkLnycnhsQc7/
         aukA==
X-Forwarded-Encrypted: i=1; AFNElJ9KJdz51nUEpwNeVk88uvu+6+wN/1Zg984vZRRoC6RX8zcJjnxkDZdr15Tn+BYERf3Ov5jx5gU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyv1dOvCBodma8vWPqIqTeiBdckBU5Msb8hZU5dmdiIiQFdEaRA
	N982/H3VRg+LKdXjLm1+bTaakupwyLR9VcASxvu5is3eeVeMVSYMpMvQ
X-Gm-Gg: AeBDieuDznCnBs4Qy35rtxc9dzebhdjRpb22WGpuCUSi6pO4nhKHgwrt0G4ORdGWHen
	ylybBUx8JCpgABfePuIt52ZojRzGf2Fcnzj9+qPF4OdMIUVRnZBRFnJwZkhX9q48pAcSO4WZatY
	ngPWaXDcoHcB30jRw+8t8nLm53voyY92W0Zpvg8dLd14MOfJo0cWlCrByhXKmNMNc2LH7mt0yoV
	OKCo4Ejf0lhoypWQfYYe01e+7wtYRuxCl9jovEEDWFnaPAzh2XX5W+AxdGz3TtJjRkdogRWoc6J
	YcFwC8Mb7PAmDyEpYJtH7AImKkYcEQVgBYbIRHUdos7dk/1YbI30heDjHeK5wJsIDiHqsIU6Uci
	2Q1dR4RVlMgFYcsMUDtm5hBI0PxQcGui6F51nkxWCtqtw9DD++zQejWPwr+smR9N7weV878JiGg
	hc2GVPysqggGvrrnPg2uLukqtvhAoU/lVtiRew2SqmA1JdBk8HZ0J9BG6tFNhu
X-Received: by 2002:a05:6a00:aa8c:b0:82c:6bcc:f3fa with SMTP id d2e1a72fcca58-8352d2b58c1mr2888895b3a.35.1777727996093;
        Sat, 02 May 2026 06:19:56 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0176sm5553791b3a.39.2026.05.02.06.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 06:19:55 -0700 (PDT)
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
Subject: [PATCH net-next v6 5/5] selftests: net: bridge: add MRC and QQIC field encoding tests
Date: Sat,  2 May 2026 13:19:06 +0000
Message-ID: <20260502131907.987-6-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260502131907.987-1-royujjal@gmail.com>
References: <20260502131907.987-1-royujjal@gmail.com>
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

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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

