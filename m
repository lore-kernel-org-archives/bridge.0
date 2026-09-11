Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85F40681D
	for <bridge@lists.linux.dev>; Fri, 11 Sep 2026 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121237; cv=none; b=U/Ft46RpaRRhomOqf1pvHmA1uX2xJ5FoUvJGmWyymtj/qFlQRFqHiaGCv7WoLnBtmEZCzpOMVlZeuC0r71TGtr4QQdaMwDKzS9isy+/1LCtA2qoYKM5+eSPeQ4tWWwhKvvFcFY+3QzOuT22gultbWr0WydQi0C2vTEX/O2kpwus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121237; c=relaxed/simple;
	bh=V8NxLrR85R4hMEuCvuq7hPTTUg2W2ANSVj2I+B9IfgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/Q7XH30LKn9f0ub6q8NstsdlavATRinmSKh8Ssmii/5petVewCQ20B3zmo/V2n46d28NIAmXmg8p/atss3S5drWnLxxRamoWisdoL81yPhJZfnrKcQFwOzkL70RxhcWXwmZ6DeJUmHVwrWqNAh4hFbgohuO+Nj+ectnJWQqx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=iPwgHhis; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="iPwgHhis"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e65b1cc29so2961855e9.1
        for <bridge@lists.linux.dev>; Fri, 11 Sep 2026 03:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789121231; x=1789726031; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXcgPnmTgj5AcgZzHmbEG6784aYNLo1awnsyC/8jJWs=;
        b=iPwgHhis3aUyq1GRJjfyGtKA1kvR/2sfWdUobaX/U6EYZKTMqTdoEbYCYGzwaROJED
         nJsmgvbnp5YaHj/XRTDdRvZPdqh6siaPpM8OWvMn/5pUHPWz+/kyIC5DnNTia3UwcNFY
         sNg+APMy3Ib4oAFH3sh73BltnnbKOMbYOfrFWGL86/FJEb+YbVTQTAGGJf9wSe8RaqAK
         lWF940S6tKDVNfTEOnCcBfDHkTWOZMtyxF1F4cbZa5tRqhsh6bXyi7cWhbHEPJhXZtU+
         4U0sAeKPDZMz/nvgCFNENGb0HsDVzzYKY81nGlOiN3w5bv44ET5c13J9MH6cnp7om3fC
         4Uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789121231; x=1789726031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kXcgPnmTgj5AcgZzHmbEG6784aYNLo1awnsyC/8jJWs=;
        b=cQJQU4YLUDs8uhV1v+Ht80KkTrQSUGfzYlGn3/XkexODronnddttaYKvCzfJDhsUdZ
         T51mDutm6JN8YqrJbUCprKhj983eGv92gIHVdEXSMIQDYtTOoNW76/Er7bEiDDFJptmg
         zvAyXn+JGoM/a8KhzRI/07pCIS+V+c8wTPXjUpEhXQJv2idly8PuO8m0TObWOMQybYnB
         6hNxH/D+knsWC7jpF93Q0NK/nGUvG8S3SNqwrwzK392jc8JndGASowwsBAF5R0zSo+FR
         9yNis1QKzVLc6MK+dBe3RpX0q//F5ike3eNjUUj4kN+crYyB3AUnm3KRCo3a4Z/4GvSy
         9A7A==
X-Forwarded-Encrypted: i=1; AKwUvBzlRHzM9tR7Nar4j+93TwHdS47MSD3OUdTA/m3F66Ul5kY/Y8XVBXHbuI4roElvbF1Kozd6Pxw=@lists.linux.dev
X-Gm-Message-State: AFuF++m1bXyLPvqvMi4Uvnx7x32wiOPXAJ0c+ifgZjEMqs0sr84kuGVP
	8/yYcMGJbl/97Ze+A5Qs3sVck05TwAaWeYpvbDMHC/dQjk6vUq9XaCv+6ShB5cevdjY=
X-Gm-Gg: AYBFou1RcXTIVX3+as2hRtMd0srn1dwgIJQjguIOTV266c668xdlYHvyE00P7bNRjcm
	UvyIsEuF3XGvKaICzsf7rRKVOTBq/9cYPcwmcKH4DCbXT2BneAEJH9YlDirvN2lItYXgwXQ7hZl
	jCyvSkEg2tLa9NdmQyJNnc5VfDk8BD6EjuYad5fPx9lWVm2UvsICkHAtvJwRHuy2l67n99qoJG3
	NcCftQkY9gyCxW8WPtvPOqPFUnDegH/BIVobDPypPxYMWG2tFqAlCszN2V4EhIH3mdHV2a3ksm+
	2lAe7S38ftHZTKOeZvMqZZLHpIHWvvNKCqxkDG9x6zXyTMvrn2H7KcSXThI2vueFmL3uWvCve26
	AMUw2gR+/MpFzuSyxWE5uNJKmJbyQh5MNXe32gCxnRjfOyQdK3QCMECD3YkcZak7/lcNs4UUrrc
	OCtOEcq1bZwsM1E/Vh59DwO7OVMibiScdemWa2XY84bmJ0AiWgaQTYeRIdYRVKGy+jqNtJeyHe+
	T+R+5oYWk/D9C8egwrGgA==
