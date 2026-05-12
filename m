Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAB12417DE
	for <bridge@lists.linux.dev>; Tue, 12 May 2026 04:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778560300; cv=none; b=oqVnUbg1RtR1n7MjOSah64XUiODQLIy/ZM3R/t44b2RxWoe6mLRR5qGVHyKe8W+A0kpHPZKPKIR+yr5cvaoreoUSz5zPcYheObnOu+ayhqqvh2eJCtim/mW3V52JRnU2lHwUkdYSRv5Q2zhxrD5CGPxyGoGXd85v4xbk23/ahBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778560300; c=relaxed/simple;
	bh=hOknjVenH5pFx0OwcER51qxHwSWRCw0sHBBrz576YP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deNhMRHJGdmtIwxw0mZ7ymyYBRfFpAkJWG09kZHlNzV9dlPMGXtcBxr6MZd/l1Ebxjf4rcD4dVaUh6RNgXqv/a37CJhYYq5xB0z4DbjiuqQBW93RaG/2tjVxz/wmezgr2u113V3o7u2mym9PwRFoHDTuYOhaHjvmskOEVB9BMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAD3afogrQJqu68FAQ--.3470S3;
	Tue, 12 May 2026 12:31:31 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	fw@strlen.de,
	davem@davemloft.net,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	tonanli66@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net: bridge: guard local finish against missing port
Date: Tue, 12 May 2026 12:31:24 +0800
Message-ID: <ad183a40c4d906f39e03590b371fdcfdffb863c6.1778504155.git.tonanli66@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1778504155.git.tonanli66@gmail.com>
References: <cover.1778504155.git.tonanli66@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAD3afogrQJqu68FAQ--.3470S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4fKr13JFWrAFWfuw1rJFb_yoW8ArykpF
	yagFy5tFWDWFy5Kw4vyFyxZF47Cr97GrW3J3sIvryFv3Z3X3Z5Xr1DKF9YvF4UAFWrGrWY
	qr1qvr4Sya4DZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0FCWoBl+USJQAAsu

From: Nan Li <tonanli66@gmail.com>

The bridge local receive path may be deferred by netfilter and resumed
later. By the time br_handle_local_finish() runs, skb->dev may still be
valid while its bridge port association has already been removed.

br_handle_local_finish() unconditionally looks up the bridge port from
skb->dev and dereferences it for source learning. If the port is no
longer attached to the bridge, the lookup returns NULL and the deferred
local receive path can no longer rely on the port state being present.

Skip the learning step when the bridge port lookup fails. In that case
there is no port state left to learn on, so returning early preserves
the normal behavior for existing ports while avoiding access to stale
state.

Fixes: 8626c56c8279 ("bridge: fix potential use-after-free when hook returns QUEUE or STOLEN verdict")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/bridge/br_input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 2cbae0f9ae1f..5b0d7450de5f 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -247,6 +247,9 @@ static void __br_handle_local_finish(struct sk_buff *skb)
 	struct net_bridge_port *p = br_port_get_rcu(skb->dev);
 	u16 vid = 0;
 
+	if (unlikely(!p))
+		return;
+
 	/* check if vlan is allowed, to avoid spoofing */
 	if ((p->flags & BR_LEARNING) &&
 	    nbp_state_should_learn(p) &&
-- 
2.43.0

