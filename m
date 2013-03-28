Return-Path: <honkiko@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=+8y6lKOID5sBbmb4oSaXEGCsTczq0xuZ8lzZwy94bwY=;
	b=nU0zuZ95tGGIeGFSXd/8QzvAlySu3+szVjvtgKIyndpvwnKhyk2Egb1Qdgcj2NSQ9F
	JmEJb2q/jSHfXs/ybCVfKQ/3bjDasfZCeyUI8W+MK9xNOiBlSIc9Tf7BVQj3RXXkNoKI
	qGEevYS4OSzboKO2BbwdXN1V+PfkJfZ1CWuz7az5Vj45viv5Dm/9ZcQZuIiDVL88XZBW
	BjU4BzloHmQ1uz+V/cRW3ojRl46jtDKMvTX+HIhNvwP9guYzg0NC0uS/N91/ZPZeLLuj
	WaqpTjOHKRBEV2piqu6UVDZiPZB0viZqiBzkiKdJ8HO4AmUoCwWK6LM1WOQurczjChUn
	2DAw==
From: Hong Zhiguo <honkiko@gmail.com>
Date: Fri, 29 Mar 2013 00:21:22 +0800
Message-Id: <1364487682-5839-1-git-send-email-honkiko@gmail.com>
Subject: [Bridge] [PATCH net-next] bridge: remove unused variable ifm
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org, bridge@lists.linux-foundation.org, davem@davemloft.net

Signed-off-by: Hong Zhiguo <honkiko@gmail.com>
---
 net/bridge/br_netlink.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index b96e02e..8e3abf5 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -352,17 +352,14 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[])
 /* Change state and parameters on port. */
 int br_setlink(struct net_device *dev, struct nlmsghdr *nlh)
 {
-	struct ifinfomsg *ifm;
 	struct nlattr *protinfo;
 	struct nlattr *afspec;
 	struct net_bridge_port *p;
 	struct nlattr *tb[IFLA_BRPORT_MAX + 1];
 	int err = 0;
 
-	ifm = nlmsg_data(nlh);
-
-	protinfo = nlmsg_find_attr(nlh, sizeof(*ifm), IFLA_PROTINFO);
-	afspec = nlmsg_find_attr(nlh, sizeof(*ifm), IFLA_AF_SPEC);
+	protinfo = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_PROTINFO);
+	afspec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
 	if (!protinfo && !afspec)
 		return 0;
 
@@ -411,14 +408,11 @@ out:
 /* Delete port information */
 int br_dellink(struct net_device *dev, struct nlmsghdr *nlh)
 {
-	struct ifinfomsg *ifm;
 	struct nlattr *afspec;
 	struct net_bridge_port *p;
 	int err;
 
-	ifm = nlmsg_data(nlh);
-
-	afspec = nlmsg_find_attr(nlh, sizeof(*ifm), IFLA_AF_SPEC);
+	afspec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
 	if (!afspec)
 		return 0;
 
-- 
1.7.10.4

