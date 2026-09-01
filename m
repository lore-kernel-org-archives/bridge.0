Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112B3C0A02
	for <bridge@lists.linux.dev>; Tue,  1 Sep 2026 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264464; cv=none; b=C9vhxB9xEG+nCQAoDDMP0lp5e1MQjiN+QsCuaOuZLQKSCa6TIEDpUedrJo+D6BS72v8DfAJOitXskpdvjLWLpGt1A2FXNNqwA6wlnWjCR4usgqHLVydM2wSqkEmn84nDDBWEWpN+0xO7H4qucnKXFZgpkryeuh84yPw5tQDBzM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264464; c=relaxed/simple;
	bh=vDHm7CkTNErA2+VH4D/qGhWbmoMxmNZSOesyPx+peIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXdFZQIgIiZQFBQ0wWUXWvhfdja8A8en5pITPwAXgHsq24OJ9s9+d5tXsDRDM9Fd6uUA4aBNBS9HPmq8ie9EAvn6lJU64gTkFLMD1OQRHEjOGyUOklPhGO2vGoBGxnfZaTexepgSqdh+4QxHBxqJXPZm0Q+uG9wQaGZ84zYncM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=RnXF5oot; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="RnXF5oot"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so8931915e9.2
        for <bridge@lists.linux.dev>; Tue, 01 Sep 2026 05:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264460; x=1788869260; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R+TeBJucdheuLQOVi4XpjZrYuesJgF3ndjF41LXDZJI=;
        b=RnXF5ootMrg2YnSK95VZlkRamDu3hy+Z0ygQitDLJa44SdSu9GHntDJ48POnkNOXq9
         obO7LUXFGfR5pSSKQgLzkv/BqQgV4l36oCxVIrDTJ6LvrU/JrulnX1Wg75cuuaa0/80S
         ylRq9O4CxzmiWEzv9WX8kNJ8OZLGHhGYqTbNHzl4ACwZISoSiYTsWP0Wmp06Hh6wKMRO
         7Z3t4Sa7VoWJqKOyGivT3kHQFrJQqEXeqVVPqzyzJo5LuXzrgjyLc6imGXBozdcPSa1/
         OrNhcOTPXbb0JqrjBO8jRGglS3rOGgOaktW8Pus/xcbdnhWdJbmXfsWaqNNGXKxozM2I
         7imQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264460; x=1788869260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R+TeBJucdheuLQOVi4XpjZrYuesJgF3ndjF41LXDZJI=;
        b=on28P1D3foyl4TLzNZ13sYM9f3vIBbjrb6bvMUd609Pr4WqmW1ba3VZ1mGy2M9DDXH
         JSCIDuZhvxLI2E8fp2t9TWawHxsgnFi+oOdmcaaRvNsFmlYIcpFaJ/nBLzXbjEMhxnzm
         uRHFBS/qTroAr9dtpd4zw5FRilhTlPbUrRVGUQnb5nUdgMKSQ9dR9xEOtY5JXRiy6cPZ
         TjM/s3xwnfF+UGVDz5B5KSpg49qTzNLGqpfpP5BYHTHokQ4cy0dCNfCKOD2OmKbXebHB
         FhOnMNUzIFwF2UZFjQmb2i5QtVLJrOtNqUonIe582SO7xa+aaaCwZAgECcxRq7vx9yPt
         jiig==
X-Forwarded-Encrypted: i=1; AHgh+RputDUuPINx1HAsL2KTRPjYNKYc93E3PqGJk+gYlCIG+OiORWRN7hhGOQuQc9rgwhPsw3/0Ci8=@lists.linux.dev
X-Gm-Message-State: AFuF++l69O9BFQVjWE3xqMvywJeD+5gJOqNQxVUfUzGitGlURa8x5bdV
	GXT+0xwxJWN4+Dd9X2smZGFvUmYuMeJHBxzuRCBjPCkosArU9cZHvKeZroOtLhDoQ20=
X-Gm-Gg: AR+sD10/o3eZn8oVeBRb9u3Wi61nbwYCdPkym0J89nYaLUNnmj0jN/azMkMxVemyPH6
	CjwMopv3z6fzZwUzIO7Bgkk2LyfqxbNFxguT5QutkI9oOWKJjfgUMAVKGnmGgm44Lk297QFAKD7
	ajkq5UJ2hEGmC0qWwm51zBT05vAzruSEjl8Iys21zgJf6sHXtBOqMWk9J/QkQO/8pmQZ8UYudBJ
	00W+iYet7c5MzWr91GLGnDoNz3unP7u/ZKeVeNg5rtBzd0qKTGO4ntzcxgMpTS4JI2/G48ViUlu
	n8tWE6TyJq1cpZsx2LpYmF0ZbeuXPJvSm8jEeyDGcsz9gW50xriSZdn3eov6+XalEnw2Tynqrdg
	yxYUDgutxvX1keOAQL25ezJUmIqsiBhb635pbhx+pk7WzReL4ZkGsvwZT/ZVpCZ3aqHXZnCCyKt
	KWL42H89Ap2Pm2Alo10paw0T+crrurXXP+/Mgzmd/KVB4HncDGxYAS2rYsY288OssnD2Jgdi9Rz
	CJmlASjQKk=
X-Received: by 2002:a05:600c:4fcb:b0:499:db27:7b1 with SMTP id 5b1f17b1804b1-49b91c62d9bmr504091125e9.15.1788264459996;
        Tue, 01 Sep 2026 05:07:39 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d78444sm5107623f8f.25.2026.09.01.05.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:39 -0700 (PDT)
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
Subject: [PATCH net-next 3/9] net: bridge: mst: use br_get_pvid helper
Date: Tue,  1 Sep 2026 15:07:15 +0300
Message-ID: <20260901120721.747908-4-razor@blackwall.org>
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

