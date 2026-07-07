Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB93909B5
	for <bridge@lists.linux.dev>; Tue,  7 Jul 2026 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415478; cv=none; b=libnbsQOrk8l7CyqtFlLhM9G+JdYPr5SkzXRMiJvLJvn+ZRsrvh7dlzcNIYaz3JGoHAsBwKEn1FHvfJ314+J1E6YDxw+y7DzDr3t7Syth0EIGLRzC1g0YiXl5r/1g6AuCNattIIWLq4pAiz/R1f4fqwelpXvg+utMDyROp8eZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415478; c=relaxed/simple;
	bh=LcdpFlrsMeZN7QoWRQhK/cKX1hTenue3TaEEENYMPZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tu67VWbv3SJkjlQMzEq4YZPHqiUWG/aNjZonK9iNWDks0dUuoG9YcA6pWFZXrGMCZPkSEypygdhTz/8e+FxbToHAwy7q3PL9/GlVZTAl9TgGdaxvUq520uSq7e1jzoxDJUjDNMbjD02abqVLU4Jy2vGKA99Wl9Kh2cErSjCvINg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARjqbglw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARjqbglw"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698c0ff45b5so637799a12.1
        for <bridge@lists.linux.dev>; Tue, 07 Jul 2026 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415475; x=1784020275; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1RZuLSLPgvQmrHlTSn76qYj1An3fG36jxd15dXTQDE=;
        b=ARjqbglwbVkPDG6NYwCH3tfbK8yLNw4vUtsgS6HgkDItsnHnEUYmJJo0hVdkeqw7Tw
         cOlDnqAOnWbWI/r+NyteRp0vIrrQm4o2YmLWOVpqky5ManlbY+b8S1JVC5eX9grd09r8
         JUf/0t45Dw4vUnosHTRBzY+wAFJyN6ECDaxJnkalmOaK022AyJxBgQWMFnIpujf8RZBI
         ydcvPqG0H7Q1RQc4Pj7tc3Sq5lHXK7iV1Elxgj56t1KO/pjGlMDUBgeZwH4TBNxQv70S
         J/eVIZKYBiuEy2leLm3ZB4pQJxLUsQ9c+xJ2Ze7bjXcoSi+EGVb+FgbtDzj1Z4sOTQUN
         6g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415475; x=1784020275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1RZuLSLPgvQmrHlTSn76qYj1An3fG36jxd15dXTQDE=;
        b=K9mdcLnK0y+8s1hzGLy1vH58w09qUFg+Q0NhT/pptbx0ORVeOxKMyfKYFpxdoS8u9a
         B/Es2sp/ccLfuMp+/eDzP97RECXhPuer3263xyE8u4Epxiu4QP5Tqs+JGAg3BNiIh2XM
         9MhVBExMls3bdZkvcV3BmujED4Ydpcb1JXT/5XMPyg5gJyJqy/RcYtXc/rf4Z6wK1NEa
         eXVFd8fxE/oYuRkjeIu4VJ6/z8Bfb1CqOcgcgEPuyOt8VXofwoo8FRm3i+rA0SXOx4I3
         vHGJJeikjzbBxhAGxYqm45WqXLPUWwF2a9jTJ+f8lgpAPfj2PKz0O8Wymo8XR+6hhMhb
         T36g==
X-Forwarded-Encrypted: i=1; AHgh+RqvUuclrheDa7/p1tBOv6Pcp7hN9JiyF+aw+HsW5lNx8Ce28SpbJR2tOErkNLED83tTvQnfZwU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxg6g3zk0apQhDJrTe2RQ0bCJXXbOavzJ9i80zM0A4DxSIAi2Cb
	GE1EmOcjCrDbCVIzUtt5/zAa0/nf2Vjd2yXW5CdZQlcXTsxBqBYgqx94
X-Gm-Gg: AfdE7clkNvDgjvG1q8MP3p4DXgub8KWxaTSfDQdj1fxsFr3yM1iP4JppSUzT57I7JUH
	rTye9rxvKLlnHF3gPaKRdviNQerljSnj7vuOju06Alq7TTKSmWsqyk/BIeOPNW1/cCpUW9W4KC6
	luR9jbolBcsyMvzaqbw27OfxD5NHI1kJDuPboM9WmtoWFgoTojZK8AkehalAZOZ4BKFG0eluk+O
	yanfCwikJ8AYX6Z0lrdRnIIZU2388pg6bvUR2tLWYufuoca15ntEmPVyAz51CpsTbz12lghnc6I
	dPhaM53tChsOtTSJEBg7LCcFF/GUMvnNHgzj8lG1Okll0t6gE0ugO9T0SjybycmHBq/AYCoaLip
	k1SllqP6TWDXVG7f28OeII7LmeM8D7+cym+YZP+jVLErmuClu9vC0TJnWzsH5Fu4ddxBEPGVcUn
	d36fhbNqh5LkFo/xVjECRk/d5R3+oJG6+1l7ew0VcRQb6q/HpTWKvodasmmvBOyGxjcjxWLvl5l
	SRgGExPPtUfw1T4eO3n2MUANu86/uVPGOpcM2Ii3268
