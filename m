Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9D323777
	for <bridge@lists.linux.dev>; Sun,  9 Jun 2024 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929441; cv=none; b=JR89nOe5U3aTKAgwGFeUQV/6HKwl1cdgQPm7i9DKfZII9zqQ9bPSutLs/vGrqacms4nQWbLDixYAY3u1KU2H4MqluwaGXHV0+5KUzIDZ+eary00J2qRoq/2reGIsWpK+/FpuOEH0wGQTm3spScyzMG2KGaW6k/xzV1emGJNRiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929441; c=relaxed/simple;
	bh=fS0riV6tx+Ta15aGrODcXuGQx926c7E8BMpciH435MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXigpsSdX+CLn5K+zKE/rKfrLLxLuy/L6v9IyWKAK3Io0wxj3HbvnfyvJc5bMMBV/8LaEEtylB0Eso8iQhMcA7o7GkMxMo6YQE0SWmqgCNcisUmbYNh7ZzKNuQDltWjVF7rjOphvvLL0gh1Je6chE2UC3BXSPcZG19yt5iUKQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=b5U0AL+U; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="b5U0AL+U"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f1dc06298so10422166b.1
        for <bridge@lists.linux.dev>; Sun, 09 Jun 2024 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717929436; x=1718534236; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBg6USOiUCl8/5mG5bszaFohunyM8rngAh7qlwT06Ac=;
        b=b5U0AL+UWurUniH1UTZiGlfg4xhVjtNnYiAIgudz8mZzc4hiyInaqEkgchq6GPZz/L
         rHaIjEpnwGdSWo2GTEtpB73OTdcImbuCmtDJxSupAszimUl8a4EyfiS06EwFhUtePBZF
         +t4kqZALsVsIfjbIqxspNfUavOl7ivCMpYW6T+ZDlUCtW96AmOhTgRTJYRwLCIC21aNT
         qegYbH1OWL0sh6gJfTdv9yJ3lRz2iJtbgNbyY0Lq81Q9RxoBnYBIDvv5W8AusX18YyKW
         DJy7zX1EyZqTu+hfS95jhwuuPsTJENSpUmDSiv+me0MFEFfuOgRhl1XPHFSoOexLUdFS
         Fkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717929436; x=1718534236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBg6USOiUCl8/5mG5bszaFohunyM8rngAh7qlwT06Ac=;
        b=bZVAOFonnNEx8YC0OpmeNo3i8+JbWTnsHqZHtNg/C46W4KcRLg44jIStMFfA/w4ipJ
         3YzMuHsunD8d1GaSAwWKB+Z/6xvhi35dduYHWA54WFVh0mFshN3XByxKruc66AJPXFJp
         1O/0UAMu73pfQVVGL8963C5h6h8VfOxiaTjz3TtE+V8OIKCzmjIFFckbOQPiBYPjeHFs
         alItpRL9+MwHbyAaRM4S/DHYN8qE4vBtlEbsvDC2F6zPPKPeQeQOoF+AzCkdkaXmj4qM
         OfdclNZdpkuQJjhjGI5P/4xDzY+P9DY95Bx4sAPPZi+UYqeNo9tyoAwvdnZRhI8HaovC
         NISA==
X-Forwarded-Encrypted: i=1; AJvYcCWjgG0wep3DSp51pqp+GX4QF7CU1+TOCEEQweC7wzmQYsdYCjHgROmLCbiYa/P4tTpSxSTC1iv09Gnx4dndVEpyDNCz5Hs5
X-Gm-Message-State: AOJu0YzYb0PxJVzVllceAnsZ92rMVQdDiwLALLVRGXZxUtNYg1/ewalk
	6PSVSkEFnPzwYCxxXJb6XtxwZ690/vis/MzQUk2zOtBz3HtS6h5CAj9yDzSipbc=
X-Google-Smtp-Source: AGHT+IGhtjbH8tdBa6Z2trv53b7OLUu7IL/XfWQCQqByhcCcU0iomqhLDFqeo785srCXIa2ATLvf4Q==
X-Received: by 2002:a17:906:298c:b0:a6f:18e6:606e with SMTP id a640c23a62f3a-a6f18e662cemr63630466b.26.1717929435769;
        Sun, 09 Jun 2024 03:37:15 -0700 (PDT)
Received: from dev.. ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef8c01579sm259579966b.155.2024.06.09.03.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 03:37:14 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	kuba@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	syzbot+9bbe2de1bc9d470eb5fe@syzkaller.appspotmail.com
Subject: [PATCH net 2/2] net: bridge: mst: fix suspicious rcu usage in br_mst_set_state
Date: Sun,  9 Jun 2024 13:36:54 +0300
Message-ID: <20240609103654.914987-3-razor@blackwall.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240609103654.914987-1-razor@blackwall.org>
References: <20240609103654.914987-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I converted br_mst_set_state to RCU to avoid a vlan use-after-free
but forgot to change the vlan group dereference helper. Switch to vlan
group RCU deref helper to fix the suspicious rcu usage warning.

Fixes: 3a7c1661ae13 ("net: bridge: mst: fix vlan use-after-free")
Reported-by: syzbot+9bbe2de1bc9d470eb5fe@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9bbe2de1bc9d470eb5fe
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 1de72816b0fb..1820f09ff59c 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -102,7 +102,7 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	int err = 0;
 
 	rcu_read_lock();
-	vg = nbp_vlan_group(p);
+	vg = nbp_vlan_group_rcu(p);
 	if (!vg)
 		goto out;
 
-- 
2.45.1

