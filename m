Return-Path: <huangguobin4@huawei.com>
From: Huang Guobin <huangguobin4@huawei.com>
Date: Wed, 26 Jan 2022 11:36:38 +0800
Message-ID: <20220126033639.909340-1-huangguobin4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH 4.19 0/1] Fix UBSAN: undefined-behaviour in
	maybe_deliver
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, stable@vger.kernel.org

There is a syzkaller problem for Linux 4.19 last for over 1 year:
https://www.syzkaller.appspot.com/bug?id=288ae4752bb930c26369d675316de0310264ee34

Mainline patch 7d850abd5f4e(net: bridge: add support for port isolation)
introduces the BR_ISOLATED feature, a pair of ports with the BR_ISOLATED
option set cannot communicate with each other.
This feature applies only to ingress flow, not egress flow. However, the
function br_skb_isolated that checks if an interface is isolated will be
used not only for the ingress path, but also for the egress path.
Since Linux-4.19  not merge the mainline patch fd65e5a95d0838(net: bridge:
clear bridge's private skb space on xmit), the value of skb->cb is unde-
fined because it is not initialized. Therefore, checking 
BR_INPUT_SKB_CB(skb)->src_port_isolated on the egress path will access an
undefined value, resulting in an error in the judgment of br_skb_isolated.
UBSAN triggers an alarm by finding undefined
BR_INPUT_SKB_CB(skb)->src_port_isolated.
So cherry-pick mainline patch fd65e5a95d0838(net: bridge: clear bridge's
private skb space on xmit) to Linux 4.19 to fix it.

Nikolay Aleksandrov (1):
  net: bridge: clear bridge's private skb space on xmit

 net/bridge/br_device.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.25.1

