Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457B313547
	for <bridge@lists.linux.dev>; Mon,  5 Oct 2026 04:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175124; cv=none; b=sOWKcFCqIJS27rVbNdDQK4GKslV/gZiQ6+xcYMbWlVHJsOeX46OQq+sT1xrjgYVFWzq39i57HbgJVhsQRpJNFZpBFo6CTM12jV88dhHOlDfWrBoDZNmE8/+FF7pklSwtWBwyE4Jzgncm3P5780L6+b47ccAHXoqVFF0kpwDQPVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175124; c=relaxed/simple;
	bh=tWTj7sa3HSz20eoE7iU48Ov4FXB/O8yPqTq5z9H7G1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a47/JKV9K64y18YA+hn+djUfQiscuJmvoCBWjz+o5mwGXuzjPHRiUnazMgcPI/guNqTC2iBlaM+RjGKdJVo0hkfdodHeTYiYYYqzMD3MASeacA4QxH7NbbzP1B2sJSsucj6U6bNZvxB1vIjMVBBXvaa9+an8Ljqo5CGaOeX6Gsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3C+30x7; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3C+30x7"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35120d43ecaso1724571eec.1
        for <bridge@lists.linux.dev>; Sun, 04 Oct 2026 21:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791175121; x=1791779921; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=miahjqq1TAdqXeL2Jl7n/7P9i8eCMUOcl23EpJEiCcg=;
        b=T3C+30x7ht7/2lmjpi6LbFKPb3/awqBrhFD7PwcXQy+R6Wl0fBzW91ppjJw4ktGwUs
         LMzXmc7bFMh1Bs/phUuaotDvZ7OLX2pF1ymQz7oijBnYawM/Qsac4Z5VUJ1qncakyGq2
         O9GqR5gWASTqx0q2wi4Lqy8Hzcks9oTk7jF2BTC1DEEHPFcN4UrZtejqE+hNnqd7Kar8
         G92ktWn9MawGO0q3iZm57vpoijBkk6fr03gZQrOOmVfTRmukafkifxMd44W/J5DTkqB+
         vKr3VMm8bCnpq1mGBaDv7rWjp6tNjxFrlIVM2n1d8ynFyGlTgwLpad53fPXAJxNLWE27
         uJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791175121; x=1791779921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=miahjqq1TAdqXeL2Jl7n/7P9i8eCMUOcl23EpJEiCcg=;
        b=XAmvsNVYWKrE7MGlTzzLdnjUPtRPCz7gHjBcv5s/nVVUHCQz/V+IxByG/51kWl3vye
         B57M40rtq9ZY6YPp0lxvvPdTaTi2KpQZVJJrMJozTYCZlbFrzMhWtoY03J7Nfaw4ij7t
         OhfKB/aNMGMKpUC7pBncmZ2N9LA1oEGqOyGJiFnywTV/E0Q97XBRAtPsuNSCMZWRVttK
         ceXtsZd4y0oXs3zwxX78Es2EI+WCbFhkyhi6QgfTnvTJFfkj/L5oBXmNNCASQF0yS/Ub
         h639USlhgc8Bp3eMZqcRkSoPJ/P8tOqVf6aRCNtUFTsIubigYX/MSh5fNmt1iw5/nZXK
         DI6A==
X-Forwarded-Encrypted: i=1; AKwUvBwVfOdh43iqrOrqR+D56Vtyb2Yu4bcwC0AaLvWZjmDmkMb1LKPPMXNorEjAJLmFNCESmC2xELo=@lists.linux.dev
X-Gm-Message-State: AFuF++nPRdbVTcrZhKbZY6wpEEpVfSWHkmiGibyUNaQ5c/RfU0vv1H3M
	LPRcb5NULAubYxRrTO/hlyDKEMo+GmYVkgPucQ8cY+A/3KRUadbKnthj
X-Gm-Gg: AYBFou0V9OwSTmYA1io4w7q9hHBbNQJJ9AJwWCSAZ9k4PCUo5y73aiy4V5R7FPO2QXj
	uLs1F2Sy6jZvN0aSQiRUwC5aWzUrClYmUrZWayMuBVFJFVI7gAMd2luvlkUwfLgNY8BmbBCuhQL
	NzqwceoY5HSpgbyEjEldpRMi4tomMWeC0RPYP/yATKaF01uAtb+FiOe7nls3xnZ2zpc+oYxuBl6
	xLVfIt+qAZuPGfvxg5y8WU9Sv+IA3VS/XKjoSH0EmsZGZFmo3AfkhU4l7++AYJSJmRa7aXU0KOP
	4XZRZ+2p/JlfCFcAxF9mFDsWFV5EIEg6UFXHfgOANdYewR7Lw0ZnCJz6rBQGjWOR8T51nv7W1Ou
	LVD12+u57+TDX69ik/fdECvhBjvB6//47mFI3C2v6PzV5so8sUq5ySRVT9pgajoFH0l4qdLkIsA
	pFt7v39MKeYEWYpzGxpjW/PEYTxXAbCpalRF2UIYxlzbMR6RXg9/gan4hBJVn69bjGEkFB0EpbW
	gVlsBk=
