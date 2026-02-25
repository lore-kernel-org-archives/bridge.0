Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022EB29DB99
	for <bridge@lists.linux.dev>; Wed, 25 Feb 2026 03:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990738; cv=none; b=RlyddDbWOM79ti1YPCcFCKzA/3Moggb4C8Z9/IGxg+7cSjw25SPoNhzTZ4/mnNpwE0+Q7ktmj2k2u9EivFzNN/st8urlo1iVc9iPY663o7dQo7FnCjsMdudThZDo+Uz6o9vTjLzzyYVkjHTBJTB49KpsS/mZ6Ncg66BKWaXwo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990738; c=relaxed/simple;
	bh=ioQkH6Kq3BaHcNNHYkbSQWOm2Z0hguUCzLEhgRepsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltKj5Exy1FLIQC94XfoZhAOInNZITRSaAL+EmMcfg8RAI0yM8E+8awqDPYWYocD1HcUm899/STapFXGVqytO0n0kEyzqWS+hII8hBIdhlsgWttfrlnxJR/0uGpu1AfrzLbAdz8jTpj2kEPyEpgZketl8EL8KBRBhGQeoaPmCpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldBAMt+P; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldBAMt+P"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c7059b9df33so199893a12.0
        for <bridge@lists.linux.dev>; Tue, 24 Feb 2026 19:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771990735; x=1772595535; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRulitact7LuRkcM6p1wuTRq7YmEiipbfGs7cAozTt0=;
        b=ldBAMt+PDp5932x03Ex0H2po6a493TW33NVTGVLiMP0b7ofAI7GPquqTM6nqde1y8t
         ZNQ+KK9xo/p4lQZCIW17mYQsIs1GnuIzFamXTXS5XECiMOY6Ynd+sgT4CD0QasPM+zlP
         744+wrbVUM/tPp0ahftlgw+X8bXxoIiyC/EdKV++bkHn6/sUIlf/kPCDgmVqxhkidXrY
         u/NosCTxSGxOzsPeHksdrn09mTNt9npi63PAmJPOoyar5K4JehYSI4wUXaYi4wOReXuT
         tfMfRrKtkko2NTUf2BldlR5K2BYnfsAD5daWsM/Wu2HgEWOsQw0gR2EPmdcuywEtyq7U
         /g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990735; x=1772595535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pRulitact7LuRkcM6p1wuTRq7YmEiipbfGs7cAozTt0=;
        b=PBpfMfBLLur5JA+KW3cqEeS2IYFRZmTQAR8hi0edGdOW5L7dvordzT9A08Rqns8Qyi
         F7aCAemK43CQ8GT53EGWrtOs6qKxYp6iXqvXBWp6w6CEYTofGmkBJXosRUNRxD8ThkFt
         2QN6/f9nXqcYPaA4WxJ5lFtZFSc5hjSFJihCoCPFbSdY/XRf3x5nykkqG6T2HjXCJVO8
         Ne57wjSXke/ehMZBuApo2YM3tiMQ9ZiPk4gZcAQsS8FowsTsAWR6fJIVACIYgo69MxvT
         y0fhSr8y2KJm4DbpNKkZRWYLtcltugmgU2Ghz/REjd91T8QBY6E2pb+VstVJxXI8xxGd
         f0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUC1VqwRiK97/AMFn4Se7xfafFLehzJAVuARvCPKg4m6JNBsu4xtxDWo3zD1t/v+GncCkfVRXM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2S7cRLlfv4XPPhakYRSUlSaV3jOXkOTBNUutAv+XLUDyEXJ5z
	vVv/ZVbg3o1+P1AFpod7ke/xj6WPn/hLFap0sG7DrMt20pjJcY//g8dp
