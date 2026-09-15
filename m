Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5D395266
	for <bridge@lists.linux.dev>; Tue, 15 Sep 2026 04:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445228; cv=pass; b=sVqfkecyfiXXlZNw+kxyifA9eR1PM6W3+BuLWBLK6BfAV297lCAYV5DPHjsxHLUNki5lRZDa+llJ5aGJc2K9li0kZO2B8y4YV1a+EIjKftZkHpoYGkoSf7rEKxUd4+g0AThdAWk6IRbhNeSqodSW1/iJndeO2dbCP0798JC44Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445228; c=relaxed/simple;
	bh=7OBVt0Ud1YvIgH9Tp2l74XjcjTCwMxPkx/QsQOeUdF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hy7DOc/GkYU0Tu2ZobeSfAm+7fN1BuUeQB0uJsXVyr5kSCsXF0VGYGad0utcgGR//bjVFu+TlAzuex9eUeI7bjFvKwVZsMAuQFcTszmb1gMO/GoAeRalydR86uaHbZos0Ogoo8ADUYAzkIY3LmUT5KJWf0cc47jP2O4NjVGk0P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LMAwhSQ4; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LMAwhSQ4"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530fa0716f6so26167791cf.3
        for <bridge@lists.linux.dev>; Mon, 14 Sep 2026 21:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789445225; cv=none;
        d=google.com; s=arc-20260327;
        b=HtRm7QrpdOk7IJWj+i/toCvaOsIbhq1e5fuOf1PxEcOg2SkHOIMQ/5J60fqZ4C98Mp
         5B/oBjn0101Fxqz2wfn5MNKHLozgAr4caw7Gclihb69Ww7F1n60Q6MZZS8phg92vSOlS
         31wLFUCmu8PzpAGeZ/piY0VyrilpGg/4b/Mfng/4uby778/ATN1AOh+McMB7MeKc5AyY
         AVQpEcFDfIlt4gCxXeOq5WOBogAr+4YEcdIDsRUOnqtTHaaunkzmO7puzwxzfNDF4nKP
         W/NgZeMA6E/H+nkZbe7Dxk1N+LCUHA5oftZWY9qOh5xJbp1u+icnUlAp33loYuLWtgeQ
         hKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B6gDmPz3qGEPkH2fhejCEB9YBkrmj/2GMhhw0mxhtxo=;
        fh=vod+wGuNnMsZVJGnkQ2YPB9IRiFaE4qQ8CTeuCvQ2c4=;
        b=TBm/db6bkKyZNfiLGHY1G4W5vdIbni3ePpfUlIdr9FKykfoLBLWP+awCsiEwIHCAOp
         A+zqu6JiYAPHqFeZPLV6c2QC0lwhv802zqlbufiOl32YfWD53VKNJg2pygH+zdYupBrI
         5WcqFrkncwKmh79WkvdPhzG5AnyB8O9+g0SRFhNOMDUvw3eE2we1DkEiLkH/iOptPPZh
         qJbLGo+MHZww8wKZ54OMNLLeBZOX76uogV+7hJom1Q0YdDEA/e0KMCz2LUbLzbS3vwCi
         SMPD4PbgVe3h1Dlt6JonsemwGwWVnGhh8x21IdgbNVZqAL0Sf8UDJr3NFaEgzVPmx0ZH
         tj4A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789445225; x=1790050025; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B6gDmPz3qGEPkH2fhejCEB9YBkrmj/2GMhhw0mxhtxo=;
        b=LMAwhSQ4+DwUdrqqz41bRZb0nRYApz/7bmjSaZ695hSfyyAUFqxDWxw5I3cxurmf1B
         o00raN2IJ0xtksOWcbuKd59zqdYfvy7hUal40G0OgHVTZVjwoxrFV2HcVcbhZatGSenm
         EWiBjSbxSs5mMSRCbO9p/JYa96YGuqF+0rOYjf0iM/0qPap+3hXiymN8E/mvoP3nydHY
         hDFxjGX27D/VjtKlC9e0gOL7gSjw9XX2HbEQR2WISIR9dXMBe5IhNNYoMwqfChWKx23n
         IkM1bJJFP1eAI0qRvEgZL6OXM83cIH4b0QcQxmfItxEg7HVr/v1QEQtQ9U52d4i9fHzc
         jWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789445225; x=1790050025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B6gDmPz3qGEPkH2fhejCEB9YBkrmj/2GMhhw0mxhtxo=;
        b=O7A/d7d+ypUUkHiZp1GqZnQk5LSYYzEm1sNb9tSaPDpOF6AovigXjq8Brc6JvrL1QY
         Nqtfgno4DbGuhxEBK5GbpGfQH2I8MLXzUiT+XUqbzoAz99ODkKZoYhog15865/5hp4On
         FTOeD290hyClsIs2bjRCMPooWdbzPkLUERoM1RznrHuTdqjls1OJgSH4sdWd4O+YcOyP
         Jid8yIwYEds6pldadnRsOhmtapoyihpyiWe6NaC07n53xWZl6d/mN9T20iupZUpdC6Hi
         dAZetPd+jnL9IkLHL9ioDM1ZXu34BFsJmVYzdgMBzFPPt6XFhQl7xHyaP9ZzTVs6k0EH
         n7GQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuHDLnBA/IBCLd1bseKFxmLgF45mM9FO7J7N7wea500TuAX6jDzRFuDSyo6iec9llGSnFRnXg=@lists.linux.dev
