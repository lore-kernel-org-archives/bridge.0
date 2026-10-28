Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206058;
	b=m1QrLJrDd+VrUmpnLfosZ3g8199ssAE7GLQVjps3gKp6hPLZisXUrEFtvAU2g0444fj/
	 e91DqoHQHLfWyPbS6oU9wy/sEASmPHT9CmjlO8oXWOfGtl4bIDYK15f4zSc2ovyv5Hksl
	 XpBUdPqDBUBoeBl4G/rikHYBlGtvFl0fUGiRtA1I6vSv8QAUPzFDN5Mf5oBxykmc+ZrbQ
	 /FL8wCJ09RXNFYxdekH7kpIYnt9Vvr2x2M9ze0QRjeRkF12teOf6myzQL9wtreH2wu6Rl
	 3MqYLfDRgyFtZ3i/A+oI8/+91DYpF68r9ue7xqK/gPqp1xYhhgMmEDuL/DWXnFZDtBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wyc8C+NvW8Oi6c2BSOE1temIwM0U908BwU/ZONk8yec=;
	b=TC7R7G8JWc+PJsuO3+EKjlUlNWH91RMq+w3bg1cKZJyZyMK4dI1B3HGK+3gvHlwURPMs
	 OyM/D9S8NCixFFktuFaTQcSGZL+//ziN8dH+uuYVOy/E2T3VMYsOf5usEuiMzkY+TYXFt
	 qpm+3xHUAyR/hB3Hq/pQ2kZLOqvnC3Cs8aNcQ5o8nxfFQ0YATJwCNFAr0+PUK5vtrzFde
	 RdtDVNSlUzr7QjN6ORrV1y7QLLW3nt9ywT7vRx4p1w4GrZID/VRYuKIMPGAPamgRfDp1F
	 5hFOoxeHvfMoeI6JpyfDAdf8+0y00ggMvMdjB0u9FeJCCjnizgLC5iGWn4TwB2YQSsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t7RZdDYW;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E26606A338
	for <bridge@lists.linux.dev>; Wed, 28 Oct 2026 16:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18E26606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t7RZdDYW
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9eb579c0eso7517175ad.3
        for <bridge@lists.linux.dev>; Wed, 28 Oct 2026 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206056; x=1793810856; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wyc8C+NvW8Oi6c2BSOE1temIwM0U908BwU/ZONk8yec=;
        b=t7RZdDYW8gUqdTUsx5QXda8h3NBv3bYOr0YsGx8bfPq+cR1q3F7LS4/j2q+oHxjgB+
         tg4uIT4lKbne8fOSTYeGzbegq2VxcZOWyuPI/e2HggJueoRO2cs8Bq9aUxLZmfiZFH+K
         QVCQ4uF1R2yF5AQq5oALGU5GoTSkev+gvDbQqOZ/S2EHnuvgXLfbJ6yFE0rDxEKh1A4h
         JXpsK+jeoRlHDM/WjBlICPYHtzm97f+jEuJXish/vLnIMa3f5IncA1vOiCPf0digBgF+
         qroS7PpZ1XjxhugG0T6rY8JsFze+wHK5YQIr0f5OcvmimSF/9yDl6vBO5phS07x8xKvg
         5swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206056; x=1793810856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wyc8C+NvW8Oi6c2BSOE1temIwM0U908BwU/ZONk8yec=;
        b=y0A5iw8V3NRYrZVYf+qa/tEPl3I4AGad746hngGLUH8cYODShO0L/966elm3iMElV3
         oScp0aIfIylMAfvzJ0RSfJdGqt/2Xat2+3n1uQt8GIU195Z9mMsD0Buu6wXSULBAKH7W
         eHjFnuWDa03UQDvCx6NL2YFYh7+iJihpAXsDcxD0XJGxpjDvtLaHF1HfXi0D88CBppZR
         9Z04hHz17NXZ3vROSLZhtvd+PvlN7f4/4whuAZZuUgnKwLDAqv5KLMXqd0iQ0eHmnAwg
         1boX7gk+mwGX5jn4hE2kvY1LHXfCmm/kBwU79DEyfTGtF9AVOOtv86FRGpfoBT/V8h0J
         r8EA==
X-Forwarded-Encrypted: i=1; AKwUvBxmD8Y/Fw2UHdBgFyI2NIME3lxDfzukvZwA/uPsbl5u7tGHil0HC26Bp8FXGCvA3F8YP69z7go=@lists.linux.dev
X-Gm-Message-State: AFq9FYLdkJZumW634gPMQ3/2qoGrAammvj8y4vb13WKOizpXJWwks1Rq
	g4HjD4bBCDbE00g6UfxMNmclFVOfRkPwO2sBhMpdR8ik5Mxt+KOjGzs0
