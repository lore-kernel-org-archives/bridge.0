Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DC396D09
	for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898224; cv=none; b=gTwkAxZX58wDDqE00NT5vi9rC3KEvUNW0eYIZk6NW+MZeRS1e7Rdvt2ZScfQyHKndF4rSPQESHp3Fp1jjAg6WIw3N/3xW16XYUz5DzIzmtCvGfGsAaLFnYXP846wj3xaPMBjjvXPS/HvQiDAK673v8aic5/9LHEoGEXVWA6/zAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898224; c=relaxed/simple;
	bh=cT/13qstn8/nOhBjQXRq0PqqXbdhTgppzUWbgSGQO70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGbLpqqr1qZtrTVUgxRqQfH6hY9hOL0kBpbJd+k75ovzc0VKxhlK2MGcOKvHqVcXXLF0kP+TLNRauXjbOAQ8WrRcQs/DBHyLe1+YmiFIKjxG5HAg7yexyy22YrbaG6R6lvgXDuJt63og21sTwm9x7cOKCGiQ2esMdEI+RV7fxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhvyYq+y; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhvyYq+y"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so1342949a91.3
        for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774898222; x=1775503022; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f2zrKZrRaGjASZcWc6dPmrf+99AFfJekwpd+WSzFDo=;
        b=LhvyYq+ywQLbaJ9ANVquoYlVkYjQjXnD7FPrRO1rg35jBjRQ4GTqJKQZp6uF7lyUoh
         qpcdv7XQ2Cn8cjeVSYSk+zmQyWBS4tCNhXZkdInWIUcZ0Wh3+FTM+kur/6T8F6fILAYZ
         o4Uf7bNfdXcZLCx9esJPa/Q3JGsO6t0a3MFsYDQkOAmzlyBGAXPgr1SgYh7hqC/KdfkP
         RyKxmOmDUQ0822tQYZ56uQJYKv5f2qDzrDIfiiyHV9G0+li6ZWQ5f8C0H0cH2tYyChbO
         WsgWNKJAp/51z6dh8dOHPZbZv0krexJdfifDh9zL45wMs6ARJcY58txOMSXO1vshWkw8
         LFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774898222; x=1775503022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5f2zrKZrRaGjASZcWc6dPmrf+99AFfJekwpd+WSzFDo=;
        b=kEwq3tFvnvz/SVqMzzWsfxWIudWs1NzydL2gb3XXLOg9YkxdggK0FN7nCCP+3/ikv6
         v4ln+opGdT4biHQ6JMwH7bBc4ym+E42/+ic61iA7o9K10/ouUN1NzFfhXCPmwt2kmq3i
         DJfOH71rykCM6CjZf6wVcYabFxFAcj95JIg5rawZAh7S/bRSz27wxQYgXrCWhVWRSWIC
         dcmPzG/H7k5IQrBsrkU1YMhpOieect7WSANJfDlHOjtbCe1PZzq1gZQ/TCUlJ35hrxU1
         Yj989490T33z2hrszBuVfYUGGTrHdqkjFu5lYsPLxRXCyjgN7Md2odG3KVnQRGXQ0WEb
         YrUg==
X-Forwarded-Encrypted: i=1; AJvYcCX/EL2nXTH1jOoNLCQBpzTvhUrYZdnZWOeUTtriz774wfD+SBGiqLFDloaRLg44dEflkU10TsI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwhWZ/c2+aIocyhp3g6nRH+sA9xhT9VD0LJGS2ixXK4f3XuKTp2
	6ITrmTpwN4/8422WDzr3b8tOYHsSb6w3OXccxjeQ4pumeIOdKjkiPu17
X-Gm-Gg: ATEYQzxZvrvNuisgH/ryJxN/d5LEyHq1Q7EzdULo0u6YHzSpwOkq3d6AAT/OuzedhNG
	SyRn8qeaKI+pz1KDTan80Raoi6khbxRl6r92Cg/kL9f/TCuNKdUNj1CIOMOl6DO31FyPzwc7/QM
	0kkrL2IT+O8aos5XhjEehVS1rwwROyk9x7CwVEvP3gnO67APJbLLXsdFpUSQjy43tg04s1U6vD2
	wqsDVO5pdeeEvF5byzDDCk4pVQt7rbHPcf5mUJCLMstY550Osze4j77lFYyc0Miue6B/uM9q/ba
	mWoleFtb/G/0hrpFAde9IdF7vePdLNm7Yhp/UVYR2Y+hjRFe+NkqhevuvvlAQlYjUQUX1f/gcTI
	XHRFd/z3i6nWaY2GMW8XXoJVlmMZuA9CUTbneJD5GeWjCTRWdTrJhMa4tBhh8j12kmIvwA9u1qY
	UL6y5zIFXZZNPHI50Xr96lmRNm7lBJL6D2lCVhlPff
