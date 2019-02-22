Return-Path: <lirongqing@baidu.com>
From: Li RongQing <lirongqing@baidu.com>
Date: Fri, 22 Feb 2019 21:45:52 +0800
Message-Id: <1550843152-1772-1-git-send-email-lirongqing@baidu.com>
Subject: [Bridge] [PATCH][nf-next][v2] netfilter: convert the proto argument
	from u8 to u16
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org

The proto in struct xt_match and struct xt_target is u16, when
calling xt_check_target/match, their proto argument is u8,
and will cause truncation, it is harmless to ip packet, since
ip proto is u8

if a etable's match/target has proto that is u16, will cause
the check failure.

and convert be16 to short in bridge/netfilter/ebtables.c

Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
v2: change type from u_int16_t to u16

 include/linux/netfilter/x_tables.h | 4 ++--
 net/bridge/netfilter/ebtables.c    | 6 +++---
 net/netfilter/x_tables.c           | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/netfilter/x_tables.h b/include/linux/netfilter/x_tables.h
index 9077b3ebea08..8ba6a6227542 100644
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -289,9 +289,9 @@ bool xt_find_jump_offset(const unsigned int *offsets,
 
 int xt_check_proc_name(const char *name, unsigned int size);
 
-int xt_check_match(struct xt_mtchk_param *, unsigned int size, u_int8_t proto,
+int xt_check_match(struct xt_mtchk_param *, unsigned int size, u16 proto,
 		   bool inv_proto);
-int xt_check_target(struct xt_tgchk_param *, unsigned int size, u_int8_t proto,
+int xt_check_target(struct xt_tgchk_param *, unsigned int size, u16 proto,
 		    bool inv_proto);
 
 int xt_match_to_user(const struct xt_entry_match *m,
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 6693e209efe8..7bbb9b189752 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -385,7 +385,7 @@ ebt_check_match(struct ebt_entry_match *m, struct xt_mtchk_param *par,
 	par->match     = match;
 	par->matchinfo = m->data;
 	ret = xt_check_match(par, m->match_size,
-	      e->ethproto, e->invflags & EBT_IPROTO);
+	      ntohs(e->ethproto), e->invflags & EBT_IPROTO);
 	if (ret < 0) {
 		module_put(match->me);
 		return ret;
@@ -422,7 +422,7 @@ ebt_check_watcher(struct ebt_entry_watcher *w, struct xt_tgchk_param *par,
 	par->target   = watcher;
 	par->targinfo = w->data;
 	ret = xt_check_target(par, w->watcher_size,
-	      e->ethproto, e->invflags & EBT_IPROTO);
+	      ntohs(e->ethproto), e->invflags & EBT_IPROTO);
 	if (ret < 0) {
 		module_put(watcher->me);
 		return ret;
@@ -767,7 +767,7 @@ ebt_check_entry(struct ebt_entry *e, struct net *net,
 	tgpar.target   = target;
 	tgpar.targinfo = t->data;
 	ret = xt_check_target(&tgpar, t->target_size,
-	      e->ethproto, e->invflags & EBT_IPROTO);
+	      ntohs(e->ethproto), e->invflags & EBT_IPROTO);
 	if (ret < 0) {
 		module_put(target->me);
 		goto cleanup_watchers;
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 13e1ac333fa4..5b61146443ad 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -461,7 +461,7 @@ int xt_check_proc_name(const char *name, unsigned int size)
 EXPORT_SYMBOL(xt_check_proc_name);
 
 int xt_check_match(struct xt_mtchk_param *par,
-		   unsigned int size, u_int8_t proto, bool inv_proto)
+		   unsigned int size, u16 proto, bool inv_proto)
 {
 	int ret;
 
@@ -984,7 +984,7 @@ bool xt_find_jump_offset(const unsigned int *offsets,
 EXPORT_SYMBOL(xt_find_jump_offset);
 
 int xt_check_target(struct xt_tgchk_param *par,
-		    unsigned int size, u_int8_t proto, bool inv_proto)
+		    unsigned int size, u16 proto, bool inv_proto)
 {
 	int ret;
 
-- 
2.16.2

