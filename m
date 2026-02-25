Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A72BD02A
	for <bridge@lists.linux.dev>; Wed, 25 Feb 2026 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990734; cv=none; b=CzK+f1hqFFR/bpfirsK8FRQwBSApkQQFidHf0kzrv8Eq23fctgrB+64dvnmIYUH0OMN0mOBcvh+9G5ZoideqK+OPPXUGGHrhpsmcPrgmTtCG1GdHMT2Ac/pVSx4RgL0zVTh5WT8bh2Tc4U0Aji4fqticBep3YspiaGkzG/NsjN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990734; c=relaxed/simple;
	bh=UzebxA6/a7fg3sjOiWp/u7lzb1dFODtxX1sVJYsce3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJyJANEfOj3ERIX4EMHCpNt8vcifWbxp885PUoShEiZieauQHMYawIFqelgTPxirvujw1xFVuWYprJrOAjZCv+3gvF/fOjNrgG85c1RKbpqrwwm2hG6upkzxJebQIxi09oC9TJp/FcghAMdv5S04g+VqEmgnL0yR2eMMYzizLcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXM23/sH; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXM23/sH"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c6e266a3572so2150500a12.0
        for <bridge@lists.linux.dev>; Tue, 24 Feb 2026 19:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771990731; x=1772595531; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqCX+A7B/xYK3O+/EJk4ZtsIswe0wWdZp+sEMdt10Pc=;
        b=CXM23/sHi0wB90SilSWDLkZJQzviCoWMeA5Qid2k/wOVRpxYL1dzYoT5SHH1rrjnH4
         QfePXXC8Dy2q1Z+rAa9vdYD585swGCXy+1kBHU/z+EmI2SYk9EZWiwDASfoSU26Ymqv7
         qQxpDa9i5hnUkWIm5UJqJSM7NT6/f62Q9uUlbZ3vhVpDexXsFqD4qJnhx5wmxU09sL8M
         mmRUpdLzpMqcCT2yVL87g7x3tu8u6qmdQi1K0K1m88W9LEapRZOw+KgClnPiqnXDGRE0
         4pRmA6GsOmKplRiAx6P/E3nF2VokyfcU9q97s+wUzPEYxDIjqBg2Ks8lklzuk0IT6uvW
         d8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990731; x=1772595531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqCX+A7B/xYK3O+/EJk4ZtsIswe0wWdZp+sEMdt10Pc=;
        b=bwcuLg3JXB+xKUFKwhLX0NCtDpKSUNkwB10I2zJuWQbNa9aJEHsdnBEDuffMhqmpk3
         1j19Fm2IIt2GljZRQ+UPPb7S2OnnRrUAfmkGAG2aVHe1TXzPcre5w9fXNN+qNW3XNaV3
         7CdZN8GAb+s/3dsk4Iwj2tHvX0xWetE/hvulemYrSQXpdsZMabW8uY98pW5VH6fqwKF0
         af/CURt5ON8okWj9hGvr6l5sUijfQUB22+ZmW1epmpc0bqBU/LOLnhvcnXc/KKaOF3KT
         EcEVmvyZSmvdcjlA3OL4WllOk3ojCGa4WpCajjhz0aan5pjXKrqsL3w+1L4SzBK1IQTs
         Pe3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwb6OK6p6/reu9x52PLixw3FKEhW1cE1T+f4Qqmki6bOwbzaj5Qe5m3lO/AUFnN2475VkVSns=@lists.linux.dev
X-Gm-Message-State: AOJu0YzcRvYXG6xBy9YTVS0Qkh3bzy2ySBEn/CX5ocUnpYQdaaur3RRP
	vreNnDac+Ta0SvV2SFoce8k70oMXnvaIsbnUSFvONPVlLaOJKkQ+R9xn
X-Gm-Gg: ATEYQzxk3BQwglveFy/+L+CJ3AL9UBy9/c3Vjs6HPLxcmL071a25BskzAea/XpNngo1
	gkBvK2r0yYf846jc1L6kwTHARbdv2ChEgFP3mdIQQ/DET989p1FHqoScXtJEnDJtrXxEkOSyQpz
	zomg0p2q1dChitArSORw8Y1okr/jEUaOn0x11LPdrsKU4pc4XcJEw+c8/jzUDEvsOrYlphdVbf4
	zcgnxN0n0jH3J48ZtzlpikuUoQkXTj61RWlsKLIe/LXtTNk+nmj2bo64BiG7VDKr6bwJXN1ggXu
	RxKdsunQucURH7UVbmZkdrGWXnMTgwcH0bxvsF+D6G49guvL1uyaXezLQC3shYaa1cZ+pCATI4f
	nLeKYwEmfvgkNpmSlrDUAnPBNQU1vVtl4/QAm+UnL0aNWjRZfnVQb1lLoIN7ii8pCcBoLZbjwVg
	m4rZpX/+aTSgb4Iectq3Nn6qRzDO/WmeJ++v/tTPVI/EX6t9zcyB9z1Jsts/MZPZgu1yeHNh/7y
	u2vhjQv
