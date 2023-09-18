Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B29E60EF6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8F1F60A9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695029393; x=1695634193;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rCF0Horr2h7qpSaWZlXlmtXAqYL8heykh2jju7r+Kn8=;
 b=bR7NzoD3KYv2/jmiz6HoFr15t8QVahzPS4eP1Zc5lDAE6zuuzbxt5szA1r0RWixFcy
 FI/N5yRAID/D1SErHcG326XnjoyuBSCTFm1NFBLVh1xm0crrQcDZe6DgBU9D1Y8un2KI
 smnxlvoKVAO3gMEkGDOoz2rJ80ZYXBLd1TMErjLXC6wFTQCVyIcKiz/qScRdWJjeRjqs
 /IcVCMOeQfyNl56v8eOyUS1hIV9u+H58mMLsXFGmgxUr2fcpz1MzSSx5dJwUOMxmvRAa
 wLYwM+9M6MZimiHZI9tbBnFyM+aJDMW9A4/97nHai7i90S5nkRIaefwFZmmLDaavjYEE
 Hgaw==
Message-ID: <cf8b9040-46dd-21af-b92f-78af1f1536c7@blackwall.org>
Date: Mon, 18 Sep 2023 12:29:52 +0300
MIME-Version: 1.0
References: <20230918091351.1356153-1-edumazet@google.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230918091351.1356153-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: use DEV_STATS_INC()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, syzbot <syzkaller@googlegroups.com>, eric.dumazet@gmail.com, Roopa Prabhu <roopa@nvidia.com>

On 9/18/23 12:13, Eric Dumazet wrote:
> syzbot/KCSAN reported data-races in br_handle_frame_finish() [1]
> This function can run from multiple cpus without mutual exclusion.
> 
> Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.
> 
> Handles updates to dev->stats.tx_dropped while we are at it.
> 
> [1]
> BUG: KCSAN: data-race in br_handle_frame_finish / br_handle_frame_finish
> 
> read-write to 0xffff8881374b2178 of 8 bytes by interrupt on cpu 1:
> br_handle_frame_finish+0xd4f/0xef0 net/bridge/br_input.c:189
> br_nf_hook_thresh+0x1ed/0x220
> br_nf_pre_routing_finish_ipv6+0x50f/0x540
> NF_HOOK include/linux/netfilter.h:304 [inline]
> br_nf_pre_routing_ipv6+0x1e3/0x2a0 net/bridge/br_netfilter_ipv6.c:178
> br_nf_pre_routing+0x526/0xba0 net/bridge/br_netfilter_hooks.c:508
> nf_hook_entry_hookfn include/linux/netfilter.h:144 [inline]
> nf_hook_bridge_pre net/bridge/br_input.c:272 [inline]
> br_handle_frame+0x4c9/0x940 net/bridge/br_input.c:417
> __netif_receive_skb_core+0xa8a/0x21e0 net/core/dev.c:5417
> __netif_receive_skb_one_core net/core/dev.c:5521 [inline]
> __netif_receive_skb+0x57/0x1b0 net/core/dev.c:5637
> process_backlog+0x21f/0x380 net/core/dev.c:5965
> __napi_poll+0x60/0x3b0 net/core/dev.c:6527
> napi_poll net/core/dev.c:6594 [inline]
> net_rx_action+0x32b/0x750 net/core/dev.c:6727
> __do_softirq+0xc1/0x265 kernel/softirq.c:553
> run_ksoftirqd+0x17/0x20 kernel/softirq.c:921
> smpboot_thread_fn+0x30a/0x4a0 kernel/smpboot.c:164
> kthread+0x1d7/0x210 kernel/kthread.c:388
> ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> 
> read-write to 0xffff8881374b2178 of 8 bytes by interrupt on cpu 0:
> br_handle_frame_finish+0xd4f/0xef0 net/bridge/br_input.c:189
> br_nf_hook_thresh+0x1ed/0x220
> br_nf_pre_routing_finish_ipv6+0x50f/0x540
> NF_HOOK include/linux/netfilter.h:304 [inline]
> br_nf_pre_routing_ipv6+0x1e3/0x2a0 net/bridge/br_netfilter_ipv6.c:178
> br_nf_pre_routing+0x526/0xba0 net/bridge/br_netfilter_hooks.c:508
> nf_hook_entry_hookfn include/linux/netfilter.h:144 [inline]
> nf_hook_bridge_pre net/bridge/br_input.c:272 [inline]
> br_handle_frame+0x4c9/0x940 net/bridge/br_input.c:417
> __netif_receive_skb_core+0xa8a/0x21e0 net/core/dev.c:5417
> __netif_receive_skb_one_core net/core/dev.c:5521 [inline]
> __netif_receive_skb+0x57/0x1b0 net/core/dev.c:5637
> process_backlog+0x21f/0x380 net/core/dev.c:5965
> __napi_poll+0x60/0x3b0 net/core/dev.c:6527
> napi_poll net/core/dev.c:6594 [inline]
> net_rx_action+0x32b/0x750 net/core/dev.c:6727
> __do_softirq+0xc1/0x265 kernel/softirq.c:553
> do_softirq+0x5e/0x90 kernel/softirq.c:454
> __local_bh_enable_ip+0x64/0x70 kernel/softirq.c:381
> __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
> _raw_spin_unlock_bh+0x36/0x40 kernel/locking/spinlock.c:210
> spin_unlock_bh include/linux/spinlock.h:396 [inline]
> batadv_tt_local_purge+0x1a8/0x1f0 net/batman-adv/translation-table.c:1356
> batadv_tt_purge+0x2b/0x630 net/batman-adv/translation-table.c:3560
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
> worker_thread+0x525/0x730 kernel/workqueue.c:2784
> kthread+0x1d7/0x210 kernel/kthread.c:388
> ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> 
> value changed: 0x00000000000d7190 -> 0x00000000000d7191
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 14848 Comm: kworker/u4:11 Not tainted 6.6.0-rc1-syzkaller-00236-gad8a69f361b9 #0
> 
> Fixes: 1c29fc4989bc ("[BRIDGE]: keep track of received multicast packets")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: bridge@lists.linux-foundation.org
> ---
>   net/bridge/br_forward.c | 4 ++--
>   net/bridge/br_input.c   | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


