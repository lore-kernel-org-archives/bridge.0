Return-Path: <menglong8.dong@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OdOYvLKaoSgVaZejaz21ew2EF1idBOpu4EgqrpcWnb4=;
 b=HhFwKGeoVFs0hdiatK077VZ4s6B/4MfW+deARy0QD5c0MMKl0X5NPTMoCcLxWesLJC
 I82426ijG3cvoS8mdIRVftoXwhuY3Y8KXn/RyuJwbDxoPEPJUrIuWClOqR5UbdRBAsh8
 qEJb/5kRlgSwWvXrb2dxwBDUrWwvv1zsKaXhZMMiCMhnJAwdAbOCiWELAwwhMCixvmf0
 aEe9IazlXyWoyDnTEAs9Wu0Cj9lPhhLG3dhJYDMjN73AmFDc07y9JtgkiL2CxGV3Q3Or
 W3AxWOJISUIpirdvnk1uzrWMGsNybumRuJekmfPoqe2a1dwIoGZ58tiTYaTivfLL4wd4
 ZQpg==
From: menglong8.dong@gmail.com
Date: Wed, 13 Jan 2021 23:51:01 -0800
Message-Id: <20210114075101.6501-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: use eth_type_vlan in
	br_dev_queue_push_xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: kuba@kernel.org
Cc: Menglong Dong <dong.menglong@zte.com.cn>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, davem@davemloft.net

From: Menglong Dong <dong.menglong@zte.com.cn>

Replace the check for ETH_P_8021Q and ETH_P_8021AD in
br_dev_queue_push_xmit with eth_type_vlan.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 net/bridge/br_forward.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index e28ffadd1371..6e9b049ae521 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -39,8 +39,7 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
 	br_drop_fake_rtable(skb);
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (skb->protocol == htons(ETH_P_8021Q) ||
-	     skb->protocol == htons(ETH_P_8021AD))) {
+	    eth_type_vlan(skb->protocol)) {
 		int depth;
 
 		if (!__vlan_get_protocol(skb, skb->protocol, &depth))
-- 
2.25.1

