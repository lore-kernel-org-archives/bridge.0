Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6046EF79
	for <bridge@lists.linux.dev>; Tue,  1 Sep 2026 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248461; cv=none; b=Wn9taXNUoa5F3zGVSe6waS+z2Q+1b8cwilXrtc06L4o4GF2Ed/svBu9j0Qh3GGqc+TmoqM13H5ocQvcT64W0hFwuc+v2WjxTtQBHoXgWxMS+1bPnjQu8PgDBcIzj5Q5F4N9n+98z20oghKpOTHC5hxW5ykM2CcVH2h4sSaVJpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248461; c=relaxed/simple;
	bh=d69I/cdvJ/o7q3nW7vBwryI/iZgtGSueqw1aSs5Y1TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1AhenhSZwXfN4vxieqc1sBTT3SrmzWEIZtAackGv17YAZNXJE76ylVOsWDElTweI/vmQUMrftxA9GV7BeHGAo6BUnrJuHK09eqMQMB1PvUFdYxK5aeuUJ4/938tEoETo+eVL5+iaKR9C/1TDscnkMoOeYLIibYMpwbfbfsRvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=d858OmCc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="d858OmCc"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48442ea8f59so303239f8f.1
        for <bridge@lists.linux.dev>; Tue, 01 Sep 2026 00:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788248457; x=1788853257; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WzxcW1LLqwVWe0wSU90DzGvke623LGpZQMtqGLDr5j8=;
        b=d858OmCc8M9moLCPVdnqVTzbtEWqOGSP/4SB8dLZWLNEysxUvlT7ciNvj7g0Ezskxq
         lDytml+sGQGLS6n8oW78JQMngu5VOzcKYMeczlwF+Ii36VhvPmtNyPOL1jKPgy7U1PFA
         Bh77YsontGDTGfXvNw0dRBhjw6Krf6Yk9ToF7JhMtmQwKE/uHHCFvLz1vnX2peEo+sUS
         +FztrjhCjbVPLUq+oeyRPhdrPi4zugDZewb0G013I6V7egpJJvIlQy3QA2K2kzSy2YPf
         YkPWz0483rZvsB+mbhOzUJamEgQbE86f6x+/zR/P3brSZAb95Jwpc6QZ+0P0FTmJACI8
         4BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788248457; x=1788853257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WzxcW1LLqwVWe0wSU90DzGvke623LGpZQMtqGLDr5j8=;
        b=Y7JOcz0C5vitkCHw04oqXnmmZtzbdTNuvAilYiZwCivZ9PxzIh/xQKzem9aqlGAl4P
         WXqBTSF04QhCFC3ZVsTJ14Dx0XylDoHxUJYiEHHcWIMWLCTKUSLjFjUfn8Ax4+N1pkoq
         /uhih4zlCsEDmky2rxBOFtEYoWPxsgfqw18i+5NIPw6X53glnjEIuckveTmEfc+B3ruG
         hrws0u2aHvZ2GqqkwwmECwkLZ684jSg5MdcBaHvDA0vNnLKEQSkkbal4CPBTiM7O2/4Y
         Zwod8Xj8IZU/yq1w6W639xtktIDDzU6nXYt0NtgZrH2SHUHudJOEoheSfawXoPR0Omgg
         uMLg==
X-Forwarded-Encrypted: i=1; AHgh+RotiC8bHbGSdE197Afxd0T7+WvQIzhz1de/rI4MGObLUqFlMqhdpL66TQ8tv8jxWCiztHf0lcc=@lists.linux.dev
X-Gm-Message-State: AFuF++kZNQWyiiSlbJTbgupZv1q3WYv1qX2VZTgmgYH5usHotpk9tjov
	A0l/f7XqcL+HKSp6W8wxbBJYb88LuX2zA86YTF2D8ciFQM+itWxTTmp33Il+ygW4j8U=
