Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D8433B3
	for <bridge@lists.linux.dev>; Sat,  4 Jan 2025 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735979962; cv=none; b=SGepNZhgH0PbT1BecSj1Bw55TIoIKxmxxIVCdENJEfv18lpqsDzCnq09Nt+3ZenBAMaJHnshMqi33wtmmn6kyoEhff8P0GO1XlOFhju2Q4DMi+LfPXLNCumuUQMYutlc/i6FJIw8Ro0QL2wfPv5XMJKkikV9RVq+zYsyDUs4xtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735979962; c=relaxed/simple;
	bh=NXan8oxIYy/ZmaOV0exlIOxUNFHEgCAh9/q/86ZqEQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o8Ly+l+TmKUY1/SVHk03pbz5c2jIVBfq31PWob2JxaEqnwNYjfMPYIV7K9LTPVdK356ZWANHizn5HCgDE09Vr6eT/HwNX1IJC2LRku1VKhFI6rP0UvaygeHY80nUZu+KVmj/y0PDD+2F5uQQyv+9lu+9P7wiIG07gt38OIpV81c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7vrcIRI; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7vrcIRI"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f6497fbccbso5000542eaf.0
        for <bridge@lists.linux.dev>; Sat, 04 Jan 2025 00:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735979959; x=1736584759; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ms578HFiFMJZleG0QpTq+Vnu+FBkWfD/5q38w3RYJo=;
        b=A7vrcIRImtpis7W1ndMJQZDGe250JIOsM8uY5y5P4uSbVpCS1MjpMhjnK7+Ar1cQnj
         I+1N1fzHADztmTkNkOECy/lkW7aQKvBZzGRToleo71SlLtLrspgrZrda/G62wrp3Zdjm
         FzfAjFwu3FFlhea+RfJX/ZZYFOUYqD1bmZp/fvLKE6K2NC2EFXuGKoVIFYGv/ayUgluG
         lAlOhZLoFLbx8TZTjL+CI66pavfcGIH5SdPz1NSRjZqrFXxld9qO8YaoIhIRgNe9K8+8
         ZDvZ2C8iUP9oSzxMl4OnnN7x3v0LeFpz9Ahm4XjoiYz0KgD2omV6k6Qz0eqomaUZeh9D
         dhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735979959; x=1736584759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ms578HFiFMJZleG0QpTq+Vnu+FBkWfD/5q38w3RYJo=;
        b=NzeoAC+Ab2AfJ9qjqbCPcsSEufie+NpHITCLqGv4zKyRIKTA6+qavbRf7XjbQBzVRf
         eS1kXbWAV+NphjrxyQpYtYX34UHbr+RXA3/GodMuihV9LO67+4Nee8FCfzhc9+7F3fjU
         vDGKumkVt1cBSJfJJ8fi0b5B1o/rAoPAFfspqydM4g6JlfZ71fb1YDq2sxSb316yzWQk
         XZzrF66+yrnVuXy8tIvsfDplH0Kj/dWjGFRwScq1bPcm4Dc28Px5UXkWsuuSPba9IuuQ
         OyBTa2PrGt5uPxRDzJz4tgYhOHFWqS2p3b9vxYfx0hu7A5mPbUFonfxEOv5aowAA/v7w
         PFLQ==
X-Gm-Message-State: AOJu0YyE2WOEpTUaXuU+efiX/iV4Ldwkzp/3vlGpjkPBe2KzjPG7FEbL
	xfMrqaQN1q/GPwWqKJPd3p3J0K5PVdjLKjxuFJI0kqSWObjOv44=
X-Gm-Gg: ASbGnctmD3fXRt9eijnNUPzgswpjX9R61BEc9gZtKViqxffWnVLrLhe/TbjMUpiIH3K
	f+rW16kGKnOZmIy1vf/5gvJsO510ymt/gvVTHYi2T7OlkYZxlvR2UGns22M6mNO2EdfPc+CQVNv
	0J+WIWeCD3P9Uh6wYGICd5AQRFkoUlt3850XhtelI7bOrY9jsjIerTHLSjJhPe3URfYlxKKzvsa
	AExiagLcQnqOQV++c+I/I3sUVc9xO5kmMgPicxCt2ffZI/r8dn2JfTiVRE=
X-Google-Smtp-Source: AGHT+IE/5GwGUtvKwqDS7wa3/g82WNA44zDDcQRhUiRtgY4gcX9Y36mSnYtthXDEmg6XMg1KFXCvZQ==
X-Received: by 2002:a05:6870:b28c:b0:29e:7629:1466 with SMTP id 586e51a60fabf-2a7d113f93amr29344927fac.7.1735979959636;
        Sat, 04 Jan 2025 00:39:19 -0800 (PST)
Received: from ted-dallas.. ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d77f0a69sm10305427fac.45.2025.01.04.00.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 00:39:19 -0800 (PST)
From: Ted Chen <znscnchen@gmail.com>
To: roopa@nvidia.com,
	razor@blackwall.org
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Ted Chen <znscnchen@gmail.com>
Subject: [PATCH net-next v2] bridge: Make br_is_nd_neigh_msg() accept pointer to "const struct sk_buff"
Date: Sat,  4 Jan 2025 16:38:46 +0800
Message-Id: <20250104083846.71612-1-znscnchen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skb_buff struct in br_is_nd_neigh_msg() is never modified. Mark it as
const.

Signed-off-by: Ted Chen <znscnchen@gmail.com>
---
v2:
- Rebased to net-next (Nicolay)
- Wrapped commit message lines to be within 75 characters. (Nicolay)
- Added net-next to patch subject. (Nicolay)

v1:
https://lore.kernel.org/all/20250103070900.70014-1-znscnchen@gmail.com
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
index 29d6ec45cf41..1054b8a88edc 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2299,6 +2299,6 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			      u16 vid, struct net_bridge_port *p);
 void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
-struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *m);
+struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *m);
 bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
 #endif
-- 
2.39.2

