Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E29502559
	for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745399; cv=none; b=BUAYy4JMjCKjDGBgUgDYWkFjS4dXGsxTg+udsbH3W3vpE6YeQgdZb0gVui/xm22Eke4P1Y1Y1gUoh/+7OExXKfoIlf3BkRW28CY0kZpFLYgOa+TpHkKIYdeakD+aGvYFtV9qq6fGWZpEZpwRfeSwbZmTZRD2qNoWF/nXc1nTreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745399; c=relaxed/simple;
	bh=2EVShEmI/0rJNMpwjpQOmFmP5a9kka8l4gxp8+ZaUpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgIIyS8vFfkFx6ynt+m55ot8NuyCO/7lKgidCqQWXDmLpHktXkmPz0EZSPw8P5P4aYPeaBRr8zSSAwMl6QYIh+RCmbgiIDxy0xrDVykQzz/xM2pubmBkRu0yvVnOGno30LC6454ltui7kcgdETQcTNDS1l2FKe+H5M+OzXE8QWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JGm6e+MI; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JGm6e+MI"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c3ee4cfso495867f8f.2
        for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789745396; x=1790350196; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=96oAyfpjzN0+/Y81mIOKiKNvJ2eV4pXY44RiiIB6xww=;
        b=JGm6e+MItvWpZqnwTne33F2ubMBTf/CgnNmZtA+FrK0GGWo1tW6RJG6pdQBDQU6STm
         aN6AKHoRAcyy3NyOkrZHljV+TAcgHGUh8VcE2cBJ+SIjE7pgjr7vPX8uUggNLrKF7yv8
         IFS1PBEVGSbYWj6Axh61PQsUNvuJFkEBj0RubEGoTjFrtR95/+2D3jNUEIaty7cfiXq+
         aUnuGBMuINCcQad+u5OtK159E6mv9nyKRRg6sFIqlL6kMxTysj4laSOtLxA1GXSP1h/3
         fOl3zyU9OSsqWDXi0nAcnPF7IQ11JqInGaGpMqFPC73eFBhgz73HlsdOiYG5hQJT56JV
         0TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745396; x=1790350196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=96oAyfpjzN0+/Y81mIOKiKNvJ2eV4pXY44RiiIB6xww=;
        b=LLXdOi0MxsWq8wUCT4XXHAjQOHPA8j+s4MQ+egSYYscwIU1mr3kAx82+U77wVrkhPi
         FxsVFChnn7KkyoTeXeUaYcXK5j54w1OdGuYYup766K/Q0l21CllZwoTK5dtkshPJSqQP
         POlC9AaKoOPiHbDS+mhO526+4RF8MRo22UBsup8peVngKDlRhwIcmoS2fGyVzhFb/00H
         e07ph5n+E+srr3l46oao0+CLgnLTlHOss042J/COwtmajw2OcZUYeM8aYBCpTSZljvJU
         maQ60BVF9Q5LTZALOLDgodD/OTbY0QZ6oyxJDaEEjSPgfDgtixd4WnhXmXuxCypN7VU+
         lqvQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQLS9GQI6NheXhlaC6kxCUI3Z0dp1qykQzljzO+Ds9dvUM+EeKn8txZosLoUrfrdQRIVqbQpU=@lists.linux.dev
X-Gm-Message-State: AFuF++kfugVXeI5QUeFSYJWgACz8C4SFHbW9Lq1AP7rROI4SYyOGkMPv
	XQ+ciOfMr8YdsOqeLIQ8MQvDL4WfUvWCJfgsEYvsPkFFqwNDQdAwyTSk/vF77Ez3Kn8=
X-Gm-Gg: AYBFou2ql+mfgsn4mpz5uIsWJOANySFNhMw/Wpd5eDTOGX9JT41rJiNrZ5itYYO5gWh
	+X++ih0LSLRjhhtcjzc4jPyFhwZIiVq+Zhzo+CJrWp5plMfp9zwNNkahbuY7yFmIOwfRebwEB8X
	67h3R/MuH/EhnTg6xGqd5n81Gmb90BhWd06vfoxGnpYTjxvSOOCPWzNKv502TQ9zLat/KEm/Gk2
	ehuMlvJnK6Nvqs3w2b4ecIW/Kb5HK7ySdGKxe6FHZOktt3/bHFeIsTpNIQkAo5gC/SU26gQ2WQu
	rRNXF7MqjEdYSk+ga52i7HGif6adeocobQfJADwFbh/J3U4r9RJSCR2glnyIfc3kUYDq8Z8WDVY
	kSzaTlBpBAAqaThV9BtKzmMiMw4UgrQdDgN9JnGILBXCFrFZgBeGEjx9bwqeUOaqIph5kx9IsNf
	yAoKpdkiGd9IF2bYLBv3rMnCSDiQ2Z9TYsS4ZqUYZS+Y9OdTz4VrC3OnrcSbCTIJeHAMNaHzT9z
	F2DPbdztC2phzMxYrjHrg==
