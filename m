Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915B200133
	for <bridge@lists.linux.dev>; Tue,  3 Sep 2024 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351618; cv=none; b=XGneT9EmoSbjtdCnfGWPpZW64iGtxcGxnuSF/nkEguyUqTRAZczprVmg5tCmDGEn3QwvkRa0mnorOuAmnv1JsCsla/KZN3ryJ/4E+CO+26kePbXz9i3BR0zOERqEtK1yrekOxlaHKmhbzCbQ3XGtL/KNaacabVzAikKQzsMhEMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351618; c=relaxed/simple;
	bh=zQ7ucgyJvJz5JjcFYbNwCsbg4nagkKxZ+nZ3sV8msGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=McqmS8fgl1tmLRzHQzUKvYG+reILf2bFKoSD66avWAu/qOV3V8KEyCoSLdAuRM6MgnDzoai71ydn5x7rUhG3yJyh3GtDubtPNBZvF2TN/2BFVcFomulNdqQBK5nFyeZ3WQpDIuDKxfjbKT82/IDvRKiQoKM1/cCYZUEQZILc4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=rEpJ5OdL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="rEpJ5OdL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bbd3bed1bso5130485e9.1
        for <bridge@lists.linux.dev>; Tue, 03 Sep 2024 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1725351614; x=1725956414; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EgKUHrUOMpyjZi6C5EjxXwCmD9bSiBGL0khiLuKOJRk=;
        b=rEpJ5OdLif+o3JjutZst949h5wfB9Yneel7TrAt3YDwHfX/OU8jvmM5oAMm7pZbOTE
         DXlTG/jvV4uXNsvhAjT1AHYvAuaUTJIbZCz9NeNpWASBEi6kSwZa8TkOM6D7+toPlrBq
         SRCK6q4UdTd43TnGGAmA16vuZmImN4WhUPNnK5GXokND7OYFtlnFci+p57BqGnK9Dpyo
         CESIqU50/TO6INO1k2tkIF89LA7C+8Ut/zztHzCxu9ibmgJKg1mpRlraAOY4MIBG0Br9
         4z7+KJyWKEs9zh9uHF+s8OZhjZZ9ConlXY5b9Wl/nIA8RmonmnTmUFc3MQBfpSZhiasi
         J6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351614; x=1725956414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgKUHrUOMpyjZi6C5EjxXwCmD9bSiBGL0khiLuKOJRk=;
        b=L0nDnQ4yYvJAjzku1xr8eIQLp+sN38eNUqvYgkd+qWZuR0OlwLG95K3MUzkxkAYBfU
         i9DhQ/V9YuU3SZXj8+mzxZ0xnCnTItaka7cMsrE/hXbryf/K0sPrltpdkPDPEovNBYnS
         HVov5QP3LWuaxvEAqq1fDmY3HwiKfVV3knzIhMP2QGut/xyLv5NNqm36R/moGgvwNl+7
         1jo0eQm/M5RJwy4ul2B2OXJM2JfXrlrnHY7IKFP6gZtGYCHcAx/hzVwKIi4XsqlSbZ22
         NiYsAB62fW542gmE8zemE1CziJiJZqhfzxP3KA0d9lqCqueaGIZmOC5cWk39sEuuJAn2
         aDMA==
X-Gm-Message-State: AOJu0YzqQOyrri2wBO/37XI2FVb1Cw0rmFtQzb23+4ZXBX37GRGXbvqn
	OKpZK2igb3z1W6Iij1CP/AlsA1qmf3ZRI6sfTNVZMRdZypJP2PMaFuu/hI24xpg8JzQYeP5Kes9
	CeiPBg6ZgOeRLugrhAy04dG4HWRJAIJpCBlnkfEvepeSwPpA=
X-Google-Smtp-Source: AGHT+IEFFqFL6Z+i6DHqcKyxe8/RJtfANtTvmRv05p6nE4LwpVsuRRRoI4GM1xfpkOExobdfMfIk6g==
X-Received: by 2002:a05:600c:4f4a:b0:425:73b8:cc5d with SMTP id 5b1f17b1804b1-42bbb10d9eemr52777185e9.1.1725351614019;
        Tue, 03 Sep 2024 01:20:14 -0700 (PDT)
Received: from localhost (dslb-002-205-017-144.002.205.pools.vodafone-ip.de. [2.205.17.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba641db07sm195757675e9.34.2024.09.03.01.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:20:13 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@bisdn.de>
To: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@mellanox.com>,
	Petr Machata <petrm@mellanox.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net V2] net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN
Date: Tue,  3 Sep 2024 10:19:57 +0200
Message-ID: <20240903081958.29951-1-jonas.gorski@bisdn.de>
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
update.

Fix this by always allowing to set BR_FDB_ADDED_BY_EXT_LEARN regardless
if this was a user fdb entry or not.

Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user=
 as such")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
---
Changelog:
V2:
 * always allow setting EXT_LEARN regardless if user entry
 * reworded the commit message a bit to match the new behavior
 * dropped the redundant code excerpt from the commit message as it's
   already in the context

 net/bridge/br_fdb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index c77591e63841..ad7a42b505ef 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1469,12 +1469,10 @@ int br_fdb_external_learn_add(struct net_bridge *br=
, struct net_bridge_port *p,
 			modified =3D true;
 		}
=20
-		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
+		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
 			/* Refresh entry */
 			fdb->used =3D jiffies;
-		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
-			/* Take over SW learned entry */
-			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
+		} else {
 			modified =3D true;
 		}
=20
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

