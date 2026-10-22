Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685406;
	b=fhnkg5GEmX86yMoOFoO0Pbfv/YdgdhCPNOG4cKDWVqfylZ7o2fzFkiw/zAFjZ+2MtlqD
	 +dfIA/yi1baLpO0uVvkzyYtFLo0sUnjmE1lZ2mx+ljDjX6uriPeSfAnVO5dwm5HGAALn5
	 hkHXIuXTaL9eqaUrHmj1S7hNNq+72ydEDnJoQDSoy04973WbN4Q2Y3Q5j35NpkOQMWHsG
	 KuukwsP5Mx0hBl30su9+IOYWoBqDsE/7W9kkIdTo/XiyIcDB4z7uSYTZhQLbkT8ZlsNWb
	 76LLqfjpMm5s3wf3Cnlj4TH/Qaw7AXDPQfx7Hik7rDQQnmivV3KHJ7hVTwS2K8YqhkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TKiZFeJUlLaF2cjWlbWxlK679IXDg+jtMCj4786GFco=;
	b=mdul3Hq3uRcJnmhN0mBxnHpgv7DiFJiV0bEk4F7KM9DRLLQa/NWgrZvoR+CP9SKurYFP
	 MSZ8zdRqhmUt3G9HKA2WMaoLw/MEReEwT8Ql2RMB278AZM7mbOT4XS9xm7cyXbPzexx4V
	 BIrZyoyRAwbKZpEwRm16iYdut8vfcFkNUw6tetw2C7xUlKCQB4eIE1FlBRjGbrBn0x+6e
	 Xfs+Hv4E6M5s8amvfHCGUZZfBaspCN3c8cGwzivpeagCEsIN/VZ0LCf0tqvwAhDxfo7Ol
	 hSicaN57EmOxCy+VFpYyQVXC6N0mgZL7onMqHl7EdKqOCDjGzsQEMTmoCZmn0xdEBVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="p/LZfTni";
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE6606A31D
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 16:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2CE6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p/LZfTni
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-33baa8eb238so1208022eec.0
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792685405; x=1793290205; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TKiZFeJUlLaF2cjWlbWxlK679IXDg+jtMCj4786GFco=;
        b=p/LZfTniMN8ZZTbu+gHuus5c/ZhdHNTrycSv4j9+TwljbxTZBkKdjamM7vYdFkPcqI
         H1dt3l8YODryYWjWsfL45Z0ft2+PeV8vqninVEBUIMHFUkjSjH8yB0O46I6JP5l4jjJb
         FrLdME8cEFypuZAAPhoyHk7CQ8OjMgz2YNgBRskV4r6UuklY5KxZk4CrvPIUrpCvwLZ/
         GOcuZIjcLFfGDsC8jJQ5Ioj+RKuBykZTID3iokTHyE5cjnAH0uyQL7vW9xlEdeBrOFQM
         x4WKN1NAn7lQ3PcNBPO6GbpK/72Whnt2jpsVkzTnYxaf9DJhZNqdaHgOWRTHN9KqzJQR
         i8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685405; x=1793290205;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TKiZFeJUlLaF2cjWlbWxlK679IXDg+jtMCj4786GFco=;
        b=R7eVbu12JkOYGfAleeTcHuPppr6VthFyuVXeYGNozgoDMFkSo4nApWAbjKd4BXASc1
         JU9/js3amGMu5Q+pawgRYRJFzgfiLu+BrERdMjqqDqTPw/HqMv9bq6GO53u5fpV5mJCA
         dJAXH+k/wV6iWTrAYDca600wJ0DIkW6UG6fsb6QP0ColvkTt+YSwEGpPrOJsloOpMQYo
         IW2SOT4e3NC0171BxhMU8m232YELF/gfyQq4OWw2OtV6O+QQ9I3zSiug2k+DXOvsvOtD
         n091PPJsVDQPPM8VL/dPa9qZz0WMJtj+CjOOP9wOgqj7KDkyC6HkGZ7FEf34Vv2ZiIWL
         g91Q==
