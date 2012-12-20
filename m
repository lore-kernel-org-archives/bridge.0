Return-Path: <amwang@redhat.com>
From: Cong Wang <amwang@redhat.com>
Date: Thu, 20 Dec 2012 22:31:55 +0800
Message-Id: <1356013915-20835-3-git-send-email-amwang@redhat.com>
In-Reply-To: <1356013915-20835-1-git-send-email-amwang@redhat.com>
References: <1356013915-20835-1-git-send-email-amwang@redhat.com>
Subject: [Bridge] [PATCH 3/3] iproute2: make `bridge mdb` output consistent
	with input
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, Cong Wang <amwang@redhat.com>

bridge -> dev
group -> grp

Cc: Stephen Hemminger <shemminger@vyatta.com>
Signed-off-by: Cong Wang <amwang@redhat.com>
---
 bridge/mdb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bridge/mdb.c b/bridge/mdb.c
index 6217c5f..81d479b 100644
--- a/bridge/mdb.c
+++ b/bridge/mdb.c
@@ -53,12 +53,12 @@ static void print_mdb_entry(FILE *f, int ifindex, struct br_mdb_entry *e)
 	SPRINT_BUF(abuf);
 
 	if (e->addr.proto == htons(ETH_P_IP))
-		fprintf(f, "bridge %s port %s group %s %s\n", ll_index_to_name(ifindex),
+		fprintf(f, "dev %s port %s grp %s %s\n", ll_index_to_name(ifindex),
 			ll_index_to_name(e->ifindex),
 			inet_ntop(AF_INET, &e->addr.u.ip4, abuf, sizeof(abuf)),
 			(e->state & MDB_PERMANENT) ? "permanent" : "temp");
 	else
-		fprintf(f, "bridge %s port %s group %s %s\n", ll_index_to_name(ifindex),
+		fprintf(f, "dev %s port %s grp %s %s\n", ll_index_to_name(ifindex),
 			ll_index_to_name(e->ifindex),
 			inet_ntop(AF_INET6, &e->addr.u.ip6, abuf, sizeof(abuf)),
 			(e->state & MDB_PERMANENT) ? "permanent" : "temp");
-- 
1.7.7.6

