Return-Path: <joerg@higgsboson.tk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=higgsboson.tk;
	s=default; t=1425453591;
	bh=Fut0x037dMl76tquzDIDr7euHxM50/Lho1rJk4kNQDM=;
	h=From:To:Cc:Subject:Date:From;
	b=iBmYnL/+M2COxWPgpZL25LFCkmYMLhxbP6BBvkVtuVU1IlveYWtqzLasWshBRL2cf
	pfV5ESdPpfkAu4xzbHO8kwnCt7q0DHzQXguFeNPlEH5+fi9DwlfA1zQU44/Po0pVAk
	4Wd1kp6NSbtmJiGIuMRLLvAC7sPnECvSW6YIOrhk=
From: "joerg@higgsboson.tk" <joerg@higgsboson.tk>
Date: Wed,  4 Mar 2015 07:19:47 +0000
Message-Id: <1425453587-2146-1-git-send-email-joerg@higgsboson.tk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] bridge: add ageing_time, stp_state,
	priority over netlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org

From: Jörg Thalheim <joerg@higgsboson.tk>

Signed-off-by: Jörg Thalheim <joerg@higgsboson.tk>
---
 include/uapi/linux/if_link.h |  3 +++
 net/bridge/br_netlink.c      | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index dfd0bb2..ca5d838 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -224,6 +224,9 @@ enum {
 	IFLA_BR_FORWARD_DELAY,
 	IFLA_BR_HELLO_TIME,
 	IFLA_BR_MAX_AGE,
+	IFLA_BR_AGEING_TIME,
+	IFLA_BR_STP_STATE,
+	IFLA_BR_PRIORITY,
 	__IFLA_BR_MAX,
 };
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 3de0eef..13ffb66 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -728,6 +728,9 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
 	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
 	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
 	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },
+	[IFLA_BR_AGEING_TIME] = { .type = NLA_U32 },
+	[IFLA_BR_STP_STATE] = { .type = NLA_U32 },
+	[IFLA_BR_PRIORITY] = { .type = NLA_U16 },
 };
 
 static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
@@ -757,6 +760,24 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BR_AGEING_TIME]) {
+		u32 ageing_time = nla_get_u32(data[IFLA_BR_AGEING_TIME]);
+
+		br->ageing_time = clock_t_to_jiffies(ageing_time);
+	}
+
+	if (data[IFLA_BR_STP_STATE]) {
+		u32 stp_enabled = nla_get_u32(data[IFLA_BR_STP_STATE]);
+
+		br_stp_set_enabled(br, stp_enabled);
+	}
+
+	if (data[IFLA_BR_PRIORITY]) {
+		u32 priority = nla_get_u16(data[IFLA_BR_PRIORITY]);
+
+		br_stp_set_bridge_priority(br, priority);
+	}
+
 	return 0;
 }
 
@@ -765,6 +786,9 @@ static size_t br_get_size(const struct net_device *brdev)
 	return nla_total_size(sizeof(u32)) +	/* IFLA_BR_FORWARD_DELAY  */
 	       nla_total_size(sizeof(u32)) +	/* IFLA_BR_HELLO_TIME */
 	       nla_total_size(sizeof(u32)) +	/* IFLA_BR_MAX_AGE */
+	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_AGEING_TIME */
+	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_STP_STATE */
+	       nla_total_size(sizeof(u16)) +    /* IFLA_BR_PRIORITY */
 	       0;
 }
 
@@ -774,10 +798,16 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	u32 forward_delay = jiffies_to_clock_t(br->forward_delay);
 	u32 hello_time = jiffies_to_clock_t(br->hello_time);
 	u32 age_time = jiffies_to_clock_t(br->max_age);
+	u32 ageing_time = jiffies_to_clock_t(br->ageing_time);
+	u32 stp_enabled = br->stp_enabled;
+	u16 priority = (br->bridge_id.prio[0] << 8) | br->bridge_id.prio[1];
 
 	if (nla_put_u32(skb, IFLA_BR_FORWARD_DELAY, forward_delay) ||
 	    nla_put_u32(skb, IFLA_BR_HELLO_TIME, hello_time) ||
-	    nla_put_u32(skb, IFLA_BR_MAX_AGE, age_time))
+	    nla_put_u32(skb, IFLA_BR_MAX_AGE, age_time) ||
+	    nla_put_u32(skb, IFLA_BR_AGEING_TIME, ageing_time) ||
+	    nla_put_u32(skb, IFLA_BR_STP_STATE, stp_enabled) ||
+	    nla_put_u16(skb, IFLA_BR_PRIORITY, priority))
 		return -EMSGSIZE;
 
 	return 0;
-- 
2.3.1

