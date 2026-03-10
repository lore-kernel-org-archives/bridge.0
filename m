Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A28727816C
	for <bridge@lists.linux.dev>; Tue, 10 Mar 2026 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166703; cv=none; b=G2OeRhsELY8D6U2GOjjp8x7MLO8zCa1AgABtrpC/tTNm0wjljdD4LRbJl64qLEPIlbeU2jakXaSFWobFmmW2ROdlVE5CmLWnVwJMNojF4SUY4dRNOv8e3y1I0x8S6ToXgcuXwpI/kc9tFioMAe6RLNkB35h3AcGIzNr2JgGx37E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166703; c=relaxed/simple;
	bh=S0NmHKlyhSFgA8uUlP72LP4EgiMjzY4mLhz3uLdZL2A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JygVvim7dU42aHvUwLROXESJ0CUIcw/vrjof7JDlYu7bSBVMQfzxOqivFMGupg0tDAq1u0Gng/P3NGDjXgUSWa84fPQVMxh3bkr9jfRpKNHYJRo1Rz7QE5xwo7mEA6oWnrR7YJR/LqDPs8UhTmZBdfw/21CVzXSYP2LhR9zvsMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpBbWi8V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpBbWi8V"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ab077e3f32so59529655ad.3
        for <bridge@lists.linux.dev>; Tue, 10 Mar 2026 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773166698; x=1773771498; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rocOqQ0GGRQ2FFD3SaYh+qh681ItNUFgfBnjMmi0fOY=;
        b=NpBbWi8VNbUwtWONTdaFf5qEMXmte/eTDmR4e6n4wBUIjTn9dUit8XqmtH4HvD6uK7
         kmBXyZ72qhhGXI5Wixqsdlmn9lpiF5QxZWW73IaNsUSCijrLeiHp0BejMY3kyWTvkmvF
         D8MQjjIFfEQPPWJ9del8YgTKVzs8AWhqbMnTyzOiMKJh0E1yx2p5s5FiX1HmIpwLwgB5
         rRml8rhysRyHft6fdQOPgQfxuZPQVfO5umlA36826ENOoiv87SCw52Z54fn96mlm8E3l
         WS7Nf+KLK21PIMLOqanNc9YnS3TrcKkIG38732mbI+OxVIznzptL667Fh+GWWs+LTKHt
         DREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773166698; x=1773771498;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rocOqQ0GGRQ2FFD3SaYh+qh681ItNUFgfBnjMmi0fOY=;
        b=L/QxQu+cHybyOdMyDqe4eCVC+FPBHuX3VQTkbrF+WwIsJZPZ0s+yQAg+Fgy4US6GdG
         KKJmaNmASPbCOYXkq/DU5l9qggKjZURAHPuTF6bVisXUnuNVNFSLx75xp4lYGFTLhwbR
         FR+w3ZFFckoxwBMzn5C5WlppLfE3eimRJYhmUYmenclEjYIkDQ65mxFI/5ALhebYd2HH
         gEm7CTZxJKqZkiwxiGN8W7oKNg7leKYqJEzxmG6h68r7zAIzJRQb/1Gz4x69fQftC6i7
         aCgQ4BeKbOCxoh+yerQUzBxEK13UM2yaUFfhcp5tMoQKKI4lNeA466HKc0M4ke3lCGiT
         xhnQ==
X-Gm-Message-State: AOJu0YwjnPZkGvbx8paq3N0/xCoS2yeiEpCrjwHcve0QNKCMnyJjr7bt
	3VLKxzXWplUBOzePkor17SwzZn2uwYg12MaUWlW7MEtXcbdrjSllbNDk
X-Gm-Gg: ATEYQzzXO6ImAWXkagnPNpgeS/xWPY4Zx4RsJWGVZ+QrJ/P8SqMvRQZ0X8TpJkgaKN0
	xRfs6kKnCgYEtmVGF5Vm36Tiqkfy3hbBSmg5ALFu85Re2OzrTV0+FHSl9wD7H6rYlp/Fmc7h3Q4
	Qj3qukzSKqgNrb/Vaa+/k03SMqi1brSW6Yw/cHFS8jJ6HBol+s1caM13iv+rSxN1MGZe+raC9CQ
	jzOzsVKZjr2xwt+0X1ROC6I6Ix6dCUIdtvTKme29XWRjKVrPgntcTiq2hxXgxTcNjl/qtPlE6JN
	bghQHd8n2W7jhmFpkmQI37Djo21rLcSxKSAMVqUFkxsfbswhN0yu8g20tGMmJzD8HfAN09YuWvg
	eFDPV67AnOpgabuPKEtl7LC3tdM0ireMspVtlknl/TzNaWFc/ZBKcWRfDrR+ycYbmwhDUYUWMUh
	6TsaUHuCEbo8rdpLWiaUlwAJiwEJjTj9Nc1JPnnpYS8w==
X-Received: by 2002:a17:903:1cd:b0:2ae:62c8:771a with SMTP id d9443c01a7336-2ae8241e451mr165342805ad.5.1773166697905;
        Tue, 10 Mar 2026 11:18:17 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aea4eed00fsm51159255ad.80.2026.03.10.11.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:18:17 -0700 (PDT)
Date: Wed, 11 Mar 2026 03:18:09 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] bridge: cfm: Fix race condition in peer_mep deletion
Message-ID: <abBgYT5K_FI9rD1a@v4bel>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a peer MEP is being deleted, cancel_delayed_work_sync() is called
on ccm_rx_dwork before freeing. However, br_cfm_frame_rx() runs in
softirq context under rcu_read_lock (without RTNL) and can re-schedule
ccm_rx_dwork via ccm_rx_timer_start() between cancel_delayed_work_sync()
returning and kfree_rcu() being called.

The following is a simple race scenario:

           cpu0                                     cpu1

mep_delete_implementation()
  cancel_delayed_work_sync(ccm_rx_dwork);
                                           br_cfm_frame_rx()
                                             // peer_mep still in hlist
                                             if (peer_mep->ccm_defect)
                                               ccm_rx_timer_start()
                                                 queue_delayed_work(ccm_rx_dwork)
  hlist_del_rcu(&peer_mep->head);
  kfree_rcu(peer_mep, rcu);
                                           ccm_rx_work_expired()
                                             // on freed peer_mep

To prevent this, cancel_delayed_work_sync() is replaced with
disable_delayed_work_sync() in both peer MEP deletion paths, so
that subsequent queue_delayed_work() calls from br_cfm_frame_rx()
are silently rejected.

The cc_peer_disable() helper retains cancel_delayed_work_sync()
because it is also used for the CC enable/disable toggle path where
the work must remain re-schedulable.

Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/bridge/br_cfm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 2c70fe47de38..118c7ea48c35 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -576,7 +576,7 @@ static void mep_delete_implementation(struct net_bridge *br,
 
 	/* Empty and free peer MEP list */
 	hlist_for_each_entry_safe(peer_mep, n_store, &mep->peer_mep_list, head) {
-		cancel_delayed_work_sync(&peer_mep->ccm_rx_dwork);
+		disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
 		hlist_del_rcu(&peer_mep->head);
 		kfree_rcu(peer_mep, rcu);
 	}
@@ -732,7 +732,7 @@ int br_cfm_cc_peer_mep_remove(struct net_bridge *br, const u32 instance,
 		return -ENOENT;
 	}
 
-	cc_peer_disable(peer_mep);
+	disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
 
 	hlist_del_rcu(&peer_mep->head);
 	kfree_rcu(peer_mep, rcu);
-- 
2.43.0

