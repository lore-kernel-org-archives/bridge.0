Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746332692D
	for <bridge@lists.linux.dev>; Tue, 10 Feb 2026 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770706548; cv=none; b=u54GfDy+XPkhtesckMnZxRqkQqqMOhAkbh4h88nanbsc89DiYA3nshDFE1X8BPw7m7RlfFTdbA8sQJsgxE0JcrHvw1bo9i939bX92RgQI3z6c0i2YqgNSuGaSZrfW+Z30SbiSvrFlpkNUw7/v+OG8WBenr0gDj2vXvtiVgACifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770706548; c=relaxed/simple;
	bh=KO8LeRWdnQ7ue91IOj0rRDJYZAFWjIoKwqELEeGO6cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R50blTnYMc15qqidvRibGtM55qjHsJ/wNX4l9KSMDhbNOV+uyMpITycsjGTxAywMKZpgUP2+SBEIT5yE9m4g8VeJjs7870W22ZVK6FYKJaiZ8zbO+NC1stL7sGyNHluxW+tCXs6ZLEHVf3uep1W716RlERwhz4SwAToVBKzLya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=k23le58M; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="k23le58M"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1248d27f293so1141434c88.0
        for <bridge@lists.linux.dev>; Mon, 09 Feb 2026 22:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1770706546; x=1771311346; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wEKhjBqUUwBZ7lofXCvuHTKUFxrtEOLIEsF1dJpnu7c=;
        b=k23le58MAnds+FkxtHkQsubKC08adi+b/pbWw265YFUXt0kiU+1uZn2PO0UHQXsVMS
         2csnpq11ld+jntikHxqZAcxLWHKd2bcD+16y55+zdgYYKJelun/cO89virjIIt7onYoj
         9CFkCGk3h8W1LKXZ1gWHQdZy99q8jhj3rVgLIHOFcVKyH4Ti7QE8GLxBclDSNhWq5Xph
         STv7SHTqfa1AxT9dmNCfTGktaZw6xODgxBgiVmE5DabI5V8bZHt2XphN/kqI1RorYpBe
         ezvRwxnz+gxCkvFHGpIhk9vNwU3DpbqvT0VnG9afvlIDvl/XUOaaygKZKaWBYaYaB1W4
         Hehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770706546; x=1771311346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEKhjBqUUwBZ7lofXCvuHTKUFxrtEOLIEsF1dJpnu7c=;
        b=YvXn7PA7BwA8OMtn3YOqcZm20cVsiblUFv2HjUqD2P1G/W+PiD21Tejn4QOwoCzHij
         1m//FdBLkjWApYMn62rXcpAS2P4Dg3wW1WwyJXqBhmpBvozZN3nQNWyWs0rM1+uJDWvs
         z+uQbk85hvNVA5LLd1ePLb6mF6g4arJvZ7UEsK2XaV12FrfqywAYb+QN8AIb3x0/nCPD
         aq5AWHGdTTFI6GLEgSVkEO0hhIYw1FTd0woiKJfDMJLhU/hS29RAPBCXPSuPAn6bj7NN
         buNmZpYh4NgeHFXFY6vxtw0EexjQITSg7HhnEDv9uqrwS7rYBwyjukKeeVc1wTec50E2
         TSZQ==
X-Gm-Message-State: AOJu0YwZojTWLoAK2wZ8xmU+sOAH4MM/s7TzN2pllam4G8EIqHi3BJl0
	WOLEC//16IwdUBKQcY2wX2CbE2I79eU3gwTXfT+iNmVLULTVHFmLxmQxq1hVDBSF2No=
X-Gm-Gg: AZuq6aJTq6Wql66/NMCHZxk8wAvaC8eC99ea3gFP3rdsXJs+TnpbRckWRiNIlzJwiPA
	QI37guj4ssJBD8tE+ZllhZUf2D5Zo/Jjadx+YqM1tnhNF8UiKJuwC6ZV7WZb8EYQyL4clsaZli9
	VEmExLDpanGDF2IL+xUKLwftbsRId1mQh89iDH4hdXgLXWKOgVStFJpocLrm7kWqh1+V2eC9sGu
	CXMOq6S3ld8J1MI2Wb/CtqpkJPmxYTJo75vdVl3BdM+RrrtUAWWSyzAl6lmwBr/kHHZv1b4wFbv
	RZVJYsfc8jzcLStAny/TfOf1l8ckv6ocvHdsVsN4baGI0ozg6KuNnthOouW9s4CtGQuCjbncRqH
	Xm3jyjyQnkP31NxbcRVAcioOakOGUN1GbcEmt6yYSbfvgrHNlUw3asqOBpuuYEoc1WWDgErHKsR
	QI12fuz97Tg4KhJ6kRupZLVIJxA4BKTNC/svkHo+4gTDiZfuXq9SEqZhoP
