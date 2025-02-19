Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F031EDA0B
	for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969573; cv=none; b=H6Op2+mDyy2I3FYlS0BjKBaM6DnX3aIFvpGXWCPYWtjIWORuofntnYnO31nirpoUhi0awMuV9aFp9PPtw8kHCFG1oO6ixXXTvWdsMveU91Oh3KKN6uioIopxj8P5s19+db8fE1bmRiwFGEMLFvSY3NWc+tuRJkRPPkprPHyPYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969573; c=relaxed/simple;
	bh=jqz5blGUX5UncrsSac4ngco/AKqB1xIOiCjAuaEMTY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IC9p6rrHOZP6U5EEm4Fdyom3DVFOBn3JndV+xApaj6ET9nH5ZLd6cvJkeFpsVMd08Ml0Ow9bATiDjL9pyr7U9rdRmvAAiw/UlS7XvGFF/knv+fWRJ0MENgSnOoBi/mmCJ+wOSC75WlDqigGwOdLHj3AxA6KrmyvOUOKi0UhZ7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLctishr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLctishr"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220ecbdb4c2so2418605ad.3
        for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 04:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969571; x=1740574371; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qx8bg1rA+gp6wNTCNpkIOzYNrMU90JwyPLUIFRVvz8E=;
        b=bLctishrgUBmYSqUPYZ3MunNQMAIcnM+Naov72pWRajk2Pf+WkACWLNMaqaNYfH7Ef
         vkeLZ3L7r+t1C3uITKBYuVD38NZJUoWa6WL3/ke8XvxUPXMYtnuXpTku2M4S9bc0dMUZ
         OMjp17zBXKcC19I7iwJzt+SKacaSDdKbITPdQ3P0KkQbink2T+xyMDDMFPN7DJaJRb6U
         c+jbhlr0dnIlcJW1hq+4lba4M25faO2mEFLXA26PpITZqsGTzdNFZ04mmDjQhppIgiy9
         /G17BIZkeP27xaCwwmhoBrs5urN1StRUhuaMzBeZdU0/W2gu3OaQBY4F02vaBPvhq7E6
         DmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969571; x=1740574371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qx8bg1rA+gp6wNTCNpkIOzYNrMU90JwyPLUIFRVvz8E=;
        b=DcdYDIhZhdsjFiuGJT867nnuZfMdbcVu100uZyUgFMzlU23+bktJUj0N42lbWKVNH7
         3zQQow9WPBp+/9ainU7mePCSjb+I/MPnIdSVT3peKWe/in5jldhapnFzXI1HRhEVp5X8
         50J89AIQheEO3OuvGarsrW6zTEAOSgVxyi73GSei6Sed0mwLVIX5lXyuyOjVDAm7LBnt
         NUvGPvdR1ga0v7J/VL5T3BpBuiNfUvk9FVac49W6/Pj8I29Ccm1wpvm5aHenzntOxn32
         j9jE1+NPwXytSnCd9v1RBIn0cB7L4sRtkWPQYyWjjV9xefPAP382xWTKrgZ60Qukd3fb
         2H4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9kcR4OWtpfqwGvMZ9PExvXq1+3MfCUbZ7sEMivgvRVkW48smdcScAyhh/xTZhEC9MA/TPnPQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyzZC4h/TyYW8xxhqTjBVy3QcN3DKjaX3wVwlAAXIgEQ/FVGkP8
	ZjaAQQ9svd+bng3R7tEB6TG1yrlRjhGS9MW1XiU7CEcQp2IbdVLK
X-Gm-Gg: ASbGncvZOa4VynXgHiAvA/UV0TvxrppFfK5iE9cm8FVvzgkPgnInhAgomFPnpBE4YxU
	WHafSWvMKPuDq43yWim1gBOPgOcemoLvyv2xvEe8E6B7TcstwSfCEIQMMw8JD5jNe8llDLHzS7h
	KO1Gfx7D6eb1VtT0mS3dxahfu9IedA3TKX49jeHpsPyXz0+QULbFaCDY083KmACnWesrAyUCnPv
	1ECFNqZx0tgkifxCtz0E2syaZM7rH2+KY1jrF+eft2/pSPioUqCk7f4pzmOsYw4lq66VBoxUhOZ
	mexUdw==
X-Google-Smtp-Source: AGHT+IFzy5Z/oqAXsIcnrbdGOPINebfA49h4xYVAFBGwVs0inyqERb0A/6qA2oCD1QD2DsUmBu7oEA==
X-Received: by 2002:a17:902:f706:b0:21f:35fd:1b57 with SMTP id d9443c01a7336-221040be680mr277312185ad.43.1739969570774;
        Wed, 19 Feb 2025 04:52:50 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:50 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
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
Subject: [PATCH net-next v10 13/13] selftests: net: Add test cases for link and peer netns
Date: Wed, 19 Feb 2025 20:50:39 +0800
Message-ID: <20250219125039.18024-14-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
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
 tools/testing/selftests/net/config        |   5 +
 tools/testing/selftests/net/link_netns.py | 141 ++++++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh |  10 ++
 4 files changed, 157 insertions(+)
 create mode 100755 tools/testing/selftests/net/link_netns.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8d6116b80cf1..aeb96c085614 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -36,6 +36,7 @@ TEST_PROGS += cmsg_so_priority.sh
 TEST_PROGS += test_so_rcv.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS += netns-name.sh
+TEST_PROGS += link_netns.py
 TEST_PROGS += nl_netdev.py
 TEST_PROGS += rtnetlink.py
 TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 5b9baf708950..ab55270669ec 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -107,3 +107,8 @@ CONFIG_XFRM_INTERFACE=m
 CONFIG_XFRM_USER=m
 CONFIG_IP_NF_MATCH_RPFILTER=m
 CONFIG_IP6_NF_MATCH_RPFILTER=m
+CONFIG_IPVLAN=m
+CONFIG_CAN=m
+CONFIG_CAN_DEV=m
+CONFIG_CAN_VXCAN=m
+CONFIG_NETKIT=y
diff --git a/tools/testing/selftests/net/link_netns.py b/tools/testing/selftests/net/link_netns.py
new file mode 100755
index 000000000000..aab043c59d69
--- /dev/null
+++ b/tools/testing/selftests/net/link_netns.py
@@ -0,0 +1,141 @@
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
2.48.1

