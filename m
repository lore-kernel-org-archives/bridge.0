Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0F1A23A0
	for <bridge@lists.linux.dev>; Fri,  3 Jan 2025 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735888165; cv=none; b=P9+wrBcrEvfoK8RSpnoK0ag7ipqiJjIq9FbJ2dPE3PBU7B/P7Rrv93+ShYPERFNAnY1MTr0UH1+a7CIqiK7KbalHyKHWh4ELjeARtXRXugC49R2J4PSy2jWNuXCgiUinmtsPzDSJ8v7/WwPOdvVX+JlhtPCD1842eiMbabfJn7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735888165; c=relaxed/simple;
	bh=HSJ0ZEy2DPmuDpX6eoSbaBlR6OxYz878S/dQpamUN9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pHHwJgcGpLiAh1rIsRWM6X3HIQX7Y/Iad4x60O2Ydrq5YZxFPNPut4fSU99STZwwI0bMIPq99x598yhRF8c/0Nwn/T3O3rSC5Z9mfIV8hNFAJvFj1ueTwsXWgfmfYc2at9O6WgsT8wiwzhBJ6WlOPirlMs5SpATRYaFW7E6rEPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bfr2/Hwe; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfr2/Hwe"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e2766994bso6193635a34.3
        for <bridge@lists.linux.dev>; Thu, 02 Jan 2025 23:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735888159; x=1736492959; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6OEzrzuscE4oPpkRFpo2jIt2k/CSdnlVciljdUj3mw=;
        b=Bfr2/HweaESdHSKIBQXAbKNrPrpLsh1VGot8T1oUikXq0vFThOD6Rwf2ZOGQbT6G3I
         RNrz290lBp+K85Nz2diFqPRKnxk6CA2fS7WwiiHAsileuRAEbJmXDAhFG8r2p7CvXNE1
         vk9SF0jNDdaIqtBpPZ2mloB/sce5NktMo3xIa2uucMsGFT/p8XEd6A6a1EY0PzwmHmU9
         028g+GzIi4n+GRbwJcFvndcYTBJtPCxkTbGSvJ0LbEtJs6uKeWQ0JnHGdltQLRUIephw
         WInmEjTnhEyU2EWey56gzcF0lKY+45oWcxsYAKKC6sN3P5fRO7gGay6v+bgJ3c+r/pE2
         lJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735888159; x=1736492959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6OEzrzuscE4oPpkRFpo2jIt2k/CSdnlVciljdUj3mw=;
        b=UsNnpljwKE7DZ0vb9ghbvsRjtVqfNTMTFD6V2zdmvvlvQiB9AudxLKvpOQeuOttCr4
         BeD2yuZmP4Qvc3kEkOls8drFb2kSsFkiVFHv7O8A9D8kIa5F4lm8qLXe3i+ogYhAP86y
         p3iP/hoXIU+lWp3Y3gGed0ZEWR75sY4J9n5fSX5tW5VvC+V7dzCDzCDPV5gpUfvcwZES
         mXCbbE7xvo7hNhQzhkqB+KbW9/XJCJvfezckdNKuGHeGDGowc3QBxB433G6U28FOr3HX
         WzGh/5c4xU1nkDyqDzCC5H/nvMw6icGokbyADNWXsys+gt1GOHTDvVqh4jpAnwz1x0no
         qMDg==
X-Gm-Message-State: AOJu0YwJPiWdIt1Dygg88nEsGe8MpgXUNQa1ykKpldLdSBPCxQi0RJUZ
	3r1ipfPSo+Ge5p3UiMrjq+UzR4nW47+BUKxywXcQ8mgDD39IMq4=
X-Gm-Gg: ASbGnctf2jHuEScKm+xdfrFCha3Mzg7mn54nZMs9HLXmgysgQEUrBKWy81iTH64Vjd9
	xaPXJWs6nanRYktj6PGVtujISO8S0vFKau1vBXoKE3zs5TpfUjIEUg8q5OBQltUUPT9S3mgslgz
	arHzW3lxpdpZhuhJ4MOnq8LJl21K24SGDkP82IZJh/Cl3IwMuOuQav9fpJOyiNQ+9KY8S5rqHtY
	kclMv0uix6zUrBGDUu7FvvbLaLkn/GCVhh49V0wSDboU/bJzWzBu2LHl2E=
X-Google-Smtp-Source: AGHT+IFy12YVHNrc3sT1XyiJQzbsl5UqyT5hOiKulsVvIHKxiXliUZkbrkTUbzTsPMumIoPv0UOK+g==
X-Received: by 2002:a05:6830:2701:b0:71e:1ff9:e91b with SMTP id 46e09a7af769-720ff8f34a3mr29302221a34.27.1735888158994;
        Thu, 02 Jan 2025 23:09:18 -0800 (PST)
Received: from ted-dallas.. ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc998e59csm7896109a34.55.2025.01.02.23.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 23:09:18 -0800 (PST)
From: Ted Chen <znscnchen@gmail.com>
To: roopa@nvidia.com,
	razor@blackwall.org
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Ted Chen <znscnchen@gmail.com>
Subject: [PATCH] bridge: Make br_is_nd_neigh_msg() accept pointer to "const struct sk_buff"
Date: Fri,  3 Jan 2025 15:09:00 +0800
Message-Id: <20250103070900.70014-1-znscnchen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skb_buff struct in br_is_nd_neigh_msg() is never modified. Mark it as const.

Signed-off-by: Ted Chen <znscnchen@gmail.com>
---
 net/bridge/br_arp_nd_proxy.c | 2 +-
 net/bridge/br_private.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index c7869a286df4..115a23054a58 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -229,7 +229,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 #endif
 
 #if IS_ENABLED(CONFIG_IPV6)
-struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *msg)
+struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *msg)
 {
 	struct nd_msg *m;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 9853cfbb9d14..3fe432babfdf 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2290,6 +2290,6 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			      u16 vid, struct net_bridge_port *p);
 void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
-struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *m);
+struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *m);
 bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
 #endif
-- 
2.39.2

