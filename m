Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EE13DE44E
	for <bridge@lists.linux.dev>; Mon,  4 May 2026 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907052; cv=none; b=FEBzRiCoKJbijLqd4Dy0DWy+/PN6DL5bxiaBgKyBm8iOZmYkDUr7mmCshjByhK2wY/bAaUGHZAOiswU4E3H9K6v1rvMv8QpouEvzzVo+POmJqcuJezCbDveoo8mI5pbewP57d3vgYEgh6wHY+M2w8rz1IZVCm2hps0RBTRAOi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907052; c=relaxed/simple;
	bh=Zt52XDDhonHJAIyeH3TKYgmGMbFia/F7uYhGZrwZ78s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILJGVVB8WNhWqjE9Czv5HFDy5zBp/bRxz4ArFFjz0Oxtf4JtasxKaB2fYdgyrLNp/c7sGHrTJ9S3PkW1Kpy8PdhT4EyDt99o3fDr3GDTqhpISZn6J6Yx6GHU4+3vYv0xLyoQWhm4awNF7O74isGG+2GVAJBpYZ3MALBZNOGFDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD3M7ElR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD3M7ElR"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-364e5d895e3so2417023a91.2
        for <bridge@lists.linux.dev>; Mon, 04 May 2026 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777907050; x=1778511850; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wBLYio4dSORQ087NCKhszziXEykjpp/cDyPH1+d3fvI=;
        b=LD3M7ElReRjbs+lwStp77USsxI7s3ttbpAIw6qZvbFpbF0vR7NANIfZ5SA0/JHAmL+
         yxWitanPzsDIzl4p6naf2V9AiKwjBpB70dYen2g6i2wXsdEJNI3kxpTJOGGtmRWKmO8X
         OnhZBVhUzv79VUhcbL+gOjr/gBaJMzNhTiIqLZkhkipg2VpPqodKt8CNApd8pE3yxXnj
         o2ZOEqv+2DZXyyjEI5PxZNz4R3vp5ilxd0+VNE6o+zAO1p53s+RyjRTpZXeYCz5iOots
         JQWzkd8CmHTs4ut40ZCgRLnlGV9f+nBeGSX7HpjmkNJCRX88VruQ+0DZDMxs8/nAaAdN
         /xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777907050; x=1778511850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBLYio4dSORQ087NCKhszziXEykjpp/cDyPH1+d3fvI=;
        b=i2YDu0+N2IdmlxKgGAqT1ZOMcL+pBp0Z00EHRKXcvo8Y7CjQCeiJKr/Szk4B62B5r8
         8SZdavkPe2naGhpUOpvg+hIWNv8nyzI/n2e9NDhT6qb6NwGjgVYnWXOSc+u/vrKgjM61
         UkKjWPhdbWW+XHaQojBDmijJ6kXYYnuFrFKhFHyGV6zASJSwOo2u+zpZy2fdh12SJP39
         MKyte0PN7h3hIRc7aCQDDAKgjVf+DpgO83YTeA+YJAXSOCdLrabA7gtQCK1O40Lqy66w
         i2Py8zNUcQQT34TKuO60tyHKkHEkk6dnBcrAwW2pS9eETrIgwsrEY0x2WO+QSmYVjZPk
         Rdww==
X-Forwarded-Encrypted: i=1; AFNElJ9o2UjtbwxWEkJXkpxRV9SUgXxtEmGmg2xJX5wIu9qpG94UIBucDei0sbEY6pj8O5D+loIoPXU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2jO1sDCccutYMsD9m/MnYWAHtW8AHNZaDLNzmuNa/anPfw878
	CnaO+DS4mAGtIXA/wPhB8rhc9uOaM25BfLXwBHN+KleGgVpyCEUUfxCd
X-Gm-Gg: AeBDieu20H3fVwUXsb7wqzOlNxS8iZ/NYofLpGxAPmehlvmz5hqwlBJzzkbVFUy1gLY
	tDDT0PWNgKg4DRXsVb/NdOsaHBW6aAxHDmM6BLIM28zbglIub1y3rCHwyywbJdnnBelfj4VtUm5
	UHsZJnaQ9OGv6wXHjvN2fLD50jCwvIz1UfdOlpqqbafPfgAKl00n90G+q46NWl18I3+BLznVlyX
	lCI9Y1Ea6wOZAo5IfHBpMaJeMVvqnxrL+7X+7kIXhwJUkXcpddgELsbjrB8w2HJyD4VSm+LN9Fb
	H+F/doEezTqvI3qUf9csjT4FHrsKhmu3SdaQvMD4hcn+JuIWG0uYUQYDGs2TkTiNznYg96tjtMF
	foLzlSFjR6cipUSSwNYeBvKEOqzONsYx+mOU2yu2ELPA4/VJCpJVWxSE7PuPy6f70ER4D/5DrxK
	Iakp9GVGRoIqu2FR2KdVjXyvBezcYvx0C7C1pumJJtrjxN0z8y5BaDP+fLBMbSkpQQlFnadISs7
	Eu0mdjxbGqddAu45w==
X-Received: by 2002:a17:90a:d2c7:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-3650ccefbdfmr9350785a91.4.1777907049979;
        Mon, 04 May 2026 08:04:09 -0700 (PDT)
Received: from arch.lan ([2409:40e1:3007:cefc:472f:1ad7:13a6:92d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f3c55bfasm7325410a91.0.2026.05.04.08.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 08:04:09 -0700 (PDT)
From: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
To: razor@blackwall.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aadarsh Chandra <aadarsh.official.xz@gmail.com>
Subject: [PATCH] net: bridge: replace simple_strtoul with kstrtoul
Date: Mon,  4 May 2026 20:31:46 +0530
Message-ID: <20260504150146.457562-1-aadarsh.official.xz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The simple_strtoul() function is deprecated. It does not handle
errors or overflows correctly. Replace it with kstrtoul() in
brport_store() to ensure that invalid user input is caught and
returned as an error.

Signed-off-by: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
---
 net/bridge/br_sysfs_if.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f57c36a7fc0..3e948d781970 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -318,7 +318,7 @@ static ssize_t brport_store(struct kobject *kobj,
 	struct net_bridge_port *p = kobj_to_brport(kobj);
 	ssize_t ret = -EINVAL;
 	unsigned long val;
-	char *endp;
+	int err;
 
 	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
@@ -339,9 +339,11 @@ static ssize_t brport_store(struct kobject *kobj,
 		spin_unlock_bh(&p->br->lock);
 		kfree(buf_copy);
 	} else if (brport_attr->store) {
-		val = simple_strtoul(buf, &endp, 0);
-		if (endp == buf)
+		err = kstrtoul(buf, 0, &val);
+		if (err) {
+			ret = err;
 			goto out_unlock;
+		}
 		spin_lock_bh(&p->br->lock);
 		ret = brport_attr->store(p, val);
 		spin_unlock_bh(&p->br->lock);
-- 
2.54.0

