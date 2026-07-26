Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197FD32E72F
	for <bridge@lists.linux.dev>; Sun, 26 Jul 2026 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047184; cv=none; b=KjkFYgBZgpd7eg9bruc+YMblFpPQ8PVyf22GEDtwIPJJLQNs6Md/vbX/8xsAqe6zCU06HfNNrOMjD+ZY1sXoTrOYd3pUI4IXAQeD/1m8KSDGAP80Cb0Q7GdzAbY/4fVpVvwZfQ5Zq0/PFCAFWR3t3KsO7q8XpyNrOKi4+qLIs+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047184; c=relaxed/simple;
	bh=U6rtLcsMd+bW6cgkNVoXqC0rvV2EUY2DJnWwFEigjMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bG5h6UVzvRfkdtVn2y8LA49VdNdt4OW08K3N1/8FDJE9XbEHtb/3rBDc/MyrneEw5KnWjuPpojk+Wx+npLC0jYasclnR+6gz4eNI+/jXiKsZoAzUwpePASmVjcsXrUW9ULuTK+tEZhvWOqJctNaztP8Qup40pjq/3LIs/k2JEso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev; spf=pass smtp.mailfrom=corvaglia.dev; dkim=pass (2048-bit key) header.d=corvaglia.dev header.i=@corvaglia.dev header.b=QrzhdofN; arc=none smtp.client-ip=74.125.231.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corvaglia.dev header.i=@corvaglia.dev header.b="QrzhdofN"
Received: by mail-oo2-f10.google.com with SMTP id 006d021491bc7-6ab07c35b5eso151047eaf.1
        for <bridge@lists.linux.dev>; Sat, 25 Jul 2026 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corvaglia.dev; s=google; t=1785047181; x=1785651981; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8BWHXjMiQy9uqWLmDCLbC9R8ot89mFYPDtLgVnTx4Nc=;
        b=QrzhdofNr+/xl9bLcpCO6wXZfXllDuv1MEpxnSFY8y51KygBp/CWDkoHM30jdv+KI0
         HgLOqfain+fYD3p2RG6yhvnyUarVvBerq4Mu8lr18VWEIuDfFzyLQGz3uDfLsHQBJc7M
         iBg6owXxWG1kUFSrhR22TkTMAc+ish//Z/CZAab4ZXNQngA7gzngLuS9cicrfh4laG01
         hCCIwHIZLxuSEo5RTOw9GMWee8xp2+LcN6ugyW5kxed9vxaZ1ryZOl6lFqKlp59dw06G
         E29Gi6/seMu4DUUEzIfzK3tBQxzoiKf1ErCV2PjGUvMCMAYfOp7bkIDdiRUoa6t89wE/
         /ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785047181; x=1785651981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8BWHXjMiQy9uqWLmDCLbC9R8ot89mFYPDtLgVnTx4Nc=;
        b=jjVyUFqj/agPa5Da66XI9EUobIAH9/YUZQ5nCnJLPDQ2jQBOTMfYtsRKW9wlJNyshE
         dHe4jCzSMAVyYO7M1X/lcHvK5smSnyF7FgieVWRe6EVSGTEFixG2uKooFqcxYT2cQN4S
         kJh5YfXJOxC90iyaxbuPeWEM7sP33geVLKLhXysaLvMsBhInrnabr64M/9E1Jefc5LeT
         7oRow7BTJ7m31znRbmwmHXCe+IQZP2nwhJbZRtiVLHdj16QzwkqSxaolVu3HMfssYBKt
         H1EO/nOJoVI3jZcssCxQ5XlKs/6veOVj45qIK1upFZ4sICw9prT4BU6zUJ+ylF/nAR0h
         HwfA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4BW2p4l1+wGYr6DYuwrSx9T2kO3fcoIvviOnvkGo5Q88uIHnvGwjbvTDuj7RNNzZ6G5Y+OM4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyPNDgqUYU0XzkTNWlg45Y2gBYBx64XKHACAyPlO1jgqml5FCx4
	/3C1u26htX4thIzKBlWUVcscN8Pe61T/dGSjyvgsJ27Q3nkJaO607qNYOh8Pjm1x0KWE
X-Gm-Gg: AR+sD108HFHt0vNnXkR1lB/Qqt/OINYj9DOXByO6KKqx5dMryUZ0/wtXH41daF8/NhQ
	1RWzX+F5wALxgufdeBZaFGd7r957V0f1A3VyrirCO38fdPFT7xeNRj86lc6osmirv1y89eP0wsm
	T0dwX4r7Djxdlpzk59WE0whuMTaA3XQFujPnHoqc6IMvHe/b9QKX5tl18nTgwCJbuYNbD4aOXaM
	cE/5O9831moH4E4vVezOHknvhuf5wkP5SgMvG3CZpFtoOwob5/WIKyQkn18+Md/3IifNxpRWqgR
	IyRYD18a2y7bXbTQXz63YWFRqTiUsa8BSHE5y5HltQYMq3FtsVtLEW0pMfQLjaWfrOMlgUgzZs5
	9M6l5reMFfdN3SwggquNN1QKbGAoil7G/6MuZbKB8KX1XdgNK0WM20QUdrRdxSJge
X-Received: by 2002:a05:6820:4dc7:b0:6a1:9a59:5c5f with SMTP id 006d021491bc7-6aaff9a5a80mr3020723eaf.46.1785047180881;
        Sat, 25 Jul 2026 23:26:20 -0700 (PDT)
Received: from dev ([47.160.132.81])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf92d0109sm3073215eaf.3.2026.07.25.23.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 23:26:19 -0700 (PDT)
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
Subject: [PATCH net v2] net: bridge: mrp: fix Option TLV length in MRP_Test frames
Date: Sun, 26 Jul 2026 06:26:05 +0000
Message-ID: <20260726062605.2746-1-david@corvaglia.dev>
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

Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
Signed-off-by: David Corvaglia <david@corvaglia.dev>
---
v2: target net and add Fixes header
v1: https://lore.kernel.org/bridge/20260724051202.61946-1-david@corvaglia.dev/
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

