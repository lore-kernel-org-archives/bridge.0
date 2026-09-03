Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C84BAA1E
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445936; cv=none; b=By/9TialcU5MXNEQnnuoB2O6W+Rek5NmDlx+AjXujGw7/7zRaO7ZIElFlt8XtCryf3X1UEFoMQFU5ebrAcqK9S7/E61mYVNb7bMkYFfkOu7U6NbXszR77kB+fYh9EBJ0N5oYnrhv5OOl+Roiw/Gm5SdBz3Xio78+lTQkNtZmFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445936; c=relaxed/simple;
	bh=FEur/ri54hGyH4cUJi+IzbPc4XzKpmrDPdVGZZlD3ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8asHy8sxdF+Pg1c6k4rdG6vdWju/o4XAIoGsOKR1p+hvqyWqXUk8zBXHkSQJyziPQ3rPGjz0SlTIefkmzIXgsmoIql7/9RoA1FoaQzEnpFdqOhcx8Adt2ZuvaMIuShlqOyNgQr7HFXqJZF8MD0hYQzGcCrNSRI2V/ouzkA7p+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=KFVkcg+R; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="KFVkcg+R"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso3875232a12.3
        for <bridge@lists.linux.dev>; Thu, 03 Sep 2026 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445921; x=1789050721; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+bgh+p7Ku2uvfVDGLLZ5aGg6OM4iEpOCQPH5ASYbm68=;
        b=KFVkcg+RLzn6QANs/3qjYZ0ea8AzsK6A1uBqTD2UfhQIxky11vZd+X5PAJof7ZjW5y
         1VRSIVInMORHJzKBOXrDKo3vBiMTwM68XXdK8k2yzP+mIRTw6b657p28taBBpIU6cUty
         01peCyIT4MCOkB4YJheMgehjRxeWit2f99hRy9F/kSwKZHfAIaOaOtB9eUN+YtwTuWAl
         X2OPtd4lxR665qrPOQvW0u31P0A5SVGhmwFrPlZd18pc9wrgXeg9ZWh8xLTqn77pdhMI
         7PrHcQkoohW+AWdvBH3REaUUVZ8gAlcNn1GTUPNVVU4HV+4bNMGcdYJ+YZTqfZ9TlE5g
         EX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445921; x=1789050721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+bgh+p7Ku2uvfVDGLLZ5aGg6OM4iEpOCQPH5ASYbm68=;
        b=ns0Z2FkTSoJA3cv4FP7zuiQuRKs5sRdfs1AZoPv7GPPU09+llRrWOBn+WnyPP3Zh6u
         isf4oO2uQUnuGSZAzZhnFmQeUhENjCcZaH/OE66BB3ZAlR/Jh4gsiJve+/i4aerRmiMx
         U/0OHhiyAd3nZYDjrQCriEbx8YrAvhGO5m4ScMizELgq7bi62lt/Kog9sKdCnNNRe/3+
         tFcwCdMdSYJDScBKNjUqYAeMWiV9Y0RirUXBshIX7Vht7vqezVZ6YHa7FKSz/mN/00Ix
         gmNau1HgtXAUHfkDcDFqAQyhMlDoOrsWyZtFyT9pDa9I2TnkaSJyBs9pYNMiNtlDDRfD
         7Z5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwb9pS4/u6cAN28vXhRQP+O4e7X5x+WrCi/n6amfiqY2iHO4ThSf896c2dhLtDqkoeTtHULzgM=@lists.linux.dev
X-Gm-Message-State: AFuF++m/w3lYIQSCCRblGv/D9aKSd5HnCs7kE8oHn+5lGN3nwG4ijl2I
	yR4SMBetrpIwGXg6wJfy61CGZJpx26PF0s8iaFQRtHdXLYduSeTTY8+L2tDesyt1yWk=
X-Gm-Gg: AYBFou268KByrU65M0Q4gaJ2uv3joT0NC6VOkV5dd9CWJ1O1YtglVHBSxd816EZqJx6
	hkGSi1ZSfH18Tvts3r1koHHgVZdfHHyfXwZuYuhkfcEYZQQfWu1ad2LrGqmZ+vlyNIhvwjj1+NC
	7Etle1mhQfc34hdplUylHyawfNcPRKbdwpY9nqNYiBEYYGOJuhZ5W1n6KrIvZfQcUllMxXpbEWV
	O9PkNOjZ+2w3CAArraQsXOUearENIPZ9xauFvQYbCohcYLXxf4qPiBGmarAvJ/iF3JKIbcFS0JS
	mxYFhs2ZrHxDpH14dEu0rHyA5D/Rsey8Jfmd+FiDFFFp6BaQbU3BBXSWRtYN0DN754hT45Ll3lD
	FuV0xxoEfPxMqhle23LIrth8hxdIJlsOJ0VDMnn0YTu2C8tdPOx1FfauF4zysyqk9DgwSDWHwoC
	WD3Vb4aqhWwX9NfxxbADKb6nDjwfzo0lfvNaamKDfvEsJoZfxcpakX2aqkCCBpd3CT7LnqK8a9j
	bTJOfC2xszXZN1NK6VO9A==
X-Received: by 2002:a05:6402:51c6:b0:6a6:7f0c:32b6 with SMTP id 4fb4d7f45d1cf-6a682ac0831mr6738716a12.15.1788445920954;
        Thu, 03 Sep 2026 07:32:00 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6a67f8c7a0esm2400317a12.13.2026.09.03.07.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:31:59 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/9] net: bridge: vlan: annotate lockless pvid use
Date: Thu,  3 Sep 2026 17:31:31 +0300
Message-ID: <20260903143138.1574598-3-razor@blackwall.org>
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

