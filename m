Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5598265CA7
	for <bridge@lists.linux.dev>; Fri, 29 Aug 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461306; cv=none; b=SRc6kJ2y8WJKxVosjfzh7LsP7ycdH9G9flZqIQgg+gsY8ehCJED77uO8z7MBwZm7m1Fqq9PneCAjMUVvrxkJVEPZxDBpYskey1ZSO+Z+4AFtHRPk7CRP9AFhZVS/YiD5EsF+cEWJKFldJ693jRgAiJvflTrsGz9Hv/4Gdl8c0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461306; c=relaxed/simple;
	bh=fpxAMTh1DHFN9bdroAryNzz1TbRNMH5pMcaPuAnjYMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laSeKegLpeckxY/Dxb1hv56lLXRZdcEM11Qf1aWP2S2Gks+TmBVCXZKc/5nO2sDArqHU3eAHoPApMi+5WYZZyCpQCgU+db17U9+vb/obLJgYPqCrNxU3p1mW3EpDlUFmYD7+nbYDby+gC+8lbdAtvWRzL80phYG/fu+01mkx/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDwiLZcu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDwiLZcu"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-771e15ce64eso1613723b3a.0
        for <bridge@lists.linux.dev>; Fri, 29 Aug 2025 02:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461304; x=1757066104; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6NPvT6bQ/Fm1Ox6j1QOMXLS7IgmyQZhMktUnB9yevI=;
        b=SDwiLZcuAlkT7hPNju81bLkGSxPmdgS49cZc8E1waMl8RBs4daCHzpJEqmEBofOZq1
         R0KvPwlsd/VyXT+OILYw8dX5YocfD49wp9HWKcJvdmxTpygnKp/Ncyg2PWrXeqYIlXBy
         kSfsdEM5pI7zqxYmGZ1whYvftBxL+CczgcvZ6dTRxrj/3rvTVJRX2QbRh6SMgwG/9cMt
         xx+ggM7yQt3zwfDrUrxf9hj4hObUNni3Fvto3H6DyyaguixXrQkMgoh05Yy5ORI2pgeA
         HCR7DCAdKVZ9+SQu1ubh4VLW6SsvDX6CVLlRgqHcvOu6woKONARsq3KnZPej2PkU4LPJ
         xPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461304; x=1757066104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6NPvT6bQ/Fm1Ox6j1QOMXLS7IgmyQZhMktUnB9yevI=;
        b=lz1cDE/MJIuY9H7czSGtABx2knG4PJJLWhTbNO+N0XiBuIyGYxbfaCpNrk8bWsGODc
         mDUaAhdvYE/ItDRqbbWbDKoGYkiRG2whnWVXehbXiZ9Eg3SrMS8GpVKpwpmJvGUsPy4X
         44arF28zlPHHDAGk05rOyEAeoM0JzBz8oSMDSyqJbhwNiRPz65IKb70JnXvVke0BNumY
         gE1yu2oMmhPqRfdqYgB1N9wzZZVOVW2Bj4xeHijURR68wmUcfsK20HL1M8Z1DuCSR5v6
         3NWpogDmPhBqI41dELWIc2mcCuznoI5VzCNcg5zv/f0VRoPBDYqyNeKt8+J+mtpgwZu7
         E40w==
X-Forwarded-Encrypted: i=1; AJvYcCU3Uu4akKVGL8WUe3HUadGcHlZlr4+w58vqpO4gPSbbUtWba3uzugX4eddNUCF3QQjQTLl/54g=@lists.linux.dev
X-Gm-Message-State: AOJu0YwDPjVboaT4prEkuxD/7imQH1WRsjs190d1GyfZZU3AshSVrdbF
	LBiaZgYpvbfCTL49/N19pc+0KCLXM64oL0Kx08m5NWVPTQg4VY1mznph
X-Gm-Gg: ASbGnctS34svSOUDy9HJ4ucnxk8OVOVxzQtwg0ALwqwhxKXhjnajbdgDJRTSNBqSAbD
	ZppKN2JYhO/Jqev40fVjgmsy3w8pPD9zj1xESJFQwU9IHcaSk8/O3COFpOR61M9x2Y4I2yqHxPv
	A4ivbx2dr4bU+ZEBHHxsbfeiwo0ZNz8sIB/8Vp6HFVRyD+KVXB6DpQ7As+YmBnO9GOC8s9sqcrv
	o1MGn4m2GIzHeP0BO5AA9wtk411ZDC7mxmG8tObKlQJScP08qu0QAAYxY4HYQ07RmPeq+ZQE4UH
	uLdGgHBlQBzc4GeiHPTlUpSvIVXNDLHnrLslS4kWMZ4zIegVrw0Yl/AunYUz5tb3xxAbDe6k6ue
	SrT6aucUUvu+PCbgjixzV/sNWHLoqJIhsXLDsyBqn3w==
X-Google-Smtp-Source: AGHT+IFGXzhq9ds6ROUBYBGSxBK4ajoQmAHzewQj+7CT/9RjdUiBfEp4Rj+dc45CK1+/tRRA0h2qXQ==
X-Received: by 2002:a05:6a20:4e12:b0:243:6e5a:51ef with SMTP id adf61e73a8af0-2436e5a5496mr20602657637.43.1756461303928;
        Fri, 29 Aug 2025 02:55:03 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd347db1fsm1751528a12.47.2025.08.29.02.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:55:03 -0700 (PDT)
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
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 3/5] team: use common function to compute the features
Date: Fri, 29 Aug 2025 09:54:28 +0000
Message-ID: <20250829095430.443891-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829095430.443891-1-liuhangbin@gmail.com>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
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
 drivers/net/team/team_core.c | 73 ++----------------------------------
 1 file changed, 4 insertions(+), 69 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 17f07eb0ee52..018d876e140a 100644
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
@@ -1976,9 +1919,6 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 
 	err = team_port_add(team, port_dev, extack);
 
-	if (!err)
-		netdev_change_features(dev);
-
 	return err;
 }
 
@@ -1991,11 +1931,6 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 
 	err = team_port_del(team, port_dev);
 
-	if (err)
-		return err;
-
-	netdev_change_features(dev);
-
 	return err;
 }
 
@@ -2190,7 +2125,7 @@ static void team_setup(struct net_device *dev)
 
 	dev->features |= NETIF_F_GRO;
 
-	dev->hw_features = TEAM_VLAN_FEATURES |
+	dev->hw_features = VIRTUAL_DEV_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER |
 			   NETIF_F_HW_VLAN_STAG_RX |
@@ -2994,7 +2929,7 @@ static int team_device_event(struct notifier_block *unused,
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

