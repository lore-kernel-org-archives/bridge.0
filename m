Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8844DA9DD
	for <bridge@lists.linux.dev>; Mon, 28 Sep 2026 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612325; cv=none; b=E1j/WlPCMpTHr2QXNdqxWypifqyuu/sxxC0YWRL0sRmjoexzm3QYrBwmJFxXLrJs7fi4vICoN1T2cZt1q67ALfLaMpqqgJWb7wifhP6LO0NtZp47zpLl3z91IuFkUcVBccxn1XaAR+4Dmw75417Y+ZfOztRid1DA3mPayosozyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612325; c=relaxed/simple;
	bh=AOO/rNbtYn/XV+z6aJLsYODwFNDUGFoFh+PHNDW0M2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/U7EVS/wv93lA/Kz+KxBu9v2sRv2Ol15ElnSm/8a8M4lz3nNjhfxuPmj9BAOE5GYg4tXGB4x+sncy+GPQWGp1YiKbjxhyM8DFe9vdiOp7ooTVkZkPaq0QdYpLeKgQQS6IwV+obLsZhR2lFVoTmmjb8DR/JnoQuza6+f6GJUjtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lshTy4qe; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lshTy4qe"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so17951145e9.3
        for <bridge@lists.linux.dev>; Mon, 28 Sep 2026 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612321; x=1791217121; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GSDv0oMqDQGMqVMxgulpjHU/XgBmZQ/St3zf1qwBsuM=;
        b=lshTy4qe5SryremLS6RBhaujvdYOnUZb1Pj5km7kA24Ae8oMYu48xxQIsZlakhLgQd
         pctVKKsrYLJXdte+2kk4X4iJlVErMPE4qxRTUjPtImsflAKFP+FCcu5zVo/l3TJKD9oy
         DXe3Y4GHrodt05z2ch8tqutLBr8mIbMOs4kNE1HHtqiGU9L13Lxdi0ABcy/0KCSJbCZq
         dPam/DTGlTk59/vi+YdT9HIQW2ZDw4ku5cHiblaA4t43x0lCBRFDit41PBhuBraGNBrS
         vZVbQU4Dm+lLF6LrCdSoqtcAwZUGL7wVeOXSmr/GwUb+sRXjbIB/OJjZ0lBfOX6vUwZZ
         9GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612321; x=1791217121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GSDv0oMqDQGMqVMxgulpjHU/XgBmZQ/St3zf1qwBsuM=;
        b=2fS+u1P/DKppmCUqquLYacLKgr/hitbTHoCk+X80p1tB21khkvIBbv4jfl2Nl13SsJ
         KXyR3AD4gNIJS4n8IstrXowyLW78Wd0G9Oh6MZugg+bgMumkYhfxgPg0t7/Q9zp1YA5H
         ENisaNzxWZHgzuQcy0WgrzQh15TIhNryuu9L8ov/6+Olpi9NxeoqmqMY/IvAF9+Qixyw
         UrvMOjwHdh1sGlvSH0jXafXm5mVx1M3Yqi/N7f4HoXW1zGlf58Wfpog8KEe3kAYwesUS
         gFetI88/+FBSwtKaAuJOSnMOsL/YPe0wtAFW/wGwcShWwgVuI82wDbiLyaLOaY0NFFmA
         LG+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwuOfstEAI0sQCnOb9mpfyBVvG0kNJtYvyhRWNCvw7MeC65O8P4OJwZU6FJxT0Go6pJuyqMeKQ=@lists.linux.dev
X-Gm-Message-State: AFuF++m3Ayx7MbwpASIhchnUu49K9Y1H6SVu0TNrb5gJmrP7qzMd3wqw
	hRzTAQDyr1SUNlCuzIaxg0W9xVfe/FiTj+oNQKqGX1AfHuLgBFm8Ya/4
X-Gm-Gg: AYBFou0gYriTcOfGavqMBsjieG235LawWXCCdvy7kYgyxoa3veL6hPNdn0fo/FXtKtb
	mjDDqE5evdEVdvKfbSj9MCccd6qBU7t9kE6PlH6Xn4LH7K6uUefMR2bHmB+giOXB2Om/42XSY3/
	NaRFq5od4Wl9w7Nq9lQ23MWrcwJ+s3eL+ndFBXwp9Q5e3AcTXWTU/zSssLDjYsg5p9zEvrWWL0M
	RUyoz/3LcauQfGrf4R1MT2uX6ybwSznMrc/FsoSQPTo5fh/Ro+gRtVeGTBmRmOCljbdwWM2F2Jd
	5E3hvkvX4317uvil4oHA9R+6iCZ6GKC5OmX1cN3bb53AgVudH2yqNY87k4pnxWB0tN+rfhQVUPN
	X1TFDOG4Jhyf92XeZMnlydFpg0MnjwSQEWKb0QJM3zQTwpSBeUwjsR5aVc3Tn1a3Qpmlmuqg27h
	CjKgWqeZMlJXuASLAd+EGjOBowdmtzqRSz162g3Cw5AtEkGAK3aJTvYclcNe9YXiQ+Vi76ADhKA
	DAhD3XTu9ZCi0L+77j1rV27Ye3g/8Lqz9o6Zq5LjvfqpAXXPgY8+Fq7aK3YKRLiUj5/7yT8IlvA
	9SXlNA==
