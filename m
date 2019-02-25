Return-Path: <SRS0=mF0B=RA=linuxfoundation.org=gregkh@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130419;
	bh=vudtx12oHcq2Bp0tQq5lxNFVflGs+C9/eCjyPrrrM/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AoAvFro0mi1OhX7y0p3RmlE8pBYx00qfvw9TH9PyH4SODBiVX/RV9E4gkmTnYvtpD
	6h35S4AsAQSXemVSWn+sSgyS5yfIJIEVovhChV9dmVYiM+Epgg6KSHHqCeKL9oA7xK
	WCy5HjiL21kGKXRTxYGWutzOy4zaS29CP+mlYFKI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 25 Feb 2019 22:11:29 +0100
Message-Id: <20190225195114.133478058@linuxfoundation.org>
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 4.20 116/183] net: bridge: Mark FDB entries that
	were added by user as such
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>, Alexander Petrovskiy <alexpe@mellanox.com>, "David S. Miller" <davem@davemloft.net>

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 710ae72877378e7cde611efd30fe90502a6e5b30 ]

Externally learned entries can be added by a user or by a switch driver
that is notifying the bridge driver about entries that were learned in
hardware.

In the first case, the entries are not marked with the 'added_by_user'
flag, which causes switch drivers to ignore them and not offload them.

The 'added_by_user' flag can be set on externally learned FDB entries
based on the 'swdev_notify' parameter in br_fdb_external_learn_add(),
which effectively means if the created / updated FDB entry was added by
a user or not.

Fixes: 816a3bed9549 ("switchdev: Add fdb.added_by_user to switchdev notifications")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Alexander Petrovskiy <alexpe@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: bridge@lists.linux-foundation.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_fdb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e56ba3912a905..8b8abf88befbd 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1102,6 +1102,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			err = -ENOMEM;
 			goto err_unlock;
 		}
+		if (swdev_notify)
+			fdb->added_by_user = 1;
 		fdb->added_by_external_learn = 1;
 		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	} else {
@@ -1121,6 +1123,9 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			modified = true;
 		}
 
+		if (swdev_notify)
+			fdb->added_by_user = 1;
+
 		if (modified)
 			fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	}
-- 
2.19.1



