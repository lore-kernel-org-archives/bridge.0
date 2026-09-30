Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969373AC0C1
	for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752514; cv=none; b=dmN6593+Q0CqsEPGJU+eUfMkAWXVSzJYbcZ+DdHM1mQ2LAgobz8Khxiud62HqE1MvrsHeri4iwcDhoMGHqb+fpqOmN8WRopbYLJBJ1ywBHu8HH97ozogw6SieB0aKrBq6GCDphXPGdzgWNYWemuQyFQBvMxjTox0qgenmAdMJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752514; c=relaxed/simple;
	bh=gSR1Rvdfvw09fwQj2QshgiIthi46vO9rQZdK9fkGmIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6Kh/xYT/utAkdpICOL7jfDIRxB1SDtV1TyvFteieJvT2dc/zwPjb72beiikmdl12nyOYNeHxlCmD9kAzCrYCIAqa5f/HOsUqf85bAPVg5PNehgNsbvgAwUQTFrMNsmGepcU10UFYCk0n9SEWFaWsB/yo3mjBX32Y94ZUcyM6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=IlIJUQGj; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="IlIJUQGj"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-482f63546c5so4428204f8f.2
        for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 00:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752508; x=1791357308; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrGkj+VE3xyyrtndMSCCNDGNBlpXd+mjCqInZjhVUQ8=;
        b=IlIJUQGjtIxc3ajre2E/gEWzFfG5hHUXIOHSdygCp4x6oJMfe3wWPIWHHhRaC/tCam
         C49RPGQvHfYSadenV0m/sELC7hx2Jv6UHnR9l5DpierdJr7qpWOWABP8yquzb+YX7hln
         Ljsl6NZKkvWBtDjoyvc40y4gLGKp4yZAXNQr/PaXFRf/09gTihb6NHkdYki9n61Q8NKz
         uEidDW/bfgCUS+eVy9FD+TQDUITRFxBXw09eFsnCmCPumEK+D7G7z7mkW1J9XmbsDhcf
         1QEx8cnqOgMVluMhcoTil4/pI9qJcymZ/II/LUhuDMPqzivssYQEwT8LlQFaal3ZUQHY
         KF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752508; x=1791357308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrGkj+VE3xyyrtndMSCCNDGNBlpXd+mjCqInZjhVUQ8=;
        b=LiO89KBw/HSs72Pw6FaVZTwFt2YG6H1Mawes2Pbgx+TxycyWP8edzhvacyWKnFB95r
         I1hmJHbccpLkbMOu0YNMCQo7inxXmpmiQXJkNnfEL8gjgacmAG0T2LWpQBVDxuyu2QJF
         m7YeanHQnOZDRSlmr00kmFHE8c4oOKB8/9e3kfGuKWXULIq8GujQUSGx+mI/pGPeg/zj
         UGfGFyqJ9JOqbYJfxu877BPB+sl1/++J/edr35fghvfyCLHGRRpWcE4xgGUOlJZBkYlp
         BqPNL/wRT3AYfyP05BIIaZ5d5BNKIKYzEqg7NfE6lFdkQar2KdAWNxpavnR5MK8oMfdz
         JF8Q==
X-Forwarded-Encrypted: i=1; AKwUvByUI8dJj4Ub8BhSP0KG0f/NHrirqY5GjBfcL2gQWTQ3fALyM9Jy9n7OtJJhPAl7o7QIeUFHouo=@lists.linux.dev
X-Gm-Message-State: AFuF++m175UIoFU5FZDAVOHlFEJZlII2mHMGstaXKYNUjxwmZ1O+qQBb
	kZeXweIba1mgPwqzfuxoUJhEsNcI0TVyIHGwnX8rAtqFwy8RIOSIr4z0M0UmE2uybX4=
X-Gm-Gg: AYBFou1j4ys1dpzzjgtTfLDi60WE90vYPKgZO6PKyb96F4L/qLPWutm/I5w+fDGjPyl
	NoHMWYy5M0euyddE+4GRdnLmYrQ3/7urYBCeIU+bvcJLoaIZ02jw36X7UQ6hGMZ0LEg+INlf500
	LpNa/CR2JvfvdiNrhzWqm3Zq6X1nzjxpeaKyHtdidmxPrTSEeD5yXveWInJFNcuCXOa5wVeQnQE
	Mh3mct/Uyma7JZDfwuuiGlRqP6cZ4OLgYMmbakPvMsIyeQRluXkrVe8Ig/6YvHvl1032PMZI5CM
	2VVqTXxCpfr1FZvpU0vWxX+pnXzwYqe+p49zqDslkmi13ig+q35lAl8T74s+Td2kZfw9b+rgg61
	PdxnJg8slDZD+iyPhG61TrPdyT37WpZiaZ01+8z3GR5YJwtC7y/1jn5obBYBp8F32EqcmHG36Hm
	KTOEK/BJK8a0yM/JbpioHXE7K+2rMDWdsd/YqcISNu1yn1Xw0gSOiO26UFCXxOGG2Md0e4S8GqK
	r5cYQ==
