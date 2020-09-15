Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=V0oVeorJEn639RUtHYFD9WKWaUEUtKz13YDNA91Zt1M=;
 b=VNhG4zHEKDWxe/WBUk+BEg4hHxxdD4aw6BHfCqYM/7+u34DRHtu5P7rDWDKRF2SXSG
 QMPOQmY3+CnpDK/dDjJuZUnqmSfll9zei2DQFzwzvr+/V1+KWrIKCMAGdVLEMCvjcrTW
 AkNEB8uwQqlPiEDzKCsgb+uIg8h0PscZzoBhE=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 15 Sep 2020 17:57:24 +0300
Message-Id: <20200915145724.2065042-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: mcast: don't ignore return
	value of __grp_src_toex_excl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

When we're handling TO_EXCLUDE report in EXCLUDE filter mode we should
not ignore the return value of __grp_src_toex_excl() as we'll miss
sending notifications about group changes.

Fixes: 5bf1e00b6849 ("net: bridge: mcast: support for IGMPV3/MLDv2 CHANGE_TO_INCLUDE/EXCLUDE report")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 33adf44ef7ec..e77f1e27caf7 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1710,7 +1710,7 @@ static bool br_multicast_toex(struct net_bridge_port_group *pg,
 		changed = true;
 		break;
 	case MCAST_EXCLUDE:
-		__grp_src_toex_excl(pg, srcs, nsrcs, src_size);
+		changed = __grp_src_toex_excl(pg, srcs, nsrcs, src_size);
 		break;
 	}
 
-- 
2.25.4

