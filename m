Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256320B20A
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170617; cv=none; b=P/qoPkA3h2cLOQw47uO5vOc2fZapuKzDySZt8VEeqv5Y3lLrpaBGKqSSI2+tuzYR/UfMzDf1+y7JoQ2F5A5dXJRaRhraDv/jzVuSkSwv4+PNvE2kgiNMZUP1ff2fG2Tar5wlcIN1u8KgdLOpQBZvlibuPUVDeA/fYcDTB6uyWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170617; c=relaxed/simple;
	bh=p1IsKiAxwq12F2MM7ABxyO6mLj6RlYFe8Yg33MCLfXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jI+a1anpKrgqSeIg/9hf0NStB3m7Jdib767gPbwJptM1ADPnnnmFfFL1JBaygPBcXVDEHryknHr/nqhE7QuIzw2Mzskc4xX+Z3lng/86XAsfhdxeb3Vm5GwGzuUO5B3HTqisQ4FTGekqZ1FwHF2lj9xM/10sclqeSPTcRVBww6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5SNaUxP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5SNaUxP"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so10953165a12.3
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 02:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170613; x=1741775413; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAJ1+kbz8lZ4YwPg+OV3VOfAm0Jd01XhEIX1QeYwh3U=;
        b=e5SNaUxPatafDQfy2xpHW9FDwpBH/tAL186TYB6TaSTwtwZrblmU+4u43DeKfzEvHV
         70xpP+vUxKnDDkSvejgHt17ga9L5Mot9WHRewjAtaBdx63xRiMVWRMzw1l7wKD8zuWei
         owKeboi06ODjPCQO7XMR9EXmYJEfDcs+jYJjdHxFMcFR8uSEOIOCbZEfIinhc0mSddHT
         N4WQ9lyiy507HM8yEUGCImQWyvlRwhV/u/IEgv7sTZ+/6WTGSgG8pBBZQfEjfCxeTEa8
         H8v4XRyqsnO9qxp75TnMFrNoeF0WdUInPTQN/fOk6jczgsy/myvP0pmspcs15AboormE
         BOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170613; x=1741775413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAJ1+kbz8lZ4YwPg+OV3VOfAm0Jd01XhEIX1QeYwh3U=;
        b=KMVOdyTigGcquhdLye37th9ISNBOS7yB7FqJXw99e5XXZObUxb88uX39ZEuU2TCnu6
         eLVPy4AFpgwyhVFbOwHqc5/o4UxgMWR1hCKV2ra/TzCBEJ84jRs3aIqUFexi2jAyQUWE
         O8asaWUc8pBPoiEmqYC5mEwmqwnGAe1lxaEJGRJdyBKnnHetgG0nag9dQkKXVlXc5aob
         3lz8nNX0bqBdjO5dAEeR4zyAeLRNqfiYgIB8sSA0BVo8KhwgWeW89msSGGYQ1r5XLSbm
         JaY2Sk0yR/AfJjqgocKo/e/CsObXprepvdC8cajI+fbCgZ1YPx7QWOfwvR0CFUNeB/5/
         mkfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPwn8Y9NRJw9rffMEGR4PbDBTdhVaDmINzS7DZXu/4T+rAmbiEDAPapjW8qEmdwfN6byypG/c=@lists.linux.dev
X-Gm-Message-State: AOJu0YzAQiR2Hy63SMz2jk89wpklice5huu/7bcs5IHSHHi/uj5fFQuv
	7K1i9ZgwGusV8YddVcz7Wry5NccCbvkIuQ+wwIYPyq8PVmSf362mLagwWkyp
X-Gm-Gg: ASbGnctvUEtb+OF79GwCD9Wa+BGjkftDXIk7G3OfULETp2uiESnWw36CwDljRnI1hcz
	Cyl9M1CeUikbyQtwJEmVeaxpZSyTe9ozFziR3tXmGpQnEbAyVd5juyCudHWewGo651KWxEjtQQw
	jcOkzBbE7cuGBSfHlmNU6JB9oXHktdb+hlTXRxt9jSQ1hfZZzc2pOunQBPifSKrx/Z+55zghLoy
	ZFeqVUsdIzHHwnkb2ZRPVepAE7VNC3Gk+64dVa0Dtp/H7cFe6ICdvaF/CEPIeEqTR1Ma5yL8eJs
	xAuGciAIdtKj+Gu4ArSDRdsc+5l5G0DB4izehmq0CVH8pQVHbkgcACGAM8NLBUBCS81euPCTHg6
	O9e05rTreK1C4feY8WSN/bjeSDy+s/0FSR8gqQIC+VOkRmqjvc0zUCxRkO6RhOA==
X-Google-Smtp-Source: AGHT+IHkGwcjTfVbXx6eVRlSW1bPJWg7ABfB6LE3pcI1ePV03v0+a0Kiykk4HhykJH2czK6vrMyHQg==
X-Received: by 2002:a17:907:8b9a:b0:ac2:c1e:dff0 with SMTP id a640c23a62f3a-ac20dac2643mr219805866b.19.1741170613297;
        Wed, 05 Mar 2025 02:30:13 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f7161a4esm247154266b.161.2025.03.05.02.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:30:12 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v9 nf 08/15] netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
Date: Wed,  5 Mar 2025 11:29:42 +0100
Message-ID: <20250305102949.16370-9-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305102949.16370-1-ericwouds@gmail.com>
References: <20250305102949.16370-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nf_flow_rule_bridge().

It only calls the common rule and adds the redirect.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/net/netfilter/nf_flow_table.h |  3 +++
 net/netfilter/nf_flow_table_offload.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 4ab32fb61865..a7f5d6166088 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -340,6 +340,9 @@ void nf_flow_table_offload_flush_cleanup(struct nf_flowtable *flowtable);
 int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 				struct net_device *dev,
 				enum flow_block_command cmd);
+int nf_flow_rule_bridge(struct net *net, struct flow_offload *flow,
+			enum flow_offload_tuple_dir dir,
+			struct nf_flow_rule *flow_rule);
 int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
 			    enum flow_offload_tuple_dir dir,
 			    struct nf_flow_rule *flow_rule);
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index d8f7bfd60ac6..3cc30ebfa6ff 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -679,6 +679,19 @@ nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
 	return 0;
 }
 
+int nf_flow_rule_bridge(struct net *net, struct flow_offload *flow,
+			enum flow_offload_tuple_dir dir,
+			struct nf_flow_rule *flow_rule)
+{
+	if (nf_flow_rule_route_common(net, flow, dir, flow_rule) < 0)
+		return -1;
+
+	flow_offload_redirect(net, flow, dir, flow_rule);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nf_flow_rule_bridge);
+
 int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
 			    enum flow_offload_tuple_dir dir,
 			    struct nf_flow_rule *flow_rule)
-- 
2.47.1

