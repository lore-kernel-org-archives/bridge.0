Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D97768EA
	for <bridge@lists.linux.dev>; Fri, 24 Jul 2026 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784869966; cv=none; b=dO1dqKBIwdcugwISD/32+ZDRI+CN5FoACWzV+n73AjlbqLS9ehYTpY58x61A3xu9eZlF9fg7602OVmWmd51/l5M8foT5rosAGietufw2zRSMwQLipfATB0kV/cf0ufef7sDbLlgcBttcOHM1RAbZr3pSlV2ZwdqmC41BUo1mnfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784869966; c=relaxed/simple;
	bh=BXw66hXGuImIJwHVpe0J6OOzDDbA3l/0X6t5liDFZG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WB07ugyeN4ClgdVQ0oQ/2yx5yd5qD0j38ZItj6HQkTvUHY6U0TsCivB3Q0uEJUTAQ1U9Pv+7eJPn13M9LOSMedo17AVKP32euoAsyGb9FxK3yx6mWbbAGXkkOG4nBdKqHptrvd3XmphsPZomFmqKU25ZPO28KXb/nJ2FpRt6+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev; spf=pass smtp.mailfrom=corvaglia.dev; dkim=pass (2048-bit key) header.d=corvaglia.dev header.i=@corvaglia.dev header.b=VfOjd9EQ; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corvaglia.dev header.i=@corvaglia.dev header.b="VfOjd9EQ"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a384e29a20so836051eaf.1
        for <bridge@lists.linux.dev>; Thu, 23 Jul 2026 22:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corvaglia.dev; s=google; t=1784869964; x=1785474764; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rN9GaeCC8AYVH1+QdHf7ZR+ma81Q9VJG0dObH93Dktw=;
        b=VfOjd9EQdk3ouRBB0pCoIwHdWEyEtNL90FVZcbfOC0mxFxwK5AON3ezANNyWpeqCj4
         DtDR03Prl0ZRJOHzGfn+alveuy74M2QOpMjNnOBhYu04W6vZtvJNgBOvZMy0HLK6mIsy
         c2MdHHy7kzppYek78lTQ33TUGY42qfKdeQrfy5Tr5R/Ip2eZkBJY4QTJgaT2x9KSmpQP
         eKHDqps/WVoJxGqJcmd846ySbuTTG7BurEo6tPGPux90Bjuy2MvHO7dPzBzcu9Jb2Tek
         jlVXvxNduve1BQqrjcF6eD0tptmyrIZTJI9VCou3lZfpcUZpq4ajt+krlZqUDKl0x6xo
         9uCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784869964; x=1785474764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rN9GaeCC8AYVH1+QdHf7ZR+ma81Q9VJG0dObH93Dktw=;
        b=dOujw341lz4NcyfM+ZvizepYDWc+g01f2uSKnZco2HnCk9rJ5srwfN30IG4kfjneRS
         VUCh7Qh5Hi5WF0nt+Ch5bSSp6e2MC5mKlGlBftvd/xjzSkZmKkqwh/KwadE61ur6fJys
         DkWMqzU+kvWXy035CKnd1P78VsVfg6cOynEumVgd4r1YVn/AGVHyAy2NgAKZxZPMkxXp
         LbHEOeBRewtdX4Ebll3m7MxwpNnFPGmsNLrM/vV0lcrXt5Q+RU4XLkBWQjvU/RLtkkAM
         TPtsfHemVevxQM3I6lx3EpbnpsgYip8unc1B5wYFXEjToLsSgwwTPh8vmiP1iyAW07NM
         ykbg==
X-Forwarded-Encrypted: i=1; AHgh+Rqf12xiCw+J2tnanSQvYcDaYMSS9Yml+dahwaqMTsTY1pZTee5pzziFym3RmDQz9DcFa3G+eCM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx39cwUkcO9LPirdDyPbCgQMPkqKBG8yPukyTDxrqdDpYLwtIS4
	082AUhRO1t1ISE96CEv88cNGmCsk6JtpeLLABxuE9V8HqSd+52KqPGrVaWNoJRbcj6nd
X-Gm-Gg: AR+sD11ovzCGl24ZBMtYcMdCkU+IU+Z5k2BivccyRvTeUj42joDf4xGzXMQHRgyEuOY
	eYpYOVb+9ySCPhSa7ge295U7lXUaSIrV6BEHy+HXp8/fZ3qekJxNyD/VJ+JVP1Vo0HJFuMD0L24
	Ye0mAd3fidXsfyxRZq1a5TsNW34XpjhDH4E0hublnTTW5Jcsyy0gOg45nA+VBGZzKzGRvqKkgfH
	ol+lnP4ghwHkeRi/JsHUINnJSuwcqLMFNzTLjhl3tyUEmLLutLGnRFqfAKvTltoO8qauxuCrAGl
	gMec1lYe+DLwCJEPtuvg/9C8TeQkU/sXlrHkEtIIzmkOdAg7J4egpKJ1UrkG2rWo34ylj2B3fU0
	n8HzWG1Kj4RctGNemReGlY+a4IMse4+a1uxavzC0NCiuU31NRABpG79cpH5x5JQ9n
X-Received: by 2002:a05:6820:2d0c:b0:6a3:7f14:7d05 with SMTP id 006d021491bc7-6aad3fa6f31mr2879504eaf.11.1784869964113;
        Thu, 23 Jul 2026 22:12:44 -0700 (PDT)
Received: from dev ([47.160.132.81])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aa76c19081sm4924823eaf.6.2026.07.23.22.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 22:12:42 -0700 (PDT)
From: David Corvaglia <david@corvaglia.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Corvaglia <david@corvaglia.dev>
Subject: [PATCH net-next] bridge: mrp: fix MRP_Test option TLV length
Date: Fri, 24 Jul 2026 05:12:02 +0000
Message-ID: <20260724051202.61946-1-david@corvaglia.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

oui is a pointer, so sizeof(oui) is the pointer size. The MRA
Option TLV thus advertises a wrong length (15 vs 10 on x86_64),
causing misparsing of the frame on peers. Fix is to replace
with sizeof(*oui).

Signed-off-by: David Corvaglia <david@corvaglia.dev>
---
 net/bridge/br_mrp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index 3f7126a7d720..179d2470b724 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -215,7 +215,7 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
 		struct br_mrp_oui_hdr *oui = NULL;
 		u8 length;
 
-		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(oui) +
+		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(*oui) +
 			MRP_OPT_PADDING;
 		br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_OPTION, length);
 
-- 
2.55.0

