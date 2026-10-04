Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808E448392
	for <bridge@lists.linux.dev>; Sun,  4 Oct 2026 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791117784; cv=none; b=kNqR4q9mtCnV79kuUQ8m/J6MPTJx5h6F1B6LoapFQnChUoCT1A4coL+ywuRuCKnx81gPxtahCAtb8nDNIVywqF8Wxtdxe869sxzwM/HwCdN6FbHKTnsaJMU2ta9uNKipoYJ3cs72WI5CqaRqYEphFA166RERb0Nm+dec2WzHmdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791117784; c=relaxed/simple;
	bh=tTgrBs3Hgw+xZh6szNsKjeuhK4AVLdIPNXX+P4056Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQsGM+9QmoJpN3swWsjCdGnRnDJDQyU82q4LLizVufw2PdDB2D3p+O6aV3N07e8ddvIN0HH+aVNyJTuR9KPBXTN96d/YOax8FZB98bLMtdasFUNRgEMWSlG6PEisJdzD6sdyJUH6TFTWBpjNU2VNcoCAmYr10bQxffnSw7m7HJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=yQ0IUCqD; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="yQ0IUCqD"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e227422e3so143153366b.3
        for <bridge@lists.linux.dev>; Sun, 04 Oct 2026 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791117779; x=1791722579; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eos+MZIZfy20RrX7r6puDDSBR2yAZWLtl2ZkahKdzuk=;
        b=yQ0IUCqDYvpTIN2ylNXDoa2PUfR0RaX4ehJ51uupgdP0rZIZBrQT/k959y69GDIw1+
         uRqQ/C8rbMpp195jggF8un9J9Tkj3EV5oy2z+Dy3ecXYv6AeTKdeZNZ4szrkXwOvNlYi
         FKccQ4n7zgrnmDGwIQWHzrm1+Xf4JW3HsZV1Wutr4oTJCz/TOe6AP9e5xIwLQ61NCA4b
         pnrSmYud/aAzfKbMfJnNREHqqtfJW8W79MqRmRw2L+gFml1qBptZh4Ozde4L2OdGJpZH
         ewC80EoTe4b4swnfsG64lIJj8FuA6LlLQwdLYYPABjI/IeQr8JSwbOuGkcY0HDcVX2i4
         2JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791117779; x=1791722579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eos+MZIZfy20RrX7r6puDDSBR2yAZWLtl2ZkahKdzuk=;
        b=A6SNvToRnOYN9EBzvI/M7q6mquYCCi0Z+wLQ7O9V9darZuZoaDkaqSMzRgsIbHswNw
         /GZcTs9ekYUc7E9Z3NWCuMibfJ84FgfJPmfvOOBKP4/XxyNB77MkpAbNOgEsdgV510fY
         tS95OJdE+L1Mch8q2wXgnidpiRuGAGoOOqH6eWqjzhU5vAWAh5uDakIeQX8MRu67K6Rg
         MXbaGIHDkIsbssESxevO9ePlzH/4to6FXY/CXrr7Eh5oZg+joVB9nJ8ugHiFm5uiTg5H
         wUf3dyjKbTz0jPzcQb/fMpd+uC+O82d+j/K3VZbjzLiTrauBEODZf9XWuuPv3QU7V++0
         j0FA==
X-Forwarded-Encrypted: i=1; AKwUvBy65s9D1YUAgLTpBYl9M5vDxFTnTQQC2yhL6/l20Yc8rpm0Y6X1NW4cWHSEcVPzUG0WO4nHPgw=@lists.linux.dev
X-Gm-Message-State: AFuF++nhE/fVyJXzj/vbBdf/2EWRRIeeFu1wnMOAb3cPM4UuT/zHuCqP
	aaHxOYGaUdqTg4O7IWKy//RT+z5wg2ZSAdE6adLcyhljix4oO0lztqaAKJGzYjBNcA==
