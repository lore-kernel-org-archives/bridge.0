Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910852E62B3
	for <bridge@lists.linux.dev>; Fri, 13 Mar 2026 03:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773371052; cv=none; b=k37AFIx1/e0sBKUaFmG16iCOcJu0VpX/PFJTBrhOzCG9HVg7+j6P4IgJXQHdimZ7UDC4bSPxHCxwxaOVsVjcmDSBxEUmBJ/PuJP+6ZIoia3ummrR64XiN+FlrjE3N9RPxS3d+7WICiRxPJ13sIXQYhTykgmvthRwYdeLJpaelWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773371052; c=relaxed/simple;
	bh=pbtKIDznCvGEVtQHODrKsx+vVNFY8ZkNIx/vZ7lzIsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqN+YFNDAi3tE1k9N5ECSDLl+DXOdieV1Q1Fcm7M7U54frAqEW/xKrcnULJbptkUr7XN69oQg5vohtWyNFWBYrz2sxdSv5HOuYZ5ZixcH671rRNuResZ7jtLA++tFtleZX7HPzDFajJsXQ6YMTt9FYZ/UgKHdZkRMmcA16DvCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lsn4edtd; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lsn4edtd"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso1098438a91.3
        for <bridge@lists.linux.dev>; Thu, 12 Mar 2026 20:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773371051; x=1773975851; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPGq7YNOGl3DkR8NTBoIGDJAXGD2GV5oTegfoP6i0Xk=;
        b=Lsn4edtdsTv8EO60IhUmtpPBEKVW0SLeGp8BOoHFx0jOSpEcsKo/Ss1pxlAR+wZSVr
         WxJXidpaW0lC/5/PATjSpiUJ2VZnQbi2l+ovGPhgoqAlBw7ja6BbAz6NUirSPmx2WPxr
         cZaA/WeoRW+15F5B9uM5pEsEMI4YFkgz5iWK226rZi660f1ca75pAO0KJkL08/mpOv8K
         Us4VwpraUP+31CMk0fKWbgtfiXiB2h5jSbQM47cYuoJVDHglMWVzp1QRSGA4keWhG7Ek
         MaUHB7F0DSrVBTFNuaAXlTOqMPamDt7Esp/+D1jPmA/sEt1cHP3KTpPQzB8E2Y24paqT
         FtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773371051; x=1773975851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPGq7YNOGl3DkR8NTBoIGDJAXGD2GV5oTegfoP6i0Xk=;
        b=AtUqZgfFbrT2KZsx8WVZxsQigjFV6/9ui5jo9PJE5hbz8F1YcCZIQgbEfLmbpvRU/J
         V6Mf36hqtgBwLoMKyWqqW2f92eqVj/jWLeApID1iMyNgMAVaYYsaTjUh+TM/vzoi/A79
         L0rEYEp3/lYC9GrpmXjGr8pKlG0FhpP0MpsdkKNLQplGYgNn313Xtr3sDF2AMoRnKzPp
         X+WghOAgvnaED/JqjG0yRXNn2RN4Sf6Smu5Q5fexJN5URRZfrW3985PIfXyI29jyH4Lh
         m/rQc48EdxCcPOvALsnotDwShlImQBlw33tq9NCWAg7pDZL3tA5DD8F261DCrmGjQJ22
         MIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4UqnhgScTdfJ4FQJ00radxn/AwR4zkmNX8og38AxSzINnXGJsfYEc/eubnttsO79rNHB6D5w=@lists.linux.dev
X-Gm-Message-State: AOJu0YzM1KBj3AF0Qft/wGo+H30po2VR7CL6WzVR2SduOFpT4VuPbiCo
	nPjJVzFqFudXD1KFxrTIrw+s/PiGIGtRXeRGh++oIxwKTWmmohQXP80Z
X-Gm-Gg: ATEYQzy3O7Ix6ZE6qAX0qy/JQxbMGPrJFL+aW+DTs3uCzSrVmSvtCnoihvMQnTjUItT
	BhwqZZ3+ZW0yGzbMh4l74rC/NchtF/ITbS0rbUhElj/Qeg8DlP12Rpx3AyarvWnfwbq34Mg9rmK
	pr1bvw/Q3MkRrvKnRZQ7ZNufjgYQ7Zie8VMt2JsDDAAwwi4wO3jLBcwz4OhV6jLDQc7Mja7dcDw
	ZQyZX8RLnGDb5q2QE4SkGQlkRhpIAzV3nKn4pMUJ8Nhm5ieo60sILK/nqpX7BIZb+QUHz3L8TNX
	yQpZHAgYui6WSME9mh/BjipA2sQlIE3ik1mc/C7g4sxMN3jfrM0XqGtNw3WEZ7TasjLQEGAL3fy
	tm+Q4C9D2bmaRVvuqxLGKFb6I2miFokMm/3OAWemEBsjJMpNYmccibMj1uESTcT1ccpdP/yudOf
	N76KUryn6RvlICLRZvTT5xT4gduGoXxyigI4yVADdcz29gCl5yVHckY+DVK66SkKtlcV0vSXVuu
	QlKIF5KtmybwA2mMX1Zi5KswzGv9zXvK5HHfJE4YZmPIxA9JSpLqhdSOzFbfMs=
X-Received: by 2002:a17:90b:3b41:b0:35a:3e2:7cbb with SMTP id 98e67ed59e1d1-35a220558b3mr1403433a91.29.1773371050802;
        Thu, 12 Mar 2026 20:04:10 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:adb0:54b3:92b9:a11b:1cae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a24a7dc1csm293967a91.1.2026.03.12.20.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 20:04:10 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Fri, 13 Mar 2026 11:03:10 +0800
Subject: [PATCH net-next v2 2/4] macsec: move netdev_upper_dev_link() after
 macsec_changelink_common()
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-offload_compute-v2-2-ffbc8ce5d50c@gmail.com>
References: <20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com>
In-Reply-To: <20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com>
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