X-Received: by 2002:a05:600c:a30b:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-49ffaa33f7amr92371915e9.13.1790612321314;
        Mon, 28 Sep 2026 09:18:41 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9dfdbsm4813715e9.1.2026.09.28.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:18:40 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH nf] netfilter: br_netfilter: restore VLAN tag on refragmented IPv6 packets
Date: Mon, 28 Sep 2026 18:18:28 +0200
Message-ID: <20260928161830.351199-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bridged IPv6 packets can lose their VLAN tag or acquire an unrelated tag
when conntrack-reassembled packets are refragmented. On a VLAN-aware
bridge, this can send fragments with a different VLAN tag from the one
selected for forwarding.

br_nf_push_frag_xmit() restores the VLAN tag from per-CPU storage, but
only the IPv4 branch of br_nf_dev_queue_xmit() saves it. The IPv6 branch
leaves the saved tag from the previous IPv4 refragmentation on that CPU.
Newly allocated fragments do not inherit the tag through
ip6_copy_metadata().

Commit d7b597421519 ("netfilter: bridge: restore vlan tag when
refragmenting") added VLAN tag restoration for IPv4 only, shortly after
IPv6 refragmentation was introduced.

Move saving the L2 header and VLAN tag into br_nf_save_frag_data() and
call it from both branches, so IPv6 fragments use the current packet's
VLAN information.

Fixes: efb6de9b4ba0 ("netfilter: bridge: forward IPv6 fragmented packets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 net/bridge/br_netfilter_hooks.c | 45 +++++++++++++++------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0a394e5f43916..ec69d6254e340 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -832,6 +832,25 @@ static unsigned int nf_bridge_mtu_reduction(const struct sk_buff *skb)
 	return 0;
 }
 
+/* Fragments may not inherit the MAC header or VLAN tag. */
+static void br_nf_save_frag_data(struct sk_buff *skb)
+{
+	struct brnf_frag_data *data = this_cpu_ptr(&brnf_frag_data_storage);
+
+	if (skb_vlan_tag_present(skb)) {
+		data->vlan_tci = skb->vlan_tci;
+		data->vlan_proto = skb->vlan_proto;
+	} else {
+		data->vlan_proto = 0;
+	}
+
+	data->encap_size = nf_bridge_encap_header_len(skb);
+	data->size = ETH_HLEN + data->encap_size;
+
+	skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
+					 data->size);
+}
+
 static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
@@ -866,28 +885,13 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 	 */
 	if (IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) &&
 	    skb->protocol == htons(ETH_P_IP)) {
-		struct brnf_frag_data *data;
-
 		if (br_validate_ipv4(net, skb))
 			goto drop;
 
 		IPCB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
 		local_lock_nested_bh(&brnf_frag_data_storage.bh_lock);
-		data = this_cpu_ptr(&brnf_frag_data_storage);
-
-		if (skb_vlan_tag_present(skb)) {
-			data->vlan_tci = skb->vlan_tci;
-			data->vlan_proto = skb->vlan_proto;
-		} else {
-			data->vlan_proto = 0;
-		}
-
-		data->encap_size = nf_bridge_encap_header_len(skb);
-		data->size = ETH_HLEN + data->encap_size;
-
-		skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
-						 data->size);
+		br_nf_save_frag_data(skb);
 
 		ret = br_nf_ip_fragment(net, sk, skb, br_nf_push_frag_xmit);
 		local_unlock_nested_bh(&brnf_frag_data_storage.bh_lock);
@@ -895,20 +899,13 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 	}
 	if (IS_ENABLED(CONFIG_NF_DEFRAG_IPV6) &&
 	    skb->protocol == htons(ETH_P_IPV6)) {
-		struct brnf_frag_data *data;
-
 		if (br_validate_ipv6(net, skb))
 			goto drop;
 
 		IP6CB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
 		local_lock_nested_bh(&brnf_frag_data_storage.bh_lock);
-		data = this_cpu_ptr(&brnf_frag_data_storage);
-		data->encap_size = nf_bridge_encap_header_len(skb);
-		data->size = ETH_HLEN + data->encap_size;
-
-		skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
-						 data->size);
+		br_nf_save_frag_data(skb);
 
 		ret = ip6_fragment(net, sk, skb, br_nf_push_frag_xmit);
 		local_unlock_nested_bh(&brnf_frag_data_storage.bh_lock);
-- 
2.53.0

