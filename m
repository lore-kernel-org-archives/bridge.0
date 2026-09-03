Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109A30569A
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445947; cv=none; b=R2ZhvKFUgIDoemv+U3ZIExXBpVdxX4uMz+EhmmxVGNEMQTgNCtwomLBiky28xvSDCbUrh+xN440vgEbxLJ6r5vLrsI/JzkaYXaJ/shlsa2N4AYW+bxZ/Vue8N17vZ/phOomAjheFEGBn9v4mlYbMwchYEqPK4sUeL8pXZ5Dn/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445947; c=relaxed/simple;
	bh=vDHm7CkTNErA2+VH4D/qGhWbmoMxmNZSOesyPx+peIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kujk8ya2J7axcd9wL/y8XnYLLRiRoChrrt10Pm/dvQ2ksJli2SKJtTI/9F/19la5fEy9gW6TzJNSt/rSDAtuS2Qde/ubEB47DD2K7O+nV1hN3FKGDrEakZ2PYOtsLiUKLPDNIGqA6kAlbKnkdaCFGq0o9NQavCgUGUOtR7KP2L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=SMSnUlyY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="SMSnUlyY"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c197e7e4e94so378912566b.2
        for <bridge@lists.linux.dev>; Thu, 03 Sep 2026 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445923; x=1789050723; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R+TeBJucdheuLQOVi4XpjZrYuesJgF3ndjF41LXDZJI=;
        b=SMSnUlyYfZscVlQk7P2FfXUYkJtq4BX1jY+gD5pc44C9Gn07R+zEHGhdr60Y0x5StH
         YJDk4/bJw2vCKRYEcXRV6Y3XUICoo63p42gLk79K6xqClfF65FprWnTr5H5oaYaQDwbG
         wTPU99JWW7kT2Y4wDTGNZw+hxcwX400zQJDqw02p1l6DGwVtLxBan+JBVoj74Mttp0T1
         jtlS8mL7yV4+auNiCa99MtCX6w51vBdhWEtktUaba65/w4uUjeN4HUeXfSyNv5Gqg+DS
         HLu9bdf/h/HSRBt9loZIs5CN8iS8xgvYqXQEiuaW6/8tj9XtY/Tr+bup3jQ5CaxSuKao
         kC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445923; x=1789050723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R+TeBJucdheuLQOVi4XpjZrYuesJgF3ndjF41LXDZJI=;
        b=m7mAHrhs1y/gYhNjBcxyGLZj04kur+LT+xaOTzL7RDQTufm+mFoiIB6kXI25Nvmxlt
         VW4B1x1r5U99G73Fg8HPQaNgXrxfuriA9fcCsU0D8pK0wEYVIy+wt03ge+xbKOKDsRut
         Wg7PJYuc0DgSVkYJGzGkMPWJZt+rFi33/kkvoESvb31EvOBDrWC6OIuasXzKdjCITKnu
         hDLxLiI5VbDGBVdlPRl19+1n1DyYXAqb53cwNC8f2EGkRfbefgZSClspl3/ZZqcVdbIW
         50WKqmSVuaF/G2q8pO2EkZDEZv/v28Ul4ZOBy1++s15mFRD6V7jpB+c72+tIX3XX6kGT
         uiRA==
X-Forwarded-Encrypted: i=1; AKwUvBwM5XWqD4aULKxWhtoNP/rs7onierzzYX0dWhA4QIhuAtd55jB/bNc+EsYPz46obHnnsQB8L3Y=@lists.linux.dev
X-Gm-Message-State: AFuF++kkxc7ZAYLxz96Ys2e7cKgE21lbIpeiBWDejCNSP1QFO10mVF02
	JsUSygZ7OzaJTKQ1AdG9UPF5On7rvMHvI6DCgLcitx150C3vMOZUseDMMdwxMl3CPIo=
X-Gm-Gg: AYBFou1CgSg5bfWSPEKpj4zqL8kNMdj+bT2BQ/0wuvURoFbMnShhpGnxA1N91Ikz83g
	bAewFzaFQhzlxnv01kkV2slC7L/Z7aDnfuzSKgjI4ymZZ/dEzfBz84+CINHVUJXLpZo6/2FrqHE
	SAvCAytDtbCNhzNVpfCUCEH9RvUPxdbRIsvVl9YDZEGcTy9urmiNnMbr0goXQXPZs093z+4gwcc
	OHcmfhCB0aloB2Ywk7A1xixn+hdfq2JzbljnekViJsmVwlM/3j/Ik2g3f5BcnVh4ejd2j1IEYF+
	m/6HSfRuL3dkWDAsJvrqdqeV5baRq2g51wQY0sQRZ4NvB8E190NdX+Iyo1RDSUbmBz/Fva6XS8P
	1rHyM1Ds4o/CQWgAGDG7QURHdcwj3NTcR36OB+eb2Cl672jCC+eT6nKqnj9guFi2QHBqFKzj3vY
	lxSwPwcgD9CHpmK6HLPjXcXX0VHcFzHEqwJw2AvPRXyZoh94kIhgcRq65fFJRjMgycmEH3kaySC
	haVj+4=
X-Received: by 2002:a17:907:198a:b0:c21:8c6a:c680 with SMTP id a640c23a62f3a-c25d563b583mr924706766b.22.1788445922972;
        Thu, 03 Sep 2026 07:32:02 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-c25f423f2fbsm106058466b.58.2026.09.03.07.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:32:02 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/9] net: bridge: mst: use br_get_pvid helper
Date: Thu,  3 Sep 2026 17:31:32 +0300
Message-ID: <20260903143138.1574598-4-razor@blackwall.org>
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

The only place that accessed pvid directly outside of the bridge vlan code
was mst, change it to use the br_get_pvid helper.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 43a300ae6bfa..95e49ec8065e 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -86,7 +86,7 @@ static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
 	if (br_vlan_get_state(v) == state)
 		return;
 
-	if (v->vid == vg->pvid)
+	if (v->vid == br_get_pvid(vg))
 		br_vlan_set_pvid_state(vg, state);
 
 	br_vlan_set_state(v, state);
-- 
2.47.3

