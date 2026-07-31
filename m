Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A13546F4
	for <bridge@lists.linux.dev>; Fri, 31 Jul 2026 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785479834; cv=none; b=rJGFPP5zBWNhEh+ZcVw4+jHlqFqh14hzUabGD73KfVkD6i2oEYWeim+MY2rORutAbbgKjPOrC482to9W5XnrvYwiRKG6tEDZlUsauwukcLiG5vcTaXiF5RZq1jEMwhbAabnS8R1MpR3y0JbcLmQh/hpcJeCfVLry3Ib99Khlr0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785479834; c=relaxed/simple;
	bh=awBKtuk3P1U8r6U160YAF4cK4MFM4a/YKTdDyMkaeQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfqoW/se8jSnpfk6OWJPZQzLY5D1llPGT5TgPX8s/y0wzOi/oX0Z9hVWTZzJbIfSj2TLCWDj35WuKGxBSaJS+ytflKV/ZtKta9KicgtdY26AOScMj3pRPQfdgCMpZrWMqaODiItg1y1999OwPVsQaQpHIbGOFph3LddynW2xA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=h7zS3GI3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="h7zS3GI3"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e04df8c46so736697b3a.2
        for <bridge@lists.linux.dev>; Thu, 30 Jul 2026 23:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785479832; x=1786084632; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d35+JgJtJG1kYmqMSF4QUkguqfOFWu6IqCtN89cldws=;
        b=h7zS3GI3ucUguD/V21wy1kl431Ai5/2NMnyNb84nHXZKeu1+xbPBXs5IvDQStlG0Ne
         gx6V/wxDW2bSa0Zh+I+VylYcpLR1Y7/pzGk8pEm6mmUxaUXuniKHB/d+7goRJ63xxfvq
         LCukoMPsKYQmIOpF3ZzKsNljtX9ebQ1jet5QQRjK7DrltxkrrjYZR/VjsGGyEt8kzFZv
         idm9xvo3hf0FipS8uCwn3mn0nlB/blSSzheNupaVdjfwyQ6sXI+kvZ0YkrlsrPNA5sO0
         L+aVekXwqNWa9723snjMw5q/HHs3BDLLQ30OLD9ehvTFCd/zlgJlmbHSnmUSc3YsD75O
         DAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785479832; x=1786084632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d35+JgJtJG1kYmqMSF4QUkguqfOFWu6IqCtN89cldws=;
        b=TK+7XEjk8JacbSDeX/i/YwFrxop5AIm3hsSAXTxTSY+VwPtMCLfIrWerKjWgkqnBbs
         XCQtkNKGLMPU9qTSJFstKbzVrU9OdPsMXE3r5hauQxKUjpoCFDDviAxo+pZxiVJPkECD
         ZIDUCCWUXQwdiVQavu7NWoCKPgqaSkFR07Yocd4zkq0++TvipeI+7puitmpd9M1xuXCF
         17TIHCLdCtlG8EhbwtwwKqld9djUkBFbzMBP4psP7P22VvwOspR9T4qrTnR1zUDVE5pr
         7r9abNcTgShB2TaEr9otqFFFmFNC4/AvmiOJfs93XBWRYzKZ4Fjk52f0fjaJW84Lh3dU
         REog==
X-Forwarded-Encrypted: i=1; AHgh+RpcYwNWwFC4LKEPur4UgN0qAKkTosxfa2tIsNYoK9CygBx6Sn4FAH+6sJ90kciDjWlyKJCyuEM=@lists.linux.dev
X-Gm-Message-State: AOJu0YyvNtDpHWvz19tOdDiT8NlpTR+wcBw0tLbLEoTw3VqGrDxO0VJT
	4gVBfltZ6ghdIfgDUe7ZznSTQHk7paALmPUFZ1Zmpxv7z3EcoRLFN6WdJ32XZCKuE8da
X-Gm-Gg: AR+sD13zfvxopCueMHfG3YcP3cTw+E327/GsSbQmHGFuKP398iE7YQMo1jP8OiBzjQg
	h7IMT3Yu0TZhzB+gSHLwisxC5ToyK8TTPWPNIxcQZE8AfIcQlf/AxPYZ1CaDm5u3y+c7H89P+WZ
	YxXlP9G4kLfPyMeiUeRpJS+YYzQOvy3CHOId1DJoFK3Tx8RSqsDdP0C8P5JMrXW8psnGkqUjkpV
	fpEWf30DEgYb77VPzt1EuzE7VOf3gcdMDE7tD/h4wcw86NbgTK4zX70SkelKXuY5cPZvYPDZ9h9
	RczXSicNt5vFElt9GDSUyeQddhYCJ8qqFvyfAcN4WolMTUPXDMImZY45zZJPTYxoD6JsS8B7gFB
	NZ1t1bc7jwh3p58h3KAlaxeGdbMlywOgwB82jJykRJzrMmF9Ryeer40DmxRfDr4ccXvMQwCD1zs
	/C6lZSQ7YUij3+KlXPZpZignbAVQdgDrVeZWENG6WKvFXItktYUcEJjEWUrvXo68WzOOZoSdDcm
	OoR
X-Received: by 2002:a05:6a00:1813:b0:845:e08c:a4eb with SMTP id d2e1a72fcca58-84ed6f0a7bemr695627b3a.58.1785479831871;
        Thu, 30 Jul 2026 23:37:11 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d7b97sm6102b3a.43.2026.07.30.23.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 23:37:10 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH nf 1/1] netfilter: bridge: release template ct on non-IP path
Date: Fri, 31 Jul 2026 14:36:53 +0800
Message-ID: <3cf187b612fd78f8835fa9dad870326ce380f82f.1785479514.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785479514.git.zhilinz@nebusec.ai>
References: <cover.1785479514.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bridge nftables ct zone set rule can attach a conntrack template to
an skb before nf_ct_bridge_pre() sees it. For non-IPv4 and non-IPv6
EtherTypes, nf_ct_bridge_pre() currently overwrites skb->_nfct with
IP_CT_UNTRACKED without releasing the existing template reference.

That makes the per-cpu template, and any temporary templates allocated
for concurrent use, unreachable and leaks memory until the host runs out
of slab.

Reset the skb conntrack state before marking the frame untracked so the
existing template reference is dropped on the non-IP path.

Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 58a33d0380b00..7ecb8a26bfa3a 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -280,6 +280,7 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 		ret = nf_ct_br_defrag6(skb, &bridge_state);
 		break;
 	default:
+		nf_reset_ct(skb);
 		nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
 		return NF_ACCEPT;
 	}
-- 
2.43.0

