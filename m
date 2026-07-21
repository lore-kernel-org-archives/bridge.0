Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD138B7D9
	for <bridge@lists.linux.dev>; Tue, 21 Jul 2026 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642972; cv=none; b=CETwbfiIiEtxngW48azGdZpv+1cSZizOS6+FSgzCaepSbzSOjI5Mbjy6WISgpNAJray8ZOOnFeQXohdiGE/LZ+u5z/9H31BfA4BuMaOE9T1bJWOtVrjmgVLzXRf/L74MYoV9DxFCvau4SBFXBStIS99NXHpIQxzAvR8XPy/8XLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642972; c=relaxed/simple;
	bh=Sy2dQIDfTn0vvrCxCW0E3gAUSF0oXL12B/CyzEPp41Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtpU6zRwrDUsMXM79yTPM2e/GzIYiCzJGEwVQATtSmbK2W3WoRmpJINMHyAuMahhoiHNDA2/eSer40DTtYFEvwUe8ykl8yV8ak0c/+hPd5xzwassVWM53QAUYDzFksq/V+Odc+zVTJKPJgwUXZcLM8lV+N4zH7OgL82jRvMQYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=aGWdfk0S; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="aGWdfk0S"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-495635a85d2so15051955e9.0
        for <bridge@lists.linux.dev>; Tue, 21 Jul 2026 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784642969; x=1785247769; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UfL6iUrlxMqA1SULmpcqd51oivcgiX3MCBlh/k4Gk/k=;
        b=aGWdfk0S8iTW8LlWkzBwrsdEVgkEIb1mhflcZvW2oxJHK9NMqZpdI/5eStEOFZoYqB
         liyeVDc1M55YjbnOkunkSHgXmyj9RFNIRq4huRpm3VX0oFU0fCvCGP5EUAWdcsYq5yLR
         2FfPeBahDQWzUSiYPjVhTetNl5Z/+rvTeViujqyKvkv/+ZKcQjfoR5IkNbLFb1RqD//6
         jnhos8mTN8rsYQcqi4mcm8J9VRmuYr86m87WR42rbbmLOSfluFAOv7hlm1ayHd3TeEMZ
         IOyu0MpjJLki+I43z3BDk3U+tRQb04sXjeMqL1CW4F7U1GV/o3SAJXZr2SEtnNPGZUNC
         7UwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642969; x=1785247769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UfL6iUrlxMqA1SULmpcqd51oivcgiX3MCBlh/k4Gk/k=;
        b=se3P6h2l6VLJ7pe79tNGA2Bb50MERdsCqeXKn14izqPjTuLrTI3F3yQu2A1Z83RjPV
         o0Ml4d8mNKmSJoMH45lBS7bHt8LunD7lsjQu7WQszUb7bLJ+lS9nXhQc24y3TaBqZ+lU
         VwMstQjlcipf0UnNet1NLgga2LwxaizSIyWiJKghU4jWPS73kmo/lcO4cTL3dwXR0A1n
         6BOp525pS3vKQWkQjlKjL38Wrt+X5vTOQHIIQfXlFOXo7Iw1WgXfA12mkh1pxXM+BJ4j
         0zm+xbXpb0iZnXujOL+trkjKxuFm88VbStK77PGau/Avs8epMiLpeZs3e0SoznzCmPc0
         la5g==
X-Forwarded-Encrypted: i=1; AHgh+Rp05Cz4Nb2DHsMZhkcp8OHyFay/nBaxEcR9SDxuEa9gokB6eVaE04cOSaXit1RKJ4DXE/QT35Q=@lists.linux.dev
X-Gm-Message-State: AOJu0YwXISJqlVsCtju+82ib1fyLPIr4edAMeYmBYc6usSq9s2xjCC0Z
	hBAbeOEiHJaiyG0fTIgdgALeMsJOEG3FYkFjfYs//nFpw9zw20YMBB+EXGLGRIhbTjU=
