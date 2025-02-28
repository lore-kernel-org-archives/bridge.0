Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03FB27FE61
	for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773799; cv=none; b=kh6fYheP/mP4a1KeYQ9LzJgeaCVWuKow4r3Wt85eQw5YQsVTVwTW7Ncx+ugi6hHf3EZCKSLER8BQt/2hdZ4uPyiuVbhZdHS0bBulOYEiO6znNjq3Jiz6zDaj8ikU4TYGdhs/Yp1yHDeUjYyfBf3ibgloYqsOUgakt1SLln1UmJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773799; c=relaxed/simple;
	bh=FRvZQmo2Och7IQUxCAdMtvRd1w+tCIzOcwLzMvZg5Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mF7+O9jhDrWPbULteS8iBjpwRCxYbqSaITOSevFKxCioQK4vzMffIvxYeuh+nJwpNm8a8PWlw8//wjBR3D4sPzwI4k0n50BL+vIf4XFOL3LvGJCLIHTlXMQd3WJyR1WJdKsw5aXh2y9Lt8vcPdcW73NHAoEqoBY3Ms64Sn8ghF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgSJp0cT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgSJp0cT"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaec61d0f65so517603966b.1
        for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 12:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740773796; x=1741378596; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2oeCJos5+VWLjM6O6Ww7CfUdtvRNnO3dpetsG6O99c=;
        b=SgSJp0cT4OMu4QfkqDCDqZpwqAE6TKYZxa1Ckx+3aGcQWCQcjTC+iIyZS/7mihRMu5
         TfKcq9At8yC9yDzdm9OqqQU9NjzPYNnOeQARPOUbbTzRF89v4X0zwxPFPKfkiQX/PEDo
         XxFZfmjSZHX7S2b/UW6eGf4Ve3Baid2q6YXFfBBDaANABVRD1J7jSaw5UNilX/2iRUk1
         Md3VVrSe8zJlADIeXwaEJGPB/sYcFmJ+dgkH3EPg5peW1jNjHUDcxE7Ap+8d6Glo/FlN
         V4Uiqon5fbGwyd44pjGHK1ZQc6vr0fnberUF8G26Kqxicsrwt6sRfAx7f1+Rq9Kruq0b
         f3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773796; x=1741378596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2oeCJos5+VWLjM6O6Ww7CfUdtvRNnO3dpetsG6O99c=;
        b=TzgPPxwIZbHDtdeiSX4PUxt0/fVzK8PcrXRXmlSi76KxTsxPq05XpxRBUGCw80Yw3U
         WAeaiKzSu0cvxed1KqV3AK+DXqpRWrXrdxCFy1aZUWcIg2XBDqOAf4GYmCisI2PiHnN8
         S5v64Mut/ZRDxTexfgik4Xoam2RJbzkC+fbuqEVDRsnoWE3mDdMmI5Gonl1DBuahTjCa
         g/H5XApfJxatRUDhKTx5++UZ++C/P+Igjgg5yu1yUilBFYgWifM16qyvq6BDPipvOA4H
         g8T7RpTLFhVKik9JuJpiAryiyYU0TuYsB5vUYMXTokDXrPaES2IoQTcqZWPwU6RMwXVL
         J5jA==
X-Forwarded-Encrypted: i=1; AJvYcCU11dRnK71FzzdNZ66JBgKHh09Z5iSqbo6aQNxYjk+Xgz3vZjbyXgxApUEJNdQOsLDTJPbSH+E=@lists.linux.dev
X-Gm-Message-State: AOJu0YxGTiORTADRGcsgBN0imnU4f8WIEjTKjamU4ApBjtRr37anE0bA
	NQRuFgSx44MtbXkMNgPjFZ7uIjBv8JBotS7H5dN6Q+Xqp44RcGJb
X-Gm-Gg: ASbGncu5lzKhfHkJvJ2gccpZ35XPi0xEeSvs8N4o4JTHM+YaOc8hJjiQq5SsgWqjC2L
	u0/TX9rtOHqEAi9uQHptrqPviHnc1sM6MrV3tCabQpT6UZjywM9Jrg+F7pMJSun0YzcHjtCiV65
	e92kmZxp16cfnxUpe/riLuHgDoZm6SaidpygnQY+6zPFwjCQ49uiJRBWHxJNi06WMVSVChWo8M5
	ypHqdLlHunyeWQO+i/zIYnmTN1fAcWeJudUhi+ilMYg/AdLe0Ykp3hzsJ/iq/AzR0RGHU8U95OC
	k1X6QQ8D+SCumj2aD8G1oR8CskK7fgyc/OdWjHKiqSvE0rTZXkv1I8gPnronxCWglz8t0A9CHCE
	oqn+QupgKn0BLVnh1kYxqsyvUyJ+x4PGPA4Hn8PRk98E=
X-Google-Smtp-Source: AGHT+IGRd37BcugXvRzWetE0RiFp1sspn48cYfwa0XVMvCj+hDeBReablJgdaX0T/5erZICf63Pa2A==
X-Received: by 2002:a17:907:7f91:b0:ab7:c358:2fec with SMTP id a640c23a62f3a-abf25da05d8mr559746666b.5.1740773795955;
        Fri, 28 Feb 2025 12:16:35 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm340812666b.136.2025.02.28.12.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:16:35 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
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
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v8 net-next 14/15] bridge: Introduce DEV_PATH_BR_VLAN_KEEP_HW for bridge-fastpath
Date: Fri, 28 Feb 2025 21:15:32 +0100
Message-ID: <20250228201533.23836-15-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228201533.23836-1-ericwouds@gmail.com>
References: <20250228201533.23836-1-ericwouds@gmail.com>
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

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/linux/netdevice.h        |  1 +
 net/bridge/br_device.c           |  4 ++++
 net/bridge/br_vlan.c             | 18 +++++++++++-------
 net/netfilter/nft_flow_offload.c |  3 +++
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2ee53478d9f0..17d82e4632dd 100644
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
index aea94d401a30..114d47d5f90f 100644
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

