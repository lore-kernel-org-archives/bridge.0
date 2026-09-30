Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC792449B3A
	for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752503; cv=none; b=MCbjM4GuZGpDQGLzYvWOo97c4WkPP8X3WZEpePHXmYmG8sQc0Uff6OUXbqNzCUR2QYTAjkMYkY2ExjrtiTbVG+AaOY6b9MqAcQ3P3oI9qIHQ8fyHIVKWdzvO+wAnt9MvzNF6/TzDb615EDD9ea/9v69JbRgmkFErhJQWnPme/48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752503; c=relaxed/simple;
	bh=HGcuEmCO1LQ0WKJA5UC1Yie15kNyMhHRdI2k1TnxTL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz+eEQf4McDdcNrpnICg0VNLtsS5RecU23P8yK8cdShhPwjjU/fDgJcLSmgTrGtvt6uxWXOkvJm87wiYr4j87lS2CWZ8e1bfyrO+vu+dM7h3/1kpCnr50i2RyJr3t4eMsc6lfsWHxh4v8o5cEfiB6ecC2YpCzxYltvqxd0lY0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=c52hs/po; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="c52hs/po"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01c4f4daso158405f8f.1
        for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 00:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752498; x=1791357298; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pwxGLqNQgpZLReeYWZoTPk0vbZx9ySXeua7zM2Z2aLA=;
        b=c52hs/po37ocaiHyr/GZLcVbd1M9Rd+B8tgqUsXks4k9j6KbvE+MCZQ+vN0r40atf6
         EC7kB1JvHA9PkWZqEqYAE6eAuGwDVVtScGfN49i36RkW1JpCjklT/aIGP3Y1FdaQAR7m
         DJ1IsSZ2jolt2ObzJPtZR039DBvod4sn/RaL2lk6nHhWufjgq02z4d0qEM5jZo+tfKhI
         6bCUiWFreYvlkDbMEO6bQ2gE1Uva4eG6GcWcLw6uEFRJbpMVXHV834phG8AWQziBICWv
         OcPx7YkAf06h21hTYQK06q8XmdOvcBAJ+YOYuzMQ6kW8Uflg41XTJgcDqEQQpA/mhxkP
         vsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752498; x=1791357298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pwxGLqNQgpZLReeYWZoTPk0vbZx9ySXeua7zM2Z2aLA=;
        b=Q0NBp7eJ8BIroehocx7ioJPyeC2AIM3qsvw3R4qvmVRY0ZoVr+refJ8ZDaG3T9tkJs
         V3B+WTWYArogzU1Xxa3569qQkIVH2FMQRlUsleWl5+0TQuhGbVMKHFDcMmClX0aw2pzi
         QVUJGJvYvauyjrAPn8sbDgy3iLnRPcp3sQea8XPD9XxoOnj3LF1B71Iv8YDpzNBefXga
         En8OB5xPb0ZqnADaCN8jc7ptfy8nVxO/0XhtmSHLwOxph04zTw2mKEO/ImGD5i+qn2vP
         aU34naWa27spbhL5UEi1h4qVLPWgMesLL7Z2dYnSmx4Fn/Ls9/vGhMszcPGQkuzuAzOz
         pOng==
X-Forwarded-Encrypted: i=1; AKwUvByUEx9ILdYxufZxqmwP27gs6AbnmsMX5pKuflle+6GVhT0SH64n2wzOtvHet06cT6Ns7DYP/Ks=@lists.linux.dev
X-Gm-Message-State: AFq9FYInI7z2Ru3iEBvFc/NpgxmUDxkwbHhsOFfZCCnpXZJQonznueQ/
	C4YAfgs7TGvDI2A39G5jzR/hATOBQ3dL6qr49lJFTFkw+M5LK7wl2vr947vyCZ3Ejn8=
X-Gm-Gg: AYBFou1bOddjGKK1oXzmKBd6G6r/0/usi+WzxJBOh6VCd3OmETrbJ8cxsjfSjFONBkY
	1qbByoUaUWAFxzK2FP7+m4IOHVzO7CMam1pRhz8dqBi+SZRzTIIgddY6RyOMoMYC/3aZWdEIy4a
	Cscl78WAmHmRXN1uP4DPUOwrWxds4a+Ugaro+YmS2hk1oMO82IrmAHMzhWsVMvoasUd+E3FWxlr
	5IdcmCBk2/jidpC4YuGe/fKwT3Sscv5R22Gq2bg03p/rpqM+nLMr7wX3IAkiSwuzjBFNKPM2yNs
	xTA3PB7nH1ztVz1IIpgn4lGrzShHAQrJVWSUynVUHUya/cvGQEuCJuJCNKT48fyLecIWwA7I36v
	4PuACnAfElsXpaFCXSN4fA0OgeScfnz9kqdhmygA7BRMtznu5rwKs+l7Jb05X8V+MrrbYaPUJAT
	uoKpOfhaIzdu1tytMX+fDYaeqd/eNg0cG7VH2uyUG1KZ140DE9bCBBf7N35q1d/hPzqAczqICNe
	MJ4KvJim1r1DJtq5nqe
X-Received: by 2002:a05:6000:1788:b0:488:8ad2:e169 with SMTP id ffacd0b85a97d-48b0255cce1mr902065f8f.56.1790752497656;
        Wed, 30 Sep 2026 00:14:57 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48b029d99bbsm1222968f8f.16.2026.09.30.00.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:14:57 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 01/12] net: bridge: introduce a bridge destination type
Date: Wed, 30 Sep 2026 10:14:00 +0300
Message-ID: <20260930071411.2786201-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930071411.2786201-1-razor@blackwall.org>
References: <20260930071411.2786201-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an opaque destination type and helpers for representing bridge port
destinations. Using a separate structure makes raw pointer assignments and
comparisons fail at build time while marking its value member __private
makes sparse warn about accesses that bypass the helpers.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_private.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 67117fb3dc88..1146187aa2ba 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -306,6 +306,10 @@ struct net_bridge_fdb_key {
 	u16 vlan_id;
 };
 
+struct net_bridge_dst {
+	unsigned long __private value;
+};
+
 struct net_bridge_fdb_entry {
 	struct rhash_head		rhnode;
 	struct net_bridge_port		*dst;
@@ -670,6 +674,40 @@ struct br_input_skb_cb {
 #define br_debug(br, format, args...)			\
 	pr_debug("%s: " format,  (br)->dev->name, ##args)
 
+static inline struct net_bridge_dst
+br_dst_read(const struct net_bridge_dst *src)
+{
+	struct net_bridge_dst dst;
+
+	ACCESS_PRIVATE(&dst, value) =
+		READ_ONCE(ACCESS_PRIVATE(src, value));
+
+	return dst;
+}
+
+static inline void br_dst_write(struct net_bridge_dst *dst,
+				struct net_bridge_dst src)
+{
+	WRITE_ONCE(ACCESS_PRIVATE(dst, value),
+		   ACCESS_PRIVATE(&src, value));
+}
+
+static inline struct net_bridge_dst
+br_port_to_dst(const struct net_bridge_port *p)
+{
+	struct net_bridge_dst dst;
+
+	ACCESS_PRIVATE(&dst, value) = (unsigned long)p;
+
+	return dst;
+}
+
+static inline struct net_bridge_port *
+br_dst_port(struct net_bridge_dst dst)
+{
+	return (struct net_bridge_port *)ACCESS_PRIVATE(&dst, value);
+}
+
 /* called under bridge lock */
 static inline int br_is_root_bridge(const struct net_bridge *br)
 {
-- 
2.47.3

