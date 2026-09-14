Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB13C3F52
	for <bridge@lists.linux.dev>; Mon, 14 Sep 2026 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789383190; cv=none; b=OndmrI+0WJ4J53wK/i9L4oZ5/x3iEn++isoqVwOF3yyfp6wz3JURQDHywO095Ab3HQcL2Espo2FjnMfwYE2WYdwhuyQSi0rXAHR6J1asUu6ktldUYzNIaEU6az98qy9nA4+dg/T+Sn/38/x9xhQnlCXParO6CznBWSIR6IG+G80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789383190; c=relaxed/simple;
	bh=xNpAS9Rpk+qkC+vD1efyUXqAhDVvsbN0fuxWBkjXkwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3r4Of7og4XWZwWTvkpcj0SeFEwU6mDUKs7XrrUEeBhNU4yrVOKqCwvmJd2XRIldKKrS4ZXz9ebYi64tgfkQCHB8+xa/poj0Bb0CgQNosRIJJauMuYtgSDA8IRHTus1FHAdan7wgzRPI3An1kYizHGf9XUu8Uhwm7tbXWy+6GVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=eae2395F; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="eae2395F"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so22669565e9.3
        for <bridge@lists.linux.dev>; Mon, 14 Sep 2026 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789383187; x=1789987987; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bLTGCdFRaoDG+p/o/JaHo94biFFLMcmmpOqWjVY8H28=;
        b=eae2395FuNZudrtmy4fIcsci/7lIxXvmFm5aUs/gaM8CazBYN7L6SecFPtm5miFUd4
         x4a0toTgB4DrVqeMKbQ+eySLtIMYGuRgSEWqJvRqc2Mzroz+5eHzDlQONzJdtkRR6FNO
         nPE69jFyuOnTydLb6F9fTCL9eIBVh2TL1dT5EDgKfY9iYFnHRQRs80BFcO7gQp4mt6pc
         QeqEOLdoc70PXFWSF35atc1KsisoQxRgyp+bxJyMOInedO9f5IQJsiRiGL9gWJolxjy9
         VNqlBmTCtjbCYIhbmi+i5NpOs7Uf/guI9Q/Bubs29zva+SVmXm3I3aNcZG7HPGY1JBUL
         aqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789383187; x=1789987987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bLTGCdFRaoDG+p/o/JaHo94biFFLMcmmpOqWjVY8H28=;
        b=Nl87EwgHtsSntRjq2Qfepwrqqvh4rrscTHmbzafGErpV/uYfBGaKLE1y/onxrO9br6
         MEB0vzPm8SZs37FsNtVS9Y/g69Go3YWu8JLyyT9FfQyFOvGpLEnIM45tURQrh/9K7BqQ
         H7Kr7CouesO/tZzubL704lozxNKnuFlewZNw8/MKAuL4A6dgTANiqnRCewvKiKTmsEcg
         lQgQTnoiSVsTs8u3zzGei/WpcrhzXKwI2sVEyqgy7389BCWbxNPzdspzam32cz7Drqas
         rgopT15fUPXaNCZV/eG1QeQ9KrqyXhIBcIX+5UfwqQ/KLZd7kcFTS/kkqIX2ncW3kS+j
         LJxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZfvi+Nc8Si9lOepUzRFqS0vPhDJpyAFKNS8sLVd/PQHsJvXThPi2PMUI/HqezFYwf5Z9RwOk=@lists.linux.dev
X-Gm-Message-State: AFuF++miY21OtFrzemhep6qSVtuV6YSXfIKzF87No/c/f9vwiJtMRdr/
	PUwOTJAqOTlUIBi8vxw3DYhIvS/C84oUiNx3H3OzOafNVimSKIoUCxUpPlbmbG4zS8g=
X-Gm-Gg: AYBFou1Y0cTks2a8TZLc3IK03XNbM5uhoThiz902AjvImTkzsRDhGPw7oAzPvPKS56j
	FGe3BvZyq8NnjsBLpxbAyBXqqyhmK9bedSAFG10fJSCNvC/CnhbLf2A8Qf6c778LavzccqzhEkh
	JXWZL0CyD+7LUMaDvwiwiDy6vM/mxAKrjsu3nk/eOH6seWMyuWZgrsdwPRCr4had2bmAEfvYUJM
	dRcu/4ZQtlGyEYo6EeRceWUgOtpY7rcn007mFD8Let3GGucksJz3h4TYe9AFulAOTE3NKpH9iv/
	0wfEKAxpepQbnIeha7TLV8W/mryh2yC4VAoZboDjDCF9B8At8lfoqUXG7s6hyLKKHfcx9PMB572
	2dKEJglzLttoD4hWHb94z7swHfBC5cjkqKIvMZU2hdYwtMndjGkeBfJMB1hHLjWap7Q+YOMA2Pc
	8RWSJ6quoK+LU2gZDEFskc3Tl2wtjTFHPN/I1rGyBwwsvSNmeBXolkgcM/ypItKItIpojFNcNE0
	voJTnamO2MsQA8Pa+BjNQ==
