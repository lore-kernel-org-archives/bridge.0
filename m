Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206059;
	b=G2mQfgezgFaQMjic2ZdJuBHpw8HEX8scxf/NTgnnHKBcbVQ8A9NtyHw3dOqzVu38NKAW
	 QwUB+Vj8VcHjJIjbfcGJgJteF9eSL+nIfiYtBXbzQzvJ+7GAM8AgLbwrX4KMsMJTp5W54
	 3QOSBnS1iMQG6xC8vaoEVTWbyMUresCaU8jG6URuUhmCv28CiAgDKfOLo0KwtwysPipgo
	 sUoUxZSK8oNN6V64lF5d8JQJhDNWy1YUXYHm2J1IYavJ3vrWFrd3Cjbilqy0OqqWqw1qx
	 8+dUJ9YleTi2ZnCB/2r6P3d83AGdcRQ3yowFsUsldXG+QHW2qOBLcl53Tuakwjbt6mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YP63UdSvRgH+U6RYpSmgw00Aw6otHrAc8+AYLP+kjNM=;
	b=WK/RzJtmC/oS05blNSQvXCLJVu1kcqwd1+1G7kPtEmxzuSbNWemKgj3EE/Hl5BXMQuEb
	 C+XUran+9BCGJmxPJvx2FTD6awFjGsSzJiNY8wrR2ruQ0lN4wIt+digwdbOBgUcItMJLw
	 ez0hEAC4SdQ0tI6orcCKtZdpkjKENt7dvq3Jdz8ZASF6OEKvXdbScmv0w9rIFYh6grdCj
	 F23DDkkx9Vv6Ov8gISDnqYMswVBjMdgMOpKJduhzkcXZ4jiK0Bm/ix4xVBS/EjtfdjD61
	 a9YxT+XmiKDb9K6k+sa8JSA8qExJRaInYhzX1D5dCEPnWq2GKOS6U+YUx3N4ht6+qLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6Mp0kP2;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD4606A33A
	for <bridge@lists.linux.dev>; Wed, 28 Oct 2026 16:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BDD4606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6Mp0kP2
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1035198a91.1
        for <bridge@lists.linux.dev>; Wed, 28 Oct 2026 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206058; x=1793810858; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YP63UdSvRgH+U6RYpSmgw00Aw6otHrAc8+AYLP+kjNM=;
        b=X6Mp0kP2a7XgJv6SREkMKJSFedqLje+6aC+X/Bq4EQKsR6AZJI/KVNK57x/ASfR8cW
         9LI9+OnTh93aVJ5g67y0JUX3kJy+vVCSXzv+6A4GX/WaL7LU0QoYHkzwd2AfvYJcQWFQ
         bJ7x3cH+tglpYXeqy7Edq+yNE6AZattXmx7tYyM9SGE9Mu7qYRCXlr/HjYFtEieYbqPZ
         3l7JcHHPkLxuikG3STMXLJkmrtoJEz+6+luoDH8ZWDLvgKg2GYcM7qejeWr2ADlpTaOi
         s+djdhq2koTydhpcRNxKEMJ2oi9MxZasIZUCUwwQupszXSwXn4r2DeHN7b98zdUizkAf
         1h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206058; x=1793810858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YP63UdSvRgH+U6RYpSmgw00Aw6otHrAc8+AYLP+kjNM=;
        b=D4Yd+W8wsxUWviXGtZavMYoDAPdguPZbCLXk8CkH7/XkZelIe8Br0CBHiQetn6L9zw
         cRIC92l4kqNj4g/xPSvQ35xuBSDAIN+nJK9rKKT6gLfBufxZ40pY3HsFoS4xcxWpkCcI
         Yf4NjvRCptsvZJnX6D2WcZx9javtsXsoO2ljp4HhuQbQgPXFRr+fE3VV4dfTq9GeqIRd
         2F1quasqh8qU5GKFeN/MnP6v6kmKPCyQ+ouwboRw9FmQf2dZz0yYKtIJC17V9w5y9MBn
         S+Rxg9KNks8XWOHSXNBUlxcVHJk/qlcF8C34Ejro1FSHRO37njeBAFQpowslkAmp1jn+
         SAEA==
X-Forwarded-Encrypted: i=1; AKwUvBxlj95MOf4daFPKmn2flzzEYK9LOYkbKkjLGw/GTNbfiPWkIS24MM5lPVtQo+KqiVrdDq2UyJU=@lists.linux.dev
X-Gm-Message-State: AFq9FYIlH5mvsljRYBvMe20mMCVObnweKkW78QHBYSgNf2/+ebyIxvsR
	9ib0L2Uk3JwQQhuVBdPup+q9+Izvqtkihav7sPq2969HbNz7aU7kLbj0jE9JiQ==
