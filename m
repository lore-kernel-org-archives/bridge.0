Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BbnHd4o5vqqdVnPqrILq5Jq5sTNcgygmX2gIAOpm4mw=;
 b=q3Rk/2KB7HFk7J7NZDNTLPkXze8TdzSBWoDcZfcs8MVwnGlLHHKepzt+ioTyPh9U5K
 e6UiYrM/hkvDQyjqwUoqegngxb7Sp1GMfJ9L6kNFzRamoetEIZ57i41+2CWhdx/omzrr
 5JoZzAzynleDl1MKk9KGO/pFfGIExlENek3seJD6BwB35giZPiEfvRkQcfkPKm/4SKfC
 c8Fb4fah5m4Y1idIi7UShlRDBgRCH89U6XkycmNr9cPt1RbiMJlW1QU3a57+IjoZn+pf
 +9ibxwmRLBKEMd8N94SyTsia7FOX5Cel1IiDLhw0fq6ks3pq7n1aeyPSh5Xa10rPchk0
 OrxA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 13 Apr 2022 13:51:52 +0300
Message-Id: <20220413105202.2616106-3-razor@blackwall.org>
In-Reply-To: <20220413105202.2616106-1-razor@blackwall.org>
References: <20220413105202.2616106-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 02/12] net: rtnetlink: add helper to
	extract msg type's kind
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

Add a helper which extracts the msg type's kind using the kind mask (0x3).

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v4: new patch

 include/net/rtnetlink.h | 6 ++++++
 net/core/rtnetlink.c    | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 78712b51f3da..c51c5ff7f7e2 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -19,6 +19,12 @@ enum rtnl_kinds {
 	RTNL_KIND_GET,
 	RTNL_KIND_SET
 };
+#define RTNL_KIND_MASK 0x3
+
+static inline enum rtnl_kinds rtnl_msgtype_kind(int msgtype)
+{
+	return msgtype & RTNL_KIND_MASK;
+}
 
 void rtnl_register(int protocol, int msgtype,
 		   rtnl_doit_func, rtnl_dumpit_func, unsigned int flags);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 2c36c9dc9b62..beda4a7da062 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5947,7 +5947,7 @@ static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return 0;
 
 	family = ((struct rtgenmsg *)nlmsg_data(nlh))->rtgen_family;
-	kind = type&3;
+	kind = rtnl_msgtype_kind(type);
 
 	if (kind != RTNL_KIND_GET && !netlink_net_capable(skb, CAP_NET_ADMIN))
 		return -EPERM;
-- 
2.35.1

