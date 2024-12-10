Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3603DAC19
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823992; cv=none; b=cJmbo1V4+aJpC6MJFf5pH5xL983Dk7vQC3Z9WqGd7GlKMrgZy7q2KS7qA/tDuxcullOa0qudQ9Lajt102AfhMihAZsJBB9EEoWOnXQYIPVx/mMTdcBJT6miKwCDF2p5HNZZ84UAUlpsst0C2Y+qRi1DNZlkrmf2e4/2qMGTQfiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823992; c=relaxed/simple;
	bh=dbAGsONnKRZzlx83jeLRPcTwW8qS9zwjqCZyp+6J28s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8TtPVN5sxPAadEopa7GUmTs9dmw1ImtvNFF+23ikaGRRY67NaYjUg3zwIg16uMzNBFRDd1yeTjtkKzUQZRlvZgnsz4k/yyGEcvIdRkWJzeCvvVDE7uHQrWb7nsEqWmULhflL6z3hnk96EknllVsW/CrnOGlj0PgcbmnoW6EkOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsyUhJef; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsyUhJef"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3e829ff44so4753022a12.0
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 01:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733823989; x=1734428789; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BztZ0cfqRt9dxay4EdRKv7PmLiYD1WDU1Ehk6gLPnTE=;
        b=HsyUhJef2vieoOb26DxtTak3MyH1z+PhEYpK7bCb0Frjsb4Z/xtfuA7chJ3XEX0Esl
         0W4jIsOEXcDuUSnZBaVxZVRYO+4Hk58L59ccta6GPcfDC+aErfCvJK8tbr8VnxXj9cww
         AAj5sgmqtA+PTzFFH1Xt8Z1gf5eLLigFzqGPbDgu4v6nHnvHrKFpwgE6KSloc1dYbpnB
         ef0DK+xbHDb0SFhjPd+wH7W2Jm0+fyLE+zTIDOPHHWUTIRsZTtymbd+NY5JdDmaEIW6n
         57s51UCeIajfU7mPwagVbQSCEeVozFgJtwzCmIjX2+wqB3wqV66wXOKRJef6+khxuoyF
         O38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823989; x=1734428789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BztZ0cfqRt9dxay4EdRKv7PmLiYD1WDU1Ehk6gLPnTE=;
        b=r39du5+0+0Yi4f1fa2eqHv9J1LbOrsFrrgQMnkMK9XFeM/dJgMlywTsL/XMWNyBC/H
         3ZIcChZUwi6Dg9UqhVwJmI05Ip5XFFzqhIXlWSMoWVBTvXhDzcaRTjSM2hQb1ImpwNCg
         98pNqjUD04+BilMF8Vlgtm6nlekz7c+BtO6QAIxPDzmSCiKHuNmybrGK7nlnRYUr0cBw
         5iO7/X3EGczc+86DnoZTAoqvJSkuZB9dvAe0khfsXu/nYmnRZjMf1wU+W9eYKFU1v6NC
         oyiUJe0zUHBMdexRtrU23HreHGbSmM83MguUhg4RqHzZiStI9IrNjQWgxo4mV8kl4YQb
         tFYg==
X-Forwarded-Encrypted: i=1; AJvYcCUNOBM7Ax8JXpRkPOL0wwA6l2hmosY1q+pKexr7LC9PFWFA4F8w2rXXlYlBgQ5vraj9/DabNgg=@lists.linux.dev
X-Gm-Message-State: AOJu0YwK3Aoa+wSt8JXZ/vywNkgLpNWYxQJUzr8ktBpiHoDmKDvf6ijs
	CMrGMaXUr8YLLYho5eX9DOY+6Alce/k4pX7V8BDp6gQ4F1Ru+Y70
X-Gm-Gg: ASbGncvHBzvFFn1zhJVpkpPh8Dr7O0MHIfd2RJNALqYlblPFN/VXS0w69oaTqqI2IpV
	+ZFvAbYhWprKb+DakxY8WijR399mj9De84YkWmnqRO66C9BwKI0q2vbtORN2kn1aeT117FnIyiT
	XmfK9kfIMqVYvugGPEI+7emN2aK/BrnGMO5hEjq9FmDXqBAJnNJQIGE7+2urTx2KbLQCVRSUwY1
	KtJhouPnXM/qROangi3n6wsWOpZHR8XGa7miaBeDv/7qJGL04Y8oml+MWmeSynWdet0vY7oGtO0
	ZPM33Inbl1QdP9Nd8c15Wkndkg6cCTBfv+q0Yu/uEtT5r8QxN0nZ+4WKpD8wGjb7hQCtNIM=
X-Google-Smtp-Source: AGHT+IFyTeE5viLWDV5JNS3lSXCPHMg3QwwF9F8vVIQIRSBON1JTkjS6u5VFo+SMdaaFOV+dkCijqQ==
X-Received: by 2002:a05:6402:524e:b0:5d0:e461:68e6 with SMTP id 4fb4d7f45d1cf-5d41e36d2acmr2440521a12.17.1733823989216;
        Tue, 10 Dec 2024 01:46:29 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b609e56sm7313936a12.40.2024.12.10.01.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:46:28 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH RFC v3 net-next 10/13] netfilter: nft_flow_offload: No ingress_vlan forward info for dsa user port
Date: Tue, 10 Dec 2024 10:44:58 +0100
Message-ID: <20241210094501.3069-11-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210094501.3069-1-ericwouds@gmail.com>
References: <20241210094501.3069-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bitfield info->ingress_vlans and correcponding vlan encap are used for
a switchdev user port. However, they should not be set for a dsa user port.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index f7c2692ff3f2..387e5574c31f 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -117,6 +117,11 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 				break;
 			if (path->type == DEV_PATH_DSA) {
 				i = stack->num_paths;
+				if (!info->num_encaps ||
+				    !(info->ingress_vlans & BIT(info->num_encaps - 1)))
+					break;
+				info->num_encaps--;
+				info->ingress_vlans &= ~BIT(info->num_encaps - 1);
 				break;
 			}
 			if (path->type == DEV_PATH_MTK_WDMA) {
-- 
2.47.1

