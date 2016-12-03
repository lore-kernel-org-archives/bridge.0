Return-Path: <mirq@rere.qmqm.pl>
Message-Id: <cfa1f2efae2217b50cbefccbf9ba7f0d24a23c63.1480755768.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Date: Sat,  3 Dec 2016 10:22:28 +0100 (CET)
Subject: [Bridge] [PATCH net-next] net: remove abuse of VLAN DEI/CFI bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "open list:OPENVSWITCH" <dev@openvswitch.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>

This All-in-one patch removes abuse of VLAN CFI bit, so it can be passed
intact through linux networking stack.

Signed-off-by: Michał Mirosław <michal.miroslaw@atendesoftware.pl>
---

Dear NetDevs

I guess this needs to be split to the prep..convert[]..finish sequence,
but if you like it as is, then it's ready.

The biggest question is if the modified interface and vlan_present
is the way to go. This can be changed to use vlan_proto != 0 instead
of an extra flag bit.

As I can't test most of the driver changes, please look at them carefully.
OVS and bridge eyes are especially welcome.

Best Regards,
Michał Mirosław
---
 Documentation/networking/openvswitch.txt         | 14 ------
 arch/arm/net/bpf_jit_32.c                        | 14 +++---
 arch/mips/net/bpf_jit.c                          | 17 +++----
 arch/powerpc/net/bpf_jit_comp.c                  | 14 +++---
 arch/sparc/net/bpf_jit_comp.c                    | 14 +++---
 drivers/infiniband/hw/cxgb4/cm.c                 |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c           |  8 ++--
 drivers/net/ethernet/broadcom/cnic.c             |  2 +-
 drivers/net/ethernet/emulex/benet/be_main.c      |  4 +-
 drivers/net/ethernet/freescale/gianfar_ethtool.c |  7 +--
 drivers/net/ethernet/ibm/ibmvnic.c               |  5 +-
 drivers/net/ethernet/marvell/sky2.c              |  4 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c   |  9 ++--
 drivers/net/hyperv/hyperv_net.h                  |  2 +-
 drivers/net/hyperv/netvsc_drv.c                  | 14 +++---
 drivers/net/hyperv/rndis_filter.c                |  5 +-
 include/linux/if_vlan.h                          | 23 ++++++---
 include/linux/skbuff.h                           | 10 +++-
 lib/test_bpf.c                                   | 14 +++---
 net/8021q/vlan_core.c                            |  2 +-
 net/bridge/br_netfilter_hooks.c                  | 14 +++---
 net/bridge/br_private.h                          |  2 +-
 net/bridge/br_vlan.c                             |  6 +--
 net/core/dev.c                                   |  8 ++--
 net/core/filter.c                                | 17 +++----
 net/core/skbuff.c                                |  2 +-
 net/ipv4/ip_tunnel_core.c                        |  2 +-
 net/netfilter/nfnetlink_queue.c                  |  5 +-
 net/openvswitch/actions.c                        | 13 ++---
 net/openvswitch/flow.c                           |  2 +-
 net/openvswitch/flow.h                           |  4 +-
 net/openvswitch/flow_netlink.c                   | 61 ++++++++----------------
 net/sched/act_vlan.c                             |  2 +-
 33 files changed, 152 insertions(+), 170 deletions(-)

diff --git a/Documentation/networking/openvswitch.txt b/Documentation/networking/openvswitch.txt
index b3b9ac6..e7ca27d 100644
--- a/Documentation/networking/openvswitch.txt
+++ b/Documentation/networking/openvswitch.txt
@@ -219,20 +219,6 @@ this:
 
     eth(...), eth_type(0x0800), ip(proto=6, ...), tcp(src=0, dst=0)
 
-As another example, consider a packet with an Ethernet type of 0x8100,
-indicating that a VLAN TCI should follow, but which is truncated just
-after the Ethernet type.  The flow key for this packet would include
-an all-zero-bits vlan and an empty encap attribute, like this:
-
-    eth(...), eth_type(0x8100), vlan(0), encap()
-
-Unlike a TCP packet with source and destination ports 0, an
-all-zero-bits VLAN TCI is not that rare, so the CFI bit (aka
-VLAN_TAG_PRESENT inside the kernel) is ordinarily set in a vlan
-attribute expressly to allow this situation to be distinguished.
-Thus, the flow key in this second example unambiguously indicates a
-missing or malformed VLAN TCI.
-
 Other rules
 -----------
 
diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 93d0b6d..aff9dfa 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -915,17 +915,17 @@ static int build_body(struct jit_ctx *ctx)
 			emit(ARM_LDR_I(r_A, r_skb, off), ctx);
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG:
-		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			ctx->seen |= SEEN_SKB;
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
 			off = offsetof(struct sk_buff, vlan_tci);
 			emit(ARM_LDRH_I(r_A, r_skb, off), ctx);
-			if (code == (BPF_ANC | SKF_AD_VLAN_TAG))
-				OP_IMM3(ARM_AND, r_A, r_A, ~VLAN_TAG_PRESENT, ctx);
-			else {
-				OP_IMM3(ARM_LSR, r_A, r_A, 12, ctx);
-				OP_IMM3(ARM_AND, r_A, r_A, 0x1, ctx);
-			}
+			break;
+		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+			off = PKT_VLAN_PRESENT_OFFSET();
+			emit(ARM_LDRB_I(r_A, r_skb, off), ctx);
+			if (PKT_VLAN_PRESENT_BIT)
+				OP_IMM3(ARM_LSR, r_A, r_A, PKT_VLAN_PRESENT_BIT, ctx);
+			OP_IMM3(ARM_AND, r_A, r_A, 0x1, ctx);
 			break;
 		case BPF_ANC | SKF_AD_PKTTYPE:
 			ctx->seen |= SEEN_SKB;
diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 49a2e22..fb6d234 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1138,19 +1138,20 @@ static int build_body(struct jit_ctx *ctx)
 			emit_load(r_A, r_skb, off, ctx);
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG:
-		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			ctx->flags |= SEEN_SKB | SEEN_A;
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
 						  vlan_tci) != 2);
 			off = offsetof(struct sk_buff, vlan_tci);
 			emit_half_load(r_s0, r_skb, off, ctx);
