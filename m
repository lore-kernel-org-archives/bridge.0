Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=pmLjGGIYEPK3evjW9Xbj2FZViZjFMFDbc8qOTmU8axg=;
	b=dCgPOR0Hb0CGldon2L7VePYxSPCh5gfRWjiPvpzkrsXLLGp6mF6EjQeqqschPn+oYm
	6lc4F+dvuId3cKO2T73OclFlzmP+nkZVvPQ0JSU9BUUru9cVQyr9VTQ+WUPiXa6KxfRY
	qn0nwORvv6VW0MWzzys+hfd9qvUN7+dtoZkyU=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 18 Feb 2019 14:21:07 +0200
Message-Id: <20190218122107.10097-1-nikolay@cumulusnetworks.com>
In-Reply-To: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC v2] net: bridge: don't flood known multicast traffic
	when snooping is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: f.fainelli@gmail.com, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@idosch.org

This is v2 of the RFC patch which aims to forward packets to known
mdsts' ports only (the no querier case). After v1 I've kept
the previous behaviour when it comes to unregistered traffic or when
a querier is present. All of this is of course only with snooping
enabled. So with this patch the following changes should occur:
 - No querier: forward known mdst traffic to its registered ports,
               no change about unknown mcast (flood)
 - Querier present: no change

The reason to do this is simple - we want to respect the user's mdb
configuration in both cases, that is if the user adds static mdb entries
manually then we should use that information about forwarding traffic.

What do you think ?

* Notes
Traffic that is currently marked as mrouters_only:
 - IPv4: non-local mcast traffic, igmp reports
 - IPv6: non-all-nodes-dst mcast traffic, mldv1 reports

Simple use case:
 $ echo 1 > /sys/class/net/bridge/bridge/multicast_snooping
 $ bridge mdb add dev bridge port swp1 grp 239.0.0.1
 - without a querier currently traffic for 239.0.0.1 will still be flooded,
   with this change it will be forwarded only to swp1

Ido, I know this doesn't solve the issue you brought up, maybe we should
have a separate discussion about acting on querier changes in the switch
driver or alternative solutions (e.g. always-flood-unknown-mcast knob).
Perhaps the bridge can notify the drivers on querier state changes.

This patch is meant about discussing the best way to solve the issue,
it's not thoroughly tested, in case we settle about the details I'll run
more tests.

Thanks,

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_device.c | 5 +++--
 net/bridge/br_input.c  | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 013323b6dbe4..e8c01409a7e7 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -96,8 +96,9 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 
 		mdst = br_mdb_get(br, skb, vid);
-		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(br, eth_hdr(skb)))
+		if (mdst ||
+		    (BR_INPUT_SKB_CB_MROUTERS_ONLY(skb) &&
+		     br_multicast_querier_exists(br, eth_hdr(skb))))
 			br_multicast_flood(mdst, skb, false, true);
 		else
 			br_flood(br, skb, BR_PKT_MULTICAST, false, true);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 5ea7e56119c1..8777566f7b6d 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -136,8 +136,9 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	switch (pkt_type) {
 	case BR_PKT_MULTICAST:
 		mdst = br_mdb_get(br, skb, vid);
-		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(br, eth_hdr(skb))) {
+		if (mdst ||
+		    (BR_INPUT_SKB_CB_MROUTERS_ONLY(skb) &&
+		     br_multicast_querier_exists(br, eth_hdr(skb)))) {
 			if ((mdst && mdst->host_joined) ||
 			    br_multicast_is_router(br)) {
 				local_rcv = true;
-- 
2.20.1

