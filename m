Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54584A99C9
	for <bridge@lists.linux.dev>; Mon,  5 Oct 2026 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211218; cv=none; b=YYcDbZh5SYOGa2GVDLHfovEZPBxso8A2KKxDkz6TGLiAbXx96KeUxcTOHYzeRi9mQPkkuaptHcYw7AcYydrzz7AT61gJwFOk+QSZ7Og3W7Zs/CIv55s7NgF9sAxyEHYs90mlC7HYM4wu12itFFSfinVpQfj0pbBWfcAkw4Uhnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211218; c=relaxed/simple;
	bh=Cj6glqTNouog2ShibjfR8Itq6jaQXXZtdrXbWGVCdvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=af2C/N0vkrQcT2s4N4LRAalPNQWJ74fkRrOJRlgqbOAD/j1JeSfC+c6TMaLdpUneebD0v45Cb7ovNmiVNcycROssMtzSr68C6/R+ANl3Pj4N8o/7/DghjPDqF1SwuZZovz7Hh+cb404vGkc7Ptsug+LpJMxY8Hb4tkL6djEAzyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=N+MIRnPh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="N+MIRnPh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so19622195e9.0
        for <bridge@lists.linux.dev>; Mon, 05 Oct 2026 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211200; x=1791816000; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bSt5R41K3yP75EtFUWEkcQ6TleKOOF2+mrl49XIVdM=;
        b=N+MIRnPh6vHVCOm8MoyjrRlWC2K8dOurfjDSmDI8UtWTUmNbuLCqZl5qWVUGVpJQSn
         TBZUskyLP5KQml8S108o4t6+L6895L7UQ3S6FGY3DAgFtyyuEl5v7XkcXkcbO1c2fpJz
         6E82c7W0otKPRPgEpLCyoCwMthr3gvb9bqgXJ2FjmGYkFYPejR96dfDs3AQ9zLk420IU
         8YeaEy+zGeCZC7IF9T91QMpJebtMNWXfXHjHp4MfLD5NUQdPJUQuIN5Zt/uMAHiKl8VA
         hcHJtEyBIby/3+vQdFZUKT2znZrbZkvAfc7/av8q8g5pdvX1bQyqZblUlMmMk3z4PWVk
         Dckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211200; x=1791816000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5bSt5R41K3yP75EtFUWEkcQ6TleKOOF2+mrl49XIVdM=;
        b=B76jS9OmCuHXF1qnWHEP3GkHHQwtoy/EPeAisXHlXBOPuTt8SZqJX+TYX1U4yafeCs
         k9IAy5y2sBXVphkFLakvx/cb2kqTTD/pAij3Pf/XAjn1ttnHZbN9yUO1KRkrhuTW9Dx8
         Jv0BUCi8Mn5H444JqAg6r0CGX7335JBLVCTUCvZojXUs0KCiMIBbhSJMFbL/5xmIkJ4N
         KPMgt/i8VdX1eCH8/G5SiMmnR89QxAd9nBpjoDE+wVw2F37BjGKVs0yt1Go5Vd01bly5
         hpVfI7XS6+szHNJeZ6kfLdMjWxKDNFV+THV5SAYShDvRwE8sQKhChwULuYg5TNyndvQg
         lMWA==
X-Forwarded-Encrypted: i=1; AKwUvBzxyT8IN5vc6hefkzBpIWt122SSq9ZdBGo5QOkNPcZU6Sh3jGNj6bkucl0oTib3ZHqZGHvIkDs=@lists.linux.dev
X-Gm-Message-State: AFuF++mFYq0uJAPiJ72AeHgwi5qgNbwsyyFhFsZKCbS9nDRfr9XIAS5s
	e0SpMJRZmTfApjskpv4M2B+g798jlxBnrqOdirujzEVDhI/z+dyLK943/8dGSc51wqU=
X-Gm-Gg: AYBFou2QlR08IGH20k2DvQWhSr/5QiQs9Mp1RRg/i6BjI9iBK+OybpkNFbuS8hwHPL8
	FAidepVDKcxSVkMpI9CMcFm9SnanMkvLPWVki2WIax+fKnJ1Xc7JjOsJx0gdZ8lHgQlZqHWuItS
	jwMENFcNcD6RDbsNOVvez4DhBEzfRoE+ANZIyMZyrg7yMvSuSY2f+NSseBD+Snri2+1dZVNkISK
	yt0MXwU2WffCgxbDF/H20si64hJjoukz+RVfFLud3TRE4QkSEupWllcpSsSerjvUSclR868C8Uy
	TdQEkALzXFYhr0fwSqp4MwS9rAV4Bjw32fdrclMgPfSB5rsT+OqnM8hfCHCxBoiO1vN7mG/kHNS
	9VoGoW1j29isA3om2Hyhlo4jYALraS25pnmL4d1Rnft5wMx70OVwVqw4M1ot7E46B7tsxd/nbBu
	gQZsz9FxqmoGz3jTMXPyM3eeEJMYbTH52FFEtlCw1HzZGBv2+xux7XcV4HJTpfq64yLc5NUXUz7
	E2nus6EylA4NnknA2zm
X-Received: by 2002:a05:600c:a116:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-4a1680dd3dbmr90880685e9.6.1791211199889;
        Mon, 05 Oct 2026 07:39:59 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a166bfaf73sm174234765e9.4.2026.10.05.07.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:39:59 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 5/6] net: bridge: fdb: factor out configured entry destination updates
Date: Mon,  5 Oct 2026 17:39:36 +0300
Message-ID: <20261005143937.877466-6-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005143937.877466-1-razor@blackwall.org>
References: <20261005143937.877466-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Share the destination update logic used by user configured and ext learned
entries. Report a modification only when the port changes.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_fdb.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index ce09e3fbc58b..927e5f23df5b 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1193,6 +1193,22 @@ static bool fdb_handle_notify(struct net_bridge_fdb_entry *fdb, u8 notify)
 	return modified;
 }
 
+static bool fdb_update_dst(struct net_bridge_fdb_entry *fdb,
+			   struct net_bridge_dst old_dst,
+			   struct net_bridge_dst dst)
+{
+	if (br_dst_equal(old_dst, dst))
+		return false;
+
+	if (br_dst_port(old_dst) == br_dst_port(dst)) {
+		br_fdb_dst_replace(fdb, old_dst, dst);
+		return false;
+	}
+
+	br_fdb_dst_write(fdb, dst);
+	return true;
+}
+
 /* Update (create or replace) forwarding database entry */
 static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
 			 const u8 *addr, struct ndmsg *ndm, u16 flags, u16 vid,
@@ -1246,14 +1262,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
 			return -EEXIST;
 
 		old_dst = br_fdb_dst_read(fdb);
-		if (!br_dst_equal(old_dst, dst)) {
-			if (br_dst_port(old_dst) != source) {
-				modified = true;
-				br_fdb_dst_write(fdb, dst);
-			} else {
-				br_fdb_dst_replace(fdb, old_dst, dst);
-			}
-		}
+		modified = fdb_update_dst(fdb, old_dst, dst);
 
 		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 		if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &fdb->flags))
@@ -1634,14 +1643,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 
 		WRITE_ONCE(fdb->updated, jiffies);
 
-		if (!br_dst_equal(old_dst, dst)) {
-			if (br_dst_port(old_dst) != p) {
-				modified = true;
-				br_fdb_dst_write(fdb, dst);
-			} else {
-				br_fdb_dst_replace(fdb, old_dst, dst);
-			}
-		}
+		modified = fdb_update_dst(fdb, old_dst, dst);
 
 		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
 			/* Refresh entry */
-- 
2.47.3

