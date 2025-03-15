Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C31A239D
	for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068863; cv=none; b=bYswnUirjO5NYpus2lcss4FjhnCgEL494RabomjYW1lcHigi5DToMhalRs+mQiHkW3cPRmzFji7SnP2DwaOzbR7r4lIptIrkETnasewX1auLzNw8FZ+5FtUNW2QT/AfeNUKtbguivJV0gqlprnpGFjP3CwWBS3QvfWMwdjVL7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068863; c=relaxed/simple;
	bh=0F9R/j6yTe/QG1ZiLEakkkx9BEQ8WqPxJQQJx7PDgLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJPy2gWvcnSdLLvRLhL8/uEvjxLahTaUD7vCt0Yq+ePy5eRGT21jRE7Yt+a3qTRBP/FXjNSR0ILt9lzaVHvPE4k/BJBzqzvfj8I3Cnmb0pwEyr/dRE+Nm106GzDGnJXp0UiC7ovjwJ1D0og32X+UnyfAyKKorAwZC1hPLmBbkNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqhCkGqL; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqhCkGqL"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso572032966b.1
        for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 13:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742068860; x=1742673660; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T25jQdtL6Ghs3k28V+ta25q96RJ5mAE93MydZdqFWhU=;
        b=nqhCkGqLzhhFMd53ae94QR0sHJbfttYGU/gAWyo4978QBj+oJtGlsRpHWihR1XhGgW
         mSJ6CbSoVgOhbYYkp383ubtB5tWCngxm8Hfag2bG0P/ZsMenwLcb7DO0HhV1laPlN1+h
         yN/S6gR4jt+LKnHCGnDlVPJ/DbZWBINfi8a2f/wQlfQazLfG6n0UckU4MsG4OBN4vIQp
         Dt5jcb8xaBPhJtI+3TS0iGlBh1s5h+qbhIcQqXYepgUaObGMDjo1bMsEFtljiEnLDSCI
         kVBQwFZYtU9W6KYQmoQuTwfrPOOtftBPbU2OAT9I7+VrbHyZrqol26b5+slPImzvFJ9K
         y3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742068860; x=1742673660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T25jQdtL6Ghs3k28V+ta25q96RJ5mAE93MydZdqFWhU=;
        b=or8Nmw6dbiZes+TPmAGyk6/89WmfElYIDzkoFYKQPCVS7xLAKNWHHKYruuN+tZZ/hk
         9ZxBqgY/MjKKZd59WXZt+BRO+1yO642vhqwURAvhREnTbWgVTIqBFu+77cKrH5Klwokb
         VPbeOlPtBz6pDU5YMmaWFDOWBwjzaAdJjZvkRvCC0w/1WGQBFdicWYM16Vs9khQCMhUi
         9XaYZhnnhB7YFkC9cli4Wm3i1NS7+Ae4oAPqnUDfsu9zdJd6liwdtHrPdvfZmRY8E9+j
         jjBzkn3kcXcyIU2xgs4pUVizKv8S4O5Ojzg38GOxtv2gANJz56S39/V9bhl5C001mS6G
         LqMg==
X-Forwarded-Encrypted: i=1; AJvYcCWzF1Yh1+ECAjfLqwTMV+o4d2OhkOUeeogOZUOiyHscU5E0Coo6mf0sv/zfXBgWHHdsjb9WhA4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx741Ij1YC1eEKfjyV9TvbVUTbW/YLICmE8mcfjsaa+wzdmhuxI
	CuNUFqT+S06hDTObK8uyUNDxEtM+4Mq8cV4gCJABJt1F8X6cvU6W
X-Gm-Gg: ASbGnctw1Av4hLhGKFYfvrZX++u+mI2oQMinuz2LkSe9S9N9iAvdc+qb7P+sr1jeJC0
	1ZOM9galBnd5n5s0JASz0ZodC+SK3SXB5gWQA/erltwiaBEUutb20StpDZB7GrkFx/LK2rbDZB2
	gfvrjPh2JyuAtVeudwDKDI8GNbU8iysIiz8FHL1zTbevnuwsMVXDpCyQ0384IosfeBSDQ8Proe9
	2u6UNOXGGRy+P4EWIvUBs6ACLyzCh3OoQ5AHWuKwQu3MK4z5bX3k99YHE3P3iHg/S7nTtwWDk8w
	1KoT6eetvTKuqxne6B4WL8iMcnKLmvsoZZMvED9+zPWiZrknKCWZ4ZzJLBrJ6RcCBGCBraxSF/v
	1IoHNoUVdMTh+we9R0PoEzCksEM4RxedoseDW98u0k3jZJPWWxw2AFYC/pQSOLLY=
