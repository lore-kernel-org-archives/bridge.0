Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF36C33FE33
	for <bridge@lists.linux.dev>; Mon, 12 Oct 2026 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792245; cv=none; b=n5Y66KegteOTA3ABZcHpfesMfb7sWWi5op0kTykWdGJ+SBQXG71rUTN0RX7OQx4vzTnETzwWzmJr3I4NI52vUD+YaPK++mMz2CDM0wd1zWoSrGar8UfVQtLcr1O7oAs2rWhyDTGhxCNHWgXgCahTNVGI8MHjkLhoTsbpCB5lyFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792245; c=relaxed/simple;
	bh=K9em4Tm9ugxQTtAX4IiYzZsiBtvjzXORczke2gHj6ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPxPY6T2SpjUC2aNmRqwnT3AJf/P3V6HtGGOPSU6Dc6+Mi5eO0kDAgqnDwbNkgtyIJHQUluf3Fk9ZzzyvOSJiRlQ7xrg95V4KoydmXQVQigbkTtX9DvR98IhRBMz7gLWGbbjDXvAIdfEGUs8X9g90rh7Uux7erIc6AUBgC3qAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoTujpuE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoTujpuE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8246b13cbso13101285ad.2
        for <bridge@lists.linux.dev>; Mon, 12 Oct 2026 01:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791792243; x=1792397043; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hc3DP5cOmEiiLgrIASB39ibcWyYPqeHj3lgqxS6llMQ=;
        b=NoTujpuEz0Bj5QuirH9qqwAX6C2jowtwl5v6jcFqI0MWC82+uG9L3DUuxlZJolV1eR
         o4+Tb+ly2xt0LKPtPorexUd6dZAqwS1pSL+7Dmu3TrBa2SXj16rHE8EsVTwaCuJrTWA2
         YOe+VCISZIUiaG/iLgHL0nzZj1CKatHTJfXVyeIrF9Z6yvZfIYnl89LCVQ25hR95ijkA
         4+nEKtOT1GWHXx+qN4G/y92OF8QQZO+CaPGgsDGI44eEq+Aj78LLBpPKpKk61PyLkmHI
         7D70/3lDL9x3KigGDOGbnqNUYuTNVM3Zky5bstAUouNER8EAZvMD49oVFtrpTtUGoFkN
         Kp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791792243; x=1792397043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hc3DP5cOmEiiLgrIASB39ibcWyYPqeHj3lgqxS6llMQ=;
        b=YOx09fsNf8JEp9Kygp50lZqen+1nKKQ4GF7Skqq/cgJrLIxDI4o24lFq5jE8MC/5eZ
         E00G7dB4sYG14wQa8Z1iSFe/oJoDGfF4C2vjY3Zh3gqew745r6SqFdNXjbiBcO6l8GG+
         rhBnZU1D6vItR8FfQupQSE0KELuhlwWxSrvF5NpEdIMyu6+3khf8en7IASNuns0wb4sv
         NFkFp/IfbP6qWmx400rfiQq/cSV4ia8gZeKUFtaOQ4dp0oqxaXCRSZCYr4rGRR2mNPk4
         xA0Y5nbEyEEga3umK1DzQHLo0RRIELWKQGHl1/VazhCT0c8QLXG5Oszvq+dyIkAaoBQp
         3twA==
X-Forwarded-Encrypted: i=1; AKwUvBzvRUCq9LFhIg4RmvZ9dd8K8E9/+Fa4Zg+wKMsd7I264RVKKgo3hiNC9sqL8d3dfQqZY8LekZ0=@lists.linux.dev
X-Gm-Message-State: AFq9FYIn4yXAfVu79rO5RMjdDqbKEjLfTYcP/RcE1ooiuyK4sTL7mEre
	moswP7BI91iuIduyGetKhH+siKb5jqAhiPvOuv/Px88f08kO8t4C1TZ5
X-Gm-Gg: AYBFou3QKUpOhya6pYIrbOwbtFnxuKMi8v1t1ViD5d716/uux3HJ0v2Q8TRBTwxgZh8
	4Y0T1/HXcHQWt3YVRjSXHOy1z9lrxecqKLVkUv6qhSZRXUMrIFN0fGWc/VnIIIRPw6kysTAQ6Sx
	82Dn2c/akjN4TUyB+5UqGFyUcpLEWgofhpBFo/jsxAiFY1/WNa6e0Id0B/3kMLJUX9+YDZ79Fbi
	DzNUnu36Z8LsG23XOpNysWFpLqJMMWXEw+09egYN0tj6R+1Py49CgfBx/v8+8mA0aH0H5dlbx/J
	IbHzqxJKADzCud0RLEft4N6m1BdF6WtdC2zXSPRFz9AGuSQm7mbAFkuo8bQ6w6sDbwi09Ck8mdR
	dlKmdyIX/pH5kp3u4+dy4QTWwvplCJM3tkj+Bb7PMWwChO4q76HhAodjubLhexO8Rrd5XR2oWE/
	Xi3dTEbpkWQNQhPR0SnaM1w/+vnhSo4KkvZQVNVu3ztuhi/J7OAIVqj2Ya3j8B6Ji4gPPVEFfQy
	9Iz1tqBMv4VkZDR17fdRmysZnHKCJPy/pDgilDqkyDRbtMI3hFSNi8rKQ==
