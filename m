Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE1639A7E0
	for <bridge@lists.linux.dev>; Tue,  1 Sep 2026 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264482; cv=none; b=TbGUqM9Wq8R38ImVoPCh9OQJdhEg01aT/SHMOM4brpzmMZhKKdJrutBSJ1Z9XT3mjqWr9AQ2nFskp2Ed2eeaCnwD7TUSkJ9JhSVzqkmQWbB7GYCTvypuFeKGzMvh1uq+dEDSedC74mk7046D2ghGZP410Bh2gO82XzOaOi9bPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264482; c=relaxed/simple;
	bh=0MxeVaPX+VtYHYLIfWJuakpriIgNaFhZQH5yt5XofQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvAHISxkEuKlFDaNvvCIfUskBQLg68cJbuUmoVa4kIzDny4ShUcu7fGtY3vqWguLFAHMOtyuCc3w71rTncbaIeErm8FyMe7Fa8xMQNEnvFrFqHT7vBFnMicbwBSqzfPlQWR7DwuWqdbimu0rCsA3Ol1JI7U/NhvFT70UwAh8C2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=fdcujodR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="fdcujodR"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48436216a98so1428749f8f.0
        for <bridge@lists.linux.dev>; Tue, 01 Sep 2026 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264479; x=1788869279; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1RePcB2PV85iRGG6QHEJIV9lhGnKs9EHteVDOYprXQ=;
        b=fdcujodRVL1MH/2YWryn+7CibEG60oPVHYCuqoNpi3H+GygHZCsN61SI6rP5NsatxF
         Y+c+cJpr9mqvbjVZe/t3bLZn5XPbRBBjSbTwpk2zdx23sQaylUhRrwlUsMZsLz/OMnFc
         Jr/wF430WR0yqyicNnTzgIAOugxq4TXoBggjcqdRPlBGdCrv04+kbvG2by9Zwqxb8xL2
         rHOsDDlZuVcG9UgOrJAY0Oja0CzpoMbmMza0nZ9gFr4e+JTIz20Xlf0yKTYj8ANU00jw
         7RwCF/pGbbIHeC35RWntv6560mlw9u5qLgl+AIjY2szAW53yShpazaVkMcPxlA8unt9L
         1nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264479; x=1788869279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w1RePcB2PV85iRGG6QHEJIV9lhGnKs9EHteVDOYprXQ=;
        b=diymcrdxe06EQJ4aHrdL7v6X9yBwPIklwVip3E3pgizJxahQm/cO0kOG6hZV8fNLtG
         7+8Q407BupfUlM0imZjB5Br8MzxfMQYrD3guI9IFLSWbMhxdLeJuIlR7MSDr+K1ql7TC
         RLsqXP3ICwJcBJYyBL3Bz72hXu7AYleWN3SAOUtMsJe/7BdCKvUUebNB5rXoW4MWMrws
         qlCFYp/fBlOGL34JVRAeWaigAMafe5j10bUI3lbO8ZMKM7MMLR61RUfY78uSCpqaLE4q
         5RWmp/IszHNdngq2P0i4zZQfhEDWQAf4AJzVhDiNLOD7b0UaJ5o+ktmAvy3Sbc/uUM2n
         pjIg==
X-Forwarded-Encrypted: i=1; AKwUvBwza/gg+UU9MJnPyElMF4c3SbrC3Zqzc2C7XkYv4NfbicJkj9WMs0inDBSoYcn99bU06i0bv3c=@lists.linux.dev
X-Gm-Message-State: AFuF++mkvSRjJ9KY209Q1Q5U5oFj8ipJEPS2Rg1crdKdsGVgC++yawI2
	Mu8JP90/3TyavIOlwIMHdzG/Q0PPiQutNHldapNoF4eShjTKp0nweBuyR8V27vm++FE=
X-Gm-Gg: AYBFou2J2n3crJ+tpX9zio5YaZZkxuxqDe+XSL5l+wY4noZolQxovzX7qLi+ZM5LL6A
	ljYFr5RWqK+AxdNJNR8Yu2q7IJr+4LkihV8KDk4Yr2wkQS672M0HIMT7/rMfJQSoTPoOYHOatHh
	KZW8t4pGc4gGUT0hESls3VAjd8vX7qeIXjsdyfCe+vdJWd2pUIm3bES92NptbYV4pwKWCVbouN7
	/8GpjexW+GxNuWzo1U5xlTr4dLwLrRbS0gaQe/NZll33gQY7BIQsXg6/QTpwPTK5aEAD5etYMi4
	fWuXMM7ngBA+vEVMHjUTZAKoe2+LmTlIJa2cdy6GoOQ0YxAu3IvO/KYBnrAJWuTy0wqNH7OOREY
	F/GqNY3eShZAJz+XWSW+ZUNJNJ6E8V/oVazkVIOpTEXO6nZHNl0huQzqOBOgmKArbCYt7rvQec8
	/vAPU/lK7INIyDoqIiiyFxqdn33ELUCuBjY0a31TQzTLbdQ0CKpzyYZvulVKY+qgHtv9+9q0QSI
	SCdSpHIKVM=
X-Received: by 2002:a05:6000:4910:b0:482:a8b1:aa6d with SMTP id ffacd0b85a97d-482f79c1923mr53183309f8f.10.1788264456451;
        Tue, 01 Sep 2026 05:07:36 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d781bcsm4239998f8f.26.2026.09.01.05.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:35 -0700 (PDT)
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
Subject: [PATCH net-next 1/9] net: bridge: vlan: drop legacy memory barriers
Date: Tue,  1 Sep 2026 15:07:13 +0300
Message-ID: <20260901120721.747908-2-razor@blackwall.org>
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

