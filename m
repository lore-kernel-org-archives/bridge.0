Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79430F526
	for <bridge@lists.linux.dev>; Mon,  5 Oct 2026 04:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175121; cv=none; b=L+TEHyhrKms8YuHdBxYY0SBXvLYLxKUb7/Tn66MxMPOXuicTAwg/dlEr5M2haySbu6aa6UkwyAa8a4vBrJeRJRRbtj1UJu1Ze4rdHEkkqSxJxm6uv5BajUILesapEziq03ZPD6SxTzXt8SQuNgfSvFvm0cukOj3EczYbF+pJSK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175121; c=relaxed/simple;
	bh=nf2VEgIA5V8IZnfrS95/iUAfy7BDBD8Wra2bFqecV04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnAc+S+Cw46R6o/7j8e5nbmxobcNyLgGdEfaawggvQxp1WN5iN7o2VD4KG/HlXnQVQq8qvAjQaT+EAdUuuI1bkSJx6XYlzfllhlXnDT8eW9QmE7Em3UVUOke6FpkMHwtx4l0QOnGl9CRNASVye/uLTLLGtnWIhjMEI8cdt+G+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UP4o4g5y; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP4o4g5y"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3396cec93b6so1629534eec.3
        for <bridge@lists.linux.dev>; Sun, 04 Oct 2026 21:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791175117; x=1791779917; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m3RnpCbUlx5vRacAcPCSy9Sv4WlyTpLU86dq8MXP9H0=;
        b=UP4o4g5yIFdA38N721tOWJ5J2SaiyMJ3onmvo+pdMOD+w86bOaGN95o0kuhEO0EVgJ
         R+JLUBfDXDOuLX/uCO//3RfXyZV1eEnUjOkiEBJ8KsbX36RLKgomYcqRdDPH8urVYuex
         RYygP7iXkt6wlK8syL0libFie2fstcofq8+3TfAGps/LPzHb8buntjh10xWwq8hbnXc6
         /q/Il7mtm3oudE6af3v4umKgyjEllajPlOCvV6xJxm4ZLrt7acVuuBha5MG2G9pzKrkz
         rHdjMAlKuBJxy6CVLFFPY8BlDci6uxB5Gn3GWbjZRIa1l8/gLJbZ0k8FhE0r1H1BQJwP
         AgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791175117; x=1791779917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m3RnpCbUlx5vRacAcPCSy9Sv4WlyTpLU86dq8MXP9H0=;
        b=X4rn98l+Gn8dhuOWIeOR+MZCywaA8uwH/nzWonYoaetqZsaFfUkCp9mYxXVkqftkQP
         usIFr4dsKwqnOIFJ43Fime+Zk96km0zisBi45QQptazBmS6zEVKVsv99mQC7r4BKy1um
         5P/rUeg/ZcXiEy6P+4PyMwSKMwXi5xGf0OthR5tKg4nWVkN3b2yeEsxtnFpDNBY1QBxH
         ivpS/hO3eKx1CwU6qv0ybUKuArOBItTHOpzD+HW435S6eKR47mGc313Ju12NyM5a3USx
         8G/FMDztpWi8qa3iCJEEnrRZ9F9h6AlhtwssqC8G/jzfGDaNPnZ1lV9hcq/oUvUbSrGx
         tfLA==
X-Forwarded-Encrypted: i=1; AKwUvByFJU3UTN/aIeNPs8cdiMkI/nBVyNUt6NQYoKvo/4kPangU2PXfK8ILzHnnxd30K+EdY/Ga6r0=@lists.linux.dev
X-Gm-Message-State: AFq9FYJFnhcb69shFSRejl4DWJ7nd9Hiou7B7YEQ+hAe/+hhg5IVT1+P
	iidk4QuHj7hoybMcIP+75WYK60MK06zLivi7d83rsz/bChCEvrsE7ksr
X-Gm-Gg: AYBFou08SwAhXS0PWnSi1vnoyvxdBwEXn9ht/8DzTO5BeYJbUioqORxNYkehLEKJUvE
	ykjgcBo65/fVKKvDy5KyzX3XtRweVHbSX2YogsKXRgLnARJrIpePvibx5QX7O5WvI0TBE0QjlQ/
	oqDjAfXnHSASpqsVBgN73fX9z57RwAIhfMuBckTCSu6lFe+LP4+WwbWsQjCKfUyaIZXIp8N2XJQ
	g0lGTZZ487lf9HFt6gQw0KWmpr0uhn4P3fCfc5frVYObKLuKgjwEQZ0CM6GND3rgxLawchxCU/5
	hROxRDMtQGnUyotPaQ3UsbiOIKTi6awn+rKvtrxsUbQsE23BMAl0IGYjsyOV0SgG7kjiSSVeZq5
	34qdmvMcVtes2gfO9iHeLXoXxAm8LYd+VYkh5uCI0fi/zPirmP9bwi+Jodpa2oPNe4ZZPhTvg+S
	Jmo/mNfVLbZTRTceTlazw/3lwEa+REu1Z4pT9GAzAV7nvzGzI5YsaPEwj/qdE71agx0MQE8E3C9
	hPVV5k=
X-Received: by 2002:a05:693c:41c7:20b0:351:11aa:5d5b with SMTP id 5a478bee46e88-35111aa6037mr8207069eec.19.1791175117045;
        Sun, 04 Oct 2026 21:38:37 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127136b8esm9518581eec.6.2026.10.04.21.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 21:38:36 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net: bridge: cfm: send an empty CFM nest when a bridge has no MEPs
Date: Mon,  5 Oct 2026 04:38:21 +0000
Message-ID: <20261005043822.3106580-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005043822.3106580-1-w453y.me@gmail.com>
References: <20261005043822.3106580-1-w453y.me@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_fill_ifinfo() leaves IFLA_BRIDGE_CFM out when the bridge has no
MEPs. For a dump that is fine, but a notification sent after the last
MEP is deleted then looks like any other RTM_NEWLINK for the bridge,
and a listener can't tell that the CFM config is now empty.

Put an empty IFLA_BRIDGE_CFM nest in the message instead when CFM is
asked for and the bridge has no MEPs. Ports still get none, as before.

Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/bridge/br_netlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 5160e801d..68ec4529f 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -603,7 +603,10 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		struct nlattr *cfm_nest = NULL;
 		int err;
 
-		if (!br_cfm_created(br) || port)
+		/* A bridge with no MEPs gets an empty IFLA_BRIDGE_CFM, so a
+		 * listener can tell that the last MEP is gone.
+		 */
+		if (!IS_ENABLED(CONFIG_BRIDGE_CFM) || port)
 			goto done;
 
 		cfm_nest = nla_nest_start(skb, IFLA_BRIDGE_CFM);
-- 
2.53.0

