Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977D2E8DFC
	for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774495209; cv=none; b=YI1eOdXlBCtvKvJik3qxH1gKWCvy74oAmA6QlmQuk+7lsSN1jFl5r/SHtEajoTqPuHyYyhteGL8j/XETn/tMzRjnYOQBeKWGkUyKxoLnLyXHlZBucIKQF12teJfWghWlnW2YxRnoKsmP+J50xubeRVtCMO8VpT0B4UnKiiQHV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774495209; c=relaxed/simple;
	bh=B35YZXWqdn9rlMfOAKXbsgwqM7a0SmTIdv6Czba7vgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpUBBGqV3IxRtZbxgBHwnSzjtBLnBhflr4hM0TwD0Z/O7H6tZ1QkTM7Hw62KrH0YEwy/1yPvI+HVrOZJ93hnCabXESOB3uYEWjxevD90UuTI1L62aM12N3FAbrjLWHOFxyPf2V9Ey/5OWlxwOd8BSRUiCTChTgwWTO4F5msHoOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=T8/Ga0Pp; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="T8/Ga0Pp"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b6b0500e06so719972eec.1
        for <bridge@lists.linux.dev>; Wed, 25 Mar 2026 20:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774495207; x=1775100007; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=35y3hEVWje9ry/w7SYsqM4jky9SpkQNVHtjEAbg4o2k=;
        b=T8/Ga0PpslhEqgxa0jzGyMkX6YmpTshDbD1jmraaSJtszq7yI+F6uXjSWHJlhOgFCE
         +4iGzGd3IebaVN5FjYA/MzkqHjskp3YTxSm5PPQnR9ldl6gcvsr99nJoc7q8gY2Kq0be
         ZrYuZY6Du2uuomsbUWcJb/PWzk3C9Q0wO4sY4KR5MzcBylpSIa33C0ua2yxTUzATPqw+
         8ZkKcue/MtNOw1DC9ofsKtI0tOu/eFrmV5x6dppKUT35S3bFMwIBiGiT/BAgUGpNrp8H
         xVuJWPO72eRG9NcaNxWo07R+CAGp2ekk6ykUSIfD4396PjAbMCp1hV3GQID+7S8XzGnV
         raHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774495207; x=1775100007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35y3hEVWje9ry/w7SYsqM4jky9SpkQNVHtjEAbg4o2k=;
        b=RCjRIHNHCU+JCpxeGjF2pS+QvvyfIsiyt62QJEl/+iNwXVrNT1pG+eLkt56ePNBPuM
         B3VqP32BzfWXvtMXk1gQSHhUPdRMI0FCh9YbDCSHsIKBlrNYEQN/Q+FRpOT+qodpUJKt
         0rgaMJ6LZL6iDKRCmL3jF589G3iA2uTECabR0B++PLwonvl6lpsWlGTPQWBubN82bPXa
         H0KccmUyf3oQu9lbSpomEXyfvCR3TuJrttmi5V/cKqIHt+ZNLd7nW/7fZ5480OX5fVyF
         VfIeV/fhXwx0fAIx+u1skG7XTJ58Gy91eMU32Y6/kmWJvyxTJlC1XtNG5i2xXi7XE8Ea
         ZX4g==
X-Gm-Message-State: AOJu0YybbMyp9x3onGMXET5X0Q0RdgQrRs1ipGVxDEzv0fL0cs+c9JSV
	2qdKaUrcMLsucjRIY1x3f+Mn9dI1sI6WHxR/37w94/uCCr//Vri1OKwyvQYgv2WSEg==
