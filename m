Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0393BB113
	for <bridge@lists.linux.dev>; Wed, 26 Aug 2026 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735565; cv=none; b=hEilfEwrayh5noHf+TyUcgOw/gOca5RhWHRMvqYRFpu1BjftTQVhO9vvV4TGZkKWgzL6Hdcci32sWasqwOy+HwjjitKpWpbvtX9EBy/g1dQBeqUYOslNn3TKT+xwCCd+jNR9cUGcDNY0FALStHyCHfKapwH5GKyQ2sKT43064BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735565; c=relaxed/simple;
	bh=aJcop90w13DJ8VL98pNvskWWLzcXM7bekHcMKkoIZbo=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=lisVKVvNQCbsxYOFeXvk0w/I4j6/dHHWuCoYdp0D6mCVc6l2SbkJvTPOYliVCIlfxXm4u65u+B6QccKRG3Ra44FAdrr2jOjvk/ObVO53q4tsvV2EdTqOGVA4OL9RLFeWHN4UYoJdjVjbATC6F96Imd8m//gdUbChgcsE6mK2SJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=cstjoZnC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="cstjoZnC"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so1176693a12.3
        for <bridge@lists.linux.dev>; Wed, 26 Aug 2026 02:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1787735561; x=1788340361; darn=lists.linux.dev;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yzTkADWqxMGZG5YtmI2G+L98ZjXC8gtF2MPGuaf+Q6A=;
        b=cstjoZnC1i1JhnyWYTZ5A6LjQZJDqUMECmACdUMo2q97DniLFrma0NEa+48G7N4bIF
         wwmikEmDnNJZBpSbyNY3jyc2If2LsdikY7c3Vtv8y8RdmNItNyqWXI+Qsy4HgN6suAhv
         IUPdT+rYOrTCSbYTRV9iBceES+8sqE3pTi4YuZ4maU2XWZXi2yKpVPrAwMzmO0cEd+G8
         uzpJbGEDM2LjACsBq5fsk5LiMcGFWkPYQe0s8OJ0dcJS2az9pBQj3lyGOPg2NtwlAk6R
         ic5wrJdnqP42taonYBZuUPxYEtZU2910YQxfel6hwwVU9z1siIwLMotQ2u+RtN/IuWgz
         7hNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735561; x=1788340361;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzTkADWqxMGZG5YtmI2G+L98ZjXC8gtF2MPGuaf+Q6A=;
        b=fWA7JK9/2WCZScGzA0A4NdyVFq+C/1qh2R+sEEi6hrNfxb3POQlnignNDgg59iAxq7
         FKITraGwidVWvuO4zcJMS+pr9hjmZkCAg09KPp/EmIB2bbvhi5omcOYGMxyXR/aH50f/
         gicF0kwflG307xpNhTqTzfr4pvYaSGLL7DHCIgNGqUUYKdz6BURcharGzEt2oJlMt0J0
         Y8tmdr9JLtY7ORZtDjwp7vxUxoBQOcUxzxT39AtWwTmO7t+bD538RkKxwxX2GZbcJMc5
         7YwJrIIxynnpvbgnG4AQuMeSi+zLLOHnzkmp+qWNvpTyFv6LpOTe8dz0H/yNBSufM7bn
         ZRFw==
X-Forwarded-Encrypted: i=1; AHgh+Rq8p/n1VTL8Vfeg7kOGIf42Lpet8i/4Y1RKHTtd/JwThn7YDgOjTaMXms/8TTwBG4+1+LhjCw0=@lists.linux.dev
X-Gm-Message-State: AFuF++lUa6PJUHyMhxwNtwGZxT46tIDZGI2Xzfft3hNdElGygmhTQLkP
	yDQq79IPiAqRmlZtu1vdRCz1FHOY8lnmjSFDtRfsruRWOL7SuLwwTXi3V1OF8oOqzjU=
X-Gm-Gg: AR+sD10FxWZFItXRNnyQJ1WosV376E/PqQBTIu2nht5tSqVJ52Au9EiWiziqBgWBP57
	mXZu/cIXfrbZ1qbCJ6STOTtDoEnB/RxnUy8oxioj+u0qr42Pi0uGq9RANE5oEcMCySQVWpwVH48
	Pm+l1moxvGoZ+haGwOXzMH3KCcu9xYClqb5G+h1e6XxIMoQTWJ16vPEBbUoS4e/mX6szDWUEyjN
	Phvt5w2GkNWnGJjYQbZ+y99M7obsPWjVqm/FfW9GSs1vQZt3rxXcQqZDJmqKiS/dPtE0SRdrAGY
	QqKCZtOuHG7NStwHIBtOu3gSgq2B9N5lfEMrJoysNryhFtcaYXjSYgwTIKA0XiM0/Q8VZeA5tTs
	2yo3ppDls9NK4bjJVVlxKNU62fZp6jluKm3UMEC/c34vO3fjH9ubOREVQKW5jaGrRQsrsxpngGs
	7omM1AlsICWAkYuYSTPWmcYdlkol0/U3lcX0xhUKu5iU+avjIXA10k2dsi6lXVL0Vxt4+/1N4oD
	qmcUlIei8ojxAdDRt37YZpv5tQ3JVNBpcxags4YkISzrL0/aEmIBjNRiMEMnINEtFDzvsnlFPsz
	ZYvsed2dHF5n4be796CoN5A9QP1tqsXWCLQb1+rBeNBys5ds
