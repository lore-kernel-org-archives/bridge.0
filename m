Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C9228394
	for <bridge@lists.linux.dev>; Thu, 19 Dec 2024 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626198; cv=none; b=Z+tBFbzMKyD6FpSHNU1cjscczNe35RgDhjNvpszlrVNAS6B3vDAS+QcHWJt0HT8OD4AzkG6+Y6k25MrETxhuAsUSEoHRAFobBzLXOcuNt6efi0/X4qW2H3BTo4rTZ2aGgwTQNnLtjw0y1mKMKqFpIVxXUb908tXcW7gCrJQR+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626198; c=relaxed/simple;
	bh=ARciHR9w73NncNjosuJjJlSv3wEKajijBWgVail7p4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phzbHFvCAG6NQC3be3Mv+cbxYSrOJPuqa/BhIIwgZilBHK8Vh0atfU2nvinNbHuZoRJfig71gHtrlDflJvnYMQEL0EFrvTcGu5+W8KkEk4UCoW6w4pMYZdinVg2H9G8N0MoUPOmeMqScu2wYFNJm6QJ/Eb+srHg0NaNkIj9iiB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOSAJOHd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOSAJOHd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734626196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idmZoCTLn7OzY6WY/y1BudxirsfM0U1hq26FcbVU7Co=;
	b=GOSAJOHdCkFF0dgekRlz37pJ6UCWxu3mXVUPkLvanbplHNzwvQjAwfzFJSwrEUQqdXtwBg
	TwkEesR8O5nj8dGYjgi5bPG6PxMzm5/116wze1HyxUBHJk0NF8ud84HitQuGDIY6dIrCaU
	qVktc7mSVhtO/nDpAKgsz2dPXNtbg94=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-YsRBPGmzNQa4J2geLfnRQw-1; Thu,
 19 Dec 2024 11:36:30 -0500
X-MC-Unique: YsRBPGmzNQa4J2geLfnRQw-1
X-Mimecast-MFC-AGG-ID: YsRBPGmzNQa4J2geLfnRQw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DD0819560A3;
	Thu, 19 Dec 2024 16:36:27 +0000 (UTC)
Received: from thinkpad-p1.localdomain.com (unknown [10.22.81.102])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3C50195605F;
	Thu, 19 Dec 2024 16:36:24 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>,
	Roopa Prabhu <roopa@nvidia.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net-next v3 1/2] net: vxlan: rename SKB_DROP_REASON_VXLAN_NO_REMOTE
Date: Thu, 19 Dec 2024 11:36:05 -0500
Message-ID: <20241219163606.717758-2-rrendec@redhat.com>
In-Reply-To: <20241219163606.717758-1-rrendec@redhat.com>
References: <20241219163606.717758-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The SKB_DROP_REASON_VXLAN_NO_REMOTE skb drop reason was introduced in
the specific context of vxlan. As it turns out, there are similar cases
when a packet needs to be dropped in other parts of the network stack,
such as the bridge module.

Rename SKB_DROP_REASON_VXLAN_NO_REMOTE and give it a more generic name,
so that it can be used in other parts of the network stack. This is not
a functional change, and the numeric value of the drop reason even
remains unchanged.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 drivers/net/vxlan/vxlan_core.c | 4 ++--
 drivers/net/vxlan/vxlan_mdb.c  | 2 +-
 include/net/dropreason-core.h  | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0c356e0a61ef0..05c10acb2a57e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2798,7 +2798,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			dev_dstats_tx_dropped(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
-			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
+			kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
 			return NETDEV_TX_OK;
 		}
 	}
@@ -2821,7 +2821,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (fdst)
 			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
 		else
-			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
+			kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
 	}
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 8735891ee1286..816ab1aa05262 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1712,7 +1712,7 @@ netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
 		vxlan_xmit_one(skb, vxlan->dev, src_vni,
 			       rcu_dereference(fremote->rd), false);
 	else
-		kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
+		kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
 
 	return NETDEV_TX_OK;
 }
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index ead4170a1d0a9..6e32106d72294 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -106,7 +106,7 @@
 	FN(VXLAN_VNI_NOT_FOUND)		\
 	FN(MAC_INVALID_SOURCE)		\
 	FN(VXLAN_ENTRY_EXISTS)		\
-	FN(VXLAN_NO_REMOTE)		\
+	FN(NO_TX_TARGET)		\
 	FN(IP_TUNNEL_ECN)		\
 	FN(TUNNEL_TXINFO)		\
 	FN(LOCAL_MAC)			\
@@ -497,8 +497,8 @@ enum skb_drop_reason {
 	 * entry or an entry pointing to a nexthop.
 	 */
 	SKB_DROP_REASON_VXLAN_ENTRY_EXISTS,
-	/** @SKB_DROP_REASON_VXLAN_NO_REMOTE: no remote found for xmit */
-	SKB_DROP_REASON_VXLAN_NO_REMOTE,
+	/** @SKB_DROP_REASON_NO_TX_TARGET: no target found for xmit */
+	SKB_DROP_REASON_NO_TX_TARGET,
 	/**
 	 * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
 	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
-- 
2.47.1

