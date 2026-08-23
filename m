Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC72376475
	for <bridge@lists.linux.dev>; Sun, 23 Aug 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787486301; cv=none; b=aejve1gl14BsPafTKjBwWsn/g4CG4Rr4dxVDs2+vBM295MQvo4mfOrODK+2lCZ8W2XDvWQP8DoKvcucCbFJ/Zl0M4TSGU86meBuil3j90CTlTkkuIeTbr2brD50DDWuNIRI4pMXIG8s0usCNz2ojn69NBKRwEVVr7thb2mBHAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787486301; c=relaxed/simple;
	bh=Sga20T/P8MWq7f+aP48sgyMUgOEeXsNmwdBnKjmMyOY=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=Ve5mBAcXlq+8mbO3tlI7rQRvhFVKedAI4ceOajCNY1Ab/H/Zz/U5eP6Z4EzhaKJuBYsnASIYKPOhv5iraVpX1gt/YU/KGOW1sRycF2PZwu0KztdAqkArgGpxzHKGoFF79ivyP3E253RhyIipPMwVmK42YK4ZpiH5gFttEdJ/MuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=NfCbfRZk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="NfCbfRZk"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c20ce3c118aso479585166b.0
        for <bridge@lists.linux.dev>; Sun, 23 Aug 2026 04:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1787486297; x=1788091097; darn=lists.linux.dev;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9VCdZ1UGkHSoNerNHN6y4WQf9dSCo072rCjQ4W0h48s=;
        b=NfCbfRZk0AutFjVtPuohNF+ByKwrx1sk9fqNL0KIY99REWh3ntM6q4QFdaaljplipT
         H2PVCODZHgSXF6tNwMrNM4HcNJWMdmdNCdEzqp1yxaQPLGVw1KbXX5vratdupGy0iczo
         jw/KH1156/MK5nJOcPBnwNfIAKF9ZfqOFWDrf4zxiN5NHmwbAWtxd6zhT2OraxjVUyOy
         kzNU9AIohQryGeDuB0iptPTWuPAPlRiIs8OEy99wOrvN46tJX21kZW2DtiExU/mCDK5Z
         OWMHZk3WzARwO6K8qi5ER13UpuxDllPgWwuMcjAINXSXtnjR92p+/URGlwFsYy0AITKW
         1Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787486297; x=1788091097;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9VCdZ1UGkHSoNerNHN6y4WQf9dSCo072rCjQ4W0h48s=;
        b=FIoLbS6Wg/XppFM58YukojDB/WlOuePpBGAzjncRiblKqN/872FnLZKmPdzD1qwGZ9
         bzy9pZIZTA6E8z/ulWvLWwWVSiAhUcJjfDY4WpgQ7YAivPMtrS1P/Hn0xEF9WXG+Y5v8
         mjXhWWzo52W9yEeLhr26kpCAijMK0gFagp69HfMjg4T+RhlRojRDvCMrgUID3fVwjy7X
         GFLPJ4xknY6PlrWyEjWRDol9nH4AgvaWmZts8HF+/AMqG8v5rrQq0KvHfczs45zxFMtJ
         bPDAGR+5HMqepE2VKLfVRKS/qeWFY3pAMww8tbtC+TWy8k6f9C8Pjv3G5PHRjolzRAco
         tpvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYDsx1i4saFU6JUMaaGaSCbJfJ2mpRCy8UYVKixwbKyOEB1Kd8akEWkkJAP//J8sKbcmdp9ak=@lists.linux.dev
X-Gm-Message-State: AFuF++lzp/8AJQl89tlXXmS1hl9wKj7LjJfwnoNMR5OfgoKXp5nUNkrJ
	j0KpNx+1dwwec4VFTZQFvQo11y8sYjwovqYUlxgX3RkAodmAAo+6GNI11Ox4ZNetZYo=
X-Gm-Gg: AR+sD13YJIAzl1pZuJmDZnlRFyXUXdE2RJCUVgob0ccrzgHpOdADeaoHnCalKepEd0r
	Ox3y2b225RRkYeIaucksj+bO1mjBHw+OIrJu7gn5bPtEKyEeO8IZEprusNOP5eM0t/lrTXhWLMR
	c/M4R+LEghJq2oySteWZCj4vepNMLQyGTjyJ+sLwMB5m4BW5jQQxdkUHC23bOhxYiLgT28KYCmb
	3xMu1FrVv8sWyF7ul3OLBNPOetrYbpRJXZDD74fXe+3jj7DkkeCOBicPm+dCH+9ObQchfaX4KEY
	A23Df0l4aCdE9aUx6H1cCwa9RLK5s5VsO5cC/NTCpPoiqvm2l6zAL93KFfB5AKqpfbxW1Rgycux
	U7bUYi9cHDax7f+ZpPpolfdbgVhxQ8+KSf7caA/ruPTWHqTuwbfcLBGqMNma7ccHb807I19yNYV
	zdsD9blHi3ucHkVUBDoBxwNNnk+pddtT0D9Id90ioUxTBzEK83eUqH6Uo9CF4Ww8gAHhc6LSnlt
	TB72ETD7pIDNLL10IlepC86Ny0WioMqRxhCM3JtgiIyGPZxa5fh2tbe8fh+DqIqYOaX4wbJz4Z9
	MEZF0oK48M6ZbSxpcm4E7cdeup8Ygm5EJAdISg==
X-Received: by 2002:a05:6938:a08b:10b0:beb:d461:7b09 with SMTP id a640c23a62f3a-c246dcc72afmr1228120866b.11.1787486297276;
        Sun, 23 Aug 2026 04:58:17 -0700 (PDT)
Received: from smtpclient.apple (host-79-57-139-67.business.telecomitalia.it. [79.57.139.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249685ab3csm762988166b.49.2026.08.23.04.58.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2026 04:58:16 -0700 (PDT)
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
Subject: [PATCH net] net: bridge: mcast: fix use-after-free of a master VLAN's
 multicast context
Message-Id: <B41EB55B-E5FC-431D-956C-503CA7B95C30@doyensec.com>
Date: Sun, 23 Aug 2026 13:58:04 +0200
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

Any user able to create a bridge can trigger this, which includes an
unprivileged user in a user namespace, by deleting and re-adding the
master VLAN while sending IGMP to the bridge device:

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
2.55.0

