Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F241F0E5B
	for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527400; cv=none; b=lnaZS+Snky4K0gO7c2TSl2LF4exofKOfoAGDMLl5EgbCjgeL6q8CCIGr+R1IX5FyiHNT6PfGgpbRmhFiZewqlG9TINpmRNWF3iMYgylD++1iw4Qh14NK8u9w8RcFXJzunz/G1++yxPBFJHPMkss6/k0dpdVOy88Yhkf7xyZBH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527400; c=relaxed/simple;
	bh=cjTzwWbCJa7r3TyEGggN4J7HFrp5Bpypfn8vCgGnGtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N85RVcmj4FjlwCy6ems+pvHwYTBwOaaoUIJXnNau9jGqJsdDmaWnHVpi2hPFg5bDysE8CaHeVQouHnWwH+pqqgD+EwSb0v0flRxOd64YN4RVaOUpD0hDgigur+YRnx2But4DNZ3IGlrtGfOyYWbS+ExoHodlKRrWLcWfeo0qIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eICQG8fb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eICQG8fb"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso5055721b3a.0
        for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 05:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527398; x=1735132198; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
        b=eICQG8fbVBWQcvyWzwQi5Z15rwQSuZXizwWoc1CRACJSaDBER0YM6V2NR6UmlCCF1I
         omXHIwjQQJwgTBBErmXhaYG3o1MAmJbUQHDHm7v1jhTZ6LR7RRTdf8su9NtTFkOdhXfO
         WfHWZm/03YDO3pYnLWenalTXNCnkOy498QsoSmtxC1K3lgzB3/LWwM0ZVp9nEKCfTP2U
         uZNDv8R5bmkXkyU8pb5qRddytnF64yLUkIBLGY1je03JcY82Feor+ekpGrlSaOljwOvX
         ivv4VdcNBXS03vPj3xpA/Sg2/98GSp85pQiCyWHapdUGUdebBrWd2O/vin/5bfSzEHnk
         feDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527398; x=1735132198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
        b=h/FAhWkm9ErMfFfS63zpfv9/JIGzvfBpKxqU+yfx0ckUJqfhdFBa4xq7IJjVkgpiRg
         nEY9Mtq6LeHRN1I/zjBgWyRFQtqOh+E5fhGTYPYjCmIFV/tL6+mdCjW4CVzi3OsmLoVx
         n9Wo6pt6qzcFxSxzYFKsaOyBpFbdUCDBAB/QuitoMt+nGjX4WRjrMnpX+Ub3Sffi/7HA
         W2amrTjeh3nFKGH5bGJFr/C9YV4X5aBuvYoq+CNInAf8nNCtY7z5G97qqHX5E6grVd6v
         bA9k/0xhMDW8EXzDUQJ3a0I9N2pvyKHILckrqBZUtGhjUv3gqtseD+Ek0N4tROYbj9x4
         HFkw==
X-Forwarded-Encrypted: i=1; AJvYcCWUUHTsGtyJKAs3fWPmkRcXo4xhZzUaJt9YgFRHyyr+yLe09wW0Vo3SBCuJQWEcXrQI9WNPSls=@lists.linux.dev
X-Gm-Message-State: AOJu0YwCg7PY+MkeqIktTxOWNKWZQpH06Eodv3PBGr0sSsFTuTAysYB4
	TmL0KtwRIWtvQ5SC55IfqdAaTLbr/1C+V5XNOTGPKpqdHbiqbvdM
X-Gm-Gg: ASbGnctg2Eqztt65+mmn7kZ3l3Uqa4pwfCILjTmTATFwsNR7ilGb1siQrCfMHAZaGHI
	pm7Skgp88Rr+HGRDuREqu9b6iJddO5TdiZ6+rBfFtwpeUwC/BoGqKeXh9+tFt/8BeUX2mS3vwNK
	jFCfwTwRsWaXbONEdXAEyJMWgp7pnpEdu+yh/SaAhvMSIK5tgo4lQdIpUz71RA6i5O4wh9QaAb2
	kkXs0SRjPKUFJhYD+2E6CANFlAe8ueoLt39ogrK98lFil4=
X-Google-Smtp-Source: AGHT+IGmYU6ujKxLBy1JGYsxY/MwVi8oxkRDUmwYNBJP1y7XmPRqmJNLVIgjjMfYAOzzfAymm/3esA==
X-Received: by 2002:a05:6a00:35c3:b0:71e:1722:d019 with SMTP id d2e1a72fcca58-72a8d2f0b92mr4132701b3a.22.1734527397729;
        Wed, 18 Dec 2024 05:09:57 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:09:57 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 04/11] ieee802154: 6lowpan: Use link netns in newlink() of rtnl_link_ops
Date: Wed, 18 Dec 2024 21:09:02 +0800
Message-ID: <20241218130909.2173-5-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218130909.2173-1-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When link_net is set, use it as link netns instead of dev_net(). This
prepares for rtnetlink core to create device in target netns directly,
in which case the two namespaces may be different.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index c16c14807d87..65a5c61cf38c 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -143,7 +143,8 @@ static int lowpan_newlink(struct rtnl_newlink_params *params)
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 	/* find and hold wpan device */
-	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
+	wdev = dev_get_by_index(params->link_net ? : dev_net(ldev),
+				nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
 		return -ENODEV;
 	if (wdev->type != ARPHRD_IEEE802154) {
-- 
2.47.1

