Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6C321D
	for <bridge@lists.linux.dev>; Fri, 19 Apr 2024 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513755; cv=none; b=V2pZDCSh7CilkACduoMTg1XK2Nl08S7o6fV9ayFXwrjttYKBYoWGHpqy72nzKqpjlDxCv65AzwtRvxesyp+ZpJOOG0wup1U870Fuow0k5KO91b+eVYc8BeXRHhQ+9iY8967ITJV5kXZoRHZyjo21fBT01TML75Zr9uoW63/FsD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513755; c=relaxed/simple;
	bh=myVJDsTKa/WXoL1yBWtObLyf8yonTFEDcG8Zxydo+U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcJK+6rdFYXfV29rN9v1o8pP1lAccb+6GvOzCt4IXvp0NW0BeZrkjHaZytK99NTAwC1fyl3EBDVBfrwlLJFQS1TqcAguD95xgVYIf05HwPQXSQthW+AmZxkJTrW5Yhc9gjfd2YCDYeN7wyFwPVyPt3t9U8EtpNY6eNjdfd7Q/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyR1tnda; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyR1tnda"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so1263053a91.0
        for <bridge@lists.linux.dev>; Fri, 19 Apr 2024 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713513753; x=1714118553; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NbIohFzFH14A3SlvF9HeYBj5jvgE3wBhghJ4bHde3o=;
        b=AyR1tndaF2cJeiRJAh0BXC87bT+zpthhgFqfAU933G2MwHNajRq5eLsWC1DbLOR7rN
         7UjtF+EXOJSoVnvBjuHFJMjlj9gQx9Te8vhR/6HRDcSG46UFZuZvibtOuSm3tVgA5f+B
         tIP8uFN+UhT7LMujvXS9+y5FaSPZuS+tYmOiCSyjAr6mak3M2lOY8WOQBGdxIU8D9h2r
         qlOaaezzETerDYx5gqUcBW6jzyh3TE9mTgze3u+zlcs++2sNgEGWRuMD1/gS61uRadWm
         eSwVcYzyYmEo7cq0/CGhY5gvQ+w+j4tqSrfyBjxhaxOcwvkPEHlMxv1VMlsRSFlAsfzj
         vX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713513753; x=1714118553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NbIohFzFH14A3SlvF9HeYBj5jvgE3wBhghJ4bHde3o=;
        b=LXJcYB7Ahk+qDbxEQe0YUuwuaKK82JJdEMH+bIQbAXL00P7hZJqQ/nELo7TCipBM9l
         gwVKTOmmciegc+ZWfWxevyzEokV4gw4jzED3qGghvY5LTvUOKYbRebbQjJ8ZpCuCwxcg
         PkK3BegUJ6MCa77/mbkTmBnioBwl715TW4VJLA4VpWQ5RVOtYAAng6cXcS9Wg+Y5prZV
         u4AVszkoOYgf9eijS//cPMgdjTIdFiVdbJzGT2jhQy86gZy5F0LOGVzfVpaKDF9smlgO
         esLCHXarJG2vCMO7g33L7ITv9NAUUJrCtvhRlHK053+YHJmzv0fvoDIZtsjI1leUBan1
         tlfA==
X-Forwarded-Encrypted: i=1; AJvYcCVFs+3WGIMrfYMltOhjFsNKd3o0pW4xnx8mYGlYexv1NnJX9w1tVBwg5gy/pe9yEyLq4jGSs4t42BLDLx309bxZMPdxOhKR
X-Gm-Message-State: AOJu0Yxr7IaWmQglpqON9KJ90FyDmWMfKXFjFy7dT63N95chWjjY/PO2
	niCYCmxzxYfQXfSzm6IqctoaTbkmjmhBRKNqJOLxx8BurBFJv0f5
X-Google-Smtp-Source: AGHT+IFEjwzZPgiuLVd/yxNg1EAvsl6OMBBNIxdraC43rkRPkiT0JgZ14y8A5G3KWtCrBq3X0eUCQQ==
X-Received: by 2002:a17:90b:4aca:b0:29b:c31:1fe1 with SMTP id mh10-20020a17090b4aca00b0029b0c311fe1mr2151220pjb.10.1713513753240;
        Fri, 19 Apr 2024 01:02:33 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090a840100b002a78c2e21b3sm4331561pjn.20.2024.04.19.01.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:02:32 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Henrik Bjoernlund <henrik.bjoernlund@microchip.com>,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] bridge/br_netlink.c: no need to return void function
Date: Fri, 19 Apr 2024 16:02:00 +0800
Message-ID: <20240419080200.3531134-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_info_notify is a void function. There is no need to return.

Fixes: b6d0425b816e ("bridge: cfm: Netlink Notifications.")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 2cf4fc756263..f17dbac7d828 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -667,7 +667,7 @@ void br_ifinfo_notify(int event, const struct net_bridge *br,
 {
 	u32 filter = RTEXT_FILTER_BRVLAN_COMPRESSED;
 
-	return br_info_notify(event, br, port, filter);
+	br_info_notify(event, br, port, filter);
 }
 
 /*
-- 
2.43.0

