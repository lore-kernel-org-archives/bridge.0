Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108D30BBB9
	for <bridge@lists.linux.dev>; Tue, 24 Feb 2026 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916001; cv=none; b=M+WGpn3SQ27x5hOF07ZsOnwCTUEr3ITnRAAhezd2oRxPe308C0GAFssqUERt/h8DL/lfQM152QLC6To7r9HV5GO4eAT5JjC+pA7UmsJDwm3CLGcmMNogN3OmHPehcNaGOFDPjt5+gNvkTA5JFanm1biTFd+f6K9C4EQlJFLQjn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916001; c=relaxed/simple;
	bh=MgqFP+kEIYkaJNFbJG3TL6RfVtetCetfNmpFyY7dGco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lkf5p7AOXmsxpRNAzAVvluCM1oAy0vrQCCWW5IdXUXMbMiJyxQYJan7m/U/5+2pQSFiTBGN2avuW2NtKAE5IP91+cxioSqv3VfwMQ2Qf/nWVOtW6fCJZ40nRmoctbmOMoj5qO4vjOeEG+T4vCYQ+oVVokM6P5N7owsBqG+WRhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DH1HKpWN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH1HKpWN"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65a26c220b6so6577082a12.0
        for <bridge@lists.linux.dev>; Mon, 23 Feb 2026 22:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771915998; x=1772520798; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+3Us/40ma9gw7n/u08hiyPrq5670jVo0kM4Qwre1Os=;
        b=DH1HKpWN4cdR3Ps9CsysY484XzQeX+0lbwhIxTx+Az/2Ca+iRVplUvvqP+P4owDNiG
         lv3ia4mhFUNnNoOoJ/31P9SYB9OTHi3OwqcJZ9Kt6kfnVJF64JirWORYvjK1gzJw86wS
         7JG0zjCiUUicteo7+Thf9g6Y2ZLvUscMML0OhLlIWzlPs8wGFtSgSEMjrOQHe74fEuV+
         pjdYoO7zxd0JuUIDwKNfzycO4l9gUpZWqRacLAkt+f5IvYTdubelCWWBRTSSD209Wrut
         pMuhGLcMuw0brebkN/eJMkdvkYGap+KMfH/lRDAoxx1JsbrTW3uili6giKlnTFh7br/l
         3jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771915998; x=1772520798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+3Us/40ma9gw7n/u08hiyPrq5670jVo0kM4Qwre1Os=;
        b=NUy1yW5VswAQDoJIQx8A7uOywDtWDP8WeD+Qvy6euI4Xe8xZ2lzDejqwi4w6MTukPm
         wCsOmwb3uAdrye4eDyFjFtxNbxR/xLMQhsT3s0CEWJzhyPTxLHXuE5S7+F2GoR/7QrHx
         F36zVhFyxQ4WKcXyd7jbqAPNlmXRjZCLNCyVHWKTaUmQDwPD8wzfz+YL8rryF1XY5lNN
         EgKLEMqX7zTT4p+mmaGmloQhUf9GMEF8h6yZbSYHkdEAtcwRo/3qedbCTLNUthUpyRzX
         ezjngxRZCJW7tRljJVTSFS/OPaJDWH3dM7E3I5JSBifS8p5p8yYuAwgBshpk+PWEDYHI
         xa0g==
X-Forwarded-Encrypted: i=1; AJvYcCWjiOHUuJX6MTpJ8L4U5HhYeLiidhkmMOVfp1ma371VQZNGnXCPGBmcVPpSlNRMFUUIytyi8E8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzeJ8ldgay5ScvDdVl+BUmvfprY2bPKQKIfiF1CKkBeQucyJ7ns
	Oqrfn+WzULQNxtpb0aNPVOyFjJAqvBaVd1Sa2xquxxkU46YMRw7oakH4
X-Gm-Gg: ATEYQzyYDdkiIC5slR2n40lAEEwrcRJbq3Lqy6L9lLJrtKjZqE+6CO0tnqCWsb5fcuT
	hvaq4bGa32cLCHO5Udx5qYZg7VlaKvHdIkh4/vSCftQBwBPA2V0j/Gtip8D31cklxskXz/sXJfW
	f4Ko+DHTuDAKAtN/aDq9dL8UB/YzlivgKtiAYH6iP1TakKRP92ZX7mPYlueQ5yb0eoMDdFyHQVD
	SSiqduJfxnQHxOMNqCMmgQ8HLxwhIiOQcfsWAH3DTq3sGPUa3GJV8fT2VXNl4VK3/SDBo2sGHeA
	vppkKEBrcz0V/QUiYUze4TuleCFqWrYoXsmJoLU7W9pnF8FY2rZsZUTkrTmd6nKIaCj1zoy7nfc
	16RxJHjkWZb3DyMKCEdPp/U/3wGBhXyKbMWH8dVpFUO6IDzHZwcDgviyvn5mb9sTKKhv7lo95T/
	ArQeQZH0H8FkATj8Lwv57aR7OFTf/d2RPk+WWDcvUkp8JEOcAmV/d2hr3BhZcEPK78d/szMBMWf
	mnUbKErLifjy0ls2zmqP4FDFwA45XYPQ2VqyVn+7hnaEBHEMqucm00=
