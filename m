Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FBD78F36
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839621; cv=none; b=qRd6BNkZ0y+cEg2KvBURLZJ0C9IWul4D8XyyuUUe8u3FykPugz9W1POyYJxGJPAM/TwvSMqOkPcSxa8tIRs1T+zKhQS4r1qmU5WdHznvYM2oIQ+kTV8PL3i04D7th1bP67yZSHukOgrOAM0xffaL9Jjh5oS+sGreTlmy0EfghkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839621; c=relaxed/simple;
	bh=0YZNKtXDfP+8QyyPpsswSj+2vSc/K+kIjLDDq3tOwC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X1bfmwv+VElELP051mhdGGX4rsGYDdhzwDuQDdwv2FU36n5p5tw9dxsxqZHTMYYe9k7GEPocf1VtFSZ6VCvsZZjR8IGKrFN/rgEd7Hj0O59BRyDUP2Pfe0/T3TmF02YF7NN5HuLW+D3pMXbpWsaUKCtNQB+Ozaj0ysGFNcqjMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=kVDZRtQr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="kVDZRtQr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434f3a04b86so1361855e9.3
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 06:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1733839618; x=1734444418; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fwVBCYlKvSJ/tb5KPR5pkdXQVWY08bYiN1DG29AvgxA=;
        b=kVDZRtQr4HeXChY/LvnhLd0l+Mm+BvqyUReJiEAI6320cQEU03QZaPKgvLX9BzdRea
         12LhV5W5JOyhO/pVpFNfx5BoTbNcoC8gDnd5M8tM+L9fnN0UEp1w9hXzkixV5cB70208
         5IMHYNdYekuNJsXvACnDWfzv5PW4lxBIdh9xZ3OMZrL5gWgX5yqWQz0QyuenUn7qxY7+
         o+5ORI6UE9plzOsNscQUbcJU4K4BX00g7dnm8MXm377o+AQscE1i+dsEP0VgfIjTrL7p
         mEVkCUTufMdB7LEjCm7rbGtUoYZc/IT5udMQ6l1MDtpElnVCtuvtGk6hO6XP32v4BE49
         RgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733839618; x=1734444418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwVBCYlKvSJ/tb5KPR5pkdXQVWY08bYiN1DG29AvgxA=;
        b=ro0uN58mvvbgSwfrUm8CkyqlesVL6/DVn1bCZyPZ/bMoDMjgtUNmcEAzuGarDlaN9d
         /0Iso0nlCbWUDIBA7mCi2lYDpg/KN9TfP82MFS65U/12eWZ776KfBWqC2CZvaOrriSRd
         XI/TpxRRS/JzXQQyag9XiHkYGJbqA3o0FP1OdGbkHn361avU6ppwVQ9pvNjcqKka5OS6
         hJ7ej/o4fASwPM/NDUnP/t0UhHasLnrwKtwFosi4XNuC5GHBLj28PKwGgTdu2qs4CZr9
         fcGnNPs+NIglAXArCOgkP4/I4gczyQCFhmad4Yggv4LPY/XhqkqFSzGmsshSRQS6MFxw
         YVdA==
X-Gm-Message-State: AOJu0YxpYCxw5v0F37ngfVCHi2eF80BvY8hCEffqeJN1JGDQQ+OSMbzZ
	GnVWYcfOvbA0DYm8gkD0xQdo6/NQqR5g71/j3Vh3HTBP8DhGNuB7oIJaQBoaCbQq+z5cMvuRiaM
	Hp5Ja83l+XR5827/jotrHZsZKFWVXuk11C0jbbJewcpPoTmU=
X-Gm-Gg: ASbGncvHPKMlN01ITRMEmxIz28sOP5Cm176tOlP2v4ajn7oY4+58OIpgdBAa4i8AW6T
	aYId6CH57bcOx0rNuUTrLcwdWGKRSUjijkkZnug9hjzY59W7YsSMQBP7yRiX3aYU0ldOvZgorCA
	2u4oKGTo2kBIP80nwC3afnFHo/7cDIDSbA7SBZqJ3V2ttOOVHxmyqWGYV5i2uXfo7d1zidPA8Eo
	lDs5jAL1pQjUt9O9ScPwuXukg6RltfmkCp6Ev1ly9UlpwlNT0nxyByDvdJksXvRWIrBhm5fXd8d
	0EMtvfJw7Tfl8DizYaQ8Nyj3qxz8VNc=
X-Google-Smtp-Source: AGHT+IFjq3W+OtWrcW1iL9JDh1ARCh77V77C27ZksusR6Buk46t4KtFCOIUWlMbJwNxtHZvhPesjCw==
X-Received: by 2002:a05:600c:46cf:b0:431:4983:e8fe with SMTP id 5b1f17b1804b1-435019c8d2fmr12174395e9.9.1733839617559;
        Tue, 10 Dec 2024 06:06:57 -0800 (PST)
