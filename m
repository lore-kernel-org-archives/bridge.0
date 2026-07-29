Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8048A8BD
	for <bridge@lists.linux.dev>; Wed, 29 Jul 2026 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331195; cv=none; b=ctzGJ2BU/gJ3nPsaKm9ksbRLgsrm7flt5rPfgZI91Vdeg4mB4gEAKDLhjJVmHUIf9vWtDj2JChtgzBW+Z7rtJEQK2kR+Y6h3FPgDVy2dRWScSxo4g4v559eoqxcyiGJN/veOlk6V8MH7WGKuuObRg0ROxnmPxqVqT06DUPei1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331195; c=relaxed/simple;
	bh=kdlhdT6qgk713ttnMT/RjwDbI68wlDahWZC3PMz1mLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quBmO2dxGBJQbkb3IzBxh0QW2y9aGCHfbnlqiTDPKUNp0yEwVdjiLoPZhSnpjYVaBEaRSJIbpGx81M/75zL3Ao6UsDNO6XpEmtJ2Y164TOMcTcgETSkvQuIVTWo8w8RV8DqI6tB9zOkklybszmepCcFLZaEYAI3FZiPTt1YihCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=HT1Z4mKj; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="HT1Z4mKj"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81f3b227a4aso15156537b3.1
        for <bridge@lists.linux.dev>; Wed, 29 Jul 2026 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785331191; x=1785935991; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KMXrirPZU7fXTxWoE1e8bDQ+DkmRVCXCwha59Dx6pk0=;
        b=HT1Z4mKjyYvjtVVs2S8tT7hd4+OU11R9QXBJN0ZfZnHpuBcDuOSUBOdIqucLoDUZP9
         fqadIbcQlCoONorGomYs1YFJHI5D16C2GPs12LQXOk1v2L4pmMiTwebcDxe0S+04VQ3/
         w8ul4nC5ph9X+gCi2ecEe0z8ptG1WjePLrfn4lRMJ0wjsioeWqX1LCTQB8QI/OlfAXdg
         7Hnfu09mJX9DR5xSnypyK5B3fh54b6HaiXniNao9N4nxtUlLp0DNQhQY/1rzPYKb5A1f
         vk1qGsBvO4UVsQTbRHR+lPvoSIHA0cg1RBA8Dnxzp5p0vHlICoZMID6/l3BEfeXvllXv
         QwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331191; x=1785935991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KMXrirPZU7fXTxWoE1e8bDQ+DkmRVCXCwha59Dx6pk0=;
        b=IBemoWQy44aqTnbgL7BVPlhiOTb/987zFqbQSdEe5NP2sVJAtBLQuxjRxyL7/X0DKb
         bcSF2rf7Py3p+N8HU1q1TsdtME/UEm976VweaugtTlFr553ygeQCH0skyIj4Stbt8/Qo
         6b5bWSurs9xcx/1Zv+Y03D77mtDtGj7Im34WpgnXrRGYBfHAdpVIDjzJVxv7FimWHzwF
         uctF8gu1e702+UQ+lSFVfcnkHw4qMxhEACSB1UIkKabCv1/lUzZ7FJQZz9bN/F10F6cd
         buIemwbVyXUPTx738xb6qnrhCZ1qkzluMZ/dIfL2nB09Uf2efj8RIk6Ywgmzuo/dBAwp
         LpLg==
X-Forwarded-Encrypted: i=1; AHgh+RrBikCDEA14iCQ7b5rX4unR1ZLyBWm8LPjc/pL+2n+NGjR7dRxyBRvAgeLdfkwwEPq+k9DCJ6s=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+ZXBNuforgIIV5p4/rmgh4U2UutLAd+QkTsUm4QsZYpyix+sL
	Qs90Polf7Sdp81dQ/F/+YGhBZCxr3f5nqJcTtRxqDIpasZSs1Ll5jtZkXoqo8d08GyQ=
