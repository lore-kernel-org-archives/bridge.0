Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046F3FE37B
	for <bridge@lists.linux.dev>; Sun,  4 Oct 2026 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791087208; cv=none; b=aIOHnVnPl2oEAKjclrN5ee/zW6NaUa715idpzJxtdrYALcFuZrgPtikiKoZw/+uWKc5WS6WxhpfJ/xn+R54j2flDPxTQGPFgE/S/LogJNF6fKxF3IodXX/UZJAkooG6Lkup1kIdVHA2svimOgkZNCc574b8xcHHovH12Rq1M7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791087208; c=relaxed/simple;
	bh=qnBOAGp89M3wyIjQLiMdPKdvO2kK1yWasOMRPfd15IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biF5z5Yxbo9YX2DQLIg7WFDU04JAjJVeC/3nAGqHb3xWcJjPWCrHzGvaRpafzgPKwT0ILEtyS3VP0Gl0AVrvRG8LmuB2n47Fqf3IYiMidZr05dy9ZoNS1EmymsnrbM4lQ+4L61FqynWOHH1suIt0S/krLvaTF+/kLONl088I+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKTBjTkV; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKTBjTkV"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-34ca2d54925so1217135eec.0
        for <bridge@lists.linux.dev>; Sat, 03 Oct 2026 21:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791087200; x=1791692000; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zVdVJDmCxgmk1uopQz2dkoSvwdPiQnojeiMTYKdCWM0=;
        b=qKTBjTkVJbcbSfP58Led2zCdSmzVUpCvzfnPYVXYUNvAwJX0dwrwKRaE1FSG1L0FAU
         MF1HYzd2Zz8tnbkJ67TdT8AGh2xSlpkOv1xxMzqglKEC/8xkOPJKY17UhxvFWXIKGP5F
         RIqsqqGVIhURnA5M/wY2PgBXOxobZRkGhIZeWqfxAeq7XTbAT/B0xUkmZpWWYzXvfjLF
         plLvrGO0x2iH5mCExGl2mFMg2RZXslQscX8BFpPUUulXnlKXBR0y7F1obE7VgmUulvVI
         6IQ0bblL14IPexW9Uxh2qY45mudkBovji8gYlAw/BBUJtTGdLAjD9EkKkBoQ4FnENm08
         iFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791087200; x=1791692000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zVdVJDmCxgmk1uopQz2dkoSvwdPiQnojeiMTYKdCWM0=;
        b=YhGuHjpxiiC0o5LU6E/Pr6q2I5BcYFJsvG01pomgJfSIXoiGsPBOqw5uciUWBXBTcJ
         CzGvMiJOUHiWy7qvg9J4HOBB0r+9FYsfTp/tibDQh+NWIusjtWH8macTm2byAFNrQyRR
         35QlJUtSeRWHfNjNyRrKmaF/Zl7xe3PLxfVLw+3zUPKSlu5MJlchAA4mrwkxYpZfUih8
         wsID5rWsNPMreN5Luej9W7jOWH+xUzQtVTIkvucQCFm83gH0+V2giqd/0Cgw1FurQ8xV
         +mw9zSSSQU6ZfWz/CvArtrQ4sqQszHXksYKhtCviPUCBjjcdTN+pkb8/Vk411j7Lrtet
         1Bpg==
X-Forwarded-Encrypted: i=1; AKwUvBwWD/VLsI42IMiLx0X4WXWAS2+M9EwFnzPL+ZKIcg2RmHcGMoeoflatrQyRzOJwd/jq075mxz4=@lists.linux.dev
X-Gm-Message-State: AFuF++nDR4zvek7WEK22uG4plv/9qkacJ2MCMY5lvFr0mfw3lW3VdUt1
	keWz31LfF8h5KE1NdEfJwfMKX9W/8Ucag4mEspApMI/C7MO0+dG3iLJHNz2Wew==
X-Gm-Gg: AYBFou2PTq1RUTlcsROoN3K3bxfbwmhTZBteFVi6WS0ynbG4sJap7DoKyJ44DKWaaSG
	lhrYnNJhmtIw60A7BsWYQe2xuBbDqGigr1iHBLtN9ruZc9mo1IwCXJY9GWcrXa3t5LOy5ansxkk
	sNhrDjxIWdqxThhUqxX3wyhHi4vxowD/G59p9efWalcrDZ5vQyHO/dgao+vZ7w7S8Ocq8fzeZMf
	TTvfsSzrTY1YkKD+kpuboIrL+qio8TLtk+/qWU5dMNi/A9f3P/jmlvL63HDGNaBQchpJUJ9sB7+
	ExXEo43Ot4phTNWnGTDZO2d1JC2Xvr/Lv5pLqYOMH0JZb2vZNz43yl1nkshNI+eWI8VB20SijBH
	7+zDRcf8VGNvcp7DS1LXovuBTN0yfP5os11SO85iBDIf/jRVDE1uvUFaad5C1bZl6vjstsSoM00
	rKLFwxw9gu+juSaie/QvBwCBE7yMkPhSL6IHF2fsYChxpVw1UPCMOSna9CqSy9C4ZyrWHHBuSMu
	Fh+VFUwlgYhJ3SUzQ==
X-Received: by 2002:a05:7301:7d09:b0:34e:6ffa:ad6c with SMTP id 5a478bee46e88-35111544b8amr4640983eec.40.1791087199850;
        Sat, 03 Oct 2026 21:13:19 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127136b8esm1366253eec.6.2026.10.03.21.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 21:13:19 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	idosch@nvidia.com,
	razor@blackwall.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev
Subject: [PATCH iproute2-next 2/2] bridge: add cfm command
Date: Sun,  4 Oct 2026 04:13:07 +0000
Message-ID: <20261004041307.2683990-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004041307.2683990-1-w453y.me@gmail.com>
References: <20261004041307.2683990-1-w453y.me@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bridge has had 802.1ag CFM support since 5.11 (net/bridge/br_cfm.c),
but iproute2 never got a command for it, so the only way to use it is
Microchip's out of tree cfm tool.

Add "bridge cfm", which covers what the kernel supports:

  bridge cfm mep { add | del | set }
  bridge cfm cc config
  bridge cfm cc peer { add | del }
  bridge cfm cc rdi
  bridge cfm cc ccm-tx
  bridge cfm show { config | status }

Each command maps to one IFLA_BRIDGE_CFM_* group and is sent to the
bridge device with BRIDGE_FLAGS_SELF. The MAID is taken as a hex string,
the same bytes the kernel stores. There is no way yet to build it from
an MD and MA name.

Example with a MEP on each end of a veth pair, one bridge each side:

  $ bridge cfm mep add bridge brA instance 1 port vA
  $ bridge cfm mep set bridge brA instance 1 \
        address 02:00:00:00:00:0a level 3 mepid 10
  $ bridge cfm cc config bridge brA instance 1 \
        enable on interval 100ms maid 0104746573740002
  $ bridge cfm cc peer add bridge brA instance 1 mepid 20
  $ bridge cfm cc ccm-tx bridge brA instance 1 \
        dmac 01:80:c2:00:00:33 period 30
  (same on brB with mepid 20 and peer 10)
  $ bridge cfm show status bridge brA
  brA
      mep 1 opcode_unexp_seen false version_unexp_seen false ...
          peer mepid 20 ccm_defect false rdi false ... seen true ...

Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 bridge/Makefile    |    2 +-
 bridge/br_common.h |    1 +
 bridge/bridge.c    |    3 +-
 bridge/cfm.c       | 1058 ++++++++++++++++++++++++++++++++++++++++++++
 man/man8/bridge.8  |  196 +++++++-
 5 files changed, 1257 insertions(+), 3 deletions(-)
 create mode 100644 bridge/cfm.c

