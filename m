Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD115B57B
	for <bridge@lists.linux.dev>; Tue,  2 Jul 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922116; cv=none; b=FqT/Y8TWIe8/THZQ+pS6+KjOuPXgG8A8X4lnt13PhV94pECCxApxnfwvgo5uor3oPTeirhEJGJZnMIfjc03YfEIEEb5NWHebzLZW6MgKrospPsRi3zf1I1JcTq701+ajCrT1Rpy1IcTga121kGiJhXszMTkGbwhYb1fCBXQtJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922116; c=relaxed/simple;
	bh=hsftkSP2BDiz9TglzlG9ee1wDJWfkHJpC75tpg0xtkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOJIbBHl+FpmGB/ZYojtZKvTs3EiPugXxK1HqkXx0AoOm8DJm/hcgoEawRlHFQlkGeqLq47mO//4BF6JkM5YGkI5+4MF7mKleTlCT4+ZzT2VVMO8e11ZRucF8shb2yWxQ+Xw8d05jUhDjBoSfmdK52bgqi9C/2wb7hjrVAbz7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=ewbBoQP/; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="ewbBoQP/"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee4ab4076bso44251301fa.0
        for <bridge@lists.linux.dev>; Tue, 02 Jul 2024 05:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1719922112; x=1720526912; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8j4YJnckxoKym+ZcM9ZDthFzWyUhM2Uf5fbtBbrDdx4=;
        b=ewbBoQP/a3js7yXGibqY3O/5GQrXSfFeICFzyG63k5j/nGwX7njCiGx5ylWy+2XSMk
         X3HjGQwnHC35WQMiuVFhLdaxbjy6ODnb9BMYtmh3Q1BS6Cs5X/F89sOaiySaeDUAhjB+
         ZzoAZkwoe5UIHxunMABcUoLA+s9IUyx5qiXztbvF648HyqoFIuXllTQ+4dXXINZ2RyOJ
         vdB8e3R3+PyyDdxwH4O1o6EVAtvpM1kQsUt69VRXizKACZDKy0V5klSW8feGmJdhmzGF
         2cdXI2t1pbuukxHZlVZ1QE+6JXzFFaOw2jm+3OOnbUgZcKaKhR85Ygd/kTwOMLAjhOUz
         NY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719922112; x=1720526912;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8j4YJnckxoKym+ZcM9ZDthFzWyUhM2Uf5fbtBbrDdx4=;
        b=kZvFo4L5he/cLvKL/fMFqFAzesAz2rh2FnjO2iErSs3DPpeBBHzUxbE5d0y+NxaI7l
         5vO3pPep6obrutr70i5NhdgkA5ZZtTmhZkkYcWD/j9Z1K8l6vBMlkoEzHkf84jHV9YLS
         ZgVexGumTn4pYsHlgkL9QE5+I3YTXK1NXBsA9+byiuqJb5B5X/+XOxLCNQeikc7XSaAa
         1tIjy6F6pRIBX0RDxbq2KFOMF4vk5XJYRnvTtFEk88XGAOhRjZxIX/Dc82M3UmJPmYOm
         /stOdaRl3HNRLZT8paZZJK6Bq24uK62UKUmvWUvaR6arUqFNIbCLbxurE8FWJun2WiWf
         JIfA==
X-Forwarded-Encrypted: i=1; AJvYcCWb3lZl/Z/x2WJzCE2IzDNB5uZFnII/Ct2IlGqm0luENXjh7HYi2eX5YLjQV1yqGZp3O1VDXlSek8fRJbhP7bLbRDyxPnDA
X-Gm-Message-State: AOJu0YyF3UEvqWZINkYi3v19dFnUdo9NJn7cqqVLojq0TqBOZuBKg834
	Ma8mm5aB1TH+JTMxCEwajXwzapVABDi/NdY1hw0isGYy2VR8rUDLg2i/3O9Dic0=
