Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68F3DCD80
	for <bridge@lists.linux.dev>; Tue,  1 Sep 2026 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264474; cv=none; b=IwwQZURoDWjm3ixOWHgqfhhB8j7UTNLaIUeifF+KDKNh4cx+pw3OeKKmGvM4rhh1O0L7O8m+nJjojCx2d7PzhraQhN67OYkO+/l3m5LGG5PE901i1eRggT3aohd0uKu8Ilx8wt8OUjkxALvem6e3bwkbENPgP4prTm9Rmr0mroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264474; c=relaxed/simple;
	bh=eHCQJU9epidDiqSw6rychh/RrwvWwagWP4T3b2XA2T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCdwfwC9t7neVt+oZHtdNIvIL90M09m5u4N7CpMmai6S/Hf0VqaMSckjbqiqoTVg6GU1ry/W7Krw9eXl41Zu3d21K2TL3T1F/s1tEvW2C0vLJou40KIcPYOdlVLgRTNx2z4UGLi1+5aSgqy8lkCDSWDu64bxYktRl3JS6XbTppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LunbmRl1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LunbmRl1"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a6165b4402so1247745a12.3
        for <bridge@lists.linux.dev>; Tue, 01 Sep 2026 05:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264471; x=1788869271; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C9fGukl2hxJruJMoMsmWQ5mpAQOKInaHi7HfgMgK36w=;
        b=LunbmRl1/D5LkD+Hn92Jez+e5KFD38/tvq5gzgAnCrFa4qg1Da24bbXKndFdsfnqPI
         4LCRHl6SDe2oXQxhm+oCKd5ibHa8ENsKvwQdswbF9sM/ZW/G+XcqaDmsFzmlt5zFJyOU
         T7gSEgPf8+MyPczxiXWCIElT0hZm1owcbMa011Aao3yeCE+ZKsfrQX3ckjY77UpzXVC3
         ald2CxYvagfqHvR1E4Q5ocLecqZVCZ9qZN0lv6xGEeLOaTcRWOBBU5jRq+znLsYo30nW
         dp3jvZWlU9k3mJKuzC9T/ZzMOBZpRp6RomiT5xZBo1BoHWHwLlXgVfDkDQdqf1xamuCC
         KVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264471; x=1788869271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C9fGukl2hxJruJMoMsmWQ5mpAQOKInaHi7HfgMgK36w=;
        b=og/Su+GlFbs5t68/+ANALvYNMDWdnP9Pe+G+lv9KQr0nbOVBWSZgAF9vkjGfr124mC
         G9LYxCRzqk1LbmYWO/6TRZJ90ezJNSNWpUfNQQZ1ypfrueLbi25GN+SjXg6YJuntpzet
         mAbHgOLOT3qd2Ho/rslgaCcrnJ6Yp8k8pH5sUNqlT+84edMWuFBDjzV0wYVqA/6ueK/m
         Cxu9OqBs8TvCxwozOearsiFHUuzjk5l2ZYvzqa5V+5lTyp3HsrcpR8zM37fxhRSfr3Aj
         4xVv26Br8SCHHT9E1NWLR3qvsh5MpsKp8zHQvcaxJ/OpIA8+BtmLqOkx/dZsCFDD8cIM
         8HLw==
X-Forwarded-Encrypted: i=1; AKwUvByyHjRYDkig0YFvMNGepHxulGmT7b1uaI1t7ZYS3dscw6S3KJivwcBiRvYNbsUBPjTaveFaaLk=@lists.linux.dev
X-Gm-Message-State: AFuF++m17a+96X3Phd8w2+t6cU0K9AMO9crq8jjdTsC3T6dz16z1/GHK
	HAEyAXUqFaxQ0dVEEix9VlTYyEisQ3PxK8ouuPxhM47w0chgqchThA6b8gZidZEiL90=
X-Gm-Gg: AYBFou3ZTrTRE6zGlEgLD5oKJQVh2CqTBZjQMi4Qsa0fXvupCR/iJXBNJ/NZWzPFWon
	NV9IT6kxtPTQFRo9sLhwxSUou+nl3GhYnBNQQy/jCS+e0/EXrcvvTKM4GGQMKxnzlWocrZ4s36C
	GCsPpNPJp8+0/8k6+52ZyDsCSL2hKxI+c/OPyp7Dm65gGuL05mswdHODTEQaLCqwo5fTEf5qwF3
	7IwYJy6+y50Gbdc/qqr7Pab/anaHPqMQtlG+pgzWXJ0/b+oJKQyMZ9LBmd8FWWoW6GoPUXk7Jae
	CbxU/POYjMrK1BGiRu1yBdpBgf+KsgStpEC/tJPN3c2cn6AYvCRKDmjw/uSHkmifcyPujQSMWd6
	i+1aIEVLVlbudEuHIEIfxRWqOHzCZacxa9rSLhRmkzped/VOwHrUMX/IcfFnUsrFemidDfac3TP
	FeJPx4iv89Ufww67MKvq77ciZewN2PtaGkp/q1SI3y8jKLxq+AH8Qe5jmPKvV6gGIhnLmChzxf2
	1toCYoehu9gW4bVMa//QA==
X-Received: by 2002:a05:6402:a0cb:b0:6a6:32f5:5570 with SMTP id 4fb4d7f45d1cf-6a632f556bamr12242853a12.18.1788264471422;
        Tue, 01 Sep 2026 05:07:51 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d37ce3sm4518398f8f.8.2026.09.01.05.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:50 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 9/9] net: bridge: vlan: use br_vlan_get_state to get vlan state
Date: Tue,  1 Sep 2026 15:07:21 +0300
Message-ID: <20260901120721.747908-10-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
References: <20260901120721.747908-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MST code can change the vlan state with only rcu, so use the helper
to get the state properly.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_vlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 95187a607ec2..72b75757ac85 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -40,7 +40,7 @@ static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
 	if (vg->pvid == v->vid)
 		return;
 
-	br_vlan_set_pvid_state(vg, v->state);
+	br_vlan_set_pvid_state(vg, br_vlan_get_state(v));
 	WRITE_ONCE(vg->pvid, v->vid);
 }
 
-- 
2.47.3

