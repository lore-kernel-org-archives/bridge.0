Return-Path: <gongruiqi@huaweicloud.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA79C4158A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD21240469
From: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Message-ID: <20230816093248.1459951-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4] netfilter: ebtables: fix fortify
	warnings in size_entry_mwt()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Wed, 16 Aug 2023 09:54:46 -0000
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Gustavo A . R . Silva" <gustavoars@kernel.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, gongruiqi1@huawei.com

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=y, the following
warning appears:

In function ‘fortify_memcpy_chk’,
    inlined from ‘size_entry_mwt’ at net/bridge/netfilter/ebtables.c:2118:2:
./include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Werror=attribute-warning]
  592 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The compiler is complaining:

memcpy(&offsets[1], &entry->watchers_offset,
                       sizeof(offsets) - sizeof(offsets[0]));

where memcpy reads beyond &entry->watchers_offset to copy
{watchers,target,next}_offset altogether into offsets[]. Silence the
warning by wrapping these three up via struct_group().

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

v4: fix a typo in commit msg; designate to net-next; cc more netdev
maintainers.

v3: use sizeof(entry->offsets) as memcpy()'s size, as Gustavo suggested.

v2: fix HDRTEST error by replacing struct_group() with __struct_group(),
since it's a uapi header.

 include/uapi/linux/netfilter_bridge/ebtables.h | 14 ++++++++------
 net/bridge/netfilter/ebtables.c                |  3 +--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
index a494cf43a755..b0caad82b693 100644
--- a/include/uapi/linux/netfilter_bridge/ebtables.h
+++ b/include/uapi/linux/netfilter_bridge/ebtables.h
@@ -182,12 +182,14 @@ struct ebt_entry {
 	unsigned char sourcemsk[ETH_ALEN];
 	unsigned char destmac[ETH_ALEN];
 	unsigned char destmsk[ETH_ALEN];
-	/* sizeof ebt_entry + matches */
-	unsigned int watchers_offset;
-	/* sizeof ebt_entry + matches + watchers */
-	unsigned int target_offset;
-	/* sizeof ebt_entry + matches + watchers + target */
-	unsigned int next_offset;
+	__struct_group(/* no tag */, offsets, /* no attrs */,
+		/* sizeof ebt_entry + matches */
+		unsigned int watchers_offset;
+		/* sizeof ebt_entry + matches + watchers */
+		unsigned int target_offset;
+		/* sizeof ebt_entry + matches + watchers + target */
+		unsigned int next_offset;
+	);
 	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 757ec46fc45a..aa23479b20b2 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2115,8 +2115,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
 		return ret;
 
 	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
-	memcpy(&offsets[1], &entry->watchers_offset,
-			sizeof(offsets) - sizeof(offsets[0]));
+	memcpy(&offsets[1], &entry->offsets, sizeof(entry->offsets));
 
 	if (state->buf_kern_start) {
 		buf_start = state->buf_kern_start + state->buf_kern_offset;
-- 
2.41.0

