Return-Path: <sashal@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A19AC41E7A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD300417AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694197305;
 bh=hq4liqqaZEbpt3nMeqc0u2X0V2l96a2XzBRqOQu/QUU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vxdn1sllmiugwNedZzRGP45sXaxGB9d0N14l1Yi+yEeyK+lmqg+4DIwdENv6U9GSr
 JnZcz7ysahNpZqvNUFvBPALyCapL8EhiBb/FO5jN9A2UeBWseVKB0X2yJ7TMkRqWz8
 rH6q8GCSJKFHpz7zzzNgx+MvFhAT3Jmo4na5UVbCGf+Ja5jbbYHZVWsdMz2yIdmVYg
 MvBYvw5YZwHh3RDPOkbgZw0dyP+FCRz4p8IoVhN6HDI7mNe1fgIGnRiWX9XZZYr0l/
 Y/0rEMI1Zcn14LBH/LIDiHUB6OBJW9ylOzfsoPB7wYR+FWGa35sIPldP6OVsyo9oPx
 Wj3a4UOY6gLZg==
From: Sasha Levin <sashal@kernel.org>
Date: Fri,  8 Sep 2023 14:21:25 -0400
Message-Id: <20230908182127.3461199-6-sashal@kernel.org>
In-Reply-To: <20230908182127.3461199-1-sashal@kernel.org>
References: <20230908182127.3461199-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH AUTOSEL 4.14 6/8] netfilter: ebtables: fix fortify
	warnings in size_entry_mwt()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, bridge@lists.linux-foundation.org, GONG@osuosl.org, netdev@vger.kernel.org, razor@blackwall.org, roopa@nvidia.com, Florian Westphal <fw@strlen.de>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, kadlec@netfilter.org, edumazet@google.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, "GONG, Ruiqi" <gongruiqi1@huawei.com>, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, pablo@netfilter.org, Kees Cook <keescook@chromium.org>

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

[ Upstream commit a7ed3465daa240bdf01a5420f64336fee879c09d ]

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

where memcpy reads beyong &entry->watchers_offset to copy
{watchers,target,next}_offset altogether into offsets[]. Silence the
warning by wrapping these three up via struct_group().

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/netfilter_bridge/ebtables.h | 14 ++++++++------
 net/bridge/netfilter/ebtables.c                |  3 +--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
index 9ff57c0a01990..43db01c05c4d5 100644
--- a/include/uapi/linux/netfilter_bridge/ebtables.h
+++ b/include/uapi/linux/netfilter_bridge/ebtables.h
@@ -172,12 +172,14 @@ struct ebt_entry {
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
index 84d4b4a0b0536..b5fb880c8a093 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2071,8 +2071,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
 		return ret;
 
 	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
-	memcpy(&offsets[1], &entry->watchers_offset,
-			sizeof(offsets) - sizeof(offsets[0]));
+	memcpy(&offsets[1], &entry->offsets, sizeof(entry->offsets));
 
 	if (state->buf_kern_start) {
 		buf_start = state->buf_kern_start + state->buf_kern_offset;
-- 
2.40.1

