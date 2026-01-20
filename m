Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145C3D34A4
	for <bridge@lists.linux.dev>; Tue, 20 Jan 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900969; cv=none; b=l9r80ljKol4aG1fqzuJStuQO62vKUAR3HzaAww8tUJ5+qdzUkQaJ4RIs8oaxU+PMQZSKkUhnwM5d7VXpofZSFNCD9aPmxWT7S7eNTBEb8lcTTfKsp9blOmcJzkZMh/D6YFZaTZA4xNX1xpGrdQs+BX4IFqlRAus7ythQ2bY6eG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900969; c=relaxed/simple;
	bh=aXepxHEM+bUanCG6M2YQkdGsjdUrPkO4BtQqkZ7jSTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcP7UkTwuNcIMfY2EIK3ni6upSmbuKg8sKKebA1OtxTVyYQVV6dClG6j8ojFKO+XWmk5CY1sK1P5ZYWkgtHb5a2o7FRUVC11mm58f5UQOvruT3irWQsTUKpZ+nvPC1pf1QocMs2ZnZiz5y6nNy8JlQ5CVrk49Wlt1/hvEBHPBb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ph5EsCJa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph5EsCJa"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a1022dda33so31783645ad.2
        for <bridge@lists.linux.dev>; Tue, 20 Jan 2026 01:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768900967; x=1769505767; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vCyzApzHRVDFWMwd6G0sX6h4LUY1dkAl+mfLdsoDQo=;
        b=Ph5EsCJaLeMZx6fdRrAweN2N2iKs+S5tJm2OhANtQyKJxHu3IFs0/44pdPAPN2vCJV
         lFWv4kKm3dRxyEQP9x7s9RxbFNgIY3Cx4kFQkH9mI5U0U1T8pNd4eHIYjndR3pH4p6gK
         os0kMfGEzRTrwJu8D1TLxoX96bVdaLwUa0qZO7sT0iklm8gxN56wlBccP39CdmtYG+rI
         6zjfA4l1hbMWI4CVRvzeImDf3FjgJ3PNbpB2+rIYlO+LLp1B8zbiE9P1JqQOQQLb43rj
         d0snD858i/DLbH9/8KZrGQX4cf1JHxM0neJ7wWK0pqmUZAzDfhPhPznxxsUGn+fxEuh1
         W5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900967; x=1769505767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9vCyzApzHRVDFWMwd6G0sX6h4LUY1dkAl+mfLdsoDQo=;
        b=wuzSUa0ee2tsZDUr2rQ8FUVvZn66VGDxJCcCerihk4B52oi0XEju7pnBkWAwkskQSG
         ez+nFvi+NYM0isSlGZIKLrLEm5Fa+XLcWXTqJyezhSuHgE3kPQ1Sh/1+yBJPs0ehLaJE
         1YPNfEOrXLzURe1mWAL2zJ7FTzkWGT0HuXKaRcpBynuJFAtYGZ2Zip4Rjq3Je4K+4vMu
         IQ5/qFWKeQDI4sdptsy/5e/c8QcDpJenvBeBTn86GnqbzyGbnr+uCNMkk198qIcip3cC
         ElMisXdzk8Sy2nks5a/QabgbMY7xUOqJCvb+237pZ+TGVWPmNMJZ/w+WhUYqMlDKNal4
         UqIg==
X-Forwarded-Encrypted: i=1; AJvYcCV1a0SAPc5bxfUnTh9X+n5iBgbY+zIM1r3AsDUAh8odH/vr7thCb3b9Eq6Ow/gH2lM2fNm4Jlw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5oR60SefSIkW3ZmMV9DemNKM1wHoeKKW7DxDRvLtciIFLJ+UC
	5KxWjQeG0Cyes+flKnoltwa1pqLHxOqrAxChVTiXVf/NdXc4RulgwWAH
X-Gm-Gg: AZuq6aI7UlAbiYX9d9ZdDhnJOSi/N3MOWmwpyJpHsQ0+7HMMQZkUn1u/E+/sJnP/04f
	nISvfls2kGDOLsLMpV+3ECrAuXF714DtP0KuXpFuVSui8bVxw4fafWfPk5gmDWt7elcCoBVMFF4
	ZNGtS/AA2aUlveYea0515hkMKeK6ba/zUCqvL1vRzxGb+/jxc7R2/xcNCfR/LfMZKDy46sCfsFo
	PVG4uYkhqKOxfX6dp3n68CYsgJ9M4wlQOpgQXJ+D7KxRwr6nHiBUQfhXsZXWtfgl8EJ8Px709wz
	6SRyGHc9GXjs8KUCJZ3YRiq9Yc3SH8zt9a374g1tRdTmRor790MpLaiCh1tieTF6x7Tm19hQ2/q
	ZfofFJZqMS9hUUWi2BIbm4ZLv1LF4K0Z6I4tnr0cWI8JGRfC7ZpmimYiC8Hw52T7RpqfGxnuK0y
	VV0doOQ9KvBrXafLjQ88pYLSj/c7QDV+9OS5OnH2+InMkjet3P1cg5PA==
X-Received: by 2002:a17:903:13ce:b0:297:c048:fb60 with SMTP id d9443c01a7336-2a76a389391mr13454865ad.25.1768900966610;
        Tue, 20 Jan 2026 01:22:46 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412d38sm107330435ad.87.2026.01.20.01.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:22:46 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Carolina Jubran <cjubran@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Shigeru Yoshida <syoshida@redhat.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: [PATCH net-next 1/4] u64_stats: Introduce u64_stats_copy()
Date: Tue, 20 Jan 2026 17:21:29 +0800
Message-ID: <20260120092137.2161162-2-mmyangfl@gmail.com>
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

The following (anti-)pattern was observed in the code tree:

        do {
                start = u64_stats_fetch_begin(&pstats->syncp);
                memcpy(&temp, &pstats->stats, sizeof(temp));
        } while (u64_stats_fetch_retry(&pstats->syncp, start));

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing, especially for memcpy(), for which arches may
provide their highly-optimized implements.

In theory the affected code should convert to u64_stats_t, or use
READ_ONCE()/WRITE_ONCE() properly.

However since there are needs to copy chunks of statistics, instead of
writing loops at random places, we provide a safe memcpy() variant for
u64_stats.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/linux/u64_stats_sync.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 457879938fc1..849ff6e159c6 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -79,6 +79,14 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
 	return local64_read(&p->v);
 }
 
+static inline void *u64_stats_copy(void *dst, const void *src, size_t len)
+{
+	BUILD_BUG_ON(len % sizeof(u64_stats_t));
+	for (size_t i = 0; i < len / sizeof(u64_stats_t); i++)
+		((u64 *)dst)[i] = local64_read(&((local64_t *)src)[i]);
+	return dst;
+}
+
 static inline void u64_stats_set(u64_stats_t *p, u64 val)
 {
 	local64_set(&p->v, val);
@@ -110,6 +118,7 @@ static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
 }
 
 #else /* 64 bit */
+#include <linux/string.h>
 
 typedef struct {
 	u64		v;
@@ -120,6 +129,12 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
 	return p->v;
 }
 
+static inline void *u64_stats_copy(void *dst, const void *src, size_t len)
+{
+	BUILD_BUG_ON(len % sizeof(u64_stats_t));
+	return memcpy(dst, src, len);
+}
+
 static inline void u64_stats_set(u64_stats_t *p, u64 val)
 {
 	p->v = val;
-- 
2.51.0

