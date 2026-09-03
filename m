Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568039A070
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428407; cv=none; b=LM4bhTeIvRl0lo1WWN6MbAuMoXX0CfR6KHhjqvuumV+64F+x8V51t6E+cZwnTtkoOzVL2PFiTWqN1nqdgfdl0JLkaU5eJPPHzwJ7j4tXnpSQ0zw/UV6vJr9fu6SwU2SrJi031BU+anEXuwpQ9m4/3CTc4b4jk2Mg2I0ZYk1SNm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428407; c=relaxed/simple;
	bh=wz4keuX0h1t4uesVF64NbRSyPXsVWi/lr7DkR/S5oT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jYZAcl0xZTHdsE8wjx/PdLN9em0ZNEqVLBM3gVdX0DFKzmtE/zAPR5xsg2DPOb2ujfV7YqBosaWx9cVI28gu0KFk9rojgWJF479SAj+mKbFnxtDaGEX5SdNrpC25bG7SsIPqOGnsFutVsD6vs2k3W+kJ69wV8JeQ+28zKkjQR00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ISYGJNSI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ISYGJNSI"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-485852d03a4so45710f8f.0
        for <bridge@lists.linux.dev>; Thu, 03 Sep 2026 02:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788428404; x=1789033204; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bNVK+ncMXTVlIksAK/ckFMkJgOdGgxwOoFQ9vZoAv8s=;
        b=ISYGJNSIGpboW5zNWr11hhO1XrFmDdVsWK7Is4OAG8P7tvRqHMfSqZObKX/t6CzVuB
         aWqnBhTP7BsEqYnvzGHI0cZFkm9yrB+nChKXGm4iQP6NpHcO3HGXfyPRcfsbVbI/9CPW
         6lTDoBQS65TuvIT2tKqza86bbEZgQhrouwWEBMcVsTs9pjGxkq0Cvxjy7I62hJPFVn7D
         TbHZ5Cw6CyhL7GDN+7ILEC2IS127fE0gcJdOJ5ZDtuB/V2RCDI2avnHpuIR1PtYy/Rux
         mRIAYZdVv09Nek7O62DCTj/mVQnQZr5L+Ni30LLioerxtizD9ToDk/Cx5jz6tq984L1c
         NWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788428404; x=1789033204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNVK+ncMXTVlIksAK/ckFMkJgOdGgxwOoFQ9vZoAv8s=;
        b=ZKF8pzo0IIItR9vTv0cri+SrwaG61U954pZhcVILyutMKBf+rr/qYoIuyOQ3i9HLoq
         N4g+fL41DOLP4KjpqMBcw/BwpHw/hqiKXjF+rem/fqgUfI70m1Rw4Tyk0Sv11K9XQyLe
         L/RlIYl7LhoPGUWnhQL7R/l9GROaGZ6KlIWW4WJfAteABThwR9trlITs7uWTpx/EbRPU
         9h/+c+v7/FpTPrXN5LrCUTuBgt58L0K1kh9Sps5hoFDpYjXGm7oS2OluhvpZdfQB2msr
         baFQAorx+IXBmyQx+ePFiH/XPIgz4aOKat2adB83CuvaS7ZNaYAcLDbUrsd49W5/oBly
         EIKw==
X-Forwarded-Encrypted: i=1; AKwUvBxC8SAfaFwRrp7R2yddBVhgm7YZ5YUIHa4wbW6LuusAamhPoXoZANokWPm1s5hFwav50ufMaSI=@lists.linux.dev
X-Gm-Message-State: AFuF++njPEeyxqBoV52VR/+hUpjlwSeqC7vCSH6hBJT1Kc587iTCW4RD
	CUsD50krkEGWyfbiwTviiyTqdOabEqgdTF918kK1FulFlb92N3W2ONJEjV3jKoinAr8=
