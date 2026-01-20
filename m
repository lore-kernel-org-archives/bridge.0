Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1257F3D525F
	for <bridge@lists.linux.dev>; Tue, 20 Jan 2026 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900973; cv=none; b=pAMj2Xqbfr9jfNEODHonB1TwnBxeGfQyMe+JYy6pu7tQCEcoqEIkSu3cxQ5zeai4YwMDKmme+eT9Q7wXDYRUgAhaYqBj9Gsb+oPJeqN1NRimSBNLfrrZeQdwIBZGTKpqYgwaN2/lEi8wK5jdWDC3k+WWH2vaC828UnT2l6f9Thc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900973; c=relaxed/simple;
	bh=LFXvvsnSHomS3qAx5n0cKtlDgaxDB0LHfzSintTiwXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hqm1yaLHLg+LiJnH5EJvlhEayRUNY5gPqknzbbBNYqs4dxWxOMFOIw1ngQuG3h+VGjBQhMU6VxCTFERdGnI2WJW7SFS5XiQ1cY5DG2BxIIjLjztl0NqfL59sDk6IEBYnIymS2BJNxoJFE+iVZI6rXZXDXOelJE1uGxNl5j8THSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+Zr0x1r; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+Zr0x1r"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0fe77d141so33861595ad.1
        for <bridge@lists.linux.dev>; Tue, 20 Jan 2026 01:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768900971; x=1769505771; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a8I7+iCrEMhwpiceFoy5kG8jHorqo1UmmUWGOAZBtw=;
        b=c+Zr0x1rByyu5AhyI1WXJgpzq+tcUrJbysvFw9yseS6aEe2WZBrFa0YbbOTKNNBHjz
         oqjpuxGKF+cd7dZ93fuVJ+xrDD3p+unzm8f9BcDkv0Ig22hGLz0aicWzrgqt5rtQN8Gw
         3Qcgtnn+n2U/OxPcbbEXaDzUa10YdZvuQ6DWdKgVccGT3sihogltlOsK06HCNQdXQfkD
         pp4iSyf77g6XbzQDTAZ997069e+aGc2zhYmyBf5vB2faJ8aJUzxrbUQu1vfrX7fEMK+n
         gn91SbzO4PpgiKtVBHi2zOUSiqXaB9Fz0hM6Vsg5LMxnhxIkbho5p+/kFMSOVDKCNsuO
         cBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900971; x=1769505771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7a8I7+iCrEMhwpiceFoy5kG8jHorqo1UmmUWGOAZBtw=;
        b=hfbgdBVoE5M3dgoEzbb/8kfeMa4MfzggxWzQZnKtKUD0JtLKh+8xmVREHIRIPz6tzi
         JYQ8Lyu3RTmdllQe9ZBZYdIdiQiNjZNGpbDVGAbL53/68ZkN5zlOmgmE3h30QdOAwH7r
         lR3upNBauxzFmnd1DPsk43ir9Ox7WqsYazVnWcno1sx+sPAdE8QiYRAJuwOQCT5HQ9Pt
         p7CMp+CDJyioGrtBHNggjbUnWru9vXrkDJpq4/XffksQGZx+B/xe1xGfI4sy1Jz3mtqI
         pzDgaC0FtwuQ2L6XgshKHXremZqzI03vrXV5vXxZbEGGxzE+OY9hFTrXdTMUajkNRrld
         aVCw==
X-Forwarded-Encrypted: i=1; AJvYcCWgoF7Rvw1tURafDukr4K4U97GDAmwRs878B7PWCRMAx63HBHawpXQnCPG4s0e1Rq/UVllvINM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxrcFPa0WI0YEpJd1wq0HqUYJbuFT8pIOnFQpewg3wytBC0QO56
	zl/BrIKiifCWBqwkzg4bYSkXjkgcX5I1pA7/Ybj9c3TSY65Wpz83thlO
X-Gm-Gg: AZuq6aL9oTh2QwG19X1jQWVvIf80mXMBNjAQO75me8IPnUDqQ+E7f0ZHR+6BwgqnSp5
	mbq2IXiMZPJg8WWkGopUczCl4hi638PdkVXdH2XSPFx4jTMLFHLvNUX2/eaDrlK6rqwJp6DdWsQ
	e2xAaHWEIcMfuamyTw6ILX7nJTLkcJXSuUexZZgmrPzGFUJjRR1Bx5KLY9XZSObKjc/FkIWVQpv
	yQeTHzmUTF+RvXLjQfnc6Q5B04Uy8IBnehunbAjfq/jEMEyL/VGGJtA4q65BYmrUOqAxhufZzWY
	99BezZspN5yJ/Ss6GFyp89QRHBzVUJTJx/EYEeoRFq9lhjpjIzbSpubjpDn2WbnLl9HE2GZaxN3
	nyJyyPOU8vryG/fLWvKiIrrH4HPd7DE5bk5lGPtHvIgh83PZ2feXNw8TZvdc2lETYYSiqm5Fb0S
	4bRmvJW4WZO6f59QVC86d6lIv5FF4LTxlVpkW2ASa6lEsFstxgE8/Vsg==
X-Received: by 2002:a17:903:948:b0:2a1:10f6:3c1 with SMTP id d9443c01a7336-2a717551dd1mr133844815ad.26.1768900970966;
        Tue, 20 Jan 2026 01:22:50 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412d38sm107330435ad.87.2026.01.20.01.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:22:50 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/4] net: bridge: mcast: fix memcpy with u64_stats
Date: Tue, 20 Jan 2026 17:21:30 +0800
Message-ID: <20260120092137.2161162-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120092137.2161162-1-mmyangfl@gmail.com>
References: <20260120092137.2161162-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. memcpy() should not be considered atomic
against u64 values. Use u64_stats_copy() instead.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/bridge/br_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index d55a4ab87837..dccae08b4f4c 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -5201,7 +5201,7 @@ void br_multicast_get_stats(const struct net_bridge *br,
 
 		do {
 			start = u64_stats_fetch_begin(&cpu_stats->syncp);
-			memcpy(&temp, &cpu_stats->mstats, sizeof(temp));
+			u64_stats_copy(&temp, &cpu_stats->mstats, sizeof(temp));
 		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
 
 		mcast_stats_add_dir(tdst.igmp_v1queries, temp.igmp_v1queries);
-- 
2.51.0

