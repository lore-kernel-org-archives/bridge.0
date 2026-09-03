Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97C4B717D
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445940; cv=none; b=pJpSkyf96SDCon/bbclVjoR9E5jz9GWKnD6ljEwXMt74F5FDzypoXgxW+cL1jEtv3dR8Xg97OO1EGY8/lQTPJbUyLjnicwloJ9ZAm8waV1iJWg0y2mmp5NJ7iw0cOgitHhj0aGoSyUpnmaibHDgij2rQsCVXHMwi7VYQbBKq9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445940; c=relaxed/simple;
	bh=0MxeVaPX+VtYHYLIfWJuakpriIgNaFhZQH5yt5XofQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubpfjC66rYZy2b1yzQEDvPm6UoT4+aHAZQsT0NmwGUVxvdn8OOx1dOGXLa+Vc5hvipk7KBxD2w4WYP9sOEr6Y6BfVUKktq4lXtduxovd4MysAMzPAv5yAIOrO55gWiSOKKLW7CHRcAu1CrKsJuxrSMsHQvE3knFAJ/eyCi2X1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=dKphl0B2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="dKphl0B2"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a668ce86abso4355742a12.2
        for <bridge@lists.linux.dev>; Thu, 03 Sep 2026 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445919; x=1789050719; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1RePcB2PV85iRGG6QHEJIV9lhGnKs9EHteVDOYprXQ=;
        b=dKphl0B24PW8He4SRH3x2eaM4al7dO70/oZw4WFsqyV/ZqTnfbgt5w2D2iusIrvExE
         uJWJiXFhRb0igXM/7TeUUu/gpH3JOQ7yUfwlyrmW293vVx7Ploh2yOo6lKDZpvkbmiKC
         xXINw/x1v+cLZxPbdPLFyMn1yqvhaP8fqKzrU3AAUqgOTc74pJBvwuar5PVbAHeQ5N94
         rs6+sU+VuFXZ/pD8BwLP/D+e/NaZGbJbn8qCNGLl08OeK2u38PxbD7ec4VXVN0TDk7Yh
         ZHy665lefauh5ZTsHzchKORUfd1pXjcCQpQOy7oemYxgre/qwZXuFI8XdqmwjRXTW+ps
         wGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445919; x=1789050719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w1RePcB2PV85iRGG6QHEJIV9lhGnKs9EHteVDOYprXQ=;
        b=OhvLDmsWJhPwShfNHR5xaMzwSvXp353vBICapYYcTN0PKD0enQ/lJd9dYdU5fOmzBB
         uZKk20ycJjSmsUGPy/wEUJyudM9H27iTO3tM9UHttPFWwOjYCNFYvbVsmJZDL91vJFyD
         dd3qHzehrbckUzddmpg1ESGflVJWUFKP62aL9j8lhzvuEVlUhL6/A0NZYhR7d5BfPPSj
         dpmuk1tNqj5YFJrRJRd8aec7JFNYIat51cTtwMZVykZ8u2E+Is5r9+7FQXLiEtA064PZ
         qNQQ1UZYdDx87HkVgkBVbCO9E8A84m067piRT09vsIFKy2fseWd/GlMi8aluBo3EdIoR
         JdFA==
X-Forwarded-Encrypted: i=1; AKwUvBx+WUOvp58kDkpj9XONhZ4U3zpQ2ApuCwF4HcMhgC4J9Wi+4sLTnB639gvL6HXPVxI2q/GIWN0=@lists.linux.dev
X-Gm-Message-State: AFuF++nEbq/AySTPNxXP2yrd6pzedqEli9qlq3ZhAHzVUVjczIHs09Bo
	qAMJSU7iLZH/bRnRzZjcoyKObe8Wfqi74etPvdyR+lYK6QsFyX5VJdyvpqNrb58titg=
X-Gm-Gg: AYBFou1rkc8Irl9iGaM0HyNSJpnZ2MT14bWYoTIL/Kmg70fPXnaEzVN9dmN478MrOhK
	/Cni60qp49PcI1b1HvV5FuJvLsgU8QVJO4rTfwh4xI/GedvAgVtdoYPMnIoEs1HBtzfRTLeUvOo
	D8uedIldLLKM5hYWZ3Uhden5oB0dUVzDOKUvFynglHj0M3oRFmufpkkNJmZajRTt65VbhE97OGe
	+wOG/LCbRocirsFfWs9uQneJjrAhg002hc4ki+I791cb5x/DTntuECgAfDItwtHvHRaB0YblOa/
	dON/dSExko1q28An9VWn6KlU4Ndtkr5HpkxfLevm7tXcbzQQ8WP0p2KfCR1nFvjyYJZOoGlMo3Z
	BUushVk+d2JnTZhuWcpDggMq0bI6xKqZNVwQzYxvNUEa3UKkPs22jE4beynafMyu6bjb1Zl2ibi
	f5pRgTxaGFrArC/YnvDJF31SN6k3oN9oYbMMAL4iOoQ7aUdsTFwTBfZX2KC5ZhGiyFtd39
X-Received: by 2002:a05:6402:440b:b0:6a5:d8eb:da01 with SMTP id 4fb4d7f45d1cf-6a6818d29e7mr10408738a12.0.1788445918887;
        Thu, 03 Sep 2026 07:31:58 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48448eea468sm15013634f8f.26.2026.09.03.07.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:31:58 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/9] net: bridge: vlan: drop legacy memory barriers
Date: Thu,  3 Sep 2026 17:31:30 +0300
Message-ID: <20260903143138.1574598-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903143138.1574598-1-razor@blackwall.org>
References: <20260903143138.1574598-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These memory barriers are legacy code from the old vlan implementation
that is not needed anymore. They're also affecting the fast-path.
The pvid is changed under lock and is read with rcu only in the fast-path
there is no need for a barrier, nothing to commit prior to changing it nor
invalidate prior to reading.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_private.h | 1 -
 net/bridge/br_vlan.c    | 2 --
 2 files changed, 3 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d337b1cfb980..5b2c22ad669e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1687,7 +1687,6 @@ static inline u16 br_get_pvid(const struct net_bridge_vlan_group *vg)
 	if (!vg)
 		return 0;
 
-	smp_rmb();
 	return vg->pvid;
 }
 
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 1e0e436629ec..2ae6ffb23399 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -40,7 +40,6 @@ static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
 	if (vg->pvid == v->vid)
 		return;
 
-	smp_wmb();
 	br_vlan_set_pvid_state(vg, v->state);
 	vg->pvid = v->vid;
 }
@@ -50,7 +49,6 @@ static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg, u16 vid)
 	if (vg->pvid != vid)
 		return;
 
-	smp_wmb();
 	vg->pvid = 0;
 }
 
-- 
2.47.3

