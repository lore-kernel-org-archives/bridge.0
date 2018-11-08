Return-Path: <mirq-linux@rere.qmqm.pl>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1541719026; bh=Z+HNaM5fXyVuKUciR7QSnLsdYJK4FdXmDw4Sv4STP4I=;
	h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
	b=IouwOZhEURVgmCgVYXMvjKvX41KQpKfCuBLDv8+wUi7LGkRb1rO0kRGHPj4VkshZn
	eO1OS6l9+6qUiMxhh54jPLRqCs1mdpvjDKlwe/0O2EccRABJoYKY8On+omibR2I8/H
	0zWYokVTsV0FUps3v6GZNza/8h1HYwteulzOOVMIX8mLlHTnohbfJg8pPzU3SHh7cn
	LHl7paCWDDbIfE7I7oCoWvnfB4cP3g4d5ycQqu4ELenfYJVHC6BZ45KZMoQ/LbrndW
	GR3YOeOTXPeJsFtdX1EnCxlMKd/lDOLiISOZL3b5gieUdMfVQDVubUU7EEK9dn81Fe
	k/61gM58lIi1g==
Date: Fri, 09 Nov 2018 00:18:04 +0100
Message-Id: <d379d69c6b5a1079b13ff69c1efb17599dbdac94.1541718583.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 7/9] benet: use __vlan_hwaccel helpers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, coreteam@netfilter.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pablo Neira Ayuso <pablo@netfilter.org>, Jiri Pirko <jiri@resnulli.us>, Steve Wise <swise@chelsio.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Sathya Perla <sathya.perla@broadcom.com>, Cong Wang <xiyou.wangcong@gmail.com>, Mirko Lindner <mlindner@marvell.com>, Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@mellanox.com>

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index c5ad7a4f4d83..80b2bd3747ce 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1049,30 +1049,35 @@ static struct sk_buff *be_insert_vlan_in_pkt(struct be_adapter *adapter,
 					     struct be_wrb_params
 					     *wrb_params)
 {
+	bool insert_vlan = false;
 	u16 vlan_tag = 0;
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return skb;
 
-	if (skb_vlan_tag_present(skb))
+	if (skb_vlan_tag_present(skb)) {
 		vlan_tag = be_get_tx_vlan_tag(adapter, skb);
+		insert_vlan = true;
+	}
 
 	if (qnq_async_evt_rcvd(adapter) && adapter->pvid) {
-		if (!vlan_tag)
+		if (!insert_vlan) {
 			vlan_tag = adapter->pvid;
+			insert_vlan = true;
+		}
 		/* f/w workaround to set skip_hw_vlan = 1, informs the F/W to
 		 * skip VLAN insertion
 		 */
 		BE_WRB_F_SET(wrb_params->features, VLAN_SKIP_HW, 1);
 	}
 
-	if (vlan_tag) {
+	if (insert_vlan) {
 		skb = vlan_insert_tag_set_proto(skb, htons(ETH_P_8021Q),
 						vlan_tag);
 		if (unlikely(!skb))
 			return skb;
-		skb->vlan_tci = 0;
+		__vlan_hwaccel_clear_tag(skb);
 	}
 
 	/* Insert the outer VLAN, if any */
-- 
2.19.1

