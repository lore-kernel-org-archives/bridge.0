Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795483005;
	b=CPplQKDjAPZIv095kir/jQ1adIQkFwSoEhvXSL80FWW/yVKXN97+2ilRClVTvfZ5nceb
	 a6XOpeuOKKyMqQNbk6Oo3fwnQJosoqbC+coEZERwTP9HAVCiuJXa7oR7CImYmW+nCxM2K
	 ewjo9DmNMm6qXxZ7OgWXQMiHSCEF3qsIR9uZ7wBZI1mJBZK+l+CZEGif584Z5+KQDXmdm
	 +LyWk4DNKwnr+6l2oinXEkxepnIvpNm8QtPbYj5vrY25k/I1vYjtUMYqymeae5RBLRkXS
	 pfFh+3ZzseeO09mrZDYmc1WVcqN9Rzj8JnoYTJmaUrWssWFx7OFqUYKyxLGHADxhLXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qZxwJbaKC6lsjHCvbsBOtxQBCZj8gipsbFteOfeQl3c=;
	b=Zf7X53zpUjzTfjp8l9btxKNGjb8EGJYRlY4Ja5ai9sZEyDy41uoFlR0k/zzeTIySsevw
	 8b3mpLatcH4WGQpN5IX5i529UGeE1WRJoR2E4BFNBD5HyZfwEJJX8q2G6ku+/KGy3s/uA
	 kKfcDEpqsNJThpGkfqlIcUP701pYorQd23uW2l4fLiXfjX1pp4hTQdx6ncZVo7hX/bJh6
	 pPYalTt6aSL5DDyAKJ3eXjpTFcA+rHNWUzS6Oxgo4C6iWDHVPIZrtYqNaeCyRSuUIr1UH
	 oLrfWZQqExvh7WnGv6orrDhj8J8CtwSADgp46UslhCZdDPFXvH3P6W7AtY4hbd6Q5/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wLt5vpMd;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F41606A321
	for <bridge@lists.linux.dev>; Tue, 24 Nov 2026 01:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26F41606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wLt5vpMd
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3866a784546so5104941eec.0
        for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 17:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795483004; x=1796087804; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qZxwJbaKC6lsjHCvbsBOtxQBCZj8gipsbFteOfeQl3c=;
        b=wLt5vpMd5D+zC43epdwX27YV1qVspNO6rJmzrAPPbfLY9xSB+MXeh3j+abXZP5p1HJ
         3Lmo4ImzCPhj0gcp6r8W4f1Wi4+vuPHIv5/xg6SFlgVO3/zyMlD0srqSycLxg5Yu8leR
         xx+j3CWktc12ZCPYwzULYRD1hQqFmeba+bvupSGixtM21QFrTWY+dQT8zPJnZp/itmGG
         UXQZlAhAOIg/MXGasyw1Dq0x8aER2x+D73yvHI2BCJ5hUdpsW9TyP0jVqH63u4chZGnZ
         Ln6sVQCOAXoWp5H1IzTlkxKeHbMLDZfHYrdaKLksf74MtHHsbKxvqtukfDaz9P94bF2u
         FmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795483004; x=1796087804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZxwJbaKC6lsjHCvbsBOtxQBCZj8gipsbFteOfeQl3c=;
        b=Q/UQmQB8mmz4v5Ye4q+J93RtN2TOcy3F5qkm3PG3iSIoLCfw/ypiRwe3CCIRI24wJe
         ihGFr28rVuLuiHG4ps0r6oZc8+BlOnVCOSzgFJQiqfa6AjnZsFGXGRASEXYTCE86lAC8
         EAprVpnUKD6Cw5qPEc8Val9xlhIkmTCQWby5447gOFz0M5swqO/Y1Ksiim525AwJBM0/
         mPUz8jOFXIlmuJYZL6X04CiSD/BB8oTJC5KIoiuy1E68oRI39WPuifQMxq4eRCUN8IZa
         ceo4ws/iJ4nIucRnS/SN80ihhbFcvBLxA12bRgcLngfggAlSpGF36Y1qQTgjegWxlvaK
         os7A==
