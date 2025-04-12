Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21351E9B0D
	for <bridge@lists.linux.dev>; Sat, 12 Apr 2025 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460679; cv=none; b=U0OLeUasLAgzfouGYQcpJ5czNwk5TrW+u0n2Ot2is3vjNtou3dPLj8QI+KkPphF08HWrPa0lzlhXpo//Ze2ETqVeBsi2zfJ63SpACFELzZ+vSJiR3CSTbIUDCoT4cwzLxnF+ajr+m00G3kQlF4ZMTyeY04OgjMeIajnnzZtkqTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460679; c=relaxed/simple;
	bh=rY1TeKaSapTBrLHShvIxdhjK3OX8149H0qymlwcITCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLuxIeNmVNSFplI5nZCCwZlMIpB0A1SdaY3Qgoixdcc8dGDJqxjCp+QccqgnT9rxwqSeGqLQ1WFo58YYXZe8oGv+8E7lW95iiv1rnkZMEr+mJ69FPATf01jyKmXsiM4JlvoRv5jLoznVR17nvaMnQg6/pBDsFgb9tFki2LeYwBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGmX27hl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGmX27hl"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso559486466b.0
        for <bridge@lists.linux.dev>; Sat, 12 Apr 2025 05:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460676; x=1745065476; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkw2DLu2MuX4YCRrxN6mIReFgA1BqxAF343I23fbZ64=;
        b=kGmX27hlALFP4EfO8egPoRi58+9ePdflcgdLp/D1kDjfcfwFSs79vKAuRWX9tng/XP
         LUleh4/rp110Zo0vYNvl1tP8A8qqkBy1UmyXPZri/OCcUbw8Al4fQfpS6tNiEBfBACHk
         PQFfTMf9ZsyNRdfqEcKst0VBbd9vmNNc6ebFH761ZuzOVW950WVhcCCZT86AyqAyio/Z
         frkWYFiFQfhM6WAmlPQg/xNzivIJMJYjInpY9/PVVOw8WWhpC8xISVaDEqkT+2vSxI8p
         D8xVk/4qpE/2vHkWcHDhK/bIq6hoLkc1GEXyRTOhJtX1Rc+YqgLI9z3kkL5G9oPH9iAT
         24ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460676; x=1745065476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkw2DLu2MuX4YCRrxN6mIReFgA1BqxAF343I23fbZ64=;
        b=DDiafiScdVON79ZHDugTaKW6IZif/CnVKotI8uPBrItVwAwvRPh04j9PHQhnoliu2W
         Y/RksURJ6IlPdKFVNtjXuKox/FBvZwgYeKJw1pA+UE8hKJqfBpXsWky0kZ76icrQgSvI
         afMquVHamWLWLfjSNn3moGEdIt+ISKYfPvKA+mwCQGsm7yHy6vzORJTTvb3PWO4/nD/T
         FWlKdA3ATaGq9Csj0z89UWpa65KFnLeS7/FG631xeXOPVwaRJoMsS/ZJMFMPAhDe3DDM
         I45XBQhr76w/HdvZWpm0mxWr2VCMF6Sp13zd6a+tIPpHqniso+f69uG8VcSwmCb07OHt
         ILVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8OcIhVvHrUpjPQ6cwSCVaCYJhfYgUgm+NbbnOYwAoEWkhcpx3TJbb7vbuCUNUz4RF/hMCDZ0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwIXzsjd/vDYfu+mBjoIqKFmtryt2le+GTcZzhTyGwNs3lSSVOw
	+Q/5oOYViwKK9HWXNKrFoH7nb9Ow9XGvnCAyRRdutDcCvOba91dx
X-Gm-Gg: ASbGncu5P/LF0GJa8ev4zj0p96W+DH43UTi8XjWNznwi+eW6fjE2vYxRbEFSjBUV87K
	9yA2c6OV1XNRPgchcurDLGFEhNJyMEDNH7vbs48oLG9Z/xltrxfSC+eHrgurDRUBh9EwrzL0ph/
	AdSg56OyVTUh+dmWZhi+xVYartseF4us3TXOfOb9+7rQc2ZHL2xcmkj2MAmR75RB++tfiOVafeh
	dl2j9+koCu1NMKydaw8Up7fqUxjGr9Ej+W/utvZNDchMm1Bv/TXCgLdgsaUYhM+eoxakhPAuKUT
	cZzbVf63XjiaIPnJdt1tlFBdAyJTLMRYtx6BdKyiDPh9CnfX+Wj5dzjoYGbjBZPVy8QFZQg1vXL
	uUN3IPhLwPIgf91Xdr7ue
X-Google-Smtp-Source: AGHT+IF6b7JdMoOluM6K7HRrjYFSRBdYLvJnP8t2CcaA5YsZbKa8oHLzNRX8VZ7oAaKXWjrBmMk0tA==
X-Received: by 2002:a17:907:d92:b0:ac3:3fe4:3378 with SMTP id a640c23a62f3a-acad3456bebmr548716766b.12.1744460676005;
        Sat, 12 Apr 2025 05:24:36 -0700 (PDT)
Received: from localhost (dslb-002-205-021-146.002.205.pools.vodafone-ip.de. [2.205.21.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bed98esm592465166b.72.2025.04.12.05.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:24:34 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net 2/2] net: dsa: propagate brentry flag changes
Date: Sat, 12 Apr 2025 14:24:28 +0200
Message-ID: <20250412122428.108029-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250412122428.108029-1-jonas.gorski@gmail.com>
References: <20250412122428.108029-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently any flag changes for brentry vlans are ignored, so the
configured cpu port vlan will get stuck at whatever the original flags
were.

E.g.

$ bridge vlan add dev swbridge vid 10 self pvid untagged
$ bridge vlan add dev swbridge vid 10 self

Would cause the vlan to get "stuck" at pvid untagged in the hardware,
despite now being configured as tagged on the bridge.

Fix this by passing on changed vlans to drivers, but do not increase the
refcount for updates.

Since we should never get an update for a non-existing VLAN, add a
WARN_ON() in case it happens.

Fixes: 134ef2388e7f ("net: dsa: add explicit support for host bridge VLANs")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 net/dsa/switch.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index 3d2feeea897b..dc3cf13ef29a 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -702,23 +702,25 @@ static int dsa_port_do_vlan_add(struct dsa_port *dp,
 		return err;
 	}
 
-	/* No need to propagate on shared ports the existing VLANs that were
-	 * re-notified after just the flags have changed. This would cause a
-	 * refcount bump which we need to avoid, since it unbalances the
-	 * additions with the deletions.
-	 */
-	if (vlan->changed)
-		return 0;
-
 	mutex_lock(&dp->vlans_lock);
 
 	v = dsa_vlan_find(&dp->vlans, vlan);
 	if (v) {
-		refcount_inc(&v->refcount);
-		trace_dsa_vlan_add_bump(dp, vlan, &v->refcount);
+		/* Do not update the refcount for updated VLANs. This would
+		 * cause an imbalance with deletions.
+		 */
+		if (vlan->changed) {
+			err = ds->ops->port_vlan_add(ds, port, vlan, extack);
+			trace_dsa_vlan_add_hw(dp, vlan, err);
+		} else {
+			refcount_inc(&v->refcount);
+			trace_dsa_vlan_add_bump(dp, vlan, &v->refcount);
+		}
 		goto out;
 	}
 
+	WARN_ON(vlan->changed);
+
 	v = kzalloc(sizeof(*v), GFP_KERNEL);
 	if (!v) {
 		err = -ENOMEM;
-- 
2.43.0