X-Gm-Gg: AYBFou16qIDrH4FtjZk6dhs9rfaBefrgEBCS6m/N24mIG66aF6jh4YbFzdaFwpuaLYy
	04ezubr+eWRT3YVDqmjZWCOdY8leOMxDTa//o08zn2kXwmSKJrThMD3oH9qmrJMyJQ7FLZCAbTq
	OJWiBZ5oV4p5hzUBTDJpPJi2FKZv3kaoFLOVVmEO1hpZ/9RISSy9ml8/bMK2vRkgX73BOuyS2zJ
	bN5cbOKti0n3oYg+8pMrB3JJ7yiAb71Sbtf9eNNFtj9i40vnPqzzwW4pqLt79MzvPNFUEsWggRN
	SRLsZ6Tk3pThQAaW1Rd3a7jQZWBz+UF/g0VXNCNhoBC6CM7lOIlIemRcfxEV3vTG3lc26fW5dfK
	FzNw7FlEpAkXh9+dmjdy/Dyn4UXWeQRjHc8i5K3dJtqJYKDKEVGxAw7FhWe+fIN2gY9ImYRdmvp
	D/jgAq88c2ncsVr1aoX3Z2M19GG9eNDoe/+dBLuqbpCMTHIalvZqc1RTyDMs+SIez/X85fh2Z11
	Jp7WcylpY9+Tv2Los4RGrWZLi+CiCe0R2IHNGBSIXJQ7Pa9MRtaLbCUgQuJfnh1mWOg5QxF11nU
	IZv9BbOMrkZgxnl/KepFA4sOz/HodKBCN47R0Q4P4dWSXA==
X-Received: by 2002:a17:90b:48c6:b0:3ac:86a0:5766 with SMTP id 98e67ed59e1d1-3ae5836cbd4mr2201584a91.63.1793206058606;
        Wed, 28 Oct 2026 09:47:38 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae579c5b77sm2173048a91.3.2026.10.28.09.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:47:38 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Subject: [PATCH net v2 2/2] bridge: cfm: ignore CCM while CC is disabled
Date: Thu, 29 Oct 2026 01:47:30 +0900
Message-ID: <20261028164730.253238-3-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028164730.253238-1-pocj8ur4in@gmail.com>
References: <20261028164730.253238-1-pocj8ur4in@gmail.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A valid CCM received after CC is disabled can clear the peer defect
and restart its RX timer. Cancelling pending work does not stop a later
receive from queuing it again. Even with RX work disabled, that receive
can still update peer status and notify userspace.

Keep RX work disabled until CC is explicitly enabled, and skip CCM
processing while CC is disabled. This prevents a later CCM from changing
peer status or restarting RX monitoring.

Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
On ARM64 QEMU/KVM with bridge/veth, a valid CCM after the disable ACK
cleared the peer defect on v1 but left it set on the combined v2 kernel.
Re-enabling CC allowed a valid CCM to clear the defect. All 3 status
checks passed on v2; 2 failed on v1 as expected.

 net/bridge/br_cfm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 28b40dbf4073..115cccf1d327 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -150,12 +150,13 @@ static void cc_peer_enable(struct br_cfm_peer_mep *peer_mep)
 	memset(&peer_mep->cc_status, 0, sizeof(peer_mep->cc_status));
 	peer_mep->ccm_rx_count_miss = 0;
 
+	enable_delayed_work(&peer_mep->ccm_rx_dwork);
 	ccm_rx_timer_start(peer_mep);
 }
 
 static void cc_peer_disable(struct br_cfm_peer_mep *peer_mep)
 {
-	cancel_delayed_work_sync(&peer_mep->ccm_rx_dwork);
+	disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
 }
 
 static struct sk_buff *ccm_frame_build(struct br_cfm_mep *mep,
@@ -414,6 +415,9 @@ int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
 
 	if (hdr->opcode == BR_CFM_OPCODE_CCM) {
 		/* CCM PDU received. */
+		if (!READ_ONCE(mep->cc_config.enable))
+			return 1;
+
 		/* MA ID is after common header + sequence number + MEP ID */
 		maid = skb_header_pointer(skb,
 					  CFM_CCM_PDU_MAID_OFFSET,
@@ -699,6 +703,8 @@ int br_cfm_cc_peer_mep_add(struct net_bridge *br, const u32 instance,
 	peer_mep->mepid = mepid;
 	peer_mep->mep = mep;
 	INIT_DELAYED_WORK(&peer_mep->ccm_rx_dwork, ccm_rx_work_expired);
+	/* Keep RX work disabled until CC is enabled. */
+	disable_delayed_work(&peer_mep->ccm_rx_dwork);
 
 	if (mep->cc_config.enable)
 		cc_peer_enable(peer_mep);
-- 
2.55.0