X-Gm-Message-State: AFuF++kcZyEcnx/IDdSI1dIoQ85RdjZuWX1vENMye1M6wl6V0vthF4Ap
	5CztiydLsprit4d9H+Ux16C5NcgixZMMd003ch8NJvSiuSPGeKnd0rPEKUmOUDegKIo2jIaJaYO
	2a9ozwaboalUNJeGTjMSG4vjJmzhtvQODSfAF436N
X-Gm-Gg: AYBFou1Mpmp4kqxx15WYxRjD/fjzNeLNqYLvBfS8RBrbIVq0xxp611CxyzFjmFoVGZH
	PUsGByDMFHDcQPKbHtPCMr41kb5Jd4ZcAInwU2ar/XhaGmx27R/z4VQxM9X+EvSDq9svw9yFGkP
	a/GPDoXWw37Dmvfo8M658FScd23kKYwT/ij7VIXae3IufiIxBHZnU9WSjFyIAeOBz4TkvP/bc0G
	2mVsEImoj9HLsyz7kOrE7JAk7DExwS2+Vi08ejycpsTG7xsHjWUhM608acb1pjQQXJjWmYrbmIC
	sTZJaLr/HO1lHmbljNxBLFcgRXaZbDSdL+3AyvVebMR6p1wCGl1hOXX7TRZryNf9P6AY95vKW3t
	akn+0AdSxBZUUaatt+9gR6nALj8/tx1CSuzmsbaVYiChFy7tho2WI9BHYHiNKv5Yecv0=
X-Received: by 2002:ac8:5f48:0:b0:530:da1d:5892 with SMTP id
 d75a77b69052e-5310d02712emr82753041cf.37.1789445220111; Mon, 14 Sep 2026
 21:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6aa5fcf6.f2639fcc.29487d.0048.GAE@google.com> <aqi7fpazv2KDDdvn@shinmob>
In-Reply-To: <aqi7fpazv2KDDdvn@shinmob>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Sep 2026 21:06:49 -0700
X-Gm-Features: AcwNN1X82ZoI5TlCIJsK5WJwSy47t1reQOtezO_HIoo9MhkrsW5D1A4Z-cxzXak
Message-ID: <CANn89iJd0QnoDo0tjrFED2myec38U8joyqR05d6BVnJ-sX=NVg@mail.gmail.com>
Subject: Re: [syzbot] [bridge?] WARNING: locking bug in match_held_lock
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: syzbot <syzbot+4d0e4d2db6dfde01b52f@syzkaller.appspotmail.com>, 
	bridge@lists.linux.dev, davem@davemloft.net, herbert@gondor.apana.org.au, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com, Thomas Graf <tgraf@suug.ch>, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 8:40=E2=80=AFPM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> CC+: linux-crypto and rhashtable maintainers,
