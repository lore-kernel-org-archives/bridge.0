Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294538;
	b=VuNG9JuqiP86KoeoKewtrV9GzsyRm2mul0q7K8hz9ErG+aMyfh3hI/uhlpwPX3Pw43DR
	 JbPtakqdXHZNUWgFKEvLvQBEikfgWkeU8qyuOf1/km2UJOXIVivXp9+g65PnT8+bPlpDS
	 MWr6zEEETuwfHJoK4D5/c9rCzHBsmAXIoNotsu7TeMImtwFh1+scFfj+WHSwXgNhfBuWb
	 srGUPDixfJb/aljp/xU1f6HnB+U8HXsgyEDS7AsDblRMJImMZKcuW+2h4/sqdWMCRQ8CF
	 tRotXCcA/zsAgwi9LubCxo9ZnKtkaf84zQPL0uAHekeOP+9avvs1j9UBWt7Bt4E0erA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GeBK2KWSTEYOjvpbrLoolF+PIHIEDG1AsTpzAFk1TEA=;
	b=bWHgJQB96epg+IwqmYe0yQ5yY0/S0+T3Rilgm9hpbKicnUY54pR8ctxAAZZGKwAHMIBr
	 jpigyVmoiMze8ssomPYUOqyv+kGKMjCSLKN0YHSi78WICRnhiqduiKvNe9Jc0WmJfKl4w
	 JT/2OR0ZRmpDX76k19QOpBkawwTyQI3OuRYYaLPxtfgGGBT+2jz70T6pz3BPoZNcXkP8k
	 rFFOir4ibYCEFt0mJEcmdV4ggJ1r1tWyDNyKygCV9Gsur4d/LATjhgy3lWYuoWiMAs1iV
	 4U/yw9TFNFtxJsPr3WYYEmrjvymy557MYWUmOF0qrRFtYeke3hD1712K4DBT9qjUkbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=gd3qaL6F;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484A1606A682
	for <bridge@lists.linux.dev>; Sat, 21 Nov 2026 20:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 484A1606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=gd3qaL6F
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c505b2e1cb9so379923766b.2
        for <bridge@lists.linux.dev>; Sat, 21 Nov 2026 12:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795294537; x=1795899337; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GeBK2KWSTEYOjvpbrLoolF+PIHIEDG1AsTpzAFk1TEA=;
        b=gd3qaL6FUzr3TOpIPLmiHmguZiJkwQCCoU+Et+OMsk57LE/pVd9zrxC4mzYRL813hD
         KfgbQeUruWky/qlqwzl1ynqQqXlxYteJA9DzBFp21R7opPs37dBV9rqeVsDl2W8NtIHv
         jgUzx9/4oVgcqUsC+j67+2MzMcFxLNLhzjPleAA3K0pIOF/L/0QGSroBpgxJWulpNmxi
         3NLr4kyWoLsz0u24vZQmDPUhkgbp0qXBDhXriom+zFaeyw3Ni/Ep9VhGEnZawxj8q/wy
         UyZY6SigrEhfVxUN7LhLK3uHCR6ELCKLGOpH6KsKxYuerNIV3TZBXLT5fcOL7ubUpyh5
         VhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795294537; x=1795899337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GeBK2KWSTEYOjvpbrLoolF+PIHIEDG1AsTpzAFk1TEA=;
        b=vBcopul2ZoG83q3UD1nZDMgr29aEPIG6FgPyHrOyp75FruYz+vi0e0v4ORBHD20q0k
         d7qYC5mBTC2wIwjudQIblPuCDqQIUBmnrrLYymJxHX50YagQR9uQC0iOhFQfpCOxeFa9
         zsFc9XSaDLTJWpa1nNvaNVhhSt0i21iPkrXYG+F3c9o6BtLUBSFc38Yj+TjYCCiaGldb
         SqBeaY+RMtn4lIdpuz9VSUV8qLz2YQHBvH4qGS8i9AsEdfjiuS07SEzkJvckLm/WPJDQ
         vXICa1nCK158JbTxvfiwnuSAqB/nTZO9ZTvhIbTZj/JYxRJ3u1waJl7GFB9fm8W+wgFT
         0snA==
X-Forwarded-Encrypted: i=1; AL+hErEc90KKUjV41oggKGBm7sqBJlVQtLWqsJaCwgNhWhFyVi0zc3gWjCnaRxgKZI0w+0ZmXKogjkg=@lists.linux.dev
X-Gm-Message-State: APuU4Z93Ac8oNOD53EQ3groklbPgwRgldosTa8ld75efrLag9wsMRASN
	DbBXWs4/RzSYdTcBXgVPtQRHz6OlGZ272/Imj1CJ2v+9UU9sqEOaHOsG9Ma8DXSiDg==
