Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FBC1C2324
	for <bridge@lists.linux.dev>; Mon, 18 Nov 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940440; cv=none; b=uWXJ/FSVolLnXSawW8PPzfJYKTzj72Iqdg17P2m5/YHeNYUDQjk7dHenE2QB1jixT7bVdtCoXwVYGkCsVK337CyEmq/Un30vg1jn2+Yp9IFvZDYEz7osvkaBqxMaPGcj2QbD2VJByVmi4hNbIFGMnebpxVNdQdrBWMexnTxPo7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940440; c=relaxed/simple;
	bh=EMm8SpRFSVdgOejildAdC2w3jXC1qx7tovAMGbdzoWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pd8uataLykj4kXiczlqjGjked3aB3NTCzVEy0rgtYRDb2KWRGTl7chwX3CihTXCHDDNjvHsoZwV8HQYQZJbxZoxM/U91+/Ob4lVyUCL2jBgKwmKa1hy477alT8U/iYUofGtpVvru7JfSHkYXLsdJrvx1lgSjGxeC+6aiSUKBKio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7IV6aV0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7IV6aV0"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ea2bf25dc8so1879700a91.0
        for <bridge@lists.linux.dev>; Mon, 18 Nov 2024 06:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940438; x=1732545238; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mad+mOcno2P0CIpC5U9uxqbBM+RxeN4q/RBh6+yxx1g=;
        b=A7IV6aV0LfJmgKFZtmYVYQhwBLeZUGpce7x5gDKuG3c/CPO2qzGcoq8yPHCDMa1KJ7
         JlCL8YcGBq0WQKrijOeVi0LHXfbQLnH0JuD0sS2b3eAAfmE8hFLk/Z1y7UpkSA0HIfC6
         1Ltz8Hvkuf6H6EOuwriOvoPliTWPYLL60Or8k3k975CjZTsdNQ/QlNICd1vGq27/UDix
         Qv5NP4Olmn7yShO0c1ik2zPQg/rZCAZzV2ypsLmCmo+DAa0OrnFYeC7yB1fPrtKg9VSe
         wgmXhOP84Ipjd+NDNTL9uQ2Lo6SY71S3WgUAn6mjYrTNrYw3R1ik0Al0GM/4iAd9u8DJ
         UhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940438; x=1732545238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mad+mOcno2P0CIpC5U9uxqbBM+RxeN4q/RBh6+yxx1g=;
        b=j+Ev8MeZxyfakjXDSMgj+q4GgNiItZSa0/SlejtPmJsjNimaTI6rJ35XG8g1bsN8EN
         AwrE7Lc3B7hmyGDQSnzRxdws2ZfDRfPnHUPsJIzUlETZjLrBh2RV22AwOmXUtsWEtRDJ
         lB/7Tl6fs++og+Zg+E2oV2W5V52pB50WCeZRrkJy8u3ssaNb5G/md8ZaLudt88c25817
         A0uhB01apIujcjVRQpVH/ozHR5L238HtJrxihzxa22Kx29kXjbz42NASqmL2Uv67a0is
         4IOytLwZ9xOeiiFjc1Jv3p9ji6J1vf4m1Cmxu8HxRpM5WzxwZfxMjs6ICIxQ25JbwMGD
         Pbhw==
X-Forwarded-Encrypted: i=1; AJvYcCWuMWGKKzTtAKOlXZMZLX98v0vp0Siga4/t9kMZcdTIwJNq2uHIY6mpuddwXhOorSPhBYhUQnc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw58ukUvRoeCQLffNk63nFIl6BsmvgsSffjH2lZuVNZTL7XO/4D
	n8CXnhW7LdNiClY5adSTIuJPkA5MrKbGqROu+BB5EEp6Ap4XnaBr
X-Google-Smtp-Source: AGHT+IF3SrGnsKmrF4jvHwe9jv6er3cYNAFkQ6BmUOZb81V3DDpEwoq4AchAw0/egZEddY1NEy8bEw==
X-Received: by 2002:a17:90b:3887:b0:2ea:98f1:c172 with SMTP id 98e67ed59e1d1-2ea98f1c2a5mr1425759a91.7.1731940436264;
        Mon, 18 Nov 2024 06:33:56 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:55 -0800 (PST)
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
Subject: [PATCH net-next v4 5/5] selftests: net: Add two test cases for link netns
Date: Mon, 18 Nov 2024 22:32:44 +0800
Message-ID: <20241118143244.1773-6-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118143244.1773-1-shaw.leon@gmail.com>
References: <20241118143244.1773-1-shaw.leon@gmail.com>
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
 tools/testing/selftests/net/netns_atomic.py | 39 +++++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 3d487b03c4a0..3aaa7950b0f0 100644
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
index 000000000000..d350a3fc0a91
--- /dev/null
+++ b/tools/testing/selftests/net/netns_atomic.py
@@ -0,0 +1,39 @@
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
+    ksft_true(rtnl.async_msg_queue.empty(),
+              "Received unexpected link notification")
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

