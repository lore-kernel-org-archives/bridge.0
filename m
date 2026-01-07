Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3D2EA169
	for <bridge@lists.linux.dev>; Wed,  7 Jan 2026 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767783799; cv=none; b=kVNnUOIKWHn/RC9jd/6R3mQj82syNe6b8XNHgy3seXT0lIFIv3IfPS5S3mmRNkSwXAzLj8SLNsBB3mv1ngJ4OStgbQo74EkxHedfyY9C99izm3pa4+OQOGzzGiWBvlxDINYr3LC4kyWMzlX5+eRscD6Lr3a39BqLH3/7s1uLZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767783799; c=relaxed/simple;
	bh=9YmFFHHYIqyVB3Ut9rjIEURsPfRSbWn9cithoGdSowA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PJpEE/Wv9/3Fdmwq6bBcIiWuyt4WzSTWBGDfwEw2Aox6DHj+vNZ0AisXV4RvqmVL4F78rGt0BvVOoQm/qXs+ZL4EKDQQqQK6dwLAbqKB4dDRhhUxEYnxO6dr7IAaOdUZlLLMUUdiP/AEmvs68IygU5pjVGkEfCHpWAFldY4h/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-65f540eb569so2998745eaf.1
        for <bridge@lists.linux.dev>; Wed, 07 Jan 2026 03:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767783796; x=1768388596;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAzea6RibarWVUjrp90ecxeeipp3LvJAd2KfQev/m34=;
        b=Gy+MBhtUxaXadxT4VaSWSDhO7oC4+gll0Gs8iTiYHwQKgCGd2BpbjCL1idPPnm2Cx2
         KgGyJxyT0bqHLALPZbmqftjjkvaDScymCfOFQDLoBI2fQMgyKFp3ih1MRPOB2dkU2ojd
         EQjR3SGjhqJ5AOyt3R2d4gUwdhqSvcgdbWfyW150RW/5ED1E+hbYs2Bwjnm6w9FtjeDR
         ePn4dSXYgwORgeRrBaQjfej8pSufrVq2y4H23/eWek5XMfMBp/PwGKkg2YRslv7SXtvR
         0QcX8vSXp7dnHDHyry/mpaWOti4cKMURAZDINTlGRkPjUrEfAhI7zADNZDTR6SxgUzIO
         TD8g==
X-Gm-Message-State: AOJu0YxF7YCKow5ummNU+wFyOeKeAleuCDocHESf2lb0dbObGW7ZGcRp
	mpDWNklS6hgqORVF+2GwPt9thTO66+PVoIM3j3EYP+aNL1AV8PU8vsCzX5wbdYjStB/gVnTmFsh
	Xzftp+/7mb1wfEjH/YVUDLV0dHsn0gtmOWLWVxxwz71fTujH4MItp9BVUNTBMGg==
X-Google-Smtp-Source: AGHT+IE/bvj8Ni/UExwZ9hRKWGqxU4MJF5rRLxU1s8dA+C5hRjhru7rhpGVctzgUZNlHKEjaVoQwZh5ck52qF5n7Tui/gByk1X4H
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:7815:b0:659:9a49:9023 with SMTP id
 006d021491bc7-65f5509c1admr623635eaf.80.1767783796217; Wed, 07 Jan 2026
 03:03:16 -0800 (PST)
Date: Wed, 07 Jan 2026 03:03:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695e3d74.050a0220.1c677c.035f.GAE@google.com>
Subject: [syzbot] [bridge?] KCSAN: data-race in br_fdb_update / br_fdb_update (8)
From: syzbot <syzbot+bfab43087ad57222ce96@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f0b9d8eb98df Merge tag 'nfsd-6.19-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1304c922580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b319ff1b6a2797ca
dashboard link: https://syzkaller.appspot.com/bug?extid=bfab43087ad57222ce96
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f91c35600c27/disk-f0b9d8eb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9edb3553b7a5/vmlinux-f0b9d8eb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d762ee145b8/bzImage-f0b9d8eb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bfab43087ad57222ce96@syzkaller.appspotmail.com

bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
==================================================================
BUG: KCSAN: data-race in br_fdb_update / br_fdb_update

