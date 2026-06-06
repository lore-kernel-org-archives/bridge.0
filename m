Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90BE2571C7
	for <bridge@lists.linux.dev>; Sat,  6 Jun 2026 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780783135; cv=none; b=CkYgv/qgQQJ48noJaN65Irb118RfQ4D8st470N4LJlsmxilCH5BUqO4uq5cAFiyqGBk46SxJHxjv+4oxVJR4oseWlKIY2+ykD6BpEf7hbIPmP3QEP2jzqiFfnBVFYKTY/UnNsHKZ2Sz3LNkFIk5DQTpqKHxe6qy+HjNVoSAfI6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780783135; c=relaxed/simple;
	bh=2Ps+Xuc9znsg0RNzhx1A0A8d54hT6K+VJtoW1ihaD68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9kb9zWJC6ojoDM6avxHGQ07l+SuUBAabtXmmT2ht/lRHiMRAW/m2xaCTEa/LgM0ItSMrvRAHQh3r7fM/EH8uNE4b3g3qx0eMYV5Fli9qIgM54IB6MOBMrdbsDMeNpIJ3polWkTr9w3rpbAMyVwcYEY4szvr49wHx4+SOtT2yfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=p1ej7bHU; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="p1ej7bHU"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304d8362a58so1825645eec.1
        for <bridge@lists.linux.dev>; Sat, 06 Jun 2026 14:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780783133; x=1781387933; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sHjBft5h4OphRFMIcmac4iz2gVqRE8mh2c47+OSftFA=;
        b=p1ej7bHUhF62GTYAborq4aRb7ictTzyRBOaGBn5+8RenL5X4n5PcaQKcUNijDrLRKB
         mqPqAWd8bl+Tvy6Y+rNBuxdZ7Df0Jg2aHEQFWpAz9vdodd8g7PmlKLi58vD9EA0Fso50
         ARjPq+1oBWIhzj3DbxKFm0iuoRLBFdd3SGjFS3jBa0B25Dy+kM6PpMpvdsK9lYzso/gG
         oj213kkDD1JNHGQTJdZsJPusxqx5AmNhWyOpu3nVmVRbj9eNqCHzsXgkHq8cqBm0+sCI
         tab6yrGn/CsVUO2wWGr7ghPe6ZnM4K60oeOvRAXxnlzbvThGDIM/wWJCuEEJFUzaK/e3
         fvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780783133; x=1781387933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHjBft5h4OphRFMIcmac4iz2gVqRE8mh2c47+OSftFA=;
        b=iavg9EpSMwaLTWAQtzp8qwXBRGcDIrG1OHyJHOEIcy62lDq7uWGJDL9AwbfV52Wj/U
         W6i0gbivl/5WzTh2ynHBSCEes5NqxH2DPYfGbL6a6ziP/QOiIjMen/ul6iyPIksH5Y9H
         zOGYJQmtUTXYMRvKCiJ0cp5dZ/+SChOPT8uKhT0ukSO01QRExkwHI24EW2OZZ+LSfwy3
         g0fcmO4Pyshnvb6/eoBaEO1q8WiRrTeSaBlqwW2z/zwQNhInkIAbinUgVXicxl6DKBRv
         GVnvBjW7Y8Wa2dKRVECdjeOw9BSOXjiaPNwP2u32MnF+vNjuo9F1DURhFA4e8PIGxMmY
         VkSw==
X-Forwarded-Encrypted: i=1; AFNElJ/QYGz+//w4vAOSzsEjmh0BBPEI8IFGGvi0/KTx0GSwMoVIZRQkXvQQV5i4utzrlNYNxFs/IzQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YydlikJg6++Lz20o3C2vybTncJDWru3od7w2wcEvFL7DBXhYSFP
	kkuj6umjtUtXioghUgHxumAyDVgzuCn3Qr99FQe2AnT8Zhllxpgc5dZtv3cso73GLw==
X-Gm-Gg: Acq92OF5nYwQfIRWtFNSqLyj3rtHKND2O9o4+0WJlc9EKd337LW424K1iyTXaKUdZxb
	NOxOD2YWUQNWmw6I1AgSZ6dsQ8zTPLqxLrSi70CwvAF6lvKVhVsfkqBiyHC9Pl5YBJFuIg2aqLc
	VwPQT441BM0StxJ34/bJ2UIiiGBFSow5Vru93mJ11l69yRenD/0LrMdXSPycxDF1XUxQ8A9e5+R
	GTt6uUojkgYh0L4XBrKd4l7sFyBtNSHWfiBq/3KWFc/ToiTH+g0p/SGgzUnpOipsBXrLO5Mnzmt
	yVnDpbzYblrTrf7owPam6WB7dYV2Lara+hd8OZxDC/ifQOeRSM094voBkZ+Vfu4vcmsxYGeJNmq
	fKyBaYAyaDw0uPM1Ip4ZTQdS0RAHya52snai+XKKqhtOqLvjqw6yefmrgtamOysba1wrCmKLwAk
	qdCKpgF7sXO24glylPnZgzECQKs7E=
X-Received: by 2002:a05:7300:dc8c:b0:307:3a74:749a with SMTP id 5a478bee46e88-30780021639mr4328443eec.16.1780783132905;
        Sat, 06 Jun 2026 14:58:52 -0700 (PDT)
Received: from p1.. ([2607:fb90:eca7:eb8:c719:b925:9617:633])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db85f60sm14942404eec.8.2026.06.06.14.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:58:52 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	razor@blackwall.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v3] bridge: cfm: reject invalid CCM interval at configuration time
Date: Sat,  6 Jun 2026 14:58:48 -0700
Message-ID: <20260606215848.1951633-1-xmei5@asu.edu>
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

 - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to the valid range
   [BR_CFM_CCM_INTERVAL_3_3_MS, BR_CFM_CCM_INTERVAL_10_MIN] in the
   netlink policy so userspace cannot set an invalid value.

 - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
   not yet been configured (defaults to 0 from kzalloc).

Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interface.")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v3: Correct the fix tag and avoid use magic numbers
v2: Move validation out of the datapath and into configuration

 net/bridge/br_cfm.c         | 6 ++++++
 net/bridge/br_cfm_netlink.c | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

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
index 2faab44652e7..91b9922dc3f2 100644
--- a/net/bridge/br_cfm_netlink.c
+++ b/net/bridge/br_cfm_netlink.c
@@ -34,7 +34,9 @@ br_cfm_cc_config_policy[IFLA_BRIDGE_CFM_CC_CONFIG_MAX + 1] = {
 	[IFLA_BRIDGE_CFM_CC_CONFIG_UNSPEC]	 = { .type = NLA_REJECT },
 	[IFLA_BRIDGE_CFM_CC_CONFIG_INSTANCE]	 = { .type = NLA_U32 },
 	[IFLA_BRIDGE_CFM_CC_CONFIG_ENABLE]	 = { .type = NLA_U32 },
-	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] = { .type = NLA_U32 },
+	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] =
+		NLA_POLICY_RANGE(NLA_U32, BR_CFM_CCM_INTERVAL_3_3_MS,
+				 BR_CFM_CCM_INTERVAL_10_MIN),
 	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_MAID]	 = {
 	.type = NLA_BINARY, .len = CFM_MAID_LENGTH },
 };
-- 
2.43.0