X-Google-Smtp-Source: AGHT+IHXc3iBDf8ib1JnOQZU9P4sM7gMd43rDie9fReqHUMq/fuvd6EnMEIA80Ah+N94qtaKEMo3GQ==
X-Received: by 2002:a17:907:2d0f:b0:ac1:17fe:c74f with SMTP id a640c23a62f3a-ac3314f2d7cmr674702766b.21.1742068860201;
        Sat, 15 Mar 2025 13:01:00 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bc6sm405908066b.49.2025.03.15.13.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:00:59 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v10 nf-next 3/3] selftests: netfilter: Add conntrack_bridge.sh
Date: Sat, 15 Mar 2025 21:00:33 +0100
Message-ID: <20250315200033.17820-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250315200033.17820-1-ericwouds@gmail.com>
References: <20250315200033.17820-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check conntrack bridge is functional in various vlan setups.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 .../testing/selftests/net/netfilter/Makefile  |   1 +
 .../net/netfilter/conntrack_bridge.sh         | 176 ++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100755 tools/testing/selftests/net/netfilter/conntrack_bridge.sh

diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
index ffe161fac8b5..bee403d423f5 100644
--- a/tools/testing/selftests/net/netfilter/Makefile
+++ b/tools/testing/selftests/net/netfilter/Makefile
@@ -8,6 +8,7 @@ MNL_LDLIBS := $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
 
 TEST_PROGS := br_netfilter.sh bridge_brouter.sh
 TEST_PROGS += br_netfilter_queue.sh
+TEST_PROGS += conntrack_bridge.sh
 TEST_PROGS += conntrack_dump_flush.sh
 TEST_PROGS += conntrack_icmp_related.sh
 TEST_PROGS += conntrack_ipip_mtu.sh
