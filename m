Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BBE4C630
	for <bridge@lists.linux.dev>; Tue, 23 Apr 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859390; cv=none; b=ktuSYlapyzSWflQVlgjqrYLrw3DndgWrV63nxvKm/Q8N+BODLIhejYXEkTQvrbpgUvCeFiBAtSgL4w3Dbfq0vJndxCiC/OfxrlPSpQvFKv/R7z8aJnJ2oCx8OvOywZfZKqL0uoi6XUmwekz+UaW8siRzLXAlxQJmV3Fj62/DBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859390; c=relaxed/simple;
	bh=1pR6m5Wi5iIO9mWeE7uFEYPdE/xPU01dcPav6FtcGgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IrwufG9wXw0JQ++t29ctk8i6BGhn9L5rpOzyzjM8eK/J0JwmA9Q6zVMxuFtDI/Bs+GC9V0H+ANvuNPeDaZC3l4aTO2d1vD9aUIVs6JWRuwOaGk61Yr1FdZXUoaECJaimBzl2i29+BLYUqnd8RV2naTrsMoIBz4ghk863tA1Nykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qrpXb4E7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qrpXb4E7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=1pR6m5Wi5iIO9mWeE7uFEYPdE/xPU01dcPav6FtcGgk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qrpXb4E7M7hSiZ8Cf2INubIQwovOxf8rtiST2nTdYG56P/i02vaGe83f+9bvQprvq
	 VgpcOsvaoWCndC7LXwkbN21msJ81t9jqvLggR4K6+dWl6vt6tbFaQ5B1IFnTi+I3Mw
	 H0IMGkDPx1RTLLHkm4qk51fTBM34bIyN02uPPn08=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:37 +0200
Subject: [PATCH v3 02/11] cgroup: bpf: constify ctl_table arguments and
 fields
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-sysctl-const-handler-v3-2-e0beccb836e2@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=686;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1pR6m5Wi5iIO9mWeE7uFEYPdE/xPU01dcPav6FtcGgk=;
 b=pcm/jJjouDKJ7dKkXuplkCwgN4lakaTVY5yViah+TEyJb0kgB/5JxKSM28vhTdxT/a0KzPrgc
 T5MafpuEka/DMwunsovOVuekoxGTF4FJjqwg/mb6qFtEZR2YOr2vquk
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the sysctl core will only use
"const struct ctl_table". As a preparation for that adapt the cgroup-bpf
code.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7a27f19bf44d..4eada55a2df8 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1404,7 +1404,7 @@ struct bpf_sock_ops_kern {
 
 struct bpf_sysctl_kern {
 	struct ctl_table_header *head;
-	struct ctl_table *table;
+	const struct ctl_table *table;
 	void *cur_val;
 	size_t cur_len;
 	void *new_val;

-- 
2.44.0