X-Received: by 2002:a05:600c:34d0:b0:49d:1f10:8b9f with SMTP id 5b1f17b1804b1-49e7a63a711mr24550035e9.7.1789383186324;
        Mon, 14 Sep 2026 03:53:06 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49db038401fsm471937885e9.13.2026.09.14.03.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:53:05 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	petrm@mellanox.com,
	jiri@resnulli.us,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net v2] net: bridge: vlan: fix bugs caused by switchdev deletion errors
Date: Mon, 14 Sep 2026 13:52:58 +0300
Message-ID: <20260914105258.3436918-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allowing switchdev to prevent vlan deletion and error out in __vlan_del
could cause multiple different issues - inconsistent state, memory leaks
when flushing, NULL pointer dereference on bridge error when flushing.
It doesn't make sense to allow it to stop __vlan_del, so log the error
and continue with software vlan deletion. This is also consistent with
8021q behaviour.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Fixes: bf361ad38165 ("net: bridge: check __vlan_vid_del for error")
Fixes: 5454f5c28eca ("net: bridge: vlan: check for errors from __vlan_del in __vlan_flush")
Fixes: 2594e9064a57 ("bridge: vlan: add per-vlan struct and move to rhashtables")
Fixes: 9c86ce2c1ae3 ("net: bridge: Notify about bridge VLANs")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: this is a new patch, don't fail vlan deletion as suggested by Ido
v1: https://lore.kernel.org/netdev/20260911100645.1360386-1-razor@blackwall.org/

 to Sashiko (from local clone check):
 [Severity: Critical]
 Could this introduce a regression where net/bridge/br_vlan.c:__vlan_del()
 leaves stale VLAN membership in hardware after tearing down the software
 VLAN?

 For the port branch, __vlan_vid_del() has already converted -EOPNOTSUPP to
 success.  An error reaching this warning is therefore a substantive offload
 deletion failure.

 Nik: No, a driver should not block VLAN deletion and this behaviour is in
      line with 8021q. Also blocking it could leave incosistent state. It
      is best to print a warning and allow software vlan deletion to
      proceed.

 net/bridge/br_vlan.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 1e0e436629ec..92b3cb621a26 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -387,12 +387,12 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 	goto out;
 }
 
-static int __vlan_del(struct net_bridge_vlan *v)
+static void __vlan_del(struct net_bridge_vlan *v)
 {
 	struct net_bridge_vlan *masterv = v;
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_port *p = NULL;
-	int err = 0;
+	int err;
 
 	if (br_vlan_is_master(v)) {
 		vg = br_vlan_group(v->br);
@@ -406,12 +406,16 @@ static int __vlan_del(struct net_bridge_vlan *v)
 	if (p) {
 		err = __vlan_vid_del(p->dev, p->br, v);
 		if (err)
-			goto out;
+			br_warn(p->br,
+				"port %u(%s) failed to delete vlan %u from switchdev: %pe\n",
+				(unsigned int)p->port_no, p->dev->name,
+				v->vid, ERR_PTR(err));
 	} else {
 		err = br_switchdev_port_vlan_del(v->br->dev, v->vid);
 		if (err && err != -EOPNOTSUPP)
-			goto out;
-		err = 0;
+			br_warn(v->br,
+				"failed to delete bridge vlan %u from switchdev: %pe\n",
+				v->vid, ERR_PTR(err));
 	}
 
 	if (br_vlan_should_use(v)) {
@@ -431,8 +435,6 @@ static int __vlan_del(struct net_bridge_vlan *v)
 	}
 
 	br_vlan_put_master(masterv);
-out:
-	return err;
 }
 
 static void __vlan_group_free(struct net_bridge_vlan_group *vg)
@@ -449,7 +451,6 @@ static void __vlan_flush(const struct net_bridge *br,
 {
 	struct net_bridge_vlan *vlan, *tmp;
 	u16 v_start = 0, v_end = 0;
-	int err;
 
 	__vlan_delete_pvid(vg, vg->pvid);
 	list_for_each_entry_safe(vlan, tmp, &vg->vlan_list, vlist) {
@@ -463,13 +464,7 @@ static void __vlan_flush(const struct net_bridge *br,
 		}
 		v_end = vlan->vid;
 
-		err = __vlan_del(vlan);
-		if (err) {
-			br_err(br,
-			       "port %u(%s) failed to delete vlan %d: %pe\n",
-			       (unsigned int) p->port_no, p->dev->name,
-			       vlan->vid, ERR_PTR(err));
-		}
+		__vlan_del(vlan);
 	}
 
 	/* notify about the last/whole vlan range */
@@ -837,8 +832,9 @@ int br_vlan_delete(struct net_bridge *br, u16 vid)
 	br_fdb_delete_by_port(br, NULL, vid, 0);
 
 	vlan_tunnel_info_del(vg, v);
+	__vlan_del(v);
 
-	return __vlan_del(v);
+	return 0;
 }
 
 void br_vlan_flush(struct net_bridge *br)
@@ -1368,8 +1364,9 @@ int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
 		return -ENOENT;
 	br_fdb_find_delete_local(port->br, port, port->dev->dev_addr, vid);
 	br_fdb_delete_by_port(port->br, port, vid, 0);
+	__vlan_del(v);
 
-	return __vlan_del(v);
+	return 0;
 }
 
 void nbp_vlan_flush(struct net_bridge_port *port)
-- 
2.47.3