X-Gm-Gg: AR+sD13Wak7EQ+d54OUb5p59ELTUTiaIZ62rG5UgIdBJt04nV9KbF0JQrWAn92PX0la
	T55BB8HP3iMEWa67C+F83MR+KfdHrNsqo4BAm8BI0vCUvT20iLKHo6pTM2eFUz9N7AWPdNVa6Xh
	XiRriJBFoQC3/JpDUm8k+iiPhSuV+oBfMfk3TLHCgGJsF26EKZ1twP6SQ/zzSyo8jyvanijSmUx
	NkN/uw2DwrVPPRlXk9cNa+9CjT9wb2yQCgm2glDZCFjkLymm5WFoa1QWM2pSf/r+07UBHk2A0nR
	Yt8Lt08QUMhtRzx42DTwVye2ak2j/9wDl+iaHCQtERDZWiAk7KhXB6XGI64XfiB8qgp5jXJzus+
	7mTA9AFSXV9fVWDz9eLq8rca6cY8+iTIoO1S8vT9ooXlbJC3fjs67VN1jy0kYfo9mWMlgpT+vno
	L7JQJ4zYZ9TsZc9YtuKjTzRVHf8ZZB5WFW08IE24d2RoJQVrx4EMO79OcFFvO8f7kMq4jC5+oEd
	FKg7cKYwJt2Ee6F2E5SufI7WhBMGy0xIIlB3yx/js2KlkKzaDOCrt1qLQMgp8/2FobZPlqSPUKf
	y87HG9T+BSWruUb7MpgNk4UIYQi3Qg==
X-Received: by 2002:a05:690c:62c7:b0:814:5312:47bb with SMTP id 00721157ae682-81f993f145fmr33494437b3.69.1785331190331;
        Wed, 29 Jul 2026 06:19:50 -0700 (PDT)
Received: from buildmachine.tailf331da.ts.net (ec2-3-14-143-233.us-east-2.compute.amazonaws.com. [3.14.143.233])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa275691asm17653907b3.4.2026.07.29.06.19.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 06:19:50 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH net v2] net: bridge: mrp: fix uninitialised bytes on the wire
Date: Wed, 29 Jul 2026 22:19:41 +0900
Message-ID: <20260729131941.10254-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726062518.43774-1-baul.lee@xbow.com>
References: <20260726062518.43774-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_mrp_alloc_test_skb() builds MRP test frames on an skb from
dev_alloc_skb(), which does not clear the linear data area.  On the MRA
ring-role branch the sub-option TLV header is appended with

	sub_tlv = skb_put(skb, sizeof(*sub_tlv));
	sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;

so sub_tlv->length is never written, and the two trailing alignment bytes
are appended with a bare skb_put() that does not clear them either.  The
neighbouring oui and sub_opt regions are explicitly zeroed, so three
uninitialised bytes are left in every MRA MRP_Test frame that goes out.

Put the sub-option TLV header and the alignment padding in a single
skb_put_zero(), which clears both.  The AUTO_MGR sub-TLV carries no
payload, so the zeroed length field is already the value it should have.

Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
v2:
 - fold the alignment padding into a single skb_put_zero() for the
   sub-option TLV header, dropping the explicit length assignment and the
   second skb_put() (Nikolay Aleksandrov)
 - drop the paragraph about observing the leak, and the Reported-by tags

Link to v1: https://lore.kernel.org/netdev/20260726062518.43774-1-baul.lee@xbow.com/

 net/bridge/br_mrp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index 179d2470b..ef16d0703 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -224,11 +224,9 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
 		sub_opt = skb_put(skb, sizeof(*sub_opt));
 		memset(sub_opt, 0x0, sizeof(*sub_opt));
 
-		sub_tlv = skb_put(skb, sizeof(*sub_tlv));
-		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
-
 		/* 32 bit alligment shall be ensured therefore add 2 bytes */
-		skb_put(skb, MRP_OPT_PADDING);
+		sub_tlv = skb_put_zero(skb, sizeof(*sub_tlv) + MRP_OPT_PADDING);
+		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
 	}
 
 	br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_END, 0x0);
-- 
2.53.0

