Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA23147C78
	for <bridge@lists.linux.dev>; Mon, 13 May 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715598440; cv=none; b=WGhgoqYVhHraQXboFeBuBmbncUqVN56WUjkflQ+ixT54qeaZSQp2wq5q/dsPAchenQ8WqCkS0VZNWQsuVu3FSSvmQWPouFpTeTtuGawMKINGGHHUGLZx38KHTg1jDZJ/0rNkImbjjQ9Id1hdUsF8MfftrY2nJoHOgvwK0HU5KxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715598440; c=relaxed/simple;
	bh=sQ22MnC/GqGA15bb6lplBaFv5MtUbe+DNgEvgg1mt74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILr32ruu6Gp0YnMF5KPiBJGJPAIfjLW+hy1qsJXyxLtoJr3Vm0iJXT1ZZm9QRJwNNFmzHTAw9gexNelm118EynyLzNXS8kzqZMufiqmtbjpkwmmn+pu5xVJ9dhy/57uX/2gvgoXrQXWJHhamBKjo2JU0V1/OJhRTqdE7QaWMMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=VIIixXr0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="VIIixXr0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41fd5dc03easo25501845e9.1
        for <bridge@lists.linux.dev>; Mon, 13 May 2024 04:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1715598437; x=1716203237; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fpyRZoJrK21uu/CPd7IvcdbbP6QpYeHMyHtxNFb1d68=;
        b=VIIixXr0T9Gj+wSM1kojT2ADlfcQI9ttTv7bKxArPY0H/z6SmL/PDNpNy0AEazSS6q
         9SMK4eknjWpK9YWAPTEMUoKTHxRnkeIHGslbyWPaJBFDm0cdOBW7OL5n8MTRXoj94YJC
         MsKU3yvuE3qnLgnV/QWpEYEOG4nWgNYESGcOQQaVkV4wdEbf/kUAdqMJ2/X0Gk4bykmw
         gzg1Vv1XI97Jw6zXEf6OiYwcCumGmeALQ9PU5IZHZXpaRzF+k2da99HB9tz7/iqVDhD2
         4DE3nm11AunW22qzy63aBazfYmkau98avrFrsZHsYbSBnmlXSbNNuv43f1viuaiplwAX
         7r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715598437; x=1716203237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpyRZoJrK21uu/CPd7IvcdbbP6QpYeHMyHtxNFb1d68=;
        b=i6yRrLUlBO00HnTBXBISOBKTY3jWFRP4gDo4K8QKr5TZ44nE076Lt163UrQJ8FjO3p
         R/Au4yNq5ape46IBnHTNvh+ceO7kMuGd6mlUjLpZr/UU41vS55CoX7t2EIjJ0xA9iRj8
         Y/PYwx7O7Q9HHshLDVb8O9C+oa9eD10Un/zhv2Z6CTeXtOQUtZAda8YfhbSlwt0yh+qX
         fj6ZyiY55VLZU7JBhjO/kAkjIjfTRXTWP0OR6HBlLvcDz6fNmZxKyc9fXrpISlU6EhIX
         WlQFdB8G0aOD5WL5nqjBtbvVv1zQJ/DfpG/izJCLxpcj1i9SEbDo+tMFmQtu2irSpGCI
         /Lbg==
X-Forwarded-Encrypted: i=1; AJvYcCVp5OjNCAGuFgSCdMdrSCZzoHdQSuu1/rNRqi0gHNXhfkZcsBoQrM7ZyooRGIsKw4UeE8z+bUS9ks7X7gPYWjq1xJAP38Ho
X-Gm-Message-State: AOJu0YwDviOQNJ2s7b1JT1oL0IyiA6ARSfx+OOs6vY1iKJ1WYA/308lh
	qJqEMr+aAx5EEYkki8/ATxcWp+lEJSAx/p0MJRBqo0You8ew8jw3fxhREquAqv0=
