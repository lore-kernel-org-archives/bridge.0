Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426A93168E6
	for <bridge@lists.linux.dev>; Sat,  5 Sep 2026 23:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788652598; cv=none; b=hTZlbvptwKo9qUSuEy0laZ1QOA+mOhs+bGQ2qc16T5kKfum4toG8dttxVVHKrJlGVBcrquEnHivp3WP9aR1wfkeP5rFFQVX0Q/faEYNwkPjrszAFtF4fmOjf2up1YS9P+QUrJjgYWKJslT04vnURMQGWXAOqoflvKETD8GtETMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788652598; c=relaxed/simple;
	bh=pddK2N0duwoQb1mI4YqZ2LJG7qWQL7Meue62j2M7jOU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LgAbUYcopV6y2SJGFkqlZTbwFLtbjXJaAL3Iubts1TZ00LqO187UvWjAmEBa2mWZhr0BN25SZaMDQXTi6NzToKSAE6gHqeogywTvvTLD5NxGqgzKDLOAa9e11cTthEUs9idH59/PAHFajmB/FItCy8KoVea7DTG8KjV+kZEutUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6b1b32cc57bso183846eaf.1
        for <bridge@lists.linux.dev>; Sat, 05 Sep 2026 16:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788652596; x=1789257396;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JnrjshyuggTKeO2OGoYPIVvGnKtaActQ8ii8qn0UbNs=;
        b=ssnau362hUGD1kq6NW38ZSsXYdimXUj5MHhiFoSEmQPw9vJS+Iniy+WBt5byBwcFjb
         iXinjjZPefv/VC4z1aAwd3de2M8tFDRq6VdC3QtNybmiZ7VpUzBDYD3UEG8rYgVEsfte
         NOx4UkWcLuJggUZvTgNRq+T+OWY5J4ClJeCt5SioQXD2zC2CxTHRj7XrDdrQDhlwED4B
         UWNZHdK/F+GH9NRe9DuwDhSUn1ErCPKMcoM2H4VnbpPOc2d6qR7Kd9cuqzw4gQdkdPGn
         aNf90x4np92TDnc6J5brlOMkq5Fz50J6r0C0zBFpMj2SWlAWirM2ICOaRjp5SAsIIEBl
         3ASA==
X-Forwarded-Encrypted: i=1; AKwUvBwbLG0ZLOZKDxjnnDk4iS74dZlsek6/BS9DbzS2lPKGXx0qYKO5G2jThx12OWFAlD9zfpt/8VU=@lists.linux.dev
X-Gm-Message-State: AFuF++mq25T2WJU8ENSD7NkmNhSFFCAbr5uiBLeH5wN2KgcsV9edOkU5
	xeFWCje9LzylnGzE8ebO6uE8Q7WH5+nxa+vmdZun4xm6H+8qx0ZusOPcWZRwgwTLyAhFLwqLF2a
	xxFi7CmMF9fK5k2EHa9nj/hpO4xYiqFTMEe4kJQ2Ji9z99ziZy0ggwIZqmtg=
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:179b:b0:6ae:9815:7c8e with SMTP id
 006d021491bc7-6b6fd2cea24mr10082448eaf.21.1788652596282; Sat, 05 Sep 2026
 16:56:36 -0700 (PDT)
Date: Sat, 05 Sep 2026 16:56:36 -0700
In-Reply-To: <6a9a137f.9266084e.bf0d7.02e3.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9cac34.37659fcc.e790.0005.GAE@google.com>
Subject: Re: [syzbot] [bridge?] general protection fault in br_del_frame
From: syzbot <syzbot+1df7473ef265fe8ba6e1@syzkaller.appspotmail.com>
To: andrew@lunn.ch, bridge@lists.linux.dev, davem@davemloft.net, 
	edumazet@google.com, eric.dumazet@gmail.com, horms@kernel.org, 
	idosch@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4d7d9486c04d Merge tag 'integrity-v7.3-rc2' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16aeeb49580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85bc5cc2fc7394d9
dashboard link: https://syzkaller.appspot.com/bug?extid=1df7473ef265fe8ba6e1
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10da9125580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15aeeb49580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4d7d9486.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1233b136bf9d/vmlinux-4d7d9486.xz
kernel image: https://storage.googleapis.com/syzbot-assets/25eb977d33cf/bzImage-4d7d9486.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1df7473ef265fe8ba6e1@syzkaller.appspotmail.com

bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
Oops: general protection fault, probably for non-canonical address 0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead000000000127]
CPU: 1 UID: 0 PID: 5761 Comm: kworker/u32:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:__hlist_del include/linux/list.h:1045 [inline]
RIP: 0010:hlist_del_rcu include/linux/rculist.h:599 [inline]
RIP: 0010:br_del_frame+0x106/0x1a0 net/bridge/br_input.c:482
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 87 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 18 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 76 49 89 1c 24 48 85 db 74 24 e8 36 8b 6b f7 48 8d
RSP: 0018:ffffc9000497f8e8 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 1bd5a00000000024 RSI: ffffffff8a9fb08f RDI: ffffffff91470cb8
RBP: ffffffff91470ca0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: dead000000000122
R13: ffff888068c49400 R14: 000000000000001c R15: ffff888068c49400
FS:  0000000000000000(0000) GS:ffff888096a63000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f7036630 CR3: 00000000223c0000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 mep_delete_implementation+0x292/0x340 net/bridge/br_cfm.c:591
 br_cfm_port_del+0x14f/0x1e0 net/bridge/br_cfm.c:872
 del_nbp+0x168/0xd50 net/bridge/br_if.c:348
 br_dev_delete+0x96/0x1c0 net/bridge/br_if.c:387
 br_net_exit_rtnl+0xdb/0x140 net/bridge/br.c:414
 ops_exit_rtnl_list net/core/net_namespace.c:181 [inline]
 ops_undo_list+0x896/0xab0 net/core/net_namespace.c:249
 cleanup_net+0x499/0x920 net/core/net_namespace.c:706
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__hlist_del include/linux/list.h:1045 [inline]
RIP: 0010:hlist_del_rcu include/linux/rculist.h:599 [inline]
RIP: 0010:br_del_frame+0x106/0x1a0 net/bridge/br_input.c:482
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 87 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 18 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 76 49 89 1c 24 48 85 db 74 24 e8 36 8b 6b f7 48 8d
RSP: 0018:ffffc9000497f8e8 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 1bd5a00000000024 RSI: ffffffff8a9fb08f RDI: ffffffff91470cb8
RBP: ffffffff91470ca0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: dead000000000122
R13: ffff888068c49400 R14: 000000000000001c R15: ffff888068c49400
FS:  0000000000000000(0000) GS:ffff888096a63000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f7036630 CR3: 00000000223c0000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	00 fc                	add    %bh,%ah
   2:	ff                   	lcall  (bad)
   3:	df 48 89             	fisttps -0x77(%rax)
   6:	fa                   	cli
   7:	48 c1 ea 03          	shr    $0x3,%rdx
   b:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   f:	0f 85 87 00 00 00    	jne    0x9c
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	4c 8b 65 18          	mov    0x18(%rbp),%r12
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 76                	jne    0xa6
  30:	49 89 1c 24          	mov    %rbx,(%r12)
  34:	48 85 db             	test   %rbx,%rbx
  37:	74 24                	je     0x5d
  39:	e8 36 8b 6b f7       	call   0xf76b8b74
  3e:	48                   	rex.W
  3f:	8d                   	.byte 0x8d


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
