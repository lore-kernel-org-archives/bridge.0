Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258993F7AAC
	for <bridge@lists.linux.dev>; Mon, 28 Sep 2026 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584462; cv=none; b=A7hA1iN0ZmDliEP/ujeEBQV4ekEIH/nDj01fh1qGpt8mDjjjcmV4U/+kJfwbZX5/0SzscH8ZWwPyaScgx/KiUbTY0sEQdRwYm/kqraJ2/OlnqzWoukU1qhhVWBjIzXZr7Ie0mKD6C39/fgfkMRJKEvaqzWUevJMwVs6eJ6lypw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584462; c=relaxed/simple;
	bh=mR+r3uGBzJtrwy13qloZwh2TNqoWWjI2DQS3mzd64FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxI8JHBYOTQQNFhmzlD/E0u3wctD3ia6RCVlS3YJS82RsdpRe1kg3vUbdCO/+kRWgbeB/Y2No5o4a+uKSir5lFTbPc2+1y5hfX6oCj6kpD8hISVxyf8IAaE3nfh8WslRvdblZQO2EIe2NSvF6cbsie3+zviIAMkTf/+IzQ8zb18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=ZG53DtjE; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="ZG53DtjE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790584457; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=38M1SpqtY4Y4kGGMo4lFDwqzGnfS5lW46jvslGgoIXE=;
	b=ZG53DtjEgH/dw7o/bDhYyRZPgjslx2nnA5XXIuyOnQKohEHna7R7DncROdb8Xbsye5aEnzrU65mQxjczF6jZXAuCG1p69doEVvuozE4jDx7qAgBNlBzUqDSf97y0t/iPjgs3yGV7JFUGNxsLMhNlNjvxRl8cgGjLHqtOX32MVew=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07440555|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.228353-0.00216327-0.769483;FP=18347645252747136519|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jQ0CZhn_1790584138;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jQ0CZhn_1790584138 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 16:28:59 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: ebtables: ebt_802_3: drop short frames before the match reads LLC
Date: Mon, 28 Sep 2026 16:28:58 +0800
Message-ID: <20260928082858.3009191-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ebt_802_3_mt() takes the frame pointer from skb_mac_header() and reads
the LLC union fields (dsap, ssap, ctrl, type) without making sure that
those bytes are in the linear area. For an 802.3 frame (length field
below 1536) the payload is LLC, but only ETH_HLEN bytes are guaranteed
linear by the time the bridge hooks run, and neither ebt_do_table() nor
ebt_basic_match() pulls more.

A frame that carries nothing past the 14 byte Ethernet header therefore
reads into the skb tailroom. Check that sizeof(struct ebt_802_3_hdr)
bytes are actually linear before reading, and drop the packet through
par->hotdrop when they are not, the same signalling other ebt matches
use for a packet they cannot examine.

No Fixes tag. The unchecked skb_mac_header() dereference comes from the
initial ebtables merge and has not been touched since.

Reviewed-by: Liu Chao <liuc63@xiaopeng.com>
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
 net/bridge/netfilter/ebt_802_3.c | 36 +++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/net/bridge/netfilter/ebt_802_3.c b/net/bridge/netfilter/ebt_802_3.c
index 68c2519bd..533f0d36e 100644
--- a/net/bridge/netfilter/ebt_802_3.c
+++ b/net/bridge/netfilter/ebt_802_3.c
@@ -14,27 +14,43 @@
 #include <linux/skbuff.h>
 #include <uapi/linux/netfilter_bridge/ebt_802_3.h>
 
-static struct ebt_802_3_hdr *ebt_802_3_hdr(const struct sk_buff *skb)
-{
-	return (struct ebt_802_3_hdr *)skb_mac_header(skb);
-}
-
 static bool
 ebt_802_3_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct ebt_802_3_info *info = par->matchinfo;
-	const struct ebt_802_3_hdr *hdr = ebt_802_3_hdr(skb);
-	__be16 type = hdr->llc.ui.ctrl & IS_UI ? hdr->llc.ui.type : hdr->llc.ni.type;
+	struct ebt_802_3_hdr _frame;
+	const struct ebt_802_3_hdr *frame;
+	int mac_offset = skb_mac_offset(skb);
+	__be16 type;
+
+	/* skb->data sits past the Ethernet header when the match runs, so the
+	 * frame starts before skb->data. skb_header_pointer() takes an offset
+	 * relative to skb->data and cannot express that, so check the linear
+	 * area against the mac header ourselves and use skb_mac_header()
+	 * directly once the check has passed.
+	 */
+	if (mac_offset < 0)
+		mac_offset = -mac_offset;
+	if (mac_offset + sizeof(_frame) > skb_headlen(skb)) {
+		/* The frame is too short to hold an LLC header. */
+		par->hotdrop = true;
+		return false;
+	}
+
+	frame = (const struct ebt_802_3_hdr *)skb_mac_header(skb);
+	type = frame->llc.ui.ctrl & IS_UI ? frame->llc.ui.type :
+					    frame->llc.ni.type;
 
 	if (info->bitmask & EBT_802_3_SAP) {
-		if (NF_INVF(info, EBT_802_3_SAP, info->sap != hdr->llc.ui.ssap))
+		if (NF_INVF(info, EBT_802_3_SAP, info->sap != frame->llc.ui.ssap))
 			return false;
-		if (NF_INVF(info, EBT_802_3_SAP, info->sap != hdr->llc.ui.dsap))
+		if (NF_INVF(info, EBT_802_3_SAP, info->sap != frame->llc.ui.dsap))
 			return false;
 	}
 
 	if (info->bitmask & EBT_802_3_TYPE) {
-		if (!(hdr->llc.ui.dsap == CHECK_TYPE && hdr->llc.ui.ssap == CHECK_TYPE))
+		if (!(frame->llc.ui.dsap == CHECK_TYPE &&
+		      frame->llc.ui.ssap == CHECK_TYPE))
 			return false;
 		if (NF_INVF(info, EBT_802_3_TYPE, info->type != type))
 			return false;
-- 
2.50.1

