Received: from a8-176.smtp-out.amazonses.com (a8-176.smtp-out.amazonses.com [54.240.8.176])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270832DB7AD
	for <bridge@lists.linux.dev>; Mon,  2 Feb 2026 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059385; cv=none; b=Kb6tNRc0ZbTusXTvon1PJRvBVGpV8rNM0z+N17a+1M7GjSIL4MaXsM6K8c0gG6vXVs8e+CaltDSAz23Z2Xov6/cqOWYv0Az484pnM5nJ5NCrP842Tyhh5XjhJwjRGICYB037JInXeLWCaxJYPRa1S15snrQ4DfxjgMwccVM/NJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059385; c=relaxed/simple;
	bh=MZ4XAg06krB6sMylc7OqkNxkgzBWL3z6L/Nijdwu3LM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6PB3c3FTqQw0AVN+q8kqET6m9A02fy3kmMfFjgL0nuIzTFu1cs+6jc7ysQa0Nnijhj16Rir4i5PMFRlWPS57SlNMCBGZ/M94LQsErtysAqupaRq2mtMuPcyxGkCw4kgUUJjM5ioNDf78LacAp+4rDGIxHKksv7tiVxiHzrokJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev; spf=pass smtp.mailfrom=mail.corvaglia.dev; dkim=pass (2048-bit key) header.d=corvaglia.dev header.i=@corvaglia.dev header.b=kahTBgRg; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=jhCmTDpU; arc=none smtp.client-ip=54.240.8.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corvaglia.dev header.i=@corvaglia.dev header.b="kahTBgRg";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="jhCmTDpU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=bvgar2idfqx6rr2b3v3v2bwbuxumhdxo; d=corvaglia.dev; t=1770059382;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=MZ4XAg06krB6sMylc7OqkNxkgzBWL3z6L/Nijdwu3LM=;
	b=kahTBgRgFsqt5bc6eT7i9iDc4iKx/KF7pbNBMIFKkMojp/2fettWCNQH09T6HjXL
	R7WMwBy9z/fpWUK9MfqRchjuXBpWDAHYEM8WoUc/5d+ByuVzJqyRrw9EY5yj3sRhcUf
	KslcnT6rUuq5/aWx2m3aHN9edSf2l8sPM3eKkRk7paG1Bo0l/umCCvs7rO8S1WgGOGj
	eu7sDoBxBDue2nikxkTLz5ycPNJ9/tUfQHi4uyQ1v+XAIZNoxrFEK2jBWDxKVLPRdqZ
	uG6WTgb5UicPzKtKTZJKlrcwYS21UfOMj9IiAYs1d2gcppLbHCGvyMaDP9cDq97aUeh
	aO3ylIyRIg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1770059382;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=MZ4XAg06krB6sMylc7OqkNxkgzBWL3z6L/Nijdwu3LM=;
	b=jhCmTDpUiNaoOaYnqUyfvXmdKs4Ct4Oa4vVaMzOckwoPSLRtKX0qJr4UIq6/fS8P
	I3a6Z/cw9M+If1MvE76pBxiyHNpCtvJjZF/lIbkGhyWkuGx3S61eGNhCw4vDKuhHQp4
	YiazqM6OemirfD+MnwRPiMk3Xn6KSCcFq5CbENiI=
From: David Corvaglia <david@corvaglia.dev>
To: razor@blackwall.org, idosch@nvidia.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Corvaglia <david@corvaglia.dev>
Subject: [PATCH net-next v3] net: bridge: use sysfs_emit instead of sprintf
Date: Mon, 2 Feb 2026 19:09:41 +0000
Message-ID: <0100019c1fc2bcc3-bc9ca2f1-22d7-4250-8441-91e4af57117b-000000@email.amazonses.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-1.Dw79TYOMY2hrNmvZ7e9+qnciE2cwcAniRLo3LdoqSVI=:AmazonSES
X-SES-Outgoing: 2026.02.02-54.240.8.176

Replace sprintf with sysfs_emit in sysfs show() methods as outlined in
Documentation/filesystems/sysfs.rst.

