Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907E2C0F6D
	for <bridge@lists.linux.dev>; Sat, 19 Sep 2026 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825431; cv=none; b=FPK01Ub5ebUKPNRGJTw9n/p76EYyBaIilT94Zl/nN2znbEKoYGBK1iLGZUU+ZLfLChldSB48wUzz+7RXRsgG9gBLSBdKncjwMCbOsYKhA/NEdCwxsUgfG1xgkAEL8Qa57ex5ZClILtpA8JLF3Fo4hGAeo64f1CIqK6QxfAhdlPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825431; c=relaxed/simple;
	bh=dFZ63T3zvOowaEIbbYHyNeo31i69lA6u+JkTJ9+rQeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1lq4ypPlGRWCN3hIKcveAwvLfnbyQtoQJhLS6Lfe0BVoIU06IkYgutCHMsUOz3BzWPUXQ7gtkraZDCOsjkLygTVHIQZbo06xbhde/FQ+yocu6kPPbuxx+F0mdQ5W7ttyPFE7l9C+1KZyudz+Hx1SbyI3SEJuZazJnVcKMM+YnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnLQjrIc; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnLQjrIc"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff00b8d8so13882621fa.1
        for <bridge@lists.linux.dev>; Sat, 19 Sep 2026 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789825428; x=1790430228; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HuHF/oDZVPSpibhsK+iPHeV9FkZXWA2uFO4o60iu8z0=;
        b=DnLQjrIcgPc8oQV9s0nBzWidE4qYC85PFsrZab7kdl/iOWuHH22OEGTaWkl1mtLoZz
         QcV3G/PX6JqoAprBdqYwNUjmvJa8j9LpYTq9FlIf/nGB6EOXUfeOt+BQJrsjJFRMxMYI
         fFl743WpmT6VSmkkQICnXIKStSY+D1MwYCtFiB7C6sN1eiVdWmg8st4py1MjRwveTZ71
         ZnkqwBoxWnxPYmC0bE8PxHbxLSS8jIMvJeOu7L4MU4qDoqreWKl4Fj1a17m5raLsc9bl
         73PxTZW4UcUFkoDQiVstEfDrPwMBLXx4qWq23oYkdvnpAGKwUJE9gSUWJHf/I7gbfXdD
         5uDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789825428; x=1790430228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HuHF/oDZVPSpibhsK+iPHeV9FkZXWA2uFO4o60iu8z0=;
        b=YjwqAEZ3FQ3RES8xUm7Bm4QQiAXCA7NxUcxjFV08MearmW3fdSdD7E8m8k1WnHRtOY
         Wv9iwUrVC5CcVFb0mmK+cH9EYg0bLom2njCzoxgq4+2mrvFN1vTPsLQc+UQYbiFWMkGF
         umZVrIqvxQSQ2rczSGxBFWxCGAipPw+Wi05kLlSY0yAqI7HNakg6ku8vQRBjx0LhEmoC
         B4gBgSI8J6KhF82q4fgJEHiXowjo467n4WzbDY9VLcWOgdg+q27Wg9c3VlsUqzPZiiL7
         9t2W5NwLKYYf+X1dI7E6WoKZOiT3mN7cE9jlwZdpkE3ujTqRv54x2JYu/CwMbjos4AKt
         Se2w==
X-Gm-Message-State: AFuF++ly+rmxwsbvWhxS+k0LfM6tbQQ8kVlCwF1fxRVPiwVwWfTppQPE
	qePFv0QLjV4dpBjdKECjII3lhmjZgQeKQ9MQqg4p9DlmbwqmaE3wxGtL
X-Gm-Gg: AYBFou2Om4p3nRCJmikvPQpk/epsyQm9PNISnwtaB4oBSB6uDzwKWkWZ9iCnRF6ekv/
	ppRzmb6k9QlKdjgadB5EP3zp3T9RT5CU0jE9b6cOoJcby34igWYueVQzxpiXq4oqiqU+TKYX7yl
	SOOz2tjSBdEY1uuegwikeb57abpRTbWHcw7sxqyZRfdlkXwqYURr9PA/I/H+mF3qhwrliAAiFuj
	CWHCo+73nTI3lI9VbpSLkY93yWIDs82dDllq89v850jtxf8DOivGBV4tBkwdXlS9XHKbre1C5VV
	T25+NFBfyaAoF4pra1zSoUImjW7cUFgkpKLUPLdq/iAlkp8avElz+ePklu2VKh3/R7bp8QKxa6q
	i58yVCbNRjWSzSgvrSqalAD8ikLI5v9ExIyyZjSROmZDJtlfDgjB1x0i0ssyeCBTqOZ+1VtUP9S
	FoY0p82UZuMePtnqyvFIYREXZAW6KNTNBLjAcUX327TMtHGoPHEx/g4h0niX7u+iOkJB/pINigo
	OWHAsu107ZGNAk0mTWW2Kr5q66arqDDkCzbYoR+0qZV4CaBUuWBzsM5GYJlnhdtj/Pt
X-Received: by 2002:a05:651c:2213:b0:3a3:314d:1169 with SMTP id 38308e7fff4ca-3a5fbf05908mr10726771fa.1.1789825427681;
        Sat, 19 Sep 2026 06:43:47 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60767aa6asm6220941fa.40.2026.09.19.06.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 06:43:47 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	kuniyu@google.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	oss-drivers@corigine.com,
	wintera@linux.ibm.com,
	aswin@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next v3 0/2] bridge: report an oversized IFLA_AF_SPEC nest instead of truncating
Date: Sat, 19 Sep 2026 16:43:31 +0300
Message-ID: <20260919134333.49379-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 adds extack to ndo_bridge_getlink(), patch 2 returns -E2BIG
when the AF_SPEC nest, or the MST/CFM nest inside it, overflows nla_len.

v3: handle the MST and CFM nests too, use nla_nest_end_safe() (Nikolay)
v2: https://lore.kernel.org/netdev/20260912135022.1701-1-iprintercanon@gmail.com/
v1: https://lore.kernel.org/netdev/20260906224246.21719-1-iprintercanon@gmail.com/


Artem Lytkin (2):
  rtnetlink: pass extack to ndo_bridge_getlink()
  net: bridge: fail link info that does not fit in a netlink attribute

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  4 +--
 drivers/net/ethernet/emulex/benet/be_main.c   |  4 +--
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 ++--
 drivers/net/ethernet/intel/ice/ice_main.c     |  6 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  5 ++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +--
 .../ethernet/netronome/nfp/nfp_net_common.c   |  4 +--
 drivers/s390/net/qeth_l2_main.c               |  4 +--
 include/linux/netdevice.h                     |  5 ++--
 include/linux/rtnetlink.h                     |  3 +-
 net/bridge/br_netlink.c                       | 28 +++++++++++++------
 net/bridge/br_private.h                       |  2 +-
 net/core/rtnetlink.c                          | 18 +++++++-----
 13 files changed, 57 insertions(+), 36 deletions(-)


base-commit: e3bfd25626b44b6fa61a13c17178922171d519ce
-- 
2.43.0

