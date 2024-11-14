Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2896AAD
	for <bridge@lists.linux.dev>; Thu, 14 Nov 2024 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553124; cv=none; b=jWJTKYhV2tvBrTmRs6kc3eTnnHh2Hk0yPklmbgJAmqdIBXQLfjr2W/8uO5Bywtoy8vEWbAGYzKFXqkjOOBXNIBnWQ1to+Ue0XISBl2DFQArX1BqyOrzxsK8nIuF7bAJlVAOQuPSLJeRIZOrkSrfmpb20wCSZ4A4lfZxUBsz6YQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553124; c=relaxed/simple;
	bh=xxhuzZuGm9k0MdWxiUn8MDTId0zaE1jmnDfmM+WARP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d3WgxAicuY9us1fBGheOxHQcmgeJLwYsUCH5BQ3c6YEMPmMBC2//xmGMDwl3pDbagUayz3WD9tnu6dWCOg7ptKt6j4YfxoiJWvREnRRasO6dOtTBOo3BGlpcGq5Nd/ZLVGMIyxcYCi7TNGxmR7TkmIJDXVf2tWH69l1ktWw6XFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee367356755280-ecaa6;
	Thu, 14 Nov 2024 10:58:31 +0800 (CST)
X-RM-TRANSID:2ee367356755280-ecaa6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36735675670d-ab0c1;
	Thu, 14 Nov 2024 10:58:31 +0800 (CST)
X-RM-TRANSID:2ee36735675670d-ab0c1
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: roopa@nvidia.com
Cc: razor@blackwall.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] net: bridge: Fix the wrong format specifier
Date: Thu, 14 Nov 2024 10:58:20 +0800
Message-Id: <20241114025820.37632-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

The format specifier of "unsigned long" in sprintf()
should be "%lu", not "%ld".

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 net/bridge/br_sysfs_br.c | 8 ++++----
 net/bridge/br_sysfs_if.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index ea733542244c..0edab3910d46 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -266,7 +266,7 @@ static ssize_t hello_timer_show(struct device *d,
 				struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%ld\n", br_timer_value(&br->hello_timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&br->hello_timer));
 }
 static DEVICE_ATTR_RO(hello_timer);
 
@@ -274,7 +274,7 @@ static ssize_t tcn_timer_show(struct device *d, struct device_attribute *attr,
 			      char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%ld\n", br_timer_value(&br->tcn_timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&br->tcn_timer));
 }
 static DEVICE_ATTR_RO(tcn_timer);
 
@@ -283,7 +283,7 @@ static ssize_t topology_change_timer_show(struct device *d,
 					  char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%ld\n", br_timer_value(&br->topology_change_timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&br->topology_change_timer));
 }
 static DEVICE_ATTR_RO(topology_change_timer);
 
@@ -291,7 +291,7 @@ static ssize_t gc_timer_show(struct device *d, struct device_attribute *attr,
 			     char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%ld\n", br_timer_value(&br->gc_work.timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&br->gc_work.timer));
 }
 static DEVICE_ATTR_RO(gc_timer);
 
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 74fdd8105dca..08ad4580e645 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -155,21 +155,21 @@ static BRPORT_ATTR(state, 0444, show_port_state, NULL);
 static ssize_t show_message_age_timer(struct net_bridge_port *p,
 					    char *buf)
 {
-	return sprintf(buf, "%ld\n", br_timer_value(&p->message_age_timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&p->message_age_timer));
 }
 static BRPORT_ATTR(message_age_timer, 0444, show_message_age_timer, NULL);
 
 static ssize_t show_forward_delay_timer(struct net_bridge_port *p,
 					    char *buf)
 {
-	return sprintf(buf, "%ld\n", br_timer_value(&p->forward_delay_timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&p->forward_delay_timer));
 }
 static BRPORT_ATTR(forward_delay_timer, 0444, show_forward_delay_timer, NULL);
 
 static ssize_t show_hold_timer(struct net_bridge_port *p,
 					    char *buf)
 {
-	return sprintf(buf, "%ld\n", br_timer_value(&p->hold_timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&p->hold_timer));
 }
 static BRPORT_ATTR(hold_timer, 0444, show_hold_timer, NULL);
 
-- 
2.33.0



