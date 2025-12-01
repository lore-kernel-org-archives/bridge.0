Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281333507A
	for <bridge@lists.linux.dev>; Mon,  1 Dec 2025 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608919; cv=none; b=QBJ2+fmHsD4SsKOrz/4aozsFGFCtl3YZAB0zki6HhiYATTWt035QfVhPBCY9poQU8qVpK2gYNl2d4EpdV5wL0ZoaUxRrIjdght+NLSFIApNPDYLPLNEcC7uz5xaEJAIQJ5xbrxU/eSYdO0aEIevYY4zlgcSPp4n4mGt6yTKMaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608919; c=relaxed/simple;
	bh=bBXkacKZ3dPPSO1kOOntC9FmsUogIrenh6VYlbtFTxg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=vFrUKTULBttLxbadJkXRzLAEwm1XgXtfcx/OlTMIPFdGD8xgJQlTg4RzclPI93tZHAOJ7/lGl7MIGMAdoieGMoeJKbBgkvti/Z5lHwvhWlBEUKwSpflDP/lpv6L0OmISRStGwk0WxRr7Gc2oXVEeoB08k4erDKm9hPFjOWa/2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-65747f4376bso6308059eaf.2
        for <bridge@lists.linux.dev>; Mon, 01 Dec 2025 09:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764608917; x=1765213717;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IGgw4cmQSTUXMDHP6hSXGRUhINvpMa94Hp04p38gdUQ=;
        b=iX+iNDP3r3L55Gph/MuDizqom/jUTp1ifGa2S8gRT404qRW4McPRRfV09wYrFHinp8
         WpdDIgSGcxqI9vngivvbZJqwy09f0dHGB/+/4bjB0srvicEmyNhISmqgjf0V6K7Q5AZp
         Nrg8SLR6pmWUOoKikPFZtYWuF8wIt59gkmCn/aLjRfXiWuAkjcTwhdSjVHC+NpCu6sNe
         SzA5GpjD8QQO4rb6E7Tf9vpEEwQ1wUOflYsKSpLBvLAsyn/vVG/XPqcCVpPMcdAx/jvR
         fpE53b2rwdOBAmvgsmnZkUSvhvR/iCrNyA3jGj4o+PuLK9z+V+jd56GamwG+46Lb7NfW
         8Tzg==
X-Gm-Message-State: AOJu0Yxzx6QtFEKBLPPbeIoY15ICqOcO4xW9lAV8eJw7ohl7iWzmxd7x
	ZZpKR5fW426ZCHS397HZuaEHe7IJ5/nWdo5lhNJ1rF/ABq4WjoNRdWhdA6nHorYOusfXL30mkRi
	6YhXYIvcuu3vfe/mDZJwF6c3aVRlHTw8MNmTPtXMIekwyRG4A1r34z4Gtjep5xQ==
X-Google-Smtp-Source: AGHT+IH9NuFruHmgK/3D/rVbGU7t6FAooCbOPK47woHfGrJ9gVgHedVFHG3uvO9GUzJhQf2rwRrYEU0KFR8lwlyYUSPCcRzfjuvy
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3448:b0:450:4628:e3f2 with SMTP id
 5614622812f47-4514e7a4293mr11442006b6e.42.1764608915594; Mon, 01 Dec 2025
 09:08:35 -0800 (PST)
Date: Mon, 01 Dec 2025 09:08:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692dcb93.a70a0220.2ea503.00b6.GAE@google.com>
Subject: [syzbot] [bridge?] INFO: task hung in br_ioctl_stub (2)
From: syzbot <syzbot+6bdeba54c73aa6a6219d@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    765e56e41a5a Merge tag 'v6.18rc7-SMB-client-fix' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159ace12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1db0fea040c2a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=6bdeba54c73aa6a6219d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ddee12580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-765e56e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd649009c819/vmlinux-765e56e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bf3e0d5c78c2/bzImage-765e56e4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6bdeba54c73aa6a6219d@syzkaller.appspotmail.com

INFO: task syz.0.27:5720 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.27        state:D stack:28904 pid:5720  tgid:5719  ppid:5469   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7083
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 br_ioctl_stub+0x199/0xc80 net/bridge/br_ioctl.c:418
 br_ioctl_call net/socket.c:1227 [inline]
 sock_ioctl+0x4d8/0x790 net/socket.c:1329
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f91bf78f7c9
RSP: 002b:00007f91c0675038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f91bf9e5fa0 RCX: 00007f91bf78f7c9
RDX: 0000200000000000 RSI: 00000000000089a2 RDI: 0000000000000003
RBP: 00007f91bf813f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f91bf9e6038 R14: 00007f91bf9e5fa0 R15: 00007ffd440d2c68
 </TASK>
INFO: task kworker/u4:11:5722 blocked for more than 150 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:11   state:D stack:28872 pid:5722  tgid:5722  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events_unbound linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7083
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
