Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D8240756F
	for <bridge@lists.linux.dev>; Tue, 24 Mar 2026 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366254; cv=none; b=XbDLvwKa9OKv01thD/UPX4CzHsObc/kmixaMsRjQMayg4r4PNDtwwMNeJk9CEvGJ/Ufbvp3n9PPoTB2RUXOucvXB6LJdPoIsFRHm90I38W4SxbXxDUor8qaG0kKqqj4AcaLErJhgXlxptrzQiBB+zeCliuJVO42Wn24wFbf3Zhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366254; c=relaxed/simple;
	bh=IkRvC5Y3yv7EfUIouHSB7F/B/icLT44ICvi/VwM4Hso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lY5pPfLV8McAlt2lHCt0XH11ldxDzag3UWQP3GCAd5b7Gy/GiNLSCOjmqZXEXc48Xdj1DUIO6Nf41IuCCLRdDc12LG+Vo7/vVLzGaM6qHwUcUQt/2gH2UINDcKr6erCuRqxnoC8RKsn/vJ0Ec93X5rsoToDPMOR2Yiu3cH9DNOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcR0dor8; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcR0dor8"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12a695044a4so2559839c88.0
        for <bridge@lists.linux.dev>; Tue, 24 Mar 2026 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774366249; x=1774971049; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiVBh44Ha4wklKoyn3mQlolcP3I3uICA1aXisZpChwo=;
        b=YcR0dor8AWcjL5LTd+qY2L4crcVA+8w2KGPAPArWox2f1xqDexkNKJbSQZlGYtkXaG
         ffwP88VC7/8dl+bgLeiSKLgHachWbd+3vz1d2TSXswj3hFYlH5Delp+Yfmavt9kHAfqC
         ExfxIFdYKZbzKb9iaE/pBPAxP2l9CJG1DQn9uGO4yEITHSGdPtXyhh75/TRUX4imlXW0
         nh9JjAYE6zlC7BywQwCXuctAOvwQctkTaMjvk8hl33li5+qyUYZZOuTiuf2jShO9K6ib
         GLeSj5n+eOpPB3+l2U6YtWvX10rfy+zTfjIfHPPwYZLSwRiEE4n6rvHYfXikJDdoLdrj
         hfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366249; x=1774971049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WiVBh44Ha4wklKoyn3mQlolcP3I3uICA1aXisZpChwo=;
        b=iUYJn/T87zEiCZo5Zv3IqfNarSjjR7ooXaCYHNONrPq0qchpuPbf9UorC8RgVOaPh+
         v3cpXgkZqE8w2B5IOW64spvLE0RtSt8VD7ibnhiz3ZDUioceQw6vbqQjg/H53ETQb5tW
         iYrVkDYN/O90/OY9xEdwCTbDDXq2Ab2nJn7bwMUhsDBqVfMPsJIawjtoGVgFtgIiwhCF
         xm5/l7FqESwPlcWIRg5dIYHpV+NbJx6BaomAwKGoiNqGWsSJ+b/LbOQKOOPJFW7tDZbX
         qg/V87A9XF+S1nqgiFu6135odh1OHy0s3coRcmScVXcAQfF2wQ94p7ILxvj4MG3kcd1C
         Ik/w==
X-Forwarded-Encrypted: i=1; AJvYcCXKD7O73BhUgV3Ki+tBrLy0ojccXbun0EVizjRuy6zx0B656DRx5K1W+QymIrcberAzoBc6b2I=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0+ytVQ+DFNDULvjHYb/YsHwbCW++Z40xDxM1OXtQgMl9WxlXs
	2CDQmPiInoLtoo+pdg0uKlHjVQZ4M1x1QG8yjdwrGu4vwWf1gBGEzyvW
