Return-Path: <gongruiqi@huaweicloud.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 766D04158A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC2FB40469
From: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Message-ID: <20230816093443.1460204-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2] netfilter: ebtables: replace
	zero-length array members
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Wed, 16 Aug 2023 09:54:38 -0000
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Gustavo A . R . Silva" <gustavoars@kernel.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, gongruiqi1@huawei.com

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

As suggested by Kees[1], replace the old-style 0-element array members
of multiple structs in ebtables.h with modern C99 flexible array.

[1]: https://lore.kernel.org/all/5E8E0F9C-EE3F-4B0D-B827-DC47397E2A4A@kernel.org/

Link: https://github.com/KSPP/linux/issues/21
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

v2: designate to net-next; cc more netdev maintainers

 include/uapi/linux/netfilter_bridge/ebtables.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
index b0caad82b693..673b00df162c 100644
--- a/include/uapi/linux/netfilter_bridge/ebtables.h
+++ b/include/uapi/linux/netfilter_bridge/ebtables.h
@@ -87,7 +87,7 @@ struct ebt_entries {
 	/* nr. of entries */
 	unsigned int nentries;
 	/* entry list */
-	char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
+	char data[] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
 /* used for the bitmask of struct ebt_entry */
@@ -129,7 +129,7 @@ struct ebt_entry_match {
 	} u;
 	/* size of data */
 	unsigned int match_size;
-	unsigned char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
+	unsigned char data[] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
 struct ebt_entry_watcher {
@@ -142,7 +142,7 @@ struct ebt_entry_watcher {
 	} u;
 	/* size of data */
 	unsigned int watcher_size;
-	unsigned char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
+	unsigned char data[] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
 struct ebt_entry_target {
@@ -155,7 +155,7 @@ struct ebt_entry_target {
 	} u;
 	/* size of data */
 	unsigned int target_size;
-	unsigned char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
+	unsigned char data[] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
 #define EBT_STANDARD_TARGET "standard"
@@ -190,7 +190,7 @@ struct ebt_entry {
 		/* sizeof ebt_entry + matches + watchers + target */
 		unsigned int next_offset;
 	);
-	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
+	unsigned char elems[] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
 static __inline__ struct ebt_entry_target *
-- 
2.41.0