X-Received: by 2002:a17:90b:3cce:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-35c3000c6f0mr12496361a91.12.1774898222332;
        Mon, 30 Mar 2026 12:17:02 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950d9b12sm9627178a91.17.2026.03.30.12.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:17:01 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/5] selftests: net: bridge: add tests for igmpv3 MRC and QQIC validation
Date: Mon, 30 Mar 2026 19:16:11 +0000
Message-ID: <20260330191611.16929-6-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330191611.16929-1-royujjal@gmail.com>
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bridge selftests that configure IGMPv3 parameters and validate the
resulting Query packet fields for Max Resp Code (MRC) and Querier Query
Interval Code (QQIC).

This also adds helper binary to encode floating-point exponential fields.

Future extensions may cover corresponding IPv6 cases.

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 .../selftests/net/forwarding/.gitignore       |   2 +
 .../testing/selftests/net/forwarding/Makefile |  10 ++
 .../selftests/net/forwarding/bridge_igmp.sh   | 109 ++++++++++++++++++
 .../selftests/net/forwarding/mc_decode.c      |  38 ++++++
 .../selftests/net/forwarding/mc_encode.c      |  40 +++++++
 5 files changed, 199 insertions(+)
 create mode 100644 tools/testing/selftests/net/forwarding/mc_decode.c
 create mode 100644 tools/testing/selftests/net/forwarding/mc_encode.c

diff --git a/tools/testing/selftests/net/forwarding/.gitignore b/tools/testing/selftests/net/forwarding/.gitignore
index 418ff96c52ef..aa0c7f1afb4b 100644
--- a/tools/testing/selftests/net/forwarding/.gitignore
+++ b/tools/testing/selftests/net/forwarding/.gitignore
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 forwarding.config
 ipmr
+mc_encode
+mc_decode
diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index bbaf4d937dd8..a26da846632d 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -1,5 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
+top_srcdir = ../../../../..
+
+CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
+CFLAGS += -I$(top_srcdir)/tools/include
+
+TEST_GEN_FILES := \
+	mc_encode \
+	mc_decode \
+# end of TEST_GEN_FILES
+
 TEST_PROGS := \
 	bridge_activity_notify.sh \
 	bridge_fdb_learning_limit.sh \
diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index d4e7dd659354..9841c4e4eca0 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -2,6 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ALL_TESTS="
+	v3query_mrc_test
+	v3query_qqic_test
 	v2reportleave_test
 	v3include_test
 	v3inc_allow_test
@@ -84,6 +86,7 @@ switch_destroy()
 {
 	ip link set dev $swp2 down
 	ip link set dev $swp1 down
+	ip link set dev br0 down
 
 	ip link del dev br0
 }
@@ -116,6 +119,112 @@ cleanup()
 	vrf_cleanup
 }
 
