Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667151C3F1B
	for <bridge@lists.linux.dev>; Fri,  2 Aug 2024 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586088; cv=none; b=VY+L0VoqWjtRo4/EX4eYhxbNG9HKDodkIBEXGNdvScpyFYvLHf2pnsO9D87JS7nVItd/nVMlUh4YK5y2j3Vx5Ed7JaWHxkjXopNnP20qG4IRgrwIJG/SCWJkAb3LruwirBUPE3dsqUmo99wnWyBGtxCnqTEtLYRXPuRzyjyYzkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586088; c=relaxed/simple;
	bh=gHVyyvEhrZejUDUsXHFskf1BDflUwJv1wmiTyCoQDrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djEvhQN6PrRoq72RINSOeTB4mKYDWKX6ZD6j07V49PeDR9GWYNIvo46DCE/jlMVUXhpj2xVpxevmHUPueMoNPhecJFv3CjXuCTWIv8gj7+GyUciNjvNK3uwF13MdVEx5CvibK8Bkux6uu1g/qaku1gSBbsIkTbfVA1TW/RYXdq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=HQtDjsVI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="HQtDjsVI"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so10969024a12.3
        for <bridge@lists.linux.dev>; Fri, 02 Aug 2024 01:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1722586085; x=1723190885; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ5i7ZZsbb8/qv+GVwtLQNKmkvQ+k/9eNI6fKizaQ6g=;
        b=HQtDjsVI8jL//wUqMFD/74bBpLUh4erx0mR6UigY8dNyzDfWvOHGK5vgbmfvSe/S8g
         Xej/MkTwdC6ZD1QwlpEHxHkcPrpVIP7tb9lHuqxU1f0Hsul0GyCB3LbIWqWNl8lU6vmz
         TICGLfsP0U45t3CDWWlfJoZW+W7xSWR3tYmWPSVDzkuEWNOEDi15Wn4w4juaKKAcdVHW
         GPsP+pbpgavHutOqjsnlpA4ix22dTM/+4T5L65xkp9e6vmPeBSAhZUN4oQg9kh6rM9iU
         ErvvfI0Kwsp5aeDZwcaUSHnoPIA16vnSesoxvQ6e1kuwSRnCJxIcpyJKW5AEo9893pcs
         4jLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722586085; x=1723190885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJ5i7ZZsbb8/qv+GVwtLQNKmkvQ+k/9eNI6fKizaQ6g=;
        b=C6SO59ELmtVDlWZu4X3N8E09vfJcm5IGGfqTGRLUh4xJ+bE94Nd2d/qD0A/uTHBFmF
         tj7AknFO/jjuCcexshSa+2GWzPHaaGJsd5MiEIDtByn7HiA2kjv4VHMpR2ymOXyraXos
         QG3TKI6ZhOtd0NGNzx+mikB68pl+Nr3d6jf3IA75zxEwGaBTrwMFN76FdENV9szY2vfB
         JmPcg2fWLkuCMPO5aard+buwEMZ3eiKP4KsmkC1e+T+7Ds5u8dcwFJ1Z89epkinJ8Fwd
         NZYoIkYXhJCa+3WHeeRIiMl3k8CzyiR+puTJvaIGjo0X8+DwaiBXKU5KfLb8FJ4Zuy9B
         6HXw==
X-Forwarded-Encrypted: i=1; AJvYcCWAt48E3IrqxC7nvM/yV80kPCL08yktVpmEkdqwL7ofywRhVh8HBNwOeV5UqYlnsywdP2cppdrv+1ip4Fv2A2zUnYVkMUz1
X-Gm-Message-State: AOJu0YyujBKnTOsk+EbZ0oKTVQLd9a6DlxubmpwMF4gevxUMqYMXOg45
	dRNzQRbluX9I5WXpETDCavYhzM5fTSXl6EfwT/zkIIH3v+rOwryeHlM5E3CY4PQ=
X-Google-Smtp-Source: AGHT+IG0i663YS5+4jvwwDGdS+W3psa+6dXTTsklOkkbw5bII+qM8QZd/U9dSYFjdtS/CEGuBCyy7A==
X-Received: by 2002:a05:6402:517b:b0:5a2:eab0:4a with SMTP id 4fb4d7f45d1cf-5b7f5414590mr1809000a12.24.1722586084434;
        Fri, 02 Aug 2024 01:08:04 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839719fdesm778001a12.8.2024.08.02.01.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:08:03 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	edumazet@google.com,
	pabeni@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>,
	syzbot+263426984509be19c9a0@syzkaller.appspotmail.com
Subject: [PATCH net] net: bridge: mcast: wait for previous gc cycles when removing port
Date: Fri,  2 Aug 2024 11:07:30 +0300
Message-ID: <20240802080730.3206303-1-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot hit a use-after-free[1] which is caused because the bridge doesn't
make sure that all previous garbage has been collected when removing a
port. What happens is:
      CPU 1                   CPU 2
 start gc cycle           remove port
                         acquire gc lock first
 wait for lock
                         call br_multicasg_gc() directly
 acquire lock now but    free port
 the port can be freed
 while grp timers still
 running

Make sure all previous gc cycles have finished by using flush_work before
freeing the port.

[1]
  BUG: KASAN: slab-use-after-free in br_multicast_port_group_expired+0x4c0/0x550 net/bridge/br_multicast.c:861
  Read of size 8 at addr ffff888071d6d000 by task syz.5.1232/9699

  CPU: 1 PID: 9699 Comm: syz.5.1232 Not tainted 6.10.0-rc5-syzkaller-00021-g24ca36a562d6 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
  Call Trace:
   <IRQ>
   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
   print_address_description mm/kasan/report.c:377 [inline]
   print_report+0xc3/0x620 mm/kasan/report.c:488
   kasan_report+0xd9/0x110 mm/kasan/report.c:601
   br_multicast_port_group_expired+0x4c0/0x550 net/bridge/br_multicast.c:861
   call_timer_fn+0x1a3/0x610 kernel/time/timer.c:1792
   expire_timers kernel/time/timer.c:1843 [inline]
   __run_timers+0x74b/0xaf0 kernel/time/timer.c:2417
   __run_timer_base kernel/time/timer.c:2428 [inline]
   __run_timer_base kernel/time/timer.c:2421 [inline]
   run_timer_base+0x111/0x190 kernel/time/timer.c:2437

Reported-by: syzbot+263426984509be19c9a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=263426984509be19c9a0
Fixes: e12cec65b554 ("net: bridge: mcast: destroy all entries via gc")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
note: tested with KASAN and kmemleak on.

 net/bridge/br_multicast.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 9a1cb5079a7a..b2ae0d2434d2 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2045,16 +2045,14 @@ void br_multicast_del_port(struct net_bridge_port *port)
 {
 	struct net_bridge *br = port->br;
 	struct net_bridge_port_group *pg;
-	HLIST_HEAD(deleted_head);
 	struct hlist_node *n;
 
 	/* Take care of the remaining groups, only perm ones should be left */
 	spin_lock_bh(&br->multicast_lock);
 	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
 		br_multicast_find_del_pg(br, pg);
-	hlist_move_list(&br->mcast_gc_list, &deleted_head);
 	spin_unlock_bh(&br->multicast_lock);
-	br_multicast_gc(&deleted_head);
+	flush_work(&br->mcast_gc_work);
 	br_multicast_port_ctx_deinit(&port->multicast_ctx);
 	free_percpu(port->mcast_stats);
 }
-- 
2.44.0