X-Received: by 2002:a17:902:db0a:b0:2dd:c053:9c71 with SMTP id d9443c01a7336-2e842ac8b2bmr84273155ad.39.1791792242900;
        Mon, 12 Oct 2026 01:04:02 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422da9b1sm40189785ad.66.2026.10.12.01.04.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 01:04:02 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: razor@blackwall.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] net: bridge: don't re-arm the STP port timers on MRP driven ports
Date: Mon, 12 Oct 2026 16:03:53 +0800
Message-ID: <20261012080357.29015-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

br_set_state() returns without touching p->state when the port is MRP
aware, so br_stp_disable_port() cannot move such a port to
BR_STATE_DISABLED.  The br_port_state_selection() call at the end of
br_stp_disable_port() therefore still processes the port: it is past the
"if (p->state == BR_STATE_DISABLED) continue" test, it is a designated
port (br_become_designated_port() ran a few lines earlier), and if MRP
left it in BR_STATE_BLOCKING then br_make_forwarding() re-arms
p->forward_delay_timer - after the timer_delete() that
br_stp_disable_port() just did.

del_nbp() then frees the port through call_rcu() with the timer still
queued on a timer base, and the timer wheel writes into (and eventually
calls a function pointer out of) freed memory:

  BUG: KASAN: slab-use-after-free in __run_timers (include/linux/list.h:1175 kernel/time/timer.c:1820 kernel/time/timer.c:2356)
  Write of size 8 at addr ffff88800ba32070 by task swapper/1/0
   __run_timers (include/linux/list.h:1175 kernel/time/timer.c:1820 kernel/time/timer.c:2356)
   run_timer_softirq (kernel/time/timer.c:2386 kernel/time/timer.c:2405)
   handle_softirqs (kernel/softirq.c:645)
  Allocated by task 1:
   br_add_if (net/bridge/br_if.c:440 net/bridge/br_if.c:596)
   do_set_master (net/core/rtnetlink.c:3076)
  Freed by task 24:
   kfree (mm/slub.c:6792)
   kobject_put (lib/kobject.c:737)
   rcu_core (kernel/rcu/tree.c:2919)
  Last potentially related work creation:
   __call_rcu_common.constprop.0 (kernel/rcu/tree.c:3181)
   br_del_if (net/bridge/br_if.c:736)
   do_set_master (net/core/rtnetlink.c:3060)
  The buggy address is located 112 bytes inside of
   freed 2048-byte region [ffff88800ba32000, ffff88800ba32800)

Skip the STP forwarding state machine for MRP driven ports, and for good
measure shut the three port timers down in del_nbp() before the port is
handed to call_rcu(), the way commit 2a00517db8de ("bridge: stp: Fix a
potential use-after-free when deleting a bridge") did for the bridge
timers.  timer_shutdown_sync() also makes any later arming attempt a
no-op.

Fixes: 419dba8a49d7 ("net: bridge: Add checks for enabling the STP.")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.
---
 net/bridge/br_if.c  | 4 ++++
 net/bridge/br_stp.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index c52613431f88..ea36da07b56f 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -374,6 +374,10 @@ static void del_nbp(struct net_bridge_port *p)
 
 	br_netpoll_disable(p);
 
+	timer_shutdown_sync(&p->message_age_timer);
+	timer_shutdown_sync(&p->forward_delay_timer);
+	timer_shutdown_sync(&p->hold_timer);
+
 	call_rcu(&p->rcu, destroy_nbp_rcu);
 }
 
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index c7e7e924f155..5f4bca38a40b 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -463,6 +463,12 @@ static void br_make_forwarding(struct net_bridge_port *p)
 	if (p->state != BR_STATE_BLOCKING)
 		return;
 
+	/* br_set_state() will not move an MRP driven port out of BLOCKING,
+	 * so arming forward_delay_timer for it only leaks a live timer.
+	 */
+	if (test_bit(BR_MRP_AWARE_BIT, &p->flags))
+		return;
+
 	if (br->stp_enabled == BR_NO_STP || br->forward_delay == 0) {
 		br_set_state(p, BR_STATE_FORWARDING);
 		br_topology_change_detection(br);

base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
-- 
2.55.0