read to 0xffff88811a0655c0 of 8 bytes by interrupt on cpu 1:
 br_fdb_update+0x106/0x460 net/bridge/br_fdb.c:1005
 br_handle_frame_finish+0x340/0xfc0 net/bridge/br_input.c:144
 br_nf_hook_thresh+0x1eb/0x220 net/bridge/br_netfilter_hooks.c:-1
 br_nf_pre_routing_finish_ipv6+0x4d1/0x570 net/bridge/br_netfilter_ipv6.c:-1
 NF_HOOK include/linux/netfilter.h:318 [inline]
 br_nf_pre_routing_ipv6+0x1fa/0x2b0 net/bridge/br_netfilter_ipv6.c:184
 br_nf_pre_routing+0x52b/0xbd0 net/bridge/br_netfilter_hooks.c:508
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x4f0/0x9e0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x5df/0x1920 net/core/dev.c:6026
 __netif_receive_skb_one_core net/core/dev.c:6137 [inline]
 __netif_receive_skb+0x59/0x270 net/core/dev.c:6252
 process_backlog+0x228/0x420 net/core/dev.c:6604
 __napi_poll+0x5f/0x300 net/core/dev.c:7668
 napi_poll net/core/dev.c:7731 [inline]
 net_rx_action+0x425/0x8c0 net/core/dev.c:7883
 handle_softirqs+0xba/0x290 kernel/softirq.c:622
 do_softirq+0x45/0x60 kernel/softirq.c:523
 __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 __alloc_skb+0x476/0x4b0 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1383 [inline]
 wg_socket_send_buffer_to_peer+0x35/0x120 drivers/net/wireguard/socket.c:192
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
 wg_packet_handshake_send_worker+0x10d/0x160 drivers/net/wireguard/send.c:51
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0x4ce/0x9d0 kernel/workqueue.c:3340
 worker_thread+0x582/0x770 kernel/workqueue.c:3421
 kthread+0x489/0x510 kernel/kthread.c:463
 ret_from_fork+0x149/0x290 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

write to 0xffff88811a0655c0 of 8 bytes by interrupt on cpu 0:
 br_fdb_update+0x13e/0x460 net/bridge/br_fdb.c:1006
 br_handle_frame_finish+0x340/0xfc0 net/bridge/br_input.c:144
 br_nf_hook_thresh+0x1eb/0x220 net/bridge/br_netfilter_hooks.c:-1
 br_nf_pre_routing_finish_ipv6+0x4d1/0x570 net/bridge/br_netfilter_ipv6.c:-1
 NF_HOOK include/linux/netfilter.h:318 [inline]
 br_nf_pre_routing_ipv6+0x1fa/0x2b0 net/bridge/br_netfilter_ipv6.c:184
 br_nf_pre_routing+0x52b/0xbd0 net/bridge/br_netfilter_hooks.c:508
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x4f0/0x9e0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x5df/0x1920 net/core/dev.c:6026
 __netif_receive_skb_one_core net/core/dev.c:6137 [inline]
 __netif_receive_skb+0x59/0x270 net/core/dev.c:6252
 process_backlog+0x228/0x420 net/core/dev.c:6604
 __napi_poll+0x5f/0x300 net/core/dev.c:7668
 napi_poll net/core/dev.c:7731 [inline]
 net_rx_action+0x425/0x8c0 net/core/dev.c:7883
 handle_softirqs+0xba/0x290 kernel/softirq.c:622
 do_softirq+0x45/0x60 kernel/softirq.c:523
 __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 fpregs_unlock arch/x86/include/asm/fpu/api.h:77 [inline]
 kernel_fpu_end+0x6c/0x80 arch/x86/kernel/fpu/core.c:480
 blake2s_compress+0x67/0x1740 lib/crypto/x86/blake2s.h:42
 blake2s_update+0xa3/0x160 lib/crypto/blake2s.c:119
 hmac+0x141/0x270 drivers/net/wireguard/noise.c:324
 kdf+0x10b/0x1d0 drivers/net/wireguard/noise.c:375
 mix_dh drivers/net/wireguard/noise.c:413 [inline]
 wg_noise_handshake_create_initiation+0x1ac/0x520 drivers/net/wireguard/noise.c:550
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:34 [inline]
 wg_packet_handshake_send_worker+0xb2/0x160 drivers/net/wireguard/send.c:51
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0x4ce/0x9d0 kernel/workqueue.c:3340
 worker_thread+0x582/0x770 kernel/workqueue.c:3421
 kthread+0x489/0x510 kernel/kthread.c:463
 ret_from_fork+0x149/0x290 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

value changed: 0x0000000100026abc -> 0x0000000100026abd

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 8678 Comm: kworker/u8:42 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
==================================================================
net_ratelimit: 6540 callbacks suppressed
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:aa, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:aa, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:96:6e:14:75:db:9d, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:96:6e:14:75:db:9d, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
net_ratelimit: 7050 callbacks suppressed
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:aa, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:aa, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:96:6e:14:75:db:9d, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:96:6e:14:75:db:9d, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)


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
