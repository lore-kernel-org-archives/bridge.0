Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01152BE655
	for <bridge@lists.linux.dev>; Wed, 25 Feb 2026 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990741; cv=none; b=Ng81JGOXeU8cnzLVV8YVta9deTL8omgXDxBcieJSAv65IVeLKiuMPmv0enCFQ8gakdazoB3pIvGxUqbB+CHL86PYylGLgPkYRr/VR0YheVo3+WMIQCzwKu9ddN69XNz4f4SF2Evp7tg8Gb48bRI7CQWW64UotlfDfi/YGwykDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990741; c=relaxed/simple;
	bh=Xmf0Usl2CbiEJ++dZC/dkjhOytdRgouJKZh4aFkNkks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poL6m96aoD2PhdkXl3MLpaJAxDCPDkFwdkfG/XOnCoDQiCIaKg5D+9nNEww1Kp6pRQ33R1khYMbMoFCYi7s+yHG4dbxbbAN+9Uk3mxxGjGtMy79wKz3Fgf2BtkwdYZfrZJI3tFHDc26p7cDJONYBtiHt7+H7Nb5VhHY6jSokB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6SvuGht; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6SvuGht"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso463438a91.1
        for <bridge@lists.linux.dev>; Tue, 24 Feb 2026 19:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771990739; x=1772595539; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x6mfY87rLHQQy6u5hEHImplDq7CY6og6rQC/w4gcIk=;
        b=M6SvuGhtumWQFEmHaQTba9GU4hyfffuwaPO7Pt0U0hFZ6qJpnciLnZSBTkPilcnZDe
         6i6TfH79hHuPmR7dJz2CbZwl+iwytQrYxn9cbM1SJvEwyYhlBsxVrDXEkawSYx+5MRMh
         eBcK444skAHHlfDWRaYp9Dcpx93UwB5tM7QNuBxxL+SS64kHKxLopm67GeP7QTx5kQai
         mhT8qNNlX7hC7m5JU+wQUdv5eGvW3G3Irq4N87hfkIHWIcZBQExo2jqTgt/h5WECk6eq
         ea+gc7f/9RGWaDQVkAdXlL572KrbCCWmAqvNgPMv+E3cOML9tw62ohZr/nZ7UW/nP92r
         z/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990739; x=1772595539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1x6mfY87rLHQQy6u5hEHImplDq7CY6og6rQC/w4gcIk=;
        b=fw5PMpUybU0jzOunXenh21NF0t6EwFPo4ObHRsAh9UzbrrbPCEc2fZK9gZIJMX89Nu
         /1271dRHUEMwEsNECzEIN1X65tTRRN4m4ERw3XYPKcy1m/GwWkdhvX3vNG1K/c0s/tD9
         Ssl0e1m1oLsgcKVHXXNwUd2e7iITbhZOqHe6s82KBLFMNQOe2mwLM3CNdUOELiqBRHDl
         EHAjIqCHunE+6Mio21gB3pJ1c4m4dk2FWrwExoDD7RIEKfPUf+qFQK+UEypeTsU1sqr8
         8nggs6RK9/RHiL75Rn+RFSpEEioyxkH4rbYU+8M5UoV+pvwkzBBhkYajtUBVpQTzjTv+
         cz9g==
X-Forwarded-Encrypted: i=1; AJvYcCUEm+BCMPoz8xU/ald4DJeLInJHN3PPHvDnCVBqeryyXAwiYTnFzNzLqh39hdKaVQXGYaP315M=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyy2a4LTbGz2pASNFnMvG3kC1OJUbkRDo5A5YFPCeum/jIDx2vk
	mLTdzFsppZIx7lkDFIREmtDIuRNrpbgc5zIVUzyqU18rE+ZdOpViyasX
X-Gm-Gg: ATEYQzzUKcZV+RQqOFxxSIw+sX8cx7S2ady9Zs4t4A6QSsWVWRQDPk6xnivjbwXIp5e
	25WQoXG0SLuzKllzZiKlHNZMksJQvt9HYFURfR/7p+auBYafQUGFvSQj05pU90cQMMaDvbIJ4mx
	HFvPlWMZRm0a3ZB4U4vfxPZR69FWdrRZjB/wxfl4zrb/daQFivlf/Bn9A19uA3TCcokqwhyuwWT
	cXYb237OBu2Dcyg7zhnNtv2XNcAkBGdBAGDnqd3DacFVbxAN3RDyULlPtOO1Ldjbyk834dl8cJv
	BdxViV6N5E6R8PHk34lEiqrdu8fCWW4Wn9NFsNXKGVyE1A7FBWUbNBGKsyiYWyqjz61l1WX3Pj/
	WiBVGv9+fwhK/Gjr+ENUJ9wQ1PkJH9RVJ/zPpBIVfmdzkPX8o5XrUh4xfaQdl2VpQsnHyDhpo63
	VBM5sdhbGyyzHJI4KweLm83rnKN5GGUPZzviyv0eY9m+pA8oKf95EkrB+YMeWliGw+XaZmNQ==
X-Received: by 2002:a17:90b:56cb:b0:353:4f7:cc3a with SMTP id 98e67ed59e1d1-358ae6a20c3mr10834421a91.0.1771990739052;
        Tue, 24 Feb 2026 19:38:59 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359018838b2sm1161746a91.5.2026.02.24.19.38.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 19:38:58 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v2 3/4] net: bridge: replace deprecated simple_strtoul with kstrtoul
Date: Wed, 25 Feb 2026 11:38:39 +0800
Message-ID: <20260225033840.33000-4-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225033840.33000-1-ericterminal@gmail.com>
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=ericterminal@gmail.com; h=from:subject; bh=c73ZZJhJVbdBF0f9KkqjyvY2nE5EvyIEm2O6pWmXnD4=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOy5PnqLqsF81puzI5ayHffb3zHYcZDL1UHARPrTOS+ L/mqIZHRykLgxgXg6yYIsvd//vm5nrdmnOd+3AuzBxWJpAhDFycAjAR55eMDHuY6jkmG7ptFBOa 4PKkJd6hVPdHv8EUc5nrVxctfxvR8I/hv1doohTPKjst3sM5214eqV8idXiXa8/OijYjjbnujbs /8wIA
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit

From: Yufan Chen <ericterminal@gmail.com>

Replace simple_strtoul() in brport_store() with kstrtoul() so
conversion failures and range errors are returned as standard errno.

This keeps parsing strict and removes deprecated helper usage.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 net/bridge/br_sysfs_if.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f57c36a7..cdecc7d12 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -318,7 +318,6 @@ static ssize_t brport_store(struct kobject *kobj,
 	struct net_bridge_port *p = kobj_to_brport(kobj);
 	ssize_t ret = -EINVAL;
 	unsigned long val;
-	char *endp;
 
 	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
@@ -339,8 +338,8 @@ static ssize_t brport_store(struct kobject *kobj,
 		spin_unlock_bh(&p->br->lock);
 		kfree(buf_copy);
 	} else if (brport_attr->store) {
-		val = simple_strtoul(buf, &endp, 0);
-		if (endp == buf)
+		ret = kstrtoul(buf, 0, &val);
+		if (ret)
 			goto out_unlock;
 		spin_lock_bh(&p->br->lock);
 		ret = brport_attr->store(p, val);
-- 
2.47.3