X-Received: by 2002:a05:600c:8b38:b0:49d:272d:74b4 with SMTP id 5b1f17b1804b1-49e619a1e56mr80755865e9.2.1789121230555;
        Fri, 11 Sep 2026 03:07:10 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49e6576122bsm41061755e9.2.2026.09.11.03.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:07:10 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	petrm@mellanox.com,
	vladimir.oltean@nxp.com,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 1/2] net: bridge: vlan: fix leaks on switchdev deletion errors
Date: Fri, 11 Sep 2026 13:06:44 +0300
Message-ID: <20260911100645.1360386-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911100645.1360386-1-razor@blackwall.org>
References: <20260911100645.1360386-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vlan_del() stops the software deletion when the switchdev operation
fails which is ok for an explicit VLAN deletion because the VLAN remains
configured but not ok when its VLAN group is being destroyed and everything
is being freed. __vlan_flush() always destroys the VLAN group after walking
it regardless of individual deletion errors, so aborting the software vlan
delete leaks the VLAN object's memory (and potentially its master VLAN, due
to references).

Allow teardown callers to finish the software deletion while preserving
error for reporting. Save the VLAN id before deleting because the VLAN
object can already be freed (queued for freeing by call_rcu).

Fixes: 2594e9064a57 ("bridge: vlan: add per-vlan struct and move to rhashtables")
Fixes: 9c86ce2c1ae3 ("net: bridge: Notify about bridge VLANs")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_vlan.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 1e0e436629ec..1748ea1fc202 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -387,7 +387,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 	goto out;
 }
 
-static int __vlan_del(struct net_bridge_vlan *v)
+static int __vlan_del(struct net_bridge_vlan *v, bool teardown)
 {
 	struct net_bridge_vlan *masterv = v;
 	struct net_bridge_vlan_group *vg;
@@ -405,13 +405,14 @@ static int __vlan_del(struct net_bridge_vlan *v)
 	__vlan_delete_pvid(vg, v->vid);
 	if (p) {
 		err = __vlan_vid_del(p->dev, p->br, v);
-		if (err)
+		if (err && !teardown)
 			goto out;
 	} else {
 		err = br_switchdev_port_vlan_del(v->br->dev, v->vid);
-		if (err && err != -EOPNOTSUPP)
+		if (err == -EOPNOTSUPP)
+			err = 0;
+		else if (err && !teardown)
 			goto out;
-		err = 0;
 	}
 
 	if (br_vlan_should_use(v)) {
@@ -448,7 +449,7 @@ static void __vlan_flush(const struct net_bridge *br,
 			 struct net_bridge_vlan_group *vg)
 {
 	struct net_bridge_vlan *vlan, *tmp;
-	u16 v_start = 0, v_end = 0;
+	u16 v_start = 0, v_end = 0, vid;
 	int err;
 
 	__vlan_delete_pvid(vg, vg->pvid);
@@ -463,12 +464,13 @@ static void __vlan_flush(const struct net_bridge *br,
 		}
 		v_end = vlan->vid;
 
-		err = __vlan_del(vlan);
+		vid = vlan->vid;
+		err = __vlan_del(vlan, true);
 		if (err) {
 			br_err(br,
 			       "port %u(%s) failed to delete vlan %d: %pe\n",
 			       (unsigned int) p->port_no, p->dev->name,
-			       vlan->vid, ERR_PTR(err));
+			       vid, ERR_PTR(err));
 		}
 	}
 
@@ -838,7 +840,7 @@ int br_vlan_delete(struct net_bridge *br, u16 vid)
 
 	vlan_tunnel_info_del(vg, v);
 
-	return __vlan_del(v);
+	return __vlan_del(v, false);
 }
 
 void br_vlan_flush(struct net_bridge *br)
@@ -1369,7 +1371,7 @@ int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
 	br_fdb_find_delete_local(port->br, port, port->dev->dev_addr, vid);
 	br_fdb_delete_by_port(port->br, port, vid, 0);
 
-	return __vlan_del(v);
+	return __vlan_del(v, false);
 }
 
 void nbp_vlan_flush(struct net_bridge_port *port)
-- 
2.47.3

