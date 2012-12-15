Return-Path: <amwang@redhat.com>
From: Cong Wang <amwang@redhat.com>
Date: Sat, 15 Dec 2012 16:09:50 +0800
Message-Id: <1355558992-32285-1-git-send-email-amwang@redhat.com>
Subject: [Bridge] [PATCH 1/2] bridge: update selinux perm table for
	RTM_NEWMDB and RTM_DELMDB
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, Cong Wang <amwang@redhat.com>, "David S. Miller" <davem@davemloft.net>

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Stephen Hemminger <shemminger@vyatta.com>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Cong Wang <amwang@redhat.com>

---
 security/selinux/nlmsgtab.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 370a646..855e464 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -69,6 +69,8 @@ static struct nlmsg_perm nlmsg_route_perms[] =
 	{ RTM_SETDCB,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_NEWNETCONF,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_GETNETCONF,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_NEWMDB,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELMDB,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE  },
 	{ RTM_GETMDB,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
 };
 
-- 
1.7.7.6

