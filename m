Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB91EE7C2
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240785; cv=none; b=J5JfZO8Cp9O4ZKT5Z/rzKHOsBIPwgX/+cSLIIrQyssD55DYoLE3GijguTIJFK+D+kQk1wetfYKbTm2/laR8QSFEe0NERHJ5QzR1YMvOPVy/lZuFNqAx1cBrQoTUFzAurdvLQVnYZex9A2R26tTh2vvEZGJPuhQw6FL4Pg2BAG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240785; c=relaxed/simple;
	bh=HatO8o2t8hOjMXOG7SdN9eW8i9smGPaf05kEwn4y+GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMUsoHZ9s/eO+wiFWFEKJLq4FUWBOBkDx08MG5c7j3LTjPxesCMKnpHLyaJ/xgiFpIjetDhfqy+H0rs7qJdsAZqGZof9dSRdiDSYcRUQn9CDL/UZG4OQAn/p+75S4CD8egpcAX7ZYp/GLZA/G1lWzAirokofAXY3VZix0TpNQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2709e1e; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2709e1e"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa67333f7d2so2236048466b.0
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 01:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240778; x=1736845578; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9/TvKRPWpgFkI5Z6u1yRjdyakFY+K8HugvLg1dhslU=;
        b=M2709e1e75jLyZfTcCHKAVaeZmKpkoGsyaGoBiHC74jEsOBuOk4F0rlON0XdpzCwcX
         wgAbLqkJGu+/I5h4wZxkKb6nxyueVXweo1j2zoLep4RdOXamvKXENGPC6g70FX9W1oaU
         RpveKG39RrFe9MfRyFJFbURSE3HF3T9G5PVd+qg0zZpssli3qa2LSvwE96cGeQTzW5fh
         YCGKrJJz/ftznyd8JvdOUi0GZdBuWRUVfpKoh5QlR8QsJ4UP7ynS7odWHMJeEVp0uTrH
         Q2gZ24hvLdW+dTD3Wjzt0+P9MAfuZs8BeX15gIgAVuLdQZFZTMIXP5ZrzgiA79UQkxrH
         w3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240778; x=1736845578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9/TvKRPWpgFkI5Z6u1yRjdyakFY+K8HugvLg1dhslU=;
        b=IfrRnbi/U/mUIOKp02IH7Juutx0tzMSobJjDjdEikqj6cyW844DG0i/JGKXfJ9sUEj
         YQ5adhc5R3aJZYKfXOFVQEMAY86Vyx4Vo0V0Y/hfEtbgGOQIVGeab5YfCqF2a3GfAH5R
         7FATjolJXzM/OUetj7FoyVRuZoIQmxHgLp8VIYbhAlNhUR/SlATgxROGevijKEGMS443
         lEDMnXfRhrJfevMbMezIG9iI2R0SVPK0303yzD1H7WABfpROHykouKCMyyvvHKJH7wjG
         idi3kI5TmAeNV+9Zp4nD9qzMzgQag2rU5qQKHHbjwRureF+ovZ3Ebvw0R1e1kyCQcVhT
         Qkmg==
X-Forwarded-Encrypted: i=1; AJvYcCWCavtV9LOwCaiADzEYQsPhucKEHHhOhCaQUju3rSkccXM3A7/dOBpW6UKm8JpvwD8i4T4jrhQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwMeUJz14OaknxAZUFsL9ua2C8Fks147u1/iXSG0wvSOAAeh2dv
	8uI9z4eR9TtGEwVdGOUYVRA+3aOr4TBfWGyBzn4MfSvAlqt08rlz
X-Gm-Gg: ASbGncutuiBaswj0AsIvRPD88E3XF/eHCuXXn9k/xCMxrLropwjq0wN1rhUF2SHSCpl
	2DD5+LxiL5FUX5x5gYgIzeVRUHUkMoOUVbxyD+Oee2MjrcmceBs2P85XKE55ERxHXJs2UCWuzVA
	jBYp8IUK5gKTp/49FE9W5hrS6Cou6NG1aFkcY4VpXU307heF5VvepxIxCx6MPQeX3VVTHR8Kz+C
	v0+Xr6MZ2/fyIQJoaJpFb4zeLDhF5zO1I7gCszpxlC/+nLUT5N/alndUCkhH0jiXJQ7powDrUNO
	u8dufEzMR/elwUj/p0zCh3LCBu+RCgPCpzOibDOKhhWAqSB2R5GfcC32w+X6DhFec+lVOmzXjg=
	=
X-Google-Smtp-Source: AGHT+IHdVy6Qh1qZGtVgd8n+OJxf5iK/E+S3j6UfqiQPaQRG6QNZMxXigkGNUkGK3KdZcEdkCWqhIg==
X-Received: by 2002:a17:907:9304:b0:aaf:c27e:12e9 with SMTP id a640c23a62f3a-aafc27e141emr1105602266b.14.1736240777946;
        Tue, 07 Jan 2025 01:06:17 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24005333a12.23.2025.01.07.01.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:17 -0800 (PST)
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
Subject: [PATCH v4 net-next 11/13] bridge: No DEV_PATH_BR_VLAN_UNTAG_HW for dsa foreign
Date: Tue,  7 Jan 2025 10:05:28 +0100
Message-ID: <20250107090530.5035-12-ericwouds@gmail.com>
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

