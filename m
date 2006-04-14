From: "Jayachandran C" <jchandra@digeo.com>
Date: Fri, 14 Apr 2006 03:24:14 -0700
Message-ID: <20060414102414.GA25727@random.pao.digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH] ebtables: clean up vmalloc usage in
	net/bridge/netfilter/ebtables.c
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org, bdschuym@pandora.be
Cc: akpm@osdl.org

This cleans up other usages of of vmalloc in ebtables.c. The 
changes are similar to the cleanup done in 
ebtables-fix-allocation-in-net-bridge-netfilter-ebtablesc.patch


Patch Description:

This patch makes all the vmalloc calls in net/bridge/netfilter/ebtables.c
follow the standard convention. Remove unnecessary casts, and use '*object'
instead of 'type'.

Signed-off-by: Jayachandran C. <c.jayachandran at gmail.com>

---

 net/bridge/netfilter/ebtables.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

diff -ur linux-2.6.16-rc6.clean/net/bridge/netfilter/ebtables.c linux-2.6.16-rc6/net/bridge/netfilter/ebtables.c
--- linux-2.6.16-rc6.clean/net/bridge/netfilter/ebtables.c	2006-04-14 14:00:28.000000000 +0530
+++ linux-2.6.16-rc6/net/bridge/netfilter/ebtables.c	2006-04-14 14:22:36.000000000 +0530
@@ -830,7 +830,7 @@
 			return -ENOMEM;
 		for_each_cpu(i) {
 			newinfo->chainstack[i] =
-			   vmalloc(udc_cnt * sizeof(struct ebt_chainstack));
+			  vmalloc(udc_cnt * sizeof(*(newinfo->chainstack[0])));
 			if (!newinfo->chainstack[i]) {
 				while (i)
 					vfree(newinfo->chainstack[--i]);
@@ -840,8 +840,7 @@
 			}
 		}
 
-		cl_s = (struct ebt_cl_stack *)
-		   vmalloc(udc_cnt * sizeof(struct ebt_cl_stack));
+		cl_s = vmalloc(udc_cnt * sizeof(*cl_s));
 		if (!cl_s)
 			return -ENOMEM;
 		i = 0; /* the i'th udc */
@@ -943,8 +942,7 @@
 
 	countersize = COUNTER_OFFSET(tmp.nentries) * 
 					(highest_possible_processor_id()+1);
-	newinfo = (struct ebt_table_info *)
-	   vmalloc(sizeof(struct ebt_table_info) + countersize);
+	newinfo = vmalloc(sizeof(*newinfo) + countersize);
 	if (!newinfo)
 		return -ENOMEM;
 
@@ -966,8 +964,7 @@
 	/* the user wants counters back
 	   the check on the size is done later, when we have the lock */
 	if (tmp.num_counters) {
-		counterstmp = (struct ebt_counter *)
-		   vmalloc(tmp.num_counters * sizeof(struct ebt_counter));
+		counterstmp = vmalloc(tmp.num_counters * sizeof(*counterstmp));
 		if (!counterstmp) {
 			ret = -ENOMEM;
 			goto free_entries;
@@ -1147,8 +1144,7 @@
 
 	countersize = COUNTER_OFFSET(table->table->nentries) *
 					(highest_possible_processor_id()+1);
-	newinfo = (struct ebt_table_info *)
-	   vmalloc(sizeof(struct ebt_table_info) + countersize);
+	newinfo = vmalloc(sizeof(*newinfo) + countersize);
 	ret = -ENOMEM;
 	if (!newinfo)
 		return -ENOMEM;
@@ -1246,8 +1242,7 @@
 	if (hlp.num_counters == 0)
 		return -EINVAL;
 
-	if ( !(tmp = (struct ebt_counter *)
-	   vmalloc(hlp.num_counters * sizeof(struct ebt_counter))) ){
+	if ( !(tmp = vmalloc(hlp.num_counters * sizeof(*tmp))) ){
 		MEMPRINT("Update_counters && nomemory\n");
 		return -ENOMEM;
 	}
@@ -1376,8 +1371,7 @@
 			BUGPRINT("Num_counters wrong\n");
 			return -EINVAL;
 		}
-		counterstmp = (struct ebt_counter *)
-		   vmalloc(nentries * sizeof(struct ebt_counter));
+		counterstmp = vmalloc(nentries * sizeof(*counterstmp));
 		if (!counterstmp) {
 			MEMPRINT("Couldn't copy counters, out of memory\n");
 			return -ENOMEM;
