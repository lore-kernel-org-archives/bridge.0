Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2138F926
	for <bridge@lists.linux.dev>; Tue,  1 Sep 2026 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264461; cv=none; b=WpX5wYuQU9K8M0CRoNSTJekkRC6AZxIE33LCVsPshKEVITcTP8/1hetAORc8/lBfcQGmeEkUFIwNa+dtLVjS+A4+gZWXHMaBbwF/w3H6w23VMmCbrDFWFyqD0xixUwbN2X8saIUO/ZfSnG7jmSlDJz9rAN9dBsaGPxQArfyvezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264461; c=relaxed/simple;
	bh=FEur/ri54hGyH4cUJi+IzbPc4XzKpmrDPdVGZZlD3ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rbx45pV1+nlMCc1vb67x5P9B2jM9sF/q1ydCDyl/KyCTdwk4xJy9P9umTyJYM1rrQvvn43aO5w+/85fN7CUNDAB0IUDeiOtkYD8YjFXjKn4JUjmjALrE6FQXmyLwZX4rbFdIUKKPI/gou7zQ2qObWIcyXzc0O4BQxOMZqfnF//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=MC1+R4PI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="MC1+R4PI"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4843efcbdb2so1045296f8f.2
        for <bridge@lists.linux.dev>; Tue, 01 Sep 2026 05:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264458; x=1788869258; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+bgh+p7Ku2uvfVDGLLZ5aGg6OM4iEpOCQPH5ASYbm68=;
        b=MC1+R4PIc8Vb66O+MarA9X186Gy834qfLmi/2/nQiKTxUt3saTB7I+uctBwRuVDrcZ
         yMTox+3jPQ6t2Z0j8A9P4M41d1zP8gpDe4CnQjYosPZy+39IhUJQF5ZkyXmcMn0upUp7
         d32+Pc0qU3HpZTCDc/0hW+efJmGmH9we94rNBl8rMQ2ddZTeXNKLPHXxnFS3FUoXen/t
         UanF9yhVmD3rOj8PjdXk0gPQo65aguklD3SkXnIl0HXSWLZ6OhWcpFx93YI8xK3Zfw04
         2y9nJ442FCC16EZWxTi8yD1kaurOKoz37uArhE9Wf75nsA/50HCM4wJnmAREurtyEbCK
         nkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264458; x=1788869258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+bgh+p7Ku2uvfVDGLLZ5aGg6OM4iEpOCQPH5ASYbm68=;
        b=jUTLLpXRV6JR7yuBxWIQ8WylznBW5AlCVxSCnHs/JLRHY/EZN6sT/r9BRVdlOtHOzH
         FY36gbo5ECq/O6K6ASKllgPgVBsexUf1g+Y36g4dTLMPRJqY9vhPqt+KYv223JkfEpnf
         WiPu0xDEQfHkxDyy6W10+7pbgtWZrHBACW0/f7YMdDXLkWsphcWmsSkB564Il9TTS4eO
         U0NvflmjNtJBLXYPThTtyCgzp4i3fobkYWtlIgchts/lFlHrXM8z9ddX2EpkrCdfkYYx
         70AEaYwYjJdIPHV4NIC2aP6R6uqQBsdn2+p8lwJP6/e06fRhtw8AyGXn9ToMvfAAJxWC
         ypgQ==
X-Forwarded-Encrypted: i=1; AKwUvByV2fMNjDvUMV/Kj979T7So18cg0cPVdmy/aii2u1u6BJBohCjBh+fl2mPXcqaBTI7ktmUVVeo=@lists.linux.dev
X-Gm-Message-State: AFuF++ntIq6KhrtNvx+zHcep9tSYO56pvs2tkqWnPue1NXc0FWYiMJoL
	PBuOWt+G9kzrNLjVi3UFqvlYJ1KiXChmR+vtQmn6hP8UNnaE52G/XRbiqB2/baaMxIA=
X-Gm-Gg: AYBFou2tw02y+AS47rEKEH07q8+lhDFvvPwn9rhSqnO8G/WspQzpF/DBV0mklL0eyzU
	p7sNhkXObvyfGw2xqacDe368I/5O02aCA9fYz80kQg1H0GnK3EJxb/SOX87zQrZfGSljdzvoxA5
	QCuRCp6okQnywRA4z7L/dw4RL3f+LKtQ5JzvqPU7YpmIjZGpsV4/MKTaiS3j4U9fbLAeP011RhN
	qVo4yrLnXurxRz1J8x8+frVkIDrge5Nybbc4i0IpDdGJ0Fc4kv+WrWPf2EARQ6G2+SmSzSvlFd+
	R1lpWxELr6E0VMvOUKzXMukQvCza7nALXqc+g+AnB9xtm8t5YacGl+Iq6kGSi0CkPVIDbKM/1Ox
	SE+4J7/FLGKU5v0XTUgOvptfGkZtemRwpJ+Uud4WTpJMbT7yxyIAls4wJHnFrnFsUeRcOkFyyK+
	mNmYXEesLyBcS99cGC83iQJnarib8jWnHZ1SxL/6Cq7Bmu308DUPcthkMrgl+X9ILh94u2Tu1IF
	u/w3EHM+RmecaLsceqlTg==
X-Received: by 2002:a5d:5d01:0:b0:482:fd9c:5d25 with SMTP id ffacd0b85a97d-4844101181dmr14309649f8f.16.1788264458091;
        Tue, 01 Sep 2026 05:07:38 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d6e826sm4430021f8f.19.2026.09.01.05.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:37 -0700 (PDT)
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
Subject: [PATCH net-next 2/9] net: bridge: vlan: annotate lockless pvid use
Date: Tue,  1 Sep 2026 15:07:14 +0300
Message-ID: <20260901120721.747908-3-razor@blackwall.org>
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

Use READ/WRITE_ONCE to annotate lockless pvid use, br_get_pvid() is the
helper that should be used outside of the bridge vlan code. The rest of
the vlan places that access pvid directly all have rtnl.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_private.h | 2 +-
 net/bridge/br_vlan.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 5b2c22ad669e..0efd2e79e255 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1687,7 +1687,7 @@ static inline u16 br_get_pvid(const struct net_bridge_vlan_group *vg)
 	if (!vg)
 		return 0;
 
-	return vg->pvid;
+	return READ_ONCE(vg->pvid);
 }
 
 static inline u16 br_vlan_flags(const struct net_bridge_vlan *v, u16 pvid)
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 2ae6ffb23399..a53054fcc093 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -41,7 +41,7 @@ static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
 		return;
 
 	br_vlan_set_pvid_state(vg, v->state);
-	vg->pvid = v->vid;
+	WRITE_ONCE(vg->pvid, v->vid);
 }
 
 static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg, u16 vid)
@@ -49,7 +49,7 @@ static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg, u16 vid)
 	if (vg->pvid != vid)
 		return;
 
-	vg->pvid = 0;
+	WRITE_ONCE(vg->pvid, 0);
 }
 
 /* Update the BRIDGE_VLAN_INFO_PVID and BRIDGE_VLAN_INFO_UNTAGGED flags of @v.
-- 
2.47.3