Received: from localhost (dslb-084-060-024-069.084.060.pools.vodafone-ip.de. [84.60.24.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd72sm231624085e9.44.2024.12.10.06.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:06:57 -0800 (PST)
From: Jonas Gorski <jonas.gorski@bisdn.de>
To: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Hans Schultz <schultz.hans@gmail.com>,
	"Hans J. Schultz" <netdev@kapio-technology.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC] net: bridge: handle ports in locked mode for ll learning
Date: Tue, 10 Dec 2024 15:06:53 +0100
Message-ID: <20241210140654.108998-1-jonas.gorski@bisdn.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

When support for locked ports was added with commit a21d9a670d81 ("net:
bridge: Add support for bridge port in locked mode"), learning is
inhibited when the port is locked in br_handle_frame_finish().

It was later extended in commit a35ec8e38cdd ("bridge: Add MAC
Authentication Bypass (MAB) support") where optionally learning is done
with locked entries.

Unfortunately both missed that learning may also happen on frames to
link local addresses (01:80:c2:00:00:0X) in br_handle_frame(), which
will call __br_handle_local_finish(), which may update the fdb unless
(ll) learning is disabled as well.

This can be easily observed by e.g. EAPOL frames to 01:80:c2:00:00:03 on
a port causing the source mac to be learned, which is then forwarded
normally, essentially bypassing any authentication.

Fix this by moving the BR_PORT_LOCKED handling into its own function,
and call it from both places.

Fixes: a21d9a670d81 ("net: bridge: Add support for bridge port in locked mo=
de")
Fixes: a35ec8e38cdd ("bridge: Add MAC Authentication Bypass (MAB) support")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
---
Sent as RFC since I'm not 100% sure this is the right way to fix.

 net/bridge/br_input.c | 78 ++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index ceaa5a89b947..f269a9f1b871 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -72,6 +72,46 @@ static int br_pass_frame_up(struct sk_buff *skb, bool pr=
omisc)
 		       br_netif_receive_skb);
 }
=20
+static int br_fdb_locked_learn(struct net_bridge_port *p, struct sk_buff *=
skb,
+			       u16 vid, bool mark)
+{
+	struct net_bridge *br =3D p->br;
+
+	if (p->flags & BR_PORT_LOCKED) {
+		struct net_bridge_fdb_entry *fdb_src =3D
+			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
+		if (!fdb_src) {
+			/* FDB miss. Create locked FDB entry if MAB is enabled
+			 * and drop the packet.
+			 */
+			if (p->flags & BR_PORT_MAB)
+				br_fdb_update(br, p, eth_hdr(skb)->h_source,
+					      vid, BIT(BR_FDB_LOCKED));
+			return NET_RX_DROP;
+		} else if (READ_ONCE(fdb_src->dst) !=3D p ||
+			   test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
+			/* FDB mismatch. Drop the packet without roaming. */
+			return NET_RX_DROP;
+		} else if (test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
+			/* FDB match, but entry is locked. Refresh it and drop
+			 * the packet.
+			 */
+			br_fdb_update(br, p, eth_hdr(skb)->h_source, vid,
+				      BIT(BR_FDB_LOCKED));
+			return NET_RX_DROP;
+		}
+	}
+
+	if (mark)
+		nbp_switchdev_frame_mark(p, skb);
+
+	/* insert into forwarding database after filtering to avoid spoofing */
+	if (p->flags & BR_LEARNING)
+		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0);
+
+	return NET_RX_SUCCESS;
+}
+
 /* note: already called with rcu_read_lock */
 int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buf=
f *skb)
 {
@@ -108,37 +148,8 @@ int br_handle_frame_finish(struct net *net, struct soc=
k *sk, struct sk_buff *skb
 				&state, &vlan))
 		goto out;
=20
-	if (p->flags & BR_PORT_LOCKED) {
-		struct net_bridge_fdb_entry *fdb_src =3D
-			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
-
-		if (!fdb_src) {
-			/* FDB miss. Create locked FDB entry if MAB is enabled
-			 * and drop the packet.
-			 */
-			if (p->flags & BR_PORT_MAB)
-				br_fdb_update(br, p, eth_hdr(skb)->h_source,
-					      vid, BIT(BR_FDB_LOCKED));
-			goto drop;
-		} else if (READ_ONCE(fdb_src->dst) !=3D p ||
-			   test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
-			/* FDB mismatch. Drop the packet without roaming. */
-			goto drop;
-		} else if (test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
-			/* FDB match, but entry is locked. Refresh it and drop
-			 * the packet.
-			 */
-			br_fdb_update(br, p, eth_hdr(skb)->h_source, vid,
-				      BIT(BR_FDB_LOCKED));
-			goto drop;
-		}
-	}
-
-	nbp_switchdev_frame_mark(p, skb);
-
-	/* insert into forwarding database after filtering to avoid spoofing */
-	if (p->flags & BR_LEARNING)
-		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0);
+	if (br_fdb_locked_learn(p, skb, vid, true) =3D=3D NET_RX_DROP)
+		goto drop;
=20
 	promisc =3D !!(br->dev->flags & IFF_PROMISC);
 	local_rcv =3D promisc;
@@ -234,11 +245,10 @@ static void __br_handle_local_finish(struct sk_buff *=
skb)
 	u16 vid =3D 0;
=20
 	/* check if vlan is allowed, to avoid spoofing */
-	if ((p->flags & BR_LEARNING) &&
-	    nbp_state_should_learn(p) &&
+	if (nbp_state_should_learn(p) &&
 	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
 	    br_should_learn(p, skb, &vid))
-		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid, 0);
+		br_fdb_locked_learn(p, skb, vid, false);
 }
=20
 /* note: already called with rcu_read_lock */
--=20
2.47.1


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

