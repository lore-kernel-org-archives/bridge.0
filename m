Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555E41C5F1B
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122499; cv=none; b=AtICYiGhKK7MK9/Gh8QqynNJugrm+0DKBLXuMyfCObDIGXbSL/jig0bS9j03Nac5MOsJo8beoJedTn0LARUUi1ywiVyqI+UoN/7dno5znYNrfps66qeyImQUNKkURgx44FfbXXwGz6StLXmDfRM1NCEeQHNPryV2y9cK3+FcVpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122499; c=relaxed/simple;
	bh=lErjI/YqIYRsXvXQflvwzYfNLYFv4Um1Zmu0i4NiNm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEzFIdWjYOGzvPmrnyJy5Yi3aLep+eh9796SMgQNbu6qIpS2+06EtMdmut5UGpZ6wq84cb4DPdc8qBSkKx4rxlseoPKYiJ/tl3Rhx+1lPA+gqPe9w0Qt6j+L14Unq66DclFobDUEvY68XFDhTrG65kJVen1oOpWU16yO5I2lRD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOXV/K5I; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOXV/K5I"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so10271617a12.2
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122495; x=1744727295; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5BFzr+RmGXXOsHTXqFyGDkv5yWiKdI5zdAeFPopjpSg=;
        b=bOXV/K5IaG2fgdph6ldgbAR/NG64eQcqA2YrMumbnf6UwqmWrW0ZdcbY8mMI/NtkTF
         nDF131qPRcT85Yz10forFh87LrYCOpCSyck1swhP0neNTPuHTwdV7i5hzCvHk8Mzrill
         wnYUx0mYFELkC4Vx39gvfi5CvQqkhRaZmYEOoTCtXu4WyENM2eqFMLO9MHHOcl3lW1xw
         jmuW/qBbrIahdQopqPqXVFepotWimz1v/Ri19jL2j7sa5DxoBxk1Xo4ruY2Fq4sAXGKi
         +VrbEYPEVvPzBg81H8ZwsIiUXBHkhkw0JRcBc0c/cOpYlHAJARaUwaG4iJu+4GnaU/8O
         oWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122495; x=1744727295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BFzr+RmGXXOsHTXqFyGDkv5yWiKdI5zdAeFPopjpSg=;
        b=TNoZnJkjum0QecI5hEhMC6isthxKZBHWUSChtsoJrIrSgWzwE1zsCMWGTJZyklmR+s
         9lkqOAwixaajx3XhIpffJInkbjb2Wmt2F0NKk3Wx5J/4CFOJwPzG9tnhrSTzzgDB0fZs
         y77xxwwjrbYgZ6pKnDtlB/SElYCEta8E59lEh+oCDtvIGGLEc4zn/O9nDdhBtVVMdkrl
         aVRXWLPTU3pCxlqdhsD6LCHolH1YDWYzE7MD+WF6lMe88PA88VHJRMGCa0mOc4HwuIez
         vzXzmyg50WgaGqcoKgpK0BNOUluNMT9ciTE8AuWH/7qdrxxF8a0ZjzAdsLU8y02LoybI
         nk9w==
X-Forwarded-Encrypted: i=1; AJvYcCX5fIokV4lv9fzjdo6BPYdce1EMaoSXX2dez/ZuXklthSx5TnbSr8F0bpWkDvsd0Eutpl4G6RA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6jiFLRTWvfW8S06Nt/zF6Cs3CbbZV6X2NhC/73wiuR51YMmEc
	9BkYimX3zP5L8euQFezp3uCRplHQAMs1qumkHjX0/t1SfhuEHB8Z
X-Gm-Gg: ASbGncunc7UZelCWRYBRD5054yxn/+TE3pBL+Yx4Y7o6MJymxAYftQCB6Mq0q/0TvQW
	rRNpt5ADs2EfM7b96JBZqR55yeXcLdm4QyE5A29X0SVQ35UoYVprMZC2yQyHA9CH989fna6LYxx
	aVJ4D1BkD7hmWsMHjPeXokRnmmk2AIQEdu9A/f4GLOtwJFpTWQElhIOCSTATEMezwRYR6gPb/rv
	A8BsSPqmAK4EM4oUCh1LvjgB0ePm9CQT13eqK6O5ukang9OXqw4a3QrNo/rn3Bwvie/lhBxU4Ki
	lsoZmpjc+FiglPqWC3vDzXsb9crRTlLkjOxM8r/21DvBSGZWTea9ZeKMBO5TMDgvyNw+NkvK3hg
	vy4GXfR8t3NuQOWTR1uFGsok1hkOSsVULY4YSYhhLNcTetJqxrFcLArFC3BMlmFQ=
X-Google-Smtp-Source: AGHT+IGGUQrSOB4qpE3QjNkiYb11QRJ+mj4qPf57cTWASVDr2tmbCOxluKgRKa8GJjYOmWsNRMZVYw==
X-Received: by 2002:a05:6402:c45:b0:5e4:cfe8:3502 with SMTP id 4fb4d7f45d1cf-5f0b3bc9216mr16012511a12.17.1744122495447;
        Tue, 08 Apr 2025 07:28:15 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f1549b3fd0sm2236164a12.35.2025.04.08.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:28:14 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v11 nf-next 0/6] netfilter: Add bridge-fastpath
Date: Tue,  8 Apr 2025 16:27:56 +0200
Message-ID: <20250408142802.96101-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
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

Changes in v11:
- Dropped "Introduce DEV_PATH_BR_VLAN_KEEP_HW for bridge-fastpath" from
   this patch-set, it has moved to another patch-set.
- Updated nft_flow_offload_bridge_init() changing the way of accessing
   headers after fixing nft_do_chain_bridge().

v10 split from patch-set: bridge-fastpath and related improvements v9

Eric Woudstra (6):
  bridge: Add filling forward path from port to port
  net: core: dev: Add dev_fill_bridge_path()
  netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
  netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
  netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
  netfilter: nft_flow_offload: Add bridgeflow to nft_flow_offload_eval()

 include/linux/netdevice.h             |   2 +
 include/net/netfilter/nf_flow_table.h |   3 +
 net/bridge/br_device.c                |  19 +++-
 net/bridge/br_private.h               |   2 +
 net/bridge/br_vlan.c                  |   6 +-
 net/core/dev.c                        |  66 ++++++++---
 net/netfilter/nf_flow_table_inet.c    |  13 +++
 net/netfilter/nf_flow_table_offload.c |  13 +++
 net/netfilter/nft_flow_offload.c      | 151 +++++++++++++++++++++++++-
 9 files changed, 250 insertions(+), 25 deletions(-)

-- 
2.47.1

