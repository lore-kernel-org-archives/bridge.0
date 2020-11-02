Return-Path: <menglong8.dong@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2sn9IlsAf/o9PWSnZUDacWvGJDMDAyE7jKOu80Z9/XQ=;
 b=NQ/gal9zzj2UqO3cAXsmHskedL493eGjFym6fPXH9qBstkQNuhYGfz/cumaLHhEwy5
 Q0lRD9kCA7ftBWsukFlgcPDc+FqT8IMRZSZO1/5f0lcStW8e8U+Y3l7EGiSzns7Aej0k
 IEz3QV61BRuLkPW+698vYxNtt3okkp/W2imR6Cjkr0flzsQg7WmhohibsRE5ebqGx2/2
 swHHF4uixV6q2Qu2iJSDAhp+Ucnskdcl/SFc9cmiPnNb6hdHPf74yxNcWgTllh+Q2In/
 njKUbFGis5ARnc2axQpcS1TyWxxZ7fZf/etN+/m1URj5yE54tbrL1S3OGxjZcPivRPST
 qGkA==
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon,  2 Nov 2020 22:38:28 +0800
Message-Id: <20201102143828.5286-1-menglong8.dong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] net: bridge: disable multicast while delete bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@nvidia.com
Cc: Menglong Dong <dong.menglong@zte.com.cn>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, kuba@kernel.org, davem@davemloft.net

From: Menglong Dong <dong.menglong@zte.com.cn>

This commit seems make no sense, as bridge is destroyed when
br_multicast_dev_del is called.

In commit b1b9d366028f
("bridge: move bridge multicast cleanup to ndo_uninit"), Xin Long
fixed the use-after-free panic in br_multicast_group_expired by
moving br_multicast_dev_del to ndo_uninit. However, that patch is
not applied to 4.4.X, and the bug exists.

Fix that bug by disabling multicast in br_multicast_dev_del for
4.4.X, and there is no harm for other branches.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 net/bridge/br_multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index eae898c3cff7..9992fdff2951 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3369,6 +3369,7 @@ void br_multicast_dev_del(struct net_bridge *br)
 	hlist_for_each_entry_safe(mp, tmp, &br->mdb_list, mdb_node)
 		br_multicast_del_mdb_entry(mp);
 	hlist_move_list(&br->mcast_gc_list, &deleted_head);
+	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
 	spin_unlock_bh(&br->multicast_lock);
 
 	br_multicast_gc(&deleted_head);
-- 
2.25.1

