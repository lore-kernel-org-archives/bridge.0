Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44E1A2392
	for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068930; cv=none; b=poN5ENYR3l1/vHJu+5XwK1c/qgfO5e/YUG2gSVfCMChsByiLHcGG9dMaFPn0OPZEtEpyHF+xMZXgJoA4ZQHao3lScxTkPm0O595+s0nW1BOuuB5ktDl5udlISpnSyO60VwbMLpLjTd8BvSFCyNxswEipkTMRS3/M1eYVZwfc9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068930; c=relaxed/simple;
	bh=GybLpAybbUmOfhk9Lf/pKIo5aScLdrW9YfE6FqksJxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9odo1h4d45ZOC7Dr12zar+dxd+QXUlUYN7yg9QUAhD6oMipE4ISLHWstgRco3MWZweLH38GJfpQfLbiuZk9hvP12bGRYGI6FnLRNFhevagA9jy9HRowJl6NaEvXerlCvVuCSfmY5WSHvc3e9dtKuleLjksW3KVGSuIG17ehGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvOpjS42; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvOpjS42"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so2160361a12.1
        for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742068927; x=1742673727; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkA4UZVIpwTz+MfKCQjyLNbONPOyz+LdYLZQ/1FoX0k=;
        b=VvOpjS42Qiirlgc9e/cGWfqgImoSYf7Y8HLLM1tfNLyoe78dlX5AML+xtTvbl4b/FR
         gSePE1WcJO9449lxXbiqgb4aRtC9NCfwoQ0TehUqKjFZ5zi5Z9Ga8fl5KtwGi1UsFiVZ
         gUQsmhaxhT9u5677NxC+zHVo5zxyK/8+UkkxEM5gRRWOnDByoLj47xABq9Lng8FHAFjc
         L2LgtM1V4BGota+TqBnWcw8CwUBhmEjszoNHw28rqsLljUCYIKJeYeHlzz5I6ihugWRL
         CrAk1mk2WG2z9rLEsvpLCHENDhMuqH7xPhDKz9C4IXwp71QMgu50bP4bAu7oQuQ7+zKB
         htIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742068927; x=1742673727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkA4UZVIpwTz+MfKCQjyLNbONPOyz+LdYLZQ/1FoX0k=;
        b=k/8JGip1RIuGR0pmsYiLs9gZsC2GEdFgerkWMaNkWohCSswbXJrj/RTQzGmIKog5SZ
         5IMcGuedCSvRgiyI+d03R12y/mLsHuRSaUVuGJ8TCXXT5drySQVpnh8hVfnjlhCMi4DQ
         cI4GyRgFFaG7UmV//DzxUAi+LdM2igldZ1nuXj8aMwXoZQgMacfQu2sLCYhYxGIj3/6e
         DS8AOPlT+9+OVqTDo7DjyDbzeNu9KKzC0giSxN6l36v+fgDOgWf4sIOqFiHzh/Cv6UpU
         HK/xd7md/2wbUzPmZrU0snlkTBzWUGzxytLSsyAFWajIMvHjuuAq2hHLpb7CCXJlzoJM
         4xhA==
X-Forwarded-Encrypted: i=1; AJvYcCXo/RUeVlsP5WbpTnHr40K0dcmDnT+Wl+6QKco/nv8B/Sk9+zwFX9NajrztjZkgwtR+h8zmzh0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxBajjxqHfnM7HQEOi6/uBpH6EmC96DfVn1f9o2yQjri+XoJOwa
	ruxpbRQ6SEjwX/tFDshF6bb0RS946TRF/YhllyU1MQUn3xBypJM+
X-Gm-Gg: ASbGncutKuPSvghUCvJTvz/x3JcPJZwJX4XqIvSwR1auO0/mKfUs3KE8LppoL2iXWAK
	4zjPpcNUQj92PJlZrkdbCkfpLJxaAglxRd3VYtzKlcJ/qO+TMqGeK3pyhnPc7a3jreGCZmm/Pxg
	4sapcDImObnXpZ02fka2se7T6TPvOSWQaEUECbPX9QlLD1hwwFntBUbH5vViQX6V+0Df4a2Hf13
	tmn9erE9BNrySbbAZbdj+xdE/aOIvzcWrPpLHoags75UzLa7p3lbvjyL0P3p7mWRRkoefCAasjt
	BlbePXKHjw3nOWxd+9z3o1ZykZjGBYC2jny9IRJRoPd3cKX7IOV2qrVoswsYp0b1EPlnSJtPo8o
	CDRVmjFwCjkwo3KMRAz8GugPt7nO+1YnMKmcnLgu1uk6P8YC1rMhv4sC3966g0Fw=
X-Google-Smtp-Source: AGHT+IGZrLPyzUFrsmUJ6bjiHKaOKcN6z3XUtUDmp1EbfQa4TkA4lIxe1N3KZXeS7nHJqoz8wrbu6w==
X-Received: by 2002:a17:906:4795:b0:ac1:fa6f:4941 with SMTP id a640c23a62f3a-ac330253720mr766195566b.13.1742068927072;
        Sat, 15 Mar 2025 13:02:07 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a489c9sm411456766b.152.2025.03.15.13.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:02:06 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v10 nf-next 3/3] bridge: No DEV_PATH_BR_VLAN_UNTAG_HW for dsa foreign
Date: Sat, 15 Mar 2025 21:01:47 +0100
Message-ID: <20250315200147.18016-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250315200147.18016-1-ericwouds@gmail.com>
References: <20250315200147.18016-1-ericwouds@gmail.com>
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
index 1054b8a88edc..43f04bd69d73 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -180,6 +180,7 @@ enum {
 	BR_VLFLAG_MCAST_ENABLED = BIT(2),
 	BR_VLFLAG_GLOBAL_MCAST_ENABLED = BIT(3),
 	BR_VLFLAG_NEIGH_SUPPRESS_ENABLED = BIT(4),
+	BR_VLFLAG_TAGGING_BY_SWITCHDEV = BIT(5),
 };
 
 /**
@@ -2182,6 +2183,8 @@ void br_switchdev_mdb_notify(struct net_device *dev,
 			     int type);
 int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
 			       bool changed, struct netlink_ext_ack *extack);
+int br_switchdev_port_vlan_no_foreign_add(struct net_device *dev, u16 vid, u16 flags,
+					  bool changed, struct netlink_ext_ack *extack);
 int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid);
 void br_switchdev_init(struct net_bridge *br);
 
@@ -2265,6 +2268,13 @@ static inline int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid,
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
index d9a69ec9affe..6bfc7da10865 100644
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
@@ -1487,7 +1492,7 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
 
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