X-Received: by 2002:a17:90a:c887:b0:356:23be:7ecb with SMTP id 98e67ed59e1d1-358ae808fb4mr11595307a91.12.1771990731279;
        Tue, 24 Feb 2026 19:38:51 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359018838b2sm1161746a91.5.2026.02.24.19.38.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 19:38:50 -0800 (PST)
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
Subject: [PATCH v2 1/4] 9p/trans_xen: make cleanup idempotent after dataring alloc errors
Date: Wed, 25 Feb 2026 11:38:37 +0800
Message-ID: <20260225033840.33000-2-ericterminal@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3411; i=ericterminal@gmail.com; h=from:subject; bh=Gu0MyqKlwATaZLTHkAVxYELyEu7nRq9nuCfzTHc2Ad8=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOy5NTm/gzgiOsN2hHx4cJz7fzhr19LZHb++7ufoVZo snTztnZdZSyMIhxMciKKbLc/b9vbq7XrTnXuQ/nwsxhZQIZwsDFKQATuWbAyHDC3ICJlbVC0rBZ fRMn18uDx4MObX75UfXy+stNxZIpL/4y/BXwOLHVb3ZcItMd+/SAj2IK0WHehYmHLjAYvrrHufu tEDsA
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit

From: Yufan Chen <ericterminal@gmail.com>

xen_9pfs_front_alloc_dataring() tears down resources on failure but
leaves ring fields stale. If xen_9pfs_front_init() later jumps to the
common error path, xen_9pfs_front_free() may touch the same resources
again, causing duplicate/invalid gnttab_end_foreign_access() calls and
potentially dereferencing a freed intf pointer.

Initialize dataring sentinels before allocation, gate teardown on those
sentinels, and clear ref/intf/data/irq immediately after each release.

This keeps cleanup idempotent for partially initialized rings and
prevents repeated teardown during init failure handling.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 net/9p/trans_xen.c | 51 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 47af5a10e..85b9ebfaa 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -283,25 +283,33 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 
 			cancel_work_sync(&ring->work);
 
-			if (!priv->rings[i].intf)
+			if (!ring->intf)
 				break;
-			if (priv->rings[i].irq > 0)
-				unbind_from_irqhandler(priv->rings[i].irq, ring);
-			if (priv->rings[i].data.in) {
-				for (j = 0;
-				     j < (1 << priv->rings[i].intf->ring_order);
+			if (ring->irq >= 0) {
+				unbind_from_irqhandler(ring->irq, ring);
+				ring->irq = -1;
+			}
+			if (ring->data.in) {
+				for (j = 0; j < (1 << ring->intf->ring_order);
 				     j++) {
 					grant_ref_t ref;
 
-					ref = priv->rings[i].intf->ref[j];
+					ref = ring->intf->ref[j];
 					gnttab_end_foreign_access(ref, NULL);
+					ring->intf->ref[j] = INVALID_GRANT_REF;
 				}
-				free_pages_exact(priv->rings[i].data.in,
-				   1UL << (priv->rings[i].intf->ring_order +
-					   XEN_PAGE_SHIFT));
+				free_pages_exact(ring->data.in,
+						 1UL << (ring->intf->ring_order +
+							 XEN_PAGE_SHIFT));
+				ring->data.in = NULL;
+				ring->data.out = NULL;
+			}
+			if (ring->ref != INVALID_GRANT_REF) {
+				gnttab_end_foreign_access(ring->ref, NULL);
+				ring->ref = INVALID_GRANT_REF;
 			}
-			gnttab_end_foreign_access(priv->rings[i].ref, NULL);
-			free_page((unsigned long)priv->rings[i].intf);
+			free_page((unsigned long)ring->intf);
+			ring->intf = NULL;
 		}
 		kfree(priv->rings);
 	}
@@ -334,6 +342,12 @@ static int xen_9pfs_front_alloc_dataring(struct xenbus_device *dev,
 	int ret = -ENOMEM;
 	void *bytes = NULL;
 
+	ring->intf = NULL;
+	ring->data.in = NULL;
+	ring->data.out = NULL;
+	ring->ref = INVALID_GRANT_REF;
+	ring->irq = -1;
+
 	init_waitqueue_head(&ring->wq);
 	spin_lock_init(&ring->lock);
 	INIT_WORK(&ring->work, p9_xen_response);
@@ -379,9 +393,18 @@ static int xen_9pfs_front_alloc_dataring(struct xenbus_device *dev,
 		for (i--; i >= 0; i--)
 			gnttab_end_foreign_access(ring->intf->ref[i], NULL);
 		free_pages_exact(bytes, 1UL << (order + XEN_PAGE_SHIFT));
+		ring->data.in = NULL;
+		ring->data.out = NULL;
+	}
+	if (ring->ref != INVALID_GRANT_REF) {
+		gnttab_end_foreign_access(ring->ref, NULL);
+		ring->ref = INVALID_GRANT_REF;
+	}
+	if (ring->intf) {
+		free_page((unsigned long)ring->intf);
+		ring->intf = NULL;
 	}
-	gnttab_end_foreign_access(ring->ref, NULL);
-	free_page((unsigned long)ring->intf);
+	ring->irq = -1;
 	return ret;
 }
 
-- 
2.47.3

