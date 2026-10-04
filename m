Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F84C4AA033
	for <bridge@lists.linux.dev>; Sun,  4 Oct 2026 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791149086; cv=none; b=tBhFPwL/h1tRzMXnPIJOqRgH0EWGQszogNLs9Jrhgx+zQFtZs4LrGXqiNmEfF8soVgHEbsnwyuiELimfLFgdlmMVJdyJ4TEW3OoYuzChCAyx6GgKGfUjTDcubAWtAr6ZnBtMSXtMxUPAQOOsWswVrsEgSHuWYvYzBIbmXzoVafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791149086; c=relaxed/simple;
	bh=yd3SvQ1usHAP4aqbb+hfLrE84zju6x7zQRRGsOcQdx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1jipzTXZw49oKBXYefztorYcXX8gWty57qchRFzs0LnA3epLn/RGQ8kBq1PWalwvzAE2zYnDvpUT5KARMRzoSoB9vlcixgyLVC4UUC9gDBKi7GibLYLWhllAEwDXJ3Y9p41sLjKFCcBcvxX5M8Bie8YKCqvFsQmgIDVngnShPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2i5KglM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2i5KglM"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso5525785e9.1
        for <bridge@lists.linux.dev>; Sun, 04 Oct 2026 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791149082; x=1791753882; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hrVnCdYeysPlKE3eqVZUbon5985jaaujr6rHDKXwGGE=;
        b=q2i5KglMsXl3LEDdYM02cTuVUK2PyimvJ/PRQLhZGngBXyVfBkeOqjZu3+ALjqRqpC
         JXCrUyhpQMs+1a7qQS3kO2vmhZo8ryvgpnfCGk66ii7U1JdX2sedM/1+LwLTmTU9dJBd
         zNCUu6fBXAaK+DWnCn0wzbFYYCnZaa5nEQeQs/8dNSux1r4YHZ4igpiMPU9YX51P1FbA
         3aDtJ33zSZo2d6dxSN8utAvBhKzv7WulXWBpBKf2GebIe054COpLZjFylyDOdQkTbD+y
         GCYY2OX6XscZVS+aiyce9e1YZggyMvVbOLhDq9jTk5xWFI7SRfok21nbLb/3cCNZvNlV
         80Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791149082; x=1791753882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hrVnCdYeysPlKE3eqVZUbon5985jaaujr6rHDKXwGGE=;
        b=OTNzgwrIlEA3c3ol9Mub0fiajeZt95J0COuplFPlT7vagjVIL39nlzffnqGveKs5Ob
         XgOra+uqQwTc6tWoi/aX5lVGMm2Mok3yX+UEl8kKrpVTut7CQsism5qgQtzGkNiIu4w+
         qIlSnYBHNEzgCM8rTBrqgbM1VB1zkZsWTrBt5A7LcPcCWbvPMUoOC0OhuBHrRZ5QkUVf
         oAaHuhq4Al9oTyF5A2fcve+y9ix8K8JDhq/72fpCI9xm3AtgZb7hUNQjbsLYhiSiEUzv
         Me29eBtcD7J+dN6Tq3vjlWm4RBzWPfcAFaFENSY5UeOH8J+131x6kYrejUy427FW1T5m
         TbeQ==
X-Forwarded-Encrypted: i=1; AKwUvByDk49h6MfDhc0o+LadiAOys2JaiBA+FgYshi2SnWa7vMX4q1jayKOHidYQJtLruT5Wx4N//V8=@lists.linux.dev
X-Gm-Message-State: AFuF++nLoQSpYuyJeKb8jzA+Gz0fdh5WEIfDARkF6TMWtIjTTSFfIvYr
	4GsxQ0K8nh3IoU9joERAp8fNjZ4J8B71G9FmfI4krsohVdntzZIIcL5R
X-Gm-Gg: AYBFou0nNZsTthFi4MmUYBiMugqPP1K9bCfch3IDOx0jUqaD+GHNBzMcH2wW6+N4vL9
	8DMbbkxeO23dKE+rBSDQhIShCq2mc2Rs2UXcyd2qrWA/ZCIkb+IyNjmCbfka+I2jefylBFtehe/
	Y+8+hwZAk08QByzhqTkH2GPidy97jH6b+T/PknGs8SwpVwGEzTCno3EWLGJh9MiF6V+cU2VN3jt
	tE2Zn7rl8iTiev8dMOHrEZVZnlyuyLP6MFjYQAFkgoTBWOULA69oTh3vdy1LH0k/P2FDuGfVXsr
	Ih8a8B07fESoiWvAgEPsFB4jzAMQBCNhqVTymd2lXxy7nnOP717rbmaJucKxLEFCxbpzXd7MPC7
	kqUHn72h3G5MdqedTF6k+Qe6fRzz2LWUi83mLw1WEQJiUus1mklhubos/05Rd82mf+u9Bq6Cy/m
	0SDUrlSOvKrGxRNBC6MnT45TF8zAGnBM4f8RVdq0pAoLHV0t8fH306fHyny5dkwEHX/VVfxURMd
	oQOBtNz/y1DTWM3bWIG6W71qPa6mmW1ipQs1QToBUtP6/N8lQ==
X-Received: by 2002:a05:600c:548e:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4a168106b7bmr77512805e9.33.1791149081734;
        Sun, 04 Oct 2026 14:24:41 -0700 (PDT)
Received: from andreayoga.localdomain ([195.122.200.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104417sm20407354f8f.27.2026.10.04.14.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 14:24:41 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bernhard Thaler <bernhard.thaler@wvnet.at>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH nf v2 1/2] netfilter: br_netfilter: restore VLAN tag on refragmented IPv6 packets
Date: Sun,  4 Oct 2026 23:24:27 +0200
Message-ID: <20261004212429.3648-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004212429.3648-1-parri.andrea@gmail.com>
References: <20261004212429.3648-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bridged IPv6 packets can lose their VLAN tag or acquire an unrelated tag
when conntrack-reassembled packets are refragmented. On a VLAN-aware
bridge, or on any bridge with bridge-nf-filter-vlan-tagged enabled, this
can send fragments with a different VLAN tag from the one selected for
forwarding.

br_nf_push_frag_xmit() restores the VLAN tag from per-CPU storage, but
only the IPv4 branch of br_nf_dev_queue_xmit() saves it. The IPv6 branch
leaves the saved tag from the previous IPv4 refragmentation on that CPU.
Newly allocated fragments do not inherit the tag through
ip6_copy_metadata().

Commit d7b597421519 ("netfilter: bridge: restore vlan tag when
refragmenting") added VLAN tag restoration for IPv4 only, shortly after
IPv6 refragmentation was introduced.

This was reproduced on a VLAN-aware bridge by first refragmenting an IPv4
VLAN 100 flow on the same CPU. All fragments of subsequent IPv6 flows left
with stale VLAN 100 instead of the VLAN selected for their egress ports.

Move saving the L2 header and VLAN tag into br_nf_save_frag_data() and
call it from both branches, so the fragments that ip6_fragment() builds
use the current packet's VLAN information.

Fixes: efb6de9b4ba0 ("netfilter: bridge: forward IPv6 fragmented packets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 net/bridge/br_netfilter_hooks.c | 45 +++++++++++++++------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0a394e5f43916..fe8d2910dae21 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -832,6 +832,25 @@ static unsigned int nf_bridge_mtu_reduction(const struct sk_buff *skb)
 	return 0;
 }
 
+/* Saved for br_nf_push_frag_xmit() to restore on every fragment. */
+static void br_nf_save_frag_data(const struct sk_buff *skb)
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