X-Gm-Gg: AYBFou0gF1ZqrfJAwqWYJV2kjK6nC0kFdqLLn8SLTGmOkSPxBLlvsVkRjFd6A3m4NRc
	Yy3qyYEGmy1jeuSUzpnYOWHbvm2GexC4GVb68fdFL0GUhjzx0FYm5YZWYjnvBQ+Ht1dYi+bO69i
	9jo5PfI2WCGunoXr2baAUsW8hf821WSNMw2mTEI48PIbKxsA7ijbrvtFKIJ3gomsKQ7wDes+l3F
	TtkK49LYzoGy74gKlPK8YGZotzSPwskoY3m/ZV8pvzit7eOJex1uFyXwWpAcaPL2wvvpqOjUYaO
	aLiO+CxDEhiIo6M/RgPfPDI9+5w2/GuxKJKxi7BpTG5gw+V5EYDnhIwenSqTaI6QWeNSAZDGQHk
	LTyrqBJMdMMszc3mqQ/PpW67itug07Cq97fBP+jvcCFkWorgoWRJznhXA7RXPIMWeBUilMY1ZvW
	rGjbJVMKpldo20GxVf2JeaQR8Wv9oolFolIYxaI1FuwUhWSCXcULMUATf+EaujcsOEBdTG3C0WA
	FT/m/4229h9yNGKCoqqTr+ZlR2OIgwYbw6mNWHb37KZx83VrhaMbWJ3p8S6dDgyhZVNenPaN7QY
	ct2Wy49ocXdw77Qwlbclt7zma8KF/eeUNr9UnSQ9M6NOsQ5br/coHwewXz/dCOeJt5zSvyEgjWD
	XpThggh7G+heG+gePuAI+7st0vm96lwWxJvj9ffIxR/oG4HKr1gO92ttJWup6L/hqcsyCILmiU8
	TtpQG2u9pos9sf4seD7BUK6s3/Hw+7lhZm9xcAiQ==
X-Received: by 2002:a17:907:6d0f:b0:c2e:4196:b167 with SMTP id a640c23a62f3a-c2e4af2bd94mr627719266b.18.1791117779193;
        Sun, 04 Oct 2026 05:42:59 -0700 (PDT)
Received: from Desktop.fritz.box (p54aff5a5.dip0.t-ipconnect.de. [84.175.245.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e878b1784sm62473966b.3.2026.10.04.05.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 05:42:58 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: bridge: fdb: hold hash_lock when an entry roams
Date: Sun,  4 Oct 2026 14:42:54 +0200
Message-ID: <20261004124254.3525496-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_fdb_update() lets an entry roam to a new port without holding
hash_lock. It notifies switchdev that the entry left the old port,
writes the new port, then notifies the addition. When two CPUs receive
the same source address on different ports, these steps interleave: a
driver sees two deletions for one addition, or an addition for the port
the other CPU wrote.

DSA counts references to a host address on the CPU port. The extra
deletion fails and the extra addition is never released:

  qca-ppe 3a000000.ppe: port 5 failed to delete 02:5a:0b:a2:1a:46 vid 0 from fdb: -2

With one address roaming between a DSA user port and a Wi-Fi AP port of
the same bridge, the error appears 3-6 times per address when the two
ports receive on different CPUs, and not at all when they share one CPU
(4 runs each). With this change it does not appear (6 runs, different
CPUs).

Take hash_lock when the entry roams or its flags change, and send both
notifications under it. The common case, where the entry neither roams
nor changes, stays lockless.

Fixes: 90dc8fd36078 ("net: bridge: notify switchdev of disappearance of old FDB entry upon migration")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---

Notes:
    net-next 941056f91907 ("net: bridge: fdb: factor out existing entry updates")
    moves this code into __fdb_update(); the same change applies there.

 net/bridge/br_fdb.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e4570bbed854..c8680ae3ef08 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -995,8 +995,17 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 				fdb_modified = __fdb_mark_active(fdb);
 			}
 
-			/* fastpath: update of existing entry */
-			if (unlikely(source != READ_ONCE(fdb->dst) &&
+			if (likely(!fdb_modified &&
+				   (source == READ_ONCE(fdb->dst) ||
+				    test_bit(BR_FDB_STICKY, &fdb->flags)) &&
+				   !test_bit(BR_FDB_ADDED_BY_USER, &flags)))
+				return;
+
+			/* keep a roam and its two switchdev notifications
+			 * atomic against a roam on another CPU
+			 */
+			spin_lock(&br->hash_lock);
+			if (unlikely(source != fdb->dst &&
 				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
 				br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
 				WRITE_ONCE(fdb->dst, source);
@@ -1023,6 +1032,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 				trace_br_fdb_update(br, source, addr, vid, flags);
 				fdb_notify(br, fdb, RTM_NEWNEIGH, true);
 			}
+			spin_unlock(&br->hash_lock);
 		}
 	} else {
 		spin_lock(&br->hash_lock);
-- 
2.53.0