X-Received: by 2002:aa7:d391:0:b0:69a:3652:9d33 with SMTP id 4fb4d7f45d1cf-69a9113f5dcmr667742a12.19.1783415474861;
        Tue, 07 Jul 2026 02:11:14 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd87d6sm5297152a12.6.2026.07.07.02.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:11:14 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v12 nf-next 0/7] netfilter: Add bridge-fastpath
Date: Tue,  7 Jul 2026 11:10:38 +0200
Message-ID: <20260707091045.967678-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset makes it possible to set up a software fastpath between
bridged interfaces. One patch adds the flow rule for the hardware
fastpath. This creates the possibility to have a hardware offloaded
fastpath between bridged interfaces. More patches are added to solve
issues found with the existing code.

To set up the fastpath, add this extra flowtable (with or
without 'flags offload'):

table bridge filter {
        flowtable fb {
                hook ingress priority filter
                devices = { lan0, lan1, lan2, lan3, lan4, wlan0, wlan1 }
                flags offload
        }
        chain forward {
                type filter hook forward priority filter; policy accept;
		ct state established flow add @fb
        }
}

Creating a separate fastpath for bridges.

         forward fastpath bypass
 .----------------------------------------.
/                                          \
|                        IP - forwarding    |
|                       /                \  v
|                      /                  wan ...
|                     /
|                     |
|                     |
|                   brlan.1
|                     |
|    +-------------------------------+
|    |           vlan 1              |
|    |                               |
|    |     brlan (vlan-filtering)    |
|    +---------------+               |
|    |  DSA-SWITCH   |               |
|    |               |    vlan 1     |
|    |               |      to       |
|    |   vlan 1      |   untagged    |
|    +---------------+---------------+
.         /                   \
 ------>lan0                 wlan1
        .  ^                 ^
        .  |                 |
        .  \_________________/
        .  bridge fastpath bypass
        .
        ^
     vlan 1 tagged packets

Note: While testing direct transmit in the software forward-fastpath,
without the capability of setting the offload flag, it is sometimes useful
to enslave the wan interface to another bridge, brwan. This will make
sure both directions of the software forward-fastpath use direct transmit,
which also happens when the offload flag is set.

Note 2: For complete testing this patch-set, see:
[PATCH v5 nf-next] selftests: netfilter: Add bridge_fastpath.sh
This mail also mentions other patches involved in this, some patches
already applied, some patches are not.

Changes in v12:
- Added Note 2, refer to selftest script
- Added patch: nft_flow_offload_eval() check thoff==0.
- flow_offload_bridge_init() removed unnecessary call to memset().

Changes in v11:
- Dropped "Introduce DEV_PATH_BR_VLAN_KEEP_HW for bridge-fastpath" from
   this patch-set, it has moved to another patch-set.
- Updated nft_flow_offload_bridge_init() changing the way of accessing
   headers after fixing nft_do_chain_bridge().

v10 split from patch-set: bridge-fastpath and related improvements v9

Eric Woudstra (7):
  bridge: Add filling forward path from port to port
  net: core: dev: Add dev_fill_bridge_path()
  netfilter: nf_flow_table_offload: Add nf_flow_rule_bridge()
  netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
  netfilter: nft_flow_offload: nft_flow_offload_eval: check thoff==0
  netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
  netfilter: nft_flow_offload: Add bridgeflow to nft_flow_offload_eval()

 include/linux/netdevice.h             |   2 +
 include/net/netfilter/nf_flow_table.h |   8 ++
 net/bridge/br_device.c                |  19 +++-
 net/bridge/br_private.h               |   2 +
 net/bridge/br_vlan.c                  |   6 +-
 net/core/dev.c                        |  66 +++++++++++---
 net/netfilter/nf_flow_table_inet.c    |  13 +++
 net/netfilter/nf_flow_table_offload.c |  13 +++
 net/netfilter/nf_flow_table_path.c    | 126 ++++++++++++++++++++++++++
 net/netfilter/nft_flow_offload.c      |  32 +++++--
 10 files changed, 259 insertions(+), 28 deletions(-)

-- 
2.53.0

