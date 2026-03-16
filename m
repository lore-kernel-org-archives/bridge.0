Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997E3339708
	for <bridge@lists.linux.dev>; Mon, 16 Mar 2026 04:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635251; cv=none; b=UeETydsLu1yM3dvSsVHHPn+t4ByhTKm2Dre7bHfezoDX3gryNeAwwWUjQk2TA2CIpWGRLqsDOpO+SjoK81loYJrQdDRpwiy0k/VzNwmvlDroWvJGqFteyZAhIzTkom+6Pf/PGR5x9K0V4mpA4e0/fuNd0KKvY/K9CR2eeELY09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635251; c=relaxed/simple;
	bh=pbtKIDznCvGEVtQHODrKsx+vVNFY8ZkNIx/vZ7lzIsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUntssfr1yyBfZBSUUkd3Ku3VnaSQ6bZ+xwwnR+2HMj1CuYdn1tB9yP1pW5twAFaiR2r1GdK6qgK6RnHa+eatTwRB8TAy1E6cztulPGKM3woYughEGQof59kZX901vozFMXTxxVrETJZSLT+NpdOlx38pk0LPCs5mFFgciLf8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMX+wlAU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMX+wlAU"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82985f42664so2647255b3a.0
        for <bridge@lists.linux.dev>; Sun, 15 Mar 2026 21:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773635250; x=1774240050; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPGq7YNOGl3DkR8NTBoIGDJAXGD2GV5oTegfoP6i0Xk=;
        b=hMX+wlAUERoGWZyFGI59X00tSbMrPm1fVwOxPnsNkfbfU+GB8oNTIvLNcRV8jy/WFZ
         rehbVeqJg2APhEU2B/0zCbNVhG2VF+BI2GiExa6PmStOP8rwvxGmomp58UsiQ5o+9m9e
         OXuvMfzCmqKQIODJgHziH8BpjEqsnFjt2oGSmn1k/DE2RFKNRCWQ8qmsHw77qBwo7/UP
         xL3iUUy7nscpPg3JfugCqz7+n2qjyva/o9x9fS0KYWuTmFOu1+HG16/hZQ7XDDTcthZc
         UGvXY02zkPhpmD3ze2jQtb17fe0o6xzVBjHrEynYahnbAfY+NTYr0RhoWXUVj6GXJhzr
         dXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773635250; x=1774240050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPGq7YNOGl3DkR8NTBoIGDJAXGD2GV5oTegfoP6i0Xk=;
        b=QQDau2jj3vNwNi+0lN75i7jRMTPyqQXtU4sp0FJRc9t3sz1PK3fQMSD3IfbNstsceo
         8BY1LxQxX9t0CS1vZDMKBZnneZpUfIKQLupha8HrfNUP4Pon6R6GW7J7kKjZ58ScT/hc
         swbYcSGtbS2MjVQEGoUn/KDl7+Yt26rUi5OTHXbM1eIc8hLnfTfzbHRJRYKsMXnfFO9A
         P2tmemGXiwTZ4AjsqC73fiwXSEK0DH6UdMd1NbfQzbu/OCVFFs96qOEW3rXYAWICQFWO
         x6wn9XFhC/7/+p8luLgS5Xh9l0ECn1C21mkD2VZC2+4qBfIbwt62eaIpck5L7Vn8kHDB
         kmig==
X-Forwarded-Encrypted: i=1; AJvYcCWwkEDsZ+jjeeG3Mn0/pIMq1DRlnY/4Es3Qtv5JJyGseRy2HhwOVVLA6WmuEeGxu5X/DSgAFx4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwR7+ZL0nnM5fRchk32FUKNXcgvpQ4bIF+OOuuZzvF5t6F8gdgu
	HTmCz7TQ6AX6DnxANILelStmwuD0g/zY8B/RqaPzjvJr1yyhvPc+1kSh
X-Gm-Gg: ATEYQzx2O/MNYXXJCSfTt3xkHt/tif0Enxn323l5i6xY9AvTsXoqLBlZ0YMHlKCysbM
	BqlGmrw0kJKBSZFZ+SAbxrb2q6SvvCXcpNg/1TZEl4qH3YPq0YOH+diU3bPQYj2DBawn2VrYx9L
	TcOf3KUL7EIiRsdRfgoORrZvIjm77D3EwvyybHuFuI9jdoO+jxzIdjHy+yG6Eh95PGW/fAAc23I
	KPVSJfT7aOEwMIq9gY++jvfszI6Ox9CMMaNCDrzLjIYNtCSapbFb6yMmGZQ6u6TiefzlJZH/+5K
	Hzx9AuXmhdfNsCCCHtbQTbHy6/FyFn3hgc/nfZ0Qxdmh67Y/AOC67ErE4sASYSvJkVRjh8imq8C
	KQRp+bDDaDfydnswQsDHVPCZTS1fiMT5XyPi65ZFEpvpua2XxIPn/nRiVN2pgPCAR5vPXkASTR1
	7dctMcnzbSCyA4xsq+iEpsspt9r5DgEplMDJXok+BS4dh1lm473G318/5f0ZFrAi48ByZs
