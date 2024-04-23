Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C5648788
	for <bridge@lists.linux.dev>; Tue, 23 Apr 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859391; cv=none; b=r0h5YYDSOJ91RZJU/uZlXwildFW6yxuuq0+tsPauCqtrmw5AbGpORvZjfzcPIqDxelsqwXlanVtjOB6X9xuaNExxSuyjyF3eY6EEW/8x18bN6tumGWZuOP1SJAWnAb7WlWVIJQeWS53NBPis7bf3Naj90W1SGNHU1gQ1URHnS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859391; c=relaxed/simple;
	bh=rorPfneHsH4rUwSDhKhni5qatzGJBaNeOV3jbM8lXHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3jhtC2sXfeKxUWrVFhE7Zzokrmr/K5jepxPvhhWnXvJuSlS5cRsuVBe9/gIwOU8wwjf7HBsjZ5663flOmvO7rPLgncoRPoUuzEOa8SNsU/2NnRmUB3UOHqIMso0TYhkAGF4Q2lH2UIa3We+COi6+4FsphK5DrOaDC5LOOdBtqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dzsiMjXG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dzsiMjXG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=rorPfneHsH4rUwSDhKhni5qatzGJBaNeOV3jbM8lXHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dzsiMjXGUMnBeinztfZVIlnYV1FybTv3PVNga/7GNRmjq0tvokzKVmAqMxqZ4TZfu
	 3Mm9Xa73ByvDCbl+zSGzluYBcTMsPar3kyGR78xthILGtEnmvJBhKWCBZI5pDCg6C/
	 UHsAfQ2uBimCPXwCv8/f91yRU/qBVoZCnvSEXqbk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:38 +0200
Subject: [PATCH v3 03/11] hugetlb: constify ctl_table arguments of utility
 functions
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-sysctl-const-handler-v3-3-e0beccb836e2@weissschuh.net>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
In-Reply-To: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <j.granados@samsung.com>, Kees Cook <keescook@chromium.org>
Cc: Eric Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
 lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=1138;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rorPfneHsH4rUwSDhKhni5qatzGJBaNeOV3jbM8lXHw=;
 b=uf+pHLZXXpo1yHHJ2Z13M1e5OT7jsu5lvkviloIZv10UAQiz7g1qEzlA2Tlm9z/kgvmk0wE7S
 t+OfiZGT2B0DcKcd55qz3Jc+6I9uA8iEvRoTSo4pFJmvocUaelGw1Ie
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the proc_handlers themselves will change to
"const struct ctl_table". As a preparation for that adapt the internal
helpers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3b7d5ddc32ad..8d12ce63a439 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4911,7 +4911,7 @@ static unsigned int allowed_mems_nr(struct hstate *h)
 }
 
 #ifdef CONFIG_SYSCTL
-static int proc_hugetlb_doulongvec_minmax(struct ctl_table *table, int write,
+static int proc_hugetlb_doulongvec_minmax(const struct ctl_table *table, int write,
 					  void *buffer, size_t *length,
 					  loff_t *ppos, unsigned long *out)
 {
@@ -4928,7 +4928,7 @@ static int proc_hugetlb_doulongvec_minmax(struct ctl_table *table, int write,
 }
 
 static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
-			 struct ctl_table *table, int write,
+			 const struct ctl_table *table, int write,
 			 void *buffer, size_t *length, loff_t *ppos)
 {
 	struct hstate *h = &default_hstate;

-- 
2.44.0