X-Received: by 2002:a05:6402:440a:b0:65a:4202:640b with SMTP id 4fb4d7f45d1cf-65ea4ef5ff8mr6889632a12.19.1771915997684;
        Mon, 23 Feb 2026 22:53:17 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eaba13866sm3096698a12.18.2026.02.23.22.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:53:16 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v19 nf-next 3/5] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Tue, 24 Feb 2026 07:53:04 +0100
Message-ID: <20260224065307.120768-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224065307.120768-1-ericwouds@gmail.com>
References: <20260224065307.120768-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a bridge, until now, it is possible to track connections of plain
ip(v6) and ip(v6) encapsulated in single 802.1q or 802.1ad.

This patch adds the capability to track connections when the connection
is (also) encapsulated in PPPoE. It also adds the capability to track
connections that are encapsulated in an inner 802.1q, combined with an
outer 802.1ad or 802.1q encapsulation.

To prevent mixing connections that are tagged differently in the L2
encapsulations, one should separate them using conntrack zones.
Using a conntrack zone is a hard requirement for the newly added
encapsulations of the tracking capability inside a bridge.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 93 ++++++++++++++++++----
 1 file changed, 76 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 58a33d0380b0..49e01083278c 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -16,6 +16,7 @@
 #include <net/netfilter/nf_conntrack_helper.h>
 #include <net/netfilter/nf_conntrack_bridge.h>
 
+#include <linux/ppp_defs.h>
 #include <linux/netfilter_ipv4.h>
 
 #include "../br_private.h"
@@ -236,58 +237,116 @@ static int nf_ct_br_ipv6_check(const struct sk_buff *skb)
 	return 0;
 }
 
+static int nf_ct_bridge_pre_inner(struct sk_buff *skb, __be16 *proto, u32 *len)
+{
+	switch (*proto) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph;
+
+		if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
+			return -1;
+		ph = (struct ppp_hdr *)(skb->data);
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			*proto = htons(ETH_P_IP);
+			*len = ntohs(ph->hdr.length) - 2;
+			skb_set_network_header(skb, PPPOE_SES_HLEN);
+			return PPPOE_SES_HLEN;
+		case htons(PPP_IPV6):
+			*proto = htons(ETH_P_IPV6);
+			*len = ntohs(ph->hdr.length) - 2;
+			skb_set_network_header(skb, PPPOE_SES_HLEN);
+			return PPPOE_SES_HLEN;
+		}
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr;
+
+		if (!pskb_may_pull(skb, VLAN_HLEN))
+			return -1;
+		vhdr = (struct vlan_hdr *)(skb->data);
+		*proto = vhdr->h_vlan_encapsulated_proto;
+		skb_set_network_header(skb, VLAN_HLEN);
+		return VLAN_HLEN;
+	}
+	}
+	return 0;
+}
+
 static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 				     const struct nf_hook_state *state)
 {
 	struct nf_hook_state bridge_state = *state;
+	int ret = NF_ACCEPT, offset = 0;
 	enum ip_conntrack_info ctinfo;
+	u32 len, pppoe_len = 0;
 	struct nf_conn *ct;
-	u32 len;
-	int ret;
+	__be16 proto;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if ((ct && !nf_ct_is_template(ct)) ||
 	    ctinfo == IP_CT_UNTRACKED)
 		return NF_ACCEPT;
 
-	switch (skb->protocol) {
-	case htons(ETH_P_IP):
-		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+	proto = skb->protocol;
+
+	if (ct && nf_ct_zone_id(nf_ct_zone(ct), CTINFO2DIR(ctinfo)) !=
+			NF_CT_DEFAULT_ZONE_ID) {
+		offset = nf_ct_bridge_pre_inner(skb, &proto, &pppoe_len);
+		if (offset < 0)
 			return NF_ACCEPT;
+	}
+
+	switch (proto) {
+	case htons(ETH_P_IP):
+		if (!pskb_may_pull(skb, offset + sizeof(struct iphdr)))
+			goto do_not_track;
 
 		len = skb_ip_totlen(skb);
-		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+		if (pppoe_len && pppoe_len != len)
+			goto do_not_track;
+		if (pskb_trim_rcsum(skb, offset + len))
+			goto do_not_track;
 
 		if (nf_ct_br_ip_check(skb))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		bridge_state.pf = NFPROTO_IPV4;
 		ret = nf_ct_br_defrag4(skb, &bridge_state);
 		break;
 	case htons(ETH_P_IPV6):
-		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
-			return NF_ACCEPT;
+		if (!pskb_may_pull(skb, offset + sizeof(struct ipv6hdr)))
+			goto do_not_track;
 
 		len = sizeof(struct ipv6hdr) + skb_ipv6_payload_len(skb);
-		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+		if (pppoe_len && pppoe_len != len)
+			goto do_not_track;
+		if (pskb_trim_rcsum(skb, offset + len))
+			goto do_not_track;
 
 		if (nf_ct_br_ipv6_check(skb))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		bridge_state.pf = NFPROTO_IPV6;
 		ret = nf_ct_br_defrag6(skb, &bridge_state);
 		break;
 	default:
 		nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
-		return NF_ACCEPT;
+		goto do_not_track;
 	}
 
-	if (ret != NF_ACCEPT)
-		return ret;
+	if (ret == NF_ACCEPT)
+		ret = nf_conntrack_in(skb, &bridge_state);
+
+do_not_track:
+	if (offset && ret == NF_ACCEPT)
+		skb_reset_network_header(skb);
 
-	return nf_conntrack_in(skb, &bridge_state);
+	return ret;
 }
 
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
-- 
2.53.0

