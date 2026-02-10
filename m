Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B0F238D42
	for <bridge@lists.linux.dev>; Tue, 10 Feb 2026 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770694589; cv=none; b=QDcsjsvGyEkLopzrTTFxLXjqYuEnZ9mSrQ79yM6G7Wtvd5+FUd/eXKZl53BZuDaP5GUHYG1HL8GRz/OZqUvHk9pvlkzXbYVLhMGWUVHJHb6LwEVWgjBdcpnmsGSoMxgcZ0q9DTJ2VE2hnAZc61NBS3BDD1k1WAgIciXVIIMgB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770694589; c=relaxed/simple;
	bh=n4Ix1TM0ZNgNrlgLXeHzo9bC/QstomgUPsY+9oTMg4w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gHzZyTjHq5FggRIUH1RvKovTLi0XZdsGztezYUCSr/N/6LoOSbWI8qxcmiDFBSiRAB5vssUzDSkF5ooUpt4cb5u6EOFDbapf0+wLd2F7CLnvlWZisfecwub/pQxZb0vDr2ak7xQ4DLDAOG7rxZESPu2UDVesrVTcBDOo6upGgbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-3fda122aeafso16988321fac.0
        for <bridge@lists.linux.dev>; Mon, 09 Feb 2026 19:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770694587; x=1771299387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kv6zYoNwOXJgrs/PCSsWLPPE13Dl39IaBgyYn8cysGs=;
        b=A07XqX9N5UJXAYuHJdPYACD77ZPq8jEE/45bT9HUK6cEOsjEpnKQ83NqhLMUFs6khR
         Qumpf9h6/g06E8+ecI2aGE45qMraVK8IdFTZt4hj0CVrrjz8WBxQcV62ngTkFf+/svUa
         bCss973MG9cXcWGUMaeeNo6hRY4zgEehhHGAfGIwEX6X0z/GchGlw4kvKYPiidj3U6JE
         DRmtDmdtoAgdG7Jxu1VhPzH/zRmz7UuwktOSHUOpBN5S/dW7XALap/DKP8awsvX0B8bJ
         Z4vXTz+QsNeAoK5N3Nxtc2dC3YK1Zji0DlTWs6lrLuxPNdG/UxgkqQPE9Y/oQ5dWivzP
         OtEg==
X-Gm-Message-State: AOJu0YwG1E325X/X8tuh2kpPGJBcOJLtwbeSc+sjIR518XBq4NPtasw/
	4zgkdvwF7QFQDpXV6Am2HL9yV7oOthD9T8lCFpwVeJ+Clt1GcDfTVu706bsajUX7K2Ad9QDQRha
	MqP+0e6GxScmTdTw9PoUfp17a2ME7XG+iSbBG4SdeeneVtNBlT47k3/ZJZBQ=
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1612:b0:672:605f:db65 with SMTP id
 006d021491bc7-672ff74369bmr319269eaf.81.1770694587659; Mon, 09 Feb 2026
 19:36:27 -0800 (PST)
Date: Mon, 09 Feb 2026 19:36:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698aa7bb.050a0220.3b3015.0086.GAE@google.com>
Subject: [syzbot] [bridge?] WARNING in br_multicast_del_pg
From: syzbot <syzbot+d5d1b7343531d17bd3c5@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c89477ad7944 inet: RAW sockets using IPPROTO_RAW MUST drop..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15f73a5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff
dashboard link: https://syzkaller.appspot.com/bug?extid=d5d1b7343531d17bd3c5
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/277c818ebac6/disk-c89477ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d4e6f0388a87/vmlinux-c89477ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/14eabb9cbd91/bzImage-c89477ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d5d1b7343531d17bd3c5@syzkaller.appspotmail.com

------------[ cut here ]------------
n == 0
WARNING: net/bridge/br_multicast.c:718 at br_multicast_port_ngroups_dec_one net/bridge/br_multicast.c:718 [inline], CPU#0: syz.4.4607/22043
WARNING: net/bridge/br_multicast.c:718 at br_multicast_port_ngroups_dec net/bridge/br_multicast.c:771 [inline], CPU#0: syz.4.4607/22043
WARNING: net/bridge/br_multicast.c:718 at br_multicast_del_pg+0x1bbe/0x1e20 net/bridge/br_multicast.c:825, CPU#0: syz.4.4607/22043
Modules linked in:
CPU: 0 UID: 0 PID: 22043 Comm: syz.4.4607 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:br_multicast_port_ngroups_dec_one net/bridge/br_multicast.c:718 [inline]
RIP: 0010:br_multicast_port_ngroups_dec net/bridge/br_multicast.c:771 [inline]
RIP: 0010:br_multicast_del_pg+0x1bbe/0x1e20 net/bridge/br_multicast.c:825
Code: 41 5f 5d e9 04 7a 48 f7 e8 3f 73 5c f7 90 0f 0b 90 e9 cf fd ff ff e8 31 73 5c f7 90 0f 0b 90 e9 16 fd ff ff e8 23 73 5c f7 90 <0f> 0b 90 e9 60 fd ff ff e8 15 73 5c f7 eb 05 e8 0e 73 5c f7 48 8b
RSP: 0018:ffffc9000c207220 EFLAGS: 00010293
RAX: ffffffff8a68042d RBX: ffff88807c6f1800 RCX: ffff888066e90000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff888066e90000 R09: 000000000000000c
R10: 000000000000000c R11: 0000000000000000 R12: ffff8880303ef800
R13: dffffc0000000000 R14: ffff888050eb11c4 R15: 1ffff1100a1d6238
FS:  00007fa45921b6c0(0000) GS:ffff8881256f5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa4591f9ff8 CR3: 0000000081df2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 br_mdb_flush_pgs net/bridge/br_mdb.c:1525 [inline]
 br_mdb_flush net/bridge/br_mdb.c:1544 [inline]
 br_mdb_del_bulk+0x5e2/0xb20 net/bridge/br_mdb.c:1561
 rtnl_mdb_del+0x48a/0x640 net/core/rtnetlink.c:-1
 rtnetlink_rcv_msg+0x77e/0xbe0 net/core/rtnetlink.c:6967
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa45839aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa45921b028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fa458615fa0 RCX: 00007fa45839aeb9
RDX: 0000000000000000 RSI: 00002000000000c0 RDI: 0000000000000004
RBP: 00007fa458408c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa458616038 R14: 00007fa458615fa0 R15: 00007fff0b59fae8
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
