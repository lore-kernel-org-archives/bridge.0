Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF826C3AE
	for <bridge@lists.linux.dev>; Fri, 23 Jan 2026 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185345; cv=none; b=Y5sE/Okdxoc3mX/T43buE+alXnRQxZD4eQE4uDljgTRqoOV6GsTgcKgueyNmwedL/PARBM4ikKnRPfB7sdOMS/H2tHN7i/qBSx77/W/WJ6ji6VVABq9VVYPSjYplPIHe8F/etXghdpEqTwgH7zGOHJ30F3AbxSy64t0T2FTPVAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185345; c=relaxed/simple;
	bh=w5MIfnlIHaBZE9Sx+nDab+c35nSGwa8xj0TFBnbl3RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrAcNgkyaluss/Nz6a8dGQxY2x5xy7lewCm8I6mHNAg1QvhACwz06xI9cSGJQ9ANMaYZZAMO87JqNCqJNAHOFDbgPPFoOtudPg6wo8Y+AzLefTtuWjFb19CAe0i89FkR66wozFU14A3RgLpfTHgj5wuCHBe2dAbfXJP4ZTf5HEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSZqohpA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSZqohpA"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-352ccc61658so1127059a91.0
        for <bridge@lists.linux.dev>; Fri, 23 Jan 2026 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769185343; x=1769790143; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1hAVBooT6RSatSb0JkTTI9JelC7CFfOn3FnTuarbB4=;
        b=aSZqohpALhcUzozdjTOVMrFNgUrJfx+ax5iNeRwIgd3n6izyhA5Hq1/S8OfCVRWSvk
         NR/HAu87Eo0g6tKfyJkMMM3wV/CumvH+2D4QL6g4EmrSkn5/bkAimUPYi8ELtmpduFns
         qyICfDAt6sa2y/A2wZ7pANo8rFKsty6wQ1XQaLAm2jPAjIaP2U3fIuQlzNPOxp9OMCyZ
         1GBE20qSkCOya2XeU+9efknFuRbElGXkpTVvYbUL7+1VqZI0cqr5i6svx6vIsFUlkS/c
         XlNlnS/dX+6eTYl/yTjtMcqM4YYyc+9lWEHoVW6327i8NLt0QmDcyBG2UtTX53G11BjL
         aYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185343; x=1769790143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j1hAVBooT6RSatSb0JkTTI9JelC7CFfOn3FnTuarbB4=;
        b=dPZ1O2e3f5FUG+df2OHZeK7k6jOUu+pfOmdcMZd2LrJ0RjfjqAL9FnsAZCcHArmEXP
         G4HYs19/u0C7MgknbKCaZdSbcmKbAYzCasOaFCUw8XinS1hpf5mFybh15bnme/c4TqaA
         GUfZ1sBcY7wYoNPIhqgv+ZTccZBS8a6e+919dcoN4OtkOuNIOEfHo9nyVwkCRPS+kpsl
         TrPyiYlKymWsF83gmAujbf5H80BtTqKlffP97DAzIXMI+jrsNdLI20ssNlTl7zyuv1L4
         0xWtvWIoaGTlHBzLd8QhygD2Pw5gs/KAdZUrX/PXM3CpONxCWrT8IFQ/zculV4QQ6ZQC
         SrRw==
X-Forwarded-Encrypted: i=1; AJvYcCWuSBsonsBSp3DeDoYSOlCzJ+RPHPceunrVej158O2OI0/7M+pGy/q5mM7c+qSOO0B3EKR2lzA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+DNm9pj4KL6oBhCl2FL0bCtan8gEkybOiWNEmBVQhC71keFGx
	GaF+ExdShVMBjOhWDk1/6HmkJMdRW5rkcDb0RXCCe6AogMQf0Vz7khgZ
X-Gm-Gg: AZuq6aIP1RF1TJT0s3WgqIrmgQ/7/CMEDzDNSwv8deQQxTz0hoT7vNfPfPLgrU+MMj+
	vE3MtUpJ0Dxc1SLXBCfHgcDBMKD12HkteGQIGfH1W1oXs77EkLR/jbohpcrjgze/H9qm3IZvyqX
	0LXIHiZb4bIfOKFMPR+rkk0q9KLeyK4lSlJh/FV+NWhCAhgTfAb27pAQmJK8OG/pvLU3WxdGJYf
	tOYiEFiYTAaHDZpfF7n1KLAgiqn3gzeNZa56cycupfeWqRbm8yDRJGBJG3mGU7TgUdjEkYV71D4
	1W3wgaZUhVR3GxfcY0DpA0G7hxw3nBsFf8BLgvAz8DNZ8wf6VyqeTZxYGPltD27iL73sfJLYOiP
	0Dbg6piTMBaUPNnzrHKjYP8GmZoJfGzwjj5g+ZEnnjkq+TDCRAIA6yN2WPPyY9+ckZS6pgm4RT8
	GlHv6sU2BHnmUpxrrYICDy1AdzqNk3u6F98+hbVyr+GJZ42i0hwFV7LA==
X-Received: by 2002:a17:90b:2244:b0:349:3fe8:170d with SMTP id 98e67ed59e1d1-35378ba82b6mr1242634a91.3.1769185342968;
        Fri, 23 Jan 2026 08:22:22 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc50882sm2496967a91.16.2026.01.23.08.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:22:22 -0800 (PST)
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
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Breno Leitao <leitao@debian.org>,
	Carolina Jubran <cjubran@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	dev@openvswitch.org
Subject: [PATCH net-next v2 1/7] u64_stats: Introduce u64_stats_reads()
Date: Sat, 24 Jan 2026 00:21:33 +0800
Message-ID: <20260123162159.2877941-2-mmyangfl@gmail.com>
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

The following pattern was observed in the code tree:

        do {
                start = u64_stats_fetch_begin(&pstats->syncp);
                memcpy(&temp, &pstats->stats, sizeof(temp));
        } while (u64_stats_fetch_retry(&pstats->syncp, start));

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. memcpy() or struct copying does not
guarantee tear free, although compilers never generate such instructions
in practice.

Theoretically the affected code should convert to u64_stats_t, or use
atomic operations properly.

However since there are needs to copy chunks of statistics, instead of
writing loops everywhere, we provide a safe memcpy() variant for that
purpose.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/linux/u64_stats_sync.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 457879938fc1..15ea4db2a77b 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -79,6 +79,14 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
 	return local64_read(&p->v);
 }
 
+static inline void *u64_stats_reads(void *dst, const void *src, size_t len)
+{
+	BUILD_BUG_ON(len % sizeof(u64_stats_t));
+	for (size_t i = 0; i < len; i += sizeof(u64_stats_t))
+		*(u64 *)(dst + i) = u64_stats_read((const u64_stats_t *)(src + i));
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
 
+static inline void *u64_stats_reads(void *dst, const void *src, size_t len)
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