diff --git a/tools/testing/selftests/net/netfilter/conntrack_bridge.sh b/tools/testing/selftests/net/netfilter/conntrack_bridge.sh
new file mode 100755
index 000000000000..806551ef8cc2
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/conntrack_bridge.sh
@@ -0,0 +1,176 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Check conntrack bridge is functional in various vlan setups.
+#
+# Setup is:
+#
+# nsclient1 -> nsbr -> nsclient2
+# ping nsclient2 from nsclient1, checking that conntrack established
+# packets are seen.
+#
+
+source lib.sh
+
+if ! nft --version > /dev/null 2>&1;then
+	echo "SKIP: Could not run test without nft tool"
+	exit $ksft_skip
+fi
+
+cleanup() {
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+setup_ns nsclient1 nsclient2 nsbr
+
+ret=0
+
+add_addr()
+{
+	ns=$1
+	dev=$2
+	i=$3
+
+	ip -net "$ns" link set "$dev" up
+	ip -net "$ns" addr add "192.168.1.$i/24" dev "$dev"
+	ip -net "$ns" addr add "dead:1::$i/64" dev "$dev" nodad
+	ip -net "$ns" route add default dev "$dev"
+}
+
+del_addr()
+{
+	ns=$1
+	dev=$2
+	i=$3
+
+	ip -net "$ns" route del default dev "$dev"
+	ip -net "$ns" addr del "dead:1::$i/64" dev "$dev" nodad
+	ip -net "$ns" addr del "192.168.1.$i/24" dev "$dev"
+	ip -net "$ns" link set "$dev" down
+}
+
+send_pings()
+{
+	for ad in "$@"; do
+		if ! ip netns exec "$nsclient1" ping -c 1 -s 962 -q "$ad" >/dev/null; then
+			echo "ERROR: netns routing/connectivity broken to $ad" 1>&2
+			exit 1
+		fi
+	done
+}
+
+check_counter()
+{
+	ns=$1
+	name=$2
+	expect=$3
+	local lret=0
+
+	if ! ip netns exec "$ns" nft list counter bridge filter "$name" | grep -q "$expect"; then
+		echo "ERROR: counter $name in $ns has unexpected value (expected $expect)" 1>&2
+		ip netns exec "$ns" nft list counter bridge filter "$name" 1>&2
+		lret=1
+	fi
+	ip netns exec "$ns" nft reset counters >/dev/null
+
+	return $lret
+}
+
+BR=br0
+if ! ip -net "$nsbr" link add $BR type bridge; then
+	echo "SKIP: Can't create bridge $BR"
+	exit $ksft_skip
+fi
+
+DEV=veth0
+ip link add "$DEV" netns "$nsclient1" type veth peer name eth1 netns "$nsbr"
+ip link add "$DEV" netns "$nsclient2" type veth peer name eth2 netns "$nsbr"
+
+ip -net "$nsbr" link set eth1 master $BR up
+ip -net "$nsbr" link set eth2 master $BR up
+ip -net "$nsbr" link set $BR up
+
+ip netns exec "$nsbr" nft -f - <<EOF
+table bridge filter {
+	counter established { }
+	chain forward {
+		type filter hook forward priority 0; policy accept;
+		ct state "established" counter name "established"
+	}
+}
+EOF
+
+a=1;
+for ns in "$nsclient1" "$nsclient2"; do
+	add_addr "$ns" "$DEV" $a
+	((a++))
+done
+
+send_pings "192.168.1.2" "dead:1::2"
+expect="packets 2 bytes 2000"
+if ! check_counter "$nsbr" "established" "$expect"; then
+	msg+="\nFAIL: without vlan, established packets not seen"
+	ret=1
+fi
+
+a=1;
+for ns in "$nsclient1" "$nsclient2"; do
+	del_addr "$ns" "$DEV" $a
+	ip -net "$ns" link add link "$DEV" name "$DEV.10" type vlan id 10
+	ip -net "$ns" link set "$DEV" up
+	add_addr "$ns" "$DEV.10" $a
+	((a++))
+done
+
+send_pings "192.168.1.2" "dead:1::2"
+expect="packets 2 bytes 2000"
+if ! check_counter "$nsbr" "established" "$expect"; then
+	msg+="\nFAIL: with single vlan, established packets not seen"
+	ret=1
+fi
+
+a=1;
+for ns in "$nsclient1" "$nsclient2"; do
+	del_addr "$ns" "$DEV.10" $a
+	ip -net "$ns" link add link "$DEV.10" name "$DEV.10.20" type vlan id 20
+	ip -net "$ns" link set "$DEV.10" up
+	add_addr "$ns" "$DEV.10.20" $a
+	((a++))
+done
+
+send_pings "192.168.1.2" "dead:1::2"
+expect="packets 2 bytes 2008"
+if ! check_counter "$nsbr" "established" "$expect"; then
+	msg+="\nFAIL: with double q vlan, established packets not seen"
+	ret=1
+fi
+
+a=1;
+for ns in "$nsclient1" "$nsclient2"; do
+	del_addr "$ns" "$DEV.10.20" $a
+	ip -net "$ns" link del "$DEV.10.20"
+	ip -net "$ns" link del "$DEV.10"
+	ip -net "$ns" link add link "$DEV" name "$DEV.10" type vlan id 10 protocol 802.1ad
+	ip -net "$ns" link add link "$DEV.10" name "$DEV.10.20" type vlan id 20
+	ip -net "$ns" link set "$DEV.10" up
+	add_addr "$ns" "$DEV.10.20" $a
+	((a++))
+done
+
+send_pings "192.168.1.2" "dead:1::2"
+expect="packets 2 bytes 2008"
+if ! check_counter "$nsbr" "established" "$expect"; then
+	msg+="\nFAIL: with 802.1ad vlan, established packets not seen "
+	ret=1
+fi
+
+if [ $ret -eq 0 ];then
+	echo "PASS: established packets seen in all cases"
+else
+	echo -e "$msg"
+fi
+
+exit $ret
+
-- 
2.47.1

