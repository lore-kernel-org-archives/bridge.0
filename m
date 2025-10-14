Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBDF30F924
	for <bridge@lists.linux.dev>; Tue, 14 Oct 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428974; cv=none; b=nnq5ReVnyMBJCEcyR9mUjZVqP+0VzgIS/vRm4Q12WskWimzXpDhuaisCwIYTWq6jrKa3VrrYP5Zjj7Z1phLcdDw2uLxy3MXI3LiWlY/bdlApbQYWLN0NBNKdWuQmgFdLpinjfiM56MvQlfByor4HnTjJlO4viZXoSuyZhf9HMmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428974; c=relaxed/simple;
	bh=v/wIJVHymXR0j0ByP0dl5kdKBXrbvxjnB4cnfrt0E4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohVA8DBlhI8Fc1QBS4aHX9RiAgSb2I+Qn3jfg8IpcO83Pm77mVYDezGqoLFlPcM3D9pvkGojBawNoXGW3//sfbNS/DQYbxeYn4DXekYHQrpj35pdWs2O6RdtHn+yHAkHtevcEkFycx5w4heyxzYxX6l+Fm0E9gq7Lq7JrdfMUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKoUQIu5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKoUQIu5"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3322e63602eso6723019a91.0
        for <bridge@lists.linux.dev>; Tue, 14 Oct 2025 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760428973; x=1761033773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7prt04ADWx0fn0Z7pGOB9FoDOjfwgNqGHsIR96eCJc=;
        b=UKoUQIu5ApmESp23GSfqZJzo+q6Tig0yvm27LwvAXMvZlrgxk0H7m74C2ZCXUwESHf
         +S703XMm+Ob3DRX7jPGJG2Mi8F3h29iN0IQy5z6L8RXN1K6nungn2DNyy4AQVGTeBKXO
         IjfEPKZ0O2T5fc2avfkTnKqsF81NRRIpTZpLCtONUb8G3sz1PAlvvd1f/hM4PByZGy7k
         Vcf2QGcSkinQyqvvv0M4ysNrA22fA530agqgQonWfeSmxsvSPzHkFD91X6F+PqFy5dyb
         LIRkZRZe8bTLqZ+grpkX8zMm6QBDaMlNAivLfiMwALbjU4gDRz7vtW7ZzfosgSuMmBvD
         zYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428973; x=1761033773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7prt04ADWx0fn0Z7pGOB9FoDOjfwgNqGHsIR96eCJc=;
        b=wbXtcVCRl4dSh374U2PkNZXchLOAoynNetdX/cLxzSr39gSJGZyp4I8uKXYAwNFAqf
         CgoTjXLYcW/ZdYdnrYlaiGisZIsbb5vtjhCbvspXREwOnX2/ktTre1V5VhUrjOBb03sX
         I3qpu2AWFTmqmsA2YBjdSANVsRPyQn5/bw93CB5iIgxEK4arXcCPBpif8tGotMRGHBs/
         ZW5lMC5JrnyCrUvY5q/MdzumIku9fYPBLpt/pN7uZ3cVFStfRWjuQUJmT7EbXcM7aTPo
         THiGbmJCknHTbdieYdouHg+wtBO7n5HDAuJL2vuCcDLoXt+hen27LT4l0tkPhXxF04TC
         sILA==
X-Forwarded-Encrypted: i=1; AJvYcCUwCZvsa8s2OcSrIayvhMBWwYOlN1hgEqwdYa4Yq2m4kuDi2qIt82XOufFiZEVmsBjgR2Valaw=@lists.linux.dev
X-Gm-Message-State: AOJu0YwbPqSEDT1M1/I1zmhoFpmr4OzZ+m0x5/jht7cMREJ01h5Yjz84
	5fYppJSutmG/DWAgyl4Z/NDpjeGoeyIECESU3nqVnp+bkgCFDgdpA780
X-Gm-Gg: ASbGncsZyBUCLrdPLuI/U3pnmrCWHa5Rm619hV0Vax7RUKv2wRZP7iEmA1DUTwNjRFI
	K5EbpyzOWeXuxnkvf0h+lSDiZAhom4nY9A26MNb6FFDWPPG23urd6YMCclKxw8Gk2UbEiWgQDkE
	xWuOr1T7xg8/hSU6ZvMK+NQXffflYb/NOQgAoTmN7xmSgVXH5KaM0WKnPsMlItn+VrIKQDabGOp
	Icxj/XKcOJ0LHkZQ8OG/yU2sxYjYp6mfxcNEliKIE2oHPURQW7p2iEYy6Kn69Owf3OGFYwoERY3
	ZNoFb0ZSe7kiu8dboNKtPaG/5avw1xabJL/jA/xwHyvT1JT8UxReo4A459ZRMtIFDnHWcWr0Wyr
	5HOBL0sNl4rGssj2zdh+CFHEJUF02rlTm0r7ANGWr1V0Yew==
X-Google-Smtp-Source: AGHT+IEVofAHMNuGc7LSVEwbMFdV5baxM3Yag0mW/ybZvJCPq+vu8y2XQS23VTKmvMmHIC3b+TxwEw==
X-Received: by 2002:a17:90b:4a52:b0:332:84c1:31de with SMTP id 98e67ed59e1d1-33b513ced6emr30004724a91.25.1760428972626;
        Tue, 14 Oct 2025 01:02:52 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626407c4sm14648210a91.6.2025.10.14.01.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:02:52 -0700 (PDT)
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 3/4] team: use common function to compute the features
Date: Tue, 14 Oct 2025 08:02:16 +0000
Message-ID: <20251014080217.47988-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014080217.47988-1-liuhangbin@gmail.com>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new helper netdev_compute_features_from_lowers() to compute the
team device features. This helper performs both the feature computation
and the netdev_change_features() call.

Note that such change replace the lower layer traversing currently done
using team->port_list with netdev_for_each_lower_dev(). Such change is
safe as `port_list` contains exactly the same elements as
`team->dev->adj_list.lower` and the helper is always invoked under the
RTNL lock.

With this change, the explicit netdev_change_features() in
team_add_slave() can be safely removed, as team_port_add()
already takes care of the notification via
netdev_compute_features_from_lowers(), and same thing for team_del_slave()

This also fixes missing computations for MPLS, XFRM, and TSO/GSO partial
features.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/team/team_core.c | 83 +++---------------------------------
 1 file changed, 6 insertions(+), 77 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 17f07eb0ee52..03df6a06e0b8 100644
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
+	netdev_compute_features_from_lowers(team->dev, true);
 	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
 	__team_options_change_check(team);
 
@@ -1382,7 +1325,7 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
 	dev_set_mtu(port_dev, port->orig.mtu);
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
-	__team_compute_features(team);
+	netdev_compute_features_from_lowers(team->dev, true);
 
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
+	dev->hw_features = VIRTUAL_DEV_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER |
 			   NETIF_F_HW_VLAN_STAG_RX |
@@ -2994,7 +2923,7 @@ static int team_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
 			port->team->notifier_ctx = true;
-			team_compute_features(port->team);
+			netdev_compute_features_from_lowers(port->team->dev, true);
 			port->team->notifier_ctx = false;
 		}
 		break;
-- 
2.50.1