diff --git a/bridge/Makefile b/bridge/Makefile
index 4c57df43..4bf5b529 100644
--- a/bridge/Makefile
+++ b/bridge/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-BROBJ = bridge.o fdb.o monitor.o link.o mdb.o mst.o vlan.o vni.o
+BROBJ = bridge.o fdb.o monitor.o link.o mdb.o mst.o vlan.o vni.o cfm.o
 
 include ../config.mk
 
diff --git a/bridge/br_common.h b/bridge/br_common.h
index 3a0cf882..fb9b0d5a 100644
--- a/bridge/br_common.h
+++ b/bridge/br_common.h
@@ -24,6 +24,7 @@ int do_mst(int argc, char **argv);
 int do_vlan(int argc, char **argv);
 int do_link(int argc, char **argv);
 int do_vni(int argc, char **argv);
+int do_cfm(int argc, char **argv);
 
 extern int preferred_family;
 extern int show_stats;
diff --git a/bridge/bridge.c b/bridge/bridge.c
index d993ba19..1c3bde32 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -36,7 +36,7 @@ static void usage(void)
 	fprintf(stderr,
 "Usage: bridge [ OPTIONS ] OBJECT { COMMAND | help }\n"
 "       bridge [ -force ] -batch filename\n"
-"where  OBJECT := { link | fdb | mdb | mst | vlan | vni | monitor }\n"
+"where  OBJECT := { link | fdb | mdb | mst | vlan | vni | cfm | monitor }\n"
 "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
 "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
 "                    -com[pressvlans] -c[olor] -p[retty] -j[son] }\n");
