Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=date:in-reply-to:references:mime-version:content-transfer-encoding
	:subject:to:cc:from:message-id;
	bh=HERAyb2nBKp/WDqxby03QYSAsCRvMKQF94fo9I4Jhww=;
	b=Lg2HLxJq7vfZbJ8AdYoSv/sk3q80EG1c38JPuTQVXGm9Yc2LXuSvIPqcvXMY4lWiYM
	dAAEtNCfIj1OGK9g7mGugPKdwar0pFC+SyVqWjRdBxh+K2/xM+OVfVyg83h+rVyKih/a
	DX4JGQBFGD4LnZ3kdNWB3Ovbecl1sSPF0JjnM=
Date: Sat, 29 Jun 2019 16:11:13 +0300
In-Reply-To: <41ac3aa3-cbf7-1b7b-d847-1fb308334931@linuxlounge.net>
References: <41ac3aa3-cbf7-1b7b-d847-1fb308334931@linuxlounge.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: nikolay@cumulusnetworks.com
Message-ID: <E0170D52-C181-4F0F-B5F8-F1801C2A8F5A@cumulusnetworks.com>
Subject: Re: [Bridge] Use-after-free in br_multicast_rcv
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Martin Weinelt <martin@linuxlounge.net>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org
Cc: netdev@vger.kernel.or

On 29 June 2019 14:54:44 EEST, Martin Weinelt <martin@linuxlounge=2Enet> wr=
ote:
>Hello,
>
>we've recently been experiencing memory leaks on our Linux-based
>routers,
>at least as far back as v4=2E19=2E16=2E
>
>After rebuilding with KASAN it found a use-after-free in=20
>br_multicast_rcv which I could reproduce on v5=2E2=2E0-rc6=2E=20
>
>Please find the KASAN report below, I'm anot sure what else to provide
>so
>feel free to ask=2E
>
>Best,
>  Martin
>
>

Hi Martin,=20
I'll look into this, are there any specific steps to reproduce it?=20

Thanks,=20
   Nik

>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>BUG: KASAN: use-after-free in br_multicast_rcv+0x480c/0x4ad0 [bridge]
>Read of size 2 at addr ffff8880421302b4 by task ksoftirqd/1/16
>
>CPU: 1 PID: 16 Comm: ksoftirqd/1 Tainted: G           OE     5=2E2=2E0-rc=
6+
>#1
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1=2E10=2E2-1
>04/01/2014
>Call Trace:
> dump_stack+0x71/0xab
> print_address_description+0x6a/0x280
> ? br_multicast_rcv+0x480c/0x4ad0 [bridge]
> __kasan_report+0x152/0x1aa
> ? br_multicast_rcv+0x480c/0x4ad0 [bridge]
> ? br_multicast_rcv+0x480c/0x4ad0 [bridge]
> kasan_report+0xe/0x20
> br_multicast_rcv+0x480c/0x4ad0 [bridge]
> ? br_multicast_disable_port+0x150/0x150 [bridge]
> ? ktime_get_with_offset+0xb4/0x150
> ? __kasan_kmalloc=2Econstprop=2E6+0xa6/0xf0
> ? __netif_receive_skb+0x1b0/0x1b0
> ? br_fdb_update+0x10e/0x6e0 [bridge]
> ? br_handle_frame_finish+0x3c6/0x11d0 [bridge]
> br_handle_frame_finish+0x3c6/0x11d0 [bridge]
> ? br_pass_frame_up+0x3a0/0x3a0 [bridge]
> ? virtnet_probe+0x1c80/0x1c80 [virtio_net]
> br_handle_frame+0x731/0xd90 [bridge]
> ? select_idle_sibling+0x25/0x7d0
> ? br_handle_frame_finish+0x11d0/0x11d0 [bridge]
> __netif_receive_skb_core+0xced/0x2d70
> ? virtqueue_get_buf_ctx+0x230/0x1130 [virtio_ring]
> ? do_xdp_generic+0x20/0x20
> ? virtqueue_napi_complete+0x39/0x70 [virtio_net]
> ? virtnet_poll+0x94d/0xc78 [virtio_net]
> ? receive_buf+0x5120/0x5120 [virtio_net]
> ? __netif_receive_skb_one_core+0x97/0x1d0
> __netif_receive_skb_one_core+0x97/0x1d0
> ? __netif_receive_skb_core+0x2d70/0x2d70
> ? _raw_write_trylock+0x100/0x100
> ? __queue_work+0x41e/0xbe0
> process_backlog+0x19c/0x650
> ? _raw_read_lock_irq+0x40/0x40
> net_rx_action+0x71e/0xbc0
> ? __switch_to_asm+0x40/0x70
> ? napi_complete_done+0x360/0x360
> ? __switch_to_asm+0x34/0x70
> ? __switch_to_asm+0x40/0x70
> ? __schedule+0x85e/0x14d0
> __do_softirq+0x1db/0x5f9
> ? takeover_tasklets+0x5f0/0x5f0
> run_ksoftirqd+0x26/0x40
> smpboot_thread_fn+0x443/0x680
> ? sort_range+0x20/0x20
> ? schedule+0x94/0x210
> ? __kthread_parkme+0x78/0xf0
> ? sort_range+0x20/0x20
> kthread+0x2ae/0x3a0
> ? kthread_create_worker_on_cpu+0xc0/0xc0
> ret_from_fork+0x35/0x40
>
>The buggy address belongs to the page:
>page:ffffea0001084c00 refcount:0 mapcount:-128 mapping:0000000000000000
>index:0x0
>flags: 0xffffc000000000()
>raw: 00ffffc000000000 ffffea0000cfca08 ffffea0001098608
>0000000000000000
>raw: 0000000000000000 0000000000000003 00000000ffffff7f
>0000000000000000
>page dumped because: kasan: bad access detected
>
>Memory state around the buggy address:
> ffff888042130180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff888042130200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>ffff888042130280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                                     ^
> ffff888042130300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff888042130380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>Disabling lock debugging due to kernel taint


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