X-Forwarded-Encrypted: i=1; AKwUvByUCiWTmK/dxVlPaRwoY9oQfAnsjcKVjTdnkdhd7kpCRHYBbjjQB82SHowf3/YLHmZ68Zw+jJY=@lists.linux.dev
X-Gm-Message-State: AFq9FYJhmGQCcRWPeW8QqenBzSZ5NZ5TmhWssyr1VFZ+JOE+12v5KPjD
	DHX78b27PKOTYSAMB08/1FU2SwElKH94qQqUZxyTpl2RoUx6cf5WzNycagAFW1NlHfyPVA==
X-Gm-Gg: AYBFou3XJ+8b08Bx3U1bl5GCD4HFE+eisvQkDFIpVj0YptTg9DG66RDw3mJrFhu5KEA
	W2KGk3N8N+uZNQ1LTRGxuvGmfQnpO3IYsQm65OM5VJvIXb9nh0ItjcMEzA3HpvLFy3p+1qV1sUh
	LWrpfYxDr6HBoVVlBv8XlNkKOutOzb96WW0LS9jalEfgD0HbD/C9mX7bFguYf0KQdTIko/Qr37Q
	6JI4ExCs8PyjCpNwG6lSdHtaqAljdvZXdmhahToDOKISlWOMFo9Gc9/cTykqSnHxPKZOx+eagI4
	sa9r3XCP6/XJyLIUpDLhe2fRiNuShQDVquWKwJ/oUGE6DYaEJR6hX/mXonALLYIGffCitHN6OWR
	Z9M/l9TxEtP9Pr7oDFYLxX5WMOOMRcoNIqIFPVtQWjoNJeasTbRpDXnI3c7bwY91N9iEaPlz2yp
	Mc3+c5ci9UnKr/srYgcQR1n5Lve+rXGVeV2uJh53+lOR9j4/iW39lMmD8sFyJPwBTHicfHm/E4J
	/n4ISI/SJa2EIMUYFbS1lt2qJLiVmOI6QS5wWtU/1DS+tcM5KmWasyN/DzBOtuL8w3lr2VjfrJK
	EP1A
X-Received: by 2002:a05:7022:b045:20b0:183:3c2a:ae8 with SMTP id a92af1059eb24-190a84c288fmr7338019c88.41.1792685404837;
        Thu, 22 Oct 2026 09:10:04 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e4f2eacsm14594124c88.23.2026.10.22.09.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:10:04 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH net] net: bridge: do not bypass port state for MST without
 VLAN filtering
Date: Thu, 22 Oct 2026 08:26:49 -0700
Message-ID: <179268538303.70821.3493915601694605045@gmail.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

br_mst_is_enabled() is true when the bridge MST option is set and the
port has a VLAN group, and nbp_vlan_init() installs a VLAN group on
every port even when VLAN filtering is disabled.  While it is true,
ingress treats the port as forwarding and egress skips the
BR_STATE_FORWARDING check, so that the per-VLAN MST state is enforced
instead.  That state is only checked when VLAN filtering is enabled,
though: br_allowed_ingress() returns early otherwise, and
br_allowed_egress() only checks frames that were VLAN-filtered on
ingress.

With MST enabled and VLAN filtering disabled, no port state is enforced
at all, and a port in BR_STATE_BLOCKING or BR_STATE_DISABLED still
forwards traffic, defeating STP and MRP loop protection.  MST can be
enabled in this configuration, since br_mst_set_enabled() only requires
that no port has a VLAN, for example with default_pvid 0.  In that setup
a BLOCKING port kept forwarding broadcast frames while MST was enabled,
and stopped when MST was disabled.

Commit 8dca36978aa8 ("net: bridge: fix use-after-free due to MST port
state bypass") stopped this bypass during port deletion by also
requiring the port VLAN group; the bypass itself remained.

Also require VLAN filtering in br_mst_is_enabled(), so the normal port
state checks apply until VLAN filtering is enabled.

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 net/bridge/br_private.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index ff746f036f54..85065304597e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1953,6 +1953,7 @@ static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
 	/* check the port's vlan group to avoid racing with port deletion */
 	return static_branch_unlikely(&br_mst_used) &&
 	       br_opt_get(p->br, BROPT_MST_ENABLED) &&
+	       br_opt_get(p->br, BROPT_VLAN_ENABLED) &&
 	       rcu_access_pointer(p->vlgrp);
 }
 

base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.34.1