X-Google-Smtp-Source: AGHT+IGr4wQPv5afUFDcinzrJ0DCOrcAewoDqVAFuxi9J7/AILw78OE4VOEWMCvm39t77WUoK8ZTEA==
X-Received: by 2002:a05:6512:3e0c:b0:52c:ca8d:d1c with SMTP id 2adb3069b0e04-52e825976ecmr2619228e87.2.1719922112246;
        Tue, 02 Jul 2024 05:08:32 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-176-10-146-181.NA.cust.bahnhof.se. [176.10.146.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab1064asm1799414e87.103.2024.07.02.05.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:08:31 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: liuhangbin@gmail.com
Subject: [PATCH v3 iproute2 2/4] bridge: Remove duplicated textification macros
Date: Tue,  2 Jul 2024 14:08:03 +0200
Message-Id: <20240702120805.2391594-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702120805.2391594-1-tobias@waldekranz.com>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

include/utils.h already provides textify(), which is functionally
equivalent to __stringify().

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 bridge/vlan.c | 41 +++++++++++++++++++----------------------
 bridge/vni.c  | 15 ++++++---------
 2 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 0a7e6c45..70f01aff 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -28,9 +28,6 @@ enum vlan_show_subject {
 
 #define VLAN_ID_LEN 9
 
-#define __stringify_1(x...) #x
-#define __stringify(x...) __stringify_1(x)
-
 static void usage(void)
 {
 	fprintf(stderr,
@@ -579,7 +576,7 @@ static void open_vlan_port(int ifi_index, enum vlan_show_subject subject)
 {
 	open_json_object(NULL);
 	print_color_string(PRINT_ANY, COLOR_IFNAME, "ifname",
-			   "%-" __stringify(IFNAMSIZ) "s  ",
+			   "%-" textify(IFNAMSIZ) "s  ",
 			   ll_index_to_name(ifi_index));
 	open_json_array(PRINT_JSON,
 			subject == VLAN_SHOW_VLAN ? "vlans": "tunnels");
@@ -643,7 +640,7 @@ static void print_vlan_tunnel_info(struct rtattr *tb, int ifindex)
 			opened = true;
 		} else {
 			print_string(PRINT_FP, NULL,
-				     "%-" __stringify(IFNAMSIZ) "s  ", "");
+				     "%-" textify(IFNAMSIZ) "s  ", "");
 		}
 
 		open_json_object(NULL);
@@ -716,13 +713,13 @@ static void print_vlan_flags(__u16 flags)
 
 static void __print_one_vlan_stats(const struct bridge_vlan_xstats *vstats)
 {
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    ", "");
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
 	print_lluint(PRINT_ANY, "rx_bytes", "RX: %llu bytes",
 		     vstats->rx_bytes);
 	print_lluint(PRINT_ANY, "rx_packets", " %llu packets\n",
 		     vstats->rx_packets);
 
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    ", "");
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
 	print_lluint(PRINT_ANY, "tx_bytes", "TX: %llu bytes",
 		     vstats->tx_bytes);
 	print_lluint(PRINT_ANY, "tx_packets", " %llu packets\n",
@@ -776,7 +773,7 @@ static void print_vlan_stats_attr(struct rtattr *attr, int ifindex)
 			found_vlan = true;
 		} else {
 			print_string(PRINT_FP, NULL,
-				     "%-" __stringify(IFNAMSIZ) "s  ", "");
+				     "%-" textify(IFNAMSIZ) "s  ", "");
 		}
 		print_one_vlan_stats(vstats);
 	}
@@ -822,7 +819,7 @@ static void print_vlan_router_ports(struct rtattr *rattr)
 	int rem = RTA_PAYLOAD(rattr);
 	struct rtattr *i;
 
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    ", "");
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
 	open_json_array(PRINT_ANY, is_json_context() ? "router_ports" :
 						       "router ports: ");
 	for (i = RTA_DATA(rattr); RTA_OK(i, rem); i = RTA_NEXT(i, rem)) {
@@ -834,7 +831,7 @@ static void print_vlan_router_ports(struct rtattr *rattr)
 			print_nl();
 			/* start: IFNAMSIZ + 4 + strlen("router ports: ") */
 			print_string(PRINT_FP, NULL,
-				     "%-" __stringify(IFNAMSIZ) "s    "
+				     "%-" textify(IFNAMSIZ) "s    "
 				     "              ",
 				     "");
 		}
@@ -872,11 +869,11 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
 		vlan_rtm_cur_ifidx = ifindex;
 	} else {
 		open_json_object(NULL);
-		print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s  ", "");
+		print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s  ", "");
 	}
 	print_range("vlan", vid, vrange);
 	print_nl();
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    ", "");
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
 	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING]) {
 		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING];
 		print_uint(PRINT_ANY, "mcast_snooping", "mcast_snooping %u ",
@@ -1012,12 +1009,12 @@ static void print_vlan_opts(struct rtattr *a, int ifindex)
 		vlan_rtm_cur_ifidx = ifindex;
 	} else {
 		open_json_object(NULL);
-		print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s  ", "");
+		print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s  ", "");
 	}
 	print_range("vlan", vinfo->vid, vrange);
 	print_vlan_flags(vinfo->flags);
 	print_nl();
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    ", "");
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
 	print_stp_state(state);
 	if (vtb[BRIDGE_VLANDB_ENTRY_MCAST_ROUTER]) {
 		vattr = vtb[BRIDGE_VLANDB_ENTRY_MCAST_ROUTER];
@@ -1155,8 +1152,8 @@ static int vlan_show(int argc, char **argv, int subject)
 		}
 
 		if (!is_json_context()) {
-			printf("%-" __stringify(IFNAMSIZ) "s  %-"
-			       __stringify(VLAN_ID_LEN) "s", "port",
+			printf("%-" textify(IFNAMSIZ) "s  %-"
+			       textify(VLAN_ID_LEN) "s", "port",
 			       "vlan-id");
 			printf("\n");
 		}
@@ -1183,8 +1180,8 @@ static int vlan_show(int argc, char **argv, int subject)
 		}
 
 		if (!is_json_context()) {
-			printf("%-" __stringify(IFNAMSIZ) "s  %-"
-			       __stringify(VLAN_ID_LEN) "s", "port",
+			printf("%-" textify(IFNAMSIZ) "s  %-"
+			       textify(VLAN_ID_LEN) "s", "port",
 			       "vlan-id");
 			if (subject == VLAN_SHOW_TUNNELINFO)
 				printf("  tunnel-id");
@@ -1207,7 +1204,7 @@ static int vlan_show(int argc, char **argv, int subject)
 		}
 
 		if (!is_json_context())
-			printf("%-" __stringify(IFNAMSIZ) "s  vlan-id\n",
+			printf("%-" textify(IFNAMSIZ) "s  vlan-id\n",
 			       "port");
 
 		if (rtnl_dump_filter(&rth, print_vlan_stats, stdout) < 0) {
@@ -1269,8 +1266,8 @@ static int vlan_global_show(int argc, char **argv)
 	}
 
 	if (!is_json_context()) {
-		printf("%-" __stringify(IFNAMSIZ) "s  %-"
-		       __stringify(VLAN_ID_LEN) "s", "port",
+		printf("%-" textify(IFNAMSIZ) "s  %-"
+		       textify(VLAN_ID_LEN) "s", "port",
 		       "vlan-id");
 		printf("\n");
 	}
@@ -1318,7 +1315,7 @@ static void print_vlan_info(struct rtattr *tb, int ifindex)
 			opened = true;
 		} else {
 			print_string(PRINT_FP, NULL, "%-"
-				     __stringify(IFNAMSIZ) "s  ", "");
+				     textify(IFNAMSIZ) "s  ", "");
 		}
 
 		open_json_object(NULL);
diff --git a/bridge/vni.c b/bridge/vni.c
index e1f981fc..57b04c8c 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -27,9 +27,6 @@ static unsigned int filter_index;
 /* max len of "<start>-<end>" */
 #define VXLAN_ID_LEN 17
 
-#define __stringify_1(x...) #x
-#define __stringify(x...) __stringify_1(x)
-
 static void usage(void)
 {
 	fprintf(stderr,
@@ -153,7 +150,7 @@ static void open_vni_port(int ifi_index)
 {
 	open_json_object(NULL);
 	print_color_string(PRINT_ANY, COLOR_IFNAME, "ifname",
-			   "%-" __stringify(IFNAMSIZ) "s  ",
+			   "%-" textify(IFNAMSIZ) "s  ",
 			   ll_index_to_name(ifi_index));
 	open_json_array(PRINT_JSON, "vnis");
 }
@@ -174,7 +171,7 @@ static void print_vnifilter_entry_stats(struct rtattr *stats_attr)
 			   RTA_PAYLOAD(stats_attr), NLA_F_NESTED);
 
 	print_nl();
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    RX: ",
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    RX: ",
 		     "");
 
 	if (stb[VNIFILTER_ENTRY_STATS_RX_BYTES]) {
@@ -195,7 +192,7 @@ static void print_vnifilter_entry_stats(struct rtattr *stats_attr)
 	}
 
 	print_nl();
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    TX: ",
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    TX: ",
 		     "");
 
 	if (stb[VNIFILTER_ENTRY_STATS_TX_BYTES]) {
@@ -327,7 +324,7 @@ int print_vnifilter_rtm(struct nlmsghdr *n, void *arg)
 			open_vni_port(tmsg->ifindex);
 			opened = true;
 		} else {
-			print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s  ", "");
+			print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s  ", "");
 		}
 
 		print_vni(t, tmsg->ifindex);
@@ -373,8 +370,8 @@ static int vni_show(int argc, char **argv)
 	}
 
 	if (!is_json_context())
-		printf("%-" __stringify(IFNAMSIZ) "s  %-"
-		       __stringify(VXLAN_ID_LEN) "s  group/remote\n", "dev",
+		printf("%-" textify(IFNAMSIZ) "s  %-"
+		       textify(VXLAN_ID_LEN) "s  group/remote\n", "dev",
 		       "vni");
 
 	ret = rtnl_dump_filter(&rth, print_vnifilter_rtm, NULL);
-- 
2.34.1

