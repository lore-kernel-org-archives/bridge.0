Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0D25B08D
	for <bridge@lists.linux.dev>; Sat, 19 Sep 2026 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825435; cv=none; b=hA/jMvvGWJwhGDDkfSJZYcwEQFgFPFn95TgevF5TLa6Oyu+1dzWcuuxMBcOPRejw+fuDmy27aVWJnT0VL3KOQIDfqubkY/LhJGWpdna/Hymx7l4voIOptR4uOgGSNjJgMBKUeDGTwAJ6IPeYmokz/nftzifU6izjzHbnlPukBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825435; c=relaxed/simple;
	bh=twYxm8KkBBz5TtdTcshdmfGdvKHWJaaTEKzHj5SSDGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqjdFV2Lv151b5n1D/6Rk/TkyIhk8TE/IycE08MyvQ452OI1ntFoJSsOuih7yZMjKwJCWOzrM7qRQRq348huQEXs80BsoxgKcqPjbI71nJ67tSjf1qxc/id+BGeqUK5X7ET5aCdpHY4ZAe3gtHSaPPhixhPXuMyzT8Q7vBBJf2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsQbBRLJ; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsQbBRLJ"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5d4688decso16488361fa.2
        for <bridge@lists.linux.dev>; Sat, 19 Sep 2026 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789825430; x=1790430230; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+J2l1gP5MhTi9oNQGHstmZ8ANZIuRJDXJgeWc7c7qg=;
        b=NsQbBRLJPJB9RG+5xzwBP1ykDW10ZCZ6pesHDDTtuvQJEOPoQRKdNtoemqATZBgMJo
         3zudfBC30NzCnioxeFZrgxwSc/8+IKxTPzBbFxbiIsSeStEJeuLS9jcJO3+zOY11qg1i
         1mYLBb1h1hDRpT9KcC+E9dhIV9LkFXNdwk2cToK888VJFgKRFJ3cdsdsYeC+lvcenAoM
         1zGbZtWuOmDAJOzsrIZsbkvlzyYUFGiNZ5cq77AxzYnvaDTsWvmE7yyOBPYaDK1QmHaL
         wJtPpPugmktGrgnEHFhwCMf/kC9mAUpWjhTdl6KdFqmKHCz62nd8dhwv3+0dUa4laddc
         9AOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789825430; x=1790430230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3+J2l1gP5MhTi9oNQGHstmZ8ANZIuRJDXJgeWc7c7qg=;
        b=DFiEGOvH0v/UVjzp8V5B7IZOkVzmbaQyDcDNhxFg+EeF1U0qeM6p5AglgwTWJnX/6q
         rQDTo91fr/5uNVCgOd/ZJcJvQOj6draNZYWPBpew9Ib2LNiBhjEZS9D1GxO7QLmSddAq
         EZJEv3Utf/P26tDhVry+hRO7rzSTrwY/pELR/3cpCViLl6C3ygPMMnJV51TyVCIj9UqR
         ylu6a7jCd0Hcwze6ky0oAvKzzsVRcgz/ZnnFMGyDBPtrqfjIj7mUuhrELHRsWUi/Qk7n
         IR7xPP0Rs58bVL1/7VFZ6pxZ17JNLD9W1R7EiB26M7aWOUa+AYIHiJ22kwUChHn3zUWh
         kZBA==
X-Gm-Message-State: AFuF++mxjftMFMSfQuwRuLr+9tisq6wYaTdsYAIZmKjTYOw+wja1maOX
	ag2tHPzmiQN2FpoPGPhAT7P6FTtq+u9YY84CJbhBdeD76JvJ0L7ox2i9
