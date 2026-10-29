Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283236;
	b=iMG9Nqv3r54ZeBT2KCL3ZGVAGvfxxxXUcmqneq0xAVB+P+0znJ2JsERHtjzjnx3ecX3S
	 jM5YSwuK/MwWNrQEf1Wcqct5S4W1/L0TRp81RKUw6Gk9K+6ySk2M/OHyM5kIqXwhXDGtP
	 Nr3UlG8YPzXmUh4/UPejIa/41E5+5hmDShQGqGMp8OO4fO7WQZ2FuA+cB+LBo0SwWPAqq
	 nS/1ToWPSdp1X9yr3OGhQhePqu7t0kHMlxXEikIwCx4tsFmXx9JXV5T5NsYd+pMxrcUHi
	 mgNZ7ZgqYBQOF/+3jJK5ge4ZRk2CQYzKw9sZ2I0DbmaV31SoitH9vqygLodVY6i2SVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3r+oUtLtuj/VEdpEb4bPGrKTCpCHtCaw4EjdujKT3MA=;
	b=GXYsFN9H42qmf/xtqnF3RFYunhRXmalf7WBJ/xJPaoCgUfM2nCmi8R2c57zgy+T86zc1
	 lGu9pABMxy9rVMZ9B/7VoMJpO4Qkeyq0rcJkeLjgHngArNmxy+ZPks6udFHLGnXgTK6Gf
	 QwxF9gx/UpO+nzBN/DKZkaMzkzTxUtCq5QScLt/5CeFgp7xORF+EagHt44nlaMLskwaL7
	 SB2dqyVKcwtcl+ceTrdXll9/veS18U+azZ2tFpVhXLOwI0FcKXbeK0pj/ubkLOwBfjqK5
	 0VW/BJYIOzT5axOe9BNg1sOaFoLGonaUOVFtDxcWY+tFo7O0Qxs3poxf/TKQd79d2lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Wq9YLV3/";
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967E606A326
	for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 14:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A967E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wq9YLV3/
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-156cbe59524so2427132c88.1
        for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283235; x=1793888035; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3r+oUtLtuj/VEdpEb4bPGrKTCpCHtCaw4EjdujKT3MA=;
        b=Wq9YLV3/8u0xXluSeoL4EHCf6p8Au4eyIHZLmWT9NGckiNL5bmubg+VVlsHsIh2AZq
         UfEGXu8CYcBIpKtNz2XTJ1I4UtFLFbs9k00z5sFfM833E+vGafvtsvDErrOb6BsCDN2c
         nEzOEe4v2+xwiS3gN1v2ijRWMM5VFTYZdp6v8hmGzQkjsD234ZaF0xEWxHffmTXzs+fE
         dGRbpQrdS766TAsaMwS6HVmNV3yD+/TRNvnM5FfEtHAvxeCCNLBL1zs7noe7XshPyHnu
         joNzwKIhkTs7UOQDvQGuBRjdRjn0GrE95xxT3VMCgvveFLUjsnvjMdsPiP/+0IpMEqgZ
         +r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283235; x=1793888035;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3r+oUtLtuj/VEdpEb4bPGrKTCpCHtCaw4EjdujKT3MA=;
        b=f0GHcAeqsbgJ5rVL8HoDoYmfvTsiZSZtZDHlStTd7gbzLY8x5WgfmQuPah4SxVswvL
         yvmkb/h0mUZqrfb/2lGBjcYMfGej4ZdybvA5sj6IHZZPiBXO+MzTnDJxiM2Q7U4o7nq3
         VU2+ut61NMegDP1SH/fQzuEtsXKtPmJzrqCZWPwrgmiWuLSXLWwA8MOlDKY4udhl7aX8
         O+QWDd3q7EoAK51tFtgvYVXZNqvkqqcZdIHSL6E5RsJVKrO0hhnuZ9h19sRG9FKJjMDd
         O82fiXVOmdvgOBAPZhVN1ORWyG5/NpLkQ0SBUegtNPpRKHsfpwNizN2M4ybbT2b2DzhG
         szqQ==
X-Forwarded-Encrypted: i=1; AKwUvBza/eMuLQf+EcXrbAS5qmCRzqpyWkzyN7tSuk+K7Vfm76Eix/K3RseTggwI59ISY/9+LiS12HQ=@lists.linux.dev
X-Gm-Message-State: AFq9FYJicA5s1QZmvWHJX99QfUfn8Z/PlEQXliLN7EvNkkEsSqJKXQd2
	EpIKXmPrUay+F/va+jX4U+NIuk2ONZhwazb6OwvPXJTNQQ6SsH2HrUob
