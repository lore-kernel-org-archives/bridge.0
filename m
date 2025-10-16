Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF71DA55
	for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585942; cv=none; b=Uq8XA1y9UI2BWhOj71xrExOjcjXnyAyNdR/Su0kKsl/jZRpnv9kfzzhpYwy/xDJDALLbpol7c4umHus/RU+GV9K34xQIHyj7hB0y7vYrQkCeQMNuygxarqKClOn+lYsix3RI50VEI2HgP+g0kOFi5PlbFkTKu77+BtFoeYTyB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585942; c=relaxed/simple;
	bh=Aj+hw3DlrAp4seWAW4d6WWDRMpqlQiLdxXwz588T+qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8+nAB94gmNbDamrbsjPwSZtO1fwngWBAzYI9VTafqlAk4x2tfmM836To8LoKMebkdHDkEXlMo9kC8diqFqM0IiZjLz7S4AZPW6yCX8icTqUZSb57AMpPDLW+y8/qQYwlPXFzsclbUsl2JiMqnwjiMBrEv1V3QfwS70/oseG74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7f6irQW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7f6irQW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2909448641eso2286815ad.1
        for <bridge@lists.linux.dev>; Wed, 15 Oct 2025 20:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760585940; x=1761190740; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqa7ROCGzACo8acdJhTd3+rTSRJ24Bm72S6sykjbwcM=;
        b=Z7f6irQWETRcNEjHBdc/aFPiDUy1czHvKtWQx7gtQPZl6EgEq5Bx55DISdLW8sapYg
         GqZk94e53he0hy5lyYeD6mAewLdBFOEa8V7Nmrah3pCDhdx718R1IHHqxm02Erk6xHzz
         vkOb6s2XRkAGMQS1u6KmQ+hiHU6ACPoPtEsfd54dYZhUrLRe8YRfPZ/Adu/ehyJvQ242
         enpuZJu1HKsWMF6AzRZS0ga0YmU4XyHSLBbMrWz2OOPOB4X9JHpeH1Q8+JD0hdKE0e+b
         Jbxc5X3CoObR65GQc0VbVroqUN9LdLQn7NChUwOIdSUoqGE61OGQnnf77ps+kJYfdz/P
         8W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760585940; x=1761190740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqa7ROCGzACo8acdJhTd3+rTSRJ24Bm72S6sykjbwcM=;
        b=EQvQP76DEa9mOjhl5U8PD/kmp1EiLeErfF6XCFjfH9iNovPhnjgVOR68oDdagtDHO3
         vptPbc1M+J4APt3r5aT5053lWECN0Gb7ZH0uPFaeSfh2r9bgP+w617PB8ELxolKmeCj4
         mWlrI6qTnAOVvsyry8Nj+8O3N/SyclfkMGX4R8sP9kSUGo3Zo8QDM8niqqmxu4qaUmvl
         KIF4pS9Wf87mek1onLT9Q83+skrNg3HSZfoPlk+2OQxx2wBz3LNozQzENK9R4eWp3wi2
         b4N9eVpMI52+2kfHkHIZBn0u94Txtra1WBXJjm278aiRWSRJZMcUECNZRAoi3qzFTFru
         dlIA==
X-Forwarded-Encrypted: i=1; AJvYcCXqBCZASf7zNMmO9aBQR2rYqyDYYDiYlInMLnN6EZaoGDYtpZBopKoQj6WejFaTMUUIEaguqPc=@lists.linux.dev
X-Gm-Message-State: AOJu0YyLniCW9wCUBhajQdkXTvAn/muRzSpCYZhSvS8tEw0TLhm2xY4y
	+qlKd7nrm16rjtzadmX8IROT3MgQNPZyYAZp70JNNDBVmtcurYm5erlQ
X-Gm-Gg: ASbGnctwJNcRCvR2OnDMCziwwpVyxHp9Wk9Y7qXjVvTwYceHoAwwi2IcdqU/SjGepDN
	9q0et3CvKCPk6NP3fq+h9n+W29KyrNKE2lTvMArAe1YG+cS/zvv66E3YaKSuH9I573kgsD0H8bT
	MS1y/KQvCr3HTABlRO8XgyzoXYe4p+MkkYy/Xc7GY5rrAMrxKX15EZsS3bes83BL6SUNHSDiaoK
	W1drARa9Y/V/5x+7IDkTkLEda9zAkNoD5ghZkkDPqTevYZ+U3UTx3laHXrBoqel2buAIw1YT0jO
	/guR6JWAcOu2qSqxR+vEgYx3bZ2lhiDrlo1czBrW9qaCfbesvOxUp0B9s086teO22CUBEPSB3W/
	AhP7V1qP6HGEczwsYgTGw8tI+dtQWHcFvkpVXDz1xHrjIwtiTcxQMDuUGpiVk4qlagvTV+48scP
	94tcrL
X-Google-Smtp-Source: AGHT+IEtPrhDeW0wahv0In2Bn/KBbsY/3rfQKc3W0cZhp3X1y4iWQbsnjGF1Yduc3EgrYDEXsKL9GQ==
X-Received: by 2002:a17:902:e84f:b0:269:aba9:ffd7 with SMTP id d9443c01a7336-29091bbf9b4mr28791115ad.25.1760585940478;
        Wed, 15 Oct 2025 20:39:00 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343065sm12507925ad.26.2025.10.15.20.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:39:00 -0700 (PDT)
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
Subject: [PATCHv5 net-next 3/4] team: use common function to compute the features
Date: Thu, 16 Oct 2025 03:38:27 +0000
Message-ID: <20251016033828.59324-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016033828.59324-1-liuhangbin@gmail.com>
References: <20251016033828.59324-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new helper netdev_compute_upper_features() to compute the
team device features. This helper performs both the feature computation
and the netdev_change_features() call.

Note that such change replace the lower layer traversing currently done
using team->port_list with netdev_for_each_lower_dev(). Such change is
safe as `port_list` contains exactly the same elements as
`team->dev->adj_list.lower` and the helper is always invoked under the
RTNL lock.

With this change, the explicit netdev_change_features() in team_add_slave()
can be safely removed, as team_port_add() already takes care of the
notification via netdev_compute_upper_features(), and same thing for
team_del_slave()

This also fixes missing computations for MPLS, XFRM, and TSO/GSO partial
features.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/team/team_core.c | 83 +++---------------------------------
 1 file changed, 6 insertions(+), 77 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 17f07eb0ee52..2e92dd24f84b 100644
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
+	netdev_compute_upper_features(team->dev, true);
 	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
 	__team_options_change_check(team);
 
@@ -1382,7 +1325,7 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
 	dev_set_mtu(port_dev, port->orig.mtu);
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
-	__team_compute_features(team);
+	netdev_compute_upper_features(team->dev, true);
 
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
+	dev->hw_features = UPPER_DEV_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER |
 			   NETIF_F_HW_VLAN_STAG_RX |
@@ -2994,7 +2923,7 @@ static int team_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
 			port->team->notifier_ctx = true;
-			team_compute_features(port->team);
+			netdev_compute_upper_features(port->team->dev, true);
 			port->team->notifier_ctx = false;
 		}
 		break;
-- 
2.50.1

