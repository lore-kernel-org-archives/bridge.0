Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79A286AD3
	for <bridge@lists.linux.dev>; Tue,  5 Mar 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649736; cv=none; b=rjLbj74kSKkktqn2yy0Xqc1Vl/47j1LraClGXI9dUCWfrdT6lum7va2F/QHXLYSyWSCfA1cVIfSwLrSp+nvbuf/bvuoy8UxHye9WKZcrI6ITjh5OcwVCj+sWtM1nS4mXwOmEMifwWFnHMJym0fPzRLulKB4+TMG1noAlbPjXPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649736; c=relaxed/simple;
	bh=gOkcqvkH4D3gY0n9wniKJjMcha0dhupF5N5XpLv3Ch4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qehryNLjs8eJF1CW0DhpR3enX5C6Ka0VUZ6oRcC9cekuVNA/c2CkKLzbRCcMS5PTchXdSTZ7CRwmQQRDIEUcbGDg9CTK+9Va3JVONymAeBUnN8pwo5zR64XvsZ2ZDSCH+Ds9HUoHHqMVj6tOLwaJOFRw8YAqWqxZWaUKa7iMmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLzqxgmO; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLzqxgmO"
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso6658950276.3
        for <bridge@lists.linux.dev>; Tue, 05 Mar 2024 06:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709649733; x=1710254533; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=csPhwUZ0maNDO/kaNYv8h2cWEul9MJDz344oSfBRaZ8=;
        b=eLzqxgmOQH5XEYOuTbDPyl26Yqxsk4/8pPZnzcGvhHFwoh8uVQHWjkW8XFI6j7vB38
         AaUTCb59dkefbcczI4DHok91o+ehedkYeXQb/IN4I6HAr0MUGUGBTHuWoYs2nchA7AoE
         DSoYMlzo12z1BJbg8HjeoK0bo9EZCyG8KzhNoxauuqR8JGTMgGne4QqnJx8deFQ0KBTt
         dhImYi61jKFtYRPFSHjeEr8GiFVMdDsSN5fhYh8th/FOojb4cQ595zCbUGL/g3YxStnq
         AdOkyvBpeqB+cUQbifz6ews2cO7W8XpsLwHL1kpbKpDXkC0XRYN0edCTNMFhR/AIDrRi
         IL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709649733; x=1710254533;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csPhwUZ0maNDO/kaNYv8h2cWEul9MJDz344oSfBRaZ8=;
        b=W51SVRHrQygsdoJeETzQ5cutSlMz7v+eedFzKkqRjoJBl3SDiM3LySx3E+IfqRDWtu
         HSEi261Vd/bL8mIfjCQ4dRAna5a/iH48WywN5WbQxhwE0cNMi7fynoVT0No1phb9k+/8
         lA2oTq1LJ6sBX8Xy2iyTdyhCHIrxO/kKOIe7Gh3BN1LFnM6q6H0dfKec7tvktZ/FqnBf
         bGFC6I3fOsB1AENLbqjPRFZUEyhZPQ9gMwrYam1RPoMoh9xBkUa1+JxCZsup8xOFj8n1
         mxu/uEJQI1dT1M/ReAlj8o+juiDNB/dphI5kTycl+bCw0u567j2BKGDEf4G1gSohOok/
         Kabg==
X-Gm-Message-State: AOJu0Yxe2s9YHqlAqay9s7Bjs4Nlzjfj//eI1wSCKHBJD/EvjMLbYuGw
	K/ul8AYQG7s8iX2hHJrhOX+I73VSh0mKgQZ26xIHJPLUFHrmBrYxZIdLNOl/wLmrC3gqS6cxGYA
	bPZCcQ5p23KNLSy1IJxqIE3P7VfE=
X-Google-Smtp-Source: AGHT+IHWHDy+FAU3g6qvTuYFUmEnFnw6aA+MA+BXaZcVDBrx94Z8KwzZE6neyEITOiDh3pAIUCK5OH2PPx2cLHbFkf8=
X-Received: by 2002:a25:b9d2:0:b0:dc7:4f61:5723 with SMTP id
 y18-20020a25b9d2000000b00dc74f615723mr8551184ybj.39.1709649733725; Tue, 05
 Mar 2024 06:42:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Zixuan Tan <tanzixuan.me@gmail.com>
Date: Tue, 5 Mar 2024 22:42:04 +0800
Message-ID: <CABwm_eRuL9UXanmTaC7U820=8GLAHHwWuFP=REOpECsPR+pPvg@mail.gmail.com>
Subject: [PATCH] net: bridge: Replace deprecated build flag HAVE_JUMP_LABEL
 with CONFIG_JUMP_LABEL
To: Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The build flag HAVE_JUMP_LABEL has been deprecated and removed in commit
 e9666d10a567 ("jump_label: move 'asm goto' support test to Kconfig").
It is no longer defined or used. The correct flag to use is CONFIG_JUMP_LABEL.

Fixes: 971502d77faa ("bridge: netfilter: unroll NF_HOOK helper in
bridge input path")
Signed-off-by: Zixuan Tan <tanzixuan.me@gmail.com>
---
 net/bridge/br_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index f21097e73482..3700e47ff181 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -255,7 +255,7 @@ static int nf_hook_bridge_pre(struct sk_buff *skb,
struct sk_buff **pskb)
    int ret;

    net = dev_net(skb->dev);
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
    if (!static_key_false(&nf_hooks_needed[NFPROTO_BRIDGE][NF_BR_PRE_ROUTING]))
        goto frame_finish;
 #endif
-- 
2.40.1
