Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C891C4A24
	for <bridge@lists.linux.dev>; Sun,  9 Feb 2025 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099466; cv=none; b=El/UBlVBZHrQCdsA9iAhRb02laFUjv99SOSWcBH0EgbThmSDomebcwzGO8pRwbDrDejePZjOkLucqAY1hlPCe9RYGkPDjGUPv4EI1lqGNCTm5k8YfGzEfNdHIDguwZF8KxxAxO8sIzs9M1A5TlI2dVAQvpd6u11px4g7a9lQqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099466; c=relaxed/simple;
	bh=eot2qzjFYblE5xeGOIs0eZ0Yx1RMdl3bwN0jHhnk9xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwNIrtqRM/JFLq8NutV73+rx4liCJldWajknE1gfuDMcgdNViL+aa1w2RNIfIsdwRp+RXqgLOs0c6Ve16grF9F00NLzHqpu1BY0BGc4TfDA5kizjJDHaRXqcfG4UmFciYp0R8ipKastU+rw5Rw0RA8jaMHjuOMDCKM/fO6tIbRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt0rYeqq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt0rYeqq"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7a4b40cc1so188366066b.0
        for <bridge@lists.linux.dev>; Sun, 09 Feb 2025 03:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099462; x=1739704262; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x342s989e3SqEpDprSMMdkIM/WvPO0edPGoockwe0Ec=;
        b=mt0rYeqquNmeEZ926LZnAJQMiwnml5HCHBUfp9t5nbzGujPUifr+R3AeaBMvVBKVJG
         U4KVdAryg4rndCt2DUQUhEC2IhzMASsRzYq2Fnx+6SXfDBUV0c7EGdQQn1dslNOtZEDG
         hmgk+68Jx2PxFNA0UlzfDgHtQ+TA8BMCOOOtgqMQdX8URM6IUcIgu+q20Gz94KkX9N0x
         8MQqXrFqJCjLC5gVA+IFOREMXv0wExAR1133lJjnzdZ4A8yYBDxsxkf75oE0BOYyLugd
         yKfFVVwINjZVKnw7J7/w+2vdk1+9wDTI3ljN4Mn1H0DBO2AvWSmy60IZrQzfn2EW1z3s
         34XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099462; x=1739704262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x342s989e3SqEpDprSMMdkIM/WvPO0edPGoockwe0Ec=;
        b=qWwdO3WJDTY39FaKSwOquA+Wdsnyidgg40t5NrIhGHAPSlBorodIYCdkL7L1d20pL9
         iHMXNumqT8HgJlObeqNnjpYVJ+zO+pTvpIou8siNbdBVsG7wvFuyoBtqOZj1ACOq4xuT
         6JydKeFOcOTCUy0Y0ywJlf+SxlwGxSFy7iWAV9PE8VdIeF308Shacgg/9kzXYCPpZdZx
         sSqW+ubxiXwX8SRAYmpZHj61C/x+RrmtwEhZHZp8ypqm2ZpgTnlaLggMYcYP97nl6AWM
         l04GniEnWRHH+wgrptQ9VerPuTVns5KwMwlRYB8p3Nz3SG9gHUFEOFOrGbyYumur2QFP
         /Nsw==
X-Forwarded-Encrypted: i=1; AJvYcCWlMBOWjSbr90A2vexUIFELS54C8ToCCJX+d/vGtqgOxvjkPLqvJ8jyBmTQaFvojw2AHHD/vEE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4bMgAVgxSBIsEqgMA8e6dMyHkZD4quS9sWoWrXBNyslvUyDev
	YOvCmow2zRED4XVTEA0gX16ie/uLU4lhwNphNGx3NZ6/P9goYvQM
X-Gm-Gg: ASbGnct22sj4qw6VrjvZv/qCm7jATcVkhObkkHJHiiMLD+wAE4znNiaGsf0wCpzPMW+
	451okmg3hoSXY5Jvp6gHj0HP9Vu+YnUIwXs1Gt2VuxY5/uE6uMV2q/CKSH11QebEv8Y8sErRSxS
	t/Pzu9tDyceVISMwCm6IHtxp+plJ6lzx9iXBZmwNifgIn+WZ3NdwzMGiJLp2U1IKmfduNIql+GI
	Kw2wgNtsiLodQGk5lrJoa6Z1dGoiqQFgcDPTT30K3bcANciIgAahkTVAG9CEoXnLQu1f5pK6nMH
	EDt1DhrVs8H2MFzuiGXjhysjX+s7ZxYlXm6QF2yP/QNPc66YlpQ1Yd+krupFVhiL5w4c4XyPCzW
	tCSBBCugQv5osRouuL+Kg2iD5AAVdgeNN
X-Google-Smtp-Source: AGHT+IGzFOqbzdxNGu8XFTKkecQMR7PLLsHBIzTQkjtLs9gLGZn/h4ghB6cukLwFR4KP5Q7Rs/NF3g==
X-Received: by 2002:a17:907:c283:b0:aa6:66eb:9c06 with SMTP id a640c23a62f3a-ab789a9be1fmr1119975466b.5.1739099461657;
        Sun, 09 Feb 2025 03:11:01 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79afc7452sm357516366b.163.2025.02.09.03.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:11:00 -0800 (PST)
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
	Kuniyuki Iwashima <kuniyu@amazon.com>,
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
Subject: [PATCH v6 net-next 11/14] netfilter: nft_flow_offload: No ingress_vlan forward info for dsa user port
Date: Sun,  9 Feb 2025 12:10:31 +0100
Message-ID: <20250209111034.241571-12-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209111034.241571-1-ericwouds@gmail.com>
References: <20250209111034.241571-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bitfield info->ingress_vlans and correcponding vlan encap are used for
a switchdev user port. However, they should not be set for a dsa user port.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index b9e6d9e6df66..c95fad495460 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -116,6 +116,11 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
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