X-Forwarded-Encrypted: i=1; AL+hErH1O212Cm/69rfJWGaqAYZ0PrRoK/B5X7rpwQRBOfdmKLDsv/I1ehY1EXkuRpjSifwdLZwo44E=@lists.linux.dev
X-Gm-Message-State: APuU4Z+fjS+OflEG+OPY4y82PWaeadOS0/XCXbW0mUIiBd5h9yPyJQHd
	AAo86TaaGkdOwoEbBwQR/lawCuIgys1MGxw3M+JCnUI0Xx9VUQ5JPgt/
X-Gm-Gg: AZFdTZffCjHF0QljHG5vw3JbTgx/ixML81sbrWosgAPiGlhbeXnynaV/iojjOD5huc3
	Qt87lbEw9mzJWiPwjHJsJSj7dHgLjsqNZeiP2TJnV9Vbj1iDo0xqIs3W/TDlm0Gw346CV1/gMGj
	YIybO4CmAONuuAzwEMuqG6mS6sA7X78kvP3uaIKlxrXFrsfQegrC5lQUl0sTQ8DFOgBoKM82L9+
	MItBew7mw0vU5By7VsRy6c5/40aefOd67CpEBoviojDgNkNfsBirivOluQSvL0wG5j6xE6/RZfd
	QG67iaTDB5sJPi/MEerPxEE8PKTdshz6A41YIUFqWL6F26krNk9rX/ExeC3NQvd3mJ+RN83PiUK
	UNvp2cl2CGn53RskTjwsFrDRP+90lraX2AUp1qUtvGXqoIKysY3s7CUv0dvcMK4IVgFGfChudDE
	yuF4Z5L7aenipys4+hM17HLOIxPwIm5AkU+YLgpWu94yNAf7szduqvSG0xSJLgoBBQfyyhnOgIi
	D1evxZZosNoAPcrBAa71P7v7Key+b2hlKfpUm6LZQo7C+vkXbW0/uNZCqra6219XVXHzyUwzhXh
	stwikkglrpk8Bx5uZ+LVW9G2/nhGHisQxekJIWhPe8kkxqBnAZ0gfWaQx+mkhaeT1m0oFoo8vFn
	+amQaDj9gficInu+8onh+bA==
X-Received: by 2002:a05:7300:de44:b0:375:c5e1:931d with SMTP id 5a478bee46e88-3857073ebabmr13338923eec.25.1795483003964;
        Mon, 23 Nov 2026 17:16:43 -0800 (PST)
