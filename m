Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5C3A545A
	for <bridge@lists.linux.dev>; Tue, 17 Mar 2026 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745443; cv=none; b=Oqm7c/qEiMwvthXboenEoP5gFB59eRvsawQzk9G4EBC3qBuM4Oju3Fez3nzJd4n6muZIG8S8UsmVMUJhAx3+0MSg9kg2+aVXbvHICbQeFiTN7u/SiUhotKPMwYXAcd67RNzp0mflX3NWpbpqCkri8f7XZV6DwIL/kuKB4z4nBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745443; c=relaxed/simple;
	bh=KNMdTz0dMtsZ0/bH1FzXk+0DNsqD2IF/dA5rxowQT18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rx3tGjTQ8EcNcvgOr86gBhMabuB07YZiP+IlzXbHElP6sHQfOLMocLsZxHWKefpViNQeFmbrM5LYWZmBx7ccFdmYNk/xccDOeQ3uAE+KEhVhciI01IJksex45cqj5ENiyHp+MI+8PcJ8gXW+kArs0d5sYLoaihbncSEYKU0iCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHmi01iM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHmi01iM"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6631e0edcf1so7939267a12.1
        for <bridge@lists.linux.dev>; Tue, 17 Mar 2026 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773745440; x=1774350240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N+sB1F9ylcq5EEMpOQgUFXx9/JMgB+sZnio0KZ13MVg=;
        b=LHmi01iMZ9id1HzY74484Yu6GcTtUH8tuuD73E8w31rlthvpU3qnDL3QGGzfnnLLQs
         bqOgxUfRTacPoJn1Cjm0eKOIQh/2bK7qQf6ob9f+ymZXI80ovsMFojMmoMR9hjWhEQ7R
         EPSEYtm5WcknAO57frEuD3fvB94W+ADA8oB62K91d5zNUXzSB343zvBPaqbDBOkwcQxy
         7SkjRmywBScY9js67N4niLYTLIzcAYHW31LudiiEM4gPYcnPp6uW4dch5trQuumFf35f
         fxYiZ6uP3Z4nRNXuZ/LnAjDXM9SuQ4DkegHJzlrPosyfjM4gQMwMWY9CGpicfBU1eRrK
         hzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773745440; x=1774350240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+sB1F9ylcq5EEMpOQgUFXx9/JMgB+sZnio0KZ13MVg=;
        b=skpczmM+5swKJA5tevKhWoLn+1v5LtJjAo1bBTokxVLstMoM4Qoqd2DEB95ObJJ9N+
         Z71jTvwPallfR6MPVulhr8862mdvuC4feX8HCZPk9GwtqT3aixRVTyn7VqVL4RZnkB86
         +47DjvlTpKDN0ZdJw+4vLe8WpB9fX2lJ0hbO/hbzBjZ9CFUz867ii1mh87UZXdGb6wJJ
         oBSOEcX0OPSiqz95brnB5oAeXlX48yS2Rm5O9a/x0CV9kU8eI+CTXJmEdpTu+W586qoz
         fpX6WqQoudYCRb6QJJW/LQP6tiMcAYoXzu9AQ2QGuyf2lpj7XwanBvD1f6zPnEvslfT6
         mB7A==
X-Forwarded-Encrypted: i=1; AJvYcCVW07vLzBzxzO64d/rMtNPbCkGtHrgK6kc6FCpRSeLwnKZmFeOdNDRqT+dLbRa5nPRo2IF2gB4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5hcvOMMFhLPuUxj8Gb6Eu88Q3E9y3rBF8I4aOKDz0wC4gAeBC
	2a450IJr392nfAaDJ5xjVx51+xhLtUQ3SU3cUvb5lxap/d1ymmJwrAhc