X-Received: by 2002:a05:6a00:981:b0:82a:110b:e22d with SMTP id d2e1a72fcca58-82a1971e6f9mr10199007b3a.24.1773635249914;
        Sun, 15 Mar 2026 21:27:29 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([240e:34c:5760:3860:bc29:deed:92d0:823c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738422esm12180267b3a.55.2026.03.15.21.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 21:27:29 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Mon, 16 Mar 2026 12:26:11 +0800
Subject: [PATCH net-next v3 3/5] macsec: move netdev_upper_dev_link() after
 macsec_changelink_common()
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-offload_compute-v3-3-a5d4a07d86d3@gmail.com>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
In-Reply-To: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3

After calling netdev_change_features() in __netdev_upper_dev_link(),
the call stack looks like:

- netdev_upper_dev_link
  - __netdev_upper_dev_link
    - netdev_change_features
      - notifier_call_chain
        - rtnetlink_event
          - rtmsg_ifinfo_event
            - rtmsg_ifinfo_build_skb

In macsec, we call netdev_upper_dev_link() before
macsec_changelink_common(), which causes the fields of the MACsec
Security Entity to be uninitialized. Later, macsec_fill_info() returns
-EMSGSIZE and triggers WARN_ON() in rtmsg_ifinfo_build_skb.

Fix this by moving netdev_upper_dev_link() after
macsec_changelink_common(), and return 0 if secy->key_len is not
initialized yet.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/macsec.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index f6cad0746a02..6bb38084bc1e 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4161,10 +4161,6 @@ static int macsec_newlink(struct net_device *dev,
 	lockdep_set_class(&dev->addr_list_lock,
 			  &macsec_netdev_addr_lock_key);
 
-	err = netdev_upper_dev_link(real_dev, dev, extack);
-	if (err < 0)
-		goto unregister;
-
 	/* need to be already registered so that ->init has run and
 	 * the MAC addr is set
 	 */
@@ -4177,12 +4173,12 @@ static int macsec_newlink(struct net_device *dev,
 
 	if (rx_handler && sci_exists(real_dev, sci)) {
 		err = -EBUSY;
-		goto unlink;
+		goto unregister;
 	}
 
 	err = macsec_add_dev(dev, sci, icv_len);
 	if (err)
-		goto unlink;
+		goto unregister;
 
 	if (data) {
 		err = macsec_changelink_common(dev, data);
@@ -4190,6 +4186,10 @@ static int macsec_newlink(struct net_device *dev,
 			goto del_dev;
 	}
 
+	err = netdev_upper_dev_link(real_dev, dev, extack);
+	if (err < 0)
+		goto del_dev;
+
 	/* If h/w offloading is available, propagate to the device */
 	if (macsec_is_offloaded(macsec)) {
 		const struct macsec_ops *ops;
@@ -4200,7 +4200,7 @@ static int macsec_newlink(struct net_device *dev,
 			ctx.secy = &macsec->secy;
 			err = macsec_offload(ops->mdo_add_secy, &ctx);
 			if (err)
-				goto del_dev;
+				goto unlink;
 
 			macsec->insert_tx_tag =
 				macsec_needs_tx_tag(macsec, ops);
@@ -4209,7 +4209,7 @@ static int macsec_newlink(struct net_device *dev,
 
 	err = register_macsec_dev(real_dev, dev);
 	if (err < 0)
-		goto del_dev;
+		goto unlink;
 
 	netdev_update_features(dev);
 	netif_stacked_transfer_operstate(real_dev, dev);
@@ -4219,10 +4219,10 @@ static int macsec_newlink(struct net_device *dev,
 
 	return 0;
 
-del_dev:
-	macsec_del_dev(macsec);
 unlink:
 	netdev_upper_dev_unlink(real_dev, dev);
+del_dev:
+	macsec_del_dev(macsec);
 unregister:
 	unregister_netdevice(dev);
 	return err;
@@ -4337,7 +4337,8 @@ static int macsec_fill_info(struct sk_buff *skb,
 		csid = secy->xpn ? MACSEC_CIPHER_ID_GCM_AES_XPN_256 : MACSEC_CIPHER_ID_GCM_AES_256;
 		break;
 	default:
-		goto nla_put_failure;
+		WARN_ON_ONCE(1);
+		return 0;
 	}
 
 	if (nla_put_sci(skb, IFLA_MACSEC_SCI, secy->sci,

-- 
Git-155)