-			if (code == (BPF_ANC | SKF_AD_VLAN_TAG)) {
-				emit_andi(r_A, r_s0, (u16)~VLAN_TAG_PRESENT, ctx);
-			} else {
-				emit_andi(r_A, r_s0, VLAN_TAG_PRESENT, ctx);
-				/* return 1 if present */
-				emit_sltu(r_A, r_zero, r_A, ctx);
-			}
+			break;
+		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			emit_load_byte(r_A, r_skb, PKT_VLAN_PRESENT_OFFSET(), ctx);
+			if (PKT_VLAN_PRESENT_BIT)
+				emit_srl(r_A, r_A, PKT_VLAN_PRESENT_BIT, ctx);
+			emit_andi(r_A, r_s0, 1, ctx);
+			/* return 1 if present */
+			emit_sltu(r_A, r_zero, r_A, ctx);
 			break;
 		case BPF_ANC | SKF_AD_PKTTYPE:
 			ctx->flags |= SEEN_SKB;
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 7e706f3..fb38927 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -377,18 +377,16 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 							  hash));
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG:
-		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
-			BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
 
 			PPC_LHZ_OFFS(r_A, r_skb, offsetof(struct sk_buff,
 							  vlan_tci));
-			if (code == (BPF_ANC | SKF_AD_VLAN_TAG)) {
-				PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
-			} else {
-				PPC_ANDI(r_A, r_A, VLAN_TAG_PRESENT);
-				PPC_SRWI(r_A, r_A, 12);
-			}
+			break;
+		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+			PPC_LBZ_OFFS(r_A, r_skb, PKT_VLAN_PRESENT_OFFSET());
+			if (PKT_VLAN_PRESENT_BIT)
+				PPC_SRWI(r_A, r_A, PKT_VLAN_PRESENT_BIT);
+			PPC_ANDI(r_A, r_A, 1);
 			break;
 		case BPF_ANC | SKF_AD_QUEUE:
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
diff --git a/arch/sparc/net/bpf_jit_comp.c b/arch/sparc/net/bpf_jit_comp.c
index a6d9204..d499b39 100644
--- a/arch/sparc/net/bpf_jit_comp.c
+++ b/arch/sparc/net/bpf_jit_comp.c
@@ -601,15 +601,13 @@ void bpf_jit_compile(struct bpf_prog *fp)
 				emit_skb_load32(hash, r_A);
 				break;
 			case BPF_ANC | SKF_AD_VLAN_TAG:
-			case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 				emit_skb_load16(vlan_tci, r_A);
-				if (code != (BPF_ANC | SKF_AD_VLAN_TAG)) {
-					emit_alu_K(SRL, 12);
-					emit_andi(r_A, 1, r_A);
-				} else {
-					emit_loadimm(~VLAN_TAG_PRESENT, r_TMP);
-					emit_and(r_A, r_TMP, r_A);
-				}
+				break;
+			case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+				__emit_skb_load8(__pkt_vlan_present_offset, r_A);
+				if (PKT_VLAN_PRESENT_BIT)
+					emit_alu_K(SRL, PKT_VLAN_PRESENT_BIT);
+				emit_andi(r_A, 1, r_A);
 				break;
 			case BPF_LD | BPF_W | BPF_LEN:
 				emit_skb_load32(len, r_A);
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index f1510cc..66a3d39 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -3899,7 +3899,7 @@ static int rx_pkt(struct c4iw_dev *dev, struct sk_buff *skb)
 	} else {
 		vlan_eh = (struct vlan_ethhdr *)(req + 1);
 		iph = (struct iphdr *)(vlan_eh + 1);
-		skb->vlan_tci = ntohs(cpl->vlan);
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), ntohs(cpl->vlan));
 	}
 
 	if (iph->version != 0x4)
diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 8563769..b9e360c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -414,7 +414,7 @@ static struct i40iw_puda_buf *i40iw_form_cm_frame(struct i40iw_cm_node *cm_node,
 			pd_len += MPA_ZERO_PAD_LEN;
 	}
 
-	if (cm_node->vlan_id < VLAN_TAG_PRESENT)
+	if (cm_node->vlan_id <= VLAN_VID_MASK)
 		eth_hlen += 4;
 
 	if (cm_node->ipv4)
