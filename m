Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1461993B2
	for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068859; cv=none; b=X/c/3PCQFltV6cHa3GLoe2nnvmthR6zOcuQRKYNaIh4oG3/Y8QTNKgJIPiFg+MXeFU13MfTdLWC5yBEr3Z7lwBWZEIMIFPD50sfp1zy3f1ER6ZFNpEB5E98a8/W8CCqaS217e4kz7r/FYg4OILJLdR/MIIsTaUKIWgxHzmKjZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068859; c=relaxed/simple;
	bh=G/yRi1RkWD5UbSObIL3zoX8Hp7Dk5qAFsA6XXdFr9Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFoDV2dchlzrpQeg0sLlJOjGaKY8EJD1nheXHDWWcaGA/bKbiGatIcQuSfaXAqUmNb3Tn5m29uYO7mvFAADp+m/M7F/kLBx463aU826RsyWuW3eZEeRO1IEBTpYkDWSghqCu+Q+nEGyDG4h2s5+fRZiK1SybGhOJPOzhXpn4gw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfE+s1OD; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfE+s1OD"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2963dc379so545922966b.2
        for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742068855; x=1742673655; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QaoeBv3gJPJ5tKrPKZcOsUFoglZ8+F/KcBx8mhaIssk=;
        b=XfE+s1ODFWY6ZKo7TAmzUV4EGjAYI7QfwLm4z4ZLATN1MURrGQHNUOXnHqrsjmmmJc
         m9MtDeY4CeGke8i0gkxjQMbU2wjgUlDeiD6K96YR6zZ6Z6RUy8ACmj1BLVxBJ9geMFY3
         eIkZrR/MP9rjTliNi7A1U8Vix7Khh3bDuMI4xcapa1yMFcrpaCQ83fgJrcD/b1bgs1R7
         ZtmRYn1NlRyuDgWb6CKetzRiKpH73Yz5Zq74ukFOCQyamAhs8a7tPWSix5E+WmhOVQfi
         ihg1/XuHtIWHhUMH5uR6LPAZ8O/B0+pPP5lNSfne5GeNcmP2i3c76keBYqqWJbmR5mZF
         qVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742068855; x=1742673655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QaoeBv3gJPJ5tKrPKZcOsUFoglZ8+F/KcBx8mhaIssk=;
        b=RG+85ao41HMwOLHZ1bj2ixDKDaZ0A4pYAVACoTiy2vQdyXfdEs3DQC1hrFQ9QDxp70
         GeMQMCgJWo66P2r/8KYT13jxAW6DspujqqBSDss1zJgE/0Vyub4cViNSiIq0+THtsUpz
         ygsmnGhDhLWDPdXr4X/0fenSRjjyYRU5VrbC2fhsbibm1HWMn4f/UhUCTh4sJlVvOdcU
         ptaFTi6tfrY0EV7DugX/rmPXJ8J8TeI3fLird27Meq5yL+c5m9uRCMPIQhpcoFQpiTt2
         f+RLvsK3EN21AWSeSN55DVkunth0rpQj766Mv5SL/sdu9dmjnF2FJBjH0LB24+cc+pZr
         V9XQ==
X-Forwarded-Encrypted: i=1; AJvYcCX74qDJW2PQjRUYeQCL34LMrYl3YKXaKfptdNVemtIKzjLLDXf1HFixDbUkgiBV09D0VPrEdQg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxFqAz9y2gJlK/90HFAXGUQx9+2L6QEGKVmaKzVG9mOo7TG/ndl
	kqTfbqhR45lx5qHGGyClj3WrTee9Hj4Qqla6A/RqwiYrZlS3gxjL
X-Gm-Gg: ASbGncsiQdFyvBvnRZn1rYpvGhwaQmXSAMsZny8gu6madhqGVbIIQeZp9viKhlJ+pwv
	2xePgWFB/jyGQhTqGHUWiHWb1hfIdYs+BNWwxdxlWoLkJ4ZzS3dMOGgIUdwHcjd/I+1MyllnC1J
	xqHgWlU3HnlmaLeCam74aWbGiriEn+tzAlMCZLfgenAKP+bC1cjrnR30c9AOkuF2CkUpV1pJBwp
	xJ/ygcuK6rlr5PzbMqSRbOvsJRZBfPN32pHVHZb6gENTMHxHloeyUmrywUJkAeqMEjIgQBvA8yG
	A6Qo3IQHtNMAM60EHsRme6xwPgVCidJpbBqbmCZDztnaQiHVel2Odc5vwmJvpSyotsTlaFb4iVI
	6S/QzxRs7MVrxIMJT4vcXGVjzv5ivLK3HLQ3AvgGDFIK0kWRch3zl7/S8oxq8JJo=
X-Google-Smtp-Source: AGHT+IHSU/jC6C/A2Lsm5jvq7xx0lXG5oat5da9YJ9l08h0SXcXFfdHAQaMZTXQ+xKscKf6OKW+jMg==
X-Received: by 2002:a17:907:9725:b0:ac1:e332:b1e7 with SMTP id a640c23a62f3a-ac3301e23aamr733726266b.4.1742068854769;
        Sat, 15 Mar 2025 13:00:54 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bc6sm405908066b.49.2025.03.15.13.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:00:53 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v10 nf-next 0/3] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Sat, 15 Mar 2025 21:00:30 +0100
Message-ID: <20250315200033.17820-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conntrack bridge only tracks untagged and 802.1q.

To make the bridge-fastpath experience more similar to the
forward-fastpath experience, add double vlan, pppoe and pppoe-in-q
tagged packets to bridge conntrack and to bridge filter chain.

Split from patch-set: bridge-fastpath and related improvements v9

Eric Woudstra (3):
  netfilter: bridge: Add conntrack double vlan and pppoe
  netfilter: nft_chain_filter: Add bridge double vlan and pppoe
  selftests: netfilter: Add conntrack_bridge.sh

 net/bridge/netfilter/nf_conntrack_bridge.c    |  83 +++++++--
 net/netfilter/nft_chain_filter.c              |  20 +-
 .../testing/selftests/net/netfilter/Makefile  |   1 +
 .../net/netfilter/conntrack_bridge.sh         | 176 ++++++++++++++++++
 4 files changed, 267 insertions(+), 13 deletions(-)
 create mode 100755 tools/testing/selftests/net/netfilter/conntrack_bridge.sh

-- 
2.47.1

