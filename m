Return-Path: <mirq-linux@rere.qmqm.pl>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1541719024; bh=+SK+n9+g9d3vOxlKaffebdt4fu9Zy2ht+kS1MahY5MI=;
	h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
	b=AtpNDFNqf5ASYuFCuT7TrQyWDpOSVZZRmBXI/PeUZx/G6iHs4T+bqc9VQ/pLHz8nQ
	v00MpAGT+Iy2I8rTN4C4+pA4SreR+yn/Y2/4twoiZiMPq4OvO5Pj+kea5Rjk5fT+jR
	+KlYyydZ8Qx4/dXJXscZyjKweFHUCDZYYZLItXXDi3pnS9QLumj5nxR/FvE+/3j9vz
	wq6cmD+lWTKS2V6jSJda8qgV1evAFM0wPtaQTLVXHAhl/6YmcMLqLfYV4YDx5hgtMB
	IE7/52i6IYujDrE0yKePhbASSNdTvWLRxHtIzNjNnBlqBZ3HlbbCU/L6z2dxLTlQaf
	eysv8Xv55VaDQ==
Date: Fri, 09 Nov 2018 00:18:02 +0100
Message-Id: <af0443419646b8e53d794c7565c47f8dc9ef5d1a.1541718583.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/9] nfnetlink/queue: use __vlan_hwaccel
	helpers
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
 net/netfilter/nfnetlink_queue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 43041f087eb3..1ce30efe6854 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -1148,8 +1148,9 @@ static int nfqa_parse_bridge(struct nf_queue_entry *entry,
 		if (!tb[NFQA_VLAN_TCI] || !tb[NFQA_VLAN_PROTO])
 			return -EINVAL;
 
-		entry->skb->vlan_tci = ntohs(nla_get_be16(tb[NFQA_VLAN_TCI]));
-		entry->skb->vlan_proto = nla_get_be16(tb[NFQA_VLAN_PROTO]);
+		__vlan_hwaccel_put_tag(entry->skb,
+			nla_get_be16(tb[NFQA_VLAN_PROTO]),
+			ntohs(nla_get_be16(tb[NFQA_VLAN_TCI])));
 	}
 
 	if (nfqa[NFQA_L2HDR]) {
-- 
2.19.1

