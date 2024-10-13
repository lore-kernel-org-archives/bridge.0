Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9855B165F1C
	for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728845750; cv=none; b=SCEg7ysXzbNr9miKh3rBAQrjV2xeG0w5hakxGZGtqFTYZFNXEcxc9dUVSx0YxiSGkZEsJhvFIj81aNFAqiD3M3jH4bplz+DUWWvKFbCI29m96Z/7FQ3vrzwCU6cF9TyHg2xR7Sipq04VVm05T7lTar/iMXfoAaIVvAk9dz1/vsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728845750; c=relaxed/simple;
	bh=2MrR29L0apTeymIhO5SD5LS844z7+xt7fA+cUFkaNlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gz//gw2WQMHsKqbdsdiXsc9IZEnaYjwYNFTG9DX509HzKvL3vtc0iIJic0pM4RBWRue85pRZ8NKMrwhNLpVDMPbw/yTpIUXZ5pjZWzHImGatTtNs6UVF4TR2bm/4QIEL8bFSTAFaCEsmHnnHCVg3UAw4isDFVURRL02/QZ2dD+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqPU3T40; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqPU3T40"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so189155966b.0
        for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 11:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728845747; x=1729450547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wvQCHOWWIW7US3Y24oFxpAEUoI5Ll0qD/qvu+rx8QE=;
        b=aqPU3T40gGgJ4AZHl0DvoczsyG5yVSy8uqCUDhAUBIhRVw2+H0uxESQPuGkYAxC7DQ
         etoYVo5/qGd3f32ED1excle7hIScnDRam+s6oBt9bRuozxcxLprHW++z09wFUUl1aikg
         J7Uyv/HmT5Fte/gGTlzYlfRr2QXHNCKnXGWI0CjC9As6exmY1d51GRdiE/VnVY+69lQR
         5qrp8ONcMuwkixxT0R1ZaxEx188rRzyIjHxp2TEPaWNoAF/pqKev8x2V9Z2naCZbZjGP
         EcG+lfpbpS02N/tuSRQuZPco/uxretFVu2vRoGFmCx0j2mpyPe69nfFX2kMc8fmo3rK1
         19Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728845747; x=1729450547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wvQCHOWWIW7US3Y24oFxpAEUoI5Ll0qD/qvu+rx8QE=;
        b=gSdSSCeehmRKWfWVZM3sxTvt2rgCfQODMYQE7qHWx8XvuGlyTLYNKZO+E1w0vyXGgg
         8+t+nGoy00pBQzMkWfguas7yxnAAeaUeJNrF/WA1EomHXu0kNpnYGY6MPfqgQbcHz8Jw
         7IE5udUCUPlDeGbVRsrbBJbvlyVrn51RAt99cv+Xp5/8z24OStUzzW+DRrqhhMCymE+u
         bea0zJggUbwdGqOM/JfRzOnXKQcgTjX4YEtXR/41VqdXEy7dj/f/j2GRxM8f2tuWKxEt
         W5QXXti6o5FY+2UcYYNjxZ4jkiLX2bLJKoyZ7gvXGu69y/sOZzmXQHOb3BPzYhHOWx8x
         wQYA==
X-Forwarded-Encrypted: i=1; AJvYcCUJy12Ot2o5BIEvfUcLaHxgfZz1WGb7kgpYcJjXrfGc0SqHBGHfnniKbCj7rQKu0C1+C2wRBo0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6dVH4hvPBuAAhxdgpr/sn74EL6G4kB4dabqlQpIN6QMPbRYg/
	/Pj/GdyHpA2yVp02SquruRnPBmajiqNIdiPFpzDaIWCH1eTCDCC3
X-Google-Smtp-Source: AGHT+IFcMh7X7AR/VKEwvdjIeYhwzK2WvA/EYBgn+NK/HakHY1UTKH1K6wSO2SOJbW3fWApGJV4UEA==
X-Received: by 2002:a17:907:6d27:b0:a99:b592:edba with SMTP id a640c23a62f3a-a99b93a7d8amr743812866b.1.1728845746819;
        Sun, 13 Oct 2024 11:55:46 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a12d384b9sm13500866b.172.2024.10.13.11.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:55:46 -0700 (PDT)
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
Subject: [PATCH RFC v1 net-next 11/12] bridge: br_vlan_fill_forward_path_mode no _UNTAG_HW for dsa
Date: Sun, 13 Oct 2024 20:55:07 +0200
Message-ID: <20241013185509.4430-12-ericwouds@gmail.com>
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

