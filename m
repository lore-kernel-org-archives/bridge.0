Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FEA15B559
	for <bridge@lists.linux.dev>; Wed, 28 Aug 2024 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724828543; cv=none; b=dQ7BmCbCicKDqymZl4OQ/JwJZHGwsidKQdk3l7te2UcqncprdfzjXwi+PtgVVcM58ncyH+9BuFtjFAkNI/zo/ZiYNQXHtcDvh5sjILQRKU0K7a7Xw+2iOjJ5e5A6C1qcZ1LrldbdZhkb6FpEb8uxdBrrRuYeugRyfKbctPyHE2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724828543; c=relaxed/simple;
	bh=cJa1hnS9lYVnIF4B8El0la0j95Um5vUaS2HneJF+CSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qK0qh3GpPVRCoCbjE5m0XrVMMA9pfhI9FE/mQqe8Owo84bGM/lgxoN0oeCn7cFsuQRyjb6yYBkogjf6Rv7wEttCfrNnDxt4QQ/fOc2w0DsVJYj15eWhWOgmZh+boQdJsPQocq3rHx0iB9zwnWwYb2txBgRKnwnyoh78IPFSwmw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WtwLX4RDMz13S81;
	Wed, 28 Aug 2024 15:01:24 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FB44180AE6;
	Wed, 28 Aug 2024 15:02:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 15:02:11 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <pablo@netfilter.org>, <kadlec@netfilter.org>, <roopa@nvidia.com>,
	<razor@blackwall.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <dsahern@kernel.org>,
	<krzk@kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <bridge@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 2/5] netfilter: Use kmemdup_array() instead of kmemdup() for multiple allocation
Date: Wed, 28 Aug 2024 15:10:01 +0800
Message-ID: <20240828071004.1245213-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828071004.1245213-1-ruanjinjie@huawei.com>
References: <20240828071004.1245213-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Let the kmemdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 net/bridge/netfilter/ebtables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index cbd0e3586c3f..3e67d4aff419 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1256,7 +1256,7 @@ int ebt_register_table(struct net *net, const struct ebt_table *input_table,
 		goto free_unlock;
 	}
 
-	ops = kmemdup(template_ops, sizeof(*ops) * num_ops, GFP_KERNEL);
+	ops = kmemdup_array(template_ops, num_ops, sizeof(*ops), GFP_KERNEL);
 	if (!ops) {
 		ret = -ENOMEM;
 		if (newinfo->nentries)
-- 
2.34.1