X-Gm-Gg: AR+sD12VPaS38Olzulfol3gu/Xwtdloju0TykxpC4f+xRvQsrboCI1R6GFV34fCpI2S
	/ngwn+JKGjKeJ/iMuvaq/b0WC+YwDdy/4D7S8UvEcWdXpE2PHPa0YIHh3w8uFHI06Yq+MtCpTQT
	JisSkT28gD2yY08lHX61cZ07CymaUyXYo/4yU2YzrU3nT4wVD7Q2nFqyyGOa1VEl4xwjWZqZOWT
	AFVaF9rj+kTs+Og0+EoxlYIRZeajFq7IKmHanWr40LBiJmSiwouKBgMQ6CUo3je36bKLSNLigAc
	SqbXdsR26F0Yfdu0ziOy8Ya7X+ibcTBCwWm0Qz7c0v8UiOVMDeuEcZsW/RRf/5Ih4Bna1otYfye
	2PjI4DS3paMpmmEv9DXQi2AW8cFkGSNgmElL5MDt2HHGpJgvypeudb0agbAH12oAy6zQMGQotVZ
	wJ/jjywojpRdsyYCzEFrbhzftC0rQPKEoQ7i1yfC18/+/nvkks+G31pD4GEgIO3LH1XUPpaEs0i
	Vr/fjODWR0=
X-Received: by 2002:a05:600c:217:b0:49b:9105:e831 with SMTP id 5b1f17b1804b1-49cdd635db8mr37882095e9.7.1788248456986;
        Tue, 01 Sep 2026 00:40:56 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d3c4absm3142913f8f.10.2026.09.01.00.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:40:56 -0700 (PDT)
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
Subject: [PATCH net v2] net: bridge: mcast: fix br_multicast_list_adjacent rcu walk of mglist
Date: Tue,  1 Sep 2026 10:40:46 +0300
Message-ID: <20260901074046.316190-1-razor@blackwall.org>
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
converted to RCU. Fix it by acquiring the bridge's multicast lock for the
mglist walk. Return -ENOMEM on allocation error.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Fixes: 07f8ac4a1e26 ("bridge: add export of multicast database adjacent to net_dev")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: while changing this fn, return -ENOMEM on error and document it in
    the kdoc (sashiko)

 net/bridge/br_multicast.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3ef5d8bbf552..97686984de6d 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4936,13 +4936,15 @@ void br_multicast_set_startup_query_intvl(struct net_bridge_mcast *brmctx,
  * snooping feature on all bridge ports of dev's bridge device, excluding
  * the addresses from dev itself.
  *
- * Returns the number of items added to br_ip_list.
+ * Return: The number of items added to br_ip_list or -ENOMEM on memory
+ *         allocation error
  *
  * Notes:
  * - br_ip_list needs to be initialized by caller
  * - br_ip_list might contain duplicates in the end
  *   (needs to be taken care of by caller)
  * - br_ip_list needs to be freed by caller
+ * - on -ENOMEM the caller must free any allocated entries
  */
 int br_multicast_list_adjacent(struct net_device *dev,
 			       struct list_head *br_ip_list)
@@ -4967,15 +4969,20 @@ int br_multicast_list_adjacent(struct net_device *dev,
 		if (!port->dev || port->dev == dev)
 			continue;
 
-		hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
+		spin_lock_bh(&br->multicast_lock);
+		hlist_for_each_entry(group, &port->mglist, mglist) {
 			entry = kmalloc_obj(*entry, GFP_ATOMIC);
-			if (!entry)
+			if (!entry) {
+				spin_unlock_bh(&br->multicast_lock);
+				count = -ENOMEM;
 				goto unlock;
+			}
 
 			entry->addr = group->key.addr;
 			list_add(&entry->list, br_ip_list);
 			count++;
 		}
+		spin_unlock_bh(&br->multicast_lock);
 	}
 
 unlock:
-- 
2.47.3

