Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3D24467E
	for <bridge@lists.linux.dev>; Tue,  9 Sep 2025 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405969; cv=none; b=BoUnm5LlvtAHcy5QDDpC8o6I/fhFPZ5R1F0sxo6rWXZL1Ojx5GlDCZpkaj+5BbLmE3o2QjrL0tQ4Xwtp8M+TBGSDvATMrXivAb2ej1ofvETp4gTpkscKyjrm1g6K9tb8+jUMl0MKknUzNNqfC6RsRgJlKj+ifS7xNrGVcJjW8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405969; c=relaxed/simple;
	bh=Eu9oo0GclufWi8CUOE7sIIQ2BCgIf/5MYzSwb+NM0W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ns8cWNMqA9pvJPHUlrRPVRTI9mc++ZvbqLIL1iFaP1vE41XHFEnelGOcKbuHzSQrWL8PTLph7l5cMpPkheECJw0q/JesrKvD8mwttA2f3yxkowhWuM6f9Jb/yxKCr8wYYrSJg/+xiMi5V4BubJxPksMkUTK1cNuZYkQo/qwtIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAjBIYJd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAjBIYJd"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-244580523a0so57286245ad.1
        for <bridge@lists.linux.dev>; Tue, 09 Sep 2025 01:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757405967; x=1758010767; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUUrBUErthGY79KnwDuuvCi+ucUhohR/OZimf4m8Bpc=;
        b=bAjBIYJduPZpDZ6ZPU14VxOfznuRBMlxyb2Qlak8OWlalZdovhH8PGa5wN9fWHsWCt
         aUmdo/u/pt5N4u/2+gA/YQvAtC41+nMgAaGZhmGiIAdgZhjkUKJVypY8lS694eOQgS88
         WMO+G4b4Blcw8eKVRJG8fXogLzRGTZMO3wCQywg/F/3jOjXXLF05XujjsK5HUaM4urY6
         oHK71bBcBqXOPN3yMdCM9J0cbEWQKU4vzsRMgnZC/SJbq40eDKpeXSYc5tw2Ga1yEd8f
         QUB6ZsjRz+/0SFIzd6gIUan7kZXUvX4dLtJgCyF78wPu1O7nN1g6NyF+PR42h0sJGUm/
         XsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405967; x=1758010767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUUrBUErthGY79KnwDuuvCi+ucUhohR/OZimf4m8Bpc=;
        b=iz/thfireLqVU8PxvfDydjPvoHVAoqkpf1AiqQMI9AXq5VZbVWr/AbJ8NeMAlaBtfh
         5U6ogp1OmYFgFYQZ1OWueTfpRfo4E6u9x3T9BeuYGCloooxVA6kwamrQyRe4xapAaqTQ
         fLQiX1czVkm+vPF8Vl6GhbYdbhpjxa3SjF9u73O9GQS/v/lz3khQi0b4/HYhPnrpr/NS
         SgE6LqPWe5VsKyfMd+5avE2Jq63pnFTz4kTKWfu0we4qsI7C4jAD3WWgopis2F3p4EP7
         Oq3NLiMzEUV8CCBgFz6qhcO9hiLuiAA7IRl2CuyZQVSUOqGRO57K3QkUnSPlBkMbxyfZ
         NBxA==
X-Forwarded-Encrypted: i=1; AJvYcCX8FNXAMPUwUR34zbQ/owTHrCu+j7wDmhIqcCwByEeY6jzl6GoWWRdo7PBc9UBHOHRgphKhM+U=@lists.linux.dev
X-Gm-Message-State: AOJu0YyEP2ptcC6I++gxr33dXmpK4gqlzdhe0T3+2zQPh/Nu5i60s+xf
	BF1l0DO3R+OIJTg/WV5PHL8dvphN+nAtgpSNW3IkN5lZTTlQBJdTmXrD
X-Gm-Gg: ASbGncsSmIu68OIKuVMTycMzDsnWZo/DHKi2zOyzkT2pvVjZX+Fq8pl7+iGCYqb1LJ+
	b+rTe7IytlhJ4opVOff+l40xo90AmAw8EG/odORUW5Aw6B/CVkI6zuE0cSffntdrWTRkmS6KiBv
	OWa/q0mEPdA8eKSRbP/5HPoG5PmTzJmy4en6rch14gUEqF9f3RGcUU4V4r1BK+CBUX9940VvWA7
	XrxlhFg3WbBSil294c4y0fofkCrZr09DpprBsm5Iv4pD3H7LNxpshMRApc+AnbahumDNgEZjVNJ
	2vp+pomBH+FJb1VAt9e0RtJKBg3wt237QI1EPBiQjfr6jFHdpXx+Hkl2F0HAXmKi6mPyU7yp6Cm
	CsfA1esaAA0XXeqwn+GUUxyf4xnd7bjRal3RJTAHO6N1UVsmbtzed
X-Google-Smtp-Source: AGHT+IEoDozETSAVhjvVYDHFH2NyPH5nJWHyVg1KPi7bNvofIFUX5MaX+Nz0VReUXMgaBo1MCtEA6g==
X-Received: by 2002:a17:902:d54a:b0:24f:b709:b672 with SMTP id d9443c01a7336-2516da06c7cmr159226165ad.19.1757405967020;
        Tue, 09 Sep 2025 01:19:27 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7ecd9cafsm174370575ad.83.2025.09.09.01.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:19:26 -0700 (PDT)
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
Subject: [PATCHv3 net-next 3/5] team: use common function to compute the features
Date: Tue,  9 Sep 2025 08:18:50 +0000
Message-ID: <20250909081853.398190-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250909081853.398190-1-liuhangbin@gmail.com>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
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
 drivers/net/team/team_core.c | 78 +++---------------------------------
 1 file changed, 5 insertions(+), 73 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 17f07eb0ee52..c5fbe392fc62 100644
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
+	netdev_compute_features_from_lowers(team->dev);
 	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
 	__team_options_change_check(team);
 
@@ -1382,7 +1325,7 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
 	dev_set_mtu(port_dev, port->orig.mtu);
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
-	__team_compute_features(team);
+	netdev_compute_features_from_lowers(team->dev);
 
 	return 0;
 }
@@ -1976,27 +1919,16 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 
 	err = team_port_add(team, port_dev, extack);
 
-	if (!err)
-		netdev_change_features(dev);
-
 	return err;
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
@@ -2190,7 +2122,7 @@ static void team_setup(struct net_device *dev)
 
 	dev->features |= NETIF_F_GRO;
 
-	dev->hw_features = TEAM_VLAN_FEATURES |
+	dev->hw_features = VIRTUAL_DEV_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER |
 			   NETIF_F_HW_VLAN_STAG_RX |
@@ -2994,7 +2926,7 @@ static int team_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
 			port->team->notifier_ctx = true;
-			team_compute_features(port->team);
+			netdev_compute_features_from_lowers(port->team->dev);
 			port->team->notifier_ctx = false;
 		}
 		break;
-- 
2.50.1