X-Received: by 2002:a05:7300:f801:b0:34c:b75a:ac1e with SMTP id 5a478bee46e88-3511150f264mr9866587eec.33.1791175121098;
        Sun, 04 Oct 2026 21:38:41 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127136b8esm9518581eec.6.2026.10.04.21.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 21:38:40 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] net: bridge: cfm: notify userspace on CFM config changes
Date: Mon,  5 Oct 2026 04:38:22 +0000
Message-ID: <20261005043822.3106580-4-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005043822.3106580-1-w453y.me@gmail.com>
References: <20261005043822.3106580-1-w453y.me@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CFM status changes are sent to userspace by br_cfm_notify(), but config
changes are not. br_afspec() calls br_cfm_parse() without the "changed"
pointer, so creating a MEP, adding a peer or starting CCM transmission
never sends an RTM_NEWLINK. Today the only way to see these changes is
to poll RTM_GETLINK with RTEXT_FILTER_CFM_CONFIG.

Send one RTM_NEWLINK with RTEXT_FILTER_CFM_CONFIG from br_cfm_parse()
once any group in the request has been applied. If a later group in the
same request fails, still send it, since the earlier groups already
changed the config.

br_ifinfo_notify() is not used because it asks for
RTEXT_FILTER_BRVLAN_COMPRESSED, so the message would not carry the CFM
attributes. This calls br_info_notify() the same way br_cfm_notify()
does for status.

Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/bridge/br_cfm_netlink.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
index 91b9922dc..56309e6f4 100644
--- a/net/bridge/br_cfm_netlink.c
+++ b/net/bridge/br_cfm_netlink.c
@@ -382,6 +382,7 @@ int br_cfm_parse(struct net_bridge *br, struct net_bridge_port *p,
 		 struct nlattr *attr, int cmd, struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[IFLA_BRIDGE_CFM_MAX + 1];
+	bool changed = false;
 	int err;
 
 	/* When this function is called for a port then the br pointer is
@@ -399,59 +400,72 @@ int br_cfm_parse(struct net_bridge *br, struct net_bridge_port *p,
 		err = br_mep_create_parse(br, tb[IFLA_BRIDGE_CFM_MEP_CREATE],
 					  extack);
 		if (err)
-			return err;
+			goto out;
+		changed = true;
 	}
 
 	if (tb[IFLA_BRIDGE_CFM_MEP_DELETE]) {
 		err = br_mep_delete_parse(br, tb[IFLA_BRIDGE_CFM_MEP_DELETE],
 					  extack);
 		if (err)
-			return err;
+			goto out;
+		changed = true;
 	}
 
 	if (tb[IFLA_BRIDGE_CFM_MEP_CONFIG]) {
 		err = br_mep_config_parse(br, tb[IFLA_BRIDGE_CFM_MEP_CONFIG],
 					  extack);
 		if (err)
-			return err;
+			goto out;
+		changed = true;
 	}
 
 	if (tb[IFLA_BRIDGE_CFM_CC_CONFIG]) {
 		err = br_cc_config_parse(br, tb[IFLA_BRIDGE_CFM_CC_CONFIG],
 					 extack);
 		if (err)
-			return err;
+			goto out;
+		changed = true;
 	}
 
 	if (tb[IFLA_BRIDGE_CFM_CC_PEER_MEP_ADD]) {
 		err = br_cc_peer_mep_add_parse(br, tb[IFLA_BRIDGE_CFM_CC_PEER_MEP_ADD],
 					       extack);
 		if (err)
-			return err;
+			goto out;
+		changed = true;
 	}
 
 	if (tb[IFLA_BRIDGE_CFM_CC_PEER_MEP_REMOVE]) {
 		err = br_cc_peer_mep_remove_parse(br, tb[IFLA_BRIDGE_CFM_CC_PEER_MEP_REMOVE],
 						  extack);
 		if (err)
-			return err;
+			goto out;
+		changed = true;
 	}
 
 	if (tb[IFLA_BRIDGE_CFM_CC_RDI]) {
 		err = br_cc_rdi_parse(br, tb[IFLA_BRIDGE_CFM_CC_RDI],
 				      extack);
 		if (err)
-			return err;
+			goto out;
+		changed = true;
 	}
 
 	if (tb[IFLA_BRIDGE_CFM_CC_CCM_TX]) {
 		err = br_cc_ccm_tx_parse(br, tb[IFLA_BRIDGE_CFM_CC_CCM_TX],
 					 extack);
 		if (err)
-			return err;
+			goto out;
+		changed = true;
 	}
 
-	return 0;
+out:
+	/* Earlier groups may have been applied even if a later one failed */
+	if (changed)
+		br_info_notify(RTM_NEWLINK, br, NULL, RTEXT_FILTER_CFM_CONFIG);
+
+	return err;
 }
 
 int br_cfm_config_fill_info(struct sk_buff *skb, struct net_bridge *br)
-- 
2.53.0

