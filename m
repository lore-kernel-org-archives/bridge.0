Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390811BEF69
	for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527456; cv=none; b=Y1rSurExFlrkhNhgHYVbhYZ1jc36l7RXVLOZmsbOFbeNXMnWVGqw6oRqcZdmmb4TAqRfqDxaldWS8jEEOhXKVxvUsciDUci7SmSX8WPjX2oHvppzLLrAkr8qjW2DD3H26Cb2XtWOOAymrNg/or57IzzmAZbAQLv7yidWz9QZP6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527456; c=relaxed/simple;
	bh=MmoB5+7EOmwBm0nVVOoQDyuB6FG4U5u804h3NW5wIi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsno1XzkI2tZBdr7iN6ezve9KrJFC4WyC8vtOyuJCokPuhl9vXRjdj9VoPcjs2teqGXJ2pU1cpziic6eAxy2nhT5KtsI3GzMrNFZZOUq3ufAxIH6CmeVAY2Lzwq7VV5qL4awgfMj2WIt2fz1W6dYe6VOVVI5JDpqittXto6YxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ll+r4BoX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll+r4BoX"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2165448243fso63145945ad.1
        for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 05:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527454; x=1735132254; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEe2srsfNQuo3cFtk4Exr0i8mchzSjDC/1TEtzbMZ8U=;
        b=ll+r4BoXO4/dnABswu+v+8Q/dt+2qmN5JWeMdMozw+YYgdkI1JGFxpbt/mpu6Qgj06
         Pybsz8WUFLSDy4yptJnmrU/PWSOfwN8UDb7eFT572/GqP4XdDRhOGA0zT986NOV5YQ6V
         MxLPVX+sdWqBWD0ZHUPCv+5HkXj4mewS6kqyeGuoP2b6tPtO/tewHRBijKEgwlQjc6Te
         xFa06W9G47lXweMAXop0qobSILmPlYnO7sFV7Kp3JYDn2C8EPbgJRjW2xK0x5zXRlfvU
         fyrea8s4qN3F4Y4Go+n3UVI0JY9mfKGUJn2ZUEi15HCc04oTbFvZgyFX0ZiOTP610ggZ
         kiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527454; x=1735132254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEe2srsfNQuo3cFtk4Exr0i8mchzSjDC/1TEtzbMZ8U=;
        b=kkYHM3/C3UPg8Jq5mlZGPtdZkgUEM+g4d0hqqDKqKxgktPuC9ualRfxIh/rk+Xhc7a
         OLaa8fEOoebQRjRy3Yt06x0j3uU68SE8jorpk0izMuUseOUn1lUtKqzhFPaXdy8MjFYS
         WLY7oUzhXXir7Kqn3LZx0YOJW8ouydY1YoXzkCirhSDxmgsvLxXHB4928DtC6BUrwnWG
         NherHVGzYraojyqO7bSeOz1LW/beJY15H9RC1QZTBoACxAG5Fehl5Fil0+6hyrBp72ex
         tz2+frIQGyvCA8w9BQmu4KUB/w2lCNEMoRxM3GTe6JuCO41H/4HOOVaKlYpjEkdmzTw3
         iVdw==
X-Forwarded-Encrypted: i=1; AJvYcCVuS0VVG9bC81JgYxO2ntx1AYxlJtm7WcBLYXfE0+Yab28KBPpDPP/9o3NROZZ+amva0x7VF+w=@lists.linux.dev
X-Gm-Message-State: AOJu0YyMHlepqtSfNr/qH2J6Ruh/prNt4lVWllMDIY/t6S7R4egK4snD
	zt+zHtdkzD3HYWGgW9vzQjtyM3Y9OEdrRIRdDSypImZvuzZzRJIh
X-Gm-Gg: ASbGnctzuWX88h4w/hVwqnbrdOIHAZ8ySma9Ud53FSp0aHHAwoyq0adN01gqB9lm5BS
	MoUXsX1tQei9lqBUMlR2ra7rsZamKTAbb9+Im3+Ww8EBh+fnyGqx8KBtyHk7TjGJbs7OtavahVF
	djxXpqjVCAPH8iZjw0bvy1CsH7NDPFWPM6AUnpgghJ8eyzECRAJcZZ8uQ7JRLH9rtDv5c9n5J46
	JzoJicYTh/b/G/y5BLAVrxZv3xoQZwbtY2k2wpnxbags2w=
X-Google-Smtp-Source: AGHT+IGW2ivQBr6ib7m/cmjzjnkogelPQGpBxwq3iWWAr6K+/MU6YNZqq3IUhKj+TIVnGpc4fMVSow==
X-Received: by 2002:a17:902:f985:b0:216:6c77:7bbb with SMTP id d9443c01a7336-218d70dc242mr29804885ad.17.1734527454469;
        Wed, 18 Dec 2024 05:10:54 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:53 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v6 11/11] selftests: net: Add test cases for link and peer netns
Date: Wed, 18 Dec 2024 21:09:09 +0800
Message-ID: <20241218130909.2173-12-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218130909.2173-1-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Add test for creating link in another netns when a link of the same
   name and ifindex exists in current netns.
 - Add test to verify that link is created in target netns directly -
   no link new/del events should be generated in link netns or current
   netns.
 - Add test cases to verify that link-netns is set as expected for
   various drivers and combination of namespace-related parameters.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/link_netns.py | 142 ++++++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh |  10 ++
 3 files changed, 153 insertions(+)
 create mode 100755 tools/testing/selftests/net/link_netns.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index f09bd96cc978..cc6665212304 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -35,6 +35,7 @@ TEST_PROGS += cmsg_so_mark.sh
 TEST_PROGS += cmsg_so_priority.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS += netns-name.sh
