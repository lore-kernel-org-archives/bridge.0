Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA8430E83E
	for <bridge@lists.linux.dev>; Fri, 23 Jan 2026 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185356; cv=none; b=M9/uSePJvv/S1vukx40/CrSAvcNaefW3K0tTw96HC945ZztVyYCpbHzgRIdCMB7n+6DodSTAk41XB8/UZOfdRDDIIWurJDLQ0INjQD7CzrNx+wVe7GXrrQ7EYJ6x67qry4eMzvWMDV5qF5u2KE2nqPb7uNkpATSInf4nMXHQgt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185356; c=relaxed/simple;
	bh=fuHJNs9q0jub17ekWOOL9sffjn3h+K2Q6gGWIFoNBxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhB0FBP0pFq55+IM/8nUFvEBkB5J3STj9+uuqBaijsfI4VBDrOxXWKSXv6mFGpnzd7YonTnE9POQ/w/vK8n4J1AmG/0BNhJ4ZRTDk3ZsMAIBn39463bv+b/t7cBYpD82D+e8grawYuR2OR943zojS0D5V8sfXwFN+l0aEPD13N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ofx32OfR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ofx32OfR"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8230c33f477so1021608b3a.2
        for <bridge@lists.linux.dev>; Fri, 23 Jan 2026 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769185355; x=1769790155; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjJ7CPS5/DqUp4cokLUu32N2BVEoOZUcO8cPBS5b2w8=;
        b=Ofx32OfRi/i2vrGMbSMq2hMmmIsV8isOvy1+Qgbh6/4FvWiVBnDqTWRxiGn+dCywiK
         KBIG4pXk3+nclPuhlYURbiTctu3oNXRK/RDUnt5nAOSvZeMg9hGVlQ124ZOtlAWAHtlO
         JY1LSN5OOy3gg6t9KIRRdHJ4UA5vVMgfwcCba4eQhD7hqw19mf07yOzJQI85SJrpw3Lc
         fx8fX0LnIl+fc86OjdXxe2xeEhHZpdK2H1qHZOT4oiNN08KQUVqKVjFRfJ7bLZX06b7O
         yfoEyWt7mLivF87sCrZDeNKblzCChC8IQ5AoT1gIK+z+ppjWOdrUN8cYAKAeJvRpWNuz
         ckmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185355; x=1769790155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZjJ7CPS5/DqUp4cokLUu32N2BVEoOZUcO8cPBS5b2w8=;
        b=E/i107bUE8P+CJV0PdSs1WOca2uY13JPUulNVG/6tsGTBdFdZE7rVRzfWNBO85Six8
         V8AYAY9j138LifGLb9G8XvFGdbrA2PUXwnUIRoCCgTyVxqyaonFtD35qDBxSjpcY66bI
         xoaT5iXXBYLXyME3EcuYHE61sEWo9b60psbzjI2pxzaWlMCdoSVWHDcgbhoEMuluWF2z
         LSNLH4/RdQtwt59s2sRMrJvWus343sZ3YGo6Rhg7QTtD112VpSgSJWvSIPjkOkrso0HL
         iBBzeA2eaibHE2JMPE2RfDFvyED/0m7HlSrG6S8qAmj3NZfEQCzPMQPFqgp0/lf/6rA1
         R/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWX5ayXMva++tF3HEJNi0mojWtGQ1LZySqjyTpGkXL1y+R610KsRxqaBlnZQP0LSH66hAYSU9Q=@lists.linux.dev
X-Gm-Message-State: AOJu0YzQKO1aU3IG9e1V3C8j1QV1WUCUpYGe9zZPeJ8DpoJzBI/ZwbuS
	Ldj+OpxmxLg5chcM68PwhjYY+fOG3LZCXwfB0Dms/bsdKQLuVcAtYaWX
X-Gm-Gg: AZuq6aJCKmCbmpZ1udtoQ9O4sVe8SK9c8G5N9xvL92YaHsjbwJMSQNfIeYlGj3JXryd
	265nZQXH1wXbzjB1W21yf61NYX1M4iOIt+iQqTWTljilMOkcGJtHaDpv3P/2FEg6RBNDXrZtl4q
	OZMpEBOOGe3mIElOS1PJUfcw1/Bw6fTY7laXOjPxeHQCTu6PK9flxef/sbitXpPv5f5QN2plkGG
	nclrfJfpG47r7oGif96v7/OomUSAHSu3Yqyzzmbn2Gb/4BsI7974y6gbuf7cWqeVyp05JK3mEf0
	x/gsAbBiwkjA0fwM0tfw1DOBc+DuXJhcj4VQ7BJfjp/xkavrSRKJxiB2V3Pn4Ybpn2y0ln1hn6t
	tA+SjZ6tsHpy52TJBAXcPuD7BqD3syk0RLHOfoThZJ8fAvsofFCsuMZafoQUIKoV+i5Zp7rjc6+
	hcO7U8IUNBv5xwlN8f8MhIVL8GMHDFI1JASXLzxAtpNmkkOEoyvDPkzA==
X-Received: by 2002:a17:90b:3c06:b0:353:49f2:1e7c with SMTP id 98e67ed59e1d1-3537b272a3cmr1132136a91.30.1769185354648;
        Fri, 23 Jan 2026 08:22:34 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc50882sm2496967a91.16.2026.01.23.08.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:22:34 -0800 (PST)
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
Subject: [PATCH net-next v2 3/7] net: bridge: mcast: fix memcpy with u64_stats
Date: Sat, 24 Jan 2026 00:21:35 +0800
Message-ID: <20260123162159.2877941-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123162159.2877941-1-mmyangfl@gmail.com>
References: <20260123162159.2877941-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. memcpy() should not be considered tear-free.
Use u64_stats_reads() instead.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/bridge/br_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index d55a4ab87837..0f8e15b4fa60 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -5201,7 +5201,7 @@ void br_multicast_get_stats(const struct net_bridge *br,
 
 		do {
 			start = u64_stats_fetch_begin(&cpu_stats->syncp);
-			memcpy(&temp, &cpu_stats->mstats, sizeof(temp));
+			u64_stats_reads(&temp, &cpu_stats->mstats, sizeof(temp));
 		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
 
 		mcast_stats_add_dir(tdst.igmp_v1queries, temp.igmp_v1queries);
-- 
2.51.0