Received: from samniyama.tailbcd61.ts.net ([76.20.4.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm47878511eec.11.2026.11.23.17.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:16:43 -0800 (PST)
From: Koral Ilgun <koralilgun@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net] net: bridge: switchdev: clear the hwdom of a port that stops the offload
Date: Mon, 23 Nov 2026 17:16:39 -0800
Message-ID: <20261124011639.990261-1-koralilgun@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Koral Ilgun <koral.ilgun@adtran.com>

A switchdev driver can stop the offload of a bridge port while the port
stays in the bridge. DSA does this when the last switch port leaves a
LAG that stays a bridge port. nbp_switchdev_del() then keeps the hwdom
of the port, and nbp_switchdev_hwdom_put() finds the port itself in the
port list, so the hwdom also stays busy. If the other ports with that
hwdom leave the bridge before the port, nothing releases the hwdom.
dsa_port_change_conduit() leaves a port in the same state when its new
offload fails.

After BR_HWDOM_MAX - 1 such leaks, nbp_switchdev_hwdom_set() returns
-EBUSY for a port that needs a new hwdom, so the first port of a switch
cannot join the bridge. While the stale hwdom stays,
nbp_switchdev_allowed_egress() also refuses the port for each frame that
another port of the switch forwarded in hardware, although the switch no
longer forwards to the port.

Clear the hwdom when the last offload of the port stops. Make
nbp_switchdev_hwdom_set() skip a port without a hwdom, so that a port
does not take hwdom 0 from itself or from another port that stopped the
offload. The skip also fixes a LAG that is already a bridge port when
its first switch port joins: nbp_switchdev_hwdom_set() can find the LAG
itself in the list and give it hwdom 0. The bridge then refuses each port
without a hwdom for a frame from the LAG with offload_fwd_mark, and a
later port of the same switch copies hwdom 0.

During a LAG leave, the LAG now has no hwdom from
dsa_port_pre_lag_leave() until dsa_port_lag_leave(), while the switch
still forwards to the leaving port. A frame that the switch already
forwarded can then also go out through the LAG. The window lasts for
one RTNL operation.

The forwarding path reads the hwdom under RCU only, and
nbp_switchdev_del() clears the hwdom before BR_TX_FWD_OFFLOAD. A reader
can now see the flag with hwdom 0, and would then mark the frame for TX
forwarding offload to a port that stopped the offload, or set bit 0 of
fwd_hwdoms. Replace nbp_switchdev_can_offload_tx_fwd() with
nbp_switchdev_tx_fwd_hwdom(), which reads the hwdom once and returns 0
for a port without one, so that each caller uses the value of one read.

The fault was first seen on a downstream kernel. An out-of-tree DSA
feature there stops the offload of an isolated bridge port while the
port stays in the bridge, and frames to that port were lost. Mainline
has no such feature. An AI code review agent then read the mainline
source and found that the LAG case above reaches the same state.

Only the hwdom leak was reproduced on mainline. The egress refusal, the
self match in nbp_switchdev_hwdom_set() and the reader race come from a
read of the source.

The leak was reproduced in a VM on dsa_loop, with a local change that
adds empty port_lag_join and port_lag_leave ops to dsa_loop:

  ip link add br0 type bridge
  for i in $(seq 70); do
    ip link add bond1 type bond mode balance-xor
    ip link set bond1 master br0
    ip link set lan2 master br0 || break
    ip link set lan1 down; ip link set lan1 master bond1
    ip link set lan2 nomaster; ip link set lan1 nomaster
    ip link del bond1
  done

Without the fix, the join of lan2 fails with EBUSY in round 64. With
the fix, all 70 rounds pass. No kernel selftest ran, and no frame
went through the bridge in the test.

This patch was prepared with Claude Code (Anthropic). It wrote the
code change, this changelog and the reproducer, and ran the tests in
the VM, under my direction; a separate model instance reviewed the
patch. I reviewed the result and checked the test output.

Fixes: 2f5dc00f7a3e ("net: bridge: switchdev: let drivers inform which bridge ports are offloaded")
Signed-off-by: Koral Ilgun <koral.ilgun@adtran.com>
---
Test: net/main 5677cf0e039b plus the dsa_loop change named above,
x86_64 in QEMU (TCG), dsa_loop with tag protocol none. Without the fix
the join fails in round 64; with the fix all 70 rounds pass, with no
WARNING or BUG in the log. W=1 builds of net/bridge/ with
allmodconfig, allyesconfig and an x86_64_defconfig-based config, and
sparse (C=2), show no new warnings. net/bridge and net/dsa did not
change between the tested base and 639a75a3539f.

Not tested: a frame through the bridge, so also the egress refusal,
the TX forwarding offload path (mv88e6xxx, tag_8021q) and the LAG
leave window; dsa_port_change_conduit(); other drivers that call
switchdev_bridge_port_unoffload() (mlxsw, ocelot, lan966x, prestera,
dpaa2-switch, sparx5, rocker, am65-cpsw-nuss, cpsw_new); team; the
kernel selftests; lockdep, KASAN and KCSAN.

nbp_switchdev_frame_mark() and nbp_switchdev_allowed_egress() keep
plain reads of p->hwdom: each mix of the old and the new hwdom gives
the result of one of the two states.

Stable: the patch does not apply before v7.2, because of f76ae12b6ba3
("net: bridge: use atomic ops to read/change p->flags (III)"). Older
trees need a backport of the first hunk.

 net/bridge/br_switchdev.c | 56 ++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 10f3aea6a1f8..7b368fa82f76 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -11,17 +11,33 @@
 
 static struct static_key_false br_switchdev_tx_fwd_offload;
 
-static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
-					     const struct sk_buff *skb)
+/*
+ * Returns the hwdom of the egress port if the frame can use TX forwarding
+ * offload to it, or 0.
+ */
+static int nbp_switchdev_tx_fwd_hwdom(const struct net_bridge_port *p,
+				      const struct sk_buff *skb)
 {
+	int hwdom;
+
 	if (!static_branch_unlikely(&br_switchdev_tx_fwd_offload))
-		return false;
+		return 0;
 
 	if (br_multicast_igmp_type(skb))
-		return false;
+		return 0;
+
+	if (!test_bit(BR_TX_FWD_OFFLOAD_BIT, &p->flags))
+		return 0;
+
+	/*
+	 * nbp_switchdev_del() clears the hwdom before the flag, while the
+	 * port can stay in the bridge.
+	 */
+	hwdom = READ_ONCE(p->hwdom);
+	if (hwdom == BR_INPUT_SKB_CB(skb)->src_hwdom)
+		return 0;
 
-	return test_bit(BR_TX_FWD_OFFLOAD_BIT, &p->flags) &&
-	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
+	return hwdom;
 }
 
 bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb)
