From: Vlad Drukker <vlad@storewiz.com>
In-Reply-To: <20050921.001427.27575173.davem@davemloft.net>
References: <1127239659.12488.26.camel@quant>
	<20050921.001427.27575173.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Sep 2005 15:53:06 +0300
Message-Id: <1127307186.15678.63.camel@quant>
Mime-Version: 1.0
Subject: [Bridge] Re: [PATCH] TSO fix in br_dev_queue_push_xmit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>, ";Henrik Nordstrom" <hno@marasystems.com>, ";David S. Miller" <davem@davemloft.net>
Cc: bridge@osdl.org

Hi,

I see you all agree to apply :)

Stephen, repost of this patch to proper places below.

Thank you Henrik for clarification of bridge standard.
However, silent drop of locally generated packets on 99% idle carrier
grade machine looks like a hardware problem.

David, don't you think that having software packet drop counters is a
bad idea? I thought, software drop counters are there to help identify
hardware problems or lack of resources. In this case, tcp stack produced
output that just gone. TSO is there over years and no one even noticed
given TSO/bridge conflict mainly because there is no stats. (IMHO)
Let's blame standards, right? 


Signed-off-by : Vlad Drukker <vlad@storewiz.com>
---
 net/bridge/br_forward.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -31,7 +31,8 @@ static inline int should_deliver(const s

 int br_dev_queue_push_xmit(struct sk_buff *skb)
 {
-       if (skb->len > skb->dev->mtu)
+       /* drop mtu oversized packets except tso */
+       if (skb->len > skb->dev->mtu && !skb_shinfo(skb)->tso_size)
                kfree_skb(skb);
        else {
 #ifdef CONFIG_BRIDGE_NETFILTER

