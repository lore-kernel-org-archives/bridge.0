Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0E1C8FD6
	for <bridge@lists.linux.dev>; Sun,  9 Feb 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099468; cv=none; b=SlM4qq7GQWfsiHz/7RJ5/p0PnFsCH9GgpQjPhVLDGyGGCpjWgK76CKHmzUUMwSXypCTwPlyy9y3W/s23QrOb3MBRMDPeIJWXTwX1K0gUTL1tbT9dYF/2WbknjbsVjn+C9IuKaciQnbAOb8XivnF0RhYDCBlFC2zq0oTKeV1mEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099468; c=relaxed/simple;
	bh=XZoyPUjQN/+20T26Lym986aR6M2k2HvcTymZcYiPB2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUZTcOL5UyzK7XYe8OEUMuBl/Uzm/hhtz4FKqOWfidbLEWE8OCY77qnV9uqL63UeVfEpoGeC9DKL6zURZxGOLn5tV2CSPIyyChz6MZSo2yWPcpGnfGkC8N2ZsGqKINvT3u/kDxXYgjqrVzdR5uubt/QXTr94l6ODoC7siH3gZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvwmLjGw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvwmLjGw"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7a4b40cc1so188368866b.0
        for <bridge@lists.linux.dev>; Sun, 09 Feb 2025 03:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099465; x=1739704265; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21wGozzdg/kg90PQGRE5o7in49y5R5W2VgpxxyORYJo=;
        b=EvwmLjGwvQlWkSg4GnoSiNiFg6sIBYnt7qwcPqnK+gdHo824Ud+Mkg0t8Y4Vs1/WFx
         kXKXNDwrIUZ3onDHcjYCJ7wnLfGJcHnilzpuygM7zYE9m3n13vtxS++Z0QBLm9EONpDC
         0HhtE6X0pqSZmMRLGcq++KxSY8QvfzhETMX63ljHDTi6ioVR5Wdl04Izmznxb6vOvDPe
         CtdArhi4QKIG22orHF6uwETtJ8m9wiCQM+CoBfpQKfpZgT8QRfKtEoGrAwwL6NrPr843
         8Egrzrc+Itwr4dOtO8Yr0t2HrF9QjsYHmCM/hqn3YxWm9nCni0WX3/fKsn3Jpseoqhtb
         ZheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099465; x=1739704265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21wGozzdg/kg90PQGRE5o7in49y5R5W2VgpxxyORYJo=;
        b=VSba65Gv2aUkuPrf8zXPTgO5+NhlNtY7nb4lrkuINdLx2FB6rOOwqvjnLu422j7XSa
         dm26D3PlDcWhPMFZotGO342Oo0AgZuL/VmOvMtM+2C0OdWdn3PaHiSEMTT0x8RuEu6bq
         kWHISTiUzCdy5LWhzQR2C3sOKV0tXL5XFIpHjfYrJIMQAXzGnO+nHqA5d3mDPfoBNfb3
         +PuHmuwqrC2L1oq+f12smjSlVLePz82FA617Tgbo4GoUmvrC1X2JK7WMfPOF/+R57ROK
         mt/Z4iPo1tkJIzZNgFuVFhHcDIBpM5rOGPyo6+g/4DbfMLTlCSGMSK1FnzKiY8OaoJPJ
         gsGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUucSEEHqlAG7s+Mlo4H5KYvq9Suc7vkLGG+PeuCCA858WBJD1TVJmBvxTmmRVtDmMYm1NCTQo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwPgmzS0pq+5n2np3+/0k7Wzqcauje2CSFoi/6iuBag5BzBRO4/
	R03ZcgrYf7OusOELlMmtkgCh8oun6fX0yJaxnkFD0bDPdVYXY8zi
X-Gm-Gg: ASbGncspatgQZuJVkaXY34O3nCWcjFLGwPWl95HmUUe0yO4mZHpIm9Kk9YYIPovwiOX
	UZ+Urt6sTlrYLWqUSN7naPDy7JTsCbp/Od233/dv9/95+YeThBfrOWNdbg8WVbUn3I1ntH/2aFo
	/xtkZjoGsmBWUrjrHX/9pZ828TUmkiolW/BSLACKa/aHjCvXB1WyxOy0i2OQGf/l5ClP+J2BN1j
	DK+SdHib13NOJZ8jUbSHRGysFjnfTvdfJh/0NAU408smKFMUusMaCq1vKJlLcSKaKoimMtuT2B+
	JK2S2EjuVj3ZQ1uAxmTBaDuyvWxaCpuG+Aiylm+XkH0YQsj7YgC190K+tGZWLUshAlIe3KK4gym
	PKBY9jdXEWUAqKagqg9nAub1UWKtx91TU
X-Google-Smtp-Source: AGHT+IFCN56S7YNhxymBxkzw1XBWVzH4BKvgunr9+9DooHHAtJHeUPUaPpWkQeeGjmJ70qNtwfqBzw==
X-Received: by 2002:a17:907:60c9:b0:ab7:bf2f:422e with SMTP id a640c23a62f3a-ab7bf2f54cemr32650866b.27.1739099465160;
        Sun, 09 Feb 2025 03:11:05 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79afc7452sm357516366b.163.2025.02.09.03.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:11:04 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH v6 net-next 13/14] bridge: Introduce DEV_PATH_BR_VLAN_KEEP_HW for bridge-fastpath
Date: Sun,  9 Feb 2025 12:10:33 +0100
Message-ID: <20250209111034.241571-14-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209111034.241571-1-ericwouds@gmail.com>
References: <20250209111034.241571-1-ericwouds@gmail.com>
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
index 9f925dc3d1d1..923dbfc589ba 100644
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

