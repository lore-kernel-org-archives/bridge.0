Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694CD47A6B
	for <bridge@lists.linux.dev>; Fri, 23 Jan 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185352; cv=none; b=IY4c1YbMJOkE1/c73vI/mOc0/KYT7l0JFOAi3O1putx2rZTkVZsBxs8DhkfHapc1wcwFcFY85gwELE8KCXVFO2Z5Sn7IiJDwkI8vg4RimWa3nO9zX4kSUP9qa1eOzn3HyZTu7dBjwaHn6mgNGLqWjK1fIXD940WSAHGI9McRfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185352; c=relaxed/simple;
	bh=CWAmd2gDO+bz+iiUcK+EZ5ZuNzlcyN9HRHG8OTxXoro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAMfAZLcVDZyuYvrRTPLsY45YNCg+AhD8nzsZ9geXBj+vmOuJDR48rWgJg5H9m2TBWtfw+mKdWrqYg3/tprsGazxKeoaCCKYqqo/irp2GLaboBtiYt0LEuOHLMWWxj8xog1WT2uQzRJM/jz1U4JcXrFCS8YJG+Zvkt9Dg1ZyYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtAy60Bc; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtAy60Bc"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c2a9a9b43b1so1492220a12.2
        for <bridge@lists.linux.dev>; Fri, 23 Jan 2026 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769185351; x=1769790151; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v74RSchMzcO/nfO8KMHLNyi6DHe8JbEgv9uztbjT94=;
        b=MtAy60BcQNd4SvQ9H+xxK6MVf59Fv7iurU4qitcAIV+bMP7xn35E0+CwDwVKWywJ2A
         K2R/zL6KTfw9YExhP4RFjrIhI7C7nlGbDLncq0AImV30cyWDN2idYmSHlrFwZYiYtlaV
         hGXMsXlAIGPk9ZMF0Zkuhm/NGwoHXqa5LHqoxOLFRZcAbj+WQrEbHMfh+/gpjjsj7Spu
         7p+eT6ezmVZSg0Uggbl4oeIydX83dL6cN6rmWH3hsneewx3tJR0apAgpRePwnKbIpWyL
         BJjKMFTFV9h+MEbPE0ImUCqWGdYF99u8/kZLhCSmJOnYL8YIk4Pol1x3bij25TZ6EkKP
         fGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185351; x=1769790151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/v74RSchMzcO/nfO8KMHLNyi6DHe8JbEgv9uztbjT94=;
        b=uJbKreEraig6v7FZnJuyAwDrmXnskawMjTMZCLzWyBQ0xTTOmvYbiuD3qgFYnf65y2
         g+K2Djt7CCiDInQzMnleiZhtmOMuftPO+w77MzZYl03kW8mu4RRIxzS0LHGosYplGL/8
         6GLUwn0u4+wkUoYaSGlT3eOxcAEOJOH24xdosfs8VeDtR9ezhhnsNGELq9eYqCEzoPOT
         MEcDY8+OAiPZbqpHHXjMCz1SNigmHf+9Vm+cpAcQFN0uJnchxC0MgVMN5YVg4mfs37jJ
         ZAha2i04mpdYemV/ePZ4nPgoCJdG0fhsXn4zODG9jc8HfhVTFw7uK7D+qJQXwo1aHHvY
         H/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ql5TXUWyG+92DLDjuGDdybccULcDmoc10qUZptx1pNmMOFzK/7JbEDjq+oi3L+PxxBmXkc0=@lists.linux.dev
X-Gm-Message-State: AOJu0YyCRyGQc287jzMPdO6x/kXRxNtCcK3gH4aAAvyLcCU1XlobchKf
	4SjcS8qTn5d/6+1A533vC5DSKmpWDNOiuQ87xfjt7/yXFXRF3kiGSg1H
