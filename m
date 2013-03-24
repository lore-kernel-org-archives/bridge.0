Return-Path: <honkiko@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
	:references; bh=cMDemWMUSz//usQGMoMExOzFewbmOBXPTVb0waVpSeg=;
	b=HYkdA/uCWo9fQJ0v9SSkGUGiAI+QjA6FsEg5wLXpv0pIQQO9Z+29IbC28nW5zAnE2z
	cnUnW0EnjMenjLz8INmzdh6YrABcCFJ4vd4MlEpXCFnSIPK6xZt7/Jp9D3l5S/YhkzGS
	La2JClJtTsMOT9yOB5obPp5ruS0PJs8IY7wx++P4CkNDjlau3ZDWSUj3JWFqu4SjXc4c
	9yTclJaynRd3di4S8G+7QngR+e5TX+XP+C7RKBKWcBo5oqWo+oRxVsR2vvmzwJmm5gl3
	n7CNAWaOStkl6PNKSB6+/T9/bdpSn3nvoiFBnPW67j5T+zCrvcHRku+v++xdCeumCViv
	caFw==
From: Hong Zhiguo <honkiko@gmail.com>
Date: Sun, 24 Mar 2013 21:26:47 +0800
Message-Id: <1364131607-11698-1-git-send-email-honkiko@gmail.com>
In-Reply-To: <1364015653-7322-1-git-send-email-honkiko@gmail.com>
References: <1364015653-7322-1-git-send-email-honkiko@gmail.com>
Subject: [Bridge] [PATCH net-next] bridge: avoid br_ifinfo_notify when
	nothing changed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: sergei.shtylyov@cogentembedded.com, bridge@lists.linux-foundation.org, zhiguo.hong@emc.com, Hong Zhiguo <honkiko@gmail.com>, stephen@networkplumber.org, herbert@gondor.hengli.com.au, davem@davemloft.net

When neither IFF_BRIDGE nor IFF_BRIDGE_PORT is set,
and afspec == NULL but  protinfo != NULL, we run into
"if (err == 0) br_ifinfo_notify(RTM_NEWLINK, p);" with
random value in ret.

Thanks to Sergei for pointing out the error in commit comments.

Signed-off-by: Hong Zhiguo <honkiko@gmail.com>
---
 net/bridge/br_netlink.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 84c3b7d..b96e02e 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -357,7 +357,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh)
 	struct nlattr *afspec;
 	struct net_bridge_port *p;
 	struct nlattr *tb[IFLA_BRPORT_MAX + 1];
-	int err;
+	int err = 0;
 
 	ifm = nlmsg_data(nlh);
 
@@ -370,7 +370,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh)
 	/* We want to accept dev as bridge itself if the AF_SPEC
 	 * is set to see if someone is setting vlan info on the brigde
 	 */
-	if (!p && ((dev->priv_flags & IFF_EBRIDGE) && !afspec))
+	if (!p && !afspec)
 		return -EINVAL;
 
 	if (p && protinfo) {
-- 
1.7.10.4

