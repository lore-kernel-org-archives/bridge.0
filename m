Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA513451B3;
	Tue, 27 Jan 2026 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511210; cv=none; b=L49RCEsz0mHQotAppVXGepomWsUyJxeZcPkJO+UJrxGEKf8aAAx8PWm5MTcxweg13dXmbhWV558m+iRIVLaMirF7lMvy3uUQhdVzXLuZGblptiAkVUIT/8gGYvRe1u8NU/Yf/mM96/PnEekxg/sQOLP7/2DiJYFi5mGhVvA6w88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511210; c=relaxed/simple;
	bh=KzdD4lB2rTs/kDah2WP4pRnN0PY9DY8epR8Z88hqQsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fftxHCFgvIQlNWQOGloN4212TXgG9QXkV/jJ7Bhg3reSdIas2/q5VLknFV3TZyXMA0MikIUU2HKNPVi3kdiVUAVgk8EWj53F42ugoxOGA1KqIjP9Z+YbB0aY+sjxS5YeB2y0yn7DPNf2PEk4/5Pqm+YnQ/p0E77bSYsMRSNq5cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1vkgAY-00000001Flk-3EGS;
	Tue, 27 Jan 2026 11:19:34 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] net: bridge: fix static key check
Date: Tue, 27 Jan 2026 11:19:23 +0100
Message-ID: <20260127101925.1754425-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the check if netfilter's static keys are available. netfilter defines
and exports static keys if CONFIG_JUMP_LABEL is enabled. (HAVE_JUMP_LABEL
is never defined.)

Fixes: 971502d77faa ("bridge: netfilter: unroll NF_HOOK helper in bridge input path")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 net/bridge/br_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index e355a15bf5ab..1405f1061a54 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -274,7 +274,7 @@ static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
 	int ret;
 
 	net = dev_net(skb->dev);
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 	if (!static_key_false(&nf_hooks_needed[NFPROTO_BRIDGE][NF_BR_PRE_ROUTING]))
 		goto frame_finish;
 #endif
-- 
2.43.7