X-Gm-Gg: AfdE7ckWmnrncDDV0N30XHOCyYiN1x0c/hpOou+t7EAw4DIqR3v7LxFNcENmLaB8qRg
	l05CsZxvhDt6BXJNbuqQnuzEqDY5Vas5HJLHn037OzG8p+Yy3uzvpra70ckfbYe4WWtiPmb9jX7
	gxyaL4q9TynBI7GtHlJ9zTbRqVuNTJIq2BOnJew9edarJRtLDaxjuDigwfW3Jax1EjaGDTpw8Ee
	yjpY1RcjINjAdWoflwEqTFNjMbnTfjsOr5n7GStqCHWXW4m6aZ6teSS5j4si4yHgf/U66hBom5G
	yyAf4PIOSEc42r6MQI5KwH46YvbIMyssFtI4MKi4Hd8tDpHpYSr65so6Mo8E5Fl/ObQxilTf0C6
	Yn/ZvNcgxeJcfRuvd+CytP+f3CmqEnw0IDRCIrflaM5A2DrT7pIpfFiOJFIN41GtnxTfGYPzAMD
	XD/OJ6qTNjGOIbcGalXm1GW6du
X-Received: by 2002:a05:600c:4ecb:b0:495:4c73:3d59 with SMTP id 5b1f17b1804b1-4954c733e07mr193457475e9.23.1784642968727;
        Tue, 21 Jul 2026 07:09:28 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-495653698bcsm65138255e9.2.2026.07.21.07.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:09:28 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 2/2] selftests: net: bridge: test ranges with PVID VLAN
Date: Tue, 21 Jul 2026 17:09:22 +0300
Message-ID: <20260721140922.682265-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721140922.682265-1-razor@blackwall.org>
References: <20260721140922.682265-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test with PVID VLAN that matches the flags of the VLAN following it
and check if the range is properly dumped. PVID VLAN should be on its own
and all VLANs should be present in the dump.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 .../testing/selftests/net/bridge_vlan_dump.sh | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/bridge_vlan_dump.sh b/tools/testing/selftests/net/bridge_vlan_dump.sh
index ad66731d2a6f..90e18e2104e3 100755
--- a/tools/testing/selftests/net/bridge_vlan_dump.sh
+++ b/tools/testing/selftests/net/bridge_vlan_dump.sh
@@ -13,6 +13,7 @@ ALL_TESTS="
 	vlan_range_mcast_max_groups
 	vlan_range_mcast_n_groups
 	vlan_range_mcast_enabled
+	vlan_range_pvid
 "
 
 setup_prepare()
@@ -191,6 +192,28 @@ vlan_range_mcast_enabled()
 	log_test "VLAN range grouping with mcast_enabled"
 }
 
+vlan_range_pvid()
+{
+	RET=0
+
+	ip -n "$NS" link set dev br0 type bridge vlan_default_pvid 1
+	check_err $? "Failed to configure default PVID"
+	defer ip -n "$NS" link set dev br0 type bridge vlan_default_pvid 0
+
+	bridge -n "$NS" vlan add vid 2 dev dummy0 untagged
+	check_err $? "Failed to add VLAN 2"
+	defer bridge -n "$NS" vlan del vid 2 dev dummy0
+
+	bridge -n "$NS" -d vlan show dev dummy0 |
+		grep -Eq '(^|[[:space:]])2([[:space:]]|$)'
+	check_err $? "VLAN following PVID is missing from detailed dump"
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -q "1-2"
+	check_fail $? "PVID was incorrectly included in a VLAN range"
+
+	log_test "PVID is isolated from VLAN dump ranges"
+}
+
 # Verify the newest tested option is supported
 if ! bridge vlan help 2>&1 | grep -q "neigh_suppress"; then
 	echo "SKIP: iproute2 too old, missing per-VLAN neighbor suppression support"
-- 
2.47.3