@@ -41,7 +57,7 @@ void br_switchdev_frame_set_offload_fwd_mark(struct sk_buff *skb)
 void nbp_switchdev_frame_mark_tx_fwd_offload(const struct net_bridge_port *p,
 					     struct sk_buff *skb)
 {
-	if (nbp_switchdev_can_offload_tx_fwd(p, skb))
+	if (nbp_switchdev_tx_fwd_hwdom(p, skb))
 		BR_INPUT_SKB_CB(skb)->tx_fwd_offload = true;
 }
 
@@ -53,8 +69,10 @@ void nbp_switchdev_frame_mark_tx_fwd_offload(const struct net_bridge_port *p,
 void nbp_switchdev_frame_mark_tx_fwd_to_hwdom(const struct net_bridge_port *p,
 					      struct sk_buff *skb)
 {
-	if (nbp_switchdev_can_offload_tx_fwd(p, skb))
-		set_bit(p->hwdom, &BR_INPUT_SKB_CB(skb)->fwd_hwdoms);
+	int hwdom = nbp_switchdev_tx_fwd_hwdom(p, skb);
+
+	if (hwdom)
+		set_bit(hwdom, &BR_INPUT_SKB_CB(skb)->fwd_hwdoms);
 }
 
 void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
@@ -221,10 +239,14 @@ static int nbp_switchdev_hwdom_set(struct net_bridge_port *joining)
 	struct net_bridge_port *p;
 	int hwdom;
 
-	/* joining is yet to be added to the port list. */
+	/*
+	 * joining can already be in the port list, and so can another port
+	 * that stopped the offload but stays a member. Both have no hwdom.
+	 */
 	list_for_each_entry(p, &br->port_list, list) {
-		if (netdev_phys_item_id_same(&joining->ppid, &p->ppid)) {
-			joining->hwdom = p->hwdom;
+		if (p->hwdom &&
+		    netdev_phys_item_id_same(&joining->ppid, &p->ppid)) {
+			WRITE_ONCE(joining->hwdom, p->hwdom);
 			return 0;
 		}
 	}
@@ -234,7 +256,7 @@ static int nbp_switchdev_hwdom_set(struct net_bridge_port *joining)
 		return -EBUSY;
 
 	set_bit(hwdom, &br->busy_hwdoms);
-	joining->hwdom = hwdom;
+	WRITE_ONCE(joining->hwdom, hwdom);
 	return 0;
 }
 
@@ -243,9 +265,9 @@ static void nbp_switchdev_hwdom_put(struct net_bridge_port *leaving)
 	struct net_bridge *br = leaving->br;
 	struct net_bridge_port *p;
 
-	/* leaving is no longer in the port list. */
+	/* leaving is still in the port list if it stays a member. */
 	list_for_each_entry(p, &br->port_list, list) {
-		if (p->hwdom == leaving->hwdom)
+		if (p != leaving && p->hwdom == leaving->hwdom)
 			return;
 	}
 
@@ -304,8 +326,10 @@ static void nbp_switchdev_del(struct net_bridge_port *p)
 	if (p->offload_count)
 		return;
 
-	if (p->hwdom)
+	if (p->hwdom) {
 		nbp_switchdev_hwdom_put(p);
+		WRITE_ONCE(p->hwdom, 0);
+	}
 
 	if (test_bit(BR_TX_FWD_OFFLOAD_BIT, &p->flags)) {
 		clear_bit(BR_TX_FWD_OFFLOAD_BIT, &p->flags);

base-commit: 639a75a3539f621e4437ffeec7ab51bf8a1fb170
-- 
2.43.0