+check_binary()
+{
+	local cmd=$1; shift
+	local args=$@
+
+	if [[ ! -x "$(command -v "$cmd")" ]]; then
+		log_test_skip "$args $cmd not found"
+		return $EXIT_STATUS
+	fi
+}
+
+tcpdump_show_with_filter()
+{
+	local if_name=$1; shift
+	local filter=$@
+
+	tcpdump -e -n -r ${capfile[$if_name]} "$filter" 2>&1
+}
+
+validate_query()
+{
+	local if_name=$1; shift
+	local test="$1"; shift
+	local value="$1"; shift
+	local pattern=""
+	local field_val=""
+	local pos=""
+	local msg="IGMPv3 query: verify $test"
+	check_command tshark || return 1
+	check_binary "./mc_encode" $msg || return 1
+
+	if [ "$test" = "MRC" ]; then
+		pos=1 # MRC field offset within IGMP header
+		field_val=$(tshark -r ${capfile[$if_name]} -Y "igmp.type==0x11" \
+			   -V 2>/dev/null | grep "Max Resp Time")
+	elif [ "$test" = "QQIC" ]; then
+		pos=9 # QQIC field offset within IGMP header
+		field_val=$(tshark -r ${capfile[$if_name]} -Y "igmp.type==0x11" \
+			   -V 2>/dev/null | grep "QQIC")
+	fi
+
+	local enc_val=$(./mc_encode $value)
+	pattern="ip proto 2 and igmp[0] == 0x11 and igmp[$pos] == $enc_val"
+	local opt_str=""
+	tcpdump_show_with_filter $if_name $pattern | grep -q "igmp query v3"
+	ret=$?
+	if [ "$field_val" != "" -a $ret -ne 0 ]; then
+		opt_str="Bad $test value in IGMP packet: $field_val"
+	fi
+	check_err $ret "$opt_str"
+
+	log_test "$msg" "configured=$value, expected=$enc_val"
+}
+
+v3query_mrc_test()
+{
+	RET=0
+	local qri_val=160
+	local br_qri=$((qri_val*10))
+
+	# Set MRT to validate
+	ip link set dev br0 type bridge mcast_query_interval 12500 \
+					mcast_query_response_interval $br_qri \
+					mcast_igmp_version 3
+	check_err $? "IGMPv3 QUERY bridge configuration failed"
+
+	ip link set dev br0 down
+	tcpdump_start $h2
+	ip link set dev br0 up
+	sleep 2
+	tcpdump_stop $h2
+
+	validate_query $h2 "MRC" $qri_val
+	tcpdump_cleanup $h2
+
+	ip link set dev br0 type bridge mcast_query_interval 12500 \
+					mcast_query_response_interval 1000 \
+					mcast_igmp_version 2
+}
+
+v3query_qqic_test()
+{
+	RET=0
+	local qqi_val=160
+	local br_qqi=$((qqi_val*100))
+
+	# Set QQIC to validate
+	ip link set dev br0 type bridge mcast_query_interval $br_qqi \
+					mcast_query_response_interval 1000 \
+					mcast_igmp_version 3
+	check_err $? "IGMPv3 QUERY bridge configuration failed"
+
+	ip link set dev br0 down
+	tcpdump_start $h2
+	ip link set dev br0 up
+	sleep 2
+	tcpdump_stop $h2
+
+	validate_query $h2 "QQIC" $qqi_val
+	tcpdump_cleanup $h2
+
+	ip link set dev br0 type bridge mcast_query_interval 12500 \
+					mcast_query_response_interval 1000 \
+					mcast_igmp_version 2
+}
+
 v2reportleave_test()
 {
 	RET=0
diff --git a/tools/testing/selftests/net/forwarding/mc_decode.c b/tools/testing/selftests/net/forwarding/mc_decode.c
new file mode 100644
index 000000000000..5b626101497d
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/mc_decode.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/bitops.h>
+
+#define IGMPV3_FP_EXP(value)            (((value) >> 4) & 0x07)
+#define IGMPV3_FP_MAN(value)            ((value) & 0x0f)
+
+/* IGMPV3 floating-point exponential field threshold */
+#define IGMPV3_EXP_MIN_THRESHOLD        128
+
+static inline unsigned long decode_field(const u8 code)
+{
+    /* RFC3376, relevant sections:
+     *  - 4.1.1. Maximum Response Code
+     *  - 4.1.7. QQIC (Querier's Query Interval Code)
+     */
+    if (code < IGMPV3_EXP_MIN_THRESHOLD) {
+        return (unsigned long)code;
+    } else {
+        unsigned long mc_man, mc_exp;
+        mc_exp = IGMPV3_FP_EXP(code);
+        mc_man = IGMPV3_FP_MAN(code);
+        return ((mc_man | 0x10) << (mc_exp + 3));
+    }
+}
+
+int main(int argc, char *argv[])
+{
+    uint8_t qqic = 0;
+    if (argc >= 2)
+        qqic = atoi(argv[1]);
+    unsigned long qqi = decode_field(qqic);
+
+    printf("%lu\n", qqi);
+
+    return 0;
+}
diff --git a/tools/testing/selftests/net/forwarding/mc_encode.c b/tools/testing/selftests/net/forwarding/mc_encode.c
new file mode 100644
index 000000000000..a2183b864be4
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/mc_encode.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/bitops.h>
+
+/* IGMPV3 floating-point exponential field threshold */
+#define IGMPV3_EXP_MIN_THRESHOLD        128
+/* Max representable (mant = 0xF, exp = 7) -> 31744 */
+#define IGMPV3_EXP_MAX_THRESHOLD        31744
+
+static inline uint8_t encode_field(unsigned int value)
+{
+    uint8_t mc_exp, mc_man;
+
+    /* RFC3376: QQIC/MRC < 128 is literal */
+    if (value < IGMPV3_EXP_MIN_THRESHOLD)
+        return (uint8_t)value;
+
+    /* Saturate at max representable (mant = 0xF, exp = 7) -> 31744 */
+    if (value >= IGMPV3_EXP_MAX_THRESHOLD)
+        return 0xFF;
+
+    mc_exp  = (uint8_t)(fls(value) - 8);
+    mc_man = (uint8_t)((value >> (mc_exp + 3)) & 0x0F);
+
+    return 0x80 | (mc_exp << 4) | mc_man;
+}
+
+int main(int argc, char *argv[])
+{
+    unsigned int qqi = 0;
+    if (argc >= 2)
+        qqi = atoi(argv[1]);
+
+    uint8_t qqic = encode_field(qqi);
+
+    printf("%u\n", qqic);
+
+    return 0;
+}
-- 
2.43.0

