Return-Path: <zahari.doychev@googlemail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=z0vJbgOulC6FzUOmFtiRWTecaPlHR64UPs574wmAzjY=;
	b=dDZcao0jVkLzfIQh8TahnBbJ+CoNNtczISoWPfegMpwwVU3kVjFQGFnpwdbzArdkP/
	55xWBmPLnfGN2cNozGVUHxr7/QEKUEiW3q4INiEUrEBNwT2gGwEc5aRkeRXOThqgtdEk
	SVSssT7QVbqeLAOjx2bgedXkajkST9sQxhRYakluAk/ybb+lqKpErj47ZCo19M8VwYGw
	OFWzizwkurpytBiQeT7Aus++d32VotL0U/lDfrlf0TcFOHEel1nf7aDPz9XWQVKN8pWO
	QiTATxt9TvO3LipwSXLMMKPncLLlafBSGMHfLjV1UGq6gku+v00Tk8Krb+8JWKJgPPYt
	23yQ==
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
Date: Sun, 13 Jan 2019 14:59:37 +0100
Message-Id: <20190113135939.8970-1-zahari.doychev@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 0/2] net: bridge: fix tc added QinQ forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com
Cc: johannes@sipsolutions.net, zahari.doychev@linux.com, jhs@mojatatu.com

The Linux bridge seems to not correctly forward double vlan tagged packets
added using the tc vlan action. I am using a bridge with two netdevs and on one
of them a have the clsact qdisc with tc flower rule adding two vlan
tags.

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

When using the setup above the packets coming on net0 get double tagged but
the MAC headers gets corrupted when the packets go out of net1. It seems that
the second vlan header is not considered in br_dev_queue_push_xmit. The skb
data pointer is decremented only by the ethernet header length. This later
causes the function validate_xmit_vlan to insert the outer vlan tag behind
the inner vlan tag. The inner vlan becomes also part of the source mac address.

The first patch fixes the problem described above. The second one fixes
similar problem when the tpids of the bridge and the inserted vlan don't match.
It fixes again incorrect insertion of the skb vlan into the payload. The two
patches seem to fix the problem but I am not sure if this the right way to fix
this and if there is any other impact.

Zahari Doychev (2):
  net: bridge: fix tc added QinQ forwarding
  net: bridge: fix tc added vlan insert as payload

 net/bridge/br_forward.c | 2 +-
 net/bridge/br_vlan.c    | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.20.1