X-Received: by 2002:a05:6000:1acb:b0:487:767:b301 with SMTP id ffacd0b85a97d-4871e387052mr4220968f8f.57.1789745395848;
        Fri, 18 Sep 2026 08:29:55 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4871ff5551fsm4656235f8f.15.2026.09.18.08.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:29:55 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 2/9] net: bridge: factor out port flooding
Date: Fri, 18 Sep 2026 18:29:43 +0300
Message-ID: <20260918152950.1938259-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918152950.1938259-1-razor@blackwall.org>
References: <20260918152950.1938259-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out port flooding code into its own helper, it will be used by later
changes to flood to specific port VLANs. No functional changes intended.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_forward.c | 77 +++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 31d54125b441..a696c6c128e3 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -219,6 +219,48 @@ static void br_flood_finish(struct net_bridge_port *prev, struct sk_buff *skb,
 		__br_forward(prev, skb, local_orig);
 }
 
+static void br_flood_port(struct net_bridge_port **prev,
+			  struct net_bridge_port *p, struct sk_buff *skb,
+			  enum br_pkt_type pkt_type, bool local_orig, u16 vid)
+{
+	/* Do not flood unicast traffic to ports that turn it off, nor
+	 * other traffic if flood off, except for traffic we originate
+	 */
+	switch (pkt_type) {
+	case BR_PKT_UNICAST:
+		if (!test_bit(BR_FLOOD_BIT, &p->flags))
+			return;
+		break;
+	case BR_PKT_MULTICAST:
+		if (!test_bit(BR_MCAST_FLOOD_BIT, &p->flags) &&
+		    skb->dev != p->br->dev)
+			return;
+		break;
+	case BR_PKT_BROADCAST:
+		if (!test_bit(BR_BCAST_FLOOD_BIT, &p->flags) &&
+		    skb->dev != p->br->dev)
+			return;
+		break;
+	}
+
+	/* Do not flood to ports that enable proxy ARP */
+	if (test_bit(BR_PROXYARP_BIT, &p->flags))
+		return;
+	if (BR_INPUT_SKB_CB(skb)->proxyarp_replied) {
+		if (test_bit(BR_PROXYARP_WIFI_BIT, &p->flags))
+			return;
+		/* For gratuitous ARPs/NAs, check neigh_forward_grat.
+		 * For regular ARPs/NDs, check only neigh_suppress.
+		 */
+		if (br_is_neigh_suppress_enabled(p, vid) &&
+		    (!BR_INPUT_SKB_CB(skb)->grat_arp ||
+		     !br_is_neigh_forward_grat_enabled(p, vid)))
+			return;
+	}
+
+	*prev = maybe_deliver(*prev, p, skb, local_orig);
+}
+
 /* called under rcu_read_lock */
 void br_flood(struct net_bridge *br, struct sk_buff *skb,
 	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig,
@@ -230,40 +272,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 	br_tc_skb_miss_set(skb, pkt_type != BR_PKT_BROADCAST);
 
 	list_for_each_entry_rcu(p, &br->port_list, list) {
-		/* Do not flood unicast traffic to ports that turn it off, nor
-		 * other traffic if flood off, except for traffic we originate
-		 */
-		switch (pkt_type) {
-		case BR_PKT_UNICAST:
-			if (!test_bit(BR_FLOOD_BIT, &p->flags))
-				continue;
-			break;
-		case BR_PKT_MULTICAST:
-			if (!test_bit(BR_MCAST_FLOOD_BIT, &p->flags) && skb->dev != br->dev)
-				continue;
-			break;
-		case BR_PKT_BROADCAST:
-			if (!test_bit(BR_BCAST_FLOOD_BIT, &p->flags) && skb->dev != br->dev)
-				continue;
-			break;
-		}
-
-		/* Do not flood to ports that enable proxy ARP */
-		if (test_bit(BR_PROXYARP_BIT, &p->flags))
-			continue;
-		if (BR_INPUT_SKB_CB(skb)->proxyarp_replied) {
-			if (test_bit(BR_PROXYARP_WIFI_BIT, &p->flags))
-				continue;
-			/* For gratuitous ARPs/NAs, check neigh_forward_grat.
-			 * For regular ARPs/NDs, check only neigh_suppress.
-			 */
-			if (br_is_neigh_suppress_enabled(p, vid) &&
-			    (!BR_INPUT_SKB_CB(skb)->grat_arp ||
-			     !br_is_neigh_forward_grat_enabled(p, vid)))
-				continue;
-		}
-
-		prev = maybe_deliver(prev, p, skb, local_orig);
+		br_flood_port(&prev, p, skb, pkt_type, local_orig, vid);
 		if (IS_ERR(prev))
 			break;
 	}
-- 
2.47.3

