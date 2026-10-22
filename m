Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685401;
	b=ZNJvXtclW2zksqRLtTppkLCwcDUtuBgKNcWbWn3GfnWKf/+hFad3VjijxTD53d37x/9N
	 6fsMOAfmYdiOn1bPleoRCSZ021IhXMYUyMvYx0/YgP1zSwo3nMBurwjh6g5LA8HY5xRpj
	 MB5cfH7847hzEWA0az30oEdnhMIXNIwFv/PteShcA2hr1nlweOQG3I1ie1e8B8mytDY5y
	 TdXJNSx3omsp0KSoYB/5Djlxc9ImNB/mMk4xYrPC1wo0DY8G1ubdvXLjCWNAJJZyHoy27
	 9pug2lb0X9Jda4r5NgFn2iyYxCab9W3y+0+AgJIPv+YvTlrUjSOr9TZtvTLKtIiKBvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GpbUIm6RX7Iel46gw55j7xKHlKF59H1RZ41ZjqItGOY=;
	b=f79Crv4W6byyX9j7ceLBGkGARmgplu1b2oqqS0WLnWsdOkqOqUek3TZM0du7jhDgWQ4y
	 GfX/kH+EL4YE80CTBrE0oLtT3A96DgiW6f2tTDKBFrv17T5dHMH2/SIXXjMikD1NNEJ9m
	 PvsOvwCGjYPGiyuyhORCNT74uOdyeuwJYsz+aL6TPva8AM7seUMgczcJXawWt1qWkMlrV
	 bGfDfjZDSLxhka/KPIWS4XXu35yR7DJhrQnPOjNHac1s55Cxg0V8xMpK+Sf1KWpaZbAs0
	 41S091kKUd45A/eD1lQgqBRemiZW18VLs/Gu2IaCo7MCH9/LU5lDumEg49fHFIYEOug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XHZBEUBo;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884260A2634
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 16:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6884260A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XHZBEUBo
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-188406bb948so1154202c88.1
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792685400; x=1793290200; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GpbUIm6RX7Iel46gw55j7xKHlKF59H1RZ41ZjqItGOY=;
        b=XHZBEUBowkn1pfK3jVbEuZmdLPTPdkYyNYwS8ewYpLiRt9708TO0c8V4fxoyavpWDa
         NGXEKa+cIOe7CH90/i/ycVppj67fF/Al72sPGEk0P49lTYcvX++uShCkKDAcIT+Dzs67
         lWa4ab0NUkSlJYDfFL7DJ5Zn71Nl5rcnPJCW4QMFuQX8e1aVH+FIzVNrWTE7+o5h3tR/
         QeWLlYpCzsSxZOuwRRHVakUTfcXgCW1cV4JJMP+2CIACgTLkBKgj2XUhgNGXKCOVbp5x
         T8hVMXmA+YnWChBEPa4JKyE9Hon2GEze/decoYTRr/K2Cqh50/yADZ+Fjk+8NXD9t55N
         SV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685400; x=1793290200;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GpbUIm6RX7Iel46gw55j7xKHlKF59H1RZ41ZjqItGOY=;
        b=cNVDfJiLECeynlIKYM56NqIWjIsfGFFzuG44Z6Ulz32cxg6K+PFZIA4tNWclF7CwPg
         2Dvwy7dfVT91igUmTKqW9KeVcs59KcxxjKqqcY9MHKcX803WnCPxncqTPkzMF+jLItLL
         gf3ymrgan5/NnKoJz2vKnFLht4e2IV8V+XRwprnqbNBF+iPSBw7AlYB5Qaia2G4tpnhR
         HajLKxD/kPEL6zhCi57Q8YOI6lAYMJzKoOOFyAn1N+ntgHa3/c5KTS3Ds9OCVL+HUTWF
         OEvOD5OXPfQkJanRdKZf/sCyB6Fe94kJRaow0KNMya4N4pJ62Kf+qSgU6XnslUXIniwg
         mUKA==
X-Forwarded-Encrypted: i=1; AKwUvBz6Dsq3p7bEIg9EK3wo7hS4DGBZTxNU90surhVj+aMFVgC/H7dvBrShTtvYXPmyAMvU+UF1wnw=@lists.linux.dev
X-Gm-Message-State: AFq9FYLA2/tdGOmmG7E730Z76NWJAoFbU6lmphlLsIOcpNlOze9bk+3u
	NMSRb6H5nC93GBRlK42/UgEE+mRkN1gioEupqESf5eCqSDa+ShE2JzDJ
