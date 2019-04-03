Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=wbjytpqVM1azUm4OJXgXnJ449HyBBV7+wd2YY/jQrtc=;
	b=MbEV9pKkEAapyqDyJKEyPtg2W7cFz7UH6fbigeRBgj1hIg7Ylqom761nHCKIRd9G1U
	TlxJnxilN8MxdW6cjOkHAbmv859Vd8GWQDBPInE21iRb7u3OkQ8jHNV0RjnsnQTlB6SN
	N438QlK27ijDvWKZQ7jd4N5yII4+Y6+nvolec=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  3 Apr 2019 23:27:24 +0300
Message-Id: <20190403202724.9123-1-nikolay@cumulusnetworks.com>
In-Reply-To: <a1c19a63-a37e-2903-335a-0a4a73efb6b2@cumulusnetworks.com>
References: <a1c19a63-a37e-2903-335a-0a4a73efb6b2@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: always clear mcast matching
	struct on reports and leaves
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: liam.mcbirnie@boeing.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

We need to be careful and always zero the whole br_ip struct when it is
used for matching since the rhashtable change. This patch fixes all the
places which didn't properly clear it which in turn might've caused
mismatches.

Thanks for the great bug report with reproducing steps and bisection.

Steps to reproduce (from the bug report):
ip link add br0 type bridge mcast_querier 1
ip link set br0 up

ip link add v2 type veth peer name v3
ip link set v2 master br0
ip link set v2 up
ip link set v3 up
ip addr add 3.0.0.2/24 dev v3

ip netns add test
ip link add v1 type veth peer name v1 netns test
ip link set v1 master br0
ip link set v1 up
ip -n test link set v1 up
ip -n test addr add 3.0.0.1/24 dev v1

# Multicast receiver
ip netns exec test socat
UDP4-RECVFROM:5588,ip-add-membership=224.224.224.224:3.0.0.1,fork -

# Multicast sender
echo hello | nc -u -s 3.0.0.2 224.224.224.224 5588

Reported-by: liam.mcbirnie@boeing.com
Fixes: 19e3a9c90c53 ("net: bridge: convert multicast to generic rhashtable")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
I will cook a selftest for this as well.

 net/bridge/br_multicast.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index a0e369179f6d..02da21d771c9 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -601,6 +601,7 @@ static int br_ip4_multicast_add_group(struct net_bridge *br,
 	if (ipv4_is_local_multicast(group))
 		return 0;
 
+	memset(&br_group, 0, sizeof(br_group));
 	br_group.u.ip4 = group;
 	br_group.proto = htons(ETH_P_IP);
 	br_group.vid = vid;
@@ -1497,6 +1498,7 @@ static void br_ip4_multicast_leave_group(struct net_bridge *br,
 
 	own_query = port ? &port->ip4_own_query : &br->ip4_own_query;
 
+	memset(&br_group, 0, sizeof(br_group));
 	br_group.u.ip4 = group;
 	br_group.proto = htons(ETH_P_IP);
 	br_group.vid = vid;
@@ -1520,6 +1522,7 @@ static void br_ip6_multicast_leave_group(struct net_bridge *br,
 
 	own_query = port ? &port->ip6_own_query : &br->ip6_own_query;
 
+	memset(&br_group, 0, sizeof(br_group));
 	br_group.u.ip6 = *group;
 	br_group.proto = htons(ETH_P_IPV6);
 	br_group.vid = vid;
-- 
2.20.1

