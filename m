Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC510322C67
	for <bridge@lists.linux.dev>; Sun, 26 Jul 2026 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047127; cv=none; b=F+jmVSUdZkmNAWkDzVKFBRK4K9kFRnQLQ2X2NmrUI55LLTW49N0eRJxUtvS2EJ+IZk+9M3Brl7a28/oa2azPyLOb5YaLVTuGXwjX0c+vcIg3UDRP5cdZqxPBJCDUAr9hvBEyOV6eIKOMd6MZBH8iHgsFS4b7RAGlaV4AUAek7WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047127; c=relaxed/simple;
	bh=dP3h+hLKsGm5KC/K2M0ypRB2Gy3z0jV1Y4qouUEoGl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRBCIZlXv7QuUrDEoJB8NDK3lI3845pAD9DZ3nvpQadYf2p0kyYFd0g6Y6Ngi+EnvguHKTC1feB9PkzUDAdYe/1sQ0df2P1WgTWZaXRlCqP1OozJbjBW2JFBuHLHcrfOlELI8wMbb4QSnaRCL0yJ9wFX4wSFX//75l9kAXj8QOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=AFWMwbUw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="AFWMwbUw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cace91f112so18405375ad.0
        for <bridge@lists.linux.dev>; Sat, 25 Jul 2026 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785047125; x=1785651925; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8zGbl4R2Ffos3phLd71l7Q80RIBm+fS5r/cqYD6HXU=;
        b=AFWMwbUw1vnFqv1eZOZpkZYNcgxKECIuy/WLQQppT+j1QvrFAdBUqMWSH7tsJ+O2We
         bxnReOvuoU5R1+q4iy1/ZRCQLuTscxZ4OKgP6GFEyXD83ks1FdB1Y6mCRo+FnQ8KvKfE
         bmfS9atB4EnISHHaN8uzo+BGruzoKSteRlMHN6ESeXKQkmsE1q93dwTyYa4z3Ypgva3A
         oBjI8f/fdqO7Ac9C7aL8DJIewsTnktrfLJjrLF6P/VGRBbU8bCOFmC8DNp1bzSxU1NUm
         uQ3ovHO5Mf5p5WyNY77tGjN/1vlSMjJ3gmhNZUwFsE4xDjYb4vtVUaGDLu++O7O7/Fzh
         4sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785047125; x=1785651925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P8zGbl4R2Ffos3phLd71l7Q80RIBm+fS5r/cqYD6HXU=;
        b=PRfyvjX0b6iy0DnX8YN2rN+y/nJEqMq57NwpP2ruyAQuPT9uRVNHYD1vj2XC2mIUbI
         oOnE+8IXdhAqpmXgAmeau12/XVF+UsBBkWzlHq/wcVQPuXwGwB+842+oa2Dy7dG1zqF6
         sX3/JZsR31xXoax6P3DQi0Va5JpkRGbeTRUEKtRtqgaEi2iM2i/l0cdfDDbBrSY4n/0B
         6nApZgZpnmJ9H42kyhdT7i1eICdGmzTOcs9pvcPgicM+wj+mabfYLlH2kHkFmFVCllCJ
         omyCukIhfMgazgsQ19gYWaenozL2Cq4/YFhT7DspiK1ZJo6HGHeROtRPwPbsqk7sOv5n
         8w8A==
X-Forwarded-Encrypted: i=1; AHgh+Rqik2t97p85ucmyZsUIONVepFb9ozW5SEjHhkSpQufxtOa2GeQJiPLfwVZE0mWJPh9N1ir54KA=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywm97ZIkEkIML5V/cE4prtWP3He77g4m12BMZcyxZ7wSJrV7kc1
	gmvbok/0VNXEsgYXB6eUFi8IAuBFQC6qU2rAdYZkZhSo6IkSdttW1RRmw9dY8/VjkbY=
X-Gm-Gg: AR+sD12BdYAtsnl3mwurb0kXPtzBEWTWO1m4759oUhON+JTDFipWRX/aXrVkQVpSbO8
	QCAo3Zarev5DgwN0Ykp39jOGYHPOQGsV5lS27pTUXYSTPxBysU98UArw4tkFOlWSjQWv4nfHuC7
	q4rNFH3NasU0rtMBnygvx6ZA6kwEOIIDicGEAXm1f0t7MBCI9Q49PFJ0QVX0Kv2qL0RKrelLaHK
	skUnl+/w+NoCknRwc+QFg0tZyrKcstrHEE8ly8mW0KWW7HA/uR3v6IQfDPGGbv1JVwTMGImP1Im
	9uzvpLxNy5kKFtMOyXLeF/T/pbfwU4XTS0pnMM+AYfgUxjsPthx9JUjFYWOd8DEaRN+yGPBNJ6T
	1udxVUx/ydH/n4BsEXJkZnBpgh+rcvJG5f/3SGL/V4oEdlfT33bmnyqovMMITziNOyhxPTU2xJM
	MNHIj336a8IcvtHxJt/P80L7XsEB0ItknRcIa+YRzkViD7hyrV7NmhMJ6soRQx
X-Received: by 2002:a17:903:2310:b0:2c8:1f56:9fc5 with SMTP id d9443c01a7336-2cfde868609mr35863255ad.35.1785047124945;
        Sat, 25 Jul 2026 23:25:24 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bc413sm16689195ad.44.2026.07.25.23.25.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 23:25:24 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: bridge: mrp: fix uninitialised bytes on the wire
Date: Sun, 26 Jul 2026 15:25:18 +0900
Message-ID: <20260726062518.43774-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_mrp_alloc_test_skb() builds MRP test frames on an skb from
dev_alloc_skb(), which does not zero the linear data area.  On the MRA
ring-role branch the sub-option TLV header is appended with

	sub_tlv = skb_put(skb, sizeof(*sub_tlv));
	sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;

leaving sub_tlv->length unwritten, and the two trailing alignment bytes
are appended with a bare skb_put() that neither writes nor clears them.
The surrounding oui and sub_opt regions are explicitly memset(0), which
bounds the exposure to exactly these three bytes.

Every MRA MRP_Test frame therefore carries three bytes of stale
page-allocator memory, at frame offsets 65 to 67, to any observer of the
MRP control traffic.  A capture on a kernel without
CONFIG_INIT_ON_ALLOC_DEFAULT_ON shows those bytes varying frame to frame
and, after a page-allocator spray, carrying the sprayed pattern; the
same reproducer on an otherwise identical CONFIG_INIT_ON_ALLOC_DEFAULT_ON
kernel leaks nothing, confirming the source is uninitialised allocation
memory.  Reaching it needs CAP_NET_ADMIN, which is self-satisfiable on a
stock kernel through unprivileged user and network namespaces.

Assign the sub-option TLV length explicitly, which is 0 as the AUTO_MGR
sub-TLV carries no payload, and append the alignment padding with
skb_put_zero().

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 net/bridge/br_mrp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index 3f7126a7d720..a5548f475604 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -226,9 +226,10 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
 
 		sub_tlv = skb_put(skb, sizeof(*sub_tlv));
 		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
+		sub_tlv->length = 0x0;
 
 		/* 32 bit alligment shall be ensured therefore add 2 bytes */
-		skb_put(skb, MRP_OPT_PADDING);
+		skb_put_zero(skb, MRP_OPT_PADDING);
 	}
 
 	br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_END, 0x0);
-- 
2.50.1 (Apple Git-155)

