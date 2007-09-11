Date: Tue, 11 Sep 2007 11:00:42 +0200
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Badness in local_bh_enable at kernel/softirq.c:144
Message-ID: <20070911110042.38c2055e@oldman>
In-Reply-To: <46E4F9F3.02AC7F.13980@m12-11.163.com>
References: <46E4F9F3.02AC7F.13980@m12-11.163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: kylix <kylix13@163.com>
Cc: bridge <bridge@linux-foundation.org>

> Dear all:
> 
>     I builded a bridge on my embedded system, the linux kernel
> version 2.6.12; the brctl version 1.0.6.
>     I connect PC0 to eth0, connect PC1 to eth1, then I ping PC1 from
> PC0, It is successful.
> 	But I got the errors blow from linux console when It
> forwarding every ethernet package. Can anyone help me ? 
> 
> *********************************************************************************
> Badness in local_bh_enable at kernel/softirq.c:144
> Call Trace:
>  [<80a2009c>] AppDmacEmacSendData+0xdc/0x100
>  [<80a20088>] AppDmacEmacSendData+0xc8/0x100
>  [<8092d0d8>] local_bh_enable+0x44/0x90
>  [<80a95b0c>] destroy_conntrack+0x58/0x218
>  [<80a342dc>] __kfree_skb+0x1cc/0x284
>  [<80a1bc00>] au1000_tx+0x278/0x4c8
>  [<80a1bc00>] au1000_tx+0x278/0x4c8
>  [<80a1be24>] au1000_tx+0x49c/0x4c8
>  [<80aad7c0>] br_dev_queue_push_xmit+0x0/0x1a0
>  [<80aad7c0>] br_dev_queue_push_xmit+0x0/0x1a0
>  [<80a4aa78>] nf_iterate+0x94/0x108
>  [<80a4cb08>] qdisc_restart+0x170/0x304
>  [<80aad7c0>] br_dev_queue_push_xmit+0x0/0x1a0
>  [<80aad7c0>] br_dev_queue_push_xmit+0x0/0x1a0
>  [<80a3bf94>] dev_queue_xmit+0x104/0x2c8
>  [<80901a90>] mips_timer_interrupt+0xa0/0x10c
>  [<80aad94c>] br_dev_queue_push_xmit+0x18c/0x1a0
>  [<80aad7c0>] br_dev_queue_push_xmit+0x0/0x1a0
>  [<80ab47cc>] br_nf_post_routing+0x178/0x198
>  [<80a1f404>] AppDmacEmacClearTxResult+0x48/0x64
>  [<80a1f3d4>] AppDmacEmacClearTxResult+0x18/0x64
>  [<80aad7c0>] br_dev_queue_push_xmit+0x0/0x1a0
>  [<80a4aa78>] nf_iterate+0x94/0x108
>  [<80a9a3b8>] ipt_do_table+0x3d0/0x420
>  [<80ab3ea0>] br_nf_forward_finish+0x0/0x138
>  [<80aad7c0>] br_dev_queue_push_xmit+0x0/0x1a0
>  [<80aad7c0>] br_dev_queue_push_xmit+0x0/0x1a0
>  [<80a4b3ac>] nf_hook_slow+0x9c/0x1d8
>  [<80ab3ea0>] br_nf_forward_finish+0x0/0x138
>  [<80aad7c0>] br_dev_queue_push_xmit+0x0/0x1a0
>  [<8094889c>] handle_IRQ_event+0x64/0xd8
>  [<80aad960>] br_forward_finish+0x0/0x70
>  [<80aad9ac>] br_forward_finish+0x4c/0x70
>  [<80aad960>] br_forward_finish+0x0/0x70
>  [<80aad7c0>] br_dev_queue_push_xmit+0x0/0x1a0
>  [<80ab3fc4>] br_nf_forward_finish+0x124/0x138
>  [<80ab3fb4>] br_nf_forward_finish+0x114/0x138
>  [<80aad960>] br_forward_finish+0x0/0x70
>  [<80ab4130>] br_nf_forward_ip+0x158/0x16c
>  [<80ab3ea0>] br_nf_forward_finish+0x0/0x138
>  [<80b20000>] ip_auto_config_setup+0xe4/0x234
>  [<809d9d88>] memset_partial+0x4c/0x6c
>  [<80a4aa78>] nf_iterate+0x94/0x108
>  [<809046bc>] ret_from_irq+0x0/0x10
>  [<80aa1530>] ip_nat_setup_info+0x688/0x7a4
>  [<80aa138c>] ip_nat_setup_info+0x4e4/0x7a4
>  [<80aad960>] br_forward_finish+0x0/0x70
>  [<80aad960>] br_forward_finish+0x0/0x70
>  [<80a4b3ac>] nf_hook_slow+0x9c/0x1d8
>  [<80aad960>] br_forward_finish+0x0/0x70
>  [<80aadaa8>] __br_forward+0x60/0x80
>  [<80aaed70>] br_handle_frame_finish+0xa4/0x1c8
>  [<80aad960>] br_forward_finish+0x0/0x70
>  [<80aaee5c>] br_handle_frame_finish+0x190/0x1c8
>  [<80aaed7c>] br_handle_frame_finish+0xb0/0x1c8
>  [<80ab34b4>] br_nf_pre_routing_finish+0x508/0x528
>  [<80ab34a4>] br_nf_pre_routing_finish+0x4f8/0x528
>  [<80aaeccc>] br_handle_frame_finish+0x0/0x1c8
>  [<80ab2fac>] br_nf_pre_routing_finish+0x0/0x528
>  [<80ab2fac>] br_nf_pre_routing_finish+0x0/0x528
>  [<80ab2fac>] br_nf_pre_routing_finish+0x0/0x528
>  [<80a4aa78>] nf_iterate+0x94/0x108
>  [<80a4aa78>] nf_iterate+0x94/0x108
>  [<80a33ea8>] alloc_skb+0x58/0xf0
>  [<80ab2fac>] br_nf_pre_routing_finish+0x0/0x528
>  [<80ab2fac>] br_nf_pre_routing_finish+0x0/0x528
>  [<80a4b3ac>] nf_hook_slow+0x9c/0x1d8
>  [<80ab42d8>] br_nf_forward_arp+0x194/0x1ac
>  [<80ab2fac>] br_nf_pre_routing_finish+0x0/0x528
>  [<80aaeccc>] br_handle_frame_finish+0x0/0x1c8
>  [<80aaeccc>] br_handle_frame_finish+0x0/0x1c8
>  [<80ab3d78>] br_nf_pre_routing+0x858/0x888
>  [<80ab3d64>] br_nf_pre_routing+0x844/0x888
>  [<80ab2fac>] br_nf_pre_routing_finish+0x0/0x528
>  [<80aad960>] br_forward_finish+0x0/0x70
>  [<80aaeccc>] br_handle_frame_finish+0x0/0x1c8
>  [<80a4aa78>] nf_iterate+0x94/0x108
>  [<80aad960>] br_forward_finish+0x0/0x70
>  [<80aaeccc>] br_handle_frame_finish+0x0/0x1c8
>  [<80aaeccc>] br_handle_frame_finish+0x0/0x1c8
>  [<80a4b3ac>] nf_hook_slow+0x9c/0x1d8
>  [<80aadaa8>] __br_forward+0x60/0x80
>  [<80aaeccc>] br_handle_frame_finish+0x0/0x1c8
>  [<80b20000>] ip_auto_config_setup+0xe4/0x234
>  [<80aaf060>] br_handle_frame+0x1cc/0x2bc
>  [<80a1f1ec>] HwDmacRdQ+0x5c/0xe8
>  [<80aaeccc>] br_handle_frame_finish+0x0/0x1c8
>  [<80a33ea8>] alloc_skb+0x58/0xf0
>  [<80a3ca64>] netif_receive_skb+0x268/0x46c
>  [<80a1c214>] au1000_interrupt+0x3c4/0x468
>  [<80a3cd44>] process_backlog+0xdc/0x2c4
>  [<80a3cef4>] process_backlog+0x28c/0x2c4
>  [<80a3cfdc>] net_rx_action+0xb0/0x200
>  [<8092cf7c>] __do_softirq+0x6c/0xf8
>  [<8092d060>] do_softirq+0x58/0x8c
>  [<80905c60>] do_IRQ+0x24/0x34
>  [<809046bc>] ret_from_irq+0x0/0x10
>  [<809046bc>] ret_from_irq+0x0/0x10
>  [<80904284>] r4k_wait+0x0/0x8
>  [<80b208c0>] ip_nat_rule_init+0x54/0x94
>  [<80b20000>] ip_auto_config_setup+0xe4/0x234
>  [<809d490c>] idr_cache_ctor+0x0/0xc
>  [<80b070b0>] unknown_bootoption+0x0/0x2c4

What is the ethernet driver? It looks like a possible driver bug.
Where is the driver source, I don' see AppDmacEmacSendData in
mainline kernel source.