In network setup as below:

             fastpath bypass
 .----------------------------------------.
/                                          \
|                        IP - forwarding    |
|                       /                \  v
|                      /                  wan ...
|                     /
|                     |
|                     |
|                   brlan.1
|                     |
|    +-------------------------------+
|    |           vlan 1              |
|    |                               |
|    |     brlan (vlan-filtering)    |
|    |               +---------------+
|    |               |  DSA-SWITCH   |
|    |    vlan 1     |               |
|    |      to       |               |
|    |   untagged    1     vlan 1    |
|    +---------------+---------------+
.         /                   \
 ----->wlan1                 lan0
       .                       .
       .                       ^
       ^                     vlan 1 tagged packets
     untagged packets

Now that DEV_PATH_MTK_WDMA is added to nft_dev_path_info() the forward
path is filled also when ending with the mediatek wlan1, info.indev not
NULL now in nft_dev_forward_path(). This results in a direct transmit
instead of a neighbor transmit. This is how it should be, But this fails.

br_vlan_fill_forward_path_mode() sets DEV_PATH_BR_VLAN_UNTAG_HW when
filling in from brlan.1 towards wlan1. But it should be set to
DEV_PATH_BR_VLAN_UNTAG in this case. Using BR_VLFLAG_ADDED_BY_SWITCHDEV
is not correct. The dsa switchdev adds it as a foreign port.

Use BR_VLFLAG_TAGGING_BY_SWITCHDEV to make sure DEV_PATH_BR_VLAN_UNTAG is
set when there is a dsa-switch inside the bridge.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/br_private.h |  1 +
 net/bridge/br_vlan.c    | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 8da7798f9368..7d427214cc7c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -180,6 +180,7 @@ enum {
 	BR_VLFLAG_MCAST_ENABLED = BIT(2),
 	BR_VLFLAG_GLOBAL_MCAST_ENABLED = BIT(3),
 	BR_VLFLAG_NEIGH_SUPPRESS_ENABLED = BIT(4),
+	BR_VLFLAG_TAGGING_BY_SWITCHDEV = BIT(5),
 };
 
 /**
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 1830d7d617cd..b7877724b969 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -3,6 +3,7 @@
 #include <linux/netdevice.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
+#include <net/dsa.h>
 #include <net/switchdev.h>
 
 #include "br_private.h"
@@ -100,6 +101,19 @@ static void __vlan_flags_commit(struct net_bridge_vlan *v, u16 flags)
 	__vlan_flags_update(v, flags, true);
 }
 
+static inline bool br_vlan_tagging_by_switchdev(struct net_bridge *br)
+{
+#if IS_ENABLED(CONFIG_NET_DSA)
+	struct net_bridge_port *p;
+
+	list_for_each_entry(p, &br->port_list, list) {
+		if (dsa_user_dev_check(p->dev))
+			return false;
+	}
+#endif
+	return true;
+}
+
 static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
 			  struct net_bridge_vlan *v, u16 flags,
 			  struct netlink_ext_ack *extack)
@@ -113,6 +127,8 @@ static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
 	if (err == -EOPNOTSUPP)
 		return vlan_vid_add(dev, br->vlan_proto, v->vid);
 	v->priv_flags |= BR_VLFLAG_ADDED_BY_SWITCHDEV;
+	if (br_vlan_tagging_by_switchdev(br))
+		v->priv_flags |= BR_VLFLAG_TAGGING_BY_SWITCHDEV;
 	return err;
 }
 
@@ -1491,7 +1507,7 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
 
 	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG)
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP;
-	else if (v->priv_flags & BR_VLFLAG_ADDED_BY_SWITCHDEV)
+	else if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG_HW;
 	else
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG;
-- 
2.45.2

