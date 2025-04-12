Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF83190468
	for <bridge@lists.linux.dev>; Sat, 12 Apr 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460677; cv=none; b=J3oIrl9+FoSzflMbD8OvrWspZGIixfSI0hWFGtLla3auwDKJYtOn1SrgXbjtHMalTjVpGhQbTnYfr0OyDLShBR879cFPfwWCe3TFRB+BTnaWgyzB1fpu9v3WzrT21kZFIT2FqX2dqluwVVetwsu4IhLavaGZ62r6ZSGEaqhwOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460677; c=relaxed/simple;
	bh=NH5eGn6YE0HYD57U3tcNn0RG+jMroQa0IL0NGEFRWvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfGo7w4azjrv9OXptFoi3JL6QEv9Ia9KCc2uTnCyfb5IAKQ8LZGlxWgB88YF87mfU5f7ZOLnOFWl9gSxUAAK/j8Jbc9pYi5KljO9c9oGvM9c3l2lqSp9IKBK++ljWvmDUG3q/sX34tPm08EiWIky4JlKWuCRIkchiloywqiZ8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG/wWMlK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG/wWMlK"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso549016666b.1
        for <bridge@lists.linux.dev>; Sat, 12 Apr 2025 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460674; x=1745065474; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h62p5OZhNIxTCZKWZTx+snSUEMw+Ce8DbeAiOfkzjuk=;
        b=PG/wWMlKxs6SSQDfBvkEtQCliK5NwnmyB0eXff6tdLhVwLgLlLFfL3vQg2vFN9+Sa8
         Oy30iNA29J8eZJwetkUmHMx8tE7Jx6RWV0J95MKiZeqTQ8S7N5q6jh90Ici7PVBhLmK3
         Ii135vDV+KiSLyTTvQWwDVRlIA65RsKPloIXrTnpos364X2+BOlIDVSbUZD5IzpHGdZl
         EOs2VTnsW2jeNhRf+svVXar2Geimd8CaNthhd5/ed7JXMDh/fYcvoUkC7LCVn2S+vpdp
         8O1VJNCsHlkCZ0cXZAMT/mnWZEX0fAEIVNidGzrFfDjcfluXqYjQoRACq92s5ZQANCMc
         f6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460674; x=1745065474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h62p5OZhNIxTCZKWZTx+snSUEMw+Ce8DbeAiOfkzjuk=;
        b=vBzP5hl2yk8CG5QHhSog1u0ZWEnFEVRcXKnP2hl1bBq2b38bDpLpNK2rGQVIp+NxaF
         UjqLbrhJyWMzjtvBTj0+CKOnj0WeIMJTuw76p0/1bLebzaD6PRJ8930GjuFAsu5J3vu8
         92eI49Kdipx1NymBlgF/NOtnDDakWJPBFpBBZCo2ebZbKhMB26RH000AFSLpXvbfFdI/
         TKI+7NwBUMbLweEHJLEXzoNFvWAgq7pltXIrtu4AT5mCXFfLIJUWKJk7oNgG17/i0xAr
         BBWv/ZLyYTql93VoB/KvD3yE5FA4so8qSqmq3RXKhbBHxH9z6R8k5Nke7Xjq2yfenQ9H
         h8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVJj1LYjPdtiBd1eaai2P/BJjWD2htvOd2QL0anbnS4NyYX2lFsKQZKyQB/y6hbEO/elahT2fI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1rGXA0Se7sDMG2eW0GjT6j/uMaHrtf6NfgZr6zfApoBlEMmeR
	Xvv4t9C7k7BBbParVqWaskXctdo5tcv6wqfvEpLYfNsvrp9OD6ia
X-Gm-Gg: ASbGncv+JTboVx9SL9le8sa9OLJTo+Uc1ThNQWxejCkPvnGMkBNCkogZplHv3ag5oZY
	1Hxa+EQXa0pj+faH6DzFUsjKScjC3w9sNZUkFgfKG8BsraETzHyxJ98Ch54x/FgF6+lzmTapP1a
	Mv9uxgi0KG7bjy9W4Ije1MhqJUr8HJpiWAEQoL3oTflsV2taJax+vm0aRdltapOAQO8chmIYoEs
	jALmkUBkkGoBxdp+YHLlZ6yQlDZWY+OzC+l9g68A1cxcEMJC8PcjOGnVMd4VCIqnmP66HfqeXmA
	ls1mpDsfypnZKWzl6wrrtBwitp32KknU/JujcFH9V4pZk7Z/j5mfb1ObxMIKEryaDswEJH4K8GR
	tWQZQb4uhqXyARNlaMpKN
X-Google-Smtp-Source: AGHT+IE3PQsp0woHKCAQep31M5T17L80A7LsFOn3Z/6unyMlIOgH87RRTA56azZ4MIpFb8C9y289zA==
X-Received: by 2002:a17:907:9496:b0:aca:9a66:9a2b with SMTP id a640c23a62f3a-acad36d93e8mr477078266b.55.1744460673553;
        Sat, 12 Apr 2025 05:24:33 -0700 (PDT)
Received: from localhost (dslb-002-205-021-146.002.205.pools.vodafone-ip.de. [2.205.21.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccc363sm603439066b.146.2025.04.12.05.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:24:33 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net 1/2] net: bridge: switchdev: do not notify new brentries as changed
Date: Sat, 12 Apr 2025 14:24:27 +0200
Message-ID: <20250412122428.108029-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250412122428.108029-1-jonas.gorski@gmail.com>
References: <20250412122428.108029-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding a bridge vlan that is pvid or untagged after the vlan has
already been added to any other switchdev backed port, the vlan change
will be propagated as changed, since the flags change.

This causes the vlan to not be added to the hardware for DSA switches,
since the DSA handler ignores any vlans for the CPU or DSA ports that
are changed.

E.g. the following order of operations would work:

$ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
$ ip link set lan1 master swbridge
$ bridge vlan add dev swbridge vid 1 pvid untagged self
$ bridge vlan add dev lan1 vid 1 pvid untagged

but this order would brake:

$ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
$ ip link set lan1 master swbridge
$ bridge vlan add dev lan1 vid 1 pvid untagged
$ bridge vlan add dev swbridge vid 1 pvid untagged self

Additionally, the vlan on the bridge itself would become undeletable:

$ bridge vlan
port              vlan-id
lan1              1 PVID Egress Untagged
swbridge          1 PVID Egress Untagged
$ bridge vlan del dev swbridge vid 1 self
$ bridge vlan
port              vlan-id
lan1              1 PVID Egress Untagged
swbridge          1 Egress Untagged

since the vlan was never added to DSA's vlan list, so deleting it will
cause an error, causing the bridge code to not remove it.

Fix this by checking if flags changed only for vlans that are already
brentry and pass changed as false for those that become brentries, as
these are a new vlan (member) from the switchdev point of view.

Fixes: 8d23a54f5bee ("net: bridge: switchdev: differentiate new VLANs from changed ones")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 net/bridge/br_vlan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index d9a69ec9affe..939a3aa78d5c 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -715,8 +715,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
 				u16 flags, bool *changed,
 				struct netlink_ext_ack *extack)
 {
-	bool would_change = __vlan_flags_would_change(vlan, flags);
 	bool becomes_brentry = false;
+	bool would_change = false;
 	int err;
 
 	if (!br_vlan_is_brentry(vlan)) {
@@ -725,6 +725,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
 			return -EINVAL;
 
 		becomes_brentry = true;
+	} else {
+		would_change = __vlan_flags_would_change(vlan, flags);
 	}
 
 	/* Master VLANs that aren't brentries weren't notified before,
-- 
2.43.0

