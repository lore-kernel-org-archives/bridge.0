Message-Id: <200501290555.j0T5txuM029951@smtp.osdl.org>
From: <dan-linuxbridge@unpossible.com>
Sender: "Dan Grigsby" <dan@unpossible.com>
Subject: RE: [Bridge] Benchmarking bridging vs. routing on same
	hardware/network
Date: Fri, 28 Jan 2005 23:55:59 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050128152333.5e718a26@dxpl.pdx.osdl.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Stephen Hemminger' <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

> Please try this patch, it does:

Applied the patch, compiled, booted and ran the benchmark.  

results:  ~4% more packets came through

oprofile result of the overloaded bridge clipped to fit follow at the end.

I decided to try another comparison:  I setup and proxy-arp pseudo-bridge
(http://lartc.org/howto/lartc.bridging.proxy-arp.html). The benchmark was
only few percentage points faster than the full-blown bridge.  Any utility
to this as a data-point?  It would seem to me that if, what I assume to be,
a simpler proxy-arp has the same performance than it is something external
to both.  

--oprofile--
5212	9.4976	vmlinux	kfree
3572	6.5091	vmlinux	nf_hook_slow
3234	5.8932	vmlinux	eth_type_trans
2820	5.1388	vmlinux	nf_iterate
2288	4.1693	vmlinux	alloc_skb
2239	4.08		vmlinux	_spin_lock
2230	4.0636	vmlinux	__kfree_skb
2086	3.8012	e1000		e1000_xmit_frame
1992	3.6299	bridge	br_fdb_update
1749	3.1871	vmlinux	pfifo_fast_enqueue
1700	3.0978	e1000		e1000_alloc_rx_buffers
1662	3.0286	bridge	__br_fdb_get
1552	2.8281	bridge	br_handle_frame
1342	2.4455	vmlinux	kmem_cache_alloc
1337	2.4364	vmlinux	mark_offset_pmtmr
1126	2.0519	bridge	br_nf_pre_routing
875	1.5945	vmlinux	netif_receive_skb
874	1.5927	vmlinux	timer_interrupt
788	1.4359	vmlinux	cache_alloc_refill
761	1.3867	bridge	ip_sabotage_out
708	1.2902	vmlinux	__kmalloc
700	1.2756	vmlinux	qdisc_restart
696	1.2683	bridge	br_nf_post_routing
662	1.2063	e1000		e1000_clean_tx_irq
636	1.159		e1000		e1000_clean_rx_irq
621	1.1316	vmlinux	pfifo_fast_dequeue
615	1.1207	bridge	br_nf_forward_ip
576	1.0496	vmlinux	cache_flusharray
510	0.9294	bridge	br_nf_forward_finish
509	0.9275	bridge	br_nf_pre_routing_finish
447	0.8145	vmlinux	kmem_cache_free
421	0.7672	vmlinux	default_idle
402	0.7325	vmlinux	memcpy
393	0.7161	vmlinux	_spin_unlock_irqrestore
391	0.7125	e1000		e1000_intr
368	0.6706	bridge	br_handle_frame_finish
330	0.6013	vmlinux	__do_softirq
295	0.5376	vmlinux	dev_queue_xmit
270	0.492		bridge	br_dev_queue_push_xmit
267	0.4865	vmlinux	net_rx_action
263	0.4793	e1000		e1000_rx_checksum
252	0.4592	bash		(no symbols)
240	0.4373	bridge	br_forward_finish
239	0.4355	bridge	setup_pre_routing
229	0.4173	oprofiled	(no symbols)
226	0.4118	vmlinux	irq_entries_start
207	0.3772	bridge	__br_forward
196	0.3572	bridge	ip_sabotage_in
182	0.3317	vmlinux	profile_hook
171	0.3116	vmlinux	_spin_unlock
159	0.2897	vmlinux	dev_queue_xmit_nit
129	0.2351	vmlinux	do_wp_page
112	0.2041	libc-2.3.4.so	__gconv_transform_utf8_internal
99	0.1804	vmlinux	skb_release_data
98	0.1786	vmlinux	apic_timer_interrupt
95	0.1731	vmlinux	delay_pmtmr
80	0.1458	libc-2.3.4.so	mbrtowc
75	0.1367	vmlinux	local_bh_enable
72	0.1312	vmlinux	kmap_atomic
65	0.1184	vmlinux	handle_IRQ_event
64	0.1166	e1000		e1000_clean
63	0.1148	vmlinux	kfree_skbmem
56	0.102		libc-2.3.4.so	_int_malloc
56	0.102		vmlinux	copy_page_range
55	0.1002	vmlinux	do_IRQ
55	0.1002	vmlinux	zap_pte_range
51	0.0929	ld-2.3.4.so	do_lookup_x
51	0.0929	vmlinux	do_no_page
49	0.0893	bridge	br_forward

