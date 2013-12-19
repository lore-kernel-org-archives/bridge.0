Return-Path: <tanxiaojun@huawei.com>
From: Tan Xiaojun <tanxiaojun@huawei.com>
Date: Thu, 19 Dec 2013 13:28:14 +0800
Message-ID: <1387430894-11220-6-git-send-email-tanxiaojun@huawei.com>
In-Reply-To: <1387430894-11220-1-git-send-email-tanxiaojun@huawei.com>
References: <1387430894-11220-1-git-send-email-tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH 5/5] bridge: change the position of '{' to the pre
	line
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org, davem@davemloft.net, bart.de.schuymer@pandora.be
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

That open brace { should be on the previous line.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 net/bridge/netfilter/ebtable_broute.c | 6 ++----
 net/bridge/netfilter/ebtable_filter.c | 9 +++------
 net/bridge/netfilter/ebtable_nat.c    | 9 +++------
 net/bridge/netfilter/ebtables.c       | 3 +--
 4 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/net/bridge/netfilter/ebtable_broute.c b/net/bridge/netfilter/ebtable_broute.c
index dbd1c78..d2cdf5d 100644
--- a/net/bridge/netfilter/ebtable_broute.c
+++ b/net/bridge/netfilter/ebtable_broute.c
@@ -23,8 +23,7 @@ static struct ebt_entries initial_chain = {
 	.policy		= EBT_ACCEPT,
 };
 
-static struct ebt_replace_kernel initial_table =
-{
+static struct ebt_replace_kernel initial_table = {
 	.name		= "broute",
 	.valid_hooks	= 1 << NF_BR_BROUTING,
 	.entries_size	= sizeof(struct ebt_entries),
@@ -41,8 +40,7 @@ static int check(const struct ebt_table_info *info, unsigned int valid_hooks)
 	return 0;
 }
 
-static const struct ebt_table broute_table =
-{
+static const struct ebt_table broute_table = {
 	.name		= "broute",
 	.table		= &initial_table,
 	.valid_hooks	= 1 << NF_BR_BROUTING,
diff --git a/net/bridge/netfilter/ebtable_filter.c b/net/bridge/netfilter/ebtable_filter.c
index bb2da7b..ce205aa 100644
--- a/net/bridge/netfilter/ebtable_filter.c
+++ b/net/bridge/netfilter/ebtable_filter.c
@@ -14,8 +14,7 @@
 #define FILTER_VALID_HOOKS ((1 << NF_BR_LOCAL_IN) | (1 << NF_BR_FORWARD) | \
    (1 << NF_BR_LOCAL_OUT))
 
-static struct ebt_entries initial_chains[] =
-{
+static struct ebt_entries initial_chains[] = {
 	{
 		.name	= "INPUT",
 		.policy	= EBT_ACCEPT,
@@ -30,8 +29,7 @@ static struct ebt_entries initial_chains[] =
 	},
 };
 
-static struct ebt_replace_kernel initial_table =
-{
+static struct ebt_replace_kernel initial_table = {
 	.name		= "filter",
 	.valid_hooks	= FILTER_VALID_HOOKS,
 	.entries_size	= 3 * sizeof(struct ebt_entries),
@@ -50,8 +48,7 @@ static int check(const struct ebt_table_info *info, unsigned int valid_hooks)
 	return 0;
 }
 
-static const struct ebt_table frame_filter =
-{
+static const struct ebt_table frame_filter = {
 	.name		= "filter",
 	.table		= &initial_table,
 	.valid_hooks	= FILTER_VALID_HOOKS,
diff --git a/net/bridge/netfilter/ebtable_nat.c b/net/bridge/netfilter/ebtable_nat.c
index bd238f1..a0ac298 100644
--- a/net/bridge/netfilter/ebtable_nat.c
+++ b/net/bridge/netfilter/ebtable_nat.c
@@ -14,8 +14,7 @@
 #define NAT_VALID_HOOKS ((1 << NF_BR_PRE_ROUTING) | (1 << NF_BR_LOCAL_OUT) | \
    (1 << NF_BR_POST_ROUTING))
 
-static struct ebt_entries initial_chains[] =
-{
+static struct ebt_entries initial_chains[] = {
 	{
 		.name	= "PREROUTING",
 		.policy	= EBT_ACCEPT,
@@ -30,8 +29,7 @@ static struct ebt_entries initial_chains[] =
 	}
 };
 
-static struct ebt_replace_kernel initial_table =
-{
+static struct ebt_replace_kernel initial_table = {
 	.name		= "nat",
 	.valid_hooks	= NAT_VALID_HOOKS,
 	.entries_size	= 3 * sizeof(struct ebt_entries),
@@ -50,8 +48,7 @@ static int check(const struct ebt_table_info *info, unsigned int valid_hooks)
 	return 0;
 }
 
-static struct ebt_table frame_nat =
-{
+static struct ebt_table frame_nat = {
 	.name		= "nat",
 	.table		= &initial_table,
 	.valid_hooks	= NAT_VALID_HOOKS,
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 185aa9c..0e474b1 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2375,8 +2375,7 @@ static int compat_do_ebt_get_ctl(struct sock *sk, int cmd,
 }
 #endif
 
-static struct nf_sockopt_ops ebt_sockopts =
-{
+static struct nf_sockopt_ops ebt_sockopts = {
 	.pf		= PF_INET,
 	.set_optmin	= EBT_BASE_CTL,
 	.set_optmax	= EBT_SO_SET_MAX + 1,
-- 
1.8.0