X-Gm-Gg: AYBFou31xR+VHxSfEM+z5FuZzVDj2zEHimrHBktRD7opQ3EQK7gb9DxEWHi1/ifb/1B
	XQ/D0MqCy+fyH1BUiQkXEZqsnaMX0qtAZL5apx05J4JYdt7uGuOoGDACi5210n+DD4A0xwIyHnn
	jijKj0e05QZwjzMdOY0wlu6NPBrAW18sndX+oQYKyUMQaGjgcrtyXuGlSvjK7H1u/YiWpHRWxk3
	macgc4HTNRiXx+upyAKG79Zxd+49jbJop2VYG0zn3U/X1hscX1WmEqGSkxyPX/2D1axBA+kRIQv
	w8ppcsIrMbU01WjazWY98XCSsTMQnwHkUVhcVfsKGHw1bhvVXG3+W8WmCMhWbfPERRs4hPiuR3r
	WYJot70Wcmb0NtKF2g/SPF33vjQjpURoPEKh5ZgN6fgyhU06UYPH8Z68Liw/Gm4K54Uirm52IsO
	UJlYce4VPxyJGwi2P8hxAH8FCL/y2jJ+n8HJRyg02HX2v3RphWZ565XzImxoHYXY72kMsdx6zxp
	AwK9v6Qu5lON+VvuLhVbiXFIl9R2ma1ob0W8uX8hQMIbFMrG26Fa82CShTLYmthG+ehqd2pRX/b
	EjI7
X-Received: by 2002:a05:7022:eb46:10b0:159:aa67:2893 with SMTP id a92af1059eb24-190a632f2bemr7128725c88.30.1792685400457;
        Thu, 22 Oct 2026 09:10:00 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e4f2eacsm14594124c88.23.2026.10.22.09.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:09:59 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Horatiu Vultur <horatiu.vultur@microchip.com>
Subject:
 [PATCH net] net: bridge: flush FDB again after unregistering the RX handler
Date: Thu, 22 Oct 2026 08:26:49 -0700
Message-ID: <179268538303.70821.8213834342995341232@gmail.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

del_nbp() flushes the port's FDB entries before it unregisters the RX
handler.  For a normal port, br_stp_disable_port() has already moved
the port to BR_STATE_DISABLED, so no frame is learned in between.

That does not hold for an MRP ring port.  br_set_state() ignores state
changes while BR_MRP_AWARE_BIT is set, so br_stp_disable_port() leaves
the port state alone, and br_mrp_port_del() then sets the port to
BR_STATE_FORWARDING (when the bridge is up) before clearing the bit.
A frame received between br_fdb_delete_by_port() and
netdev_rx_handler_unregister() is learned with dst == p.  Nothing
removes that entry before destroy_nbp_rcu() frees the port, and a later
frame to the learned MAC is forwarded to the freed port:

  BUG: KASAN: slab-use-after-free in br_forward+0x55/0x3c0
  Read of size 8 at addr ffff888079f4e038 by task br005-poc/9379
  Call Trace:
   <IRQ>
   br_forward+0x55/0x3c0
   br_handle_frame_finish+0x1300/0x1d40
   br_handle_frame+0x90a/0x15c0
   __netif_receive_skb_core+0x953/0x3040

Commit 8dca36978aa8 ("net: bridge: fix use-after-free due to MST port
state bypass") fixed the same race for MST, which bypasses the port
state in a similar way.

Flush the port's FDB entries again after netdev_rx_handler_unregister().
Once it returns, no frame received on the port can be learned, so no
new entry can point to the port before it is freed.

MRP ring ports can be created when CONFIG_NET_SWITCHDEV is disabled, or
through a switchdev driver that offloads MRP.  The race was reproduced
on a KASAN kernel with CONFIG_NET_SWITCHDEV=y, using a test module that
accepts the MRP switchdev objects and holds del_nbp() between the FDB
flush and the RX handler unregistration.

Fixes: 6536993371fa ("bridge: mrp: Integrate MRP into the bridge")
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 net/bridge/br_if.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index c52613431f88..8e774329af01 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -367,6 +367,13 @@ static void del_nbp(struct net_bridge_port *p)
 
 	netdev_rx_handler_unregister(dev);
 
+	/* The first flush can race with an MRP-aware port whose state was
+	 * restored to forwarding by br_mrp_port_del().  The handler
+	 * unregistration above waits for all active receive paths, so flush
+	 * once more before the port is queued for RCU free.
+	 */
+	br_fdb_delete_by_port(br, p, 0, 1);
+
 	br_multicast_del_port(p);
 
 	kobject_uevent(&p->kobj, KOBJ_REMOVE);

base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.34.1

