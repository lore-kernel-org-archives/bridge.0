Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449C14D2B8
	for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728845740; cv=none; b=gSrIh/+83r4uvW9TKTnRKHmV16lWbBoalAPDhejk7eAvoZlgVF9UXO5Dw3ZGg1cAE04tvGUCq0q27W/4bTepEVXiNfPhgeRys8zVTuUNRUD/2DbG/oow3V5pYkESjbcNPFHVGeZR0A+VngLSHABOs4izgElE/1fDVSe2XVoCik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728845740; c=relaxed/simple;
	bh=xVq2A7KQoTaSOf9hImnz3124p3TutQuvn+/YffCKtts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuNDLRlMVcE6gHPW9gS+Dn5gPOfNnMYauYJg/2gCsJX/u2Y7l5o+Hn80nnuKqatNEm3QpRemKKA3PxQxLwOpx72UUCtaHGc67BJ2Qy1yfLFh3iprxCh7/zpjURozKgNWPpDQvgATVvxaWA7AfA1pohYutTP8PQ3lYpQmpgXDzcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA3hkQk1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA3hkQk1"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a993302fa02so585728966b.0
        for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 11:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728845737; x=1729450537; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RADunMSsDBQJOkeIT+sKpwp5kwpbWqG3OFvDFge3gsI=;
        b=LA3hkQk1b2/5XlZH8vRXPdyrMNIzSoa7EvJ/KXETEPdU4/6xxexrKhgo078dRVOkr1
         XWiEHO9F2IjMQShY4+RbmhN4TK/xMr/3woydwC/g7YrSrTD0Pid7q7dGQb/JrkWPfKTr
         jdYIvmvzrToW3+rvtYAEXB38cHkh7u7ZhSNgXl9DwKrocg2BFoAKhEIbzECvnLzEMn8J
         3e7fK54vwhFpRUqLjhq/eWh9RPfyfa40wqUm9xYUOEghlb6Q/fI+pKKRg6GrUwrZtbmC
         T8cTZFwCo6y5CXtN1rjNWstv11AMV+pfIqi7kbk30HHftjSC05TssCNWp/cTcrkUFzmJ
         TaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728845737; x=1729450537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RADunMSsDBQJOkeIT+sKpwp5kwpbWqG3OFvDFge3gsI=;
        b=WTL8ipyHPemoJBUqdT3hLVCBi3xdh3B65y2/2xaGCCoQo9tVm9jkkiLjUV5Z4Pp3le
         jnY8e/vqrNTqFMfLqJ3Uy+HZeNhRsTQFPg2qq7AI+tnMKmRuvBxa4Y3euQDggKpiRE7O
         ippKuSjCuIJaaf66+Z8KCy2GBWql43JVVF8hZCV/xvXIiZ8/sRFZODOjF+Va8bnmhRju
         WwEJ3uKqK7WKsY11BoqVcwy9zNeu7PJT96h8vRLlIn9IKEhTcqTaGNL23tkULV6RrfRp
         jlWTysWZhaRh6iFX6D8FEnNPTo7CU/67dPmRlCZmkSIOWBsfFNL3q7L5fQCVraJxtAKF
         0sqg==
X-Forwarded-Encrypted: i=1; AJvYcCU5n5UG5vpPQ3Pb1wuhGP2VbAVFSqcmWBwkQz3HzeLzrK3xl/Hx6cysRnMhF3iqO9yTtK/xKyQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzXPPbvPx8/XUjJEUbgUq+pl/VZTbZVzM0yxapEGmZT603Qp1Xn
	heCpLCZGCsnabWyKajONng9EM1z09w3CgvCawOPeYwV3VeEU757H
X-Google-Smtp-Source: AGHT+IEWUZNp7HCnVh3j+0U2jm4O/rsy5kDbUxyRD+CLZEqkudsSqyQJlj+0O92gLyoS4IpxQ9txiQ==
X-Received: by 2002:a17:906:c14c:b0:a99:4ba9:c965 with SMTP id a640c23a62f3a-a99b9585b7amr898083266b.44.1728845736991;
        Sun, 13 Oct 2024 11:55:36 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a12d384b9sm13500866b.172.2024.10.13.11.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:55:36 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RFC v1 net-next 04/12] bridge: br_vlan_fill_forward_path_pvid: Add port to port
Date: Sun, 13 Oct 2024 20:55:00 +0200
Message-ID: <20241013185509.4430-5-ericwouds@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013185509.4430-1-ericwouds@gmail.com>
References: <20241013185509.4430-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lookup vlan group from bridge port, if it is passed as argument.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/br_private.h | 1 +
 net/bridge/br_vlan.c    | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d4bedc87b1d8..8da7798f9368 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1581,6 +1581,7 @@ bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
 			     const struct net_bridge_vlan *range_end);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path);
 int br_vlan_fill_forward_path_mode(struct net_bridge *br,
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 9c2fffb827ab..1830d7d617cd 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1441,6 +1441,7 @@ int br_vlan_get_pvid_rcu(const struct net_device *dev, u16 *p_pvid)
 EXPORT_SYMBOL_GPL(br_vlan_get_pvid_rcu);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path)
 {
@@ -1453,7 +1454,10 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
 	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
 		return;
 
-	vg = br_vlan_group(br);
+	if (p)
+		vg = nbp_vlan_group(p);
+	else
+		vg = br_vlan_group(br);
 
 	if (idx >= 0 &&
 	    ctx->vlan[idx].proto == br->vlan_proto) {
-- 
2.45.2

