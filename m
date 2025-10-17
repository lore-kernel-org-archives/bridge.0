Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527A2EACE0
	for <bridge@lists.linux.dev>; Fri, 17 Oct 2025 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672549; cv=none; b=UNxJ0LQeeFV8eDtSFLWresaZ7v6RMysIr4O/CFr3VY6I1sl3FsK1B7NPrLBYt+gIhPihOm9mJAPEGROAKfbY0mRKTXUBn2LcdSmSbOhegBxjzc0KZgzZin5D6XrFRSf15zjmc+UMUC7SUaj/ZWEkyoL+BVUY/wowx6klUSxgSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672549; c=relaxed/simple;
	bh=MXEju5yO9Px4d76UK4g2o1ywmqDPKrycxs8Kiwy6Tkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+173U7mzqIwgVea/eKUt0bIzynxgMSAuanKmZlcDuYHTA+dbzvveRPt51lq+YVplR/mpsp0kJaX/j1kfQ7fYNgyRSsMIK+LDBnXqzd0VnuuUXMgT9oYlvgzXtmtUWi5EzG7yH/kn2HJhuQhTNYgFXaV2lEl/LqiCa3oPVjculg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqCKn4+n; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqCKn4+n"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-28a5b8b12a1so15137655ad.0
        for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 20:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760672547; x=1761277347; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0/0hRcfmTn5ewjNHsITooHR5wHJru0Cnxm8kxCP01g=;
        b=gqCKn4+nlGyAwJmM2pxwCvezir0umF6kPPFs5cuUA4GFryUWnJmIqZfkhQ9ZjIC7FD
         Rxpfnofrgn6VL1q4T/W6P34Q7SftYLunq492keZqKzj5h06koS6uRsjbM3vZXQlqwTad
         RmJoVmmoB8L1UmDUeOmht6w3tZczdodHKnNcvb4RMg64XZ0A0aCCnXaYqftNkH8obzAp
         Tzb2rapv2stuaKr83IkznhRfEXjEIZGaS3bYfx2Y7O7QZfCSqxQu/qsHtHnkoND8Qrca
         Ydar8GADW0UkFDPtOzF9Ueo+Uz/8zSRTw/YleJY/HHVJ2CryGZa80t0zAoyQmyO67iEy
         BEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760672547; x=1761277347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0/0hRcfmTn5ewjNHsITooHR5wHJru0Cnxm8kxCP01g=;
        b=swY7fpReHBe7WZZDPKfzZft1AJWBmUDattkblQ001/F+ytHP1qtB51k43b1SdmPSkS
         nN5lKhRheSxNLNU1AhGWvrxd6VDao0kTQ8gmC6UHG+q9GFxJmhHa1UgPoRFaqAPPkQOZ
         40EBbQNf5KujDHd7SxG2GhIdsPLkHxmEuWoVu61nKAVMqlIpQOzyCODdFvDIzN3vbBWf
         eGdeUIULAQoyrSseOwo40jh14Chl1j+JB/aCQ/C56Nm64hHNlsu/PG8za6voZtk2tv7L
         bo9up11Ww7cij8P6KJhlnsZTG+9ZJRtKLlspdEPmv634W8N3hKqUkEFML5sjtBgfqsX5
         /FzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgSeY2iyrp8p4HZ/vLvr0P91GZroucYv1pfT4NBQYQ1afRpZJfRMstGzw0tohY/4eLkWKftYs=@lists.linux.dev
X-Gm-Message-State: AOJu0YwuUXTU5CAhF8aw1sQWGM0p8B7EJMDB3fShN9LlBQ3GC3+I/r0W
	M80wp3CQcRK+LWgchz9wtzPefoOF6nSBPJWiiDAVw1viQ/HXKncrCfDZ
X-Gm-Gg: ASbGncvwdZCd2+cvGY0zsTEP+7Yc6pucUSOp/wDTvC2CddWWXCqNWQS0Bzfnb6jtBW+
	oX+vh9hFv3O+1/3wMNmNs5IcN4c4Y3LqLa9lGbxn+YSghtZOQLoIZdlbomHS5uU3uqlr1J2s22P
	IBqy+lrKk3bkVaxRZrljSFLrCUhAEz98aD+LIAi+XZoHJ4L3M55gWDUM5T1yd61PcQZnGvxMn12
	VFh1Ps80fzl/1npAqztot/XhHtRaSjAxq7jHBVb1Zrl/YChAZ/pTmVmuEOEZJ0OyX0yVn3MRasi
	+0TwYyjiF63QfzEZfy8SJeg3jDfvRXhh60KDm7Oe2HSI62hkL+NlEW8RFlJtmR4lOslROEc+cNI
	+XknNsjQSPsBaPp97ygDpBNPo27rIqnsBUXKnPwjAcofM5X5CQGdAbKs4Ac9AII/wabkGnv8mkl
	51+nHaDxmfz59Wdpx7g3HhQAFfCQ==
X-Google-Smtp-Source: AGHT+IGtS4yfeIpw7fIj6eTJkwXSR16RZZAg+fpUBOeLn6J83Zoyd/vuf+HPbQQMeBX1Y+623a5Hdg==
X-Received: by 2002:a17:903:120b:b0:290:cd5f:a876 with SMTP id d9443c01a7336-290cd5fa92emr25623135ad.13.1760672546709;
        Thu, 16 Oct 2025 20:42:26 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab4715sm46695165ad.93.2025.10.16.20.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:42:26 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv6 net-next 3/4] team: use common function to compute the features