sysfs_emit is preferred to sprintf in sysfs show() methods as it is safer
with buffer handling.

Signed-off-by: David Corvaglia <david@corvaglia.dev>
---
v3: Fix whitespace issue.
v2: https://lore.kernel.org/bridge/0100019c1d2d46e0-a083f912-ac82-47e8-8cbb-ac9d70355ed3-000000@email.amazonses.com/
    Fix alignment of sysfs_emit arguments.
v1: https://lore.kernel.org/bridge/0100019c14f90490-950ddd9b-1897-4111-bddd-0d4b8abf380a-000000@email.amazonses.com/
    This is my first patch to the kernel! I've been able to build and boot
    with the patch. I also tested the sysfs reads and they seem to be
    correct. Any feedback is appreciated.

 net/bridge/br_stp_if.c   |   8 +--
 net/bridge/br_sysfs_br.c | 108 +++++++++++++++++++--------------------
 net/bridge/br_sysfs_if.c |  32 ++++++------
 3 files changed, 73 insertions(+), 75 deletions(-)

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index c20a41bf253b..cc4b27ff1b08 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -344,8 +344,8 @@ int br_stp_set_path_cost(struct net_bridge_port *p, unsigned long path_cost)
 
 ssize_t br_show_bridge_id(char *buf, const struct bridge_id *id)
 {
-	return sprintf(buf, "%.2x%.2x.%.2x%.2x%.2x%.2x%.2x%.2x\n",
-	       id->prio[0], id->prio[1],
-	       id->addr[0], id->addr[1], id->addr[2],
-	       id->addr[3], id->addr[4], id->addr[5]);
+	return sysfs_emit(buf, "%.2x%.2x.%.2x%.2x%.2x%.2x%.2x%.2x\n",
+			  id->prio[0], id->prio[1],
+			  id->addr[0], id->addr[1], id->addr[2],
+			  id->addr[3], id->addr[4], id->addr[5]);
 }
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index cb4855ed9500..8888300b65c1 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -67,7 +67,7 @@ static ssize_t forward_delay_show(struct device *d,
 				  struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%lu\n", jiffies_to_clock_t(br->forward_delay));
+	return sysfs_emit(buf, "%lu\n", jiffies_to_clock_t(br->forward_delay));
 }
 
 static int set_forward_delay(struct net_bridge *br, unsigned long val,
@@ -87,8 +87,8 @@ static DEVICE_ATTR_RW(forward_delay);
 static ssize_t hello_time_show(struct device *d, struct device_attribute *attr,
 			       char *buf)
 {
-	return sprintf(buf, "%lu\n",
-		       jiffies_to_clock_t(to_bridge(d)->hello_time));
+	return sysfs_emit(buf, "%lu\n",
+			  jiffies_to_clock_t(to_bridge(d)->hello_time));
 }
 
 static int set_hello_time(struct net_bridge *br, unsigned long val,
@@ -108,8 +108,8 @@ static DEVICE_ATTR_RW(hello_time);
 static ssize_t max_age_show(struct device *d, struct device_attribute *attr,
 			    char *buf)
 {
-	return sprintf(buf, "%lu\n",
-		       jiffies_to_clock_t(to_bridge(d)->max_age));
+	return sysfs_emit(buf, "%lu\n",
+			  jiffies_to_clock_t(to_bridge(d)->max_age));
 }
 
 static int set_max_age(struct net_bridge *br, unsigned long val,
@@ -129,7 +129,7 @@ static ssize_t ageing_time_show(struct device *d,
 				struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%lu\n", jiffies_to_clock_t(br->ageing_time));
+	return sysfs_emit(buf, "%lu\n", jiffies_to_clock_t(br->ageing_time));
 }
 
 static int set_ageing_time(struct net_bridge *br, unsigned long val,
@@ -150,7 +150,7 @@ static ssize_t stp_state_show(struct device *d,
 			      struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", br->stp_enabled);
+	return sysfs_emit(buf, "%d\n", br->stp_enabled);
 }
 
 
@@ -173,7 +173,7 @@ static ssize_t group_fwd_mask_show(struct device *d,
 				   char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%#x\n", br->group_fwd_mask);
+	return sysfs_emit(buf, "%#x\n", br->group_fwd_mask);
 }
 
 static int set_group_fwd_mask(struct net_bridge *br, unsigned long val,
@@ -200,8 +200,8 @@ static ssize_t priority_show(struct device *d, struct device_attribute *attr,
 			     char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n",
-		       (br->bridge_id.prio[0] << 8) | br->bridge_id.prio[1]);
+	return sysfs_emit(buf, "%d\n",
+			  (br->bridge_id.prio[0] << 8) | br->bridge_id.prio[1]);
 }
 
 static int set_priority(struct net_bridge *br, unsigned long val,
@@ -235,21 +235,21 @@ static DEVICE_ATTR_RO(bridge_id);
 static ssize_t root_port_show(struct device *d, struct device_attribute *attr,
 			      char *buf)
 {
-	return sprintf(buf, "%d\n", to_bridge(d)->root_port);
+	return sysfs_emit(buf, "%d\n", to_bridge(d)->root_port);
 }
 static DEVICE_ATTR_RO(root_port);
 
 static ssize_t root_path_cost_show(struct device *d,
 				   struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", to_bridge(d)->root_path_cost);
+	return sysfs_emit(buf, "%d\n", to_bridge(d)->root_path_cost);
 }
 static DEVICE_ATTR_RO(root_path_cost);
 
 static ssize_t topology_change_show(struct device *d,
 				    struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", to_bridge(d)->topology_change);
+	return sysfs_emit(buf, "%d\n", to_bridge(d)->topology_change);
 }
 static DEVICE_ATTR_RO(topology_change);
 
@@ -258,7 +258,7 @@ static ssize_t topology_change_detected_show(struct device *d,
 					     char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", br->topology_change_detected);
+	return sysfs_emit(buf, "%d\n", br->topology_change_detected);
 }
 static DEVICE_ATTR_RO(topology_change_detected);
 
@@ -266,7 +266,7 @@ static ssize_t hello_timer_show(struct device *d,
 				struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%ld\n", br_timer_value(&br->hello_timer));
+	return sysfs_emit(buf, "%ld\n", br_timer_value(&br->hello_timer));
 }
 static DEVICE_ATTR_RO(hello_timer);
 
@@ -274,7 +274,7 @@ static ssize_t tcn_timer_show(struct device *d, struct device_attribute *attr,
 			      char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%ld\n", br_timer_value(&br->tcn_timer));
+	return sysfs_emit(buf, "%ld\n", br_timer_value(&br->tcn_timer));
 }
 static DEVICE_ATTR_RO(tcn_timer);
 
@@ -283,7 +283,7 @@ static ssize_t topology_change_timer_show(struct device *d,
 					  char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%ld\n", br_timer_value(&br->topology_change_timer));
+	return sysfs_emit(buf, "%ld\n", br_timer_value(&br->topology_change_timer));
 }
 static DEVICE_ATTR_RO(topology_change_timer);
 
@@ -291,7 +291,7 @@ static ssize_t gc_timer_show(struct device *d, struct device_attribute *attr,
 			     char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%ld\n", br_timer_value(&br->gc_work.timer));
+	return sysfs_emit(buf, "%ld\n", br_timer_value(&br->gc_work.timer));
 }
 static DEVICE_ATTR_RO(gc_timer);
 
@@ -299,7 +299,7 @@ static ssize_t group_addr_show(struct device *d,
 			       struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%pM\n", br->group_addr);
+	return sysfs_emit(buf, "%pM\n", br->group_addr);
 }
 
 static ssize_t group_addr_store(struct device *d,
@@ -365,7 +365,7 @@ static ssize_t no_linklocal_learn_show(struct device *d,
 				       char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", br_boolopt_get(br, BR_BOOLOPT_NO_LL_LEARN));
+	return sysfs_emit(buf, "%d\n", br_boolopt_get(br, BR_BOOLOPT_NO_LL_LEARN));
 }
 
 static int set_no_linklocal_learn(struct net_bridge *br, unsigned long val,
@@ -387,7 +387,7 @@ static ssize_t multicast_router_show(struct device *d,
 				     struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", br->multicast_ctx.multicast_router);
+	return sysfs_emit(buf, "%d\n", br->multicast_ctx.multicast_router);
 }
 
 static int set_multicast_router(struct net_bridge *br, unsigned long val,
@@ -409,7 +409,7 @@ static ssize_t multicast_snooping_show(struct device *d,
 				       char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", br_opt_get(br, BROPT_MULTICAST_ENABLED));
+	return sysfs_emit(buf, "%d\n", br_opt_get(br, BROPT_MULTICAST_ENABLED));
 }
 
 static ssize_t multicast_snooping_store(struct device *d,
@@ -425,8 +425,8 @@ static ssize_t multicast_query_use_ifaddr_show(struct device *d,
 					       char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n",
-		       br_opt_get(br, BROPT_MULTICAST_QUERY_USE_IFADDR));
+	return sysfs_emit(buf, "%d\n",
+			  br_opt_get(br, BROPT_MULTICAST_QUERY_USE_IFADDR));
 }
 
 static int set_query_use_ifaddr(struct net_bridge *br, unsigned long val,
@@ -450,7 +450,7 @@ static ssize_t multicast_querier_show(struct device *d,
 				      char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", br->multicast_ctx.multicast_querier);
+	return sysfs_emit(buf, "%d\n", br->multicast_ctx.multicast_querier);
 }
 
 static int set_multicast_querier(struct net_bridge *br, unsigned long val,
@@ -470,7 +470,7 @@ static DEVICE_ATTR_RW(multicast_querier);
 static ssize_t hash_elasticity_show(struct device *d,
 				    struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", RHT_ELASTICITY);
+	return sysfs_emit(buf, "%u\n", RHT_ELASTICITY);
 }
 
 static int set_elasticity(struct net_bridge *br, unsigned long val,
@@ -494,7 +494,7 @@ static ssize_t hash_max_show(struct device *d, struct device_attribute *attr,
 			     char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br->hash_max);
+	return sysfs_emit(buf, "%u\n", br->hash_max);
 }
 
 static int set_hash_max(struct net_bridge *br, unsigned long val,
@@ -517,7 +517,7 @@ static ssize_t multicast_igmp_version_show(struct device *d,
 {
 	struct net_bridge *br = to_bridge(d);
 
-	return sprintf(buf, "%u\n", br->multicast_ctx.multicast_igmp_version);
+	return sysfs_emit(buf, "%u\n", br->multicast_ctx.multicast_igmp_version);
 }
 
 static int set_multicast_igmp_version(struct net_bridge *br, unsigned long val,
@@ -539,7 +539,7 @@ static ssize_t multicast_last_member_count_show(struct device *d,
 						char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br->multicast_ctx.multicast_last_member_count);
+	return sysfs_emit(buf, "%u\n", br->multicast_ctx.multicast_last_member_count);
 }
 
 static int set_last_member_count(struct net_bridge *br, unsigned long val,
@@ -561,7 +561,7 @@ static ssize_t multicast_startup_query_count_show(
 	struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br->multicast_ctx.multicast_startup_query_count);
+	return sysfs_emit(buf, "%u\n", br->multicast_ctx.multicast_startup_query_count);
 }
 
 static int set_startup_query_count(struct net_bridge *br, unsigned long val,
@@ -583,8 +583,8 @@ static ssize_t multicast_last_member_interval_show(
 	struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%lu\n",
-		       jiffies_to_clock_t(br->multicast_ctx.multicast_last_member_interval));
+	return sysfs_emit(buf, "%lu\n",
+			  jiffies_to_clock_t(br->multicast_ctx.multicast_last_member_interval));
 }
 
 static int set_last_member_interval(struct net_bridge *br, unsigned long val,
@@ -606,8 +606,8 @@ static ssize_t multicast_membership_interval_show(
 	struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%lu\n",
-		       jiffies_to_clock_t(br->multicast_ctx.multicast_membership_interval));
+	return sysfs_emit(buf, "%lu\n",
+			  jiffies_to_clock_t(br->multicast_ctx.multicast_membership_interval));
 }
 
 static int set_membership_interval(struct net_bridge *br, unsigned long val,
@@ -630,8 +630,8 @@ static ssize_t multicast_querier_interval_show(struct device *d,
 					       char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%lu\n",
-		       jiffies_to_clock_t(br->multicast_ctx.multicast_querier_interval));
+	return sysfs_emit(buf, "%lu\n",
+			  jiffies_to_clock_t(br->multicast_ctx.multicast_querier_interval));
 }
 
 static int set_querier_interval(struct net_bridge *br, unsigned long val,
@@ -654,8 +654,8 @@ static ssize_t multicast_query_interval_show(struct device *d,
 					     char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%lu\n",
-		       jiffies_to_clock_t(br->multicast_ctx.multicast_query_interval));
+	return sysfs_emit(buf, "%lu\n",
+			  jiffies_to_clock_t(br->multicast_ctx.multicast_query_interval));
 }
 
 static int set_query_interval(struct net_bridge *br, unsigned long val,
@@ -677,9 +677,8 @@ static ssize_t multicast_query_response_interval_show(
 	struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(
-		buf, "%lu\n",
-		jiffies_to_clock_t(br->multicast_ctx.multicast_query_response_interval));
+	return sysfs_emit(buf, "%lu\n",
+			  jiffies_to_clock_t(br->multicast_ctx.multicast_query_response_interval));
 }
 
 static int set_query_response_interval(struct net_bridge *br, unsigned long val,
@@ -701,9 +700,8 @@ static ssize_t multicast_startup_query_interval_show(
 	struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(
-		buf, "%lu\n",
-		jiffies_to_clock_t(br->multicast_ctx.multicast_startup_query_interval));
+	return sysfs_emit(buf, "%lu\n",
+			  jiffies_to_clock_t(br->multicast_ctx.multicast_startup_query_interval));
 }
 
 static int set_startup_query_interval(struct net_bridge *br, unsigned long val,
@@ -727,8 +725,8 @@ static ssize_t multicast_stats_enabled_show(struct device *d,
 {
 	struct net_bridge *br = to_bridge(d);
 
-	return sprintf(buf, "%d\n",
-		       br_opt_get(br, BROPT_MULTICAST_STATS_ENABLED));
+	return sysfs_emit(buf, "%d\n",
+			  br_opt_get(br, BROPT_MULTICAST_STATS_ENABLED));
 }
 
 static int set_stats_enabled(struct net_bridge *br, unsigned long val,
@@ -754,7 +752,7 @@ static ssize_t multicast_mld_version_show(struct device *d,
 {
 	struct net_bridge *br = to_bridge(d);
 
-	return sprintf(buf, "%u\n", br->multicast_ctx.multicast_mld_version);
+	return sysfs_emit(buf, "%u\n", br->multicast_ctx.multicast_mld_version);
 }
 
 static int set_multicast_mld_version(struct net_bridge *br, unsigned long val,
@@ -777,7 +775,7 @@ static ssize_t nf_call_iptables_show(
 	struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_NF_CALL_IPTABLES));
+	return sysfs_emit(buf, "%u\n", br_opt_get(br, BROPT_NF_CALL_IPTABLES));
 }
 
 static int set_nf_call_iptables(struct net_bridge *br, unsigned long val,
@@ -799,7 +797,7 @@ static ssize_t nf_call_ip6tables_show(
 	struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_NF_CALL_IP6TABLES));
+	return sysfs_emit(buf, "%u\n", br_opt_get(br, BROPT_NF_CALL_IP6TABLES));
 }
 
 static int set_nf_call_ip6tables(struct net_bridge *br, unsigned long val,
@@ -821,7 +819,7 @@ static ssize_t nf_call_arptables_show(
 	struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_NF_CALL_ARPTABLES));
+	return sysfs_emit(buf, "%u\n", br_opt_get(br, BROPT_NF_CALL_ARPTABLES));
 }
 
 static int set_nf_call_arptables(struct net_bridge *br, unsigned long val,
@@ -845,7 +843,7 @@ static ssize_t vlan_filtering_show(struct device *d,
 				   char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", br_opt_get(br, BROPT_VLAN_ENABLED));
+	return sysfs_emit(buf, "%d\n", br_opt_get(br, BROPT_VLAN_ENABLED));
 }
 
 static ssize_t vlan_filtering_store(struct device *d,
@@ -861,7 +859,7 @@ static ssize_t vlan_protocol_show(struct device *d,
 				  char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%#06x\n", ntohs(br->vlan_proto));
+	return sysfs_emit(buf, "%#06x\n", ntohs(br->vlan_proto));
 }
 
 static ssize_t vlan_protocol_store(struct device *d,
@@ -877,7 +875,7 @@ static ssize_t default_pvid_show(struct device *d,
 				 char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", br->default_pvid);
+	return sysfs_emit(buf, "%d\n", br->default_pvid);
 }
 
 static ssize_t default_pvid_store(struct device *d,
@@ -893,7 +891,7 @@ static ssize_t vlan_stats_enabled_show(struct device *d,
 				       char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_VLAN_STATS_ENABLED));
+	return sysfs_emit(buf, "%u\n", br_opt_get(br, BROPT_VLAN_STATS_ENABLED));
 }
 
 static int set_vlan_stats_enabled(struct net_bridge *br, unsigned long val,
@@ -915,7 +913,7 @@ static ssize_t vlan_stats_per_port_show(struct device *d,
 					char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_VLAN_STATS_PER_PORT));
+	return sysfs_emit(buf, "%u\n", br_opt_get(br, BROPT_VLAN_STATS_PER_PORT));
 }
 
 static int set_vlan_stats_per_port(struct net_bridge *br, unsigned long val,
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 74fdd8105dca..1f57c36a7fc0 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -47,7 +47,7 @@ const struct brport_attribute brport_attr_##_name = { 	        \
 #define BRPORT_ATTR_FLAG(_name, _mask)				\
 static ssize_t show_##_name(struct net_bridge_port *p, char *buf) \
 {								\
-	return sprintf(buf, "%d\n", !!(p->flags & _mask));	\
+	return sysfs_emit(buf, "%d\n", !!(p->flags & _mask));	\
 }								\
 static int store_##_name(struct net_bridge_port *p, unsigned long v) \
 {								\
@@ -83,7 +83,7 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
 
 static ssize_t show_path_cost(struct net_bridge_port *p, char *buf)
 {
-	return sprintf(buf, "%d\n", p->path_cost);
+	return sysfs_emit(buf, "%d\n", p->path_cost);
 }
 
 static BRPORT_ATTR(path_cost, 0644,
@@ -91,7 +91,7 @@ static BRPORT_ATTR(path_cost, 0644,
 
 static ssize_t show_priority(struct net_bridge_port *p, char *buf)
 {
-	return sprintf(buf, "%d\n", p->priority);
+	return sysfs_emit(buf, "%d\n", p->priority);
 }
 
 static BRPORT_ATTR(priority, 0644,
@@ -111,65 +111,65 @@ static BRPORT_ATTR(designated_bridge, 0444, show_designated_bridge, NULL);
 
 static ssize_t show_designated_port(struct net_bridge_port *p, char *buf)
 {
-	return sprintf(buf, "%d\n", p->designated_port);
+	return sysfs_emit(buf, "%d\n", p->designated_port);
 }
 static BRPORT_ATTR(designated_port, 0444, show_designated_port, NULL);
 
 static ssize_t show_designated_cost(struct net_bridge_port *p, char *buf)
 {
-	return sprintf(buf, "%d\n", p->designated_cost);
+	return sysfs_emit(buf, "%d\n", p->designated_cost);
 }
 static BRPORT_ATTR(designated_cost, 0444, show_designated_cost, NULL);
 
 static ssize_t show_port_id(struct net_bridge_port *p, char *buf)
 {
-	return sprintf(buf, "0x%x\n", p->port_id);
+	return sysfs_emit(buf, "0x%x\n", p->port_id);
 }
 static BRPORT_ATTR(port_id, 0444, show_port_id, NULL);
 
 static ssize_t show_port_no(struct net_bridge_port *p, char *buf)
 {
-	return sprintf(buf, "0x%x\n", p->port_no);
+	return sysfs_emit(buf, "0x%x\n", p->port_no);
 }
 
 static BRPORT_ATTR(port_no, 0444, show_port_no, NULL);
 
 static ssize_t show_change_ack(struct net_bridge_port *p, char *buf)
 {
-	return sprintf(buf, "%d\n", p->topology_change_ack);
+	return sysfs_emit(buf, "%d\n", p->topology_change_ack);
 }
 static BRPORT_ATTR(change_ack, 0444, show_change_ack, NULL);
 
 static ssize_t show_config_pending(struct net_bridge_port *p, char *buf)
 {
-	return sprintf(buf, "%d\n", p->config_pending);
+	return sysfs_emit(buf, "%d\n", p->config_pending);
 }
 static BRPORT_ATTR(config_pending, 0444, show_config_pending, NULL);
 
 static ssize_t show_port_state(struct net_bridge_port *p, char *buf)
 {
-	return sprintf(buf, "%d\n", p->state);
+	return sysfs_emit(buf, "%d\n", p->state);
 }
 static BRPORT_ATTR(state, 0444, show_port_state, NULL);
 
 static ssize_t show_message_age_timer(struct net_bridge_port *p,
 					    char *buf)
 {
-	return sprintf(buf, "%ld\n", br_timer_value(&p->message_age_timer));
+	return sysfs_emit(buf, "%ld\n", br_timer_value(&p->message_age_timer));
 }
 static BRPORT_ATTR(message_age_timer, 0444, show_message_age_timer, NULL);
 
 static ssize_t show_forward_delay_timer(struct net_bridge_port *p,
 					    char *buf)
 {
-	return sprintf(buf, "%ld\n", br_timer_value(&p->forward_delay_timer));
+	return sysfs_emit(buf, "%ld\n", br_timer_value(&p->forward_delay_timer));
 }
 static BRPORT_ATTR(forward_delay_timer, 0444, show_forward_delay_timer, NULL);
 
 static ssize_t show_hold_timer(struct net_bridge_port *p,
 					    char *buf)
 {
-	return sprintf(buf, "%ld\n", br_timer_value(&p->hold_timer));
+	return sysfs_emit(buf, "%ld\n", br_timer_value(&p->hold_timer));
 }
 static BRPORT_ATTR(hold_timer, 0444, show_hold_timer, NULL);
 
@@ -182,7 +182,7 @@ static BRPORT_ATTR(flush, 0200, NULL, store_flush);
 
 static ssize_t show_group_fwd_mask(struct net_bridge_port *p, char *buf)
 {
-	return sprintf(buf, "%#x\n", p->group_fwd_mask);
+	return sysfs_emit(buf, "%#x\n", p->group_fwd_mask);
 }
 
 static int store_group_fwd_mask(struct net_bridge_port *p,
@@ -205,7 +205,7 @@ static ssize_t show_backup_port(struct net_bridge_port *p, char *buf)
 	rcu_read_lock();
 	backup_p = rcu_dereference(p->backup_port);
 	if (backup_p)
-		ret = sprintf(buf, "%s\n", backup_p->dev->name);
+		ret = sysfs_emit(buf, "%s\n", backup_p->dev->name);
 	rcu_read_unlock();
 
 	return ret;
@@ -244,7 +244,7 @@ BRPORT_ATTR_FLAG(isolated, BR_ISOLATED);
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 static ssize_t show_multicast_router(struct net_bridge_port *p, char *buf)
 {
-	return sprintf(buf, "%d\n", p->multicast_ctx.multicast_router);
+	return sysfs_emit(buf, "%d\n", p->multicast_ctx.multicast_router);
 }
 
 static int store_multicast_router(struct net_bridge_port *p,
-- 
2.43.0