X-Gm-Gg: AYBFou1BxvlSSlL/w8BQNrBsT3dNieArNgbBo6I+vRGuILkFkJ+HNVcDOP0+YR3YP8R
	+ftn8M6qzG9/b8ija71knoTCukIrtMfx4fjIMONnbp4OfpYLvBpvU3zt0gN+fLfocdtx6QAxn5O
	uw5S9AQ8poCOfq2gAbc30U/xULtTVvfTfqkKxXqdqfZ6FdqCdEp2YnyUHdEq1ngMfomehBTZQL+
	q6ivDOPIFgBS9ZaLzybO970EQmvSy3IWzKLl85neq1UgtIdhHsQxAsEfiy67U/nfOdYzOXQmaXc
	AxYLst1gd5afVgEtiBXugDyEsztw6AiZtWubYVhF0iGqyyk6ZJCH8RTByUdzl0a/ysQFOhdCJhf
	VB7c9XcvfB4FAamJ6ij1ssqKDgsSP5GnGdY/c0EenggAXQ8hvcHs8GigZolv+RDS2leo3Z5QLLz
	PlgVpljZc5wpBRRHiw1xCf86gzt2aPtNPAwQpnDLFfVDpq5x+Zkq9RdcAtlvewWJX8Hnp4X9zB8
	0ChztBMCGTE8hJbmBlFbnAjPmJlbYDDDOjJJc2MBOYy5qsvWgLVkRUgeb2x2HjfuZYY
X-Received: by 2002:a2e:a803:0:b0:3a3:361e:6f1a with SMTP id 38308e7fff4ca-3a5fbf5e287mr11840091fa.12.1789825430463;
        Sat, 19 Sep 2026 06:43:50 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60767aa6asm6220941fa.40.2026.09.19.06.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 06:43:50 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	kuniyu@google.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	oss-drivers@corigine.com,
	wintera@linux.ibm.com,
	aswin@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next v3 2/2] net: bridge: fail link info that does not fit in a netlink attribute
Date: Sat, 19 Sep 2026 16:43:33 +0300
Message-ID: <20260919134333.49379-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919134333.49379-1-iprintercanon@gmail.com>
References: <20260919134333.49379-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nla_len is a u16, and a port with enough VLANs, tunnels or MST entries
makes the IFLA_AF_SPEC nest wrap, so userspace reads garbage. Same for
the inner MST and CFM nests.

Use nla_nest_end_safe() for all three and return -E2BIG with an extack
on overflow. Dumps end with that error, notifications go through
rtnl_set_sk_err() so listeners resync.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 net/bridge/br_netlink.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 855a46aec3a89..fbd91b86d4268 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -459,7 +459,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 			  const struct net_bridge_port *port,
 			  u32 pid, u32 seq, int event, unsigned int flags,
 			  u32 filter_mask, const struct net_device *dev,
-			  bool getlink)
+			  bool getlink, struct netlink_ext_ack *extack)
 {
 	u8 operstate = netif_running(dev) ? READ_ONCE(dev->operstate) :
 					    IF_OPER_DOWN;
@@ -588,7 +588,8 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 				goto nla_put_failure;
 		}
 
-		nla_nest_end(skb, cfm_nest);
+		if (nla_nest_end_safe(skb, cfm_nest) < 0)
+			goto nla_nest_too_large;
 	}
 
 	if ((filter_mask & RTEXT_FILTER_MST) &&
@@ -608,20 +609,27 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		if (err)
 			goto nla_put_failure;
 
-		nla_nest_end(skb, mst_nest);
+		if (nla_nest_end_safe(skb, mst_nest) < 0)
+			goto nla_nest_too_large;
 	}
 
 done:
 	if (af) {
-		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
-			nla_nest_end(skb, af);
-		else
+		if (nla_nest_end_safe(skb, af) < 0)
+			goto nla_nest_too_large;
+		if (!nla_len(af))
 			nla_nest_cancel(skb, af);
 	}
 
 	nlmsg_end(skb, nlh);
 	return 0;
 
+nla_nest_too_large:
+	NL_SET_ERR_MSG_MOD(extack,
+			   "AF_SPEC info too large, use per-object dumps (e.g. RTM_GETVLAN)");
+	nlmsg_cancel(skb, nlh);
+	return -E2BIG;
+
 nla_put_failure:
 	nlmsg_cancel(skb, nlh);
 	return -EMSGSIZE;
@@ -654,7 +662,8 @@ void br_info_notify(int event, const struct net_bridge *br,
 	if (skb == NULL)
 		goto errout;
 
-	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
+	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
+			     NULL);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -693,7 +702,7 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 		return 0;
 
 	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
-			      filter_mask, dev, true);
+			      filter_mask, dev, true, extack);
 }
 
 static int br_vlan_info(struct net_bridge *br, struct net_bridge_port *p,
-- 
2.43.0

