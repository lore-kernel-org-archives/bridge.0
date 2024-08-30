Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B619993C
	for <bridge@lists.linux.dev>; Fri, 30 Aug 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029655; cv=none; b=lmJHzdMM94/U3Alr2r5M5POe0MTB73IJ1MzzZSWo9KYG++AspIU4OVLgxuXMy3Hp5m7QD+/XG/4v7cO6gwW93TVyZ5wuFda2kLD16oXo+gDXIXRjg8XxatxoTKe3bU0hLOF3otnBC+0svOkzJPKrMp7rJL6m+AhL5MG1vDozWGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029655; c=relaxed/simple;
	bh=dc5bRy15ONVTTEBc9aLEo2ukaqbrY4WWZWtKTlLqz3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a9O6GRm4q+z64uQWTO6m1zElmAbaPGVyenvz4M2UuhOwef7rbXVQshphPGoZg+WwmRlIH6081aU3TBvLK6wZfhkLSgCWCyNz8Db3mNVnKcWqqae6YhwL6Y9LnmYWdXw2vFXBLlmN64xK8UDUqIIRpogdhAE7Y6D8gvWVxRTo6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=TwWK+wU+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="TwWK+wU+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bb9c04fa5so1775785e9.3
        for <bridge@lists.linux.dev>; Fri, 30 Aug 2024 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1725029651; x=1725634451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qrcokWaDtnovzXGcwzep+zxvnhENL1QqZzp8TzZhMRE=;
        b=TwWK+wU+hxSb5rl5I9wNJsLJs6xpxWYyac3lupRB1MKOWv11GVR8U5m3tpPfmUBCmB
         l8r2OjWtQLnu8perppsOpefeRx5ji5TD8yKeT7ckZ8W8ytiApT8lvLruSwCZENLEoWY6
         z7aPlaFeffeOeVSpNPeYVC9tO2vJIb0CszqD8Xr0zkPRP81R58wk3FDAdO85bK7IpkDy
         SMU6aZj7c1msEvfm6Sv2XmEsmngsVw4PFscpuj2vhqFwDgFFBqVrpTKrPl2/iM5+CVYU
         o2jYa2fsNdT0DuISp/4YrzDDkYpddTxWAbFtfBYUvexTp/Iy8upFk/qQ33hGECaOxdEI
         4NSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725029651; x=1725634451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrcokWaDtnovzXGcwzep+zxvnhENL1QqZzp8TzZhMRE=;
        b=vMDXBAGpRIEzICBLLZuKW+EXlFLdPDZTWlzcjt57ZxgopTUpGjQ0EI4pHgu9iEKk4C
         7fNKinIdySMLe4RFvdbjNE+bMWxTOVsQGQc1AcZh+xS7hNtUwdavj6lTE4+HeWPXws/l
         /aD9V9uMIE1kiRZcTa5Gy4M9GtMOjroXp1hStKcOg+840CpjswW9TOvwiQiUg9BvaTmP
         r8+N+Te5dh4A7+dgFC8tGwrUOpwYYOY3mdHf8ia98CiF0Abqyj13X2qLIjsUGN7gSqcg
         wCqznfKonsn8qjolLOFJnNZXoNsPqe1PcijQ0lGVDBq7q3CHDy5EZdOa7Z/qjs1DrzFy
         YI7g==
X-Gm-Message-State: AOJu0Yw7PNmdBAgZxgPJIaUfyhuRiGcSV5oMCpOXAhrHUea8AehGiNVr
	wh36tp44clz6FrP1AZZi0GBZUODYeTm3PiVSVx2Jt7SpFsJaaLEYDSgJj0V1/R1WttLMr8Kua0w
	YsUk1YXAeQ0G1In0sMHI2Yb9Bm+bIXyZWymvym9RJTtX4DoI=
X-Google-Smtp-Source: AGHT+IHzCrZfGKkqZIrpmvjmqPrDiRM+M6I5F7pFZ63yccDIP5YShJDmbt3sx8lfrlWsn0wQtLPLuw==
X-Received: by 2002:a5d:5889:0:b0:35f:247e:fbce with SMTP id ffacd0b85a97d-374a9551535mr1079432f8f.1.1725029650638;
        Fri, 30 Aug 2024 07:54:10 -0700 (PDT)
Received: from localhost (dslb-002-205-017-144.002.205.pools.vodafone-ip.de. [2.205.17.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb01d300csm58394655e9.15.2024.08.30.07.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:54:09 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@bisdn.de>
To: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@mellanox.com>,
	Ido Schimmel <idosch@mellanox.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: bridge: allow users setting EXT_LEARN for user FDB entries
Date: Fri, 30 Aug 2024 16:53:55 +0200
Message-ID: <20240830145356.102951-1-jonas.gorski@bisdn.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

When userspace wants to take over a fdb entry by setting it as
EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().

If the bridge updates the entry later because its port changed, we clear
the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USER
flag set.

If userspace then wants to take over the entry again,
br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores the
update:

   if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
           /* Refresh entry */
           fdb->used =3D jiffies;
   } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
           /* Take over SW learned entry */
           set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
           modified =3D true;
   }

Fix this by relaxing the condition for setting BR_FDB_ADDED_BY_EXT_LEARN
by also allowing it if swdev_notify is true, which it will only be for
user initiated updates.

Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user=
 as such")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
---
 net/bridge/br_fdb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index c77591e63841..c5d9ae13a6fb 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1472,7 +1472,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, =
struct net_bridge_port *p,
 		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
 			/* Refresh entry */
 			fdb->used =3D jiffies;
-		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
+		} else if (swdev_notify ||
+			   !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
 			/* Take over SW learned entry */
 			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
 			modified =3D true;
--=20
2.46.0


--=20
BISDN GmbH
K=F6rnerstra=DFe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=F6psel


Commercial register:=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=A0DE283257294

