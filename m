Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FEE4A02
	for <bridge@lists.linux.dev>; Sun,  5 Apr 2026 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775347410; cv=none; b=hi0QhL9A/PGVOhAyNKCTiJqssmexHJ3FFQKWoO6oBO2aahEfnwl8gj/aaAAu6ooQDl95xv8E0+NqXLly5cGqwtj4M06H5BrKp1cVO+ahiB4oT6EbWuGZ76XaaFfdVrzVnSYQUdbXEGeWjrb5XibvmomMfyLqhRDFd/xP1ZM1T6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775347410; c=relaxed/simple;
	bh=eT0BY6+jZMne8BZ+Ndpq/aSw3ClUrczrR89b+z8vpLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hylPPcm8CIzPU0rCZ6gnRNOqdoJQzeIbyOrhV23avroNr6oqz9/enUfxih3s+smI9mhlYqPZiOSb+5MVpMRUwfJ/G/BwUye2sgeUDxzrR+ke8c0wAgsyT/u0S6OP/uxki3tfTFaU83O6wr1BZ8vuFlfIg/d90OZEARrnkRcrGBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=cwqv50XY; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="cwqv50XY"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-127380532eeso3343803c88.1
        for <bridge@lists.linux.dev>; Sat, 04 Apr 2026 17:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1775347408; x=1775952208; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZAq/JoXbDsaB10E9ei7z4Jwk5QHy8JrT6TkV/e+ag4=;
        b=cwqv50XY54+p8Fd8idfG3KKBL0rKdj2AXN+K0LDk/sHILe+Q/l3M7xN+aO3w8pU5IA
         Vet0LJbHaNEp8hd3/vkU8wtyeZrk6v7Mo80sXuF640dNE4z2jXy9fvfN2EwyjkAc6LjB
         V9NtIoeAxiN+9Q1uPLoMHTlXPCsqxcBH4/3vtT4mBPzWeu39KtCH3+GZ2PpHK5tRwKft
         t/is5o++et8l63I95M+zSRyMVj9rwog4ONuZZLS4uC3+T08qPHIBUzIKAT9Fhd/XADEj
         wbxbpXb2ED6O+NJwPOZDA3Dx/GQYjKsavWCE94HycykgpW19LHotaeO2CA1qqi9aNHob
         CHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775347408; x=1775952208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZAq/JoXbDsaB10E9ei7z4Jwk5QHy8JrT6TkV/e+ag4=;
        b=W7hP5STMyygv1/+LGjRy4bqKVtJ1rBGbMv42+8NEX2pwZdsKGa1t7MqK6r726uZCfR
         x6snmBytWNPzBEpaCxZb7W7kYIXz2ekL6QmjndgbkjX4YfGC5bJTsjfvd7VzPgWW7amZ
         Fstm9FtXjCBAMAt3HsyeoPOvZp5xhg7VTY/gsdJTc3UjMoRwBdmkfLTWqSnAsWc6RhTZ
         l/0X5w5abmJ/e6BH84vr1UvTluUDXBT38BsL1t1SkLGuebJzCRLjCewm+X6IoaTGZSAp
         nhkL+zRlgOv8j1EIQeS0iltAd7x0/ry/iDi87Dybd/PId7MLI4TmVZi7Zz5MPRfxzPOZ
         T+sw==
X-Forwarded-Encrypted: i=1; AJvYcCV0DA/ib/vEatpLl+1VuMr5WR+hLjM8gVLBkyo5jddz5GZEm786ciCB3e1dRuYt4ADZUbcEzm8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3sm/yT/aB0KXwT3xmktO3zIhjd97yNErZfHhaXMnYuzajg3++
	t4Dkh249lhKCW4F0ITS6ghjlwiDaPuOg1N3qXJ6SOkE4GGjiKYum5wscmWc/d1DpyA==
X-Gm-Gg: AeBDievw3ZSo9oYCkkQsEAFX6+zBoWVAfixVcp5hQPyNCiXuR88gqj/Vqjm+2OxBH61
	LyXY26T64GK2dWSW4XnazMGVBMQKCU/nrwqWqEKQVHztR8NxoH3krVLpafh6Iaiv+6JjKXaTYaQ
	zPebIB96/l2S0T5Z8iL3AtHf3cgCRm30r9AqQaZimpAcVnYRLqpmtGEhmDxIP7xCRu/R5iyVfEO
	CdVMIzNIKm0y1ob5iwX96whpwXAF/bVnttpCk815OdI7h7VkKL5rZhAaw5WbcKg9JZVE8ybHkwU
	Aa4TSr4/6a2q50AZ3qIbhIRITiwMzqBqAn4DXYUgUyOFwfPDjSlS6zNW/2ZgfFUy/lXEIKJ6JHI
	P1SwqHomz+td83QpeWPpoknwDnGZaPLFpoMD3Ebry0zUG5Fw4QsIZFqIsx73WNxo4dCuttnspf8
	06ZyRI7vuphB22c6nn5gyfHsRuefP5rUdfx/vuJ/kstA8O04E6ZAFv7g==
X-Received: by 2002:a05:7022:418f:b0:11b:88a7:e1ac with SMTP id a92af1059eb24-12bfb745142mr3572419c88.19.1775347408405;
        Sat, 04 Apr 2026 17:03:28 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c07a8703esm1567831c88.8.2026.04.04.17.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 17:03:27 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] bridge: cfm: reject invalid CCM interval at configuration time
Date: Sat,  4 Apr 2026 17:03:24 -0700
Message-ID: <20260405000324.548623-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
the configured exp_interval converted by interval_to_us(). When
exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
interval_to_us() returns 0, causing the worker to fire immediately in
a tight loop that allocates skbs until OOM.

Fix this by validating exp_interval at configuration time:

 - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to [1, 7] in the
   netlink policy so userspace cannot set an invalid value.

 - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
   not yet been configured (defaults to 0 from kzalloc).

Fixes: a806ad8ee2aa ("bridge: cfm: Kernel space implementation of CFM. CCM frame TX added.")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: Move validation out of the datapath and into configuration

 net/bridge/br_cfm.c         | 6 ++++++
 net/bridge/br_cfm_netlink.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 118c7ea48c35..dea56fffa1c1 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -805,6 +805,12 @@ int br_cfm_cc_ccm_tx(struct net_bridge *br, const u32 instance,
 		goto save;
 	}
 
+	if (!interval_to_us(mep->cc_config.exp_interval)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Invalid CCM interval");
+		return -EINVAL;
+	}
+
 	/* Start delayed work to transmit CCM frames. It is done with zero delay
 	 * to send first frame immediately
 	 */
diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
index 2faab44652e7..1bb33c8f587b 100644
--- a/net/bridge/br_cfm_netlink.c
+++ b/net/bridge/br_cfm_netlink.c
@@ -34,7 +34,7 @@ br_cfm_cc_config_policy[IFLA_BRIDGE_CFM_CC_CONFIG_MAX + 1] = {
 	[IFLA_BRIDGE_CFM_CC_CONFIG_UNSPEC]	 = { .type = NLA_REJECT },
 	[IFLA_BRIDGE_CFM_CC_CONFIG_INSTANCE]	 = { .type = NLA_U32 },
 	[IFLA_BRIDGE_CFM_CC_CONFIG_ENABLE]	 = { .type = NLA_U32 },
-	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] = { .type = NLA_U32 },
+	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] = NLA_POLICY_RANGE(NLA_U32, 1, 7),
 	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_MAID]	 = {
 	.type = NLA_BINARY, .len = CFM_MAID_LENGTH },
 };
-- 
2.43.0

