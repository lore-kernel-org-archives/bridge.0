Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6CF218E82
	for <bridge@lists.linux.dev>; Tue,  4 Feb 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698612; cv=none; b=q/8yWa7tpfsrMFg7CbfVoR3zutm2V8CLzc4rKMlCmlEkWjosC3fjJTN7GUZjNb2wksDy1hHZcmfAYXxnC9WeDyMjaSgLIZIK/LFh5N1A0Dh8dkP/AkxJk0GEuaH8h7AZSFkKIL5D24aaL3eBpbgH6BEAGMZOFaTU4d6gPYnBh7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698612; c=relaxed/simple;
	bh=EMFBUpkmd5COgfTIlW8tvi9/f+9voyjto4Z8+2IBLWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9IY/Ax+9yKG81fUHLNxA4M/eEEOXD7QLtB8JY0TZXxwmCFA81e9kBUZWPxjVqLCNpjzlPj1ZzddcBR5t05+xSk0KclbWfHxCelaAQS5PaQSbezYlJjDLH5upfTcyS2FUOWeIMIT8dQ0gcWyOhW2OZnvh8hy75LV6yOXpRQZsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyOZTboO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyOZTboO"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab74ecfdae4so142944766b.2
        for <bridge@lists.linux.dev>; Tue, 04 Feb 2025 11:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698609; x=1739303409; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//RthvClo4JzPeEnG1PywSOoZnVfBt6m8pYgKggGTpU=;
        b=PyOZTboOGHcAiIcHjBGPLYX0hlieITYLK0I2m7T1qUO+kOPXPMiqPNRdisO5VFYJRb
         gN8kvZIGwFdEKM9z6u+Wiu4zcz9KnrjqbUT++mnKUvBzM12mman10zkpi/hz4nabexUs
         wVpg3QuOlBY+jRestKCndHKpIV4TpWSwHPx1BDCSjyUDL405h7UxkkQChvTrmZx5tBpA
         2d0Cpq1Gve8iHjSFsR3vGtPeY7e2eXQlWn0Da8lnkOCCjtbpR+Mu8vzGStvNidgaD4Aj
         DDrsP7hj6DSQ/cq1n2U/9F6ZJnip4F4C84KKffI1Hg2xBclFT9Rc5sKHix5nZjY6zReX
         xVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698609; x=1739303409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//RthvClo4JzPeEnG1PywSOoZnVfBt6m8pYgKggGTpU=;
        b=rsIVAkUXdXX4dVr3Ydc94wlH3WxVhMSRM3oHd5QXUtqo/g8ntOXeWWTa+eGrNNbI53
         2CAPx3KM5ZgnR0DZoDwmY/NNkWKvnfcNmYAESsmaQCyZ0tCsTY6O3mjaZwK+2slbVylL
         d+VhwJidb5Unh7Fn8DA3SJ949iPHlk2gJEvKgE65ReyMDiLgInEDf5GjSeXRmx+F/jyk
         6k35yj8jX7Zk7t89srzoLfp8EJT6gBRea3RobTYOuJZowo09iiDfrruf9Upoofzw1Bla
         Q4rzwYL4q3qmV07zathVwNOs3X6YttIJleIWtCGubXkX4SCRh/nY9KAc4YNCsEysvtFK
         /Ezg==
X-Forwarded-Encrypted: i=1; AJvYcCXkhcp3Tz3eUhRXlRqb5duU9VyXJLjKwZz8Vg3dD84co3kwqrGqTW4WBRnQGWC3ChBfdCCXWmo=@lists.linux.dev
X-Gm-Message-State: AOJu0YzhN0s70RM0Ce7kESG8NcFErJ6E1OFqPRRucYXS/lNFO/dvWC4w
	RXihw7y6ay3LG/8bqrhGkzttxntu5Q+JethYUy7N5aDANMZDuOR3
X-Gm-Gg: ASbGnctw/KUrX60b8PYN3e8g9MqJZfLlH8u4Op8Gh1vGSc6tW58uq8jy3QScBh904yr
	6cPtVaI/h8YLxwmFiojqLnmG4ua51buOv8hnnW7PUFbuJV0Mb6GVBJvVckmKXb5Uja9xU/symZe
	9+BXBbHkK2ZApDQ62HLOvmRMVKsobbMVHn0ndlMBBoAfuv/UtIzpR6SrPQCF61oMVWjq/LLU8kQ
	3gZdl+Rn0+XBP1EwG9nirjtVrADiIUqJdW8rg8j0JAD1EauMXxo01Zid2ISkhYw2IMmbMh6RTt4
	SsuWJbEIYJ4P370P+J8jRLvakN11/UBonwcxdbnRCS0+4dk4sXdYvEmwOu2KaM3pDAvnWIS81BP
	ZKxHNds9bB2wQmX9uFSWqnqqgGtMC/y6+
X-Google-Smtp-Source: AGHT+IGt/6VgWu/uR4UpsMkru0toFiQ+1d3xhaiHmAvPsdOeeBceqic1mQLjOAWdzpkUw3jzvfdFrQ==
X-Received: by 2002:a17:907:9714:b0:ab6:621e:7587 with SMTP id a640c23a62f3a-ab6cfcb3a0amr3155424666b.4.1738698608664;
        Tue, 04 Feb 2025 11:50:08 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5635bsm964684466b.164.2025.02.04.11.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:50:08 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v5 net-next 13/14] bridge: Introduce DEV_PATH_BR_VLAN_KEEP_HW for bridge-fastpath
Date: Tue,  4 Feb 2025 20:49:20 +0100
Message-ID: <20250204194921.46692-14-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204194921.46692-1-ericwouds@gmail.com>
References: <20250204194921.46692-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces DEV_PATH_BR_VLAN_KEEP_HW. It is needed in the
bridge fastpath for switchdevs supporting SWITCHDEV_OBJ_ID_PORT_VLAN.

It is similar to DEV_PATH_BR_VLAN_TAG, with the correcponding bit in
ingress_vlans set.

In the forward fastpath it is not needed.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/linux/netdevice.h        |  1 +
 net/bridge/br_device.c           |  4 ++++
 net/bridge/br_vlan.c             | 18 +++++++++++-------
 net/netfilter/nft_flow_offload.c |  3 +++
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 872235e30629..5a7b0843dfad 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -868,6 +868,7 @@ struct net_device_path {
 				DEV_PATH_BR_VLAN_TAG,
 				DEV_PATH_BR_VLAN_UNTAG,
 				DEV_PATH_BR_VLAN_UNTAG_HW,
+				DEV_PATH_BR_VLAN_KEEP_HW,
 			}		vlan_mode;
 			u16		vlan_id;
 			__be16		vlan_proto;
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index c7646afc8b96..112fd8556217 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -430,6 +430,10 @@ static int br_fill_forward_path(struct net_device_path_ctx *ctx,
 	case DEV_PATH_BR_VLAN_UNTAG:
 		ctx->num_vlans--;
 		break;
+	case DEV_PATH_BR_VLAN_KEEP_HW:
+		if (!src)
+			path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP;
+		break;
 	case DEV_PATH_BR_VLAN_KEEP:
 		break;
 	}
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 3e50adaf8e1b..8ac1a7a22b2e 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1494,13 +1494,17 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
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
index c95fad495460..c0c310c569cd 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -148,6 +148,9 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
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

