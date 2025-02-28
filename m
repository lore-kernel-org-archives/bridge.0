Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B794C1C6FF4
	for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773781; cv=none; b=AlcfMY4GT2EPbH7WUugum6njGidV4V3yCmhlqJ+K2E8dX4MqjnRc+vN6id1/uNU2Q4i9n8ng1somNTi0obI86k2z1MTlXgOJSMByFpweG9k6yeJyAHmWOQz08niuR3BV8BWQzneLv0gtjQc5sv18rqN7GImOP2vs/xDDikVi9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773781; c=relaxed/simple;
	bh=Fbp3oCenr8igYjoHqNHoL3I5wq9RcaWF0Ekl0eI6nvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ueeuym4QSjv92BDgcm6rWW8qrWq9knuWnwAgH0QLFSdGxireqc/4v+vh429fEdOd9btSEesv4bK/KGV3q4lcXiLVg5OONC7PzSB+HP/Z/aTO4HCrnf4eMdXV04Mhzk+BsXFhj3trxMMb+bCCXOjf7DjHQAbFVQEPaSJsKoeiBNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr4Iki4v; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr4Iki4v"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf4d756135so23811866b.1
        for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 12:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740773778; x=1741378578; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fA9Vmw88RokN6ZVcNFAMZ81OI6e/RLQJpo3MGu4wt9I=;
        b=Wr4Iki4vvDH78t0ZxijAqiz5sNlGd6iKA2GQRwzBGrT745ubmCJY7xQ8sAfWil+irj
         iqyzX7Z2tqKh3uw64iWbseUA8977IHHSzab3AUTk1yJ4iEoRQmi9Y5jVixynvY2I9XUj
         6jxFJySCw3XUtOUEb0VePR2NZqeAPpIbW1DDVK+i+eO3aGp72BHjZgr3l4gR5rzC631V
         7pLXYQ9fTOJrDZLTPomdZhqV/1XZ2NQVXS3Wp/92cajl68Bd0bWLSQPU1eH23ZDq5th6
         vQNAxXVq8ajEjuCyY+Uc0elVgjEwSnH2O2b15UovkMtQRf564QZs4NpmxdbXBG1Zjn1B
         YufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773778; x=1741378578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fA9Vmw88RokN6ZVcNFAMZ81OI6e/RLQJpo3MGu4wt9I=;
        b=qr+OxqucqwO+NsKh2LU1WeH7c9H+nEAjqgMqF4hELteKOzZ/0IlZMSb34/s+li+lXw
         6O3KCJCZ3WDczcXt1Fdng+VD77TjqQMSlPWWndT6PGJQlBgMU9KrLKiLos4I5R0ZQLE9
         uedEzsD+JIJdTdZ8si0Q9NwBHFI8uSTYQurEBwBZb4ZgsY7wq0LP6+rQiRStAuAMEhhB
         +NFXE6PYm3vjCLm3SGNQH5FANtVJJyb2mqh8ydH5eVso42CATXJMdfmWPVp/nApfevtJ
         KeMP5EVOHn/WNvO9DTuckaRun97NrfzGlYXxgJBGbQzIXoUTpGT8JgnAY3BZ5Vy85w3Q
         hlKg==
X-Forwarded-Encrypted: i=1; AJvYcCVE4a/nexrvNQHVCKn46W6fgLHeySKE83sYHFOjoBBgRJ071JJaSEibfHjnKEa5M1vEMgAG3YM=@lists.linux.dev
X-Gm-Message-State: AOJu0YwPMoYN+FSkN2Ga8FmAqbQ9LPp30TDe2ZgBu7ff754rv6GvFVMF
	ppFF8s3We9AZNj2Y8lhWDP8S0+DH0edc/HRbMfBKbCU+kBXKhoTb
X-Gm-Gg: ASbGnct+8FbGoN2P8z0DdfZDA1LQCYApcTJJ3TXMpVDajWnlGDsQWqB6+2DAR1hHGmH
	X5FzuPPWxgqzCR77YBa2U8v9qLHI5KiAROJgumkVViXkI9xL15xvS1Sx6VXajPbQdx60MuoHWIm
	rnOkwTEZXEW2YqDMzny12aEXJuk1bIL6uGyCAHDAFLp5zjr893fKYDcGPiZLLP7KtL00QunCrph
	8xAlvWfOvo99fDiNK/R30RA1FdECVQsmO3YJMiGD1TgzyI/wP5+DMXxvDcXFZT6SMW93PgHNYxI
	JhKvQy2rbZPPdy0undt2VmRRJSCKftopJeqOwUN6b8b5tuvTSfhd/LMn2ln0qr62PG4x6BNpriM
	vGMZVJQxzhI5OpjbHms94HDsM1N+VKzXvlcUh7bq1DrA=
X-Google-Smtp-Source: AGHT+IG9CXfC9QShMuEkr891X2vbkzQ2uh+igw8zIKBPddpTAHKgNLtJZSPLkYYg96Gm41ClW4AX7A==
X-Received: by 2002:a17:907:3206:b0:abe:e981:f152 with SMTP id a640c23a62f3a-abf265a2a06mr522572366b.37.1740773777757;
        Fri, 28 Feb 2025 12:16:17 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm340812666b.136.2025.02.28.12.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:16:17 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH v8 net-next 01/15] net: pppoe: avoid zero-length arrays in struct pppoe_hdr
Date: Fri, 28 Feb 2025 21:15:19 +0100
Message-ID: <20250228201533.23836-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228201533.23836-1-ericwouds@gmail.com>
References: <20250228201533.23836-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub Kicinski suggested following patch:

W=1 C=1 GCC build gives us:

net/bridge/netfilter/nf_conntrack_bridge.c: note: in included file (through
../include/linux/if_pppox.h, ../include/uapi/linux/netfilter_bridge.h,
../include/linux/netfilter_bridge.h): include/uapi/linux/if_pppox.h:
153:29: warning: array of flexible structures

It doesn't like that hdr has a zero-length array which overlaps proto.
The kernel code doesn't currently need those arrays.

PPPoE connection is functional after applying this patch.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/ppp/pppoe.c       | 2 +-
 include/uapi/linux/if_pppox.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 2ea4f4890d23..cb86b78de429 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -881,7 +881,7 @@ static int pppoe_sendmsg(struct socket *sock, struct msghdr *m,
 	skb->protocol = cpu_to_be16(ETH_P_PPP_SES);
 
 	ph = skb_put(skb, total_len + sizeof(struct pppoe_hdr));
-	start = (char *)&ph->tag[0];
+	start = (char *)ph + sizeof(*ph);
 
 	error = memcpy_from_msg(start, m, total_len);
 	if (error < 0) {
diff --git a/include/uapi/linux/if_pppox.h b/include/uapi/linux/if_pppox.h
index 9abd80dcc46f..29b804aa7474 100644
--- a/include/uapi/linux/if_pppox.h
+++ b/include/uapi/linux/if_pppox.h
@@ -122,7 +122,9 @@ struct sockaddr_pppol2tpv3in6 {
 struct pppoe_tag {
 	__be16 tag_type;
 	__be16 tag_len;
+#ifndef __KERNEL__
 	char tag_data[];
+#endif
 } __attribute__ ((packed));
 
 /* Tag identifiers */
@@ -150,7 +152,9 @@ struct pppoe_hdr {
 	__u8 code;
 	__be16 sid;
 	__be16 length;
+#ifndef __KERNEL__
 	struct pppoe_tag tag[];
+#endif
 } __packed;
 
 /* Length of entire PPPoE + PPP header */
-- 
2.47.1

