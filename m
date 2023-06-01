Return-Path: <stephen@networkplumber.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 332CC40610
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 308834053C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1685640117;
 x=1688232117; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9j3narrsxe03huzqvKsSsW9jWi72TLYmmQBkxj0a2/Q=;
 b=KEYx5twPd+O8SA7JfI1OmQDyCGO+RfmBgA8+b1bhzTRsdGE5JXm9ZjX2I3zNs36QNt
 MSNrFV/EPqv1rlH276g+w3nC3+YVr6lJyuuxhk9kKU1JoY9CqaVxwK9oHiblKSXDGQPV
 owM5/BpCr71G9me5zvSAZR9S9o98TxxBm/LMCV9DkpRkInxblJ+4c5OcsmNbBsmis4OM
 29VL1cZXTCadFvyzP5YoZUwJEVmoSDj5qJgi1IduQcS1CfV9dP+Pe6pKe18fiO4xyA63
 XquN9N8CWLsSHKOKutjbAOHAQN3O0TNpa9mGasAjYj5j//Bx9knWhHbFEMUDiHFge5sh
 fSYA==
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu,  1 Jun 2023 10:21:41 -0700
Message-Id: <20230601172145.51357-4-stephen@networkplumber.org>
In-Reply-To: <20230601172145.51357-1-stephen@networkplumber.org>
References: <20230601172145.51357-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH iproute2 3/7] bridge: make print_vlan_info static
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>

Function defined and used in only one file.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 bridge/br_common.h | 1 -
 bridge/vlan.c      | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bridge/br_common.h b/bridge/br_common.h
index 1bdee65844c1..704e76b0acb2 100644
--- a/bridge/br_common.h
+++ b/bridge/br_common.h
@@ -6,7 +6,6 @@
 #define MDB_RTR_RTA(r) \
 		((struct rtattr *)(((char *)(r)) + RTA_ALIGN(sizeof(__u32))))
 
-void print_vlan_info(struct rtattr *tb, int ifindex);
 int print_linkinfo(struct nlmsghdr *n, void *arg);
 int print_mdb_mon(struct nlmsghdr *n, void *arg);
 int print_fdb(struct nlmsghdr *n, void *arg);
diff --git a/bridge/vlan.c b/bridge/vlan.c
index 5b304ea94224..dfc62f83a5df 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -18,6 +18,7 @@
 
 static unsigned int filter_index, filter_vlan;
 static int vlan_rtm_cur_ifidx = -1;
+static void print_vlan_info(struct rtattr *tb, int ifindex);
 
 enum vlan_show_subject {
 	VLAN_SHOW_VLAN,
@@ -1309,7 +1310,7 @@ static int vlan_global_show(int argc, char **argv)
 	return 0;
 }
 
-void print_vlan_info(struct rtattr *tb, int ifindex)
+static void print_vlan_info(struct rtattr *tb, int ifindex)
 {
 	struct rtattr *i, *list = tb;
 	int rem = RTA_PAYLOAD(list);
-- 
2.39.2