X-Gm-Gg: AYBFou3szbldekdwmj9nNi2zddewKw7qZMtB5gN5q7EV7lyBVZFpGqap9f9oCZgeF4h
	kvKu254gO4qJAIcSr3GFFhc2Zx41pa4DyVcLdkDZ5AbHhLPrq3VIbXpzGdGfkKFWWxyKKQnfMOW
	Xoz7i8mAewnUXTVe9gGB1mrY5ZVNx7jSAIhKtkY4lnjaB9DD18+yO4UJYGpkTej6JaDp7DnVixw
	kU7qAyPOMRpa4hGHgLvU/43M8MD4Ywnj9SBFPoCRk2Xv6klm0IaReE854NyPp3SazmjluPptwiz
	DgGjIAowjVJe19TnSLmPUoDLrlTRHPyWAGLFKytxlNaPT4AP+879j5+E+wdC5+pGnVQduFzGj+U
	z0NtqKV3LpvQ6sTDm9xIqGOwfjDu2XYf5+nfLFL89aebPdgx9Tq5y+ZI7tzZGCesOKEcK9F+JWe
	HWl0f/1UWPyc7p/mJRJACk/ch/X/alMmhwOc0qEBiie3+K2y4OoszSRB3RXToAKfxclFQP5srAX
	FugJ+b82BCbkrlZhAdHm5c8NsQ7jsfYGgDwyQP3qUddb0F0eWP9bveAwPPxUuGDmgWedz+KRoHw
	xDQ4r+pyYKfAgTVv04YCOeQdVN8ANrkHMZsnADDyV8XRToPQu/IyZg==
X-Received: by 2002:a05:7022:6b96:b0:19a:51da:f54f with SMTP id a92af1059eb24-1a6cd498fffmr10891624c88.14.1793283219708;
        Thu, 29 Oct 2026 07:13:39 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d76814bsm15197319c88.10.2026.10.29.07.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:13:38 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To:
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH net] net: bridge: mcast: validate the source limit before replace
Date: Thu, 29 Oct 2026 07:12:20 -0700
Message-ID: <179328314075.648427.9644307795980106759@gmail.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

br_mdb_replace_group_srcs() marks every existing source for deletion and
then re-adds the sources named by the NLM_F_REPLACE request.  The add loop
checks PG_SRC_ENT_LIMIT before allocating each new source; if the
transient source count reaches the limit, br_mdb_add_group_srcs() unwinds
by deleting every source it processed, including the pre-existing sources
it just refreshed.  The error path only clears BR_SGRP_F_DELETE and
cannot restore those sources or their (S,G) entries.

A replace with E existing sources and N distinct request sources not
already in the group fails at the limit if and only if E + N exceeds
PG_SRC_ENT_LIMIT.  The rejected request currently leaves the group with
one fewer source and removes that source's (S,G) entry:

  before: (*,G) star_srcs=31, S present, (S,G) present
  after rejected replace: star_srcs=30, S and (S,G) removed

Count those new sources and reject the request with -ENOSPC before any
source is marked deleted or added, so a rejected replace changes no
state.  Valid replaces, including ones that transiently reach the limit,
keep the same behavior.  Other add-loop failure paths are unchanged.

Fixes: 61f2183512a7 ("bridge: mcast: Support replacement of MDB port group entries")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 net/bridge/br_mdb.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 0adcd15..f5b9df4 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -925,6 +925,24 @@ err_del_group_srcs:
 	return err;
 }
 
+static bool br_mdb_src_addr_is_same(const struct br_ip *a,
+				    const struct br_ip *b)
+{
+	if (a->proto != b->proto)
+		return false;
+
+	switch (a->proto) {
+	case htons(ETH_P_IP):
+		return a->src.ip4 == b->src.ip4;
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		return ipv6_addr_equal(&a->src.ip6, &b->src.ip6);
+#endif
+	}
+
+	return false;
+}
+
 static int br_mdb_replace_group_srcs(const struct br_mdb_config *cfg,
 				     struct net_bridge_port_group *pg,
 				     struct net_bridge_mcast *brmctx,
@@ -932,7 +950,38 @@ static int br_mdb_replace_group_srcs(const struct br_mdb_config *cfg,
 {
 	struct net_bridge_group_src *ent;
 	struct hlist_node *tmp;
-	int err;
+	unsigned int num_new = 0;
+	int i, j, err;
+
+	/* Sources that already exist in the port group are refreshed, not
+	 * added, so only the request sources that are not in the group yet
+	 * consume a new entry.  All request sources are added before the
+	 * sources that are not part of the request are pruned, so the
+	 * transient source count can exceed PG_SRC_ENT_LIMIT even when the
+	 * resulting source list fits in it.  br_mdb_add_group_srcs() would
+	 * then fail with -ENOSPC and its unwind would delete every source it
+	 * processed, including the pre-existing ones it just refreshed,
+	 * which the error path below cannot restore.  Detect this case
+	 * upfront so that a rejected NLM_F_REPLACE changes no state.
+	 */
+	for (i = 0; i < cfg->num_src_entries; i++) {
+		struct br_ip *addr = &cfg->src_entries[i].addr;
+
+		if (br_multicast_find_group_src(pg, addr))
+			continue;
+
+		for (j = 0; j < i; j++)
+			if (br_mdb_src_addr_is_same(addr,
+						    &cfg->src_entries[j].addr))
+				break;
+		if (j == i)
+			num_new++;
+	}
+
+	if (pg->src_ents + num_new > PG_SRC_ENT_LIMIT) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to add new source entry");
+		return -ENOSPC;
+	}
 
 	hlist_for_each_entry(ent, &pg->src_list, node)
 		ent->flags |= BR_SGRP_F_DELETE;
-- 
2.34.1