X-Gm-Gg: AZuq6aIdt5OuyF6TsJC2MwzfDkfCFmUtw9zFUZCgstiiQqwWlLNhcY9/GLUC/L7yBBL
	8GaOIztbyjUo7Q+IH99L6eKrDno1TXA8bzm/X7QoB6EHCJkZoIwG39sdaly4+gGK1PNBj5V3idH
	HkU8511YK6It5xVn4lk2/ZBoAgGBvvXheUDk4Ln5et2NcBJoensmnpuAGsKrgk8Ry5acvDFjIm+
	n/QkRuYX0XaMwzu0Uo0Z46xuFWkpQVInTIgAwPAvI0390Va5aGefgwowqNqWpxz4WlckuNmuhw8
	i2kCIVKGxjOdHcWBjoiso+QOATmyrjCF8d26Xj4sao8EKOydXKiSRE5rO47BCRbg9rOKSd9ogvs
	jcfI7kLKP7B4DDVMs+y1PfBawlARfT5XrSU3XYifc+kqIZzs6wEd6qL28kQ3kmTgb5XK8h2dHyA
	twCvEiBJFjsos1rSTobZUaOoh6R+L8ZXQG9u5UK+yQpIoQTXwhr+Oll3ufaYHO+xXW
X-Received: by 2002:a17:90b:548d:b0:353:38b3:dccf with SMTP id 98e67ed59e1d1-353688574f4mr3025512a91.23.1769185350618;
        Fri, 23 Jan 2026 08:22:30 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc50882sm2496967a91.16.2026.01.23.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:22:29 -0800 (PST)
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
Subject: [PATCH net-next v2 2/7] u64_stats: Doc incorrect usage with plain variables
Date: Sat, 24 Jan 2026 00:21:34 +0800
Message-ID: <20260123162159.2877941-3-mmyangfl@gmail.com>
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

On 64-bit architectures, u64_stats does rely on the load/store atomicity
of 64-bit data.

However, users often mistakenly believe that the helpers could also
protect/"lock" plain (64-bit) variables, which can lead to load/store
tearing.

Remove the misleading "non atomic operation" comments and add explicit
examples of incorrect usage.

Users may also be tempted to use memcpy() or struct copying. Doc the
usage of u64_stats_reads() for this case.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/linux/u64_stats_sync.h | 41 ++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 15ea4db2a77b..10f988170e51 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -39,21 +39,44 @@
  *   spin_lock_bh(...) or other synchronization to get exclusive access
  *   ...
  *   u64_stats_update_begin(&stats->syncp);
- *   u64_stats_add(&stats->bytes64, len); // non atomic operation
- *   u64_stats_inc(&stats->packets64);    // non atomic operation
+ *   u64_stats_add(&stats->bytes64, len);
+ *   u64_stats_inc(&stats->packets64);
  *   u64_stats_update_end(&stats->syncp);
  *
  * While a consumer (reader) should use following template to get consistent
  * snapshot for each variable (but no guarantee on several ones)
  *
- * u64 tbytes, tpackets;
- * unsigned int start;
+ *   u64 tbytes, tpackets;
+ *   unsigned int start;
  *
- * do {
- *         start = u64_stats_fetch_begin(&stats->syncp);
- *         tbytes = u64_stats_read(&stats->bytes64); // non atomic operation
- *         tpackets = u64_stats_read(&stats->packets64); // non atomic operation
- * } while (u64_stats_fetch_retry(&stats->syncp, start));
+ *   do {
+ *           start = u64_stats_fetch_begin(&stats->syncp);
+ *           tbytes = u64_stats_read(&stats->bytes64);
+ *           tpackets = u64_stats_read(&stats->packets64);
+ *   } while (u64_stats_fetch_retry(&stats->syncp, start));
+ *
+ * Remember point #2: update_begin()/update_end() and
+ * fetch_begin()/fetch_retry() are no-ops on 64-bit architectures. u64_stats
+ * _cannot_ be used to protect plain variables against tearing.
+ *
+ *   u64 stats64, cnt;
+ *   struct { u64_stats_t stats[10]; } st, buf;
+ *
+ *   u64_stats_update_begin(&stats->syncp);
+ *   stats64 = cnt;  // no
+ *   stats64 += cnt; // no
+ *   stats64++;      // no
+ *   st = buf;                      // no
+ *   memcpy(&st, &buf, sizeof(st)); // no
+ *   u64_stats_update_end(&stats->syncp);
+ *
+ *   do {
+ *           start = u64_stats_fetch_begin(&stats->syncp);
+ *           cnt = stats64; // no
+ *           buf = st;                               // no
+ *           memcpy(&buf, &st, sizeof(st));          // no
+ *           u64_stats_reads(&buf, &st, sizeof(st)); // use this instead
+ *   } while (u64_stats_fetch_retry(&stats->syncp, start));
  *
  *
  * Example of use in drivers/net/loopback.c, using per_cpu containers,
-- 
2.51.0

