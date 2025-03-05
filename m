Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE220FA83
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170623; cv=none; b=NJnqO60ynXUfV9NCF6ddlsbUTxKHdXY6nx8vdeKd6KfIyJTPNQiucZIx8PZIt+h5VYS/00nDkuj/hIxbtO5cIG4nOKzch0NCbjRzN5SfYPIfT194Z8mR+P1lEiBJC9nD/m5C+HvH02iJfNivgdpKgHJSQujsXyQJ53VN3vzZWxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170623; c=relaxed/simple;
	bh=7mcwChSKiCve0A+5TUtOf0dA+ljFl2navKj3ueTAL1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dorZCYmrl81Y3ewjBQYDKyCqDVkskLHE4Ea1O8G+Adac/+3ZLzOZ5ap5M6ILn0vDcIH0EeqfArm3GlpK9n0FNUc9Bp5NMycWo11ksJreCf2KjhtcSVNYzfv6b4oqAI1vObLbwzQsxDzUGaW8awXs9VE/MWycq4pq92dd9eKkC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoQctYZc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoQctYZc"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abf538f7be0so690003566b.3
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 02:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170619; x=1741775419; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGHKkM4qxKd9EB0pt79Yst8lznP4qD+tbsrDkGhaAL8=;
        b=KoQctYZcNIfU4Wwkf9u8NqQ5N3sdpm0Tyl4VrmpcS+UidgLS8nsu5ICZ6+TsIV1cVb
         5p4GI9oqstjC3ek7u9+i/wgW9AwmRlrRg12tZq+5mh5ob2sFoINVAcGyM2+n8WQIxfS6
         j2Y5KoXE0ZtcMBysd35jJHVyxdxGWVQZxJU7T0soIiZ4rRpLuQSPlgS0nyTQmXLBjI7j
         i4nclll6aNQDrh2fIL9LaEJJvJ9jczo0paP0d6PflHAcxUCSexoGafU6ASWonOCc0JQa
         aV48ocdnjTurIJBlSGKx2acSLVSIfX05S40ngW8GkI7OCGo62OvmBgeKLpwLOdsqr79k
         dyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170619; x=1741775419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGHKkM4qxKd9EB0pt79Yst8lznP4qD+tbsrDkGhaAL8=;
        b=T9IwVvLoV+4P/yNBES1XzeH/WSkJVY8WWTABph9Jq3gsksBVzhtXszVJi8FKpCCjkj
         1vPi+BFNEr0Zz8f2RmZDUSLNC4F2gWqI25FJ2fvHny2sRnq7mvG46mSKo93oPsAKDwwa
         UF09wNidN97Bgp1yoaaMJl3L4x1dl3DkhtAPGE8+fyajpSA9IH6UZXtfht3+yICU3vWV
         /MyWzTJegGF1uLCjCKlOf4rXUU6nGvwucxrvxxyYNf0knzlj8FnGLz2iRXWQ9xfNkl3s
         Y9vIo+Kl6LlqJyPoiBo9tkMI0QZJHtImagpxKBEEKdR6uJtFT68hqprOUesW1AYI64G4
         M44g==
X-Forwarded-Encrypted: i=1; AJvYcCXfKTypHV+6YrxzxOqwbrkHsBpKe4MYH2u/Q6KilML4dGDRMdsDt5Wf3O9Id3Dr2J/eJQOUeZg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzWOzEc9QGylA7tsDXhpj1iL1tG+CGF3HXu36yLe6aM5JYVuJGv
	uJYYQgZkAEj2tBFPvjx3V7QUa4QOTpeD5UliW1MVivIAgNMkhojV
X-Gm-Gg: ASbGncut4VmxoGyHj2I+oclpYmJPECFtks+FnXzirpPhRLC1daIgUw6xBNSgwFlmfKa
	CeZwaPTqzZ8VoaYdyFSclPCUkwSQapmRsF0SqK7EpuSJEk29zJc/od4WXE3szl6PR7CotW6TUli
	hsouHGBiOGQnRldLm54bIsd1/Ue83GEKSUB3FvnLtq5z0Il2SNod14dYqmm2/H7YmUkfj1SLLc2
	Hn/3yBlXEq631b3qhbv08S68KiWMU5min5PMbMuqyRYXjFQw9REHnXBgk9eNqDWFmaRmO5mv4JE
	x1sK98TG0mX8ZrBjMZuIttkEFIVSM2jikvm7Vu0zrmt7CS2S9cKPrJ0TWFcimMRlarp688+V7Kl
	ucJzECwQMoM/nJ9UZjYJ2yb7HsuYjYXdR5b5f+KodeSvkLS30kkEnjShvR9GMDw==
X-Google-Smtp-Source: AGHT+IGoN/CtSWTsLPGno4XdCpNX/tKcNpIlnQot0PcYBnAP4+pW8eJWUnu6a4Iy0Es/1rYM255M5w==
X-Received: by 2002:a17:907:da8:b0:ac1:ebfe:fd90 with SMTP id a640c23a62f3a-ac20d845965mr280745166b.1.1741170619182;
        Wed, 05 Mar 2025 02:30:19 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f7161a4esm247154266b.161.2025.03.05.02.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:30:18 -0800 (PST)
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
Subject: [PATCH v9 nf 13/15] bridge: No DEV_PATH_BR_VLAN_UNTAG_HW for dsa foreign
Date: Wed,  5 Mar 2025 11:29:47 +0100
Message-ID: <20250305102949.16370-14-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305102949.16370-1-ericwouds@gmail.com>
References: <20250305102949.16370-1-ericwouds@gmail.com>
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
index a0b950390a16..b950db453d8d 100644
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
index a18c7da12ebd..aea94d401a30 100644
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

