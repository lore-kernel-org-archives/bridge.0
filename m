Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6681141A51A
	for <bridge@lists.linux.dev>; Thu, 23 Jul 2026 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825598; cv=none; b=u9n2nDjP3BjJu2CyhX2KaG6fLZHPWXua9FTVVTZfSMnwvjOvR4Wz+CQaM6EZPEMKafIrVk/um19WXXgB7w476TGRpUkDpzZB8DAkCUoXuaOvM0iveOsG8ZE57hEeh1RYI+geGVdtG8CQhmMiOtdAo4CcrcYGUR8+KRhzw/XSMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825598; c=relaxed/simple;
	bh=+mDKO1rx0runoo7oNOwRjWDzhZlf5nu84Yus3Ia7IA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ig7RqbkDrU6xPFAJOIGhIH3pIJGjQzDABSjvBxWbAUrNWtO6c5MK4xIke4TS9/jUkbpc6jjy/EGHnpVxkHnpq3WMmMAyhyKFTAbtj/tRZkUBACmMl7BK6Zac2+ZkX/xT6ar9iEe1j450L/2aomF/AuKyBqJV6yCXXcrCZqH/4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDhtNulN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDhtNulN"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ceab75934dso11089205ad.2
        for <bridge@lists.linux.dev>; Thu, 23 Jul 2026 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784825597; x=1785430397; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YeAlIdZbh+V3dTOyvaFAooLwnZ0f3U57iLEtHBzssEU=;
        b=TDhtNulN90fA1nzp3ORAmIC+vCitZaYKK4C9k3mhiKAS6h4pMQz58Gp1RBS/YYj+5O
         aU9076CF/9DkYDARAgqgbnJX9lWmWeGPZVnw+3XHFFgL0lQ+qjkSqt+yQxDh0CHDZFsr
         NPISl9o946zmNaDRCgk3IuXLgrIlsr/MAMm/wmMKUXQGRnAi6vRYhZJ4IBlZQn5FZJs1
         MJ6kV8Lmfmp+cWa4LcJpSvf8LUlR36WnWz7aAimUHR0vZPikOx09yw8nwkjDcL68fSqA
         bylNvOVUgiZ2bgnoQS1JBxt99PD/mKUvMveinfkst25UGvpSTN8/oX5njWls4jmusVWT
         FKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825597; x=1785430397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YeAlIdZbh+V3dTOyvaFAooLwnZ0f3U57iLEtHBzssEU=;
        b=FL3VjqgHsWctTNZgZHbJmXul9Kc8M7kwOmgDebSrjRwF6FoZgZgR7FKA+s/gN3Kl6z
         KXhym0tHXnDNl9W6afR4I7idrhjDBHLHrWdEoJhoMjzZLjmaDzboFdia+/tPTMZcni7y
         RIzTLIXMj4HFS+89xOshW9AmaKBsf9KUyafH5nsPWYWsuhYOZZdo6Qi2Cc5pa4/ff3Dc
         /ODiRJYj6PUgUwEG8RkPn38GBMmI1pbO27wxaz7qGbJuyBSpbRqPYv0/XCe9BZSVBBYt
         h/iF9YGbsvLY65ZXiqhJ2Ldnjxsvbmc9FIjAg10Y75q20HBS7gEh6GNlZ56js+znZdRl
         TRIg==
X-Gm-Message-State: AOJu0Yz5XeAwoqU6q6fuAYe+jxaB9uOsLeiYeG2OW8ORZ1w39I9F/LUV
	2sanjBP9VvrdsXuL2V0b0XLD2mKAe7EyNgCy0MRnO2hltUpyN1GbebEzcALP93oYK0s=
X-Gm-Gg: AR+sD12kftw+CXBF1WbxwiN749vsz7saY3HMR4HUw8fZDqDE8IQXsfIBDE0AjgfoG5u
	0GzvkKfyYwOgstHFUGUTiFIpBfKNu3uA3NOATb7n7T0qitqmGIl8XpnCl1yH9tb1zMruGO0edVN
	Vfmjdq+K4RYaA4ToQTuT9gECyo0y2ocKUb8pj3mCM1lDhOGLsjRtA7/dQdfEB1GAk9WvYjhuAPQ
	2r1ou4X30EKsBxdgeFtp9P9nDeSblZIJMRbiJoLjhHIaPNPFNm+4NshtygDwnWNpumFnZcZjbZM
	ZGGDuqjNMbyOI2WwXO2E6RD5KJIDbxt6X5PabOGsvJnbay2gHgIouv29P1sAt940fyZxL0jzlEK
	wmLcumCwnKaZh4EL/n0wjqsCzRGKw3JwmTJUfRrJbnXa0b/I5o+bkVgK5eYeZmfCsBdFt9BDfBm
	M26PLmaPcL7Z0OIrKscPA=
X-Received: by 2002:a17:902:da85:b0:2cf:b066:7de2 with SMTP id d9443c01a7336-2cfb0667f61mr24881135ad.22.1784825596527;
        Thu, 23 Jul 2026 09:53:16 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e5e9bsm36926435ad.50.2026.07.23.09.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:53:16 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	nbd@nbd.name,
	linus.luessing@c0d3.blue,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] net: bridge: stop fast-leave after deleting a port group
Date: Fri, 24 Jul 2026 00:52:48 +0800
Message-ID: <1cf0898872ef7c72d5f4c0304414a192c6dac591.1784707712.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784707712.git.zhilinz@nebusec.ai>
References: <cover.1784707712.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

br_multicast_leave_group() iterates mp->ports with pp = &p->next in
its fast-leave path. After br_multicast_del_pg() removes p,
continuing the loop advances pp through the deleted entry.

If multicast-to-unicast was enabled, the bridge can hold multiple port
groups for the same port and group with different source MAC
addresses. Once multicast-to-unicast is disabled,
br_port_group_equal() matches those entries by port only. A fast leave
can then delete one entry and continue from its stale next pointer,
leaving mp->ports pointing at a deleted port group.

Fast leave only needs to remove one matching port group. Break after
br_multicast_del_pg() so the loop stops before dereferencing the
removed entry.

Fixes: 6db6f0eae605 ("bridge: multicast to unicast")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/bridge/br_multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 6b3ac473fd22..00aa9b2879d6 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3687,6 +3687,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
 
 			p->flags |= MDB_PG_FLAGS_FAST_LEAVE;
 			br_multicast_del_pg(mp, p, pp);
+			break;
 		}
 		goto out;
 	}
-- 
2.43.0

