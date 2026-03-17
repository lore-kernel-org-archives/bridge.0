Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03CF3A5E7E
	for <bridge@lists.linux.dev>; Tue, 17 Mar 2026 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742651; cv=none; b=OwNcG33Jdqw+RkVYQr1rindPK0z6+e4rJLWxX51Te9hw0PBX2totMfSxqGjGPuZ+YIiOPhgRik6b9oVLIsNTJdCSAoqAa7DZtAceL9uc+XKmIGnwkeBLDmr4RpEtpgefltp8UNG6iMvt5cNvhf/yIKqG8uSwUpxIk8BOTe3PmvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742651; c=relaxed/simple;
	bh=pBr7wKOt1VHnhEwSeJAROYu062K84Dc7BzVFIGRYKAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPuH/K1LawiRxH1S94kMR8DOgxd5PqPjBT1YtCZw4a0+yNJlb/GgKyjYCbf3tkF6JJlxD9YAdm7drCXKYABEO9vH/ia6JoinzOwrkjpDOtoFm4jKwU//tGnd0uEacJo2AG0IDx+7QkwzMbjoXAdm1nAbZkDrTj3FH2/Q9zyOD0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvQqWQ6K; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvQqWQ6K"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6611d20c026so7979242a12.1
        for <bridge@lists.linux.dev>; Tue, 17 Mar 2026 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773742648; x=1774347448; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Jj1znMuSQTPO/G2m5vicgYLbzdRn+Ba//APkQrLGbo=;
        b=AvQqWQ6K8a//qfe9wJim8uD1iICrJrtKOzHbTsrQlAsdHEinw8f41jea8s+lDQl+v3
         Cz3p/yJ3qnkaSrnyOi0gGbXfeMqvsdFwdUetMXycCLOE1nfvVvlTJP22jRqf3utp0wmO
         bkRyknvk2gQvPZctD+lwr8i3CYf/11LpnjhDZdOy22w616Kmx2F+ebo9zXqhVTlcmwTX
         QTYoNjVq9QqzWTRnP5fPdYf4OdU7lYYaKMX431iFPNjh1X18hxOlLpHk36HZuPXbIDX0
         uXDw5mqRkAXNl9mTkldVa02DAuj0N7VRQeBk6dL0ODWJL4ZLaxlBUipAPLWnWXFGkxof
         qVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773742648; x=1774347448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Jj1znMuSQTPO/G2m5vicgYLbzdRn+Ba//APkQrLGbo=;
        b=XWBwnMmSyQdfCUv6380Ay0w5rPprN8Tf1Ca6sL0ptTJYJ1ITJdM73nedsM164Up7hI
         GFXeK8thp78ZDM6aOy2y7Fnxd0zfw4iDTsNliVRojfnQPsAwGmJsJu4qZltVu0jiBCTh
         L6z6p/whCBfV+TogZXTPqHXSCZKhOZrMt5eDrDFdI1bk2lFmrJmIoLYmbUT9/87GLzpQ
         IlBkMW/ug/xCrbxKk+JHHH2K+y3QpZsNuzaayX0qhLagl5hzDl0LojXAlWWfCIiq2fOZ
         yXIbq0Mr5Ej4gVka/qIbeX46SH+yC/uTnysugRlMwQpFF/wta49hT+c4Ls5hRLrVtsY0
         VerA==
X-Forwarded-Encrypted: i=1; AJvYcCWg1x6Cseae5+x8BKTFMkLJSYOsJTdaPJ1J+pKax2QJx7wQg2mePMe1bT+t2C7nPiuhYL8bMn0=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywpx3LQoDA07WMHTTGItevGIQDIa5Wp4ip8R8fATd/awBlXnPRB
	mo9nCHkctFQAB6x2H8yP100OezIZaEeTKUjWqah7CSbxpnTpw54DzzXU