X-Gm-Gg: AZFdTZd7njUhbFA0qdY68Oa4Kva45UKEswy2czIMivbYja549MhU/06WuOGkp+T2PWS
	0mhb4c/IgDfkJ0C1bQiFIYIOPepEBIR9OoGq5DpRyr12ma2jVlvOqx3bFvDi0ZEDJ5Ku8TUf4sz
	gpoQFaAO2+s3xX9onwPQk2Olm2z/Q2ewQLd43Aol45JykCdEsJBb7jvby+WmI1SB1PqP72UT1V+
	XzgP9tqKtjEysM2KhqmdFINjzNAYTxp1luU6NlJsn71qJ8+vmzNEnwHBoPqkAGPiMQziGWoka3d
	38idfpWQsC9EalIAAW17JRzBvmx9G+xMfIAhmdAv5ARxV60kf9aNwehDDL+cH/9eXtlBlI1V0dV
	FBsNrelfTTMO9BRJZ60efr86xHPAiMZ1ggzcRLP8p54lXiT0fojORXexU+R7JCddaDG/B0SavYB
	DMBUm1WGp4xWEUf5Fy5fcmByLqswHxNLGs99fN6ydST80jtKouJfLxOXi94M0wbhkLtJp93Pyo1
	AdhlmfhIE8lOFG5K6EQ1H3FesbnfPPU1Kc88kUH9idIIiTWXZncYwo4ZEMV5MNuHkB7ie1Y5TKL
	g9UsDczT38ifVMumt1d1Z5b0HrR31d+pIz8EM33lDhjihxKNsNSs8BX+SIWjcS2HTA42XMRV02N
	Ybs8RnvLcgrsm9a/hGMuG8J2qfE7+bPzGiSvOqSXwA37uKmhBlZsVHmt4GdKsISwGTV2EHx+Y4P
	+3V+fitjLBHjHLpYuB146s2fgCwN7eFqlIDw633l1o+Uum1ZRUNpf5otbglxDxfHE5LvCkEV5Ta
	FTyDnclopnb73OCjOscgcrs0EzzRxyDIOzxrWfSuiqoO22xidCX4XpOEBZC2lLPPUpVw0IrbJVK
	H4Jn8K1Of3jAvwHjQH2Bxi81FDjehDcbcaW2XVJ4c7Yb34jtVf8lEC8=
X-Received: by 2002:a17:906:f8cf:b0:c50:bf14:8ec1 with SMTP id a640c23a62f3a-c513ab4d93emr437004166b.33.1795294536714;
        Sat, 21 Nov 2026 12:55:36 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f2470dfa000000000000000a27.dip0.t-ipconnect.de. [2003:f2:470d:fa00::a27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea28f4sm237136666b.33.2026.11.21.12.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:55:35 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH nf-next v11 1/3] net: bridge: fill a forward path only to a port that forwards
Date: Sat, 21 Nov 2026 21:55:33 +0100
Message-ID: <20261121205535.1888592-2-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121205535.1888592-1-julius@bairaktaris.de>
References: <20261121205535.1888592-1-julius@bairaktaris.de>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_fill_forward_path() resolves the destination port from the fdb and
checks only that the vlan exists on it. A port in STP blocking, learning
or disabled state, or an MST vlan that is not forwarding on it, still
gets a path, so the flowtable transmits straight to a port the bridge
itself does not deliver to (should_deliver()).

Add br_port_forwards(), the port and vlan part of should_deliver(), and
fill a path only to a port it accepts.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
v11: no changes
v10: https://lore.kernel.org/netfilter-devel/20261115005555.645727-2-julius@bairaktaris.de/

 net/bridge/br_device.c  |  2 +-
 net/bridge/br_forward.c | 19 +++++++++++++++++++
 net/bridge/br_private.h |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 0a1ce9e59a4d..f5860e88dbe9 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -402,7 +402,7 @@ static int br_fill_forward_path(struct net_device_path_ctx *ctx,
 		return -1;
 
 	dst = br_fdb_dst_port(f);
-	if (!dst)
+	if (!dst || !br_port_forwards(dst, path->bridge.vlan_id))
 		return -1;
 
 	if (br_vlan_fill_forward_path_mode(br, dst, path))
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 54365c6104b5..9dbe9c949558 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -31,6 +31,25 @@ static bool should_deliver_vlan(const struct br_fwd_dst *fwd,
 	return br_allowed_egress(nbp_vlan_group_rcu(fwd->port), skb);
 }
 
+/* Called under RCU. Whether @p forwards a frame in @vid, 0 without vlan
+ * filtering, as should_deliver() decides for a frame filtered at input.
+ */
+bool br_port_forwards(const struct net_bridge_port *p, u16 vid)
+{
+	struct net_bridge_vlan *v;
+
+	if (!br_mst_is_enabled(p) && p->state != BR_STATE_FORWARDING)
+		return false;
+
+	if (!br_opt_get(p->br, BROPT_VLAN_ENABLED))
+		return !vid;
+
+	v = br_vlan_find(nbp_vlan_group_rcu(p), vid);
+
+	return v && br_vlan_should_use(v) &&
+	       br_vlan_state_allowed(br_vlan_get_state(v), false);
+}
+
 /* Don't forward packets to originating port or forwarding disabled */
 static __always_inline bool should_deliver(const struct br_fwd_dst *fwd,
 					   const struct sk_buff *skb)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 014d0b8db8c7..2c73d2549eae 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1048,6 +1048,7 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
 void br_forward(struct net_bridge_dst dst, struct sk_buff *skb,
 		bool local_rcv, bool local_orig);
 int br_forward_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
+bool br_port_forwards(const struct net_bridge_port *p, u16 vid);
 void br_flood(struct net_bridge *br, struct net_bridge_vlan *v,
 	      struct sk_buff *skb, enum br_pkt_type pkt_type,
 	      bool local_rcv, bool local_orig);
-- 
2.53.0

