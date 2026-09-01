Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231393D7D6C
	for <bridge@lists.linux.dev>; Tue,  1 Sep 2026 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264472; cv=none; b=FM9Y+GRoSEXKI1IrAodjW7iEuEJoNSV9GVIw8o47PTqi++c0QgXdiPYt2N3cuJwgoMfLZ+CCRDFHYgXmBWbGYUSE/aZB/3EIa3AoAcz2wrLmsnTSAb0ScKKPK8HOoi8kBjAESMwWKefIlj5UsNYaxpxMblCQWXmWLy1FOfLgA74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264472; c=relaxed/simple;
	bh=w14NQGUpkvlFQCiflKIsxCzYZ1NbuTyJ6r2h4/Ei098=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/d/fXY8RohZKAXyai9wfi8gVVUlZ1h7JVWwjN6vPWclXDzUxYldlnolfjfNemPX8s5ALdL1QMxCmX6mKNvjNlD3bNZFMVKyr+U2UqyJAum4bJ550v+e0PmrtM7BJT4haMbHfeSOEkLD4330MdzsQXmW0B3A0/m3SJyJp5FVZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=h+vyvnN8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="h+vyvnN8"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4843e397f74so892162f8f.1
        for <bridge@lists.linux.dev>; Tue, 01 Sep 2026 05:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264469; x=1788869269; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U/aTEnKjA69JOD+I1au9uLwwmHbzGmgWlhznTgaQ+Ps=;
        b=h+vyvnN8cFSc6RJLJ/8hoqvkPWEhJQ0ta6dygHJ4fapDwBGLpNy/vTPZYSqouc55j5
         hiMHlimfLAZGGQaocPdenYVi9ljaZkjJGzETNj6kg+x8TPyAVejDPtO7Q93Skjq6iLK5
         vbu9dhJ/e159pQ2ShTL4XKDtprPDv/9N30MyZi4VOM8WBkBKfEJ0Z+wpCzuP7y5+ylNl
         +VC951AadBEvVEFObQPwPNrs/4jslV8KZTMaduqsvqX96V5X+mt8Q6baaj1jks+EbeDL
         WjqnKOCyTikEU0Z4PvmTtsCGBrASfgp2tM9449QG6yImORkWu8Nm334WrOhVy3cHHWza
         CR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264469; x=1788869269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U/aTEnKjA69JOD+I1au9uLwwmHbzGmgWlhznTgaQ+Ps=;
        b=KuM8j37RSjAXD8y8761732B3uvxAJ8GAkX2fk0bQuIiOBpOcUxAEDeyRlYd/sDSeGm
         T91Nr7y33pUk8Xb8rXL7bgXhvGOdSI4+9Rfp2NhJOFG0oJfQ/zq+qbKBBgJEztUW50wZ
         PnJON+3pnuJfZZVYMGa1u/qWyLXyyJhMdcIm5mzpOhsSZa3mdV9QuNwEArEoGQCh16wY
         I7BvF3CNQOfPA1z8Pe6bexpCng/usg1dE91RZDMvpGYCBrTE07VAbu3c8Xgfdj111vFM
         wuDZfMaGEWHpbQS3d8b/EGXpZdjSLcfjWefnHeod0mMltMCM5vmGO+cjyyDE+UgI9S70
         kWFA==
X-Forwarded-Encrypted: i=1; AKwUvBwIZN9HAndyeELthBSUMYx3vGRvsnHjs5H3ky1lWUz3pmEuHf1ZlPeKEEJxEagui7y091GYAGc=@lists.linux.dev
X-Gm-Message-State: AFuF++lmUNbdRB3wE8kEIHmp4RQGSSf8Iq1JB+4EJXbibmmGD4T+6kgH
	Ku18UazQ3f+5U2YBi7tsu5veW+lrJHHhF57vJlIpTgzd7ZCMnP6hmI4myZW52+Q1+B4=
X-Gm-Gg: AYBFou11Ojyle+I/xd9azvjW1m/A70fCj2XKVmkWolUB8iOepXZJETCOmc1e0KcoKmy
	84xg2jHnKm3yGpeGIV+aozxr/IwbyEXpAtOHVT5dhp4sg7Kv/Es4kAX/SgIOu/zzTU0brRQpdH9
	77Ce5VCHM7JPu72PuHWak1XECs5ETSvfCpIvUpTbkvXjMjZajdY2WNgyvjf44QhAnwgYIS8r/5h
	b6CBpas8JPBYCj9grdFZ+aKh/nJc0m57TvR3bgU/NQf1vSVioVnF3FuJqIFWFgemHvLJOpDtcQc
	ckV8+khY6g9RPSD25lgkM02hcpKdfCCAbO7jApTY+DEbfCJZpETFqf+XuRcB7/5F68E50/C7RZZ
	MoDN4FJSLt/+GhqkhatokPAnK1RjhsDyACknTsTvAXxss4AYt+hhrvZkMNNIyiPtAQY7DnbaNPp
	L1FQ9Yxp3t1rCImXBRVW+Bo/K0rcR2fcZpSMbojaoWg1pTdALcde0PSiXUrzU+hmnN2vAXrhIVK
	Fe8mMLzJdM=
