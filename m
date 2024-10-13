Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D597115749A
	for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728845747; cv=none; b=lT/bhjchy/JoRNPwPEbAevxmVCfTpTGE8TfQjWAm+tJhgyaI/QsyV+A4qTlBab79G5byrVQgS8mt+he0sCka6p1x9WmJaH7KlVTzIpIABrOkDejYoAqSJ8Q+tayunNMDlV6H+JCYcCnc2fqSuF9F2P4wGXPj9K/9ZdLjgZBgh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728845747; c=relaxed/simple;
	bh=qiG8ZutskEM+cPKvaIWJXoyJOE3LBvwNvOeYgLppLjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eG9eC7hW0uuFo9gJl/izsqFdE6RuO74C8zyEQv3WG25h2qJ+bWaOjTc573P29sxRcsXsbDrNeF0lNhsTwhaL5ZnVKIVLpFt8YrCAGpOSmzl8RTDmDwwG3okaRsuMQzdffkdyfG7ZVMBCpUhrNjMcR7r5RXZ9JHhZd6lcIjScv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtsTUfXJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtsTUfXJ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99ea294480so159789666b.2
        for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728845744; x=1729450544; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3I/LHRTPLqJJONKYwwXQsldQo/OPnYwvoagC0qSu+YY=;
        b=NtsTUfXJQMjJIuBBYcmv4MW/UYyrNHwdNJsQqJ3dXJYvDFmP9GqdI3MnNbtDch1+sI
         NOjda6jWo1CUaeAJ23qBOZmHd8OzaTVTOPvLfwMz9Ec1Qv00mF2wT3PRpjgx/UI2IZSL
         h7ZfJDVPCiOdGc3mdJP8uZuBDAqx7r3mHMuMTPFAQ1Gie/sS7wfH8Ws63NnwB6oPkULk
         +nkBpu4NA7kDvoQcawkTMWF6FDVfRKxUELakI0jMcjASc5bip5YDiuJMHixPsItowGi0
         kF5E4H/X1Am/b1Ic0WgMhuh+5AYBQJC2zK7fquFBKKp+PIwWmFCoRme3V3pQ3ddqeT17
         FHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728845744; x=1729450544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3I/LHRTPLqJJONKYwwXQsldQo/OPnYwvoagC0qSu+YY=;
        b=P/JeklXwQvTWJLbDi6d3uw7XThqcGPFBjnPKFtcJblKjJ7k6H8ozJPfEypCVxZn3oP
         YI4OFjbW0Sj9NOURrfdOuZMzQNkB1Fsq4UtGMFErXwmHDPFERf7H24JzbcVmhVyL0AUg
         t7iMmM3zDwipNiR2UXO6DHeaoPHShkorZmLht4Eo5DlEV1qMeo1STQ8eZLtg1o6gF+jX
         63ygZcB5rJAlwGcy3F6hWOcvhlNt8/ByW0WVQO1BNURhspbZspDX8xj6IzTPn7FB2y+W
         xTxoNjkMhGm5eYhCZEQNr7BKh5Ch+gM4mFmAC5GbvHrMQbLUzO5jwbPGo6l8maHE7l9g
         qnMw==
X-Forwarded-Encrypted: i=1; AJvYcCUN3YUIy2eP0RBNWhq1itbRnlgTmSLGqa4hy0Xxpq1oY6yuRQ1S+3g6DS1K/I4BYr8t9DWVdQk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyy1nszEuj/p9iTbEPo0Bwz92Vt/BuJ9KFN91rTaKzgMuH8/959
	0du3C/yy7M5PZ3hkSeyRW2dBRlC5OoEBD+HTV5e9QUUCdOeBk7Ig
X-Google-Smtp-Source: AGHT+IEK/qY7kO3EuTXV/jRfrEbLu6Bs8uGBQ+icVQCx2B6S9pRxxPh+utvTvacXCNe8KWGJaLv35w==
X-Received: by 2002:a05:6402:26d1:b0:5c5:da5e:68e with SMTP id 4fb4d7f45d1cf-5c95ac09876mr10710253a12.3.1728845744129;
        Sun, 13 Oct 2024 11:55:44 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a12d384b9sm13500866b.172.2024.10.13.11.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:55:43 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RFC v1 net-next 09/12] netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
Date: Sun, 13 Oct 2024 20:55:05 +0200
Message-ID: <20241013185509.4430-10-ericwouds@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013185509.4430-1-ericwouds@gmail.com>
References: <20241013185509.4430-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Need to add NFPROTO_BRIDGE to nft_flow_offload_validate() to support
the bridge-fastpath.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index bb15aa55e6fb..6719a810e9b5 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -421,7 +421,8 @@ static int nft_flow_offload_validate(const struct nft_ctx *ctx,
 
 	if (ctx->family != NFPROTO_IPV4 &&
 	    ctx->family != NFPROTO_IPV6 &&
-	    ctx->family != NFPROTO_INET)
+	    ctx->family != NFPROTO_INET &&
+	    ctx->family != NFPROTO_BRIDGE)
 		return -EOPNOTSUPP;
 
 	return nft_chain_validate_hooks(ctx->chain, hook_mask);
-- 
2.45.2

