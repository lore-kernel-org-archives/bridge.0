Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0191C4A1B
	for <bridge@lists.linux.dev>; Tue, 19 Nov 2024 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011568; cv=none; b=QWAZoeSegA3PpA4FtfKdct7U7peSg3ceYtu9h92H03Hiv+X7EdXWKdTm+9wGrDq8h/BvL3sH+gmMCXg6MVR5Pnup69etJKPncZMvyErq+imrbwPjkNLoZzQF6aJ2PW4Q2IHhWu5g3zt7SG4YCC3VU6vlpDUUAZobG6PuOQRC5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011568; c=relaxed/simple;
	bh=A+ii9hUcM8wU9eVI2sIlc9PYLGj/teoItXOMkBbxNzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1BPkSpo8t5na3p+kZz8oApV2JqWus+/xNEehXcJnKyazOg4BvrKim9w1CuQjU9CAk0JWuyfrb/qMZZpT/PPih9BN8OnVIoHb2z8Vm+lW6yWVYHplqRuuSXgzuGnUs4ysMZwt2uPXwD2+tBYGJ2ERMJvmE0JcdBH33fOXZGPavw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGLglJh/; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGLglJh/"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso42481331fa.3
        for <bridge@lists.linux.dev>; Tue, 19 Nov 2024 02:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732011564; x=1732616364; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNtMqpfiZ8j9VP8YeMgt8jDUBPMHbCQx5OGfeubdb70=;
        b=kGLglJh/q+kURr0l3fp3XjZ6Nhqf8ORplLgcPYPEFS4cdk3FTSdOGt94zkDkTaP6jo
         +IkK84HbZ5fIPD7sEvrF4U5ZbIIFbyWCiwyJQ1uQVpOqKSYWTXWRCSbG47MznPubzBxv
         /ieUxWPxGRRajC8+BYiPmeP0Sbtqrg9gPrRaFbrYIHw/nlvG6FcCRQSy6MpOyVAI/Nck
         h5I4dDkd5W5rYP93pYDd1AG11X4QdJ99D24uAvMEA3/tXKNHoFbFfZ0LLGBnB11fVubN
         IpKbufAfVnWI21XeJXR1NbdK9ZLttCK/RMGWia2pF9jVOF1uhT4lvtRDWVl+k1m1W3AP
         BG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011564; x=1732616364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNtMqpfiZ8j9VP8YeMgt8jDUBPMHbCQx5OGfeubdb70=;
        b=iXpUlC8lQDUDs3af26gdm2y/kY80JxQkGRhTtbl+Tbmp/NdleC86unfhoOMx2jNHA2
         HBWWlP37YofRhcM6KEj9EvXWNQpWpveqZ1XywpYcT53q4z/WrA9mdLslRsrSEXjy3wGo
         GqRnUR3v97B1SLdY3K5hdVFV6Pu6bpBFENcsFIMTVu54wWoddVQC148N4bwghMp5EN0D
         0gVIG7TmNEgkLtvI7gXkvHVQBcYFZp/KpVyuP9uzw7rARQJOZktfznBVUeWIPYgGHcF8
         qVpyxUCMr5m25sb3/v49/Ob0OEWegsHUSWmt+f12BejH0DNu6Vln+k8YCtwxDkbvpFC1
         nFYA==
X-Forwarded-Encrypted: i=1; AJvYcCUOOIMUtOKcHcACO2F6Bb6jb4QwZXdpODNkcuj/DlUqTYius/FBu5ntlituHvgbbLPUH8ZgErk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyZNzRGWPQjvcPsGQxaJ/xwyX75Tv2gIgx0RXgj5f7XIeZfANY5
	3puktoJRGgK6AxQegwJ15PMf0UyWyi7urrvfgEFyWPWV4EADzFwj
X-Google-Smtp-Source: AGHT+IHPphanLQvn1smAWqmqpsVVY1N5Pj6CCsoY8pRu0n0GdFTRRvOQ87pUfg0ubCpmZuXrqQ7tJQ==
X-Received: by 2002:a2e:a9a9:0:b0:2fa:c0c2:d311 with SMTP id 38308e7fff4ca-2ff60610642mr89237351fa.5.1732011563899;
        Tue, 19 Nov 2024 02:19:23 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e081574sm634875566b.179.2024.11.19.02.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:19:23 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH RFC v2 net-next 04/14] bridge: br_vlan_fill_forward_path_pvid: Add port to port
Date: Tue, 19 Nov 2024 11:18:56 +0100
Message-ID: <20241119101906.862680-5-ericwouds@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119101906.862680-1-ericwouds@gmail.com>
References: <20241119101906.862680-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lookup vlan group from bridge port, if it is passed as argument.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/br_private.h | 2 ++
 net/bridge/br_vlan.c    | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 9853cfbb9d14..046d7b04771f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1581,6 +1581,7 @@ bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
 			     const struct net_bridge_vlan *range_end);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path);
 int br_vlan_fill_forward_path_mode(struct net_bridge *br,
@@ -1750,6 +1751,7 @@ static inline int nbp_get_num_vlan_infos(struct net_bridge_port *p,
 }
 
 static inline void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+						  struct net_bridge_port *p,
 						  struct net_device_path_ctx *ctx,
 						  struct net_device_path *path)
 {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 89f51ea4cabe..2ea1e2ff4676 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1441,6 +1441,7 @@ int br_vlan_get_pvid_rcu(const struct net_device *dev, u16 *p_pvid)
 EXPORT_SYMBOL_GPL(br_vlan_get_pvid_rcu);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path)
 {
@@ -1453,7 +1454,10 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
 	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
 		return;
 
-	vg = br_vlan_group(br);
+	if (p)
+		vg = nbp_vlan_group(p);
+	else
+		vg = br_vlan_group(br);
 
 	if (idx >= 0 &&
 	    ctx->vlan[idx].proto == br->vlan_proto) {
-- 
2.45.2

