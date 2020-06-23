Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kDvcE8bgVLnQmVLk1Xzq+JHO7t/A7+JPYOpEZQ7t0NQ=;
 b=WJ7ugitIgMYh9Ww55r4ot8/2Nm8x2Kyn1/BxY+UkEcHeXa9LlBXrjycJ/rp+twNWd9
 5D+0TPnNsCc5dojT+du6DUvapnbpyj2HQvmjM/ToERVKR+edYUnvr8+u0WneWvZAq0Zt
 qixCGtvJzNYDMKs8uclC0wcv2hfS2TDUxVW9Q=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 23 Jun 2020 23:47:16 +0300
Message-Id: <20200623204718.1057508-3-nikolay@cumulusnetworks.com>
In-Reply-To: <20200623204718.1057508-1-nikolay@cumulusnetworks.com>
References: <20200623204718.1057508-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/4] net: neighbor: add fdb extended
	attribute
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, anuradhak@cumulusnetworks.com

Add an attribute to NDA which will contain all future fdb-specific
attributes in order to avoid polluting the NDA namespace with e.g.
bridge or vxlan specific attributes. The attribute is called
NDA_FDB_EXT_ATTRS and the structure would look like:
 [NDA_FDB_EXT_ATTRS] = {
    [NFEA_xxx]
 }

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/neighbour.h | 12 ++++++++++++
 net/core/neighbour.c           |  1 +
 2 files changed, 13 insertions(+)

diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index eefcda8ca44e..540ff48402a1 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -30,6 +30,7 @@ enum {
 	NDA_SRC_VNI,
 	NDA_PROTOCOL,  /* Originator of entry */
 	NDA_NH_ID,
+	NDA_FDB_EXT_ATTRS,
 	__NDA_MAX
 };
 
@@ -172,4 +173,15 @@ enum {
 };
 #define NDTA_MAX (__NDTA_MAX - 1)
 
+/* embedded into NDA_FDB_EXT_ATTRS:
+ * [NDA_FDB_EXT_ATTRS] = {
+ *     ...
+ * }
+ */
+enum {
+	NFEA_UNSPEC,
+	__NFEA_MAX
+};
+#define NFEA_MAX (__NFEA_MAX - 1)
+
 #endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index ef6b5a8f629c..8e39e28b0a8d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1783,6 +1783,7 @@ const struct nla_policy nda_policy[NDA_MAX+1] = {
 	[NDA_MASTER]		= { .type = NLA_U32 },
 	[NDA_PROTOCOL]		= { .type = NLA_U8 },
 	[NDA_NH_ID]		= { .type = NLA_U32 },
+	[NDA_FDB_EXT_ATTRS]	= { .type = NLA_NESTED },
 };
 
 static int neigh_delete(struct sk_buff *skb, struct nlmsghdr *nlh,
-- 
2.25.4