X-Google-Smtp-Source: AGHT+IHjhwTATWIQVciRypeABc4AmOlaOxDuxujYNXR8MpLWnxmnZRvSynFV04LPjnhhFCI59QlqLA==
X-Received: by 2002:a05:600c:314e:b0:41a:bdaf:8d6b with SMTP id 5b1f17b1804b1-41fead6adf9mr64529655e9.34.1715598436582;
        Mon, 13 May 2024 04:07:16 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420113d808bsm66801865e9.12.2024.05.13.04.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 04:07:16 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	kuba@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	edumazet@google.com,
	pabeni@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>,
	syzbot+fa04eb8a56fd923fc5d8@syzkaller.appspotmail.com
Subject: [PATCH net] net: bridge: mst: fix vlan use-after-free
Date: Mon, 13 May 2024 14:06:27 +0300
Message-ID: <20240513110627.770389-1-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a suspicious rcu usage[1] in bridge's mst code. While
fixing it I noticed that nothing prevents a vlan to be freed while
walking the list from the same path (br forward delay timer). Fix the rcu
usage and also make sure we are not accessing freed memory by making
br_mst_vlan_set_state use rcu read lock.

[1]
 WARNING: suspicious RCU usage
 6.9.0-rc6-syzkaller #0 Not tainted
 -----------------------------
 net/bridge/br_private.h:1599 suspicious rcu_dereference_protected() usage!
 ...
 stack backtrace:
 CPU: 1 PID: 8017 Comm: syz-executor.1 Not tainted 6.9.0-rc6-syzkaller #0
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
 Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
  nbp_vlan_group net/bridge/br_private.h:1599 [inline]
  br_mst_set_state+0x1ea/0x650 net/bridge/br_mst.c:105
  br_set_state+0x28a/0x7b0 net/bridge/br_stp.c:47
  br_forward_delay_timer_expired+0x176/0x440 net/bridge/br_stp_timer.c:88
  call_timer_fn+0x18e/0x650 kernel/time/timer.c:1793
  expire_timers kernel/time/timer.c:1844 [inline]
  __run_timers kernel/time/timer.c:2418 [inline]
  __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2429
  run_timer_base kernel/time/timer.c:2438 [inline]
  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2448
  __do_softirq+0x2c6/0x980 kernel/softirq.c:554
  invoke_softirq kernel/softirq.c:428 [inline]
  __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
  </IRQ>
  <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
 RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5758
 Code: 2b 00 74 08 4c 89 f7 e8 ba d1 84 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
 RSP: 0018:ffffc90013657100 EFLAGS: 00000206
 RAX: 0000000000000001 RBX: 1ffff920026cae2c RCX: 0000000000000001
 RDX: dffffc0000000000 RSI: ffffffff8bcaca00 RDI: ffffffff8c1eaa60
 RBP: ffffc90013657260 R08: ffffffff92efe507 R09: 1ffffffff25dfca0
 R10: dffffc0000000000 R11: fffffbfff25dfca1 R12: 1ffff920026cae28
 R13: dffffc0000000000 R14: ffffc90013657160 R15: 0000000000000246

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
Reported-by: syzbot+fa04eb8a56fd923fc5d8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa04eb8a56fd923fc5d8
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index ee680adcee17..3c66141d34d6 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -78,7 +78,7 @@ static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_v
 {
 	struct net_bridge_vlan_group *vg = nbp_vlan_group(p);
 
-	if (v->state == state)
+	if (br_vlan_get_state(v) == state)
 		return;
 
 	br_vlan_set_state(v, state);
@@ -100,11 +100,12 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	};
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *v;
-	int err;
+	int err = 0;
 
+	rcu_read_lock();
 	vg = nbp_vlan_group(p);
 	if (!vg)
-		return 0;
+		goto out;
 
 	/* MSTI 0 (CST) state changes are notified via the regular
 	 * SWITCHDEV_ATTR_ID_PORT_STP_STATE.
@@ -112,17 +113,20 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	if (msti) {
 		err = switchdev_port_attr_set(p->dev, &attr, extack);
 		if (err && err != -EOPNOTSUPP)
-			return err;
+			goto out;
 	}
 
-	list_for_each_entry(v, &vg->vlan_list, vlist) {
+	err = 0;
+	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
 		if (v->brvlan->msti != msti)
 			continue;
 
 		br_mst_vlan_set_state(p, v, state);
 	}
 
-	return 0;
+out:
+	rcu_read_unlock();
+	return err;
 }
 
 static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
-- 
2.44.0

