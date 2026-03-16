Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949463382DE
	for <bridge@lists.linux.dev>; Mon, 16 Mar 2026 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635213; cv=none; b=unaB1e55cHU2RWUEi9tyaKIk4DN38tl6fxkYmjyMEuGhdNVarMuhoL1xC7OUZbdaUv9XZtXwiIs7utXMSkR8eSP6gJMGcZ+KgalR1NwoBzDB82Av86oiHPz15HsbSmg6ACqoWeHYtKKpHGyRUSyypy7J16Q4nakpFIs+wlQ9fAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635213; c=relaxed/simple;
	bh=4vs8RNGc7MDno4+X32x3Mh+tGMstn+YXEKpVY+sxySA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Eh7IC+RPoOLghwVtdeiLb7/HRNYhZfGa6TBaCWalFtRIZ1kjO0yrb6bm30TgyzDfwuM1ogPkqO2o1tYoYRuH3oQmFF3LPEdr106iKIUhu96JbvKTZfNoKAk7NSbB8WJYg+/TNIaoWvsxXTmLaGs+USU1WCu/ItVO+tXYDIrmxGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVDzzjsQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVDzzjsQ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so600383b3a.2
        for <bridge@lists.linux.dev>; Sun, 15 Mar 2026 21:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773635212; x=1774240012; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QG6YmZw2q5tnLzZ0HARS5dPxw6jYWbvpIUxUxyo/SI4=;
        b=dVDzzjsQPASwe1JG0djIFQXG6Y039fBKNuOwUluLnjJ2EGJdNH3c3DA9JM4UNSPYKa
         yv051GbHblszhh4HeXuGJ5OqqGCr35q1w7SNzaiqCjdbOJbvxN/oHejZsrsY83otGyOX
         COL7jyJlnWP7axqkuQY0K1JWQj++W+W5khL2H8KS1LzogmGLHDZsd/aIJ/BvrpvW0093
         xNHfODG+MIk5IKXUIb/dJjRkLGWw4thT+R4/5YjUHJoChhEiqrIZvTk6e2wp6fXNiSAd
         phGI9hhBvaPo9AdCnlgcakkPhZHptrsZhNqf7MxFgZqbihpZLjoKm4JxeewNLMyGG74H
         h/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773635212; x=1774240012;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG6YmZw2q5tnLzZ0HARS5dPxw6jYWbvpIUxUxyo/SI4=;
        b=X6F3BVZJeDUI+09eoHRQpgGLYAm+Alzp8AbA6yM1rn6kH5GEKaEwVv3FoGUWWUHktv
         +gDM9W4wMujLomj5lcdr3ogzwoEtAMGmgO7F2d0oPEF81mOfxWnUdk++zoTp749Cw6FQ
         4SuwUHh0QlVpWJ8bBsJq7RnoGxjCFLG+73W/1t3L7UTeR+y2dszM8hMZ+VKWe89wt/CK
         DOg6cn2r20dnrQBMj1aC6jCHQQPLmkoOg8tghFoxdBOKLDyrBebpCj/LWEFbsa/X7adO
         f7FQ5Z2DEE79mGZ3uQzm6Uy0TOKB51fzmISTMWuQLoYNlZBfnTkHpk/Idyamxh788oCq
         eLEA==
X-Forwarded-Encrypted: i=1; AJvYcCX38BcwYomI/uvEqGxPfsyTN9roMocv3ga8j0BC9A2jkI6K2Sk4G+LfX+sS1uaRKj3kw9w92Vw=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywra8m1OLpYcey8tkAxVDH49oYlIYi42DLAYVJIbZ8k/sTtOIZI
	k64Sxn+lVCj2ryl4bJsrayjToIE84edmdSvhyVmV7Yo3gg13msy/mMcf
