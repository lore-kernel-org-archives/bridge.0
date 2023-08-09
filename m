Return-Path: <joel.granados@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E65A6414A4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 049CB4059C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691578213; x=1692183013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rF1J0XzJl2jEuCsHx7nkNs1OdRX43SORnh/9oIIv32k=;
 b=kBzWMSXu3PkjQikKnYHW4SplaSkbLTtRx+DN3V+kDSETGfMSAK/sSp6mSJ+8nqx3lI
 2qwj1SV/t13/4GvrKi8RJqLKnU26roaWkF8nqLehWjxDX9STMR4Zh4ESxSV6APNRMk/+
 quYAmnTAFA8y+/bXjvkUBcL+dhPTRXOvh1SwZmXZjI/dGG1EtkYG8fKiUw6qSsLcLQ5+
 oRZAKCQozDGbW5swn3ez1hu/auV2uwXt8dgk6+kTN+Yl3sG2BELBTq+GfwArQCaLc7M0
 N/BbKFfJs7jb7VHcsgWQGQ2bbcZWDQvbdYebZLe3N/r/nMOUCYKubQzNxmMqo6wMYA29
 bBbA==
From: Joel Granados <joel.granados@gmail.com>
Date: Wed,  9 Aug 2023 12:49:54 +0200
Message-Id: <20230809105006.1198165-3-j.granados@samsung.com>
In-Reply-To: <20230809105006.1198165-1-j.granados@samsung.com>
References: <20230809105006.1198165-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v3 02/14] sysctl: Use ctl_table_header in
	list_for_each_table_entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: mcgrof@kernel.org
Cc: Joel Granados <j.granados@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Nikolay Aleksandrov <razor@blackwall.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Mat Martineau <martineau@kernel.org>, Will Deacon <will@kernel.org>, Jan Karcher <jaka@linux.ibm.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Steffen Klassert <steffen.klassert@secunet.com>, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Xin Long <lucien.xin@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-rdma@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>, bridge@lists.linux-foundation.org, willy@infradead.org, Jozsef Kadlecsik <kadlec@netfilter.org>, lvs-devel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, coreteam@netfilter.org, Iurii Zaikin <yzaikin@google.com>, Roopa Prabhu <roopa@nvidia.com>, Wen Gu <guwen@linux.alibaba.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Joerg Reuter <jreuter@yaina.de>, Sven Schnelle <svens@linux.ibm.com>, keescook@chromium.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, josh@joshtriplett.org, Wenjia Zhang <wenjia@linux.ibm.com>, Simon Horman <horms@verge.net.au>, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Karsten Graul <kgraul@linux.ibm.com>, netfilter-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, "D. Wythe" <alibuda@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

We replace the ctl_table with the ctl_table_header pointer in
list_for_each_table_entry which is the macro responsible for traversing
the ctl_table arrays. This is a preparation commit that will make it
easier to add the ctl_table array size (that will be added to
ctl_table_header in subsequent commits) to the already existing loop
logic based on empty ctl_table elements (so called sentinels).

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 94d71446da39..884460b0385b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -19,8 +19,8 @@
 #include <linux/kmemleak.h>
 #include "internal.h"
 
-#define list_for_each_table_entry(entry, table) \
-	for ((entry) = (table); (entry)->procname; (entry)++)
+#define list_for_each_table_entry(entry, header) \
+	for ((entry) = (header->ctl_table); (entry)->procname; (entry)++)
 
 static const struct dentry_operations proc_sys_dentry_operations;
 static const struct file_operations proc_sys_file_operations;
@@ -204,7 +204,7 @@ static void init_header(struct ctl_table_header *head,
 	if (node) {
 		struct ctl_table *entry;
 
-		list_for_each_table_entry(entry, table) {
+		list_for_each_table_entry(entry, head) {
 			node->header = head;
 			node++;
 		}
@@ -215,7 +215,7 @@ static void erase_header(struct ctl_table_header *head)
 {
 	struct ctl_table *entry;
 
-	list_for_each_table_entry(entry, head->ctl_table)
+	list_for_each_table_entry(entry, head)
 		erase_entry(head, entry);
 }
 
@@ -242,7 +242,7 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 	err = insert_links(header);
 	if (err)
 		goto fail_links;
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		err = insert_entry(header, entry);
 		if (err)
 			goto fail;
@@ -1129,7 +1129,7 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 {
 	struct ctl_table *entry;
 	int err = 0;
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		if ((entry->proc_handler == proc_dostring) ||
 		    (entry->proc_handler == proc_dobool) ||
 		    (entry->proc_handler == proc_dointvec) ||
@@ -1169,7 +1169,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 
 	name_bytes = 0;
 	nr_entries = 0;
-	list_for_each_table_entry(entry, head->ctl_table) {
+	list_for_each_table_entry(entry, head) {
 		nr_entries++;
 		name_bytes += strlen(entry->procname) + 1;
 	}
@@ -1188,7 +1188,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 	link_name = (char *)&link_table[nr_entries + 1];
 	link = link_table;
 
-	list_for_each_table_entry(entry, head->ctl_table) {
+	list_for_each_table_entry(entry, head) {
 		int len = strlen(entry->procname) + 1;
 		memcpy(link_name, entry->procname, len);
 		link->procname = link_name;
@@ -1211,7 +1211,7 @@ static bool get_links(struct ctl_dir *dir,
 	struct ctl_table *entry, *link;
 
 	/* Are there links available for every entry in table? */
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		const char *procname = entry->procname;
 		link = find_entry(&tmp_head, dir, procname, strlen(procname));
 		if (!link)
@@ -1224,7 +1224,7 @@ static bool get_links(struct ctl_dir *dir,
 	}
 
 	/* The checks passed.  Increase the registration count on the links */
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		const char *procname = entry->procname;
 		link = find_entry(&tmp_head, dir, procname, strlen(procname));
 		tmp_head->nreg++;
@@ -1356,12 +1356,14 @@ struct ctl_table_header *__register_sysctl_table(
 {
 	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
+	struct ctl_table_header h_tmp;
 	struct ctl_dir *dir;
 	struct ctl_table *entry;
 	struct ctl_node *node;
 	int nr_entries = 0;
 
-	list_for_each_table_entry(entry, table)
+	h_tmp.ctl_table = table;
+	list_for_each_table_entry(entry, (&h_tmp))
 		nr_entries++;
 
 	header = kzalloc(sizeof(struct ctl_table_header) +
@@ -1471,7 +1473,7 @@ static void put_links(struct ctl_table_header *header)
 	if (IS_ERR(core_parent))
 		return;
 
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		struct ctl_table_header *link_head;
 		struct ctl_table *link;
 		const char *name = entry->procname;
-- 
2.30.2

