Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8A25B093
	for <bridge@lists.linux.dev>; Sun, 13 Sep 2026 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789263096; cv=none; b=F3CNG8dye4Udth6dYMHDiCtKntsTY+G/4MyNv6Luodhfpa/mT0ZGZGgpCVMKhHJ32eVrqIJpfdPhQafvFXkzVLbLcpRZl4+tkWttTT2S9+BWHlcqXgXCxHscXkzQ4exAVXtwMseLl/OWvojq02XZqpX63JfMcXCvadoqpTfxM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789263096; c=relaxed/simple;
	bh=95MGt0HZYqffJwT5rtnedtXz7zhgit7A214Ryl4v+xs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pk2X67jxeDMtv7d7z9CV/1AbqqkamnprancfbBj6oPT5nW8yHmOlOkT18lMDd25ZvrbJ+quAGf8VzFbYJRqMzUvz04HClnnIIt1mWcLmS6UIw4Zi8vinXvsWF2XFeIM+C5J1CVzZZNDirOML1fO5qXuS6flMmoJrfX5QgIiUo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-7f66624aa21so440464a34.1
        for <bridge@lists.linux.dev>; Sat, 12 Sep 2026 18:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789263094; x=1789867894;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RMsHE5/zXRdmTcppBYZecH1Szld/jb42UiBCQemOLyc=;
        b=SL7wVl81XnixOoDFGsCVZc/Ujq3g/F2JTyJtwkw5mTMkt48uVWzpWPGCJeOlGk7Gbe
         qoh7RRrgJrU8zcCyRpydgqO9a5xbAkXR1NECqKvmEdGaZ+9YV1CFb6eHWrEfQqMGRXYP
         yLUechFCOi7sUEJv+3l2sJ3frZ/roC7t4uBiABcBnxQcAQz2Xo876PGDBUuJYl7Jrlrp
         a0lQyuCWRgwewgr/5jQjGPxlxnyl3RTEk3vYXXUf21Ad8Oaf7kXp2NPH00DL1/Ttn2jg
         p+MzlKdPZkc1he/KV4zJObBaheyoUL2Jg84kWv2qpwwNCSz+TaE/HfBzmCWpwKxUNau5
         ACtw==
X-Gm-Message-State: AFuF++nXuFtdxJ1olDUnnoih0r8biuOBLvN/8YIvtRQ9TMKA/oawPGeB
	oJUkTFbsRrZ7VVWg5sbG/2rwUDF90T04qLuDsL1VkRCc5rWv/HbKsTVg14BYzUowO6yA4U+uPVB
	aZ+dmNQGJDTspxJ9L/sIueC0v7JnO3xZL8M8Ug7mD7tCJ4i1fSd1N2KZZ+zRcyg==
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:810b:b0:6c1:6080:f32f with SMTP id
 006d021491bc7-6c24f650f4dmr2428675eaf.64.1789263094127; Sat, 12 Sep 2026
 18:31:34 -0700 (PDT)
Date: Sat, 12 Sep 2026 18:31:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa5fcf6.f2639fcc.29487d.0048.GAE@google.com>
Subject: [syzbot] [bridge?] WARNING: locking bug in match_held_lock
From: syzbot <syzbot+4d0e4d2db6dfde01b52f@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, idosch@nvidia.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, razor@blackwall.org, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a9d7ced84989 Add linux-next specific files for 20260908
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10880f49580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17eeb09695a2b3c9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d0e4d2db6dfde01b52f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4f470407358e/disk-a9d7ced8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/858b9d7ba687/vmlinux-a9d7ced8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef971d22d75f/bzImage-a9d7ced8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d0e4d2db6dfde01b52f@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "&ht->mutex" with key xfrm_policy_init.__key.84, but found a different class "key" with the same key
WARNING: kernel/locking/lockdep.c:958 at look_up_lock_class+0x8c/0x110 kernel/locking/lockdep.c:955, CPU#1: kworker/1:6/5751
Modules linked in:
CPU: 1 UID: 0 PID: 5751 Comm: kworker/1:6 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: usb_hub_wq hub_event
RIP: 0010:look_up_lock_class+0x9a/0x110 kernel/locking/lockdep.c:955
Code: 00 00 49 3b 46 18 0f 84 82 00 00 00 49 81 3e d0 44 58 94 74 79 48 8d 3d 44 f2 94 04 49 8b 16 49 8b 76 18 48 8b 8b b8 00 00 00 <67> 48 0f b9 3a eb 5d 90 89 f3 e8 67 0a f4 f8 e8 32 5c be f5 48 c7
RSP: 0018:ffffc90000a38070 EFLAGS: 00010002
RAX: ffffffff8c6bb940 RBX: ffffffff94478508 RCX: ffffffff8c6bb940
RDX: ffffffff9af23440 RSI: ffffffff8c6bb900 RDI: ffffffff907ddb20
RBP: 00000000ffffffff R08: 0000000000000100 R09: 0000000000000004
R10: 0000000000000003 R11: 0000000000000300 R12: 0000000000000246
R13: ffff8880307a8000 R14: ffffffff9af232c8 R15: ffffffff9af23440
FS:  0000000000000000(0000) GS:ffff888124db7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3401aff8 CR3: 0000000074540000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 match_held_lock+0x9a/0x120 kernel/locking/lockdep.c:5364
 __lock_is_held kernel/locking/lockdep.c:5654 [inline]
 lock_is_held_type+0x89/0x150 kernel/locking/lockdep.c:6016
 __rhashtable_lookup include/linux/rhashtable.h:623 [inline]
 rhashtable_lookup include/linux/rhashtable.h:668 [inline]
 xfrm_policy_inexact_lookup_rcu+0x60/0x750 net/xfrm/xfrm_policy.c:2068
 xfrm_policy_lookup_bytype+0xb35/0x1840 net/xfrm/xfrm_policy.c:2193
 xfrm_policy_lookup net/xfrm/xfrm_policy.c:2225 [inline]
 xfrm_bundle_lookup net/xfrm/xfrm_policy.c:3100 [inline]
 xfrm_lookup_with_ifid+0x416/0x1db0 net/xfrm/xfrm_policy.c:3241
 xfrmi_xmit2 net/xfrm/xfrm_interface_core.c:456 [inline]
 xfrmi_xmit+0x72d/0x1b80 net/xfrm/xfrm_interface_core.c:572
 __netdev_start_xmit include/linux/netdevice.h:5433 [inline]
 netdev_start_xmit include/linux/netdevice.h:5442 [inline]
 xmit_one net/core/dev.c:3937 [inline]
 dev_hard_start_xmit+0x2cd/0x830 net/core/dev.c:3953
 __dev_queue_xmit+0x14c0/0x3820 net/core/dev.c:4926
 NF_HOOK_COND include/linux/netfilter.h:314 [inline]
 ip6_output+0x337/0x540 net/ipv6/ip6_output.c:248
 dst_output include/net/dst.h:471 [inline]
 NF_HOOK include/linux/netfilter.h:325 [inline]
 ndisc_send_skb+0xcb2/0x1650 net/ipv6/ndisc.c:513
 addrconf_rs_timer+0x2d2/0x6c0 net/ipv6/addrconf.c:4078
 call_timer_fn+0x18d/0x5f0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x223/0x840 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:finish_task_switch+0x413/0xc60 kernel/sched/core.c:5378
