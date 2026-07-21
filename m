Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40155384224
	for <bridge@lists.linux.dev>; Tue, 21 Jul 2026 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642972; cv=none; b=IkhJbN2ziTiroVOMJp5dcvtQbxIFV+iDzKI4C/ABo+tZtmXwtv18VZcKqY1tXnZhXBRbddI15mOIaq/TrHsqw0JvOA47dgBZX+n3ZvL2CLrvqWJLK/IrfpHHEw7YMylRRzANhoQXGbvSAmI9kfmXVspx4Zn5OHrPH7Xt2o/ZsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642972; c=relaxed/simple;
	bh=Fn+8gl65km4dr4U2bzehxJ91qeoxgZnZt8JL0WXZSJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qk8WJ3hH8xvCTW+v8eu0B5E6pXWnpPGnqLjgVylc7OZFVY6SW5PflwJ3xbczYOwKcaRZxbEzIe+91bkQEdMWSPguH5bRGExl0KPONX4KJJLQSpr0XNRljqLfRCCyoaf2jtMWhMFNSlWCDZCx8YeZQl3W29xxAp5xQMNczR12dsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hbhZMQlb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="hbhZMQlb"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495590dde14so25519505e9.0
        for <bridge@lists.linux.dev>; Tue, 21 Jul 2026 07:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784642967; x=1785247767; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bV8sKewn/Iiw+wxDCFC7KDgjO9zhL+uosB6vYvMCN/o=;
        b=hbhZMQlbg8LVIehdY5bCxYUBBhja06mcX+KfJXBz2MgNxib2NJxx0tNH70w8nCq7tN
         cN1u9ijigAbhq2LR/Z2PmkuFwgV7dukGEKQEkiV//lu4FruO0711qlMRmD3fd8Ko1T4e
         MQVvv/ym30qP4msfmhwjYuIHACS+ntgzXdAL6RAhGazEpdmz4mnEJ6RP/BoGw6aVZXQj
         tTSusIeErii4Ab6cMvDQ0gMeO0dDJYimI/zbJ1HzAJI01Qxq1vGjHWtYUjxGhhycs3vS
         U1IQ51gOYDcT82Hir2yBruNQoWTNeqnDZeSc0+0UyHrJ19cmYs0loV+v452NRDEKQpYD
         XiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642967; x=1785247767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bV8sKewn/Iiw+wxDCFC7KDgjO9zhL+uosB6vYvMCN/o=;
        b=SukRRAEIU/WEhBuwHXWXF72xNhnuFc6afhxaaKfj/MsWn/WwNEJ6aHw5kYDIMQM7bU
         g0fpiRl0vRX7NS/B6vkve81QYfSTOq2pvbqPGVWlMOtzhGEhWqzJuiD4RLxaf1/z0JSR
         2rXsHmph4jL3ei0ZN8B97KAIOKU3kYcPt2Z+mgPVQgVwQTmKnI/Lo12Th1YEEkk8Fwui
         ftJTwuwBIUCqQrLmJ+ErafPvex5ZAlgEhKKziA78CZ9afNakH8o4bS9qtkzQZlkvEvaE
         TNfxiJeuwvSO98aYwaPBddOHwsfM99GPXSXhE5EwDrTe1eoOt5IzLYIrS+s7+84WF5bn
         ENLg==
X-Forwarded-Encrypted: i=1; AHgh+RoBd1ODJofSvUJX3mlOX/WoIy0q/sg5oC8HycoENwvNdKqLlEe9/pRMbZ7SimmQ/D2JCakqcAs=@lists.linux.dev
X-Gm-Message-State: AOJu0YyhgiwLrzDUv02lDM73tiMb1J3qOSS4ZheA4F7i/r/tZuc8d/sm
	rTpPEn1Yu9V4oWYYUiQDZdrVJxAmF0MMyNlEZhOeiXUau6f/BiZEGA92qoE+bHScF3A=
X-Gm-Gg: AfdE7cmX6Dh4w1mIZ++NyljWROGqBISStXgsiz1C9biruNDB913nCzzE5jS5ctEYf6S
	CBIsa8PN99IfV/UzkDXhvL7PnBI4IgEnQsblbulVYN00OVQvEgPkdv5YMsDQlOTxN58xj3jbbi+
	dDT8P4KKVZr/hyfISy0KJzbdfEQfjlIRvDdVXI8vwskoR7D/gDLwaXrp/UEZV6rLH8ign82wY4f
	UmIme2lpuDElPRSPg0Zba/osnrFDWbscN1RGSSND5I1Tvcvm6O9PiF3gppEom3A9fKXOmLQKosn
	e+Zl9LAwJkvJxtg7jLibSAbKfG18P9grlwl8sF11KuzlYD4XozwquRIwE8IC22nxZAFooBCVKbL
	NOCGVFDKa/xNdsa90sbYjnlNm5UwgAki2oRYVoB9MJLtW5ssP0WoLXo4Se9FoZtqfCSVHQ20zc+
	qdd6smA3mwwfdBSKM/q4yLwtfN
X-Received: by 2002:a05:600c:285:b0:494:596e:e8c4 with SMTP id 5b1f17b1804b1-4954a3fd583mr145856345e9.17.1784642967240;
        Tue, 21 Jul 2026 07:09:27 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f63ed1911sm42139358f8f.22.2026.07.21.07.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:09:26 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 1/2] net: bridge: vlan: fix vlan range dumps starting with pvid
