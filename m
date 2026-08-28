Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5440B0EC
	for <bridge@lists.linux.dev>; Fri, 28 Aug 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911620; cv=none; b=trWF8qDIfV9Z0EjlFx8VAd80IOym2JE6foq5LOdmxVSf3SzSPl2IBtcFR8ysjGPxoZgIptKUAzCnwlSDab018lsF9qcdHpZ9a1wWPh/K/xSNWZxUE7HZkBhY1mxLY0tE3zmFxRminXSDmfCJfMT/bjqr1by+kg9Omk7TbVYZb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911620; c=relaxed/simple;
	bh=pW75mykq4qb5j9EYWFECBMjJsWX/64+SnhaNBfbhy8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uw61cy+rCYyOPAQQjXxBltDMLChfwkQkvmBFKdX6TsJaCRQlYvV3/8/LeeTXQHzoUPoy8ZZj+Ej9IZLkUf3Zs6YM6eIe9lSigX9XADMasZxuMsNPXL8E/8mpsAMkxQaxM9CuqvuMB0h8PT4DXww3bofGlbibPdyvZVyYjQDcIwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=el6aQLTj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="el6aQLTj"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47fe89fb333so479814f8f.3
        for <bridge@lists.linux.dev>; Fri, 28 Aug 2026 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787911616; x=1788516416; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L2d9aOk1DG5PJgTbHtKObATO+j7rQRq+47Wx1t8d6YA=;
        b=el6aQLTjp123y2jK1a2/hHN/xfN4u3yaSS8eEojiehJ4H3YYmuNNHR/CCp3hWr1t0K
         kf0yrXZnHM0uyBunUBjZ1nrLNp7Dkgpn0JO44BRdBfbpO5hiJyjy9+/Tyuq8Rl3TWUx0
         VhB0v7+hrU5CLln4M+eIihJ4xXZk9DDRvLcGdpPre+QqI1uR0OawhzqnLuCZ4VeGpvkI
         qhmz4WvBX2kVAU2mnH5T1sFmcy0TJh3UcsIBwvyWcQzSgG4uhtYb9GDGPxsQwQHlhJoa
         hc+jHDBdKYPJ5k4ZxuGI05Khh/f9UzlNU4oqlUogE5d/r7UGagev8sxvYwCBe7DopleA
         oBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787911616; x=1788516416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2d9aOk1DG5PJgTbHtKObATO+j7rQRq+47Wx1t8d6YA=;
        b=KM1s6ru7YZr/BMQuxyLQaXyJ2EV+uP7U4hbeVkjDoqUJ2taXNkkJ/OpyEY8VEEH3GC
         dsHIyFCB9ffnbqO8Y3n/awkPCvUP1OCBF+Kj6ejKM17wYs/I6q33Mur8GkSTt/rH20f1
         fPGyCOh3w4OmSr5+cohQo7MwyrBZFoFkJknSPdUpo46cPqfLsxYHbB1QHyHNhIWaUYB9
         3uSLbTG4BVUjJbul/Q0cvO3qYFPia/KJBDg53K/VU+FVb8numPmq34BqlOjlKbCPbHi/
         kAR/MNJrVw7usDDxasNqUBRDpcy4ugtnoWbaMIkatuL6gU4Y0WRYT1KMud3rXPzn/mfj
         EAOg==
X-Forwarded-Encrypted: i=1; AHgh+RpAlce4RSZt+tpFUg/yVoVm/VNx7jMd5Q0RevFPXMjUQTdxIOXu3Bv9wuUG4GJROPNXnxVfsQk=@lists.linux.dev
X-Gm-Message-State: AFuF++kTH5F8P/CLU569RYUak/RopmR+xaTXP61My7FvYAeYkCTD0OtI
	gHXRZHgjl/xYZXXUe22ga7zU9JdnZtj48pf4B0JPY5jHjSlSLDsrK3mEmcDnUYBPQPc=
X-Gm-Gg: AR+sD13xIBnqvfRAO5141BgGU8dnUJ4DBXLcRABAgUxJSwetOh28DpB+6tj85GbZuIM
	+5ixHTMIOF1jKChB46mMASnQU1U+kU+JyLfELDXK7zG9gGGIYwQTipZZRNq+4RtSB1Xl39QMSlr
	4dA8TF1a5duoEdEjtRTbLhIqKbkHK2PAaZZpIBX2kxtK+bkFM9UzHdGhmYC5nBbOkzKONnfbmvF
	tZcc+EUEPUxNHJWj8pxCdFnBjM5ahTrOoV6fIQJ1aOwnapEPDn2R82bC+8LlvlKznk2FJ8jXN5H
	dNs1hkOqjta3foitjfsvj5FLIIowEScj+dZvlzJE7Z3o611UqqOMcvHXvhb2IRhHe5NiLQ5QFsr
	6J4lzrlZUeAqIBbL8HG3v6MkR1ZDnJdyJJ6IxvHEm4AS1fut5MvYj5G8Tg2/gzrVt2d+jIfqjB9
	CAmehjZhRZOn9/diMpQtJeR2FPqoNERQmUv7IDNXdHPN90cVhPOwE7GN0aGaiuf3O6NUBfgVE0v
	Vp4KRSce4U=
X-Received: by 2002:a05:600c:a418:b0:49b:9433:ea44 with SMTP id 5b1f17b1804b1-49b9433eb4dmr59357095e9.4.1787911615692;
        Fri, 28 Aug 2026 03:06:55 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49b49cc61cfsm127971735e9.6.2026.08.28.03.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 03:06:55 -0700 (PDT)
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
Subject: [PATCH net] net: bridge: mcast: fix br_multicast_list_adjacent rcu walk of mglist
Date: Fri, 28 Aug 2026 13:06:42 +0300
Message-ID: <20260828100642.2664347-1-razor@blackwall.org>
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
mglist walk. We can do a proper mglist rcu conversion later.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com

Fixes: 07f8ac4a1e26 ("bridge: add export of multicast database adjacent to net_dev")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
We can do a proper mglist rcu conversion when net-next opens up.

 net/bridge/br_multicast.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3ef5d8bbf552..7fa5f4444c4c 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4967,15 +4967,19 @@ int br_multicast_list_adjacent(struct net_device *dev,
 		if (!port->dev || port->dev == dev)
 			continue;
 
-		hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
+		spin_lock_bh(&br->multicast_lock);
+		hlist_for_each_entry(group, &port->mglist, mglist) {
 			entry = kmalloc_obj(*entry, GFP_ATOMIC);
-			if (!entry)
+			if (!entry) {
+				spin_unlock_bh(&br->multicast_lock);
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

