Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=punCyQ5OlXSnY/goe5W8EQLjKTFZYGXPlnRQPpJuU2Q=;
 b=rU+fyBOGNDPr41fXvuDQ0DkGPCf1V24jkzQmDG4PWUkq88+kD3HhGIYVegC/JyoPqU
 XEa1rdx32WiRjGTEixr8QcvgVUojKKc4Wu/e5Kr4KvGoG+ryx12eTlBFSLL58BpcBli0
 bUontmhkN/fG+g5hWkUlF8BZG1rD+vMA26GZF3r2luCDetHYxAwgA/5VY7IFiJZGrbQA
 jyMMz1pSAKz2Im0DEqtUZvCh+C8QATupt8gsqfJVWx62ebvLDxo+zxQ4niXNuGUQrw7B
 yawFY7R9Xs3rB0jEXSX7pbbASlGW30LrJDMxT784poSUYHtJHU9pK3Y76RnG1AKuRKiZ
 xyLg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 13 Apr 2022 13:51:51 +0300
Message-Id: <20220413105202.2616106-2-razor@blackwall.org>
In-Reply-To: <20220413105202.2616106-1-razor@blackwall.org>
References: <20220413105202.2616106-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 01/12] net: rtnetlink: add msg kind
	names
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>, dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Add rtnl kind names instead of using raw values. We'll need to
check for DEL kind later to validate bulk flag support.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v4: new patch

 include/net/rtnetlink.h | 7 +++++++
 net/core/rtnetlink.c    | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 9f48733bfd21..78712b51f3da 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -13,6 +13,13 @@ enum rtnl_link_flags {
 	RTNL_FLAG_DOIT_UNLOCKED = 1,
 };
 
+enum rtnl_kinds {
+	RTNL_KIND_NEW,
+	RTNL_KIND_DEL,
+	RTNL_KIND_GET,
+	RTNL_KIND_SET
+};
+
 void rtnl_register(int protocol, int msgtype,
 		   rtnl_doit_func, rtnl_dumpit_func, unsigned int flags);
 int rtnl_register_module(struct module *owner, int protocol, int msgtype,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 4041b3e2e8ec..2c36c9dc9b62 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5928,11 +5928,11 @@ static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct net *net = sock_net(skb->sk);
 	struct rtnl_link *link;
+	enum rtnl_kinds kind;
 	struct module *owner;
 	int err = -EOPNOTSUPP;
 	rtnl_doit_func doit;
 	unsigned int flags;
-	int kind;
 	int family;
 	int type;
 
@@ -5949,11 +5949,11 @@ static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	family = ((struct rtgenmsg *)nlmsg_data(nlh))->rtgen_family;
 	kind = type&3;
 
-	if (kind != 2 && !netlink_net_capable(skb, CAP_NET_ADMIN))
+	if (kind != RTNL_KIND_GET && !netlink_net_capable(skb, CAP_NET_ADMIN))
 		return -EPERM;
 
 	rcu_read_lock();
-	if (kind == 2 && nlh->nlmsg_flags&NLM_F_DUMP) {
+	if (kind == RTNL_KIND_GET && (nlh->nlmsg_flags & NLM_F_DUMP)) {
 		struct sock *rtnl;
 		rtnl_dumpit_func dumpit;
 		u32 min_dump_alloc = 0;
-- 
2.35.1

