Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F172822D4C0
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122508; cv=none; b=sX8Qz5PT57XUeo6LORn9RRkVSLToA9fUXyavzsGPnfZVBufUaL+7vlHutxP0b3tA3h50/qhQ+7+kFz9rSv00Vfh1n32rd3z0drAIs+dnNJ0qNalQN71OuQV1si+bRZeF494gO6qQockXmbMFM+nEYbT7dPDteGGqD0fwE26iX1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122508; c=relaxed/simple;
	bh=Bi1g+FE34fHmwPME0V+bhZ6TtOD/z11DwCQDy4/94MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=os+1rnW2nBjaiFFCqop3ZXmaByTZXRS29Br7bB0Uw1lg56Le7fq4OGDNqj4XWgiCjeqw3FlJqlcqqxEJ2BEJMS/aIoYewQLFLWHwY/UcV/QlbKse4iVX2Nh1UxEXZkjxxAvRZewBvNUCNhTPGP0kWnZlVEnZPy/bkk6pATa3GM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th6nRJQX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th6nRJQX"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so8956445a12.3
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122505; x=1744727305; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acp6QAyrIB7XFPCeY/z2h/Zu51qu9lPNXfDcdrzAIRY=;
        b=Th6nRJQXGFBbl/ow4HQ5ppNCpxhkMUSwSG/jV7eTchwEubE91JDBVHBQFu3gDKUQ9q
         UkbQOn88QUGUD4haL6luvPTZUYYJdToegHk1uJQ9Cg9Tt+00m4FBiO7wQzgH6O7cvxPA
         rbf9NlFi8UAGrsU9MkSL1nj3wPrscuk0bv3PJ0FFu7zfMtbXQwM0Htm/rfGtRf7TTqqH
         cwumyHFLEGFpyIiyJ3NIdGw/cDs092hEAndCPO0w87ftdcwkXaBT6Eq7GIEVptj5FSEe
         S9CpSB584hZCql6mbN1RdoACaQiCaXprTseDqegkPt0y2/k4uXPqcvDEB1bx3a+I0Qo7
         ZnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122505; x=1744727305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acp6QAyrIB7XFPCeY/z2h/Zu51qu9lPNXfDcdrzAIRY=;
        b=gCBvHm6Sv9y9E6F3EteUCwsbbtA3sETQtJW1BrqPFa/Xh6+rliIOUaAKrJ8Fr/pKt2
         DsmxGW7buNdOAi+WNaCkqt5Vak1I4aMLAe/YJsz6EmM2lw/SI3Ol3ycq/19MBMnV1f46
         sHAt+Cj1YTyq3qA1ePyQgVNNc+/STmRR1DlbO47pvxTbIU75rPCjcnCvC3MZfosIdlCh
         zKvNb324UPrgKgwUInqby3gmdZ0ySWmv9AzChL0bZtxM50W3BkLndmV77EIe2VA2y5HK
         oCnGeJFQTS5vFl5u7uPjwM2nizsxQF6a8X4PNd+mrRx/I+D+o7KOIuGT5P90DM6ASIMB
         eBig==
X-Forwarded-Encrypted: i=1; AJvYcCV5iaymk1vYi/OyftlTHShVEAv1/MdFe3LraJ5isESup5+n3x1P++qVL58B7BLGFQd6ul6IrXI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8BXqfMBh50Hf7Bq8OzAkyKZC3IZp9VxzL/7GCUz4BFf7Cq+Q8
	ylH0c9OyTm7hfz6ZFtpDkMmpPWCXdE+cU0IL8/ktb7sih7pqvfkY
X-Gm-Gg: ASbGncu3VTCADMPd55Vj6ACqGnoY8CBytpEOeghWg2S9QOkIiUSB5Uq7OtkXyg12vto
	N1JWXSVxWYC9TtQdN5uZ3Qj78AdeOFBg05dMDecFmJWRZmD/oDjICS4oBYsZltQEo1r4ERj54g/
	IdIr5gBFZYcPxH8MwIq1OUPTvU+R2SfkVbE1tlS4kgVSC1fLLB5/rKQDKETfOa7IhYBnN9qB9u0
	eqsZKLuTAtjRvOLNRDkZARymiJll0s30eWbBPAL104aKghB0qDBVBKbAtiVyLafCSYgCjDU7RKs
	TKAGw/KIZk+5DyhsmzKPKIqCPe1wgIhylxxNZIoR8rqRGZuf4niiKpovVDHogEqnjUy0bQB5kPu
	w11DoZxaJOBLH4fiA+i60noqOmqUZKejJU3kMNoz+FSJWHeaoqkNlIovW1mKSJw5CSvBL024FcA
	==
X-Google-Smtp-Source: AGHT+IH8QHh6kl+s0CP+jLER1QUkzhPO+u0uCrglbs7J+deI7B/II8NFkH8U4zbe5FYa57Az6F/L4g==
X-Received: by 2002:a05:6402:5209:b0:5e5:ba3e:ab04 with SMTP id 4fb4d7f45d1cf-5f0b3e35c08mr12883416a12.26.1744122505239;
        Tue, 08 Apr 2025 07:28:25 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f1549b3fd0sm2236164a12.35.2025.04.08.07.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:28:24 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v11 nf-next 5/6] netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
Date: Tue,  8 Apr 2025 16:28:01 +0200
Message-ID: <20250408142802.96101-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408142802.96101-1-ericwouds@gmail.com>
References: <20250408142802.96101-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Need to add NFPROTO_BRIDGE to nft_flow_offload_validate() to support
the bridge-fastpath.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index e77164424891..889393edc629 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -438,7 +438,8 @@ static int nft_flow_offload_validate(const struct nft_ctx *ctx,
 
 	if (ctx->family != NFPROTO_IPV4 &&
 	    ctx->family != NFPROTO_IPV6 &&
-	    ctx->family != NFPROTO_INET)
+	    ctx->family != NFPROTO_INET &&
+	    ctx->family != NFPROTO_BRIDGE)
 		return -EOPNOTSUPP;
 
 	return nft_chain_validate_hooks(ctx->chain, hook_mask);
-- 
2.47.1