X-Gm-Gg: ATEYQzyMJ5C7GJX9NCwQFKKTl8LlE1jWWispLK+5oyQ43/wEt0s8WmivNUYAhSSLDkk
	mbXv5lMVdg8TuIFKmtL0mDJyIQDNOYjpel+DUOwPocdXWrC83tMeKTk9N3KUrlOTjjrxMHRYd68
	8UTlcFR3St53QKkOQz3Hl2oRDEUaoXsmHLNJDGZ4n1RX3cjl666nUCRA5byh/jNFBO5iLQfFt8y
	2Ko7JntPUH4XYjkymbOQCqiGcH3iKYFuT2MiCRGxd9yKD7OBD6EmTY56ZCueqPFv4Dv5Ctdx24s
	S80mLyVTyZDEQlWTV8Z6DfzF51YBoIvvk75Xajp8uFmR9ebbNPPSUH8d0b1trIYYa3L/Ebqu6QI
	hzXg331zhFIvPucUWqDsqq3nMisthnpzej5KoYneLdT7XK17eFfJxfwQnWe7UvxV+HeuCGbVdJk
	kbW3muoVzEtiwsiOBA8EZ6/9SO+FhRQSmxSGc+vvf+OjcgW44+zfNZqg==
X-Received: by 2002:a05:7022:6b8f:b0:11a:6424:f40f with SMTP id a92af1059eb24-12a96ef7784mr2934877c88.36.1774495206713;
        Wed, 25 Mar 2026 20:20:06 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa7827e02sm2561787c88.12.2026.03.25.20.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 20:20:06 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] bridge: cfm: do not reschedule TX work when interval is zero
Date: Wed, 25 Mar 2026 20:19:57 -0700
Message-ID: <20260326031957.3299500-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ccm_tx_work_expired() uses interval_to_us() to convert the configured
exp_interval enum into a microsecond delay, then passes it to
queue_delayed_work() to schedule the next iteration. The ccm_tx_dwork
callback re-arms the same delayed_work struct at the end of each
invocation, forming a repeating timer.

interval_to_us() returns 0 for BR_CFM_CCM_INTERVAL_NONE and any
out-of-range enum value. When this 0 is passed to queue_delayed_work()
as the delay, the work item fires immediately and re-arms itself with
zero delay again, creating an infinite tight loop. Each iteration
allocates an skb via ccm_frame_build() and queues it for transmission.
The skbs pile up faster than the network stack can free them because the
worker never yields the CPU, rapidly exhausting all kernel memory until
OOM deadlock panic.

Since CC config and CCM TX are independent netlink commands that can be
issued in any order, there is no single configuration entry point where
rejecting interval=0 would cover all cases.

Fix this by checking the interval at the start of ccm_tx_work_expired()
and stopping transmission immediately if it is zero. Set period to 0 so
that br_cfm_cc_ccm_tx() correctly sees transmission as stopped and can
restart it later if a valid interval is configured. This also avoids
transmitting a CCM frame with an invalid interval value.

Fixes: a806ad8ee2aa ("bridge: cfm: Kernel space implementation of CFM. CCM frame TX added.")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/bridge/br_cfm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 118c7ea48c35..688c51250630 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -274,6 +274,13 @@ static void ccm_tx_work_expired(struct work_struct *work)
 	del_work = to_delayed_work(work);
 	mep = container_of(del_work, struct br_cfm_mep, ccm_tx_dwork);
 
+	interval_us = interval_to_us(mep->cc_config.exp_interval);
+	if (!interval_us) {
+		/* No valid interval - stop transmission */
+		mep->cc_ccm_tx_info.period = 0;
+		return;
+	}
+
 	if (time_before_eq(mep->ccm_tx_end, jiffies)) {
 		/* Transmission period has ended */
 		mep->cc_ccm_tx_info.period = 0;
@@ -284,7 +291,6 @@ static void ccm_tx_work_expired(struct work_struct *work)
 	if (skb)
 		ccm_frame_tx(skb);
 
-	interval_us = interval_to_us(mep->cc_config.exp_interval);
 	queue_delayed_work(system_percpu_wq, &mep->ccm_tx_dwork,
 			   usecs_to_jiffies(interval_us));
 }
-- 
2.43.0

