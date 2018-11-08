Return-Path: <mirq-linux@rere.qmqm.pl>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1541719028; bh=3wDeYD4VmsoLNLbqsekb+klJ4WktHlfpxdIiUmnFndM=;
	h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
	b=ReYwzfr38BuwpsfvT9Y+jXF9rErvgKxPev1TppuzV1RRcaDqiq0vyeVeSJINJY0v0
	35Z/ZHRXy6EGiVt5Hwa9tFu2+19CAZhz3lYTzQUQHq+56txZ7B31iuSqXiFzlw7Sm7
	+GO3PHuz9vbA9CFsP2iqt0JDuuJbOpBUXskbjGUS4rio5Iaj4OO0wuPW1amJnlrVfE
	42YfkbHFm/Agq4mgok+Km4BrDV9RyFi0gCLAO7lLuLS/G22h4L6IsALZB3H/mOSh3n
	HLBZceoVKMtZISQCDtWhKFvwn/dYdI1rJcNrJOpp5Nlk1nwO8ZDaP4NOLjYbxbmZ1i
	AoCyxK59OTR2g==
Date: Fri, 09 Nov 2018 00:18:06 +0100
Message-Id: <c929ec8c95554502038c34fc2045b04dbe49057b.1541718583.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 9/9] sky2: use __vlan_hwaccel helpers
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
 drivers/net/ethernet/marvell/sky2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 697d9b374f5e..c7cd0081058e 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -2485,13 +2485,11 @@ static struct sk_buff *receive_copy(struct sky2_port *sky2,
 		skb->ip_summed = re->skb->ip_summed;
 		skb->csum = re->skb->csum;
 		skb_copy_hash(skb, re->skb);
-		skb->vlan_proto = re->skb->vlan_proto;
-		skb->vlan_tci = re->skb->vlan_tci;
+		__vlan_hwaccel_copy_tag(skb, re->skb);
 
 		pci_dma_sync_single_for_device(sky2->hw->pdev, re->data_addr,
 					       length, PCI_DMA_FROMDEVICE);
-		re->skb->vlan_proto = 0;
-		re->skb->vlan_tci = 0;
+		__vlan_hwaccel_clear_tag(re->skb);
 		skb_clear_hash(re->skb);
 		re->skb->ip_summed = CHECKSUM_NONE;
 		skb_put(skb, length);
-- 
2.19.1