X-Gm-Gg: ATEYQzx3N1g0qm0I/+P24Q3dNPQw6lg8E4ncsViC1RK+80ozHcz7iveDyu/0AEDUc3a
	fna08lIpS+fxhocgo+bo1hXl2tYIyiVQMGYcF64bvWaJH8nAjjBEd+b1E3YHEoXaIaE2W71xGqR
	JnwB1cngB1pKrBykpJzVtqsHx40Y2pjZNTrxCCDZJK99Q2W5vdMIsgr6ozFNz4ORjkXuNl7UAoD
	KmpOWy7SHsSmBAxQlYJCAXbIrhqiNvGs9KfofSG+SzwuwW+gbTm37RIEWGDILrKMvZLxw/dMeUI
	R6qSwGO/WoDwxwmDC+gJDyzw5H1wgD5IUfi6eukozoDw84SM4u4wAOUqYwq7N9GtwbdZSDBmM38
	D1B2Xliv6QbcPHIbAaKlKMNaSe5YXHsrdWmKSVEQLHoyaTdbQLI54plxUpxyQnv4hA8mMdb9UZT
	aQOkVPjeNhcgUHPQDDMaX77yqg6lqKYjdA80Wzd8Mar9h51QQE0VznBkBTxf96k6J0f6X6ZuAeH
	BXdxGKk
X-Received: by 2002:a05:7022:6709:b0:12a:6c84:601f with SMTP id a92af1059eb24-12a726dee93mr8317819c88.36.1774366249330;
        Tue, 24 Mar 2026 08:30:49 -0700 (PDT)
Received: from localhost.localdomain ([38.244.25.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a736b952asm11668865c88.12.2026.03.24.08.30.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 08:30:48 -0700 (PDT)
From: Eric-Terminal <ericterminal@gmail.com>
To: horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v3 2/2] net: sunrpc: replace deprecated simple_strtol with kstrtouint
Date: Tue, 24 Mar 2026 23:30:36 +0800
Message-ID: <20260324153036.86901-3-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324153036.86901-1-ericterminal@gmail.com>
References: <20260324153036.86901-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=ericterminal@gmail.com; h=from:subject; bh=6agocKJaIItyp0/DYq8x5bAU5b3NaTnGQ7RmsnHGIwk=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQeWqt142ldbiBb3nGxexem6LS+7Hnxdq9vf/LzfVUZT 5nv3p2b3jGRhUGMi8FSTJHl7v99c3O9bs25zn04F2YOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU MzTSMdAxZuDiFICpDjzC8D//4YOUx4Y/r2h2zbm/a9vDWZO7Vn2bfVc+sG7JQ7GMaROfMfz3nsO 2NCFps1Lc2d3NjLcjXQzm9DgUTRafp86w+9q1i0kcAA==
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit

From: Yufan Chen <ericterminal@gmail.com>

In proc_dodebug(), trim trailing whitespace and use kstrtouint() for
full-token conversion, preserving acceptance of surrounding whitespace
while rejecting malformed input.

This replaces the deprecated simple_strtol(), improves error reporting
consistency, and avoids partially parsed values in control paths.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
v3:
- Split from mixed series into a dedicated net series.
- No functional changes since v2.

 net/sunrpc/sysctl.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index bdb587a72..07072218b 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <linux/ctype.h>
 #include <linux/fs.h>
+#include <linux/kernel.h>
 #include <linux/sysctl.h>
 #include <linux/module.h>
 
@@ -65,10 +66,11 @@ static int
 proc_dodebug(const struct ctl_table *table, int write, void *buffer, size_t *lenp,
 	     loff_t *ppos)
 {
-	char		tmpbuf[20], *s = NULL;
+	char		tmpbuf[20];
 	char *p;
 	unsigned int	value;
 	size_t		left, len;
+	int		ret;
 
 	if ((*ppos && !write) || !*lenp) {
 		*lenp = 0;
@@ -89,19 +91,17 @@ proc_dodebug(const struct ctl_table *table, int write, void *buffer, size_t *len
 		if (left > sizeof(tmpbuf) - 1)
 			return -EINVAL;
 		memcpy(tmpbuf, p, left);
+
+		while (left && isspace(tmpbuf[left - 1]))
+			left--;
 		tmpbuf[left] = '\0';
+		if (!tmpbuf[0])
+			goto done;
 
-		value = simple_strtol(tmpbuf, &s, 0);
-		if (s) {
-			left -= (s - tmpbuf);
-			if (left && !isspace(*s))
-				return -EINVAL;
-			while (left && isspace(*s)) {
-				left--;
-				s++;
-			}
-		} else
-			left = 0;
+		ret = kstrtouint(tmpbuf, 0, &value);
+		if (ret)
+			return ret;
+		left = 0;
 		*(unsigned int *) table->data = value;
 		/* Display the RPC tasks on writing to rpc_debug */
 		if (strcmp(table->procname, "rpc_debug") == 0)
-- 
2.47.3

