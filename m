Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE601224252
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122456; cv=none; b=Z8opygngtZRm2VEPGyYeOtIvvxTzjEoew6vYmCkflRpp7fuBkFT8kYsVEch5j85E62wTr+3fvVj0HjCtyLWW7T+giSZ+J9XvmjSsHdGbLj2DaagyRkat5LTVUvX/yJotnkobTG89ypjEJGf6Kf1UYziZ3VqDjbbvoERYKdqi2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122456; c=relaxed/simple;
	bh=gaG/8CllEsuEYVXuPZk1cX0GaP1RIWirH2m+Ef/oQJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daU0boN5RoVXxfz2/zcHiAdH/oaiKOhBa0WwdIUw7r029R6jr0bX59v1WiwaGvJgxW9ME8+dI+6U+Ic71FW4IxbWyDzIyFhInWwKHku2aLxK9omEt9+o3gq37PngdscADsaL+9hX09IEEwke2GT30Iy+oJx8TsYHLnx9KUg4VZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5a97w2n; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5a97w2n"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac3b12e8518so1038910466b.0
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122453; x=1744727253; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSHGxvoqIBIbqZcTKF/gVVMx0ajorY2bbUPhZUg2YJ0=;
        b=d5a97w2nXwgVI4WsslAox2gMnLce9hSVvqI4IInrc55SmNglDf5zrkeOBT6dBBKVsz
         kIXuSmBeKeua/QH/z93ZD8bG1MqFGl0M7VWl/9+0eV97jz0niz3vDOLbVSvgTwsAW9fO
         SL7yLehvpa1DNC7CWrPgrVy+BQHbWl294FS/ka7M9C5V9gx3M6oy9mmcX72NRpYhWu7b
         2Ir29Xk1Z6n5DDHAnY1yq2Wvn8gvAd31RnKjcv40AV24V00xvWNqA25ax7tYEd8sqW2I
         KUT/J0xHNVL5x7dO24WWlP5qhTCzm6pgNoASDwf5FtdVlmU3YA9La2gbNKcq/XCoE2/Z
         C/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122453; x=1744727253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSHGxvoqIBIbqZcTKF/gVVMx0ajorY2bbUPhZUg2YJ0=;
        b=WJbksAJ3Zt6pVmJh5Cb7ux5eVDAOXBF98QmYn1ovGYOfbyibbO+IH0CRQz+QGfkr1B
         ymvTAp1TOEyLMRRpZ7/ojwxXuzSSrgjSJYQO3bFDFB6GLI7/8owdlY7PBfI5Dp3xyfyQ
         6hfGpsOdM0xdCLlfm4KNjQGqn4eZCR0S/0CCJMrTFXOpJuJzSO6kqIU0vd2vLO9HIQz0
         DaN97CY/MPojIIqqutlKz2gvhff3v53V3ybfI5waiC/qL21+tBc2Ko1Q7y2ZR8sxfkxL
         cddm57aSorHSSrq/QBjmGQsZuMdUo/SmbeP4OQ0BwgkMMUM78chSYpau9l5RM9tcpGcE
         Njpw==
X-Forwarded-Encrypted: i=1; AJvYcCUrSBDwJIyEL7WT8mBDm5K0EvV6SCwdNC6eDs5KB+rAdZ/wUJpCslOf+8gJew4/Vt3v7+2nc0U=@lists.linux.dev
X-Gm-Message-State: AOJu0YzSB2QvYqyQDTaDTl7BSgLuD09LzSHdIUjFAD0DjpV20UFbaDR4
	xQ0Atr8jgw8Gum77y+moK82zdcfon6g/MNcrKtM3mJOJlOCUL3dW
X-Gm-Gg: ASbGncvxZuVVu74UbWcTSLpQVkurS0EkapuX5BBxGoK5Mh/tNjMKjtqGGw+o+Z45EPd
	yt2B3NSr8YnkIwHzliJG63LoCnzPI0a4WwQlSk4zij8Zo0Miritn1NzyqIcXIwDgEx1o4OYgzGc
	6EpNPt+5j0ZAyCd4SnP9XP8LZWWygy0JMna9cXndFvUI1VKZ90WVHgFyiPKxPyNZG9WTTp4mSGs
	QWnzLN8OnAALVLiPWnXkDSXSr5xkWsMKkyh9DNoIo+t9Bz/cfLhloiE50OozLyJH2UwXyNvbEKR
	+B3NgbiysXntWXDQPADjnCJz7jJRC5qnlt2hMzlhZF4GERFNJs5xMBtngdpmuJIKih5tZsS7KXr
	UUwSBVWnhqXSN7je3tjsbxTCPMvSRqOzxmF87rEK7wGkgPZ7Ix2QXq/z3dZalgs4=