>
> On Sep 12, 2026 / 18:31, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    a9d7ced84989 Add linux-next specific files for 20260908
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10880f49580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D17eeb09695a=
2b3c9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D4d0e4d2db6dfd=
e01b52f
> > compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e=
255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/4f470407358e/d=
isk-a9d7ced8.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/858b9d7ba687/vmli=
nux-a9d7ced8.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/ef971d22d75f=
/bzImage-a9d7ced8.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+4d0e4d2db6dfde01b52f@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > Looking for class "&ht->mutex" with key xfrm_policy_init.__key.84, but =
found a different class "key" with the same key
> > WARNING: kernel/locking/lockdep.c:958 at look_up_lock_class+0x8c/0x110 =
kernel/locking/lockdep.c:955, CPU#1: kworker/1:6/5751
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 5751 Comm: kworker/1:6 Tainted: G             L     =
 syzkaller #0 PREEMPT(full)
> > Tainted: [L]=3DSOFTLOCKUP
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/24/2026
> > Workqueue: usb_hub_wq hub_event
> > RIP: 0010:look_up_lock_class+0x9a/0x110 kernel/locking/lockdep.c:955
> > Code: 00 00 49 3b 46 18 0f 84 82 00 00 00 49 81 3e d0 44 58 94 74 79 48=
 8d 3d 44 f2 94 04 49 8b 16 49 8b 76 18 48 8b 8b b8 00 00 00 <67> 48 0f b9 =
3a eb 5d 90 89 f3 e8 67 0a f4 f8 e8 32 5c be f5 48 c7
> > RSP: 0018:ffffc90000a38070 EFLAGS: 00010002
> > RAX: ffffffff8c6bb940 RBX: ffffffff94478508 RCX: ffffffff8c6bb940
> > RDX: ffffffff9af23440 RSI: ffffffff8c6bb900 RDI: ffffffff907ddb20
> > RBP: 00000000ffffffff R08: 0000000000000100 R09: 0000000000000004
> > R10: 0000000000000003 R11: 0000000000000300 R12: 0000000000000246
> > R13: ffff8880307a8000 R14: ffffffff9af232c8 R15: ffffffff9af23440
> > FS:  0000000000000000(0000) GS:ffff888124db7000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b3401aff8 CR3: 0000000074540000 CR4: 00000000003526f0
> > Call Trace:
> >  <IRQ>
> >  match_held_lock+0x9a/0x120 kernel/locking/lockdep.c:5364
> >  __lock_is_held kernel/locking/lockdep.c:5654 [inline]
> >  lock_is_held_type+0x89/0x150 kernel/locking/lockdep.c:6016
> >  __rhashtable_lookup include/linux/rhashtable.h:623 [inline]
> >  rhashtable_lookup include/linux/rhashtable.h:668 [inline]
> >  xfrm_policy_inexact_lookup_rcu+0x60/0x750 net/xfrm/xfrm_policy.c:2068
> >  xfrm_policy_lookup_bytype+0xb35/0x1840 net/xfrm/xfrm_policy.c:2193
> ...
>
> FYI, I also observed the WARN at look_up_lock_class() and match_held_lock=
()
> called in the rhashtable_lookup() context [1]. I used the kernel next-202=
60909.
> The WARN was observed during the run of blktests test case block/008 on d=
m-
> flakey device, but this test workload does not look related to the WARN. =
I tried
> to reproduce the WARN by repeating the test workload hundreds of times, a=
nd
> succeeded only once. The WARN looks rare, but I'm sure the WARN happned.
>
> The call trace that syzbot reported and that I observed look rather diffe=
rent.
> The common part across them is the rhashtable_lookup() call. So I think i=
t is
> the better to involve rhashtable experts. I took the liberty CC to them.
>
>
> [1] WARN observed at blktests block/008 for dm-flakey
>
> WARNING: kernel/locking/lockdep.c:955 at look_up_lock_class+0xa8/0x170, C=
PU#14: kworker/14:1/309662
> Modules linked in: dm_flakey iscsi_target_mod tcm_loop target_core_pscsi =
target_core_file target_core_iblock xfs target_core_user target_core_mod nf=
t_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4=
 nf_reject_ipv6 nft_reject qrtr nft_ct nft_chain_nat ip6table_nat ip6table_=
mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_de=
frag_ipv6 nf_defrag_ipv4 iptable_mangle rfkill iptable_raw iptable_security=
 nf_tables ip6table_filter ip6_tables iptable_filter ip_tables irdma ice su=
nrpc libie_fwlog gnss idpf libeth_xdp libie_pci libie_cp libeth ib_core int=
el_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency=
_common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_=
powerclamp coretemp kvm_intel spi_nor mtd kvm i40e irqbypass iTCO_wdt rapl =
intel_pmc_bxt vfat ses intel_cstate libie fat intel_uncore libie_adminq enc=
losure i2c_i801 spi_intel_pci spi_intel i2c_smbus lpc_ich mei_me mei intel_=
pch_thermal wmi joydev ioatdma acpi_pad
>  acpi_power_meter dca fuse dm_multipath zram lz4hc_compress zstd_compress=
 ast drm_client_lib i2c_algo_bit drm_shmem_helper drm_kms_helper nvme drm n=
vme_core mpi3mr nvme_keyring nvme_auth scsi_transport_sas scsi_dh_alua pkcs=
8_key_parser scsi_dh_emc scsi_dh_rdac i2c_dev [last unloaded: null_blk]
> CPU: 14 UID: 0 PID: 309662 Comm: kworker/14:1 Tainted: G        W        =
   7.3.0-rc2-next-20260909-kts+ #1 PREEMPT(lazy)
> Tainted: [W]=3DWARN
> Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.5 05/18/2021
> Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
> RIP: 0010:look_up_lock_class+0xa8/0x170
> Code: 39 6b 40 75 ed 48 8b 8b b8 00 00 00 49 8b 74 24 18 48 39 f1 74 34 4=
9 8b 14 24 48 81 fa f0 31 7f 9a 74 27 48 8d 3d b8 66 4a 02 <67> 48 0f b9 3a=
 48 89 d8 48 8b 6c 24 10 4c 8b 64 24 18 48 8b 5c 24
