Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5809B27E1B5
	for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773797; cv=none; b=tL4cCdPQ2I65HZ+/McRpeeEV3rax6aqIpVnWciJSfGefi+JGLboPekjzMjryuioD4haAh8HgVU6+Im8SU+blpHnp+ei8WTJpQ0XVmDmLI8VuST02Lw9DvXNSpJVgdr5VWErX4P0UIfRAbrKNvKIDxcRt4KxaqxoHu72OO9Vv3is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773797; c=relaxed/simple;
	bh=8dcYAV0MonhKL6O5x+ptHAAw+fbiOOhKssEKku03mBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giuSs9Mlg85F7aRZOIZKFuKhBW3Dls8bwGnp2OrZ39Vzrovn/Mhmi7HMhiaCbcOQwGyLMwBpUa3BD+njzRWMQNAup8ol6tsTMlvQUKP1QXSamZqwjfWmI6XWEM+NgUGuGDBMr/kzFhb82yoLGjHFUqzbaaL2AfuocK+DdAvyxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciTIDkDA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciTIDkDA"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso392499566b.2
        for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 12:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740773793; x=1741378593; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVAkTZii1Gy4XRugZsnKaWDIV+1UdUIxS1E1wVQkwnU=;
        b=ciTIDkDAg9DzJPlr/KuOZKdopGjqFobLhU9cpdwzKjG3GB/AcfMX0qTXoRjGZrPebh
         +bpR/aFRU3cUwUv7v/IvYId7snaJPKBpAq01QNCsxo9mGI4Sdn7p0Q7T/peBBW6htHmz
         cwrUi7hy5qjdI8nuS0kBpbqPWax7rt5BkrO23jg9JNCDNtyxCGOGTv+7VanBZKh4Eow5
         0by5ROsAJf7sNIOAqslnA1WV8+Hhp3U0OlQiNSZtQDMjao691FhgkZJLL4otHiQzxzb+
         5Z9NGs585il0CnTtVu+JIHOa/Tu3UdWrtaDInRZ4mmfPRqf8lOM+MRfZrQRkL75Ncd9F
         X8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773793; x=1741378593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVAkTZii1Gy4XRugZsnKaWDIV+1UdUIxS1E1wVQkwnU=;
        b=WpRiO8lRv6T8mBgs5d1qpdG6U0Q71vG0NG+IjHvfyTGyBLkw81vR8OZTtoyKlyU7Yd
         JAZUffIGDRe0aptadRVZBWVr6sJ1/RQ8KA1HcpNrw8kOfu/dy8EaqGnJJR+LomJZsAbu
         p5ZgRIGMa6KVVCthxwozQKhchkMRVk1P1iq14LgggFt0Czcqid6C1S465UK5WSSr/Zo9
         JclnarfgSVzDIv93dJpZKAotGFaVmsKU9vWr4NPoWB6N6cgvceiLbEAdppH6RxXt4TkJ
         S3LhyJguQrnPgXB2f3v6m+1tzprDjTmrXgYAFKl0P4HVQhdAIxXZHMPRkAgBXf7PwVYQ
         zyzg==
X-Forwarded-Encrypted: i=1; AJvYcCWvQdF3BOFMw0eRZIONSuUuOBdxS2YNNpf4SxxAOnFi5YV3Hu80oDXIJ1Aqh85Bs5X804tJdBc=@lists.linux.dev
X-Gm-Message-State: AOJu0YysY70C3j6Z1Hs7gV59UDXbKK6SdUHvPB5NNKmd4qtoG4fZNhC7
	T1ThwxoAFe7rs/Cl99ElSj/hwEHr+K5Pl6dqOippOGc1gRo1xLza
X-Gm-Gg: ASbGncvZfEyNa60rn0xcbPTSIBtAQmp0cs7WNAklMvnld66K3XktzWnCx37FY291Ept
	FnvgpuDKM57ZhHpOBJBAHPTpskQYvIGWyoKZvuHCJmje4CHPexHmJXxndh8FfYRBq0dEcSTmwi1
	8KWdd/iTpON4OdaIq9XsA3Di5Z7niF00IqOnz5Uhj3ii48fBmHmDkaGOYbERskwp5/M7EHTITeh
	q8QtUUFRGqP1uOTC6cmeD5oEYo3Ki2H/2yrt/JvuIyZ+iBGiHVBvWt/z24jiBuSZukv83HVlfp0
	1uHfByKmjJlR+f0Ifyoj9YtU85q3k1RCRLUM6Tq7IENKtk3cy+chFYjiKkdIBuN01fuou6DhwlO
	jyUHNDcTFGxU1IejfCE4pqrnjSNr8C7l8dgOBJGTiY7QRF+/AG7lBYCKnKJsRlw==
X-Google-Smtp-Source: AGHT+IHTNHcim7XN7hH9c7Sh5FIEX168d0fQlddgi57248KaGuR3JKO3W8QVJ0D+qGDqKD6MfYoZMQ==
X-Received: by 2002:a17:907:6d04:b0:abc:29e3:f453 with SMTP id a640c23a62f3a-abf261f2fd0mr480274566b.33.1740773793400;
        Fri, 28 Feb 2025 12:16:33 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm340812666b.136.2025.02.28.12.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:16:32 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
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
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v8 net-next 12/15] netfilter: nft_flow_offload: No ingress_vlan forward info for dsa user port
Date: Fri, 28 Feb 2025 21:15:30 +0100
Message-ID: <20250228201533.23836-13-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228201533.23836-1-ericwouds@gmail.com>
References: <20250228201533.23836-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bitfield info->ingress_vlans and corresponding vlan encap are used for
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

