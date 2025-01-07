Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37E1EF082
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240782; cv=none; b=OJ8au7QfOsJzG4Cy8W6LP4muMen1f5KTa+eg2XlpVfXYgHwU+MLanzxnpYiAYkHRQFxtnXNSCtTb58mfbXOpF3uPW/OB0ZK/Weh9WtKykeJWU0OTh7Q2PM6YAI3qH/3Iss64BKmhRBiw7WSdTazIxtx2+HYFay5dke/nOaSTKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240782; c=relaxed/simple;
	bh=fNXC6p1bCW+M/ZEhva8GTHTSh+ddIIBQnzEoEEizoog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuKOcd2jV6AUvBcuJolhLe50qAjRjhI1lWc79p/RS24w9QIz2E1YYI7staDv3gFWHeM+bdjVekRO+r+rsTaqkzB2QKbPBVId92MP4YYNpEuGbVzJM7HEb7pDakApZhz3LdYOw13E5nMZOp2mTLWHr/6I66Sr8oZNbpN4GkTPBRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mn0ErP/U; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn0ErP/U"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so21924419a12.2
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 01:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240779; x=1736845579; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElntuwObyWWTXWyk0nhZUVrAyxwm6+3uBHbEuscDHA0=;
        b=mn0ErP/UbOY9r237jGYkKlice7sXAc49CX321xQWV85dQrrK0rKuOh+ghYutP8mwMA
         earjIZxdszPSFUDucEBN1ZF21b0LWDMowOzNus1sMtRQ9Z9SQLg7f+mC1P8nE0IZnBz2
         TfjjlbPEtIXc2uRoteZ1YKu8hZJc8xf9TKx8EUMALIyaciy0MHyoY70TjooX5h6Nlepr
         ib8ecU60ZIi+eAgUcnybBN3+m/ZNvwKhlFz17zt92qnyRxsa+yWGWr2SpiFQ6PD/pbR2
         b/uW1EUlQyolswESfCwHEMJTf4YpQ8SjG6WK8io2AU34QzqOgRgrZWXyaAaLd9KdSBi9
         9jGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240779; x=1736845579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElntuwObyWWTXWyk0nhZUVrAyxwm6+3uBHbEuscDHA0=;
        b=DQhXm6jEyU9iEfKfkOj0Ar7AKs0VpoiDr6TPYsmiZMkqugsnkrb81OzMzakVg/qvVd
         U9FishUkIUQiwaej4qfmlw+GeV+fpQmcH+M8y0UMy8YYrjLiXVyc9M23AK19nVHNt3Mu
         Gss/XM4esUUMK6kCxC77SWWjB3dR+650HTY7yxZ8R+6YMz18nnnhETotaU/R4Z4gcqB7
         F7YavV5fehmqT4PJ+rkqSAEg9SZ2mH5YWMVGafNTSnmz4a54v8mFg2nfneHBSZOmfddQ
         A5QrbB6LgE/AT8aTgdE7PAu+bFasTpuPl8m1vLsXCHCD89tqap47q1KBPMnKfnPSgNRz
         2tDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1K0CVn4/6pNvut/SUpjW0qKQOAQZDHszCdGz02hcHWPMJ647wg/X+Yn/t9+tssqA51o6Dm9Y=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyqt99/kewEKBy5gZBp6fIKzRRC5CklSA4tcGtr1M/21o7MvuP9
	hXZ3JbSiYXoZDbpcjwCrGFEuAQ3UpcqCHULGgpcETHFwy3au+CXE
X-Gm-Gg: ASbGncuZ+Wz1+Iw+MPluc80Kx5Yo0LUA6UrwedlxIAfEy0fzl0zSNBvFPqNGMtPfUAu
	HHX6Q5vcFDKlFX7dNcfFZmCKDzX0aX8fyeo04fc1K5El82SD/hw0RO+LR9riJVSCeKJRkVQJABG
	CrFjhQ/cJqyJx0fbR2plYIR8IyD0J0QPt97uwXCSJjGT0VjT4A5eYFGne+1yQVYHuJLba7lGZtG
	RfrsI6Ztd+YUYAHfNj0PUF5eyF29exaJTi3dTj+tkC6p14F17IBLkWo6EpAfOlfxYT9Fn8hrEeh
	ydvbJCJLza/m+9ZDgsB/VxpbWYH1ROfuTq5J4SFl1r9EMuBnhIeHBEbJKhf6B0HGsxCAPEt9AA=
	=
X-Google-Smtp-Source: AGHT+IGt7vXeWi8jtx2prBY+YfADkXQQ34zgfUpIHrQ42iesCfqHcrSyvvrAit9+d72yO+NjyUOXkA==
X-Received: by 2002:a05:6402:210f:b0:5d0:cfad:f71 with SMTP id 4fb4d7f45d1cf-5d81de1c921mr140645365a12.32.1736240779167;
        Tue, 07 Jan 2025 01:06:19 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24005333a12.23.2025.01.07.01.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:18 -0800 (PST)
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
	David Ahern <dsahern@kernel.org>,
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
Subject: [PATCH v4 net-next 12/13] bridge: Introduce DEV_PATH_BR_VLAN_KEEP_HW for bridge-fastpath
Date: Tue,  7 Jan 2025 10:05:29 +0100
Message-ID: <20250107090530.5035-13-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107090530.5035-1-ericwouds@gmail.com>
References: <20250107090530.5035-1-ericwouds@gmail.com>
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
index 7d66a73b880c..cf754ebb19df 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -871,6 +871,7 @@ struct net_device_path {
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
index 387e5574c31f..ed0e9b499971 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -149,6 +149,9 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
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