X-Gm-Gg: ATEYQzycppjYzffkVCm+ONENgUtFUXRIrskl6QYcH4pohWSMkNyk8iad4LNkKZEajLu
	io/mriliuQVS15KmG7fWgSbz2IitP9GcvJb9LUrFlLZkpO36v1BujJc7l5cUZHL/K/+2oMVOnuY
	6ltzk261YRfJ/aI9pcFeFIPI5g3plf/glFX8vEOB89RB385DFjsHUR/xuWQdaVunc7gvrHEO4zy
	tAPXBeZ9WlnAhRds4ncXe3shEQXkNCDq/LVNTTir37gq5P5l3CdiBudM/SZF7FEDQqCH09y91gp
	Fw3Y0mATqBqfzJpLs0VsPy/qq8PdwXNyvz/1m0rizb6p/YbmMgKeEah482s4vfYSAbUmc98iwFB
	S8YbDzc702FNpyGUPFlU9KgVk0UZPApnlQAS0baOyjUlCBbRw54PcBNjUyr9KX7S9QMoKdyTPAN
	YQ/175CSqtw3a83H8deZZ7t+vRYmpp3HSXS1H0OkhlRvuPKFV86tqtIlQfeBKhfkKESWTQkw==
X-Received: by 2002:a17:90b:530d:b0:32e:72bd:6d5a with SMTP id 98e67ed59e1d1-359037f3512mr2134249a91.1.1771990735285;
        Tue, 24 Feb 2026 19:38:55 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359018838b2sm1161746a91.5.2026.02.24.19.38.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 19:38:54 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v2 2/4] 9p/trans_xen: replace simple_strto* with kstrtouint
Date: Wed, 25 Feb 2026 11:38:38 +0800
Message-ID: <20260225033840.33000-3-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225033840.33000-1-ericterminal@gmail.com>
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616; i=ericterminal@gmail.com; h=from:subject; bh=ULBANr6zOAUiLxfBQ+XUgxxtzikjVOyTnngJAb6RsoQ=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOy5Mv3PZGZ5rZi2trbn3b/meXvM21X0ZzD/hIHVHnU j+hlrfcraOUhUGMi0FWTJHl7v99c3O9bs25zn04F2YOKxPIEAYuTgGYyAFhhr+iYfnVLu2vlgl9 9Lm+6VXxTJlXa/TrWIMsHp+NPXTYLvgIw1+pWW6lZxMq+642FKwxSdu3MvZ8S+y6r4dllvUskXi 4sJ0VAA==
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit

From: Yufan Chen <ericterminal@gmail.com>

In xen_9pfs_front_init(), parse the backend version list as comma-separated
tokens with kstrtouint(). This improves error reporting and ensures strict
token validation while explicitly requiring protocol version 1.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 net/9p/trans_xen.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 85b9ebfaa..f9fb2db7a 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -413,23 +413,29 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 	int ret, i;
 	struct xenbus_transaction xbt;
 	struct xen_9pfs_front_priv *priv;
-	char *versions, *v;
-	unsigned int max_rings, max_ring_order, len = 0;
+	char *versions, *v, *token;
+	bool version_1 = false;
+	unsigned int max_rings, max_ring_order, len = 0, version;
 
 	versions = xenbus_read(XBT_NIL, dev->otherend, "versions", &len);
 	if (IS_ERR(versions))
 		return PTR_ERR(versions);
-	for (v = versions; *v; v++) {
-		if (simple_strtoul(v, &v, 10) == 1) {
-			v = NULL;
-			break;
+	for (v = versions; (token = strsep(&v, ",")); ) {
+		if (!*token)
+			continue;
+
+		ret = kstrtouint(token, 10, &version);
+		if (ret) {
+			kfree(versions);
+			return ret;
 		}
-	}
-	if (v) {
-		kfree(versions);
-		return -EINVAL;
+		if (version == 1)
+			version_1 = true;
 	}
 	kfree(versions);
+	if (!version_1)
+		return -EINVAL;
+
 	max_rings = xenbus_read_unsigned(dev->otherend, "max-rings", 0);
 	if (max_rings < XEN_9PFS_NUM_RINGS)
 		return -EINVAL;
-- 
2.47.3