X-Gm-Gg: ATEYQzzyqumEh5RRcI/vts9z0HpttTUoRdWEvcA/ObHIjGcPZWScXkBijU1omvR26/Z
	TW4vGQApH0Bo9eKlthiPUvkvOCFz8F0scGoCCWl3i+mBE9pS2Pqe1XoLhhEYUQ+gafE/CoahEjx
	ybqfTzxEYaRngKtAOG0p05TwlrP21yUhEfYtkHvH0B8Dlw1qB7EViXU4JPmfO3x+ai/2w/gQPeQ
	O5dPXmjwSaQGWffdrWlbFxxTwYvAZjZiaxsRw8ptzMxBPjNWkNfqwTYHdrHJ8zfZQeqYAk9c9kV
	34gqbrklxVH4TR/wVnI5W/BcNBUvAjgyQ5LOnSGy0UUdivV5QIpFzVeW2yOd/r0v/TJ3HE3NNUw
	chd2gcKsEVSlUM9NzFW3J2AO+OAfYF68iaVPun0pFa78QqM9+vgfGEj8JX0Bd7txA+GBA8WXTzw
	ftteWF7FbHrtQ+bCJxrfkvx2dvr2dr8KjlM6HrSOi6lYQ2u48/uQE92Oz4cp2OQuKy6KGyJmlP4
	cEXeg7UAc3/2R3y3psiz6GgoddzKRcGm++KGaZRnW+9hEFaZ4ztEhE=
X-Received: by 2002:a05:6402:50cf:b0:663:44f0:640d with SMTP id 4fb4d7f45d1cf-663babe2665mr9318190a12.29.1773742647466;
        Tue, 17 Mar 2026 03:17:27 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66753a078c0sm318154a12.17.2026.03.17.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 03:17:26 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v12 nf-next] bridge: Introduce DEV_PATH_BR_VLAN_KEEP_HW
Date: Tue, 17 Mar 2026 11:17:22 +0100
Message-ID: <20260317101722.358640-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
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
   It is also possible in the bridged path, that maybe added later.

For switchdev userports that support SWITCHDEV_OBJ_ID_PORT_VLAN in
sitaution 2, it is necessary to introduce DEV_PATH_BR_VLAN_KEEP_HW.
The typical situation 1 is unchanged: DEV_PATH_BR_VLAN_KEEP.

DEV_PATH_BR_VLAN_KEEP_HW is similar to DEV_PATH_BR_VLAN_TAG, with the
correcponding bit in ingress_vlans set.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

---

Changes in v12:
 -Split from [PATCH v11 nf-next] netfilter: fastpath fixes

Changes in v11: (results of testing with bridge_fastpath.sh)
- Dropped "No ingress_vlan forward info for dsa user port" patch.
- Added Introduce DEV_PATH_BR_VLAN_KEEP_HW, which changed from
   applying only in the bridge-fastpath to all fastpaths. Added
   a better explanation to the description.

Changes in v10:
- Split from patch-set: bridge-fastpath and related improvements v9

 include/linux/netdevice.h          |  1 +
 net/bridge/br_device.c             |  1 +
 net/bridge/br_vlan.c               | 18 +++++++++++-------
 net/netfilter/nf_flow_table_path.c | 10 ++++++++++
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d4e6e00bb90a..8a0dba788703 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -907,6 +907,7 @@ struct net_device_path {
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
index 636c86fa1183..a42bc75bc883 100644
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
 
diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index f2d7822824bc..e8e4465263e2 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -154,6 +154,16 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 			case DEV_PATH_BR_VLAN_UNTAG_HW:
 				info->ingress_vlans |= BIT(info->num_encaps - 1);
 				break;
+			case DEV_PATH_BR_VLAN_KEEP_HW:
+				info->ingress_vlans |= BIT(info->num_encaps);
+				if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
+					info->indev = NULL;
+					break;
+				}
+				info->encap[info->num_encaps].id = path->bridge.vlan_id;
+				info->encap[info->num_encaps].proto = path->bridge.vlan_proto;
+				info->num_encaps++;
+				break;
 			case DEV_PATH_BR_VLAN_TAG:
 				if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
 					info->indev = NULL;
-- 
2.53.0

