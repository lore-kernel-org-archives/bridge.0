Return-Path: <komachi.yoshiki@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WD31emG5AAw62cTFIzmY9OBwp6Qx1m67HwbYW6jOzgE=;
 b=Fwn4fVpIuOoiY6zQvbpgMCZzaLl4zm5qe1vcnKdKkipMxP8rnrEnNmarXXW2F4251W
 OuOcoCTWnnG7RJOBGbpCpl7VFICmd6rktak1eV2hL+YKaPj74PK2wemOGPCAIpWTAlsD
 s9pCQcj2W5ErTSrqlp6pkn2Tzj8EbAA5QIxVNYiew5xpGC2iH87AsfRkSRYAkKoz74cz
 JfZOIXzscNbFvLquroOiEG8zS9VfZiMt3bywjxx9RcoHr1rwb1k7fw9KDT7x1iR39X7j
 AFejoRKZvZy90KeIVo/YIjcWN1qGox6/8MUj6yxY+4Lc03xXyALCyh763BLEt+XKYnEO
 IQEg==
From: Yoshiki Komachi <komachi.yoshiki@gmail.com>
Date: Fri, 31 Jul 2020 13:44:18 +0900
Message-Id: <1596170660-5582-2-git-send-email-komachi.yoshiki@gmail.com>
In-Reply-To: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
References: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
Subject: [Bridge] [RFC PATCH bpf-next 1/3] net/bridge: Add new function to
	access FDB from XDP programs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, KP Singh <kpsingh@chromium.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, bridge@lists.linux-foundation.org, Yoshiki Komachi <komachi.yoshiki@gmail.com>

This patch adds a function to find the destination port from the
FDB in the kernel tables, which mainly helps XDP programs to access
FDB in the kernel via bpf helper. Note that, unlike the existing
br_fdb_find_port(), this function takes an ingress device as an
argument.

The br_fdb_find_port() also enables us to access FDB in the kernel,
and rcu_read_lock()/rcu_read_unlock() must be called in the function.
But, these are unnecessary in that cases because XDP programs have
to call APIs with rcu_read_lock()/rcu_read_unlock(). Thus, proposed
function could be used without these locks in the function.

Signed-off-by: Yoshiki Komachi <komachi.yoshiki@gmail.com>
---
 include/linux/if_bridge.h | 11 +++++++++++
 net/bridge/br_fdb.c       | 25 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 6479a38e52fa..24d72d115d0b 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -127,6 +127,9 @@ static inline int br_vlan_get_info(const struct net_device *dev, u16 vid,
 struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 				    const unsigned char *addr,
 				    __u16 vid);
+struct net_device *br_fdb_find_port_xdp(const struct net_device *dev,
+				    const unsigned char *addr,
+				    __u16 vid);
 void br_fdb_clear_offload(const struct net_device *dev, u16 vid);
 bool br_port_flag_is_set(const struct net_device *dev, unsigned long flag);
 #else
@@ -138,6 +141,14 @@ br_fdb_find_port(const struct net_device *br_dev,
 	return NULL;
 }
 
+static inline struct net_device *
+br_fdb_find_port_xdp(const struct net_device *dev,
+				    const unsigned char *addr,
+				    __u16 vid);
+{
+	return NULL;
+}
+
 static inline void br_fdb_clear_offload(const struct net_device *dev, u16 vid)
 {
 }
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 9db504baa094..79bc3c2da668 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -141,6 +141,31 @@ struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 }
 EXPORT_SYMBOL_GPL(br_fdb_find_port);
 
+struct net_device *br_fdb_find_port_xdp(const struct net_device *dev,
+				    const unsigned char *addr,
+				    __u16 vid)
+{
+	struct net_bridge_fdb_entry *f;
+	struct net_device *dst = NULL;
+	struct net_bridge *br = NULL;
+	struct net_bridge_port *p;
+
+	p = br_port_get_check_rcu(dev);
+	if (!p)
+		return NULL;
+
+	br = p->br;
+	if (!br)
+		return NULL;
+
+	f = br_fdb_find_rcu(br, addr, vid);
+	if (f && f->dst)
+		dst = f->dst->dev;
+
+	return dst;
+}
+EXPORT_SYMBOL_GPL(br_fdb_find_port_xdp);
+
 struct net_bridge_fdb_entry *br_fdb_find_rcu(struct net_bridge *br,
 					     const unsigned char *addr,
 					     __u16 vid)
-- 
2.20.1 (Apple Git-117)

