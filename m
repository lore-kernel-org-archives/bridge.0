Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=c4q1aukNB19Ywn0yhrK5YppHN0nN9ZnWCosl/BOVje8=;
 b=HBcQdLeyekvttOcqJyw/c2RfIJxEBHgYmtgQ3kD1Xz3683ZUW4Jw/KOKUVwlroPElG
 5pDByd9XOH/i5ZMoYANS4jS4pP9mrMVS7G47zk8KaWVoHvSthe7mHHXvQUkyF3aCESBH
 x09n0Nid2fsa8RCqAShcyHR01JqSdFESXgzUcBhrb+QkYTgHJ68TnVfuO6+4q56JUoDH
 lxpqApIUbHTlc+9iMYXHRw5kK0teaRUsJ1STRRsgWdv27ygQy6nJJK8dAtqBuhIEFsJA
 qQKcS21luVzhyRr8UEBQs/KsUp111+G7zevtkBdtwFjmtB2NLV3y2L5MGJonrAuKoKEJ
 0hPA==
From: Hans Schultz <schultz.hans@gmail.com>
Date: Thu, 17 Mar 2022 10:38:59 +0100
Message-Id: <20220317093902.1305816-2-schultz.hans+netdev@gmail.com>
In-Reply-To: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
References: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 net-next 1/4] net: bridge: add fdb flag to
	extent locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

Add an intermediate state for clients behind a locked port to allow for
possible opening of the port for said clients. This feature corresponds
to the Mac-Auth and MAC Authentication Bypass (MAB) named features. The
latter defined by Cisco.
Only the kernel can set this FDB entry flag, while userspace can read
the flag and remove it by deleting the FDB entry.

Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
---
 include/uapi/linux/neighbour.h |  1 +
 net/bridge/br_fdb.c            |  6 ++++++
 net/bridge/br_input.c          | 10 +++++++++-
 net/bridge/br_private.h        |  3 ++-
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index db05fb55055e..a2df3b9b2f68 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -51,6 +51,7 @@ enum {
 #define NTF_ROUTER	(1 << 7)
 /* Extended flags under NDA_FLAGS_EXT: */
 #define NTF_EXT_MANAGED	(1 << 0)
+#define NTF_EXT_LOCKED	(1 << 1)
 
 /*
  *	Neighbor Cache Entry States.
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 6ccda68bd473..57ec559a85a7 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -105,6 +105,7 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
 	struct nda_cacheinfo ci;
 	struct nlmsghdr *nlh;
 	struct ndmsg *ndm;
+	u8 ext_flags = 0;
 
 	nlh = nlmsg_put(skb, portid, seq, type, sizeof(*ndm), flags);
 	if (nlh == NULL)
@@ -125,11 +126,16 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
 		ndm->ndm_flags |= NTF_EXT_LEARNED;
 	if (test_bit(BR_FDB_STICKY, &fdb->flags))
 		ndm->ndm_flags |= NTF_STICKY;
+	if (test_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags))
+		ext_flags |= NTF_EXT_LOCKED;
 
 	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->key.addr))
 		goto nla_put_failure;
 	if (nla_put_u32(skb, NDA_MASTER, br->dev->ifindex))
 		goto nla_put_failure;
+	if (nla_put_u8(skb, NDA_FLAGS_EXT, ext_flags))
+		goto nla_put_failure;
+
 	ci.ndm_used	 = jiffies_to_clock_t(now - fdb->used);
 	ci.ndm_confirmed = 0;
 	ci.ndm_updated	 = jiffies_to_clock_t(now - fdb->updated);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index e0c13fcc50ed..5ef25a496806 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -94,8 +94,16 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
 
 		if (!fdb_src || READ_ONCE(fdb_src->dst) != p ||
-		    test_bit(BR_FDB_LOCAL, &fdb_src->flags))
+		    test_bit(BR_FDB_LOCAL, &fdb_src->flags) ||
+		    test_bit(BR_FDB_ENTRY_LOCKED, &fdb_src->flags)) {
+			if (!fdb_src) {
+				unsigned long flags = 0;
+
+				set_bit(BR_FDB_ENTRY_LOCKED, &flags);
+				br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, flags);
+			}
 			goto drop;
+		}
 	}
 
 	nbp_switchdev_frame_mark(p, skb);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 48bc61ebc211..f5a0b68c4857 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -248,7 +248,8 @@ enum {
 	BR_FDB_ADDED_BY_EXT_LEARN,
 	BR_FDB_OFFLOADED,
 	BR_FDB_NOTIFY,
-	BR_FDB_NOTIFY_INACTIVE
+	BR_FDB_NOTIFY_INACTIVE,
+	BR_FDB_ENTRY_LOCKED,
 };
 
 struct net_bridge_fdb_key {
-- 
2.30.2

