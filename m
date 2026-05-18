Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CB348035B
	for <bridge@lists.linux.dev>; Mon, 18 May 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109286; cv=none; b=nRem7gMNIvktXOXfoR1CQ4EpK4lAy4zXgkapgV7nbCZcr5IFyofixndyUa3mF1kGT77FCzGh7tQOxUk0GO60FIKdtr0fOgbLr1djukUrwI2pCndw49Ho82CgjmX6JMVACotckp2oNMavnEhGACN0tE4NnVkpfdfYtTePM3bv5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109286; c=relaxed/simple;
	bh=lLl6RY6caPM3rOvfBqXkbSVRHfr3cxYaeRWdxt5n5hE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Rag4LwfSCAvZf3dq075kc/TeYZeAfUsOLMemSf0AaIOuy5gwNu0yUrPdf8Vjg0/b6e3lR9k+f7ASEdBGDqwNwMtkL79AEkyzljElLf53X0k+Y80nB4AQegROl951/OZvNQDpa51NGz8ku95SmYDilDwh2R2pqTFRN6P9fBrDP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7dcc59fe0d8so3605504a34.2
        for <bridge@lists.linux.dev>; Mon, 18 May 2026 06:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109284; x=1779714084;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15XVrlqFLSsUnhnxXxSwCW7nrZfhUDLDuTiL9dFIkEs=;
        b=Fyeptlt7DS7KoPqDgMqgKG1cnvZu86pHXFsRkwBewESqbNumaX30TmIivW6ZH8HLzm
         s6g70XBocGWafZa8HlZDwHwDfb8n8QG1GHw7kQHkrRhbFdED8mPC2yNFxR5OotLihNWK
         /e61+Z3nRgdx5i/Jb1arN36tWtJGa4XnGnUGUZqxvMJ/KhWzOyHSNl5noCSgFMwJIS/8
         XBkHnBKr1ELj6KlGehtgbwwEWhSGZGtBjAAaa6AeZOI5Dvj4XeaD0gbUqMRSq7Ho7LXr
         MmU+er7KWIi56JtrVWvkIhPofMfCzUSlkXiKhKxDIOjuO6cL8p+rWr1WD89a6LonbxZi
         i7iw==
X-Gm-Message-State: AOJu0Yyz3uo2bV1rsZmb3yWy9MTtNDwbS+SY2DZ6jlX8wdSdUDcz/7Vz
	ZPex/R37e/UAimzpz2OaNN23T0gfrCKo61EDOgNdapBoqqei95WLYKjqhOMaR1iCjf+cGGHC7Bw
	HoC35VfbUoqUWhdvEPnhzt6d1Nzd+jzGABSORoCVnaLOd0PbbODQTpL7nbAG1kQ==
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:d17:b0:7dc:cd0b:58af with SMTP id
 46e09a7af769-7e4f2a2d671mr9973331a34.6.1779109283951; Mon, 18 May 2026
 06:01:23 -0700 (PDT)
Date: Mon, 18 May 2026 06:01:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0b0da3.050a0220.175f0c.0000.GAE@google.com>
Subject: [syzbot] [bridge?] WARNING in br_fill_linkxstats
From: syzbot <syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    627ac78f2741 ipv6: addrconf: bail out of dad_failure when ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1074102e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2b487b72ffad035
dashboard link: https://syzkaller.appspot.com/bug?extid=a35f9259d08f907c06e6
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/81fff4bdde96/disk-627ac78f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b0352468dcd/vmlinux-627ac78f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6db18d47dfe4/bzImage-627ac78f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com

------------[ cut here ]------------
diff > ((u16)~0U)
WARNING: ./include/net/netlink.h:2265 at nla_nest_end include/net/netlink.h:2265 [inline], CPU#1: syz.2.5599/27626
WARNING: ./include/net/netlink.h:2265 at br_fill_linkxstats+0x9e7/0xae0 net/bridge/br_netlink.c:1910, CPU#1: syz.2.5599/27626
Modules linked in:
CPU: 1 UID: 0 PID: 27626 Comm: syz.2.5599 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:nla_nest_end include/net/netlink.h:2265 [inline]
RIP: 0010:br_fill_linkxstats+0x9e7/0xae0 net/bridge/br_netlink.c:1910
Code: b6 bd 08 48 3b 84 24 60 01 00 00 75 33 44 89 f0 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 50 8f 30 01 cc e8 0a 1b 49 f7 90 <0f> 0b 90 e9 bc fe ff ff e8 fc 1a 49 f7 90 0f 0b 90 e9 53 ff ff ff
RSP: 0018:ffffc9000d04f160 EFLAGS: 00010287
RAX: ffffffff8a7ca956 RBX: 0000000000013550 RCX: 0000000000080000
RDX: ffffc90010069000 RSI: 0000000000006616 RDI: 0000000000006617
RBP: ffffc9000d04f310 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff92001a09e40 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f437e58c6c0(0000) GS:ffff88812537a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7ecf36ab4c CR3: 000000003d060000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rtnl_fill_statsinfo+0x541/0x26f0 net/core/rtnetlink.c:6018
 rtnl_stats_get+0x4b6/0x6d0 net/core/rtnetlink.c:6340
 rtnetlink_rcv_msg+0x77e/0xbe0 net/core/rtnetlink.c:7018
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f437d79ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f437e58c028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f437da16090 RCX: 00007f437d79ce59
RDX: 0000000000000000 RSI: 0000200000000040 RDI: 000000000000000a
RBP: 00007f437d832d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f437da16128 R14: 00007f437da16090 R15: 00007ffe687b3418
 </TASK>


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