X-Received: by 2002:adf:e00f:0:10b0:484:42c1:41bc with SMTP id ffacd0b85a97d-48442c142aamr6299098f8f.5.1788264469283;
        Tue, 01 Sep 2026 05:07:49 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d781bcsm4241292f8f.26.2026.09.01.05.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:48 -0700 (PDT)
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
Subject: [PATCH net-next 8/9] net: bridge: vlan: add missing tinfo.tunnel_id annotations
Date: Tue,  1 Sep 2026 15:07:20 +0300
Message-ID: <20260901120721.747908-9-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
References: <20260901120721.747908-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I annotated data races around tinfo.tunnel_id before, I missed a few
places (e.g. bridge notifications, rhashtable compare), so add them now.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_netlink_tunnel.c | 12 ++++++------
 net/bridge/br_vlan_tunnel.c    |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index e7eceab5b515..58ec7bf1d8f5 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -29,8 +29,8 @@ static size_t __get_vlan_tinfo_size(void)
 bool vlan_tunid_inrange(const struct net_bridge_vlan *v_curr,
 			const struct net_bridge_vlan *v_last)
 {
-	__be32 tunid_curr = tunnel_id_to_key32(v_curr->tinfo.tunnel_id);
-	__be32 tunid_last = tunnel_id_to_key32(v_last->tinfo.tunnel_id);
+	__be32 tunid_curr = tunnel_id_to_key32(READ_ONCE(v_curr->tinfo.tunnel_id));
+	__be32 tunid_last = tunnel_id_to_key32(READ_ONCE(v_last->tinfo.tunnel_id));
 
 	return (be32_to_cpu(tunid_curr) - be32_to_cpu(tunid_last)) == 1;
 }
@@ -43,7 +43,7 @@ static int __get_num_vlan_tunnel_infos(struct net_bridge_vlan_group *vg)
 	/* Count number of vlan infos */
 	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
 		/* only a context, bridge vlan not activated */
-		if (!br_vlan_should_use(v) || !v->tinfo.tunnel_id)
+		if (!br_vlan_should_use(v) || !READ_ONCE(v->tinfo.tunnel_id))
 			continue;
 
 		if (!vtbegin) {
@@ -124,19 +124,19 @@ static int br_fill_vlan_tinfo_range(struct sk_buff *skb,
 	if (vtend && (vtend->vid - vtbegin->vid) > 0) {
 		/* add range to skb */
 		err = br_fill_vlan_tinfo(skb, vtbegin->vid,
-					 vtbegin->tinfo.tunnel_id,
+					 READ_ONCE(vtbegin->tinfo.tunnel_id),
 					 BRIDGE_VLAN_INFO_RANGE_BEGIN);
 		if (err)
 			return err;
 
 		err = br_fill_vlan_tinfo(skb, vtend->vid,
-					 vtend->tinfo.tunnel_id,
+					 READ_ONCE(vtend->tinfo.tunnel_id),
 					 BRIDGE_VLAN_INFO_RANGE_END);
 		if (err)
 			return err;
 	} else {
 		err = br_fill_vlan_tinfo(skb, vtbegin->vid,
-					 vtbegin->tinfo.tunnel_id,
+					 READ_ONCE(vtbegin->tinfo.tunnel_id),
 					 0);
 		if (err)
 			return err;
diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
index 257cae9f1569..04751f15d708 100644
--- a/net/bridge/br_vlan_tunnel.c
+++ b/net/bridge/br_vlan_tunnel.c
@@ -22,7 +22,7 @@ static inline int br_vlan_tunid_cmp(struct rhashtable_compare_arg *arg,
 	const struct net_bridge_vlan *vle = ptr;
 	__be64 tunid = *(__be64 *)arg->key;
 
-	return vle->tinfo.tunnel_id != tunid;
+	return READ_ONCE(vle->tinfo.tunnel_id) != tunid;
 }
 
 static const struct rhashtable_params br_vlan_tunnel_rht_params = {
-- 
2.47.3

