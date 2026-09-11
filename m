Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962DC369224
	for <bridge@lists.linux.dev>; Fri, 11 Sep 2026 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140176; cv=none; b=J2yen/ek0OtsoUY0cZ5nw2fv7sBMKNi+1nWrEl+VLmIBBRjwIP9VDN/eY7WaeOMhnZzrYDOhB7kvGNUWdMpc6PoEz+3abIufMaWw7zUBv04ZMbli7LMZdaX85Fc8So3UC6v8Q71WJhFSRMfVx20Ozt+NCJtfyKg6/WtXbaTa/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140176; c=relaxed/simple;
	bh=XvBFvoj3NtxLfiq/QPGad++OX0rfUzOCIFlG+2oc4js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVhc1nojlwouxQEqdBc2V264xUgjtKTtNziqaMKcxsf3yakIvKbTCF4U59jgNlM9ukuvFtDsZ34T6wTPEoQhkIqVEePtd1BKsFzW17xFVsgYoAKNHuOww2QY/9+tRFVjXcMgTZgHWRwQiV2wuN3R2/7BI64wRBO4xBPosInLpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=GwjM3qjP; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="GwjM3qjP"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so816854f8f.0
        for <bridge@lists.linux.dev>; Fri, 11 Sep 2026 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789140173; x=1789744973; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uPVHK0UKh13XuzvPAq0t2DICkCsJRRtiu4q34ZJGYJA=;
        b=GwjM3qjPiSnEJa9KFAxQC7QX8EPU64QSjfsGo8p8n4Cbeq9gKnPiWrTYF2dbrNl/Xu
         fqskAh4b+T7dQZ5sm7mXwmpoQeA0BjcSm99rURv56o1JI17+adPiiVd9Jjo/XZBzVlAG
         ZqloBUnVl9T+pZYSx3ZutpbDq5/7Y8YmT8pL8mnzCDjgS4L+Wc9fa3OJ41nnpkx02vK4
         yGlqooAgpNXasKN4247uh+mQhxuJdUrmoR2L8zQTatZixY/QO6hDZejmW+QFGedar12P
         wlrogwROKmrAr04HC3Lp7yjKRizjaaQedSdLLjMC/xIBYW2IJqSzrkKhbd+PKHAjj0fg
         pOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789140173; x=1789744973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uPVHK0UKh13XuzvPAq0t2DICkCsJRRtiu4q34ZJGYJA=;
        b=EMabmwPP/4mCui9v+KvXBv33An/4KQ/AKlgRv+Aca6w482ozvKCRefEP5TO5KFCtMw
         gUpCNhVDuzbW6n5ioBQnvHXhinzDoqJDGg0SiILDl9pLThcQjlt9mq6Bcj0uTFdyrmZt
         2rIsdvMHo9PARkrLLWqfAU5bEeGFsh+9n3wIKqZWHzR9UJE9YR5jAEeJqyXH7q1VFxda
         uQdq0yKtdILRku8zFEdAwSNNDFTxouLtxG6PwzieLkN7Ufh13SXERSjh2w9iQnD8VVXC
         ycoj69Kxg7mCrIfLHEJ3FwrkF2nXsyyHlFpc8eL2r7u1ZgWYMz82UF9wIl8cXpd5fmsw
         Kzug==
X-Forwarded-Encrypted: i=1; AKwUvBy/crNX8cBnePaQUMySgq7zqUphUI5MJYQcl5xC6kew8DbmRIjmKgdsd2LeyU9EGU9d7olHeiE=@lists.linux.dev
X-Gm-Message-State: AFuF++lrzrkr1LlYXSKzFHJJLxgHQCYUgxd/knnuBi8btEKvKRTJX7Uw
	vOdNLTT+ZApJNR2bw+r+bQc7X5fKsNZr70X3joUE4lWrwC3a+ts4OPtdUFux7Pw4GRs=
X-Gm-Gg: AYBFou2B1X9EZraN4qFG3em+/rVgfCqzHN77LPOPixyjH1kCl3ZW462wtntfafKnX0J
	sJw8+QsjOBcnpu1l6mKvW02uLdUS1h5zKk8dRcZlwjhwma0ycfIedDfKx8FymjZ9IB948T+R9Zp
	ACzg2fnIU06XECWkAUu4MBTxCmw7in6n7OSUv6sYv3enwmUTkFFsY96eA9IhGMdl44gkCWvcafn
	SgbQvI+vrkcXJU3NLv9qaiGxdpHE6NwIKpPLoy23NvmeScBx4AlSB0Cd76AXjJplK6PUYjw7lKX
	gl8gW1ZhqBrNoiH9Cx2v3nOQTgw2/rKTQlJqpHO5B5mxS4rM3hQPiQueEPENd4/323+s3sKD7GH
	sC3dtDFfJDm8KYAapQK8ZauJTB8J4wZ11kxv7TGbxvZxN7ieHpC1xq3INlGSrp5q8G8sUPFZgon
	3aegs5iu3igebs2mLo/P4Tf3nFaP4t1dTb4q9CFQSFQVst/JKOwcUX7dVPvMdbDiyq+lILWhyru
	0DVNHIjAmI/KqNR6p7ELQ==
X-Received: by 2002:a05:6000:4b1d:b0:484:3312:f127 with SMTP id ffacd0b85a97d-486eb35fc9cmr11591303f8f.27.1789140172622;
        Fri, 11 Sep 2026 08:22:52 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-486eb34e608sm6815862f8f.23.2026.09.11.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:22:51 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tobias@waldekranz.com,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net] net: bridge: mst: move switchdev call outside rcu
Date: Fri, 11 Sep 2026 13:50:21 +0300
Message-ID: <20260911105021.1385934-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up of one of sashiko's pre-existing bug reports.
br_mst_set_state() calls switchdev_port_attr_set() for nonzero MSTIs
while holding rcu_read_lock() which invokes the blocking switchdev
notifier chain and may sleep. Nonzero MSTI changes come from netlink
with rtnl held. Move the switchdev call before entering the rcu section and
assert that rtnl is held.

The call cannot be deferred because netlink needs its error and extack.
Also DSA reads the old bridge MST state during the callback and checks it.
A deferred callback will be late and will see the updated state.

Fixes: 7ae9147f4312 ("net: bridge: mst: Notify switchdev drivers of MST state changes")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 43a300ae6bfa..ce537cb71fe8 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -107,21 +107,24 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	struct net_bridge_vlan *v;
 	int err = 0;
 
-	rcu_read_lock();
-	vg = nbp_vlan_group_rcu(p);
-	if (!vg)
-		goto out;
-
 	/* MSTI 0 (CST) state changes are notified via the regular
-	 * SWITCHDEV_ATTR_ID_PORT_STP_STATE.
+	 * SWITCHDEV_ATTR_ID_PORT_STP_STATE. All other MSTIs are handled via
+	 * netlink with RTNL held
 	 */
 	if (msti) {
+		ASSERT_RTNL();
+
 		err = switchdev_port_attr_set(p->dev, &attr, extack);
 		if (err && err != -EOPNOTSUPP)
 			goto out;
+		err = 0;
 	}
 
-	err = 0;
+	rcu_read_lock();
+	vg = nbp_vlan_group_rcu(p);
+	if (!vg)
+		goto out_rcu_unlock;
+
 	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
 		if (v->brvlan->msti != msti)
 			continue;
@@ -129,8 +132,9 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 		br_mst_vlan_set_state(vg, v, state);
 	}
 
-out:
+out_rcu_unlock:
 	rcu_read_unlock();
+out:
 	return err;
 }
 
-- 
2.47.3