X-Received: by 2002:a05:7300:cd99:b0:2b8:711:ae5c with SMTP id 5a478bee46e88-2b85645a39fmr6753095eec.7.1770706546294;
        Mon, 09 Feb 2026 22:55:46 -0800 (PST)
Received: from localhost (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2ba734ed83csm3453139eec.23.2026.02.09.22.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 22:55:44 -0800 (PST)
Date: Tue, 10 Feb 2026 08:55:41 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: syzbot <syzbot+d5d1b7343531d17bd3c5@syzkaller.appspotmail.com>
Cc: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bridge?] WARNING in br_multicast_del_pg
Message-ID: <aYrWbRp83MQR1ife@debil>
References: <698aa7bb.050a0220.3b3015.0086.GAE@google.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698aa7bb.050a0220.3b3015.0086.GAE@google.com>

On Mon, Feb 09, 2026 at 07:36:27PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c89477ad7944 inet: RAW sockets using IPPROTO_RAW MUST drop..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f73a5a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=d5d1b7343531d17bd3c5
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/277c818ebac6/disk-c89477ad.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d4e6f0388a87/vmlinux-c89477ad.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/14eabb9cbd91/bzImage-c89477ad.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d5d1b7343531d17bd3c5@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> n == 0
> WARNING: net/bridge/br_multicast.c:718 at br_multicast_port_ngroups_dec_one net/bridge/br_multicast.c:718 [inline], CPU#0: syz.4.4607/22043
> WARNING: net/bridge/br_multicast.c:718 at br_multicast_port_ngroups_dec net/bridge/br_multicast.c:771 [inline], CPU#0: syz.4.4607/22043
> WARNING: net/bridge/br_multicast.c:718 at br_multicast_del_pg+0x1bbe/0x1e20 net/bridge/br_multicast.c:825, CPU#0: syz.4.4607/22043
> Modules linked in:

I have an idea how this could happen, I'll prepare a fix.

Cheers,
 Nik

> CPU: 0 UID: 0 PID: 22043 Comm: syz.4.4607 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
> RIP: 0010:br_multicast_port_ngroups_dec_one net/bridge/br_multicast.c:718 [inline]
> RIP: 0010:br_multicast_port_ngroups_dec net/bridge/br_multicast.c:771 [inline]
> RIP: 0010:br_multicast_del_pg+0x1bbe/0x1e20 net/bridge/br_multicast.c:825
> Code: 41 5f 5d e9 04 7a 48 f7 e8 3f 73 5c f7 90 0f 0b 90 e9 cf fd ff ff e8 31 73 5c f7 90 0f 0b 90 e9 16 fd ff ff e8 23 73 5c f7 90 <0f> 0b 90 e9 60 fd ff ff e8 15 73 5c f7 eb 05 e8 0e 73 5c f7 48 8b
> RSP: 0018:ffffc9000c207220 EFLAGS: 00010293
> RAX: ffffffff8a68042d RBX: ffff88807c6f1800 RCX: ffff888066e90000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffff888066e90000 R09: 000000000000000c
> R10: 000000000000000c R11: 0000000000000000 R12: ffff8880303ef800
> R13: dffffc0000000000 R14: ffff888050eb11c4 R15: 1ffff1100a1d6238
> FS:  00007fa45921b6c0(0000) GS:ffff8881256f5000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa4591f9ff8 CR3: 0000000081df2000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  br_mdb_flush_pgs net/bridge/br_mdb.c:1525 [inline]
>  br_mdb_flush net/bridge/br_mdb.c:1544 [inline]
>  br_mdb_del_bulk+0x5e2/0xb20 net/bridge/br_mdb.c:1561
>  rtnl_mdb_del+0x48a/0x640 net/core/rtnetlink.c:-1
>  rtnetlink_rcv_msg+0x77e/0xbe0 net/core/rtnetlink.c:6967
>  netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
>  netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>  netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
>  netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
>  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
>  __sys_sendmsg net/socket.c:2678 [inline]
>  __do_sys_sendmsg net/socket.c:2683 [inline]
>  __se_sys_sendmsg net/socket.c:2681 [inline]
>  __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa45839aeb9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fa45921b028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fa458615fa0 RCX: 00007fa45839aeb9
> RDX: 0000000000000000 RSI: 00002000000000c0 RDI: 0000000000000004
> RBP: 00007fa458408c1f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fa458616038 R14: 00007fa458615fa0 R15: 00007fff0b59fae8
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