X-Received: by 2002:a05:600c:8411:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-4a01affe5camr6305205e9.6.1790752508427;
        Wed, 30 Sep 2026 00:15:08 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a019740c34sm18723525e9.9.2026.09.30.00.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:15:07 -0700 (PDT)
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
Subject: [PATCH net-next 07/12] net: bridge: vlan: split unpublishing from deletion
Date: Wed, 30 Sep 2026 10:14:06 +0300
Message-ID: <20260930071411.2786201-8-razor@blackwall.org>
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

Split removal of a VLAN from its lookup and flood structures from object
destruction. Pass the VLAN group explicitly to __vlan_del() and call both
operations consecutively for now. This prepares deletion paths to quiesce
readers after making an entry unreachable and before freeing it.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_vlan.c | 45 +++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 7ba6e57b18fa..8a914e249767 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -429,22 +429,34 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 	goto out;
 }
 
-static void __vlan_del(struct net_bridge_vlan *v)
+static void __vlan_unpublish(struct net_bridge_vlan_group *vg,
+			     struct net_bridge_vlan *v)
+{
+	__vlan_delete_pvid(vg, v);
+	if (!br_vlan_is_master(v)) {
+		struct net_bridge_vlan *masterv = v->brvlan;
+
+		rhashtable_remove_fast(&vg->vlan_hash, &v->vnode,
+				       br_vlan_rht_params);
+		__vlan_del_list(v);
+		/* -1 because br_vlan_put_master() is called later */
+		br_vlan_rebuild_port_array(masterv,
+					   br_vlan_num_ports(masterv) - 1);
+	}
+}
+
+static void __vlan_del(struct net_bridge_vlan_group *vg,
+		       struct net_bridge_vlan *v)
 {
 	struct net_bridge_vlan *masterv = v;
-	struct net_bridge_vlan_group *vg;
 	struct net_bridge_port *p = NULL;
 	int err;
 
-	if (br_vlan_is_master(v)) {
-		vg = br_vlan_group(v->br);
-	} else {
+	if (!br_vlan_is_master(v)) {
 		p = v->port;
-		vg = nbp_vlan_group(v->port);
 		masterv = v->brvlan;
 	}
 
-	__vlan_delete_pvid(vg, v);
 	if (p) {
 		err = __vlan_vid_del(p->dev, p->br, v);
 		if (err)
@@ -467,12 +479,6 @@ static void __vlan_del(struct net_bridge_vlan *v)
 
 	if (masterv != v) {
 		vlan_tunnel_info_del(vg, v);
-		rhashtable_remove_fast(&vg->vlan_hash, &v->vnode,
-				       br_vlan_rht_params);
-		__vlan_del_list(v);
-		/* -1 because br_vlan_put_master() is called later */
-		br_vlan_rebuild_port_array(masterv,
-					   br_vlan_num_ports(masterv) - 1);
 		nbp_vlan_set_vlan_dev_state(p, v->vid);
 		br_multicast_toggle_one_vlan(v, false);
 		br_multicast_port_ctx_deinit(&v->port_mcast_ctx);
@@ -509,7 +515,8 @@ static void __vlan_flush(const struct net_bridge *br,
 		}
 		v_end = vlan->vid;
 
-		__vlan_del(vlan);
+		__vlan_unpublish(vg, vlan);
+		__vlan_del(vg, vlan);
 	}
 
 	/* notify about the last/whole vlan range */
@@ -873,7 +880,8 @@ int br_vlan_delete(struct net_bridge *br, u16 vid)
 	br_fdb_cleanup_by_dst(br, br_port_to_dst(NULL), vid, 0);
 
 	vlan_tunnel_info_del(vg, v);
-	__vlan_del(v);
+	__vlan_unpublish(vg, v);
+	__vlan_del(vg, v);
 
 	return 0;
 }
@@ -1389,15 +1397,18 @@ int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 flags,
  */
 int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
 {
+	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *v;
 
 	ASSERT_RTNL();
 
-	v = br_vlan_find(nbp_vlan_group(port), vid);
+	vg = nbp_vlan_group(port);
+	v = br_vlan_find(vg, vid);
 	if (!v)
 		return -ENOENT;
 	br_fdb_cleanup_by_dst(port->br, br_vlan_to_dst(v), vid, 0);
-	__vlan_del(v);
+	__vlan_unpublish(vg, v);
+	__vlan_del(vg, v);
 
 	return 0;
 }
-- 
2.47.3

