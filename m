Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559992E1EE3
	for <bridge@lists.linux.dev>; Tue,  2 Sep 2025 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798007; cv=none; b=da0smoYloxBV2dp/fxYiTR4G5LSvi+20LACbq1U4bTq11ycBGrqs8wbeH37rZNQUT35ZMg4yRWBZWsL4wJOhZU0GDqAXFT3UrT+x84wa33FvSVodIYKhGXZFaPWP+OBL24wJRPCGZwI/Bof6rfeQowocYj+WXYomGiOyMIxH9+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798007; c=relaxed/simple;
	bh=fpxAMTh1DHFN9bdroAryNzz1TbRNMH5pMcaPuAnjYMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJApIpe9Hn2DALbTqksV6rH5mduybJgk4A5JBuIkLA72zLsM8TqdqmbLyaA3TpVhA7g190jNQtPo4+E0nzGX+0rxSGmcrIqo5DedGC2iWL1ylOOx6GfPB3+/8jPaQu9AdkWCjIuzm6SdP+isbc54S9UoAJnTT5Kae/i+DE+sas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7OZ2eqt; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7OZ2eqt"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32753ef4e33so3719254a91.0
        for <bridge@lists.linux.dev>; Tue, 02 Sep 2025 00:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756798005; x=1757402805; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6NPvT6bQ/Fm1Ox6j1QOMXLS7IgmyQZhMktUnB9yevI=;
        b=e7OZ2eqtuH/4vapM5ie78L0QLx1LRZRU6iXtIHM0OserD/spEP5RjEIVzh6Jgx5Y1c
         1c0jElczpuK+HkZnezo8lUpc6y6Ui0vtPWYsLLKyWyZPkNjcb6PmY4NpS5mY4wX9FA75
         bRVX+Bu5aRkSM/HFqu5JSx6oYfrRcr3Sl+RyiUw8f3WxlLVBBQgUoFrQZpR/e72vMJEv
         w2GHjbo9UHEUKi+8QQqfdZ8Q6x8pOKlDnvFPZv/FXU40pfN8FRh2dn36gIjT31V5hcww
         7BufkWouomroxQHyHPddDIDTwfdikziuiW5hvCmvwOlqRQJihDLr4Q5I/LWxucvK+A+l
         11vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756798005; x=1757402805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6NPvT6bQ/Fm1Ox6j1QOMXLS7IgmyQZhMktUnB9yevI=;
        b=XoUWyvGTga1i4JTy1IPs7jHRt4DOSlmJmF7dy9x/FWiQhnnQvEXTGzDyhVxSKQb95N
         UA7xO3MoTK3Q4yhfrMx+cx71+6vuY6wAaoLq+eIBGlYJwGxqDJ9NvBKFjjv0owI1dO1l
         mxjsGs8iDxTyXCTC5BR9Xoua3uXAU5HKyEDVPeB3+4Zht7kjvxifNHcYu2kZxdoE1a/x
         YTiEheKULyo2AwxlDNTDlocDyjU1DHqPzItZJnElNAGPlnTTks3TWwozs4VdYtE0e4w7
         Jv8K4vdvFrwWpd+N7i4y4TOK4Yw9ivM08eAFOKJHtWuVMlo3KVAapBbJGHe+XqpRBQ2q
         KDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO5DTL/otz+sYnExPVFLAtBNoG8HLdnDO+P1dtJp1XzDRX3mAJ5lDbJFs205CcRzDCvtqDOIw=@lists.linux.dev
X-Gm-Message-State: AOJu0YwcvDC7Lg9kC2lYnEcTyE7rZ1FzH/Km4RcZ0uB5El7kb4Na/qv9
	WkAZLA8qF9Z/cRWTcf524xkWA6MujjNhxo3miXyMEK47O/X4DjMa0HfB
X-Gm-Gg: ASbGncuNgbMFvWMC14QMVJeSjXDJRZ2vEuHFGSlI+0XOszzGFWcP9ls94JjRE7egSOA
	hDrmvljwDGmif+9RXKniLGkQPKqKX+SRNJRM6WnyWASj1OJpHVId3Ao91Gtjr9DKGEGVeSIMX/q
	sDgQIl56jLpeyn5SYxrfJdO/mXhMnP0NxYKlvK3T1NiQ8Z6vzxCPn4n8JNCUNfbT7ua3F8B5STL
	6zli5Bl59bZkvl7EIInpyebGPtKGOHxPwrUC8c8fiAVN0I1yC7HyNGGScjFAyc7JatJW9oneICI
	pRHuT1l4OtlWTXLQpd9I/nl46LwmdraXTHXNmMHU3RIsl13sMfkQCyeYOcW68hAGj2AjMXMX7Vq
	4pwfjGYsOwoIwg98CXYwbnKPSt7CuCEbuS2IQTquS4Q==
X-Google-Smtp-Source: AGHT+IGdU/ZAXvhK+gb4+6xvuoWstmZphUO60Sh4mLhsd+VaRlO2+ZRrPNUFkcLVJ4111t7W01Yt3g==
X-Received: by 2002:a17:90b:55c8:b0:314:2892:b1e0 with SMTP id 98e67ed59e1d1-328156e55d5mr13525247a91.34.1756798005409;
        Tue, 02 Sep 2025 00:26:45 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d9347189sm13416648a91.9.2025.09.02.00.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:26:45 -0700 (PDT)
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 3/5] team: use common function to compute the features
Date: Tue,  2 Sep 2025 07:26:00 +0000
Message-ID: <20250902072602.361122-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902072602.361122-1-liuhangbin@gmail.com>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
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