X-Gm-Gg: ATEYQzz+epDDpILGcyQUX/Ktacrl4lTRaCDtsDaJQAuPlhJz81+ZGxkzrVcncr1fCbT
	bAjR7OD52vO3ie/j0LC+WYsGhmWGs7BW4h0A2jOO+Te5/vo63/soX7T6Jh8QDy3WKCILzP7mLCr
	tUwoiz9gR6ZcT0LRE4cNlL2O8K8N7gzSnWsX6pN+2OK4o3Rim5LcUa6vQt7R3KCRmPQtVaLdR2t
	M1895dUUrXkC+MmO2p9X4/430dDcWxcqkN7DuBQm9g4+0aQs+yhXPLzFDaw93X5P8vI3DOydQtL
	uMQQO4+aKRiRWS+BCKoXjplkAM8fQX49WE863NYAuOqxhEFhw7AoDJCd8vmUc5adlJZitLFwCwX
	sPnQFOb/3A3ym6LcVi6vqgSZxsdkXktFcfiUpDHmCBggB5SVm5aRVa1y084Ktsh7cA8dLFH4Azw
	Wh23LmzFIjMKS1i19QIjQNEC0Z9i4T20uUVTYo9MTpq5/316M648dwHOxCJPSdg8O7bpKjTsOtj
	QZ8iduHNEGzCiacpKyf/3qHTlf4eN4+uC3HKeaIoGdQLrEtrzKpenA=
X-Received: by 2002:a17:907:94d6:b0:b97:9076:f84f with SMTP id a640c23a62f3a-b979077179cmr655488666b.45.1773745439719;
        Tue, 17 Mar 2026 04:03:59 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9791c30cf3sm594116866b.2.2026.03.17.04.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:03:59 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v12 net-next] bridge: No DEV_PATH_BR_VLAN_UNTAG_HW for dsa foreign
Date: Tue, 17 Mar 2026 12:03:47 +0100
Message-ID: <20260317110347.363875-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

---

This patch has started in v2 of my original patch-set. It remains
unchanged from v4, always moving along in a patch-set. The Acked-by
from Nikolay Aleksandrov was added in v5.

Changes in v12:
 - Moved to net-next.git
 - Split from [PATCH v11 nf-next] netfilter: fastpath fixes

Changes in v10:
- Moved to nf-next.git
- Split from patch-set: bridge-fastpath and related improvements v9

Changes in v9:
- Moved from net-next.git to nf.git

Changes in v4:
- Added !CONFIG_NET_SWITCHDEV version of
   br_switchdev_port_vlan_no_foreign_add().

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
index b9b2981c4841..5a6f7d8fca1f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -182,6 +182,7 @@ enum {
 	BR_VLFLAG_MCAST_ENABLED = BIT(2),
 	BR_VLFLAG_GLOBAL_MCAST_ENABLED = BIT(3),
 	BR_VLFLAG_NEIGH_SUPPRESS_ENABLED = BIT(4),
+	BR_VLFLAG_TAGGING_BY_SWITCHDEV = BIT(5),
 };
 
 /**
@@ -2224,6 +2225,8 @@ void br_switchdev_mdb_notify(struct net_device *dev,
 			     int type);
 int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
 			       bool changed, struct netlink_ext_ack *extack);
+int br_switchdev_port_vlan_no_foreign_add(struct net_device *dev, u16 vid, u16 flags,
+					  bool changed, struct netlink_ext_ack *extack);
 int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid);
 void br_switchdev_init(struct net_bridge *br);
 
@@ -2307,6 +2310,13 @@ static inline int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid,
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
index fe3f7bbe86ee..556ed24700db 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -190,6 +190,21 @@ int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
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
index ce72b837ff8e..636c86fa1183 100644
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
index 4d5fbacef496..bf252d116ed3 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -760,7 +760,7 @@ static int __switchdev_handle_port_obj_add(struct net_device *dev,
 	/* Event is neither on a bridge nor a LAG. Check whether it is on an
 	 * interface that is in a bridge with us.
 	 */
-	if (!foreign_dev_check_cb)
+	if (!foreign_dev_check_cb || port_obj_info->obj->flags & SWITCHDEV_F_NO_FOREIGN)
 		return err;
 
 	br = netdev_master_upper_dev_get(dev);
-- 
2.53.0

