Return-Path: <zahari.doychev@googlemail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=dp8fY7I/cUA9YKTm7Z0PYvdeVxhrHcb6x1m2fe9cmWU=;
	b=kMIieJdZas8PCq8eulzcYfD0E/uIyfFy2JEisZ0dwhXMrCxHdWRLN87IzEETAOmyA/
	kit3xFHWHVeQGjPQHvR4OKl3jN2Kx0jHiJmRa2qofUhlpVVpskyAtHcpzOrAzmZ9+WhO
	1PPXMXVImJNuUqmDP72fEDNQh7Ks1qwUlQVKSgw5xPPIvVu8aKIEvlWafT7lphYIjLIx
	AlzRjNGEhNwqlXwp+XD23ssJX1Va6YMetD9P+IznMjETUXfYuSH94QLwKS1cUGEhIUpE
	8qwFJYTjxwpdglvsKzp2UrWvg86w2hN8BfvpDPAH+QQIyxjSbNHB/2IcPMRtjiUYTOBk
	DBhg==
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
Date: Wed, 13 Feb 2019 20:51:02 +0100
Message-Id: <20190213195102.1917-1-zahari.doychev@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC PATCH] net act_vlan: use correct len in skb_pull
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, makita.toshiaki@lab.ntt.co.jp, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, jhs@mojatatu.com, jiri@resnulli.us, xiyou.wangcong@gmail.com
Cc: johannes@sipsolutions.net, zahari.doychev@linux.com

The bridge and VLAN code expects that skb->data points to the start of the
VLAN header instead of the next (network) header. Currently after
tcf_vlan_act() on ingress filter skb->data points to the next network
header. In this case the Linux bridge does not forward correctly double
tagged VLAN packets added using tc vlan action as the outer vlan tag from
the skb is inserted at the wrong offset after the vlan tag in the payload.
Making skb->data to point to the VLAN header in tcf_vlan_act() by using
ETH_HLEN in skb_pull_rcsum() fixes the problem.

The following commands were used for testing:

ip link add name br0 type bridge vlan_filtering 1
ip link set dev br0 up

ip link set dev net0 up
ip link set dev net0 master br0

ip link set dev net1 up
ip link set dev net1 master br0

bridge vlan add dev net0 vid 100 master
bridge vlan add dev br0 vid 100 self
bridge vlan add dev net1 vid 100 master

tc qdisc add dev net0 handle ffff: clsact
tc qdisc add dev net1 handle ffff: clsact

tc filter add dev net0 ingress pref 1 protocol all flower \
                  action vlan push id 10 pipe action vlan push id 100

tc filter add dev net0 egress pref 1 protocol 802.1q flower \
                  vlan_id 100 vlan_ethtype 802.1q cvlan_id 10 \
                  action vlan pop pipe action vlan pop

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
---
 net/sched/act_vlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 93fdaf707313..308d7d89f925 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -86,7 +86,7 @@ static int tcf_vlan_act(struct sk_buff *skb, const struct tc_action *a,
 
 out:
 	if (skb_at_tc_ingress(skb))
-		skb_pull_rcsum(skb, skb->mac_len);
+		skb_pull_rcsum(skb, ETH_HLEN);
 
 	return action;
 
-- 
2.20.1