X-Gm-Gg: AYBFou2KkIktoZ5wjpE0do6wM8+YBPvjFKIK6qOFDGa/OE4JH3HV/SjkoB2BIVzprDO
	uXaZcf/yNGugBZLF/MtIzjVz8OkGG4waEcV3b/AD0XWTf7dCJPe4DKNgkHByJMHCUAYdyDNan8l
	VX6Jvwa+CqcBpC0YcnpyjbpWWGSEn3nQjr3zQ5jWdjMr341SYnmJPi9y46kGCDgmf329FDox+yS
	haknbkL1GN8oxON9slOf1aIICPLQHbbFiHwAoBPxANcF4zFdqXskDteRZxNVb7EFHc9RryiGQDa
	dZxFtepKUcllNzjkV5xKkSwTYNUNP7SlEUp6RKSuOzyKm+Yf0IYWPHXQCcRXM8a/1i6+6A+Re0c
	aGGNWpwqHWA+4iWzvX7EhqOP8ekHFA5W5GohFYTrJ4lmsyRIcVO/52KuyH/ndnXxdgvJIOhCD10
	Ht5nCPP8IC6GNZC7q0LIlPBvQDrAz9GcxL27ScSBGBUi5QBINFPnhLdEaeP37NtF9E5t/DPrS0s
	dCo3kdZ2i0=
X-Received: by 2002:a05:600c:608c:b0:49c:cedc:3c36 with SMTP id 5b1f17b1804b1-49ce5826c6amr221601125e9.16.1788428404306;
        Thu, 03 Sep 2026 02:40:04 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49ce58da3acsm235767525e9.0.2026.09.03.02.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:40:03 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linus.luessing@c0d3.blue,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net v3] net: bridge: mcast: properly convert mglist to rcu
Date: Thu,  3 Sep 2026 12:38:51 +0300
Message-ID: <20260903093851.1494297-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko reported a bug [1] that br_multicast_del_port_group unlists the
port group not using proper rcu helper that preserves the next pointer and
after that immediately frees the port group without waiting for rcu grace
period. The only rcu walker of mglist is br_multicast_list_adjacent() and
it turns out that function has always been buggy because mglist was never
properly converted to RCU. Fix it by converting it to rcu and moving its
initialization after eth_addr's. Initializing p->next can use
RCU_INIT_POINTER because we have a barrier from the hlist_add_head_rcu call
later, besides we're initializing an unpublished structure anyway.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com

Fixes: 07f8ac4a1e26 ("bridge: add export of multicast database adjacent to net_dev")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v3: a new patch, it converts mglist to rcu and moves the publishing after
    all struct initializations
v2: https://lore.kernel.org/netdev/20260901074046.316190-1-razor@blackwall.org/T/#m62e08b85f208b1c438e2fda2d5d8eaacf0e96c6f
v1: https://lore.kernel.org/netdev/20260828100642.2664347-1-razor@blackwall.org/

 net/bridge/br_multicast.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3e9b10f8abf1..2f9bb30e1a1f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1441,16 +1441,17 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 		goto free_out;
 	}
 
-	rcu_assign_pointer(p->next, next);
 	timer_setup(&p->timer, br_multicast_port_group_expired, 0);
 	timer_setup(&p->rexmit_timer, br_multicast_port_group_rexmit, 0);
-	hlist_add_head(&p->mglist, &port->mglist);
 
 	if (src)
 		memcpy(p->eth_addr, src, ETH_ALEN);
 	else
 		eth_broadcast_addr(p->eth_addr);
 
+	RCU_INIT_POINTER(p->next, next);
+	hlist_add_head_rcu(&p->mglist, &port->mglist);
+
 	return p;
 
 free_out:
@@ -1465,11 +1466,11 @@ void br_multicast_del_port_group(struct net_bridge_port_group *p)
 	struct net_bridge_port *port = p->key.port;
 	__u16 vid = p->key.addr.vid;
 
-	hlist_del_init(&p->mglist);
+	hlist_del_init_rcu(&p->mglist);
 	if (!br_multicast_is_star_g(&p->key.addr))
 		rhashtable_remove_fast(&port->br->sg_port_tbl, &p->rhnode,
 				       br_sg_port_rht_params);
-	kfree(p);
+	kfree_rcu(p, rcu);
 	br_multicast_port_ngroups_dec(port, vid);
 }
 
-- 
2.47.3