X-Received: by 2002:a05:6402:5d0:b0:6a3:87b7:b516 with SMTP id 4fb4d7f45d1cf-6a5df6292e0mr7506777a12.6.1787735560457;
        Wed, 26 Aug 2026 02:12:40 -0700 (PDT)
Received: from smtpclient.apple (host-79-57-139-67.business.telecomitalia.it. [79.57.139.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5dea8388fsm3466565a12.19.2026.08.26.02.12.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2026 02:12:39 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net v2] net: bridge: mcast: fix use-after-free of a master
 VLAN's multicast context
Message-Id: <D400F6C7-543A-4B79-9E5B-D1D8974DE5C9@doyensec.com>
Date: Wed, 26 Aug 2026 11:12:27 +0200
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

br_multicast_toggle_one_vlan() clears BR_VLFLAG_MCAST_ENABLED under
br->multicast_lock before stopping a VLAN's multicast context.  That is
the teardown handshake: lockless readers gate on the flag through
br_multicast_ctx_should_use() -> br_multicast_ctx_vlan_disabled(), so
once it is cleared under the lock no reader can arm the context again.

For a master VLAN the handshake never runs.  __vlan_del() clears
BRIDGE_VLAN_INFO_BRENTRY before calling br_vlan_put_master(), so
br_multicast_toggle_one_vlan(masterv, false) returns early on
!br_vlan_is_brentry(vlan): the flag stays set and br->multicast_lock is
never taken.  br_vlan_put_master() then drains the context in
br_multicast_ctx_deinit() and frees the VLAN through call_rcu(), while a
reader still inside rcu_read_lock() sees the context as enabled and
re-arms it.  The port and port-VLAN branch of the function has no
br_vlan_is_brentry() test and flips the flag under br->multicast_lock,
so it is not affected.

The reader is the bridge transmit path.  For a master VLAN
br_multicast_rcv() selects brmctx =3D &vlan->br_mcast_ctx with
pmctx =3D NULL, so IGMP sent to the bridge device re-arms the context's
timers after br_multicast_ctx_deinit() has already stopped them.

  BUG: KASAN: slab-use-after-free in detach_if_pending+0x412/0x4a0
  Write of size 8 at addr ffff88810ac39918 by task brmc/601
   __mod_timer+0x51a/0xc50
   br_multicast_host_join+0x25b/0x390
   __br_multicast_add_group+0x468/0x530
   br_ip4_multicast_add_group+0x1a0/0x260
   br_multicast_rcv+0x2cda/0x61e0
   br_dev_xmit+0x6c4/0x1540
  Allocated by task 610:
   br_vlan_add+0x111/0xb40
   br_vlan_info+0x370/0x3e0
  Freed by task 0:
   kfree+0x1a7/0x4f0
   rcu_core+0x7dc/0x10a0

Only test br_vlan_is_brentry() when enabling, like the
br_multicast_ctx_vlan_global_disabled() test next to it.  Disabling then
always clears BR_VLFLAG_MCAST_ENABLED under br->multicast_lock before
br_multicast_ctx_deinit() drains the context.

Fixes: 7b54aaaf53cb ("net: bridge: multicast: add vlan state =
initialization and control")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
Changes in v2:
- drop the paragraph above the splat, per review
- no functional change

Reproducer available on request.

v1: =
https://lore.kernel.org/netdev/B41EB55B-E5FC-431D-956C-503CA7B95C30@doyens=
ec.com/
 net/bridge/br_multicast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 75e1e2a8fc83..3ef5d8bbf552 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4377,8 +4377,8 @@ void br_multicast_toggle_one_vlan(struct =
net_bridge_vlan *vlan, bool on)
 	if (br_vlan_is_master(vlan)) {
 		br =3D vlan->br;
=20
-		if (!br_vlan_is_brentry(vlan) ||
-		    (on &&
+		if (on &&
+		    (!br_vlan_is_brentry(vlan) ||
 		     =
br_multicast_ctx_vlan_global_disabled(&vlan->br_mcast_ctx)))
 			return;
=20
--=20
2.55.0=
