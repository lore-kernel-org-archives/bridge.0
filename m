Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D34119E0
	for <bridge@lists.linux.dev>; Fri, 11 Sep 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121238; cv=none; b=XyrmhVohqsoen7wqOAqeJ38IzE8cSO5kqjEiN4tjYaYJ3V+c26nfAS7S4lIkrt8PlbZwtzjL/liGd+tvNkaV4/hIHspahAxH5G4w/RaTw8ZfS6oDy1RdXL4168naNT/Luk7wjJrtDCv2uG7j6H40GrGx1tHs+Bo9T8GfRJrjxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121238; c=relaxed/simple;
	bh=VuV385v8230IBrnVcdExfiHXu4mBvcC2qQ7ccGIdEHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVKbIZU4Hj1C/32t53Jmc+/Gr+EmVEXVVFQluM9BIsWDlahsUYlwrjcSDtBaniCgoCKzdSmO8lcyxryLYQsSufXcfloNEoViBG8NSFqISpUlBLbFH0VlCbG9BRe5t6rnW6kOf0LYn8pGlqrNEoIU05A5WEy+7hn78kTijyEP6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Qo/tVyip; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Qo/tVyip"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49d0b98d6d0so9156085e9.0
        for <bridge@lists.linux.dev>; Fri, 11 Sep 2026 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789121232; x=1789726032; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bhi10DkAqstXDlZQSWSn3PYXAmacwyGL6+DmF7xthLg=;
        b=Qo/tVyipcjXAb6sK6r+SMuF+o11y00kqVnb5OvQ+nACyt08upwjX88nJo+wsaaaU7u
         mwhnE1PdI72TPnYaAIdOmNWRopYfibU34EgnUVHtQifhQGKXlGFLvGXazdwN4yc6FetN
         Oml5TsCy1JkEHTCEgNT50ubRDzt7yoAVbObeopIFmR8ey7E55rWBFBUt9ZKnBz3oljzI
         ETDroXuAcnE1wQjrvzN7x4jJHgdazHKWhwT7edsuJVGnifY6iP3TMTONpxeYWEpJLGhV
         3hJDhgz1z7+tMXRI5Iq/z5XVpo5wJzh0B7UQCILIgq8jgBplvVmH0G0gP8tsIMt/tbiX
         MkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789121232; x=1789726032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bhi10DkAqstXDlZQSWSn3PYXAmacwyGL6+DmF7xthLg=;
        b=GVUkXf8XGhUa39ZOMv/6/l2Xy8O8/CvnV2rebzX14/bD4c5o5S2nEzLsbfS+D2wvJI
         5InfikIWRDZC+fFiJmzssPFdVcaObWoa4dI8Vdp5TlqDoxqOUmEs+wkkcOXT/434fzkt
         rkAGxnFujK3MbQ1sQw1uxBokwx0AUUbDRgipY0+RAV4CDNcvllGxg+O/vTqb/Sj+tvmy
         vv8rBlNW6jamONksBNbkwBbzUTzopYCZb5i2/moEuV0nKADGN+D9lnNCuxN6rT5WXXEF
         PpUnvGVkruktv9Cn01BCDvNNTHH+bOQOP5cKULq6yAlqBE5Yrkf0i6G/bPn0c2ZM7MK7
         InrA==
X-Forwarded-Encrypted: i=1; AKwUvBzEYDT7RomyS7P8EKo+11dhWmLv3bPBwOXEJsbMpB/0h6QBedumDksjZx/BPN+IfHgweke1WGc=@lists.linux.dev
X-Gm-Message-State: AFuF++nwaHNfFfy0HNGinAd37RwfSRuR0kTiR8nE4m1jEBvkFmjt0YG9
	rqBzQAA3WnyfpDs1RWBiZg1Q8IdV9t4zhtSGAXMQam/xGyZEb8z7XuTFTAia71wuDm0=
X-Gm-Gg: AYBFou27gVegJ6kIe+f7ASj4wC2eLJRTVp+LX1Eo+LFVVd0TLlpN5XX5cYd7zsjEVG1
	2RB/qjRYA3iGWj06IvnQ5DVampLASHAYCylwvVVjGKk2wEYTXie9iv3wnUxESDVPNQ2DVRjdUHj
	AVufYOCM4wydV4curb+0otLjRsaJHj1swM3BeIHCxymfVPv+a6Vf6UNKYnfGyo0E97QPPfNW2YK
	4GDP90VhMhlfBfWz4TQMMKYPWFUXDHjE3X6J6El6BPm4mNQMWNvZcVAa6dgHCrtxROpG50HdFeP
	bBCowdYXYiDg5DX6ZGr7r8AWFucmKv2/Ue5lUVyw1bOtyc50jbnKrD6C0AaBnfimy4Ki65fWBh/
	8LQxCmkdExf3EymiseAmjgjO35WZghC/bBj/0tEidZBva2dl/MkkROVSXlKmyHKe2g6KifdIAa4
	HMQ8fg9MI70iBZN/nljIgXqSGSilYqAFMpD6mXAxFGGp4/gMea2DxWiSv/cDWtaVY36XJ//52ww
	7NWS2V40LyaFj8G37hc2A==
X-Received: by 2002:a05:600c:860b:b0:49c:fa21:1c87 with SMTP id 5b1f17b1804b1-49e619d1bddmr33286315e9.28.1789121231896;
        Fri, 11 Sep 2026 03:07:11 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49e636f7fa2sm42385185e9.15.2026.09.11.03.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:07:11 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	petrm@mellanox.com,
	vladimir.oltean@nxp.com,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 2/2] net: bridge: vlan: avoid NULL dereference on flush errors
Date: Fri, 11 Sep 2026 13:06:45 +0300
Message-ID: <20260911100645.1360386-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911100645.1360386-1-razor@blackwall.org>
References: <20260911100645.1360386-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vlan_flush() is used for both port and bridge VLAN groups. The error
path unconditionally dereferences the port argument even though
br_vlan_flush() calls it with a NULL port. Any error (e.g. switchdev) while
deleting a bridge VLAN can result in a NULL pointer dereference.
Use a bridge-specific error message when called for the bridge device.

Fixes: 5454f5c28eca ("net: bridge: vlan: check for errors from __vlan_del in __vlan_flush")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_vlan.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 1748ea1fc202..3aa0e1fedeb2 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -467,10 +467,15 @@ static void __vlan_flush(const struct net_bridge *br,
 		vid = vlan->vid;
 		err = __vlan_del(vlan, true);
 		if (err) {
-			br_err(br,
-			       "port %u(%s) failed to delete vlan %d: %pe\n",
-			       (unsigned int) p->port_no, p->dev->name,
-			       vid, ERR_PTR(err));
+			if (p)
+				br_err(br,
+				       "port %u(%s) failed to delete vlan %d: %pe\n",
+				       (unsigned int)p->port_no, p->dev->name,
+				       vid, ERR_PTR(err));
+			else
+				br_err(br,
+				       "failed to delete bridge vlan %d: %pe\n",
+				       vid, ERR_PTR(err));
 		}
 	}
 
-- 
2.47.3