X-Gm-Gg: ATEYQzw9p3AeWjTeuwExmg+310JxXnRz1p9LoKN0gFBGTOsDoH+EPY2KxeCDazmEPbG
	DC91Nx2XmzqsdtTFID/degDArpvOLnYvjAyGWVvvj3xmhCisqgBZxMAkQU3X8b9U7M/JGB34xl+
	VqNWGuFJGHci0M0BOVurlb0W1Q5pqu0mzpFLhJxyRarHiPlnnELM1tb+EaOs8z53QzAsKFL8Sou
	qn+FJ7AQxRsxGMpV6u3NgBs5LuZs/v+80q+XZG/0G4hQ9M9y3IjE8dQFgSABJ9j8gNG/NZVODBw
	zJMGTtoJSD0JAPwlmMpDd0JLtH1eVRx8X+LscrwEuQo2HpT6ew2nG+GXFFXL0q4yCJb7bvDj1I0
	mnXgYOp0CSC78KfW2j4ns1XWCInrueG5AVa0COw2DZg93YSYBF3woo8gDJ2eN5InDDvDUT6Lihi
	tWGPBOM/I21ni4gxaR6VxBVOURKWZWTpos2dwE0AU72+XnnRu0f51101OjBulw3O+9iJ0p
X-Received: by 2002:a05:6a00:929f:b0:829:822e:cdc9 with SMTP id d2e1a72fcca58-82a1970498amr10802677b3a.2.1773635211899;
        Sun, 15 Mar 2026 21:26:51 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([240e:34c:5760:3860:bc29:deed:92d0:823c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738422esm12180267b3a.55.2026.03.15.21.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 21:26:51 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v3 0/5] net: centralize master device offload
 feature computation
Date: Mon, 16 Mar 2026 12:26:08 +0800
Message-Id: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WN0QrCIBhGXyW8zvinbbWueo+IcPq7CZsONVmMv
 Xvi1SC6/Dic860koDcYyO2wEo/JBONsHvx4IHIQtkdqVN6EAWuAV0Cd1qMT6iXdNL8j0rOETmj
 BEBgj2Zo9arOU4oNYjNTiEskzk8GE6PynXKWq8L/VVFGgXOlLK6FF0dT3fhJmPGVeWontff7rs
 +xr3cmrxFrVIPf+tm1fUZn7QPgAAAA=
X-Change-ID: 20260310-offload_compute-4c0bafa2e022
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3

Currently, master devices (bonding, bridge, team) manually call
netdev_compute_master_upper_features() scattered throughout their port
add/remove operations. This approach requires each driver to remember
to update features at the right times and leads to code duplication.

The series adds a new ndo_update_offloads callback that is automatically
invoked during feature updates when upper/lower device relationships change.
This centralizes the feature computation flow and removes the burden
from individual drivers.

---
Changes in v3:
- ndo_set_features may be skipped when no feature change, fallback to
  use ndo_update_offloads for offload computation (Simon Horman)
- Link to v2: https://lore.kernel.org/r/20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com

Changes in v2:
- Fix macsec Security Entity uninitialized issue (Sabrina Dubroca)
  - Tested with macsec-offload.sh, rtnetlink.sh, link_netns.py, all pssed
- Link to v1: https://lore.kernel.org/r/20260310-offload_compute-v1-0-3df79c09ea65@gmail.com

---
Hangbin Liu (5):
      net: add ndo_update_offloads for offload computation
      net: use ndo_update_offloads to set offload features for bonding/bridge/team
      macsec: move netdev_upper_dev_link() after macsec_changelink_common()
      failover: use ndo_update_offloads for failover offload compute
      net: no need to disable LRO specifically

 drivers/net/bonding/bond_main.c | 13 ++++----
 drivers/net/macsec.c            | 23 +++++++-------
 drivers/net/net_failover.c      | 66 +++++------------------------------------
 drivers/net/team/team_core.c    | 14 ++++-----
 include/linux/netdevice.h       |  7 +++++
 include/net/net_failover.h      |  7 -----
 net/8021q/vlan.c                |  2 --
 net/bridge/br_device.c          |  6 ++++
 net/bridge/br_if.c              |  6 ----
 net/core/dev.c                  | 11 +++++--
 net/hsr/hsr_slave.c             |  1 -
 11 files changed, 55 insertions(+), 101 deletions(-)
---
base-commit: 5446b8691eb8278f10deca92048fad84ffd1e4d5
change-id: 20260310-offload_compute-4c0bafa2e022

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>