br_vlan_fill_forward_path_mode() sets DEV_PATH_BR_VLAN_UNTAG_HW when
filling in from brlan.1 towards wlan1. But it should be set to
DEV_PATH_BR_VLAN_UNTAG in this case. Using BR_VLFLAG_ADDED_BY_SWITCHDEV
is not correct. The dsa switchdev adds it as a foreign port.

The same problem for all foreignly added dsa vlans on the bridge.

First add the vlan, trying only native devices.
If this fails, we know this may be a vlan from a foreign device.

Use BR_VLFLAG_TAGGING_BY_SWITCHDEV to make sure DEV_PATH_BR_VLAN_UNTAG_HW
is set only when there if no foreign device involved.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/net/switchdev.h   |  1 +
 net/bridge/br_private.h   | 10 ++++++++++
 net/bridge/br_switchdev.c | 15 +++++++++++++++
 net/bridge/br_vlan.c      |  7 ++++++-
 net/switchdev/switchdev.c |  2 +-
 5 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 8346b0d29542..ee500706496b 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -15,6 +15,7 @@
 #define SWITCHDEV_F_NO_RECURSE		BIT(0)
 #define SWITCHDEV_F_SKIP_EOPNOTSUPP	BIT(1)
 #define SWITCHDEV_F_DEFER		BIT(2)
+#define SWITCHDEV_F_NO_FOREIGN		BIT(3)
 
 enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_UNDEFINED,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 94603c64fb63..f60a7bb7af26 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -180,6 +180,7 @@ enum {
 	BR_VLFLAG_MCAST_ENABLED = BIT(2),
 	BR_VLFLAG_GLOBAL_MCAST_ENABLED = BIT(3),
 	BR_VLFLAG_NEIGH_SUPPRESS_ENABLED = BIT(4),
+	BR_VLFLAG_TAGGING_BY_SWITCHDEV = BIT(5),
 };
 
 /**
@@ -2184,6 +2185,8 @@ void br_switchdev_mdb_notify(struct net_device *dev,
 			     int type);
 int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
 			       bool changed, struct netlink_ext_ack *extack);
+int br_switchdev_port_vlan_no_foreign_add(struct net_device *dev, u16 vid, u16 flags,
+					  bool changed, struct netlink_ext_ack *extack);
 int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid);
 void br_switchdev_init(struct net_bridge *br);
 
@@ -2267,6 +2270,13 @@ static inline int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid,
 	return -EOPNOTSUPP;
 }
 
+static inline int br_switchdev_port_vlan_no_foreign_add(struct net_device *dev, u16 vid,
+							u16 flags, bool changed,
+							struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
 {
 	return -EOPNOTSUPP;
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 7b41ee8740cb..efa7a055b8f9 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -187,6 +187,21 @@ int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
 	return switchdev_port_obj_add(dev, &v.obj, extack);
 }
 
+int br_switchdev_port_vlan_no_foreign_add(struct net_device *dev, u16 vid, u16 flags,
+					  bool changed, struct netlink_ext_ack *extack)
+{
+	struct switchdev_obj_port_vlan v = {
+		.obj.orig_dev = dev,
+		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
+		.obj.flags = SWITCHDEV_F_NO_FOREIGN,
+		.flags = flags,
+		.vid = vid,
+		.changed = changed,
+	};
+
+	return switchdev_port_obj_add(dev, &v.obj, extack);
+}
+
 int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
 {
 	struct switchdev_obj_port_vlan v = {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 07dae3655c26..3e50adaf8e1b 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -109,6 +109,11 @@ static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
 	/* Try switchdev op first. In case it is not supported, fallback to
 	 * 8021q add.
 	 */
+	err = br_switchdev_port_vlan_no_foreign_add(dev, v->vid, flags, false, extack);
+	if (err != -EOPNOTSUPP) {
+		v->priv_flags |= BR_VLFLAG_ADDED_BY_SWITCHDEV | BR_VLFLAG_TAGGING_BY_SWITCHDEV;
+		return err;
+	}
 	err = br_switchdev_port_vlan_add(dev, v->vid, flags, false, extack);
 	if (err == -EOPNOTSUPP)
 		return vlan_vid_add(dev, br->vlan_proto, v->vid);
@@ -1491,7 +1496,7 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
 
 	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG)
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP;
-	else if (v->priv_flags & BR_VLFLAG_ADDED_BY_SWITCHDEV)
+	else if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG_HW;
 	else
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG;
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 6488ead9e464..c48f66643e99 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -749,7 +749,7 @@ static int __switchdev_handle_port_obj_add(struct net_device *dev,
 	/* Event is neither on a bridge nor a LAG. Check whether it is on an
 	 * interface that is in a bridge with us.
 	 */
-	if (!foreign_dev_check_cb)
+	if (!foreign_dev_check_cb || port_obj_info->obj->flags & SWITCHDEV_F_NO_FOREIGN)
 		return err;
 
 	br = netdev_master_upper_dev_get(dev);
-- 
2.47.1