X-Google-Smtp-Source: AGHT+IH3URBmXzvm7rmuiifGg0nI6GTLC2yk/NwC/7RSNf7U9qMp8Uua9d/HOCEY/8nWokG6ODloBA==
X-Received: by 2002:a17:907:7291:b0:ac2:a4ec:46c2 with SMTP id a640c23a62f3a-ac7d1b9c1demr1497465466b.49.1744122452769;
        Tue, 08 Apr 2025 07:27:32 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe9be67sm910393266b.46.2025.04.08.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:27:32 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v11 nf-next 3/3] bridge: Introduce DEV_PATH_BR_VLAN_KEEP_HW
Date: Tue,  8 Apr 2025 16:27:16 +0200
Message-ID: <20250408142716.95855-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408142716.95855-1-ericwouds@gmail.com>
References: <20250408142716.95855-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the path through a bridge, there are 2 situations where the
action is to keep:

1. Packets have the encap, and keep the tag at ingress and keep it at
   egress. It is typical in the forward path, when a vlan-device and
   bridge are combined.

2. Packets do not have the encap, are tagged at ingress and untagged
   at egress. Can be found when only a bridge is in the forward path.
   It is also possible in the bridged path.

For switchdev userports that support SWITCHDEV_OBJ_ID_PORT_VLAN in
sitaution 2, it is necessary to introduce DEV_PATH_BR_VLAN_KEEP_HW.
The typical situation 1 is unchanged: DEV_PATH_BR_VLAN_KEEP.

DEV_PATH_BR_VLAN_KEEP_HW is similar to DEV_PATH_BR_VLAN_TAG, with the
correcponding bit in ingress_vlans set.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/linux/netdevice.h        |  1 +
 net/bridge/br_device.c           |  1 +
 net/bridge/br_vlan.c             | 18 +++++++++++-------
 net/netfilter/nft_flow_offload.c |  3 +++
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf3b6445817b..4e8eaae8c441 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -887,6 +887,7 @@ struct net_device_path {
 				DEV_PATH_BR_VLAN_TAG,
 				DEV_PATH_BR_VLAN_UNTAG,
 				DEV_PATH_BR_VLAN_UNTAG_HW,
+				DEV_PATH_BR_VLAN_KEEP_HW,
 			}		vlan_mode;
 			u16		vlan_id;
 			__be16		vlan_proto;
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index a818fdc22da9..80b75c2e229b 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -423,6 +423,7 @@ static int br_fill_forward_path(struct net_device_path_ctx *ctx,
 	case DEV_PATH_BR_VLAN_UNTAG:
 		ctx->num_vlans--;
 		break;
+	case DEV_PATH_BR_VLAN_KEEP_HW:
 	case DEV_PATH_BR_VLAN_KEEP:
 		break;
 	}
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 6bfc7da10865..0f714df92118 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1490,13 +1490,17 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
 	if (!(v->flags & BRIDGE_VLAN_INFO_UNTAGGED))
 		return 0;
 
-	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG)
-		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP;
-	else if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
-		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG_HW;
-	else
-		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG;
-
+	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG) {
+		if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
+			path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP_HW;
+		else
+			path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP;
+	} else {
+		if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
+			path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG_HW;
+		else
+			path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG;
+	}
 	return 0;
 }
 
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index d84e677384da..fdf927a8252d 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -145,6 +145,9 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 			case DEV_PATH_BR_VLAN_UNTAG_HW:
 				info->ingress_vlans |= BIT(info->num_encaps - 1);
 				break;
+			case DEV_PATH_BR_VLAN_KEEP_HW:
+				info->ingress_vlans |= BIT(info->num_encaps);
+				fallthrough;
 			case DEV_PATH_BR_VLAN_TAG:
 				info->encap[info->num_encaps].id = path->bridge.vlan_id;
 				info->encap[info->num_encaps].proto = path->bridge.vlan_proto;
-- 
2.47.1

