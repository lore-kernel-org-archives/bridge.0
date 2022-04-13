Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0+d6Rov8cjDp4XASxWMxnkxwuD5Gq2aFtJ+v6sDjNGk=;
 b=E2vRYdVkMpOuOmuBfP6Oq6xxQ8AygCk0IigcDxqCSJmZqps/Xbyf6XW0O12cT1Oax4
 FiCB528iHFY03d7tXKx1d7N2lWiDg084eNkY9gq7shM2MIKG9UF5/64tnrZ3mpv2OI6e
 mV12s6jeyA6T8qTdawpgBxEpaf9xzc4JN48EHsKpzIF3Puf1xfFHkxbwqDOBfCUKcufz
 72d5o/qUEMspTt1BacW//JMc0IKjZixQER9i2DrxZEZHW1da2hBX9DWVs/SXN4DCMKMj
 t4gR2S79+YxQGdmMRFJdJ5nY175E47oT+YLWlr/jgqTtIN17mxndg0U/ui3nDbEhX3z9
 Zgrg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 13 Apr 2022 13:51:55 +0300
Message-Id: <20220413105202.2616106-6-razor@blackwall.org>
In-Reply-To: <20220413105202.2616106-1-razor@blackwall.org>
References: <20220413105202.2616106-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 05/12] net: rtnetlink: add bulk delete
	support flag
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

Add a new rtnl flag (RTNL_FLAG_BULK_DEL_SUPPORTED) which is used to
verify that the delete operation allows bulk object deletion. Also emit
a warning if anyone tries to set it for non-delete kind.

Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v4: new patch

 include/net/rtnetlink.h | 3 ++-
 net/core/rtnetlink.c    | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 0bf622409aaa..bf8bb3357825 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -10,7 +10,8 @@ typedef int (*rtnl_doit_func)(struct sk_buff *, struct nlmsghdr *,
 typedef int (*rtnl_dumpit_func)(struct sk_buff *, struct netlink_callback *);
 
 enum rtnl_link_flags {
-	RTNL_FLAG_DOIT_UNLOCKED = BIT(0),
+	RTNL_FLAG_DOIT_UNLOCKED		= BIT(0),
+	RTNL_FLAG_BULK_DEL_SUPPORTED	= BIT(1),
 };
 
 enum rtnl_kinds {
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index beda4a7da062..63c7df52a667 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -249,6 +249,8 @@ static int rtnl_register_internal(struct module *owner,
 	if (dumpit)
 		link->dumpit = dumpit;
 
+	WARN_ON(rtnl_msgtype_kind(msgtype) != RTNL_KIND_DEL &&
+		(flags & RTNL_FLAG_BULK_DEL_SUPPORTED));
 	link->flags |= flags;
 
 	/* publish protocol:msgtype */
@@ -6009,6 +6011,12 @@ static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	flags = link->flags;
+	if (kind == RTNL_KIND_DEL && (nlh->nlmsg_flags & NLM_F_BULK) &&
+	    !(flags & RTNL_FLAG_BULK_DEL_SUPPORTED)) {
+		NL_SET_ERR_MSG(extack, "Bulk delete is not supported");
+		goto err_unlock;
+	}
+
 	if (flags & RTNL_FLAG_DOIT_UNLOCKED) {
 		doit = link->doit;
 		rcu_read_unlock();
-- 
2.35.1

