Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409E21930A
	for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514604; cv=none; b=Vv9A55zDXbNBEjTM+B+J2u7f3k9/Nhp1J2AgditOP8JPjE62cIG64XWbzRphRtEv8EHOHkLGUB5MoDDvW8SeQlmL9jR0OIV7XVccZosic1g41+Aq3nusjHqtKB1Z589EbAlJWjb66r0r7F/Kzxugey84d5P5UxY2VfoZsJ0Po9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514604; c=relaxed/simple;
	bh=1+de0DPWCMsSJ95CqVzExQJhx0fjAqUotezYoUhDTKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcZQRtqzwz62PfYVbnE4flmJH6D+KCuc1xA+172eV77NsktToB8nr4vNqpQMgJoIMRbo54u0pdYB+z7/n/edShEYemWFhaEZHfqWzRLXS4AUqjqBsFU1Nq82VcSfic1QhWFAC6szyS0kw5g/7zXYUNIXJZWDVgcM0rDgrClkVNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/PheheG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/PheheG"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so8843066a12.1
        for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 12:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740514601; x=1741119401; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqvEEiGjtfCg1O2c4wJsc9rlXi5oFjjuoYnCbbZ/cQM=;
        b=Y/PheheG6MqsPzc4X47NOnjew7AWA2c3R5eKKFqlqIO2eRqnWXftVZEGczkGGco4ag
         2nkxh4uQgmTSQQcSct05lHZlQVvsC99zRplYjXBiuMBCw3Vtnaae3NS1cex1Bjekmmhe
         fSbe7LqyiCni0IjursDXS/Q9X19F6tnWAKopSv5AS+PvTGsjoWbD+smHfL3DwuVDNvgp
         BYvaIlEzMcyQ4oWcRvF1M9mlqdic7Vjm/B/N0JxQwqR1/KiGckYTIyDgxwAAsCy/IuhQ
         IATTJ8gU0KAk6YP8kq3lpmEgiHRzuOD+Zf5JyCyP/VsgKXjRQVYI7Ej7q0kNJQOsQ1y0
         MJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740514601; x=1741119401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqvEEiGjtfCg1O2c4wJsc9rlXi5oFjjuoYnCbbZ/cQM=;
        b=s40mxMzGQpglO5JYp/TZlHZAB3iBRcF4YrSKqhA+O7i72PqBb5IePTwK1DjnAhvTA6
         fNfsX+NOsV9+YFTlBJ1mv2RnRS+VGPrMwZ/z9ZTuuZW/QAYh4Jxt/eBCurIGk+LodPCp
         WUGIttgmcDG8UTc6ezaUoQacEQ1NCjAT0s83CumUioJ5mmLwkpiq/cDU2Fua2yE1PJMF
         VD3Xngu+tmw6mYnqYpFo1hYQ7+uWBqQWf7Y9GdtySbmXj38iF0/IEVNm0/AMHpC4xt8g
         i16Ke/6fAB+1KI63F+KifIkQhktgmaxVc8Xn1QEm2svBgJSh5Om3QnKCKD7q38rMzdky
         rpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtO6/ngWU/qD+HnJ4+rSv6PpYr3GGl2Vepk8kCNe2L5BOIDNJmVtZXxZ2nyTuQTcVftwgLpkA=@lists.linux.dev
X-Gm-Message-State: AOJu0YysCmD/YlXbGd45v3ZQOQbLyj2Vcxxm9RwWNadl7/L2RrWAPAMI
	B9ysVjKw1/gdg9keMVopcT2PaEIX7/2A5pidyTQyja6gBymkJhXt
X-Gm-Gg: ASbGnctOnyVuvPfs4+kzgGMddowfw0BIOwmXfYW7kiOqZJV+AhG7uF6sbj5VCbrQX0Z
	6pgo3Vieec4QDQC1iWpvbgxkTulAxefUKOGi2EvJB35lilh2jlbwoNeQDxH4nREJYhlI5YhG1mR
	js7O7Ppcv8XtGiB/jIuNatyAOmmSgF/OiTF3ctrmb3kDaeliSIIU10heOfGief0b4aEIIixz+Jj
	LZkzoriiDv9snEgmk8dDemgYcsWHsEe80T824igWZi++UIcH2356bzLIuLfgJV7hVfH1z9KoLqF
	fFV8gDnQr35wMZ+ilKBe8sIKk9Jq4em1QX0pfz+3GkXmmu9pzcD97nTKsge7qUmptD7vZEw0BWH
	N5UJ6gGKGBSravkme4EuLbg6m6kyh/dfTmMb4Q37s38A=
X-Google-Smtp-Source: AGHT+IHhGusG5BMLrTa3hM8cjvDcEm75Lf8vLAMleB4CleirSzLNiv+mlxD0ehZbqG9bpzWHQ5wVQQ==
X-Received: by 2002:a17:907:3e0d:b0:abb:b209:aba7 with SMTP id a640c23a62f3a-abeeedcf3bbmr43896266b.26.1740514600495;
        Tue, 25 Feb 2025 12:16:40 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed201218fsm194319666b.104.2025.02.25.12.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:16:40 -0800 (PST)
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
Subject: [PATCH v7 net-next 13/14] bridge: Introduce DEV_PATH_BR_VLAN_KEEP_HW for bridge-fastpath
Date: Tue, 25 Feb 2025 21:16:15 +0100
Message-ID: <20250225201616.21114-14-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250225201616.21114-1-ericwouds@gmail.com>
References: <20250225201616.21114-1-ericwouds@gmail.com>
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
index 695445927598..9ac7142ee493 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -869,6 +869,7 @@ struct net_device_path {
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

