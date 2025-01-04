Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD54B1BDA8F
	for <bridge@lists.linux.dev>; Sat,  4 Jan 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995501; cv=none; b=WODyL3b5wgczAyOrSpEys2wH1D9oMcbWxjG6KJX+7GalrVBacJeuj6GJ6QjE4AKkcrUeh132zKQudTQMg26hGwO/TBwvd9EnDUdgX7HhR4azz/gS9jWPqqzxdNS7CIFEqlYfY+d5GTaDCkT8eQLIxs2QE9Z3r12Eb0tH5YOFpmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995501; c=relaxed/simple;
	bh=cjTzwWbCJa7r3TyEGggN4J7HFrp5Bpypfn8vCgGnGtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QX4eOULodiyAOH7uShz81E1OMj0BYHmhQCR8w/DVPwbeK7C9vDH9gL2xe5+v9oZ3NOLLg0m9hSBcgrVvr0IHfmy7Q+Nfyy5pvjD02KPkNiHO2RTOVSVI7UxekPtNiCm41J4tG1m+m5Z361vUmkZPGUYl/Zl9tzk0G5g3sW1CBWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO6vGEZU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO6vGEZU"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21669fd5c7cso185792875ad.3
        for <bridge@lists.linux.dev>; Sat, 04 Jan 2025 04:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995499; x=1736600299; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
        b=fO6vGEZUROQNA9ONzWLA3ZmSvJft8c2aD+D8SfiyiSWOlRBOSwhXUBVsNlyK0fF4QU
         s69flmTuW39KpfO1UPmuK13x35PFP6kJNtgS3ur8QsUUSTyuZU+br4wU1aYHzjoNTH/D
         DEaK3U3riwbzQm01Jw/b64mTwBouc5LvL/Pm1Gi4kPtFejWwfX8ziErp5o/7bcCp65KP
         IWd7aSxigBV0gBRCcDKzJ4WJBvfBSLyjrTYqSjsdfgpOOj5hceAB/YToO6GWrPL50Nnj
         zaXZMA13os3yYNYoMqdNVc0J1Mk4FNPBneNqR9u5XVpUMGnZ+NarZAJkHpw6EYSZPw6x
         JXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995499; x=1736600299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
        b=loTFWTDnuEgcCqYUN9hhARtZVhGpfu+lJe9fiDHUAz2WXzj7FoGV8mWNxkiMIlhrhJ
         eYf/4Ym5/CUZ73SlbJuDPYLpKMvZ2UZQxYHqGRElGKKM5iVqWwqGJC/bmJAU6XQD6N7S
         KmoYU8xFKuiaawzkjJVuq5Tp4KGasQXBtMLVEJEqnbNhscPdof0EtiKptIolUnPXnyEu
         +zD70JqCIagcNubiZOX/SuGPsaAMKn1K1yNC6ylXkVu4KHZfF4UcegfONJHg7dICvqVe
         kWwiU1KVaT8qmk6k2Ej0Gx81a3JLdu5lpgQTgW3g8l34mq1S6lMi+OCZpL9V4BCT4Yr8
         9qzw==
X-Forwarded-Encrypted: i=1; AJvYcCXPJACqGxwIYbNCkP+FjR4p0T24CXfYnqs5u9fH9z8OmFh7EYMpt79z2xwk/YWvrhjCUuwEujY=@lists.linux.dev
X-Gm-Message-State: AOJu0YyzYzUiHTINh0cz0Np417fp5t40sKt8vSOJzXJfc1yfXthng2B0
	QbEtsNX08bmeI+x/+IHdRQKt0ER7anSGABoGLu1L4fv+GH420tJQ
X-Gm-Gg: ASbGncvht5eSQFsMQscqk49B4xtVZ++tvxsJmggaR+chIKaTlIa+2gDigBKxD6S7hL/
	TRFkqHVH5OkP2I7bgI9diqzzXTuNxofzVxWRroOTNXinGFD5p1cNKbiVZGYv0l5aVET7UNqxVtk
	S6Al1xUWdL+WYS/rc7oe7g1itHDdlaP/NDYcMRgnKvhRRzchDeBkk/DBItcHs56eP0cmGSFkew1
	RTFjtvfnDDfd20EOtwoqbklVCYrl0HrXZ5r5TReCDQQqZQ=
X-Google-Smtp-Source: AGHT+IHIkI4kgOvJJQ9O4vOvA6fRMUVnhOi23ydvn4IOYZv1bvM67hPwcmTlhhKLeOZA8Exp/2drag==
X-Received: by 2002:a05:6a20:4394:b0:1e1:b430:19c6 with SMTP id adf61e73a8af0-1e5e04600e3mr77828034637.10.1735995498951;
        Sat, 04 Jan 2025 04:58:18 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:18 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCH net-next v7 04/11] ieee802154: 6lowpan: Use link netns in newlink() of rtnl_link_ops
Date: Sat,  4 Jan 2025 20:57:25 +0800
Message-ID: <20250104125732.17335-5-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
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