Code: 04 00 00 41 c7 84 24 20 0e 00 00 00 00 00 00 0f 1f 44 00 00 49 83 c4 48 4c 89 e7 e8 57 48 55 0a e8 d2 1b 3a 00 fb 4c 8b 65 c8 <49> 8d bc 24 10 17 00 00 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0
RSP: 0018:ffffc900043ad940 EFLAGS: 00000206
RAX: 000000000004ba5f RBX: ffff8880b873cb20 RCX: 8000000000000001
RDX: 0000000000000006 RSI: ffffffff8e47d8da RDI: ffffffff8c6dc080
RBP: ffffc900043ad990 R08: ffffffff907a9cbf R09: 1ffffffff20f5397
R10: dffffc0000000000 R11: fffffbfff20f5398 R12: ffff8880307a8000
R13: ffff8880b873cae8 R14: dffffc0000000000 R15: 1ffff110170e7964
 context_switch kernel/sched/core.c:5530 [inline]
 __schedule+0x17e5/0x5940 kernel/sched/core.c:7295
 preempt_schedule_common+0x7f/0xd0 kernel/sched/core.c:7474
 preempt_schedule_thunk+0x16/0x40 arch/x86/entry/thunk.S:12
 __mutex_lock_common kernel/locking/mutex.c:656 [inline]
 __mutex_lock+0x31b/0x15a0 kernel/locking/mutex.c:821
 clear_eld drivers/gpu/drm/drm_edid.c:5691 [inline]
 update_display_info+0x455/0x9630 drivers/gpu/drm/drm_edid.c:6934
 drm_edid_connector_update+0x9b/0x13d0 drivers/gpu/drm/drm_edid.c:7338
 drm_connector_update_edid_property+0xde/0x140 drivers/gpu/drm/drm_edid.c:7396
 drm_helper_probe_single_connector_modes+0x126b/0x1880 drivers/gpu/drm/drm_probe_helper.c:644
 drm_client_modeset_probe+0x4e8/0x60c0 drivers/gpu/drm/drm_client_modeset.c:869
 __drm_fb_helper_initial_config_and_unlock+0x10e/0x1b50 drivers/gpu/drm/drm_fb_helper.c:1717
 drm_fbdev_client_hotplug+0x16c/0x230 drivers/gpu/drm/clients/drm_fbdev_client.c:66
 drm_client_register+0x16e/0x200 drivers/gpu/drm/drm_client.c:143
 drm_fbdev_client_setup+0x1a0/0x450 drivers/gpu/drm/clients/drm_fbdev_client.c:168
 drm_client_setup+0x107/0x220 drivers/gpu/drm/clients/drm_client_setup.c:46
 udl_usb_probe+0x137/0x150 drivers/gpu/drm/udl/udl_drv.c:105
 usb_probe_interface+0x788/0xe50 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_set_configuration+0x1ad8/0x2180 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_new_device+0x9aa/0x1690 drivers/usb/core/hub.c:2708
 hub_port_connect drivers/usb/core/hub.c:5580 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5966
 process_one_work kernel/workqueue.c:3407 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3490
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3571
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	49 3b 46 18          	cmp    0x18(%r14),%rax
   6:	0f 84 82 00 00 00    	je     0x8e
   c:	49 81 3e d0 44 58 94 	cmpq   $0xffffffff945844d0,(%r14)
  13:	74 79                	je     0x8e
  15:	48 8d 3d 44 f2 94 04 	lea    0x494f244(%rip),%rdi        # 0x494f260
  1c:	49 8b 16             	mov    (%r14),%rdx
  1f:	49 8b 76 18          	mov    0x18(%r14),%rsi
  23:	48 8b 8b b8 00 00 00 	mov    0xb8(%rbx),%rcx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb 5d                	jmp    0x8e
  31:	90                   	nop
  32:	89 f3                	mov    %esi,%ebx
  34:	e8 67 0a f4 f8       	call   0xf8f40aa0
  39:	e8 32 5c be f5       	call   0xf5be5c70
  3e:	48                   	rex.W
  3f:	c7                   	.byte 0xc7


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