@@ -59,6 +59,7 @@ static const struct cmd {
 	{ "mst",	do_mst },
 	{ "vlan",	do_vlan },
 	{ "vni",	do_vni },
+	{ "cfm",	do_cfm },
 	{ "monitor",	do_monitor },
 	{ "help",	do_help },
 	{ 0 }
diff --git a/bridge/cfm.c b/bridge/cfm.c
new file mode 100644
index 00000000..1b7fb159
--- /dev/null
+++ b/bridge/cfm.c
@@ -0,0 +1,1058 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * bridge cfm: configure and show IEEE 802.1ag Connectivity Fault Management
+ * (CFM) Maintenance Endpoints (MEPs) on a Linux bridge.
+ *
+ * Authors:	Abdul Wasey <w453y.me@gmail.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <net/if.h>
+#include <linux/if_bridge.h>
+#include <linux/cfm_bridge.h>
+#include <linux/rtnetlink.h>
+
+#include "libnetlink.h"
+#include "utils.h"
+#include "br_common.h"
+#include "json_print.h"
+#include "rt_names.h"
+
+static unsigned int filter_index;
+
+static void cfm_usage(void)
+{
+	fprintf(stderr,
+"Usage: bridge cfm mep add bridge DEV instance INSTANCE port PORT\n"
+"              [ domain port ] [ direction down ]\n"
+"       bridge cfm mep del bridge DEV instance INSTANCE\n"
+"       bridge cfm mep set bridge DEV instance INSTANCE address LLADDR\n"
+"              level LEVEL mepid MEPID\n"
+"       bridge cfm cc config bridge DEV instance INSTANCE enable { on | off }\n"
+"              interval INTERVAL maid MAID\n"
+"       bridge cfm cc peer { add | del } bridge DEV instance INSTANCE mepid MEPID\n"
+"       bridge cfm cc rdi bridge DEV instance INSTANCE rdi { on | off }\n"
+"       bridge cfm cc ccm-tx bridge DEV instance INSTANCE dmac LLADDR period PERIOD\n"
+"              [ seq { on | off } ]\n"
+"              [ iftlv { on | off } ] [ iftlv-value VALUE ]\n"
+"              [ porttlv { on | off } ] [ porttlv-value VALUE ]\n"
+"       bridge cfm show { config | status } [ bridge DEV ]\n"
+"\n"
+"where  INTERVAL := { 3ms3 | 10ms | 100ms | 1s | 10s | 1m | 10m }\n"
+"       MAID is the 48 byte MAID as a hex string, zero padded if shorter\n"
+"       PERIOD is how many seconds to send CCMs for, 0 stops sending\n"
+"       seq on puts an incrementing sequence number in each CCM\n");
+	exit(-1);
+}
+
+static int cfm_parse_interval(const char *str)
+{
+	if (!strcmp(str, "none"))
+		return BR_CFM_CCM_INTERVAL_NONE;
+	if (!strcmp(str, "3ms3") || !strcmp(str, "3.3ms"))
+		return BR_CFM_CCM_INTERVAL_3_3_MS;
+	if (!strcmp(str, "10ms"))
+		return BR_CFM_CCM_INTERVAL_10_MS;
+	if (!strcmp(str, "100ms"))
+		return BR_CFM_CCM_INTERVAL_100_MS;
+	if (!strcmp(str, "1s"))
+		return BR_CFM_CCM_INTERVAL_1_SEC;
+	if (!strcmp(str, "10s"))
+		return BR_CFM_CCM_INTERVAL_10_SEC;
+	if (!strcmp(str, "1m"))
+		return BR_CFM_CCM_INTERVAL_1_MIN;
+	if (!strcmp(str, "10m"))
+		return BR_CFM_CCM_INTERVAL_10_MIN;
+	return -1;
+}
+
+static const char *cfm_interval_str(__u32 interval)
+{
+	switch (interval) {
+	case BR_CFM_CCM_INTERVAL_NONE:
+		return "none";
+	case BR_CFM_CCM_INTERVAL_3_3_MS:
+		return "3ms3";
+	case BR_CFM_CCM_INTERVAL_10_MS:
+		return "10ms";
+	case BR_CFM_CCM_INTERVAL_100_MS:
+		return "100ms";
+	case BR_CFM_CCM_INTERVAL_1_SEC:
+		return "1s";
+	case BR_CFM_CCM_INTERVAL_10_SEC:
+		return "10s";
+	case BR_CFM_CCM_INTERVAL_1_MIN:
+		return "1m";
+	case BR_CFM_CCM_INTERVAL_10_MIN:
+		return "10m";
+	default:
+		return "unknown";
+	}
+}
+
+static int cfm_talk(struct nlmsghdr *n)
+{
+	return rtnl_talk(&rth, n, NULL);
+}
+
+/* "bridge cfm mep add" / "bridge cfm mep del" / "bridge cfm mep set" */
+
+static int cfm_mep_add(int argc, char **argv)
+{
+	struct {
+		struct nlmsghdr  n;
+		struct ifinfomsg ifm;
+		char             buf[1024];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.n.nlmsg_type = RTM_SETLINK,
+		.ifm.ifi_family = PF_BRIDGE,
+	};
+	struct rtattr *afspec, *cfm, *create;
+	__u32 instance = 0, domain = BR_CFM_PORT, direction = BR_CFM_MEP_DIRECTION_DOWN;
+	__u32 port_idx = 0;
+	char *bridge_dev = NULL, *port_dev = NULL;
+	bool instance_set = false;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "bridge") == 0) {
+			NEXT_ARG();
+			bridge_dev = *argv;
+		} else if (strcmp(*argv, "instance") == 0) {
+			NEXT_ARG();
+			if (get_u32(&instance, *argv, 0))
+				invarg("invalid instance", *argv);
+			instance_set = true;
+		} else if (strcmp(*argv, "domain") == 0) {
+			NEXT_ARG();
+			if (strcmp(*argv, "port") == 0)
+				domain = BR_CFM_PORT;
+			else if (strcmp(*argv, "vlan") == 0)
+				domain = BR_CFM_VLAN;
+			else
+				invarg("invalid domain", *argv);
+		} else if (strcmp(*argv, "direction") == 0) {
+			NEXT_ARG();
+			if (strcmp(*argv, "down") == 0)
+				direction = BR_CFM_MEP_DIRECTION_DOWN;
+			else if (strcmp(*argv, "up") == 0)
+				direction = BR_CFM_MEP_DIRECTION_UP;
+			else
+				invarg("invalid direction", *argv);
+		} else if (strcmp(*argv, "port") == 0) {
+			NEXT_ARG();
+			port_dev = *argv;
+		} else {
+			cfm_usage();
+		}
+		argc--; argv++;
+	}
+
+	if (!bridge_dev || !instance_set || !port_dev) {
+		fprintf(stderr,
+			"Required: bridge DEV instance INSTANCE port PORT_DEV\n");
+		return -1;
+	}
+
+	req.ifm.ifi_index = ll_name_to_index(bridge_dev);
+	if (!req.ifm.ifi_index)
+		return nodev(bridge_dev);
+
+	port_idx = ll_name_to_index(port_dev);
+	if (!port_idx)
+		return nodev(port_dev);
+
+	afspec = addattr_nest(&req.n, sizeof(req), IFLA_AF_SPEC);
+	addattr16(&req.n, sizeof(req), IFLA_BRIDGE_FLAGS, BRIDGE_FLAGS_SELF);
+	cfm = addattr_nest(&req.n, sizeof(req), IFLA_BRIDGE_CFM | NLA_F_NESTED);
+	create = addattr_nest(&req.n, sizeof(req),
+			      IFLA_BRIDGE_CFM_MEP_CREATE | NLA_F_NESTED);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_MEP_CREATE_INSTANCE,
+		  instance);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_MEP_CREATE_DOMAIN,
+		  domain);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_MEP_CREATE_DIRECTION,
+		  direction);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_MEP_CREATE_IFINDEX,
+		  port_idx);
+	addattr_nest_end(&req.n, create);
+	addattr_nest_end(&req.n, cfm);
+	addattr_nest_end(&req.n, afspec);
+
+	return cfm_talk(&req.n);
+}
+
+static int cfm_mep_del(int argc, char **argv)
+{
+	struct {
+		struct nlmsghdr  n;
+		struct ifinfomsg ifm;
+		char             buf[1024];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.n.nlmsg_type = RTM_SETLINK,
+		.ifm.ifi_family = PF_BRIDGE,
+	};
+	struct rtattr *afspec, *cfm, *del;
+	__u32 instance = 0;
+	char *bridge_dev = NULL;
+	bool instance_set = false;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "bridge") == 0) {
+			NEXT_ARG();
+			bridge_dev = *argv;
+		} else if (strcmp(*argv, "instance") == 0) {
+			NEXT_ARG();
+			if (get_u32(&instance, *argv, 0))
+				invarg("invalid instance", *argv);
+			instance_set = true;
+		} else {
+			cfm_usage();
+		}
+		argc--; argv++;
+	}
+
+	if (!bridge_dev || !instance_set) {
+		fprintf(stderr, "Required: bridge DEV instance INSTANCE\n");
+		return -1;
+	}
+
+	req.ifm.ifi_index = ll_name_to_index(bridge_dev);
+	if (!req.ifm.ifi_index)
+		return nodev(bridge_dev);
+
+	afspec = addattr_nest(&req.n, sizeof(req), IFLA_AF_SPEC);
+	addattr16(&req.n, sizeof(req), IFLA_BRIDGE_FLAGS, BRIDGE_FLAGS_SELF);
+	cfm = addattr_nest(&req.n, sizeof(req), IFLA_BRIDGE_CFM | NLA_F_NESTED);
+	del = addattr_nest(&req.n, sizeof(req),
+			   IFLA_BRIDGE_CFM_MEP_DELETE | NLA_F_NESTED);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_MEP_DELETE_INSTANCE,
+		  instance);
+	addattr_nest_end(&req.n, del);
+	addattr_nest_end(&req.n, cfm);
+	addattr_nest_end(&req.n, afspec);
+
+	return cfm_talk(&req.n);
+}
+
+static int cfm_mep_set(int argc, char **argv)
+{
+	struct {
+		struct nlmsghdr  n;
+		struct ifinfomsg ifm;
+		char             buf[1024];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.n.nlmsg_type = RTM_SETLINK,
+		.ifm.ifi_family = PF_BRIDGE,
+	};
+	struct rtattr *afspec, *cfm, *config;
+	__u32 instance = 0, level = 0, mepid = 0;
+	char *bridge_dev = NULL, *address = NULL;
+	bool instance_set = false, level_set = false, mepid_set = false;
+	char abuf[32];
+	int alen = 0;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "bridge") == 0) {
+			NEXT_ARG();
+			bridge_dev = *argv;
+		} else if (strcmp(*argv, "instance") == 0) {
+			NEXT_ARG();
+			if (get_u32(&instance, *argv, 0))
+				invarg("invalid instance", *argv);
+			instance_set = true;
+		} else if (strcmp(*argv, "address") == 0) {
+			NEXT_ARG();
+			address = *argv;
+		} else if (strcmp(*argv, "level") == 0) {
+			NEXT_ARG();
+			if (get_u32(&level, *argv, 0) || level > 7)
+				invarg("invalid level (0-7)", *argv);
+			level_set = true;
+		} else if (strcmp(*argv, "mepid") == 0) {
+			NEXT_ARG();
+			if (get_u32(&mepid, *argv, 0) || mepid > 0x1FFF)
+				invarg("invalid mepid (0-8191)", *argv);
+			mepid_set = true;
+		} else {
+			cfm_usage();
+		}
+		argc--; argv++;
+	}
+
+	if (!bridge_dev || !instance_set || !address ||
+	    !level_set || !mepid_set) {
+		fprintf(stderr,
+			"Required: bridge DEV instance INSTANCE address LLADDR level LEVEL mepid MEPID\n");
+		return -1;
+	}
+
+	req.ifm.ifi_index = ll_name_to_index(bridge_dev);
+	if (!req.ifm.ifi_index)
+		return nodev(bridge_dev);
+
+	alen = ll_addr_a2n(abuf, sizeof(abuf), address);
+	if (alen != ETH_ALEN) {
+		fprintf(stderr, "Invalid address %s\n", address);
+		return -1;
+	}
+
+	afspec = addattr_nest(&req.n, sizeof(req), IFLA_AF_SPEC);
+	addattr16(&req.n, sizeof(req), IFLA_BRIDGE_FLAGS, BRIDGE_FLAGS_SELF);
+	cfm = addattr_nest(&req.n, sizeof(req), IFLA_BRIDGE_CFM | NLA_F_NESTED);
+	config = addattr_nest(&req.n, sizeof(req),
+			      IFLA_BRIDGE_CFM_MEP_CONFIG | NLA_F_NESTED);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_MEP_CONFIG_INSTANCE,
+		  instance);
+	addattr_l(&req.n, sizeof(req), IFLA_BRIDGE_CFM_MEP_CONFIG_UNICAST_MAC,
+		  abuf, ETH_ALEN);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_MEP_CONFIG_MDLEVEL,
+		  level);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_MEP_CONFIG_MEPID,
+		  mepid);
+	addattr_nest_end(&req.n, config);
+	addattr_nest_end(&req.n, cfm);
+	addattr_nest_end(&req.n, afspec);
+
+	return cfm_talk(&req.n);
+}
+
+static int cfm_mep(int argc, char **argv)
+{
+	if (argc <= 0)
+		cfm_usage();
+
+	if (strcmp(*argv, "add") == 0)
+		return cfm_mep_add(argc - 1, argv + 1);
+	if (strcmp(*argv, "delete") == 0 || strcmp(*argv, "del") == 0)
+		return cfm_mep_del(argc - 1, argv + 1);
+	if (strcmp(*argv, "set") == 0)
+		return cfm_mep_set(argc - 1, argv + 1);
+
+	cfm_usage();
+	return -1;
+}
+
+/* "bridge cfm cc ..." */
+
+static int cfm_cc_config(int argc, char **argv)
+{
+	struct {
+		struct nlmsghdr  n;
+		struct ifinfomsg ifm;
+		char             buf[1024];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.n.nlmsg_type = RTM_SETLINK,
+		.ifm.ifi_family = PF_BRIDGE,
+	};
+	struct rtattr *afspec, *cfm, *config;
+	__u32 instance = 0;
+	int enable = -1, interval = -1;
+	char *bridge_dev = NULL, *maid_str = NULL;
+	bool instance_set = false;
+	unsigned char maid[CFM_MAID_LENGTH] = {};
+	unsigned int maid_len = 0;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "bridge") == 0) {
+			NEXT_ARG();
+			bridge_dev = *argv;
+		} else if (strcmp(*argv, "instance") == 0) {
+			NEXT_ARG();
+			if (get_u32(&instance, *argv, 0))
+				invarg("invalid instance", *argv);
+			instance_set = true;
+		} else if (strcmp(*argv, "enable") == 0) {
+			int ret;
+
+			NEXT_ARG();
+			enable = parse_on_off("enable", *argv, &ret);
+			if (ret)
+				return ret;
+		} else if (strcmp(*argv, "interval") == 0) {
+			NEXT_ARG();
+			interval = cfm_parse_interval(*argv);
+			if (interval < 0)
+				invarg("invalid interval", *argv);
+		} else if (strcmp(*argv, "maid") == 0) {
+			NEXT_ARG();
+			maid_str = *argv;
+		} else {
+			cfm_usage();
+		}
+		argc--; argv++;
+	}
+
+	if (!bridge_dev || !instance_set || enable < 0 || interval < 0 ||
+	    !maid_str) {
+		fprintf(stderr,
+			"Required: bridge DEV instance INSTANCE enable { on | off } interval INTERVAL maid MAID\n");
+		return -1;
+	}
+
+	req.ifm.ifi_index = ll_name_to_index(bridge_dev);
+	if (!req.ifm.ifi_index)
+		return nodev(bridge_dev);
+
+	if (!hexstring_a2n(maid_str, maid, sizeof(maid), &maid_len)) {
+		fprintf(stderr, "Invalid maid %s\n", maid_str);
+		return -1;
+	}
+
+	afspec = addattr_nest(&req.n, sizeof(req), IFLA_AF_SPEC);
+	addattr16(&req.n, sizeof(req), IFLA_BRIDGE_FLAGS, BRIDGE_FLAGS_SELF);
+	cfm = addattr_nest(&req.n, sizeof(req), IFLA_BRIDGE_CFM | NLA_F_NESTED);
+	config = addattr_nest(&req.n, sizeof(req),
+			      IFLA_BRIDGE_CFM_CC_CONFIG | NLA_F_NESTED);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_CONFIG_INSTANCE,
+		  instance);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_CONFIG_ENABLE,
+		  enable);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL,
+		  interval);
+	addattr_l(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_CONFIG_EXP_MAID, maid,
+		  sizeof(maid));
+	addattr_nest_end(&req.n, config);
+	addattr_nest_end(&req.n, cfm);
+	addattr_nest_end(&req.n, afspec);
+
+	return cfm_talk(&req.n);
+}
+
+static int cfm_cc_peer(int argc, char **argv, bool add)
+{
+	struct {
+		struct nlmsghdr  n;
+		struct ifinfomsg ifm;
+		char             buf[1024];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.n.nlmsg_type = RTM_SETLINK,
+		.ifm.ifi_family = PF_BRIDGE,
+	};
+	struct rtattr *afspec, *cfm, *peer;
+	__u32 instance = 0, mepid = 0;
+	char *bridge_dev = NULL;
+	bool instance_set = false, mepid_set = false;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "bridge") == 0) {
+			NEXT_ARG();
+			bridge_dev = *argv;
+		} else if (strcmp(*argv, "instance") == 0) {
+			NEXT_ARG();
+			if (get_u32(&instance, *argv, 0))
+				invarg("invalid instance", *argv);
+			instance_set = true;
+		} else if (strcmp(*argv, "mepid") == 0) {
+			NEXT_ARG();
+			if (get_u32(&mepid, *argv, 0) || mepid > 0x1FFF)
+				invarg("invalid mepid (0-8191)", *argv);
+			mepid_set = true;
+		} else {
+			cfm_usage();
+		}
+		argc--; argv++;
+	}
+
+	if (!bridge_dev || !instance_set || !mepid_set) {
+		fprintf(stderr,
+			"Required: bridge DEV instance INSTANCE mepid MEPID\n");
+		return -1;
+	}
+
+	req.ifm.ifi_index = ll_name_to_index(bridge_dev);
+	if (!req.ifm.ifi_index)
+		return nodev(bridge_dev);
+
+	afspec = addattr_nest(&req.n, sizeof(req), IFLA_AF_SPEC);
+	addattr16(&req.n, sizeof(req), IFLA_BRIDGE_FLAGS, BRIDGE_FLAGS_SELF);
+	cfm = addattr_nest(&req.n, sizeof(req), IFLA_BRIDGE_CFM | NLA_F_NESTED);
+	peer = addattr_nest(&req.n, sizeof(req),
+			    (add ? IFLA_BRIDGE_CFM_CC_PEER_MEP_ADD :
+				   IFLA_BRIDGE_CFM_CC_PEER_MEP_REMOVE) |
+			    NLA_F_NESTED);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_PEER_MEP_INSTANCE,
+		  instance);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_PEER_MEPID, mepid);
+	addattr_nest_end(&req.n, peer);
+	addattr_nest_end(&req.n, cfm);
+	addattr_nest_end(&req.n, afspec);
+
+	return cfm_talk(&req.n);
+}
+
+static int cfm_cc_rdi(int argc, char **argv)
+{
+	struct {
+		struct nlmsghdr  n;
+		struct ifinfomsg ifm;
+		char             buf[1024];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.n.nlmsg_type = RTM_SETLINK,
+		.ifm.ifi_family = PF_BRIDGE,
+	};
+	struct rtattr *afspec, *cfm, *rdi;
+	__u32 instance = 0;
+	int rdi_val = -1;
+	char *bridge_dev = NULL;
+	bool instance_set = false;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "bridge") == 0) {
+			NEXT_ARG();
+			bridge_dev = *argv;
+		} else if (strcmp(*argv, "instance") == 0) {
+			NEXT_ARG();
+			if (get_u32(&instance, *argv, 0))
+				invarg("invalid instance", *argv);
+			instance_set = true;
+		} else if (strcmp(*argv, "rdi") == 0) {
+			int ret;
+
+			NEXT_ARG();
+			rdi_val = parse_on_off("rdi", *argv, &ret);
+			if (ret)
+				return ret;
+		} else {
+			cfm_usage();
+		}
+		argc--; argv++;
+	}
+
+	if (!bridge_dev || !instance_set || rdi_val < 0) {
+		fprintf(stderr,
+			"Required: bridge DEV instance INSTANCE rdi { on | off }\n");
+		return -1;
+	}
+
+	req.ifm.ifi_index = ll_name_to_index(bridge_dev);
+	if (!req.ifm.ifi_index)
+		return nodev(bridge_dev);
+
+	afspec = addattr_nest(&req.n, sizeof(req), IFLA_AF_SPEC);
+	addattr16(&req.n, sizeof(req), IFLA_BRIDGE_FLAGS, BRIDGE_FLAGS_SELF);
+	cfm = addattr_nest(&req.n, sizeof(req), IFLA_BRIDGE_CFM | NLA_F_NESTED);
+	rdi = addattr_nest(&req.n, sizeof(req),
+			   IFLA_BRIDGE_CFM_CC_RDI | NLA_F_NESTED);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_RDI_INSTANCE,
+		  instance);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_RDI_RDI, rdi_val);
+	addattr_nest_end(&req.n, rdi);
+	addattr_nest_end(&req.n, cfm);
+	addattr_nest_end(&req.n, afspec);
+
+	return cfm_talk(&req.n);
+}
+
+static int cfm_cc_ccm_tx(int argc, char **argv)
+{
+	struct {
+		struct nlmsghdr  n;
+		struct ifinfomsg ifm;
+		char             buf[1024];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.n.nlmsg_type = RTM_SETLINK,
+		.ifm.ifi_family = PF_BRIDGE,
+	};
+	struct rtattr *afspec, *cfm, *tx;
+	__u32 instance = 0, period = 0;
+	__u32 iftlv = 0, porttlv = 0;
+	__u8 iftlv_value = 0, porttlv_value = 0;
+	int seq = 0;
+	char *bridge_dev = NULL, *dmac = NULL;
+	bool instance_set = false, period_set = false;
+	char abuf[32];
+	int alen;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "bridge") == 0) {
+			NEXT_ARG();
+			bridge_dev = *argv;
+		} else if (strcmp(*argv, "instance") == 0) {
+			NEXT_ARG();
+			if (get_u32(&instance, *argv, 0))
+				invarg("invalid instance", *argv);
+			instance_set = true;
+		} else if (strcmp(*argv, "dmac") == 0) {
+			NEXT_ARG();
+			dmac = *argv;
+		} else if (strcmp(*argv, "seq") == 0) {
+			int ret;
+
+			NEXT_ARG();
+			seq = parse_on_off("seq", *argv, &ret);
+			if (ret)
+				return ret;
+		} else if (strcmp(*argv, "period") == 0) {
+			NEXT_ARG();
+			if (get_u32(&period, *argv, 0))
+				invarg("invalid period", *argv);
+			period_set = true;
+		} else if (strcmp(*argv, "iftlv") == 0) {
+			int ret;
+
+			NEXT_ARG();
+			iftlv = parse_on_off("iftlv", *argv, &ret);
+			if (ret)
+				return ret;
+		} else if (strcmp(*argv, "iftlv-value") == 0) {
+			__u32 v;
+
+			NEXT_ARG();
+			if (get_u32(&v, *argv, 0) || v > 0xff)
+				invarg("invalid iftlv-value", *argv);
+			iftlv_value = v;
+		} else if (strcmp(*argv, "porttlv") == 0) {
+			int ret;
+
+			NEXT_ARG();
+			porttlv = parse_on_off("porttlv", *argv, &ret);
+			if (ret)
+				return ret;
+		} else if (strcmp(*argv, "porttlv-value") == 0) {
+			__u32 v;
+
+			NEXT_ARG();
+			if (get_u32(&v, *argv, 0) || v > 0xff)
+				invarg("invalid porttlv-value", *argv);
+			porttlv_value = v;
+		} else {
+			cfm_usage();
+		}
+		argc--; argv++;
+	}
+
+	if (!bridge_dev || !instance_set || !dmac || !period_set) {
+		fprintf(stderr,
+			"Required: bridge DEV instance INSTANCE dmac LLADDR period PERIOD\n");
+		return -1;
+	}
+
+	req.ifm.ifi_index = ll_name_to_index(bridge_dev);
+	if (!req.ifm.ifi_index)
+		return nodev(bridge_dev);
+
+	alen = ll_addr_a2n(abuf, sizeof(abuf), dmac);
+	if (alen != ETH_ALEN) {
+		fprintf(stderr, "Invalid address %s\n", dmac);
+		return -1;
+	}
+
+	afspec = addattr_nest(&req.n, sizeof(req), IFLA_AF_SPEC);
+	addattr16(&req.n, sizeof(req), IFLA_BRIDGE_FLAGS, BRIDGE_FLAGS_SELF);
+	cfm = addattr_nest(&req.n, sizeof(req), IFLA_BRIDGE_CFM | NLA_F_NESTED);
+	tx = addattr_nest(&req.n, sizeof(req),
+			  IFLA_BRIDGE_CFM_CC_CCM_TX | NLA_F_NESTED);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_CCM_TX_INSTANCE,
+		  instance);
+	addattr_l(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_CCM_TX_DMAC, abuf,
+		  ETH_ALEN);
+	addattr32(&req.n, sizeof(req),
+		  IFLA_BRIDGE_CFM_CC_CCM_TX_SEQ_NO_UPDATE, seq);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_CCM_TX_PERIOD,
+		  period);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_CCM_TX_IF_TLV,
+		  iftlv);
+	addattr8(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_CCM_TX_IF_TLV_VALUE,
+		 iftlv_value);
+	addattr32(&req.n, sizeof(req), IFLA_BRIDGE_CFM_CC_CCM_TX_PORT_TLV,
+		  porttlv);
+	addattr8(&req.n, sizeof(req),
+		 IFLA_BRIDGE_CFM_CC_CCM_TX_PORT_TLV_VALUE, porttlv_value);
+	addattr_nest_end(&req.n, tx);
+	addattr_nest_end(&req.n, cfm);
+	addattr_nest_end(&req.n, afspec);
+
+	return cfm_talk(&req.n);
+}
+
+static int cfm_cc(int argc, char **argv)
+{
+	if (argc <= 0)
+		cfm_usage();
+
+	if (strcmp(*argv, "config") == 0)
+		return cfm_cc_config(argc - 1, argv + 1);
+	if (strcmp(*argv, "peer") == 0) {
+		if (argc < 2)
+			cfm_usage();
+		if (strcmp(argv[1], "add") == 0)
+			return cfm_cc_peer(argc - 2, argv + 2, true);
+		if (strcmp(argv[1], "delete") == 0 ||
+		    strcmp(argv[1], "del") == 0)
+			return cfm_cc_peer(argc - 2, argv + 2, false);
+		cfm_usage();
+	}
+	if (strcmp(*argv, "rdi") == 0)
+		return cfm_cc_rdi(argc - 1, argv + 1);
+	if (strcmp(*argv, "ccm-tx") == 0)
+		return cfm_cc_ccm_tx(argc - 1, argv + 1);
+
+	cfm_usage();
+	return -1;
+}
+
+/* "bridge cfm show { config | status }" */
+
+static __u32 cfm_get_u32(struct rtattr *tb[], int type)
+{
+	return tb[type] ? rta_getattr_u32(tb[type]) : 0;
+}
+
+static __u8 cfm_get_u8(struct rtattr *tb[], int type)
+{
+	return tb[type] ? rta_getattr_u8(tb[type]) : 0;
+}
+
+static void cfm_print_mac(struct rtattr *attr, const char *key,
+			  const char *fmt)
+{
+	SPRINT_BUF(b);
+
+	if (!attr || RTA_PAYLOAD(attr) < ETH_ALEN)
+		return;
+	ll_addr_n2a(RTA_DATA(attr), ETH_ALEN, 0, b, sizeof(b));
+	print_string(PRINT_ANY, key, fmt, b);
+}
+
+static void cfm_print_mep_create(struct rtattr *attr)
+{
+	struct rtattr *tb[IFLA_BRIDGE_CFM_MEP_CREATE_MAX + 1];
+	const char *port;
+
+	parse_rtattr_nested(tb, IFLA_BRIDGE_CFM_MEP_CREATE_MAX, attr);
+
+	print_uint(PRINT_ANY, "instance", "    mep %u",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_MEP_CREATE_INSTANCE));
+	print_string(PRINT_ANY, "domain", " domain %s",
+		     cfm_get_u32(tb, IFLA_BRIDGE_CFM_MEP_CREATE_DOMAIN) ==
+		     BR_CFM_VLAN ? "vlan" : "port");
+	print_string(PRINT_ANY, "direction", " direction %s",
+		     cfm_get_u32(tb, IFLA_BRIDGE_CFM_MEP_CREATE_DIRECTION) ==
+		     BR_CFM_MEP_DIRECTION_UP ? "up" : "down");
+	port = ll_index_to_name(cfm_get_u32(tb, IFLA_BRIDGE_CFM_MEP_CREATE_IFINDEX));
+	print_string(PRINT_ANY, "port", " port %s", port);
+	print_nl();
+}
+
+static void cfm_print_mep_config(struct rtattr *attr)
+{
+	struct rtattr *tb[IFLA_BRIDGE_CFM_MEP_CONFIG_MAX + 1];
+
+	parse_rtattr_nested(tb, IFLA_BRIDGE_CFM_MEP_CONFIG_MAX, attr);
+
+	cfm_print_mac(tb[IFLA_BRIDGE_CFM_MEP_CONFIG_UNICAST_MAC], "address",
+		      "        address %s");
+	print_uint(PRINT_ANY, "level", " level %u",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_MEP_CONFIG_MDLEVEL));
+	print_uint(PRINT_ANY, "mepid", " mepid %u",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_MEP_CONFIG_MEPID));
+	print_nl();
+}
+
+static void cfm_print_cc_config(struct rtattr *attr)
+{
+	struct rtattr *tb[IFLA_BRIDGE_CFM_CC_CONFIG_MAX + 1];
+	char maid[CFM_MAID_LENGTH * 2 + 1] = "";
+
+	parse_rtattr_nested(tb, IFLA_BRIDGE_CFM_CC_CONFIG_MAX, attr);
+
+	open_json_object("cc");
+	print_on_off(PRINT_ANY, "enable", "        cc enable %s",
+		     cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_CONFIG_ENABLE));
+	print_string(PRINT_ANY, "interval", " interval %s",
+		     cfm_interval_str(cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL)));
+	if (tb[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_MAID])
+		hexstring_n2a(RTA_DATA(tb[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_MAID]),
+			      RTA_PAYLOAD(tb[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_MAID]),
+			      maid, sizeof(maid));
+	print_string(PRINT_ANY, "maid", " maid %s", maid);
+	print_nl();
+	close_json_object();
+}
+
+static void cfm_print_cc_rdi(struct rtattr *attr)
+{
+	struct rtattr *tb[IFLA_BRIDGE_CFM_CC_RDI_MAX + 1];
+
+	parse_rtattr_nested(tb, IFLA_BRIDGE_CFM_CC_RDI_MAX, attr);
+
+	print_on_off(PRINT_ANY, "rdi", "        rdi %s",
+		     cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_RDI_RDI));
+	print_nl();
+}
+
+static void cfm_print_cc_ccm_tx(struct rtattr *attr)
+{
+	struct rtattr *tb[IFLA_BRIDGE_CFM_CC_CCM_TX_MAX + 1];
+
+	parse_rtattr_nested(tb, IFLA_BRIDGE_CFM_CC_CCM_TX_MAX, attr);
+
+	open_json_object("ccm_tx");
+	cfm_print_mac(tb[IFLA_BRIDGE_CFM_CC_CCM_TX_DMAC], "dmac",
+		      "        ccm-tx dmac %s");
+	print_on_off(PRINT_ANY, "seq", " seq %s",
+		     cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_CCM_TX_SEQ_NO_UPDATE));
+	print_uint(PRINT_ANY, "period", " period %u",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_CCM_TX_PERIOD));
+	print_on_off(PRINT_ANY, "iftlv", " iftlv %s",
+		     cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_CCM_TX_IF_TLV));
+	print_uint(PRINT_ANY, "iftlv_value", " iftlv-value %u",
+		   cfm_get_u8(tb, IFLA_BRIDGE_CFM_CC_CCM_TX_IF_TLV_VALUE));
+	print_on_off(PRINT_ANY, "porttlv", " porttlv %s",
+		     cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_CCM_TX_PORT_TLV));
+	print_uint(PRINT_ANY, "porttlv_value", " porttlv-value %u",
+		   cfm_get_u8(tb, IFLA_BRIDGE_CFM_CC_CCM_TX_PORT_TLV_VALUE));
+	print_nl();
+	close_json_object();
+}
+
+static void cfm_print_cc_peer(struct rtattr *attr)
+{
+	struct rtattr *tb[IFLA_BRIDGE_CFM_CC_PEER_MEP_MAX + 1];
+
+	parse_rtattr_nested(tb, IFLA_BRIDGE_CFM_CC_PEER_MEP_MAX, attr);
+
+	open_json_object(NULL);
+	print_uint(PRINT_ANY, "mepid", "        peer mepid %u",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_PEER_MEPID));
+	print_nl();
+	close_json_object();
+}
+
+static void cfm_print_mep_status(struct rtattr *attr)
+{
+	struct rtattr *tb[IFLA_BRIDGE_CFM_MEP_STATUS_MAX + 1];
+
+	parse_rtattr_nested(tb, IFLA_BRIDGE_CFM_MEP_STATUS_MAX, attr);
+
+	print_uint(PRINT_ANY, "instance", "    mep %u",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_MEP_STATUS_INSTANCE));
+	print_bool(PRINT_ANY, "opcode_unexp_seen", " opcode_unexp_seen %s",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_MEP_STATUS_OPCODE_UNEXP_SEEN));
+	print_bool(PRINT_ANY, "version_unexp_seen", " version_unexp_seen %s",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_MEP_STATUS_VERSION_UNEXP_SEEN));
+	print_bool(PRINT_ANY, "rx_level_low_seen", " rx_level_low_seen %s",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_MEP_STATUS_RX_LEVEL_LOW_SEEN));
+	print_nl();
+}
+
+static void cfm_print_cc_peer_status(struct rtattr *attr)
+{
+	struct rtattr *tb[IFLA_BRIDGE_CFM_CC_PEER_STATUS_MAX + 1];
+
+	parse_rtattr_nested(tb, IFLA_BRIDGE_CFM_CC_PEER_STATUS_MAX, attr);
+
+	open_json_object(NULL);
+	print_uint(PRINT_ANY, "mepid", "        peer mepid %u",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_PEER_STATUS_PEER_MEPID));
+	print_bool(PRINT_ANY, "ccm_defect", " ccm_defect %s",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_PEER_STATUS_CCM_DEFECT));
+	print_bool(PRINT_ANY, "rdi", " rdi %s",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_PEER_STATUS_RDI));
+	print_uint(PRINT_ANY, "port_tlv_value", " port_tlv_value %u",
+		   cfm_get_u8(tb, IFLA_BRIDGE_CFM_CC_PEER_STATUS_PORT_TLV_VALUE));
+	print_uint(PRINT_ANY, "if_tlv_value", " if_tlv_value %u",
+		   cfm_get_u8(tb, IFLA_BRIDGE_CFM_CC_PEER_STATUS_IF_TLV_VALUE));
+	print_bool(PRINT_ANY, "seen", " seen %s",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_PEER_STATUS_SEEN));
+	print_bool(PRINT_ANY, "tlv_seen", " tlv_seen %s",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_PEER_STATUS_TLV_SEEN));
+	print_bool(PRINT_ANY, "seq_unexp_seen", " seq_unexp_seen %s",
+		   cfm_get_u32(tb, IFLA_BRIDGE_CFM_CC_PEER_STATUS_SEQ_UNEXP_SEEN));
+	print_nl();
+	close_json_object();
+}
+
+/* The kernel sends one nest per MEP followed by its sub-nests and one
+ * nest per peer, so walk them in order and group by MEP.
+ */
+static int cfm_show_filter(struct nlmsghdr *n, void *arg)
+{
+	struct ifinfomsg *ifi = NLMSG_DATA(n);
+	int len = n->nlmsg_len - NLMSG_LENGTH(sizeof(*ifi));
+	bool status = !strcmp(arg, "status");
+	bool dev_open = false, mep_open = false, peers_open = false;
+	struct rtattr *afspec, *cfm, *a;
+
+	if (len < 0)
+		return -1;
+
+	if (n->nlmsg_type != RTM_NEWLINK || ifi->ifi_family != AF_BRIDGE)
+		return 0;
+
+	if (filter_index && filter_index != (unsigned int)ifi->ifi_index)
+		return 0;
+
+	afspec = parse_rtattr_one(IFLA_AF_SPEC, IFLA_RTA(ifi), len);
+	if (!afspec)
+		return 0;
+
+	cfm = parse_rtattr_one_nested(NLA_F_NESTED | IFLA_BRIDGE_CFM, afspec);
+	if (!cfm)
+		return 0;
+
+	rtattr_for_each_nested(a, cfm) {
+		unsigned short type = a->rta_type & NLA_TYPE_MASK;
+		bool new_mep, peer;
+
+		new_mep = type == (status ? IFLA_BRIDGE_CFM_MEP_STATUS_INFO :
+					    IFLA_BRIDGE_CFM_MEP_CREATE_INFO);
+		peer = type == (status ? IFLA_BRIDGE_CFM_CC_PEER_STATUS_INFO :
+					 IFLA_BRIDGE_CFM_CC_PEER_MEP_INFO);
+
+		if (!new_mep && !mep_open)
+			continue;
+
+		if (peers_open && !peer) {
+			close_json_array(PRINT_JSON, NULL);
+			peers_open = false;
+		}
+		if (new_mep) {
+			if (mep_open)
+				close_json_object();
+			if (!dev_open) {
+				open_json_object(NULL);
+				print_color_string(PRINT_ANY, COLOR_IFNAME,
+						   "ifname", "%s\n",
+						   ll_index_to_name(ifi->ifi_index));
+				open_json_array(PRINT_JSON, "meps");
+				dev_open = true;
+			}
+			open_json_object(NULL);
+			mep_open = true;
+		}
+		if (peer && !peers_open) {
+			open_json_array(PRINT_JSON, "peers");
+			peers_open = true;
+		}
+
+		switch (type) {
+		case IFLA_BRIDGE_CFM_MEP_CREATE_INFO:
+			cfm_print_mep_create(a);
+			break;
+		case IFLA_BRIDGE_CFM_MEP_CONFIG_INFO:
+			cfm_print_mep_config(a);
+			break;
+		case IFLA_BRIDGE_CFM_CC_CONFIG_INFO:
+			cfm_print_cc_config(a);
+			break;
+		case IFLA_BRIDGE_CFM_CC_RDI_INFO:
+			cfm_print_cc_rdi(a);
+			break;
+		case IFLA_BRIDGE_CFM_CC_CCM_TX_INFO:
+			cfm_print_cc_ccm_tx(a);
+			break;
+		case IFLA_BRIDGE_CFM_CC_PEER_MEP_INFO:
+			cfm_print_cc_peer(a);
+			break;
+		case IFLA_BRIDGE_CFM_MEP_STATUS_INFO:
+			cfm_print_mep_status(a);
+			break;
+		case IFLA_BRIDGE_CFM_CC_PEER_STATUS_INFO:
+			cfm_print_cc_peer_status(a);
+			break;
+		}
+	}
+
+	if (peers_open)
+		close_json_array(PRINT_JSON, NULL);
+	if (mep_open)
+		close_json_object();
+	if (dev_open) {
+		close_json_array(PRINT_JSON, NULL);
+		close_json_object();
+	}
+
+	return 0;
+}
+
+static int cfm_show(int argc, char **argv, const char *what)
+{
+	char *bridge_dev = NULL;
+	__u32 filt_mask;
+	int ret;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "bridge") == 0) {
+			NEXT_ARG();
+			bridge_dev = *argv;
+		} else {
+			cfm_usage();
+		}
+		argc--; argv++;
+	}
+
+	if (bridge_dev) {
+		filter_index = ll_name_to_index(bridge_dev);
+		if (!filter_index)
+			return nodev(bridge_dev);
+	}
+
+	filt_mask = !strcmp(what, "config") ? RTEXT_FILTER_CFM_CONFIG :
+					       RTEXT_FILTER_CFM_STATUS;
+
+	if (rtnl_linkdump_req_filter(&rth, PF_BRIDGE, filt_mask) < 0) {
+		fprintf(stderr, "Cannot send dump request\n");
+		return -1;
+	}
+
+	new_json_obj(json);
+	ret = rtnl_dump_filter(&rth, cfm_show_filter, (void *)what);
+	delete_json_obj();
+	if (ret < 0) {
+		fprintf(stderr, "Dump terminated\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int cfm_show_cmd(int argc, char **argv)
+{
+	if (argc <= 0)
+		cfm_usage();
+
+	if (strcmp(*argv, "config") == 0)
+		return cfm_show(argc - 1, argv + 1, "config");
+	if (strcmp(*argv, "status") == 0)
+		return cfm_show(argc - 1, argv + 1, "status");
+
+	cfm_usage();
+	return -1;
+}
+
+int do_cfm(int argc, char **argv)
+{
+	if (argc <= 0)
+		cfm_usage();
+
+	if (strcmp(*argv, "mep") == 0)
+		return cfm_mep(argc - 1, argv + 1);
+	if (strcmp(*argv, "cc") == 0)
+		return cfm_cc(argc - 1, argv + 1);
+	if (strcmp(*argv, "show") == 0)
+		return cfm_show_cmd(argc - 1, argv + 1);
+	if (strcmp(*argv, "help") == 0)
+		cfm_usage();
+
+	fprintf(stderr, "Command \"%s\" is unknown, try \"bridge cfm help\".\n",
+		*argv);
+	return -1;
+}
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index d2323521..13b02bb3 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -13,7 +13,7 @@ bridge \- show / manipulate bridge addresses and devices
 
 .ti -8
 .IR OBJECT " := { "
-.BR link " | " fdb " | " mdb " | " vlan " | " vni " | " monitor " }"
+.BR link " | " fdb " | " mdb " | " vlan " | " vni " | " cfm " | " monitor " }"
 .sp
 
 .ti -8
@@ -1666,6 +1666,200 @@ option, the command displays per-vni traffic statistics.
 .BI dev " NAME"
 shows vni filtering table associated with the vxlan device
 
+.SH bridge cfm - Connectivity Fault Management
+
+.B cfm
+objects are IEEE 802.1ag Maintenance End Points (MEPs) on a bridge. A MEP
+sends Continuity Check Messages (CCMs) out of one bridge port and tracks
+the CCMs it receives from a list of peer MEPs. All commands take the
+bridge device, not the port.
+
+The kernel only supports port domain, down MEPs.
+
+.SS bridge cfm mep add - create a MEP
+
+.B bridge cfm mep add bridge
+.I DEV
+.B instance
+.I INSTANCE
+.B port
+.I PORT
+.RB "[ " domain " { " port " | " vlan " } ]"
+.RB "[ " direction " { " down " | " up " } ]"
+
+.TP
+.BI instance " INSTANCE"
+a number that identifies the MEP on this bridge.
+
+.TP
+.BI port " PORT"
+the bridge port the MEP sits on. Only one MEP per port.
+
+.TP
+.BI domain " { port | vlan }"
+the MEP domain. Default is
+.BR port ,
+the kernel rejects
+.BR vlan .
+
+.TP
+.BI direction " { down | up }"
+the MEP direction. Default is
+.BR down ,
+the kernel rejects
+.BR up .
+
+.SS bridge cfm mep del - delete a MEP
+
+.B bridge cfm mep del bridge
+.I DEV
+.B instance
+.I INSTANCE
+
+.SS bridge cfm mep set - set the MEP address, level and ID
+
+.B bridge cfm mep set bridge
+.I DEV
+.B instance
+.I INSTANCE
+.B address
+.I LLADDR
+.B level
+.I LEVEL
+.B mepid
+.I MEPID
+
+.TP
+.BI address " LLADDR"
+source MAC address of the CCMs this MEP sends.
+
+.TP
+.BI level " LEVEL"
+the MD level, 0 to 7.
+
+.TP
+.BI mepid " MEPID"
+the MEP ID, 0 to 8191.
+
+.SS bridge cfm cc config - configure Continuity Check
+
+.B bridge cfm cc config bridge
+.I DEV
+.B instance
+.I INSTANCE
+.B enable
+.RB "{ " on " | " off " }"
+.B interval
+.I INTERVAL
+.B maid
+.I MAID
+
+.TP
+.BI enable " { on | off }"
+turn CCM reception and peer tracking on or off.
+
+.TP
+.BI interval " INTERVAL"
+the CCM interval, one of
+.BR 3ms3 ", " 10ms ", " 100ms ", " 1s ", " 10s ", " 1m ", " 10m .
+It is used both for sending and for the peer loss timeout. The kernel runs
+CCMs from a workqueue, so the real interval is rounded up to jiffies and
+can be noticeably longer than the name, most of all for
+.BR 3ms3 .
+
+.TP
+.BI maid " MAID"
+the Maintenance Association ID as a hex string, up to 48 bytes. Shorter
+strings are padded with zeros. Received CCMs must carry the same MAID.
+
+.SS bridge cfm cc peer - add or delete a peer MEP
+
+.B bridge cfm cc peer
+.RB "{ " add " | " del " }"
+.B bridge
+.I DEV
+.B instance
+.I INSTANCE
+.B mepid
+.I MEPID
+
+CCMs from MEP IDs not in this list are not tracked.
+
+.SS bridge cfm cc rdi - set the RDI bit
+
+.B bridge cfm cc rdi bridge
+.I DEV
+.B instance
+.I INSTANCE
+.B rdi
+.RB "{ " on " | " off " }"
+
+Sets or clears the Remote Defect Indication bit in the CCMs this MEP sends.
+
+.SS bridge cfm cc ccm-tx - send CCMs
+
+.B bridge cfm cc ccm-tx bridge
+.I DEV
+.B instance
+.I INSTANCE
+.B dmac
+.I LLADDR
+.B period
+.I PERIOD
+.RB "[ " seq " { " on " | " off " } ]"
+.RB "[ " iftlv " { " on " | " off " } ]"
+.RB "[ " iftlv-value
+.IR VALUE " ]"
+.RB "[ " porttlv " { " on " | " off " } ]"
+.RB "[ " porttlv-value
+.IR VALUE " ]"
+
+.TP
+.BI dmac " LLADDR"
+destination MAC address of the CCMs, usually
+.BR 01:80:c2:00:00:3X
+where X is the MD level.
+
+.TP
+.BI period " PERIOD"
+how many seconds to keep sending. The kernel stops by itself after that,
+so run the command again to keep going.
+.B 0
+stops sending.
+
+.TP
+.BI seq " { on | off }"
+put an incrementing sequence number in each CCM. Default
+.BR off ,
+which sends 0.
+
+.TP
+.BI iftlv " { on | off }"
+add an Interface Status TLV with value
+.BR iftlv-value .
+
+.TP
+.BI porttlv " { on | off }"
+add a Port Status TLV with value
+.BR porttlv-value .
+
+.SS bridge cfm show - show configuration or status
+
+.B bridge cfm show
+.RB "{ " config " | " status " }"
+.RB "[ " bridge
+.IR DEV " ]"
+
+.B config
+shows every MEP with its CC, RDI, CCM transmit settings and peers.
+.B status
+shows the MEP and peer state. The
+.BR seen ", " tlv_seen ", " seq_unexp_seen
+and the MEP
+.B _seen
+flags are cleared by the kernel each time status is read, so they mean
+"since the last read".
+
 .SH bridge monitor - state monitoring
 
 The
-- 
2.53.0

