Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAD44BC019
	for <bridge@lists.linux.dev>; Wed,  6 May 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088441; cv=none; b=d3dewKlG9lw1Ee+0l1GcUeAKE05Y2cduWaiOI3JucC3RHkgwqMcWKjEU7hsVOFz0URWEWYnhQH8pC8x8KAOgU9PywY6nH9JF+k9GsHgV+OLYa+aSTHGOIumEsSRhWIyH7XfRJYs4KOM0dLCnrUcYpWgeNWpy1dHZ4DXwKBcxTAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088441; c=relaxed/simple;
	bh=cNsCaAiyMSC71nT8JGaQxRwOoTTxzgq9htUBVnX4oq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPVwrwow4VlbQHisPSOUNLvbECYTBR0OkEcPjcynX/bNJfvsLW0XGOS1Dv4Y4U0I6JNl4k8zoi2oHujb2nHgvfiWgrNvY9kwJmTCD8Zwlj6WBxtypwJQf9G2WU7Wz7+RUZrLOdP1BE+sVbc5QI0sU3tx0d9p0GGlJLJQ+Xq+MPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pd3yhgZd; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd3yhgZd"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-365d4d2f9c1so505743a91.1
        for <bridge@lists.linux.dev>; Wed, 06 May 2026 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778088437; x=1778693237; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4PEVltZsn31WcLHjZc3d910sZos9grkTj6lR1cPeZe4=;
        b=Pd3yhgZdXlQ7MFGNRnKhbdQmVz170vvMTVwfqvAq118gjPsLmSHBUOv9XkMTsRtpME
         Tli555XqnqO37ZROVNgK3M8O9cGyoQyJlZyRmewHRQQa30wyslJa2lVqIbWIUekT9FuN
         ElrRuhYd+/jfWUIUCEzPOOQx0J739Cae50Res+OOnI1hymZgP+OSapNZL8rHU/qShreM
         QbeSUzSnlWoBJiKbPk0KgDqyu01GzfvmlxGcDEDpecPZH/IF8ju0EWhmq3REQpWTVooy
         cIkq+55IwtJzHZqq9YguK7og14NGngD0WW4I4tZMu5DDd0UFIbhb9Uaw3p+eWke3+Vau
         6Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778088437; x=1778693237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PEVltZsn31WcLHjZc3d910sZos9grkTj6lR1cPeZe4=;
        b=iW2xtiG7Eq6Nt+CxK/DEDm6OBKl/SI3zDceAIjeA610caO41ML17pt6/6qJJPSumZ4
         6lUDm2nBXqGtxVnKB5ZvhWsKG7GkFgG7PJhg/ACpEbdxhYc4ztHS8N06JzwKyNyjwX+5
         dECfzWpEtUh2a53Fal8qpgZkyVqG43+9RhlGTq72ucxP42xoAcxHWb2VnY0X/qez72ox
         O0Hwvf/h63COYU3zpZ3NXpk1iYmsdVSsnd9M/Y+TDI3seN53dYAmf3XmtKvfMbPKCvDv
         meADV59qHGRo5GGT5ZGYYFXmhNZGa0hzxa0F0G1WnKXHFrS9myUVv+pNtcSBGsof1D4z
         CrHw==
X-Forwarded-Encrypted: i=1; AFNElJ+/A7rQdduER6usED27KiI+iW+ffOB8Ynp9S6A+ol5SfoRQLe5xAd2DvcDmrkdxbH+gVQ1FNV4=@lists.linux.dev
X-Gm-Message-State: AOJu0YzzQQkJX5UG9H4kygSpexSUOQg5orIkljk7rwcGs8SkcgEhTXOG
	CwbLT4Z5W/AHGLlMI+RVgZKdaf2ZMo5qMtKnaQydOLK0YD5OKXUO/qWq
X-Gm-Gg: AeBDiesZamaQulq1ulvKTXmm5ltA88rAPjuQy+oAA8QTKkM9zIq4FYIwmyLhETlCIel
	nE2KT8p5xwku1Xg0waPyPFEty71QCHAgYb8DYwMDQgxIe3JMv8/+xWTAalj/QCg/2QhaMwMj8hN
	LYsBZLgddBnDHOcoPEH8YZpufP+scOdZFvcpwGXY5pqRtQbrk5gJpK4T2yQ8BEV3zN6cYaO39R5
	cuUtYmMwq7Qyv9K6gdF1KzhXW3HWNpdTRgkoZskS1key50d+YPiVSM/xnVp6rOO68+Wt9QjAtZ+
	Me2Hx3LIWLUhPgRuSnBka+jm4n/StxhWu1GhXVhVG+ZJ8QYMmcllxau8ycT/EasHmVSN7Y+CGS/
	PSEz03PE3LocVIYd6fFfN7Tn0Gv5Aaq+oBiLg6RMbphNOBK5HM1Xho25cTb5qLZ5VAYRtokzyiY
	cNUsdi9wWmH3vcrPTWC8LyWQHz90xeyZnH0G1HcMkBcLgazE+fyWhiftvc6dy30TgIJAsOpkZqh
	SXGBcRHJQ8Y5LE=
X-Received: by 2002:a17:903:13ce:b0:2b9:fc68:d8bc with SMTP id d9443c01a7336-2ba7881ba37mr47008655ad.0.1778088436995;
        Wed, 06 May 2026 10:27:16 -0700 (PDT)
Received: from arch.lan ([2409:40e1:300a:7d12:5c:b984:20b1:5a8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7ca244dasm28828955ad.72.2026.05.06.10.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:27:16 -0700 (PDT)
From: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
To: razor@blackwall.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aadarsh Chandra <aadarsh.official.xz@gmail.com>
Subject: [PATCH net-next v3] net: bridge: replace simple_strtoul with kstrtoul
Date: Wed,  6 May 2026 22:54:47 +0530
Message-ID: <20260506172447.9770-1-aadarsh.official.xz@gmail.com>
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

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
---
v3: move change log below the line and add Acked-by.
v2: target net-next and simplify by reusing the ret variable as
    suggested by Nikolay Aleksandrov.

 net/bridge/br_sysfs_if.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f57c36a7fc0..cdecc7d1260c 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -318,7 +318,6 @@ static ssize_t brport_store(struct kobject *kobj,
        struct net_bridge_port *p = kobj_to_brport(kobj);
        ssize_t ret = -EINVAL;
        unsigned long val;
-       char *endp;
 
        if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
                return -EPERM;
@@ -339,8 +338,8 @@ static ssize_t brport_store(struct kobject *kobj,
                spin_unlock_bh(&p->br->lock);
                kfree(buf_copy);
        } else if (brport_attr->store) {
-               val = simple_strtoul(buf, &endp, 0);
-               if (endp == buf)
+               ret = kstrtoul(buf, 0, &val);
+               if (ret)
                        goto out_unlock;
                spin_lock_bh(&p->br->lock);
                ret = brport_attr->store(p, val);
-- 
2.54.0