@@ -443,7 +443,7 @@ static struct i40iw_puda_buf *i40iw_form_cm_frame(struct i40iw_cm_node *cm_node,
 
 		ether_addr_copy(ethh->h_dest, cm_node->rem_mac);
 		ether_addr_copy(ethh->h_source, cm_node->loc_mac);
-		if (cm_node->vlan_id < VLAN_TAG_PRESENT) {
+		if (cm_node->vlan_id <= VLAN_VID_MASK) {
 			((struct vlan_ethhdr *)ethh)->h_vlan_proto = htons(ETH_P_8021Q);
 			((struct vlan_ethhdr *)ethh)->h_vlan_TCI = htons(cm_node->vlan_id);
 
@@ -472,7 +472,7 @@ static struct i40iw_puda_buf *i40iw_form_cm_frame(struct i40iw_cm_node *cm_node,
 
 		ether_addr_copy(ethh->h_dest, cm_node->rem_mac);
 		ether_addr_copy(ethh->h_source, cm_node->loc_mac);
-		if (cm_node->vlan_id < VLAN_TAG_PRESENT) {
+		if (cm_node->vlan_id <= VLAN_VID_MASK) {
 			((struct vlan_ethhdr *)ethh)->h_vlan_proto = htons(ETH_P_8021Q);
 			((struct vlan_ethhdr *)ethh)->h_vlan_TCI = htons(cm_node->vlan_id);
 			((struct vlan_ethhdr *)ethh)->h_vlan_encapsulated_proto = htons(ETH_P_IPV6);
@@ -3235,7 +3235,7 @@ static void i40iw_init_tcp_ctx(struct i40iw_cm_node *cm_node,
 
 	tcp_info->flow_label = 0;
 	tcp_info->snd_mss = cpu_to_le32(((u32)cm_node->tcp_cntxt.mss));
-	if (cm_node->vlan_id < VLAN_TAG_PRESENT) {
+	if (cm_node->vlan_id <= VLAN_VID_MASK) {
 		tcp_info->insert_vlan_tag = true;
 		tcp_info->vlan_tag = cpu_to_le16(cm_node->vlan_id);
 	}
diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index b1d2ac8..6e3c610 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -5734,7 +5734,7 @@ static int cnic_netdev_event(struct notifier_block *this, unsigned long event,
 		if (realdev) {
 			dev = cnic_from_netdev(realdev);
 			if (dev) {
-				vid |= VLAN_TAG_PRESENT;
+				vid |= VLAN_CFI_MASK;	/* make non-zero */
 				cnic_rcv_netevent(dev->cnic_priv, event, vid);
 				cnic_put(dev);
 			}
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 7e1633b..b365a01 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1053,12 +1053,12 @@ static struct sk_buff *be_insert_vlan_in_pkt(struct be_adapter *adapter,
 		BE_WRB_F_SET(wrb_params->features, VLAN_SKIP_HW, 1);
 	}
 
-	if (vlan_tag) {
+	if (skb_vlan_tag_present(skb)) {
 		skb = vlan_insert_tag_set_proto(skb, htons(ETH_P_8021Q),
 						vlan_tag);
 		if (unlikely(!skb))
 			return skb;
-		skb->vlan_tci = 0;
+		__vlan_hwaccel_clear_tag(skb);
 	}
 
 	/* Insert the outer VLAN, if any */
diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index 56588f2..b479ded 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -1155,13 +1155,10 @@ static int gfar_convert_to_filer(struct ethtool_rx_flow_spec *rule,
 		prio = vlan_tci_prio(rule);
 		prio_mask = vlan_tci_priom(rule);
 
-		if (cfi == VLAN_TAG_PRESENT && cfi_mask == VLAN_TAG_PRESENT) {
+		if (cfi)
 			vlan |= RQFPR_CFI;
+		if (cfi_mask)
 			vlan_mask |= RQFPR_CFI;
-		} else if (cfi != VLAN_TAG_PRESENT &&
-			   cfi_mask == VLAN_TAG_PRESENT) {
-			vlan_mask |= RQFPR_CFI;
-		}
 	}
 
 	switch (rule->flow_type & ~FLOW_EXT) {
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index c125966..c7664db 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -765,7 +765,7 @@ static int ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tx_crq.v1.sge_len = cpu_to_be32(skb->len);
 	tx_crq.v1.ioba = cpu_to_be64(data_dma_addr);
 
-	if (adapter->vlan_header_insertion) {
+	if (adapter->vlan_header_insertion && skb_vlan_tag_present(skb)) {
 		tx_crq.v1.flags2 |= IBMVNIC_TX_VLAN_INSERT;
 		tx_crq.v1.vlan_id = cpu_to_be16(skb->vlan_tci);
 	}
@@ -964,7 +964,8 @@ static int ibmvnic_poll(struct napi_struct *napi, int budget)
 		skb = rx_buff->skb;
 		skb_copy_to_linear_data(skb, rx_buff->data + offset,
 					length);
-		skb->vlan_tci = be16_to_cpu(next->rx_comp.vlan_tci);
+		if (flags & IBMVNIC_VLAN_STRIPPED)
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), be16_to_cpu(next->rx_comp.vlan_tci));
 		/* free the entry */
 		next->rx_comp.first = 0;
 		remove_buff_from_pool(adapter, rx_buff);
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index b60ad0e..566bdfc1 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -2487,11 +2487,11 @@ static struct sk_buff *receive_copy(struct sky2_port *sky2,
 		skb_copy_hash(skb, re->skb);
 		skb->vlan_proto = re->skb->vlan_proto;
 		skb->vlan_tci = re->skb->vlan_tci;
+		skb->vlan_present = re->skb->vlan_present;
 
 		pci_dma_sync_single_for_device(sky2->hw->pdev, re->data_addr,
 					       length, PCI_DMA_FROMDEVICE);
-		re->skb->vlan_proto = 0;
-		re->skb->vlan_tci = 0;
+		__vlan_hwaccel_clear_tag(re->skb);
 		skb_clear_hash(re->skb);
 		re->skb->ip_summed = CHECKSUM_NONE;
 		skb_put(skb, length);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index fedd736..806e4d1 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -459,7 +459,7 @@ static int qlcnic_tx_pkt(struct qlcnic_adapter *adapter,
 			 struct cmd_desc_type0 *first_desc, struct sk_buff *skb,
 			 struct qlcnic_host_tx_ring *tx_ring)
 {
-	u8 l4proto, opcode = 0, hdr_len = 0;
+	u8 l4proto, opcode = 0, hdr_len = 0, tag_vlan = 0;
 	u16 flags = 0, vlan_tci = 0;
 	int copied, offset, copy_len, size;
 	struct cmd_desc_type0 *hwdesc;
@@ -472,18 +472,21 @@ static int qlcnic_tx_pkt(struct qlcnic_adapter *adapter,
 		flags = QLCNIC_FLAGS_VLAN_TAGGED;
 		vlan_tci = ntohs(vh->h_vlan_TCI);
 		protocol = ntohs(vh->h_vlan_encapsulated_proto);
+		tag_vlan = 1;
 	} else if (skb_vlan_tag_present(skb)) {
 		flags = QLCNIC_FLAGS_VLAN_OOB;
 		vlan_tci = skb_vlan_tag_get(skb);
+		tag_vlan = 1;
 	}
 	if (unlikely(adapter->tx_pvid)) {
-		if (vlan_tci && !(adapter->flags & QLCNIC_TAGGING_ENABLED))
+		if (tag_vlan && !(adapter->flags & QLCNIC_TAGGING_ENABLED))
 			return -EIO;
-		if (vlan_tci && (adapter->flags & QLCNIC_TAGGING_ENABLED))
+		if (tag_vlan && (adapter->flags & QLCNIC_TAGGING_ENABLED))
 			goto set_flags;
 
 		flags = QLCNIC_FLAGS_VLAN_OOB;
 		vlan_tci = adapter->tx_pvid;
+		tag_vlan = 1;
 	}
 set_flags:
 	qlcnic_set_tx_vlan_tci(first_desc, vlan_tci);
diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 3958ada..b53729e 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -186,7 +186,7 @@ int netvsc_recv_callback(struct hv_device *device_obj,
 			void **data,
 			struct ndis_tcp_ip_checksum_info *csum_info,
 			struct vmbus_channel *channel,
-			u16 vlan_tci);
+			u16 vlan_tci, bool vlan_present);
 void netvsc_channel_cb(void *context);
 int rndis_filter_open(struct netvsc_device *nvdev);
 int rndis_filter_close(struct netvsc_device *nvdev);
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 9522763..1ef3d70 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -437,6 +437,7 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
 		vlan = (struct ndis_pkt_8021q_info *)((void *)ppi +
 						ppi->ppi_offset);
 		vlan->vlanid = skb->vlan_tci & VLAN_VID_MASK;
+		vlan->cfi = !!(skb->vlan_tci & VLAN_CFI_MASK);
 		vlan->pri = (skb->vlan_tci & VLAN_PRIO_MASK) >>
 				VLAN_PRIO_SHIFT;
 	}
@@ -591,7 +592,7 @@ void netvsc_linkstatus_callback(struct hv_device *device_obj,
 static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
 				struct hv_netvsc_packet *packet,
 				struct ndis_tcp_ip_checksum_info *csum_info,
-				void *data, u16 vlan_tci)
+				void *data)
 {
 	struct sk_buff *skb;
 
@@ -621,10 +622,6 @@ static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
 
-	if (vlan_tci & VLAN_TAG_PRESENT)
-		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
-				       vlan_tci);
-
 	return skb;
 }
 
@@ -637,7 +634,7 @@ int netvsc_recv_callback(struct hv_device *device_obj,
 				void **data,
 				struct ndis_tcp_ip_checksum_info *csum_info,
 				struct vmbus_channel *channel,
-				u16 vlan_tci)
+				u16 vlan_tci, bool vlan_present)
 {
 	struct net_device *net = hv_get_drvdata(device_obj);
 	struct net_device_context *net_device_ctx = netdev_priv(net);
@@ -660,12 +657,15 @@ int netvsc_recv_callback(struct hv_device *device_obj,
 		net = vf_netdev;
 
 	/* Allocate a skb - TODO direct I/O to pages? */
-	skb = netvsc_alloc_recv_skb(net, packet, csum_info, *data, vlan_tci);
+	skb = netvsc_alloc_recv_skb(net, packet, csum_info, *data);
 	if (unlikely(!skb)) {
 		++net->stats.rx_dropped;
 		return NVSP_STAT_FAIL;
 	}
 
+	if (vlan_present)
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
+
 	if (net != vf_netdev)
 		skb_record_rx_queue(skb,
 				    channel->offermsg.offer.sub_channel_index);
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 8d90904..9759d73 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -381,13 +381,14 @@ static int rndis_filter_receive_data(struct rndis_device *dev,
 
 	vlan = rndis_get_ppi(rndis_pkt, IEEE_8021Q_INFO);
 	if (vlan) {
-		vlan_tci = VLAN_TAG_PRESENT | vlan->vlanid |
+		vlan_tci = vlan->vlanid |
+			(vlan->cfi ? VLAN_CFI_MASK : 0) |
 			(vlan->pri << VLAN_PRIO_SHIFT);
 	}
 
 	csum_info = rndis_get_ppi(rndis_pkt, TCPIP_CHKSUM_PKTINFO);
 	return netvsc_recv_callback(net_device_ctx->device_ctx, pkt, data,
-				    csum_info, channel, vlan_tci);
+				    csum_info, channel, vlan_tci, vlan);
 }
 
 int rndis_filter_receive(struct hv_device *dev,
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 8d5fcd6..a0ba7ba 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -66,7 +66,6 @@ static inline struct vlan_ethhdr *vlan_eth_hdr(const struct sk_buff *skb)
 #define VLAN_PRIO_MASK		0xe000 /* Priority Code Point */
 #define VLAN_PRIO_SHIFT		13
 #define VLAN_CFI_MASK		0x1000 /* Canonical Format Indicator */
-#define VLAN_TAG_PRESENT	VLAN_CFI_MASK
 #define VLAN_VID_MASK		0x0fff /* VLAN Identifier */
 #define VLAN_N_VID		4096
 
@@ -78,8 +77,8 @@ static inline bool is_vlan_dev(const struct net_device *dev)
         return dev->priv_flags & IFF_802_1Q_VLAN;
 }
 
-#define skb_vlan_tag_present(__skb)	((__skb)->vlan_tci & VLAN_TAG_PRESENT)
-#define skb_vlan_tag_get(__skb)		((__skb)->vlan_tci & ~VLAN_TAG_PRESENT)
+#define skb_vlan_tag_present(__skb)	((__skb)->vlan_present)
+#define skb_vlan_tag_get(__skb)		((__skb)->vlan_tci)
 #define skb_vlan_tag_get_id(__skb)	((__skb)->vlan_tci & VLAN_VID_MASK)
 #define skb_vlan_tag_get_prio(__skb)	((__skb)->vlan_tci & VLAN_PRIO_MASK)
 
@@ -382,6 +381,17 @@ static inline struct sk_buff *vlan_insert_tag_set_proto(struct sk_buff *skb,
 	return skb;
 }
 
+/**
+ * __vlan_hwaccel_clear_tag - clear hardware accelerated VLAN info
+ * @skb: skbuff to clear
+ *
+ * Clears the VLAN information from @skb
+ */
+static inline void __vlan_hwaccel_clear_tag(struct sk_buff *skb)
+{
+	skb->vlan_present = 0;
+}
+
 /*
  * __vlan_hwaccel_push_inside - pushes vlan tag to the payload
  * @skb: skbuff to tag
@@ -396,7 +406,7 @@ static inline struct sk_buff *__vlan_hwaccel_push_inside(struct sk_buff *skb)
 	skb = vlan_insert_tag_set_proto(skb, skb->vlan_proto,
 					skb_vlan_tag_get(skb));
 	if (likely(skb))
-		skb->vlan_tci = 0;
+		__vlan_hwaccel_clear_tag(skb);
 	return skb;
 }
 
@@ -412,7 +422,8 @@ static inline void __vlan_hwaccel_put_tag(struct sk_buff *skb,
 					  __be16 vlan_proto, u16 vlan_tci)
 {
 	skb->vlan_proto = vlan_proto;
-	skb->vlan_tci = VLAN_TAG_PRESENT | vlan_tci;
+	skb->vlan_tci = vlan_tci;
+	skb->vlan_present = 1;
 }
 
 /**
@@ -452,8 +463,6 @@ static inline int __vlan_hwaccel_get_tag(const struct sk_buff *skb,
 	}
 }
 
-#define HAVE_VLAN_GET_TAG
-
 /**
  * vlan_get_tag - get the VLAN ID from the skb
  * @skb: skbuff to query
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9c535fb..4a28beed 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -733,6 +733,14 @@ struct sk_buff {
 	__u8			csum_level:2;
 	__u8			csum_bad:1;
 
+#ifdef __BIG_ENDIAN_BITFIELD
+#define PKT_VLAN_PRESENT_BIT	7
+#else
+#define PKT_VLAN_PRESENT_BIT	0
+#endif
+#define PKT_VLAN_PRESENT_OFFSET()	offsetof(struct sk_buff, __pkt_vlan_present_offset)
+	__u8			__pkt_vlan_present_offset[0];
+	__u8			vlan_present:1;
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	__u8			ndisc_nodetype:2;
 #endif
@@ -742,7 +750,7 @@ struct sk_buff {
 #ifdef CONFIG_NET_SWITCHDEV
 	__u8			offload_fwd_mark:1;
 #endif
-	/* 2, 4 or 5 bit hole */
+	/* 1-4 bit hole */
 
 #ifdef CONFIG_NET_SCHED
 	__u16			tc_index;	/* traffic control index */
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 0362da0..9cb21a2 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -38,6 +38,7 @@
 #define SKB_HASH	0x1234aaab
 #define SKB_QUEUE_MAP	123
 #define SKB_VLAN_TCI	0xffff
+#define SKB_VLAN_PRESENT	1
 #define SKB_DEV_IFINDEX	577
 #define SKB_DEV_TYPE	588
 
@@ -691,8 +692,8 @@ static struct bpf_test tests[] = {
 		CLASSIC,
 		{ },
 		{
-			{ 1, SKB_VLAN_TCI & ~VLAN_TAG_PRESENT },
-			{ 10, SKB_VLAN_TCI & ~VLAN_TAG_PRESENT }
+			{ 1, SKB_VLAN_TCI },
+			{ 10, SKB_VLAN_TCI }
 		},
 	},
 	{
@@ -705,8 +706,8 @@ static struct bpf_test tests[] = {
 		CLASSIC,
 		{ },
 		{
-			{ 1, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) },
-			{ 10, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) }
+			{ 1, SKB_VLAN_PRESENT },
+			{ 10, SKB_VLAN_PRESENT }
 		},
 	},
 	{
@@ -4773,8 +4774,8 @@ static struct bpf_test tests[] = {
 		CLASSIC,
 		{ },
 		{
-			{  1, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) },
-			{ 10, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) }
+			{  1, SKB_VLAN_PRESENT },
+			{ 10, SKB_VLAN_PRESENT }
 		},
 		.fill_helper = bpf_fill_maxinsns6,
 	},
@@ -5486,6 +5487,7 @@ static struct sk_buff *populate_skb(char *buf, int size)
 	skb->queue_mapping = SKB_QUEUE_MAP;
 	skb->vlan_tci = SKB_VLAN_TCI;
 	skb->vlan_proto = htons(ETH_P_IP);
+	skb->vlan_present = SKB_VLAN_PRESENT;
 	skb->dev = &dev;
 	skb->dev->ifindex = SKB_DEV_IFINDEX;
 	skb->dev->type = SKB_DEV_TYPE;
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index e2ed698..604a67a 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -50,7 +50,7 @@ bool vlan_do_receive(struct sk_buff **skbp)
 	}
 
 	skb->priority = vlan_get_ingress_priority(vlan_dev, skb->vlan_tci);
-	skb->vlan_tci = 0;
+	__vlan_hwaccel_clear_tag(skb);
 
 	rx_stats = this_cpu_ptr(vlan_dev_priv(vlan_dev)->vlan_pcpu_stats);
 
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 83d937f..1610a51 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -682,10 +682,8 @@ static int br_nf_push_frag_xmit(struct net *net, struct sock *sk, struct sk_buff
 		return 0;
 	}
 
-	if (data->vlan_tci) {
-		skb->vlan_tci = data->vlan_tci;
-		skb->vlan_proto = data->vlan_proto;
-	}
+	if (data->vlan_proto)
+		__vlan_hwaccel_put_tag(skb, data->vlan_proto, data->vlan_tci);
 
 	skb_copy_to_linear_data_offset(skb, -data->size, data->mac, data->size);
 	__skb_push(skb, data->encap_size);
@@ -749,8 +747,12 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 
 		data = this_cpu_ptr(&brnf_frag_data_storage);
 
-		data->vlan_tci = skb->vlan_tci;
-		data->vlan_proto = skb->vlan_proto;
+		if (skb_vlan_tag_present(skb)) {
+			data->vlan_tci = skb->vlan_tci;
+			data->vlan_proto = skb->vlan_proto;
+		} else
+			data->vlan_proto = 0;
+
 		data->encap_size = nf_bridge_encap_header_len(skb);
 		data->size = ETH_HLEN + data->encap_size;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 26aec23..33a0ba0 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -818,7 +818,7 @@ static inline int br_vlan_get_tag(const struct sk_buff *skb, u16 *vid)
 	int err = 0;
 
 	if (skb_vlan_tag_present(skb)) {
-		*vid = skb_vlan_tag_get(skb) & VLAN_VID_MASK;
+		*vid = skb_vlan_tag_get_id(skb);
 	} else {
 		*vid = 0;
 		err = -EINVAL;
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index b6de4f4..ef94664 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -377,7 +377,7 @@ struct sk_buff *br_handle_vlan(struct net_bridge *br,
 	}
 
 	if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
-		skb->vlan_tci = 0;
+		__vlan_hwaccel_clear_tag(skb);
 out:
 	return skb;
 }
@@ -444,8 +444,8 @@ static bool __allowed_ingress(const struct net_bridge *br,
 			__vlan_hwaccel_put_tag(skb, br->vlan_proto, pvid);
 		else
 			/* Priority-tagged Frame.
-			 * At this point, We know that skb->vlan_tci had
-			 * VLAN_TAG_PRESENT bit and its VID field was 0x000.
+			 * At this point, We know that skb->vlan_tci VID
+			 * field was 0x000.
 			 * We update only VID field and preserve PCP field.
 			 */
 			skb->vlan_tci |= pvid;
diff --git a/net/core/dev.c b/net/core/dev.c
index bffb525..1773204 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4166,7 +4166,7 @@ static int __netif_receive_skb_core(struct sk_buff *skb, bool pfmemalloc)
 		 * and set skb->priority like in vlan_do_receive()
 		 * For the time being, just ignore Priority Code Point
 		 */
-		skb->vlan_tci = 0;
+		__vlan_hwaccel_clear_tag(skb);
 	}
 
 	type = skb->protocol;
@@ -4413,7 +4413,9 @@ static void gro_list_prepare(struct napi_struct *napi, struct sk_buff *skb)
 		}
 
 		diffs = (unsigned long)p->dev ^ (unsigned long)skb->dev;
-		diffs |= p->vlan_tci ^ skb->vlan_tci;
+		diffs |= skb_vlan_tag_present(p) ^ skb_vlan_tag_present(skb);
+		if (skb_vlan_tag_present(p))
+			diffs |= p->vlan_tci ^ skb->vlan_tci;
 		diffs |= skb_metadata_dst_cmp(p, skb);
 		if (maclen == ETH_HLEN)
 			diffs |= compare_ether_header(skb_mac_header(p),
@@ -4651,7 +4653,7 @@ static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 	__skb_pull(skb, skb_headlen(skb));
 	/* restore the reserve we had after netdev_alloc_skb_ip_align() */
 	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN - skb_headroom(skb));
-	skb->vlan_tci = 0;
+	__vlan_hwaccel_clear_tag(skb);
 	skb->dev = napi->dev;
 	skb->skb_iif = 0;
 	skb->encapsulation = 0;
diff --git a/net/core/filter.c b/net/core/filter.c
index 56b4358..b4537c6 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -188,22 +188,17 @@ static u32 convert_skb_access(int skb_field, int dst_reg, int src_reg,
 		break;
 
 	case SKF_AD_VLAN_TAG:
-	case SKF_AD_VLAN_TAG_PRESENT:
 		BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
-		BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
 
 		/* dst_reg = *(u16 *) (src_reg + offsetof(vlan_tci)) */
 		*insn++ = BPF_LDX_MEM(BPF_H, dst_reg, src_reg,
 				      offsetof(struct sk_buff, vlan_tci));
-		if (skb_field == SKF_AD_VLAN_TAG) {
-			*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg,
-						~VLAN_TAG_PRESENT);
-		} else {
-			/* dst_reg >>= 12 */
-			*insn++ = BPF_ALU32_IMM(BPF_RSH, dst_reg, 12);
-			/* dst_reg &= 1 */
-			*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, 1);
-		}
+		break;
+	case SKF_AD_VLAN_TAG_PRESENT:
+		*insn++ = BPF_LDX_MEM(BPF_B, dst_reg, src_reg, PKT_VLAN_PRESENT_OFFSET());
+		if (PKT_VLAN_PRESENT_BIT)
+			*insn++ = BPF_ALU32_IMM(BPF_RSH, dst_reg, PKT_VLAN_PRESENT_BIT);
+		*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, 1);
 		break;
 	}
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b45cd14..66fb686 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4565,7 +4565,7 @@ int skb_vlan_pop(struct sk_buff *skb)
 	int err;
 
 	if (likely(skb_vlan_tag_present(skb))) {
-		skb->vlan_tci = 0;
+		__vlan_hwaccel_clear_tag(skb);
 	} else {
 		if (unlikely(!eth_type_vlan(skb->protocol)))
 			return 0;
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index fed3d29..0004a54 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -120,7 +120,7 @@ int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
 	}
 
 	skb_clear_hash_if_not_l4(skb);
-	skb->vlan_tci = 0;
+	__vlan_hwaccel_clear_tag(skb);
 	skb_set_queue_mapping(skb, 0);
 	skb_scrub_packet(skb, xnet);
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index be7627b..f268bb9 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -1111,8 +1111,9 @@ static int nfqa_parse_bridge(struct nf_queue_entry *entry,
 		if (!tb[NFQA_VLAN_TCI] || !tb[NFQA_VLAN_PROTO])
 			return -EINVAL;
 
-		entry->skb->vlan_tci = ntohs(nla_get_be16(tb[NFQA_VLAN_TCI]));
-		entry->skb->vlan_proto = nla_get_be16(tb[NFQA_VLAN_PROTO]);
+		__vlan_hwaccel_put_tag(entry->skb,
+			nla_get_be16(tb[NFQA_VLAN_PROTO]),
+			ntohs(nla_get_be16(tb[NFQA_VLAN_TCI])));
 	}
 
 	if (nfqa[NFQA_L2HDR]) {
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 514f7bc..a3f0982 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -277,8 +277,7 @@ static int push_vlan(struct sk_buff *skb, struct sw_flow_key *key,
 		key->eth.vlan.tci = vlan->vlan_tci;
 		key->eth.vlan.tpid = vlan->vlan_tpid;
 	}
-	return skb_vlan_push(skb, vlan->vlan_tpid,
-			     ntohs(vlan->vlan_tci) & ~VLAN_TAG_PRESENT);
+	return skb_vlan_push(skb, vlan->vlan_tpid, ntohs(vlan->vlan_tci));
 }
 
 /* 'src' is already properly masked. */
@@ -704,8 +703,10 @@ static int ovs_vport_output(struct net *net, struct sock *sk, struct sk_buff *sk
 	__skb_dst_copy(skb, data->dst);
 	*OVS_CB(skb) = data->cb;
 	skb->inner_protocol = data->inner_protocol;
-	skb->vlan_tci = data->vlan_tci;
-	skb->vlan_proto = data->vlan_proto;
+	if (data->vlan_proto)
+		__vlan_hwaccel_put_tag(skb, data->vlan_proto, data->vlan_tci);
+	else
+		__vlan_hwaccel_clear_tag(skb);
 
 	/* Reconstruct the MAC header.  */
 	skb_push(skb, data->l2_len);
@@ -749,8 +750,8 @@ static void prepare_frag(struct vport *vport, struct sk_buff *skb,
 	data->cb = *OVS_CB(skb);
 	data->inner_protocol = skb->inner_protocol;
 	data->network_offset = orig_network_offset;
-	data->vlan_tci = skb->vlan_tci;
-	data->vlan_proto = skb->vlan_proto;
+	data->vlan_tci = skb_vlan_tag_present(skb) ? skb->vlan_tci : 0;
+	data->vlan_proto = skb_vlan_tag_present(skb) ? skb->vlan_proto : 0;
 	data->mac_proto = mac_proto;
 	data->l2_len = hlen;
 	memcpy(&data->l2_data, skb->data, hlen);
diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 08aa926..5e4579a 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -327,7 +327,7 @@ static int parse_vlan_tag(struct sk_buff *skb, struct vlan_head *key_vh)
 		return -ENOMEM;
 
 	vh = (struct vlan_head *)skb->data;
-	key_vh->tci = vh->tci | htons(VLAN_TAG_PRESENT);
+	key_vh->tci = vh->tci;
 	key_vh->tpid = vh->tpid;
 
 	__skb_pull(skb, sizeof(struct vlan_head));
diff --git a/net/openvswitch/flow.h b/net/openvswitch/flow.h
index f61cae7..f5115ed 100644
--- a/net/openvswitch/flow.h
+++ b/net/openvswitch/flow.h
@@ -57,8 +57,8 @@ struct ovs_tunnel_info {
 };
 
 struct vlan_head {
-	__be16 tpid; /* Vlan type. Generally 802.1q or 802.1ad.*/
-	__be16 tci;  /* 0 if no VLAN, VLAN_TAG_PRESENT set otherwise. */
+	__be16 tpid; /* Vlan type. Generally 802.1q or 802.1ad. 0 if no VLAN*/
+	__be16 tci;
 };
 
 #define OVS_SW_FLOW_KEY_METADATA_SIZE			\
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index d19044f..6ae5218 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -835,8 +835,6 @@ static int validate_vlan_from_nlattrs(const struct sw_flow_match *match,
 				      u64 key_attrs, bool inner,
 				      const struct nlattr **a, bool log)
 {
-	__be16 tci = 0;
-
 	if (!((key_attrs & (1 << OVS_KEY_ATTR_ETHERNET)) &&
 	      (key_attrs & (1 << OVS_KEY_ATTR_ETHERTYPE)) &&
 	       eth_type_vlan(nla_get_be16(a[OVS_KEY_ATTR_ETHERTYPE])))) {
@@ -850,20 +848,11 @@ static int validate_vlan_from_nlattrs(const struct sw_flow_match *match,
 		return -EINVAL;
 	}
 
-	if (a[OVS_KEY_ATTR_VLAN])
-		tci = nla_get_be16(a[OVS_KEY_ATTR_VLAN]);
-
-	if (!(tci & htons(VLAN_TAG_PRESENT))) {
-		if (tci) {
-			OVS_NLERR(log, "%s TCI does not have VLAN_TAG_PRESENT bit set.",
-				  (inner) ? "C-VLAN" : "VLAN");
-			return -EINVAL;
-		} else if (nla_len(a[OVS_KEY_ATTR_ENCAP])) {
-			/* Corner case for truncated VLAN header. */
-			OVS_NLERR(log, "Truncated %s header has non-zero encap attribute.",
-				  (inner) ? "C-VLAN" : "VLAN");
-			return -EINVAL;
-		}
+	if (!a[OVS_KEY_ATTR_VLAN] && nla_len(a[OVS_KEY_ATTR_ENCAP])) {
+		/* Corner case for truncated VLAN header. */
+		OVS_NLERR(log, "Truncated %s header has non-zero encap attribute.",
+			(inner) ? "C-VLAN" : "VLAN");
+		return -EINVAL;
 	}
 
 	return 1;
@@ -873,12 +862,9 @@ static int validate_vlan_mask_from_nlattrs(const struct sw_flow_match *match,
 					   u64 key_attrs, bool inner,
 					   const struct nlattr **a, bool log)
 {
-	__be16 tci = 0;
 	__be16 tpid = 0;
-	bool encap_valid = !!(match->key->eth.vlan.tci &
-			      htons(VLAN_TAG_PRESENT));
-	bool i_encap_valid = !!(match->key->eth.cvlan.tci &
-				htons(VLAN_TAG_PRESENT));
+	bool encap_valid = !!match->key->eth.vlan.tpid;
+	bool i_encap_valid = !!match->key->eth.cvlan.tpid;
 
 	if (!(key_attrs & (1 << OVS_KEY_ATTR_ENCAP))) {
 		/* Not a VLAN. */
@@ -891,9 +877,6 @@ static int validate_vlan_mask_from_nlattrs(const struct sw_flow_match *match,
 		return -EINVAL;
 	}
 
-	if (a[OVS_KEY_ATTR_VLAN])
-		tci = nla_get_be16(a[OVS_KEY_ATTR_VLAN]);
-
 	if (a[OVS_KEY_ATTR_ETHERTYPE])
 		tpid = nla_get_be16(a[OVS_KEY_ATTR_ETHERTYPE]);
 
@@ -902,11 +885,6 @@ static int validate_vlan_mask_from_nlattrs(const struct sw_flow_match *match,
 			  (inner) ? "C-VLAN" : "VLAN", ntohs(tpid));
 		return -EINVAL;
 	}
-	if (!(tci & htons(VLAN_TAG_PRESENT))) {
-		OVS_NLERR(log, "%s TCI mask does not have exact match for VLAN_TAG_PRESENT bit.",
-			  (inner) ? "C-VLAN" : "VLAN");
-		return -EINVAL;
-	}
 
 	return 1;
 }
@@ -958,7 +936,7 @@ static int parse_vlan_from_nlattrs(struct sw_flow_match *match,
 	if (err)
 		return err;
 
-	encap_valid = !!(match->key->eth.vlan.tci & htons(VLAN_TAG_PRESENT));
+	encap_valid = !!match->key->eth.vlan.tpid;
 	if (encap_valid) {
 		err = __parse_vlan_from_nlattrs(match, key_attrs, true, a,
 						is_mask, log);
@@ -1974,12 +1952,12 @@ static inline void add_nested_action_end(struct sw_flow_actions *sfa,
 static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 				  const struct sw_flow_key *key,
 				  int depth, struct sw_flow_actions **sfa,
-				  __be16 eth_type, __be16 vlan_tci, bool log);
+				  __be16 eth_type, __be16 vlan_tci, bool has_vlan, bool log);
 
 static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
 				    const struct sw_flow_key *key, int depth,
 				    struct sw_flow_actions **sfa,
-				    __be16 eth_type, __be16 vlan_tci, bool log)
+				    __be16 eth_type, __be16 vlan_tci, bool has_vlan, bool log)
 {
 	const struct nlattr *attrs[OVS_SAMPLE_ATTR_MAX + 1];
 	const struct nlattr *probability, *actions;
@@ -2017,7 +1995,7 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
 		return st_acts;
 
 	err = __ovs_nla_copy_actions(net, actions, key, depth + 1, sfa,
-				     eth_type, vlan_tci, log);
+				     eth_type, vlan_tci, has_vlan, log);
 	if (err)
 		return err;
 
@@ -2358,7 +2336,7 @@ static int copy_action(const struct nlattr *from,
 static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 				  const struct sw_flow_key *key,
 				  int depth, struct sw_flow_actions **sfa,
-				  __be16 eth_type, __be16 vlan_tci, bool log)
+				  __be16 eth_type, __be16 vlan_tci, bool has_vlan, bool log)
 {
 	u8 mac_proto = ovs_key_mac_proto(key);
 	const struct nlattr *a;
@@ -2436,6 +2414,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			if (mac_proto != MAC_PROTO_ETHERNET)
 				return -EINVAL;
 			vlan_tci = htons(0);
+			has_vlan = 0;
 			break;
 
 		case OVS_ACTION_ATTR_PUSH_VLAN:
@@ -2444,9 +2423,8 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			vlan = nla_data(a);
 			if (!eth_type_vlan(vlan->vlan_tpid))
 				return -EINVAL;
-			if (!(vlan->vlan_tci & htons(VLAN_TAG_PRESENT)))
-				return -EINVAL;
 			vlan_tci = vlan->vlan_tci;
+			has_vlan = 1;
 			break;
 
 		case OVS_ACTION_ATTR_RECIRC:
@@ -2460,7 +2438,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			/* Prohibit push MPLS other than to a white list
 			 * for packets that have a known tag order.
 			 */
-			if (vlan_tci & htons(VLAN_TAG_PRESENT) ||
+			if (has_vlan ||
 			    (eth_type != htons(ETH_P_IP) &&
 			     eth_type != htons(ETH_P_IPV6) &&
 			     eth_type != htons(ETH_P_ARP) &&
@@ -2472,8 +2450,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 		}
 
 		case OVS_ACTION_ATTR_POP_MPLS:
-			if (vlan_tci & htons(VLAN_TAG_PRESENT) ||
-			    !eth_p_mpls(eth_type))
+			if (has_vlan || !eth_p_mpls(eth_type))
 				return -EINVAL;
 
 			/* Disallow subsequent L2.5+ set and mpls_pop actions
@@ -2506,7 +2483,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 
 		case OVS_ACTION_ATTR_SAMPLE:
 			err = validate_and_copy_sample(net, a, key, depth, sfa,
-						       eth_type, vlan_tci, log);
+						       eth_type, vlan_tci, has_vlan, log);
 			if (err)
 				return err;
 			skip_copy = true;
@@ -2530,7 +2507,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 		case OVS_ACTION_ATTR_POP_ETH:
 			if (mac_proto != MAC_PROTO_ETHERNET)
 				return -EINVAL;
-			if (vlan_tci & htons(VLAN_TAG_PRESENT))
+			if (has_vlan)
 				return -EINVAL;
 			mac_proto = MAC_PROTO_ETHERNET;
 			break;
@@ -2565,7 +2542,7 @@ int ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 
 	(*sfa)->orig_len = nla_len(attr);
 	err = __ovs_nla_copy_actions(net, attr, key, 0, sfa, key->eth.type,
-				     key->eth.vlan.tci, log);
+				     key->eth.vlan.tci, !!key->eth.vlan.tpid, log);
 	if (err)
 		ovs_nla_free_flow_actions(*sfa);
 
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 19e0dba..8d56380 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -62,7 +62,7 @@ static int tcf_vlan(struct sk_buff *skb, const struct tc_action *a,
 		/* extract existing tag (and guarantee no hw-accel tag) */
 		if (skb_vlan_tag_present(skb)) {
 			tci = skb_vlan_tag_get(skb);
-			skb->vlan_tci = 0;
+			__vlan_hwaccel_clear_tag(skb);
 		} else {
 			/* in-payload vlan tag, pop it */
 			err = __skb_vlan_pop(skb, &tci);
-- 
2.10.2

