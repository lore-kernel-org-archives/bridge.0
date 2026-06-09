Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F5C3D5679
	for <bridge@lists.linux.dev>; Tue,  9 Jun 2026 06:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987896; cv=none; b=tvaou60D8w2W8Hw5hmAI+skKi6FujWszOhfNoAYt/AY9UkNl9JizWV+tyH1NlwzNw5mKpCuKJJS8aqj4G1THw8ei59SjOxEecGA7byesiX2LPQN9x86IBaCPqGfUIMdaDjiY+dcEcuqqT0qpL7OPXsVlyf0H0Ldr7D3FvdbUgq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987896; c=relaxed/simple;
	bh=Vteap/nHF7sQj3OHKsy3ErbiZFhlDHkL1pW6lncRNG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ICJVJ2K08ylfDv8VaAjhcdd679uHiiqBV3fysd3yW++YdusC1CaFR54mB6aAynWBFE+B8/6jBXQ2Sow8Rgsx0tdPxiXqpnIYNEnp91riiSASGHNtD1k9f7LtgLMD00rOTyKOQ1kcLw8Lu3oNJqUHFyGQ3i3IY12u44SA1JFmarU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=swiYiVn/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="swiYiVn/"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0aa420401so39874605ad.3
        for <bridge@lists.linux.dev>; Mon, 08 Jun 2026 23:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780987893; x=1781592693; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUoCgjqP8cJvxOnwB2NaZqkz+8bhLbudTMsyg7OmkZg=;
        b=swiYiVn/8JGPMJ1MEQNMA41PFjR9P/n7AUBxaFHnBlLwdLzyLErLimVUVbrvWOahlW
         7U8kUXeKKe1uKoRn28/yk2v85qUJO4GXR94Sk5QUlewp7Os7KgnLJtb+uPK1li8Hr6LX
         wguW2mdRsYKovwHbM9Lt7TzIWbZn5G7gzY+/hlbDysXP8Icjhwicvh2NJt1dKx+oVT2l
         mi6wOtpd6jac3kX+8B/aT+yH+N15euBY84fjKEVAKhzm9IlTmaNfq7OQcOQ455tlemaI
         N7+VQPfl+hbQJPdXuQeYGmLhrrKL4zr8Fgqva5xlfhWCLpDcGAEsaLiseuFxGAnWIFqH
         n5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780987893; x=1781592693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUoCgjqP8cJvxOnwB2NaZqkz+8bhLbudTMsyg7OmkZg=;
        b=LNM6KCxsQmmJATQuXckzQeGiAnlKuD0/Nnj+h0sJGzwM1LFm4/deioxsJsaLuDnV/C
         3Wq7aUJBAh27a99eam6tUT5dHr+8KvE7qXGN4H64+BbVG8VxlC7z2VwkFqKsfl9y9E74
         kHUjvYtvgIEL6gDb16EIUBxAigew40UCp/kZ83ermUBOFERCZofhBWxkvuT004eBZDNy
         El/yCAzSk/6AtmfuE0ToVrNgiDyu9kHZnzIq/mbYXCLjRWlYwyZUymGDE95y3YXltdWk
         s2AW991yLXxMWuCs/trqtWKZBqmgqCTdpYnfc1ERUtchdAWnjIG14QMKVEMVoMCiPI4I
         vYtA==
X-Forwarded-Encrypted: i=1; AFNElJ9/3yuheGzPaJKrNN4ubxou1R9/OkCMnaZSA1AhsCBrKpRI+VLzQowmfKBNQObsE3ObF5WWtMI=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo7FkwVu0MCASkc1GDfz5zt5PRnIPuaKnRPpq7x1N9fISCxome
	FALmKXC8IQ2J0+Jj8mvSeAN6jSh7vWDZQ8TldpI+rXcYa9OdNRRUANkd7ot8LhNfNw==
X-Gm-Gg: Acq92OHa1A3OfENOpDZBB6FgVtuqd5h2459qrTskvUSzJmXaS7Ywclq/DIaEzynnv7q
	I/7N2sW7fFiksWbouH7IX8BT2PEPKO9a9CHGlfH7Us/qBejiyNAcgZCgCb3IJ8wcECHAzwss3BJ
	QroCiPL4I+LdTh/gmRZYZsRlnscpEHDgGZKLA2d9l5iUrP2ABy0tuPd4WuPvkKC5ZyWNlRHWFYw
	FpnCrihm3rIoOXP2JU8qkKvJBUoMSZ9PPDZkYpRkFIEaEIA6LQxmUXrIvDAFmemGKYVBYSpRZnB
	4tT2tNaUfpG0JhyfvE7IaXgr0w/hfC69+f4i+t6fTxXTRF5hEwFjKUzAWOZOYt7PL8qq3jmf3WM
	+hUtFqpMkL1q90KxHO7TwIglN+5WAd3ML6hUEgy2fYAMizTq0HKnjnT2+uUg+v333TghENqun4n
	0toQON720xJyx1T9c=
X-Received: by 2002:a17:902:ecc3:b0:2b7:aa20:3c61 with SMTP id d9443c01a7336-2c1e8339808mr212606545ad.33.1780987892776;
        Mon, 08 Jun 2026 23:51:32 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6cea3sm197980385ad.7.2026.06.08.23.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 23:51:32 -0700 (PDT)
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
Subject: [PATCH net v4] bridge: cfm: reject invalid CCM interval at configuration time
Date: Mon,  8 Jun 2026 23:51:16 -0700
Message-ID: <20260609065116.2818837-1-xmei5@asu.edu>
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
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v4: remove the Suggested-by tag
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