X-Gm-Gg: AYBFou0iGlfbpnuRMVtb7gTDQ9aVEMWhwUslxVEOlLR9PV/FDPkNL6bShpXqrHm6Ntb
	h51C03kwFUID2IngyByw9dNyt/t66xffjtczcfnP7DaAeDDeEZB7vgUS+WQ2X8ej03AjaEb4iub
	dnuGGcxNoKR6YRWXIRpWr3D+FAg2iv9waHvp4x08SYGgVkJmfPp1Fh2oifVs67ufDd2oK7VHz1E
	FSIg5sp9AsY+SqhiaWb/aFQ4FjUus7oEWGx7lC9TftvbzEBLS4sXCB+JTN/hx5MK0YIQBCSVpLr
	fIoHK7p4xM0gZrebtsqePP0SD2xXMl0TfyfaebS2MuujVmlCYm1DQBf9Cl8hoLaY3rUReyDD9KO
	m0P/JQ2QZ6fv3WhM1K7XzoatPPmsyBepPC+YSznFc2sGh3qqkHFs2XdbfD9Bajyg8pPTiyHWFfh
	JXEewwygdW02Eh+40j3f1Mqeyfg03Y9onUxOS6DdfWUUYOdrsmbs2xshtUPp5RPNHUX+3Pj0fPE
	X7mjN9+bC8PpgS5eXWTHKSCsXGukWbOL7xn4NtqYm7P7UAmL9+Tbv8FOmNOtvOLaSpOKISpZdtP
	CkjzagZjf8Bk/bfOSAuS2Lt0z7GwjTRdP5UkEqOE8U21KA==
X-Received: by 2002:a17:90b:3c43:b0:3a7:a463:54bf with SMTP id 98e67ed59e1d1-3ae581440f9mr1759178a91.33.1793206056440;
        Wed, 28 Oct 2026 09:47:36 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae579c5b77sm2173048a91.3.2026.10.28.09.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:47:36 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Subject: [PATCH net v2 1/2] bridge: cfm: Store the new CC configuration before enabling peers
Date: Thu, 29 Oct 2026 01:47:29 +0900
Message-ID: <20261028164730.253238-2-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028164730.253238-1-pocj8ur4in@gmail.com>
References: <20261028164730.253238-1-pocj8ur4in@gmail.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_cfm_cc_config_set() enables existing peers before storing the new
CC configuration. The receive timer therefore starts with the previous
expected interval, delaying CCM loss detection when enabling CC with a
shorter interval. For example, disabling CC at 1s and re-enabling it at
100ms schedules the first check after 250ms instead of 25ms, before
rounding to jiffies.

Save the disabled-to-enabled transition and store the new configuration
before enabling peers. Keep cancellation on disable before replacing
the configuration.

Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
On the combined v2 kernel under ARM64 QEMU/KVM, all 8 CC interval and
transition checks passed with bridge/veth and netlink configuration.

 net/bridge/br_cfm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 9dcc97d63a6f..28b40dbf4073 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -634,6 +634,7 @@ int br_cfm_cc_config_set(struct net_bridge *br,
 {
 	struct br_cfm_peer_mep *peer_mep;
 	struct br_cfm_mep *mep;
+	bool enable;
 
 	ASSERT_RTNL();
 
@@ -648,17 +649,20 @@ int br_cfm_cc_config_set(struct net_bridge *br,
 	if (memcmp(config, &mep->cc_config, sizeof(*config)) == 0)
 		return 0;
 
-	if (config->enable && !mep->cc_config.enable)
-		/* CC is enabled */
-		hlist_for_each_entry(peer_mep, &mep->peer_mep_list, head)
-			cc_peer_enable(peer_mep);
-
 	if (!config->enable && mep->cc_config.enable)
 		/* CC is disabled */
 		hlist_for_each_entry(peer_mep, &mep->peer_mep_list, head)
 			cc_peer_disable(peer_mep);
 
+	enable = config->enable && !mep->cc_config.enable;
+
 	mep->cc_config = *config;
+
+	if (enable)
+		/* CC is enabled */
+		hlist_for_each_entry(peer_mep, &mep->peer_mep_list, head)
+			cc_peer_enable(peer_mep);
+
 	mep->ccm_rx_snumber = 0;
 	mep->ccm_tx_snumber = 1;
 
-- 
2.55.0