> RSP: 0018:ffff888e40108088 EFLAGS: 00010002
> RAX: 0000000000000001 RBX: ffffffff9e852a78 RCX: ffffffff97838ae0
> RDX: ffffffffc271a2a0 RSI: ffffffff97838a60 RDI: ffffffff997aa470
> RBP: ffffffffc271a2a0 R08: 0000000000000001 R09: ffff888133ab3018
> R10: 0000000000000004 R11: ffff888e40108360 R12: ffff88812d59e1f8
> R13: 0000000000000003 R14: 0000000000000246 R15: 00000000ffffffff
> FS:  0000000000000000(0000) GS:ffff888ea59d3000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055dba25b8c90 CR3: 00000002a6911004 CR4: 00000000007726f0
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  match_held_lock+0xdb/0x130
>  lock_is_held_type+0xb0/0x180
>  nft_rhash_lookup+0x541/0x7e0 [nf_tables]
>  ? find_held_lock+0x2b/0x80
>  ? __lock_release.isra.0+0x69/0x1a0
>  ? lock_release.part.0+0x1c/0x50
>  ? __pfx_nft_rhash_lookup+0x10/0x10 [nf_tables]
>  nft_set_do_lookup+0x1ac/0x2a0 [nf_tables]
>  ? fib_lookup_good_nhc+0x104/0x380
>  nft_lookup_eval+0xcc/0x590 [nf_tables]
>  ? lock_is_held_type+0xb0/0x180
>  nft_do_chain+0x2a9/0x1680 [nf_tables]
>  ? __lock_acquire+0x690/0xd00
>  ? __pfx_nft_do_chain+0x10/0x10 [nf_tables]
>  ? lock_acquire.part.0+0xc8/0x240
>  ? find_held_lock+0x2b/0x80
>  ? __local_bh_enable_ip+0xb4/0x150
>  ? ipt_do_table+0xa10/0x11e0 [ip_tables]
>  ? ipt_do_table+0xa15/0x11e0 [ip_tables]
>  nft_do_chain_inet+0xdc/0x4a0 [nf_tables]
>  ? __pfx_nft_do_chain_inet+0x10/0x10 [nf_tables]
>  ? __pfx_ipt_do_table+0x10/0x10 [ip_tables]
>  nf_hook_slow+0xbe/0x210
>  ? lock_is_held_type+0xb0/0x180
>  ip_local_deliver+0x2d0/0x4a0
>  ? __pfx_ip_local_deliver+0x10/0x10
>  ? __pfx_ip_local_deliver_finish+0x10/0x10
>  ? ip_rcv_finish_core+0x75b/0x1470
>  ? lock_is_held_type+0xb0/0x180
>  ip_list_rcv_finish+0x7f8/0xbb0
>  ? ip_sublist_rcv+0x106/0x2f0
>  ? __pfx_ip_list_rcv_finish+0x10/0x10
>  ? __lock_release.isra.0+0x69/0x1a0
>  ip_sublist_rcv+0x8b/0x2f0
>  ? __pfx_ip_sublist_rcv+0x10/0x10
>  ? __pfx_ip_rcv_finish+0x10/0x10
>  ? ip_rcv_core+0x619/0xd00
>  ? kasan_save_stack+0x2f/0x50
>  ip_list_rcv+0x2dd/0x440
>  ? asm_common_interrupt+0x26/0x40
>  ? __pfx_ip_list_rcv+0x10/0x10
>  ? drm_atomic_helper_commit_planes+0x3bd/0x1040 [drm_kms_helper]
>  ? commit_tail+0x204/0x4b0 [drm_kms_helper]
>  ? __lock_acquire+0x691/0xd00
>  __netif_receive_skb_list_core+0x6bf/0xa10
>  ? __pfx___netif_receive_skb_list_core+0x10/0x10
>  ? lock_acquire.part.0+0xc8/0x240
>  ? netif_receive_skb_list_internal+0x382/0xc90
>  ? lock_acquire+0x11a/0x140
>  netif_receive_skb_list_internal+0x603/0xc90
>  ? dev_gro_receive+0x1e0/0x15f0
>  ? __pfx_netif_receive_skb_list_internal+0x10/0x10
>  ? napi_build_skb+0x55/0x1e0
>  ? i40e_process_skb_fields+0x4a6/0xea0 [i40e]
>  ? i40e_clean_rx_irq+0x96f/0x2140 [i40e]
>  napi_complete_done+0x1a4/0x900
>  ? __pfx_napi_complete_done+0x10/0x10
>  i40e_napi_poll+0x408/0xb70 [i40e]
>  ? __pfx_i40e_napi_poll+0x10/0x10 [i40e]
>  __napi_poll+0x351/0x520
>  net_rx_action+0x446/0xc30
>  ? __pfx_net_rx_action+0x10/0x10
>  ? do_raw_spin_unlock+0x59/0x230
>  ? lock_release.part.0+0x1c/0x50
>  ? sched_clock_cpu+0x69/0x630
>  ? mark_held_locks+0x40/0x70
>  handle_softirqs+0x1de/0x830
>  ? __pfx_handle_softirqs+0x10/0x10
>  ? irqtime_account_irq+0x3e/0x2d0
>  __irq_exit_rcu+0x164/0x290
>  irq_exit_rcu+0xe/0x20
>  common_interrupt+0x85/0xa0
>  </IRQ>
>  <TASK>
>  asm_common_interrupt+0x26/0x40
> RIP: 0010:memcpy_toio+0xa3/0x120
> Code: 5c e9 d1 59 9f 01 48 85 db 74 ee 40 f6 c5 01 75 49 48 83 fb 01 76 0=
6 40 f6 c5 02 75 29 48 89 d9 48 89 ef 4c 89 e6 48 c1 e9 02 <f3> a5 f6 c3 02=
 74 02 66 a5 f6 c3 01 74 01 a4 48 83 c4 18 5b 5d 41
> RSP: 0018:ffff88811b3a7538 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000001000 RCX: 00000000000003f0

Try to revert 4333ab90aaae ("rhashtable: use private lockdep class for
all locks.")

Thanks.
