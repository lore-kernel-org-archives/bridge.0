Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71A7206051
	for <bridge@lists.linux.dev>; Wed, 13 Nov 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502709; cv=none; b=nytjGsjJF2D+GMopSx32JE9WfcHutg0wWWWhr8v7BzMjDQURUA33Vvl2e96FMjnhxHxpHMXDJHgP0j/J5FkJE58ik6QhCL1SAkq9pdBlNXbAOaKIpK84z7PsSK9+KgHwrgmNRGHGB2GEWTYS81ssw5nCGiNImTJmcLnl9gWKhS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502709; c=relaxed/simple;
	bh=MiIGFE7JQmeCulMCTNzU+03Zvl9uvgozGAxqw8x+eUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdaH4jNnMxnSh1o4G2N8zipZmDnAibIYWk2kTiusS1lLZgJVzJgpRTQN2gta8ijgEJwFnsreSqzW5GAx/isUHwdQKe/l0+WJLdChDGSIwum8j8HIbPI+fnTqFaQ7PM1iD5XeXFX0JdwVgG5INxwuBh9Fpy2XOkxOrkjwL3DhozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl+niB7l; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl+niB7l"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e9e377aeadso1740149a91.1
        for <bridge@lists.linux.dev>; Wed, 13 Nov 2024 04:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502707; x=1732107507; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqrrLk6+C692qIcVQOp9KatlJAZHjGryjisTBrwbzoI=;
        b=Cl+niB7lz5SIQwJdbKhjab/xnTuPiiBZ5sxnMSwpk082yWGKzzlooYbMctpnDifG9C
         sHTmNxmInLIGvZARylZBGqVnfk2mJ9qmLO1cq69+jgEAShdw7QclPAoEL+Y/y+K3mt8d
         t3fwZuW7o8JbzYYkHhIOifRkuHZMrTNhzi7vVmYiKP6mLFql6N4v7V7t5oLwnQT/BDS8
         jcnSDiqPnsiIJ7kyXdiseIYH6xBjgdNaNwahLLIFDjSDJpOgQzJ6KnfECIQgoim9BlJl
         lSe0B+IvWZnXOne3S55dp9dBBBvtdFO9+j+AUKWlYheqn49B4ziddaM3jmA/KicNdbtC
         m10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502707; x=1732107507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqrrLk6+C692qIcVQOp9KatlJAZHjGryjisTBrwbzoI=;
        b=mg+sXNPRYCb0T4kQdUo55y2MXzx6g//aqgzZLPnV75q0y6dJSUEzI7nMz7Qx2xkmh+
         KUrzebigtdwfw1sP9hcAMvX5mmJ4w3unMrRB8w/xRzh8Il/fkPsmQLpQlNF9/hamdocD
         Nm+sAMo0v9mcYUKhr6TL3xrsmcLZYOwcXooCIdfRLNSJGtVB+UoOh6Qw6K/3Ue75qrXn
         Xs+gSCjuoo5H9a3WSTUjbRzASmUw/sClC+CD1obrn8OUFbqr7J4H5F/guSPTZkg6uhn5
         qvQ4Ou1f5bes5RYvcI1d3mJ8tiFYHGQZJc44cPxyXmfeBrBvwFkY1APjj0wBar/RJnej
         ncgA==
X-Forwarded-Encrypted: i=1; AJvYcCUmNtsI4o7VMD4TYQU2fz9yp7CUJDO7dEm57MaGgLTkgxtHI9ENJCf5RJ9l4VcReo5SAKu4TBg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2U448QhVA0epbN7UbRz4emb945OiFCmebtWDOg/xK+aQ6dyIK
	0LpxlSmXrOD2E8pMjYnxveuzF1GyLrcrWBmpcpZw66YTNm6C+Lq2
X-Google-Smtp-Source: AGHT+IE/vtXg73mPc9UwMocIh3JnpJ4Nx9KNFh/J++F7E0J+l3pL2CaZbF6bhZwKtLiUviIv9q/4Rw==
X-Received: by 2002:a17:90b:3c12:b0:2e2:b2ce:e41e with SMTP id 98e67ed59e1d1-2e9f2c78421mr3106773a91.13.1731502707231;
        Wed, 13 Nov 2024 04:58:27 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:58:26 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 6/6] selftests: net: Add two test cases for link netns
Date: Wed, 13 Nov 2024 20:57:15 +0800
Message-ID: <20241113125715.150201-7-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113125715.150201-1-shaw.leon@gmail.com>
References: <20241113125715.150201-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Add test for creating link in another netns when a link of the same
   name and ifindex exists in current netns.
 - Add test for link netns atomicity - create link directly in target
   netns, and no notifications should be generated in current netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 tools/testing/selftests/net/Makefile        |  1 +
 tools/testing/selftests/net/netns-name.sh   | 10 ++++++
 tools/testing/selftests/net/netns_atomic.py | 38 +++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 2b2a5ec7fa6a..4c15a115c251 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -34,6 +34,7 @@ TEST_PROGS += gre_gso.sh
 TEST_PROGS += cmsg_so_mark.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS += netns-name.sh
+TEST_PROGS += netns_atomic.py
 TEST_PROGS += nl_netdev.py
 TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
 TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/selftests/net/netns-name.sh
index 6974474c26f3..0be1905d1f2f 100755
--- a/tools/testing/selftests/net/netns-name.sh
+++ b/tools/testing/selftests/net/netns-name.sh
@@ -78,6 +78,16 @@ ip -netns $NS link show dev $ALT_NAME 2> /dev/null &&
     fail "Can still find alt-name after move"
 ip -netns $test_ns link del $DEV || fail
 
+#
+# Test no conflict of the same name/ifindex in different netns
+#
+ip -netns $NS link add name $DEV index 100 type dummy || fail
+ip -netns $NS link add netns $test_ns name $DEV index 100 type dummy ||
+    fail "Can create in netns without moving"
+ip -netns $test_ns link show dev $DEV >> /dev/null || fail "Device not found"
+ip -netns $NS link del $DEV || fail
+ip -netns $test_ns link del $DEV || fail
+
 echo -ne "$(basename $0) \t\t\t\t"
 if [ $RET_CODE -eq 0 ]; then
     echo "[  OK  ]"
diff --git a/tools/testing/selftests/net/netns_atomic.py b/tools/testing/selftests/net/netns_atomic.py
new file mode 100755
index 000000000000..e6c4147ef75e
--- /dev/null
+++ b/tools/testing/selftests/net/netns_atomic.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import time
+
+from lib.py import ksft_run, ksft_exit, ksft_true
+from lib.py import ip
+from lib.py import NetNS, NetNSEnter
+from lib.py import RtnlFamily
+
+
+def test_event(ns1, ns2) -> None:
+    with NetNSEnter(str(ns1)):
+        rtnl = RtnlFamily()
+
+    rtnl.ntf_subscribe("rtnlgrp-link")
+
+    ip(f"netns set {ns1} 0", ns=str(ns2))
+
+    ip(f"link add netns {ns2} link-netnsid 0 dummy1 type dummy")
+    ip(f"link add netns {ns2} dummy2 type dummy", ns=str(ns1))
+
+    ip("link del dummy1", ns=str(ns2))
+    ip("link del dummy2", ns=str(ns2))
+
+    time.sleep(1)
+    rtnl.check_ntf()
+    ksft_true(not rtnl.async_msg_queue, "Received unexpected link notification")
+
+
+def main() -> None:
+    with NetNS() as ns1, NetNS() as ns2:
+        ksft_run([test_event], args=(ns1, ns2))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.47.0