Date: Tue, 21 Jul 2026 17:09:21 +0300
Message-ID: <20260721140922.682265-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721140922.682265-1-razor@blackwall.org>
References: <20260721140922.682265-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a bug in all range dumps that rely on br_vlan_can_enter_range()
when the PVID is a range starting VLAN, all following VLANs that match
its flags can enter the range, but when the range is filled in only the
PVID VLAN is dumped and the rest of the range is discarded because
br_vlan_fill_vids() checks for the PVID flag. Since the PVID VLAN can
be only one, we need to break ranges around it, the best way to do that
consistently for all is to alter br_vlan_can_enter_range() to take into
account the PVID and return false to break the range when it's matched.

Before the fix:
$ ip l add br0 type bridge vlan_filtering 1
$ ip l add dumdum type dummy
$ ip l set dumdum master br0
$ ip l set br0 up
$ ip l set dumdum up
$ bridge vlan add dev dumdum vid 1 pvid untagged master
$ bridge vlan add dev dumdum vid 2 untagged master
$ bridge vlan show dev dumdum # use legacy dump to show all vlans
port              vlan-id
dumdum            1 PVID Egress Untagged
                  2 Egress Untagged

$ bridge -d vlan show dev dumdum # use the new dump (RTM_GETVLAN)
port              vlan-id
dumdum            1 PVID Egress Untagged
                    state forwarding mcast_router 1

VLAN 2 is missing, and if there are more matching VLANs afterwards
they'd be missing too.

After the fix:
[ same setup steps ]
$ bridge vlan show dev dumdum
port              vlan-id
dumdum            1 PVID Egress Untagged
                  2 Egress Untagged
$ bridge -d vlan show dev dumdum # use the new dump (RTM_GETVLAN)
port              vlan-id
dumdum            1 PVID Egress Untagged
                    state forwarding mcast_router 1
                  2 Egress Untagged
                    state forwarding mcast_router 1

Fixes: 0ab558795184 ("net: bridge: vlan: add rtm range support")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
The change for the tunnel should add a separate notification for a PVID
VLAN which is fine because br_vlan_notify will properly fill in the pvid
flag for that VLAN.

 net/bridge/br_netlink_tunnel.c |  3 ++-
 net/bridge/br_private.h        |  6 ++++--
 net/bridge/br_vlan.c           | 10 ++++++----
 net/bridge/br_vlan_options.c   |  3 +--
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index 71a12da30004..a713668ea34f 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -271,7 +271,8 @@ static void __vlan_tunnel_handle_range(const struct net_bridge_port *p,
 	if (!*v_start)
 		goto out_init;
 
-	if (v && curr_change && br_vlan_can_enter_range(v, *v_end)) {
+	if (v && curr_change &&
+	    br_vlan_can_enter_range(v, *v_end, br_get_pvid(vg))) {
 		*v_end = v;
 		return;
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d55ea9516e3e..d3880f31edc4 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1627,7 +1627,8 @@ void br_vlan_notify(const struct net_bridge *br,
 		    u16 vid, u16 vid_range,
 		    int cmd);
 bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
-			     const struct net_bridge_vlan *range_end);
+			     const struct net_bridge_vlan *range_end,
+			     u16 pvid);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
 				    struct net_device_path_ctx *ctx,
@@ -1874,7 +1875,8 @@ static inline void br_vlan_notify(const struct net_bridge *br,
 }
 
 static inline bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
-					   const struct net_bridge_vlan *range_end)
+					   const struct net_bridge_vlan *range_end,
+					   u16 pvid)
 {
 	return true;
 }
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 5560afcaaca3..31c1b2cf75d9 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1982,9 +1982,11 @@ void br_vlan_notify(const struct net_bridge *br,
 
 /* check if v_curr can enter a range ending in range_end */
 bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
-			     const struct net_bridge_vlan *range_end)
+			     const struct net_bridge_vlan *range_end,
+			     u16 pvid)
 {
-	return v_curr->vid - range_end->vid == 1 &&
+	return v_curr->vid != pvid && range_end->vid != pvid &&
+	       v_curr->vid - range_end->vid == 1 &&
 	       range_end->flags == v_curr->flags &&
 	       br_vlan_opts_eq_range(v_curr, range_end);
 }
@@ -2066,8 +2068,8 @@ static int br_vlan_dump_dev(const struct net_device *dev,
 			idx += range_end->vid - range_start->vid + 1;
 
 			range_start = v;
-		} else if (dump_stats || v->vid == pvid ||
-			   !br_vlan_can_enter_range(v, range_end)) {
+		} else if (dump_stats ||
+			   !br_vlan_can_enter_range(v, range_end, pvid)) {
 			u16 vlan_flags = br_vlan_flags(range_start, pvid);
 
 			if (!br_vlan_fill_vids(skb, range_start->vid,
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index fcc200c3e3da..cb0f556ff40d 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -350,8 +350,7 @@ int br_vlan_process_options(const struct net_bridge *br,
 				continue;
 			}
 
-			if (v->vid == pvid ||
-			    !br_vlan_can_enter_range(v, curr_end)) {
+			if (!br_vlan_can_enter_range(v, curr_end, pvid)) {
 				br_vlan_notify(br, p, curr_start->vid,
 					       curr_end->vid, RTM_NEWVLAN);
 				curr_start = v;
-- 
2.47.3