+TEST_PROGS += link_netns.py
 TEST_PROGS += nl_netdev.py
 TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
 TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
diff --git a/tools/testing/selftests/net/link_netns.py b/tools/testing/selftests/net/link_netns.py
new file mode 100755
index 000000000000..c4b2ddf201ff
--- /dev/null
+++ b/tools/testing/selftests/net/link_netns.py
@@ -0,0 +1,142 @@
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
+LINK_NETNSID = 100
+
+
+def test_event() -> None:
+    with NetNS() as ns1, NetNS() as ns2:
+        with NetNSEnter(str(ns2)):
+            rtnl = RtnlFamily()
+
+        rtnl.ntf_subscribe("rtnlgrp-link")
+
+        ip(f"netns set {ns2} {LINK_NETNSID}", ns=str(ns1))
+        ip(f"link add netns {ns1} link-netnsid {LINK_NETNSID} dummy1 type dummy")
+        ip(f"link add netns {ns1} dummy2 type dummy", ns=str(ns2))
+
+        ip("link del dummy1", ns=str(ns1))
+        ip("link del dummy2", ns=str(ns1))
+
+        time.sleep(1)
+        rtnl.check_ntf()
+        ksft_true(rtnl.async_msg_queue.empty(),
+                  "Received unexpected link notification")
+
+
+def validate_link_netns(netns, ifname, link_netnsid) -> bool:
+    link_info = ip(f"-d link show dev {ifname}", ns=netns, json=True)
+    if not link_info:
+        return False
+    return link_info[0].get("link_netnsid") == link_netnsid
+
+
+def test_link_net() -> None:
+    configs = [
+        # type, common args, type args, fallback to dev_net
+        ("ipvlan", "link dummy1", "", False),
+        ("macsec", "link dummy1", "", False),
+        ("macvlan", "link dummy1", "", False),
+        ("macvtap", "link dummy1", "", False),
+        ("vlan", "link dummy1", "id 100", False),
+        ("gre", "", "local 192.0.2.1", True),
+        ("vti", "", "local 192.0.2.1", True),
+        ("ipip", "", "local 192.0.2.1", True),
+        ("ip6gre", "", "local 2001:db8::1", True),
+        ("ip6gre", "", "local 2001:db8::1", True),
+        ("ip6tnl", "", "local 2001:db8::1", True),
+        ("vti6", "", "local 2001:db8::1", True),
+        ("sit", "", "local 192.0.2.1", True),
+        ("xfrm", "", "if_id 1", True),
+    ]
+
+    with NetNS() as ns1, NetNS() as ns2, NetNS() as ns3:
+        net1, net2, net3 = str(ns1), str(ns2), str(ns3)
+
+        # prepare link netnsid  and a dummy link needed by certain drivers
+        ip(f"netns set {net3} {LINK_NETNSID}", ns=str(net2))
+        ip("link add dummy1 type dummy", ns=net3)
+
+        cases = [
+            # source, "netns", "link-netns", expected link-netns
+            (net3, None, None, None, None),
+            (net3, net2, None, None, LINK_NETNSID),
+            (net2, None, net3, LINK_NETNSID, LINK_NETNSID),
+            (net1, net2, net3, LINK_NETNSID, LINK_NETNSID),
+        ]
+
+        for src_net, netns, link_netns, exp1, exp2 in cases:
+            tgt_net = netns or src_net
+            for typ, cargs, targs, fb_dev_net in configs:
+                cmd = "link add"
+                if netns:
+                    cmd += f" netns {netns}"
+                if link_netns:
+                    cmd += f" link-netns {link_netns}"
+                cmd += f" {cargs} foo type {typ} {targs}"
+                ip(cmd, ns=src_net)
+                if fb_dev_net:
+                    ksft_true(validate_link_netns(tgt_net, "foo", exp1),
+                              f"{typ} link_netns validation failed")
+                else:
+                    ksft_true(validate_link_netns(tgt_net, "foo", exp2),
+                              f"{typ} link_netns validation failed")
+                ip(f"link del foo", ns=tgt_net)
+
+
+def test_peer_net() -> None:
+    types = [
+        "vxcan",
+        "netkit",
+        "veth",
+    ]
+
+    with NetNS() as ns1, NetNS() as ns2, NetNS() as ns3, NetNS() as ns4:
+        net1, net2, net3, net4 = str(ns1), str(ns2), str(ns3), str(ns4)
+
+        ip(f"netns set {net3} {LINK_NETNSID}", ns=str(net2))
+
+        cases = [
+            # source, "netns", "link-netns", "peer netns", expected
+            (net1, None, None, None, None),
+            (net1, net2, None, None, None),
+            (net2, None, net3, None, LINK_NETNSID),
+            (net1, net2, net3, None, None),
+            (net2, None, None, net3, LINK_NETNSID),
+            (net1, net2, None, net3, LINK_NETNSID),
+            (net2, None, net2, net3, LINK_NETNSID),
+            (net1, net2, net4, net3, LINK_NETNSID),
+        ]
+
+        for src_net, netns, link_netns, peer_netns, exp in cases:
+            tgt_net = netns or src_net
+            for typ in types:
+                cmd = "link add"
+                if netns:
+                    cmd += f" netns {netns}"
+                if link_netns:
+                    cmd += f" link-netns {link_netns}"
+                cmd += f" foo type {typ}"
+                if peer_netns:
+                    cmd += f" peer netns {peer_netns}"
+                ip(cmd, ns=src_net)
+                ksft_true(validate_link_netns(tgt_net, "foo", exp),
+                          f"{typ} peer_netns validation failed")
+                ip(f"link del foo", ns=tgt_net)
+
+
+def main() -> None:
+    ksft_run([test_event, test_link_net, test_peer_net])
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
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
-- 
2.47.1