Date: Fri, 17 Oct 2025 03:41:54 +0000
Message-ID: <20251017034155.61990-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251017034155.61990-1-liuhangbin@gmail.com>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new helper netdev_compute_master_upper_features() to compute the
team device features. This helper performs both the feature computation
and the netdev_change_features() call.

Note that such change replace the lower layer traversing currently done
using team->port_list with netdev_for_each_lower_dev(). Such change is
safe as `port_list` contains exactly the same elements as
`team->dev->adj_list.lower` and the helper is always invoked under the
RTNL lock.

With this change, the explicit netdev_change_features() in team_add_slave()
can be safely removed, as team_port_add() already takes care of the
notification via netdev_compute_master_upper_features(), and same thing for
team_del_slave()

This also fixes missing computations for MPLS, XFRM, and TSO/GSO partial
features.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/team/team_core.c | 83 +++---------------------------------
 1 file changed, 6 insertions(+), 77 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 17f07eb0ee52..29dc04c299a3 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -982,63 +982,6 @@ static void team_port_disable(struct team *team,
 	team_lower_state_changed(port);
 }
 
-#define TEAM_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
-			    NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
-			    NETIF_F_HIGHDMA | NETIF_F_LRO | \
-			    NETIF_F_GSO_ENCAP_ALL)
-
-#define TEAM_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
-
-static void __team_compute_features(struct team *team)
-{
-	struct team_port *port;
-	netdev_features_t vlan_features = TEAM_VLAN_FEATURES;
-	netdev_features_t enc_features  = TEAM_ENC_FEATURES;
-	unsigned short max_hard_header_len = ETH_HLEN;
-	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
-					IFF_XMIT_DST_RELEASE_PERM;
-
-	rcu_read_lock();
-	if (list_empty(&team->port_list))
-		goto done;
-
-	vlan_features = netdev_base_features(vlan_features);
-	enc_features = netdev_base_features(enc_features);
-
-	list_for_each_entry_rcu(port, &team->port_list, list) {
-		vlan_features = netdev_increment_features(vlan_features,
-					port->dev->vlan_features,
-					TEAM_VLAN_FEATURES);
-		enc_features =
-			netdev_increment_features(enc_features,
-						  port->dev->hw_enc_features,
-						  TEAM_ENC_FEATURES);
-
-		dst_release_flag &= port->dev->priv_flags;
-		if (port->dev->hard_header_len > max_hard_header_len)
-			max_hard_header_len = port->dev->hard_header_len;
-	}
-done:
-	rcu_read_unlock();
-
-	team->dev->vlan_features = vlan_features;
-	team->dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
-				     NETIF_F_HW_VLAN_CTAG_TX |
-				     NETIF_F_HW_VLAN_STAG_TX;
-	team->dev->hard_header_len = max_hard_header_len;
-
-	team->dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	if (dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
-		team->dev->priv_flags |= IFF_XMIT_DST_RELEASE;
-}
-
-static void team_compute_features(struct team *team)
-{
-	__team_compute_features(team);
-	netdev_change_features(team->dev);
-}
-
 static int team_port_enter(struct team *team, struct team_port *port)
 {
 	int err = 0;
@@ -1300,7 +1243,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	port->index = -1;
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
-	__team_compute_features(team);
+	netdev_compute_master_upper_features(team->dev, true);
 	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
 	__team_options_change_check(team);
 
@@ -1382,7 +1325,7 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
 	dev_set_mtu(port_dev, port->orig.mtu);
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
-	__team_compute_features(team);
+	netdev_compute_master_upper_features(team->dev, true);
 
 	return 0;
 }
@@ -1970,33 +1913,19 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 			  struct netlink_ext_ack *extack)
 {
 	struct team *team = netdev_priv(dev);
-	int err;
 
 	ASSERT_RTNL();
 
-	err = team_port_add(team, port_dev, extack);
-
-	if (!err)
-		netdev_change_features(dev);
-
-	return err;
+	return team_port_add(team, port_dev, extack);
 }
 
 static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 {
 	struct team *team = netdev_priv(dev);
-	int err;
 
 	ASSERT_RTNL();
 
-	err = team_port_del(team, port_dev);
-
-	if (err)
-		return err;
-
-	netdev_change_features(dev);
-
-	return err;
+	return team_port_del(team, port_dev);
 }
 
 static netdev_features_t team_fix_features(struct net_device *dev,
@@ -2190,7 +2119,7 @@ static void team_setup(struct net_device *dev)
 
 	dev->features |= NETIF_F_GRO;
 
-	dev->hw_features = TEAM_VLAN_FEATURES |
+	dev->hw_features = MASTER_UPPER_DEV_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER |
 			   NETIF_F_HW_VLAN_STAG_RX |
@@ -2994,7 +2923,7 @@ static int team_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
 			port->team->notifier_ctx = true;
-			team_compute_features(port->team);
+			netdev_compute_master_upper_features(port->team->dev, true);
 			port->team->notifier_ctx = false;
 		}
 		break;
-- 
2.50.1

