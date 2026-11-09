Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193045;
	b=hNVgEdcvalm7Hmg/GVoyqvFnfB8APE9BGY3R0XrmiIxCx5O4m1M9yP3SHrCrvqRpyg+L
	 /VmyhwRqzuzi9kyUUMfDzD/N7OJ9QevWM0iXGetQeguIPt4jOsiCugYqY7HbZf1m6yUg/
	 4OZoOb2spU447Q/9xdZzhDUwHdwvKBr5B75GJCCeUdP1vxVoVQmhhY+FRaJKddIkrTWkd
	 aLMFsSfWdlx05ZgtM6wHGHG4LgMaZzJXfCmKX0/Wos37/UQWuJXlEIYnserzgfL/jkVgB
	 Bf6yo4YsQVvDVQ0bvoBTcw8n10q6R5F3ti22k28D/PHCNk7aCNn+1jILLxP97BFssMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193045;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=slSez8APteyrjAQFVPi36IPS8gsYJrd9o7OEPdbfuX0=;
	b=uN1I7fwsv3qBqp002wtT//FQUsG9XVMooy75nX5CfLs/Zz8irnK/uWDo1GiE6a2tc/8K
	 ZInyVwlFrwAo9b2UVaE47qIjJ57M3m91PqWnyOdd51Ei1SjutlrWMJr9bVEgnT4+S/S+m
	 zd8kphJnD6aohqRlfR+DnbazA7/DqFYdhQtieohN0bEC0W3qo5BfN7OuKvx0KGQ7DUIzj
	 uhRSjQLaH029yTvoO6sZxx8Z7WCkkSnKZwCHYSiEQgUTSUyI1K5mXpBvdMoa5XvpEYj0i
	 NlChWdK/DYlOIDS/nfOwX33W4+63Bu9DThzOtd6kUsLrnLGZBnwzeIbHx8BeAJSYWiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UVo4mFcv;
	arc=none smtp.remote-ip=95.215.58.64
Received: from mta1.migadu.com (out-64.mta1.migadu.com [95.215.58.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147E606A326
	for <bridge@lists.linux.dev>; Mon,  9 Nov 2026 02:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A147E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UVo4mFcv
X-Envelope-To: bridge@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=3ZW9WdZ2Gaii+5kPjGa0iMjjl+g4WUyJikDdM5XjZ10=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794193042; v=1; x=1794797842;
 b=UVo4mFcv9Q4H2cIE2qz310LcnD++QCHbOylIue1Vs0G6jgrLPp+xVvhGyNgSeXOl0pvzHqg3
 4fg7KzseuvrVEmjug3M7XgifnRXdeQ6dywNlzXN2u4Lvyv6LkO3SrcfLrs+JsCsbOeVx0MpIa2W
 gfPb8wsrXh3AUd5fkgs3vTKc=
X-Envelope-To: bridge@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id e7634fc4ade2e7d9;
	Mon, 09 Nov 2026 02:57:22 +0000
X-Mizu-Trace-ID: e7634fc4ade2e7d9
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Paul Moore <paul@paul-moore.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Julian Anastasov <ja@ssi.bg>,
	Allison Henderson <achender@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	mptcp@lists.linux.dev,
	lvs-devel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-sctp@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next 05/14] calipso: annotate data-races around cache sysctls
Date: Mon,  9 Nov 2026 10:52:04 +0800
Message-ID: <20261109025425.328445-6-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109025425.328445-1-jiayuan.chen@linux.dev>
References: <20261109025425.328445-1-jiayuan.chen@linux.dev>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

calipso_cache_enabled and calipso_cache_bucketsize are read without any
lock while their sysctl handlers update them with WRITE_ONCE(). Add
READ_ONCE() to the readers.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/calipso.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index e399a42e30839..5e63212b60163 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -204,7 +204,7 @@ static int calipso_cache_check(const unsigned char *key,
 	struct calipso_map_cache_entry *prev_entry = NULL;
 	u32 hash;
 
-	if (!calipso_cache_enabled)
+	if (!READ_ONCE(calipso_cache_enabled))
 		return -ENOENT;
 
 	hash = calipso_map_cache_hash(key, key_len);
@@ -269,7 +269,7 @@ static int calipso_cache_add(const unsigned char *calipso_ptr,
 	struct calipso_map_cache_entry *old_entry = NULL;
 	u32 calipso_ptr_len;
 
-	if (!calipso_cache_enabled || calipso_cache_bucketsize <= 0)
+	if (!READ_ONCE(calipso_cache_enabled) || READ_ONCE(calipso_cache_bucketsize) <= 0)
 		return 0;
 
 	calipso_ptr_len = calipso_ptr[1];
@@ -289,7 +289,7 @@ static int calipso_cache_add(const unsigned char *calipso_ptr,
 
 	bkt = entry->hash & (CALIPSO_CACHE_BUCKETS - 1);
 	spin_lock_bh(&calipso_cache[bkt].lock);
-	if (calipso_cache[bkt].size < calipso_cache_bucketsize) {
+	if (calipso_cache[bkt].size < READ_ONCE(calipso_cache_bucketsize)) {
 		list_add(&entry->list, &calipso_cache[bkt].list);
 		calipso_cache[bkt].size += 1;
 	} else {
-- 
2.43.0

