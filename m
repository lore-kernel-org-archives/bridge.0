Return-Path: <joel.granados@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4372740298
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67497400A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690787863; x=1691392663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPr2gCh0WwKGZ3vD5F3mcw/cD05Ywt0Q6uWcdKx3iw8=;
 b=ODQWGR3LflWQq2OvtY1YynEp6l9qd94J4wKNyHC1oHlJSpHL0Xo0lx7HnVPh+Maav4
 mdFvIf8q88vjdEfhrWv/mi8K27TOWd10Rfkuz2+tkKycXmM8soU71r2e2LC/cCVW8PZz
 rEwAtYG8tVYRDVtkFAdTT2B1OmQaCWtLnsADAc48NDQAR4KcEelo5MOqIjDh0HTiLMWs
 eTzmivPPY1muLmBnjFmKwT38ltKrocMx7hYMk6cMgxR9cuLiAzwnyvbOrj5d05fgDd6t
 aTA/0Fc49Q2iW1UkOCGVn4PWcKcCz83OlVO72nubL6VbL56RiI98SEglN+i3pXoWKjHs
 Bljw==
From: Joel Granados <joel.granados@gmail.com>
Date: Mon, 31 Jul 2023 09:17:21 +0200
Message-Id: <20230731071728.3493794-8-j.granados@samsung.com>
In-Reply-To: <20230731071728.3493794-1-j.granados@samsung.com>
References: <20230731071728.3493794-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 07/14] sysctl: Add size arg to
	__register_sysctl_init
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: mcgrof@kernel.org
Cc: Joel Granados <j.granados@samsung.com>, Wen Gu <guwen@linux.alibaba.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Catalin Marinas <catalin.marinas@arm.com>, Nikolay Aleksandrov <razor@blackwall.org>, Alexander Aring <alex.aring@gmail.com>, linux-sctp@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, Jan Karcher <jaka@linux.ibm.com>, Mat Martineau <martineau@kernel.org>, Will Deacon <will@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Steffen Klassert <steffen.klassert@secunet.com>, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Xin Long <lucien.xin@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-rdma@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>, bridge@lists.linux-foundation.org, willy@infradead.org, Jozsef Kadlecsik <kadlec@netfilter.org>, lvs-devel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, coreteam@netfilter.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joerg Reuter <jreuter@yaina.de>, Christian Borntraeger <borntraeger@linux.ibm.com>, Kees Cook <keescook@chromium.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, josh@joshtriplett.org, Wenjia Zhang <wenjia@linux.ibm.com>, Simon Horman <horms@verge.net.au>, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Iurii Zaikin <yzaikin@google.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, linux-wpan@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>

This commit adds table_size to __register_sysctl_init in preparation for
the removal of the sentinel elements in the ctl_table arrays (last empty
markers). And though we do *not* remove any sentinels in this commit, we
set things up by calculating the ctl_table array size with ARRAY_SIZE.

We add a table_size argument to __register_sysctl_init and modify the
register_sysctl_init macro to calculate the array size with ARRAY_SIZE.
The original callers do not need to be updated as they will go through
the new macro.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/proc_sysctl.c  | 12 +++---------
 include/linux/sysctl.h |  5 +++--
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 80d3e2f61947..817bc51c58d8 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1433,6 +1433,7 @@ EXPORT_SYMBOL(register_sysctl_sz);
  * 	lifetime use of the sysctl.
  * @table_name: The name of sysctl table, only used for log printing when
  *              registration fails
+ * @table_size: The number of elements in table
  *
  * The sysctl interface is used by userspace to query or modify at runtime
  * a predefined value set on a variable. These variables however have default
@@ -1445,16 +1446,9 @@ EXPORT_SYMBOL(register_sysctl_sz);
  * Context: if your base directory does not exist it will be created for you.
  */
 void __init __register_sysctl_init(const char *path, struct ctl_table *table,
-				 const char *table_name)
+				 const char *table_name, size_t table_size)
 {
-	int count = 0;
-	struct ctl_table *entry;
-	struct ctl_table_header t_hdr, *hdr;
-
-	t_hdr.ctl_table = table;
-	list_for_each_table_entry(entry, (&t_hdr))
-		count++;
-	hdr = register_sysctl_sz(path, table, count);
+	struct ctl_table_header *hdr = register_sysctl_sz(path, table, table_size);
 
 	if (unlikely(!hdr)) {
 		pr_err("failed when register_sysctl_sz %s to %s\n", table_name, path);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index b1168ae281c9..09d7429d67c0 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -236,8 +236,9 @@ void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init_bases(void);
 extern void __register_sysctl_init(const char *path, struct ctl_table *table,
-				 const char *table_name);
-#define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
+				 const char *table_name, size_t table_size);
+#define register_sysctl_init(path, table)	\
+	__register_sysctl_init(path, table, #table, ARRAY_SIZE(table))
 extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
-- 
2.30.2

