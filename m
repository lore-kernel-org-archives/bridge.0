Return-Path: <bpoirier@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgrXuCotWpenuvOgBO5s0mNNruBAafldw+RETouHM3I=;
 b=DmkKdXIjQWnuuWJRf7VxLSxUoquFTit4NmLQNezkM9CXNCLoWpwdvo9Hn5oSQ8+r2wc0mHqZ2H8Y3PNzRf2TTv6TXwfWcDjYTLHF3lhEZ56uyXjx2zCAwSAWfShwMbLD4Eik+K3QqWVJdnQR00LzGV/pmYwY+mLdhyZMo5Iall/Cr8LpabRWrB1MYFNawi+UUC+2MTiuXBTUdZceC3a0Jyx0y5aq/m52kqzrac2uvGF7nlUkrfR2MZP3qz6k79RTI46b9bIViCtrVvZjuRUbbwnIgLufAuVCGqrTSn5WVtfFsXZkWSVRIkLc1EW3d7deH8YfDhAr+ioAG1aLSf9New==
From: Benjamin Poirier <bpoirier@nvidia.com>
Date: Tue, 25 Jan 2022 15:19:03 +0900
Message-ID: <20220125061903.714509-1-bpoirier@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net] net: bridge: vlan: Fix dumping with ifindex
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Roopa Prabhu <roopa@nvidia.com>

Specifying ifindex in a RTM_GETVLAN dump leads to an infinite repetition
of the same entries. netlink_dump() normally calls the dump function
repeatedly until it returns 0 which br_vlan_rtm_dump() never does in
that case.

Fixes: 8dcea187088b ("net: bridge: vlan: add rtm definitions and dump support")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 net/bridge/br_vlan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

The problem can be reproduced by using the following iproute2 patch and
running:
ip link add br0 type bridge
ip link add dummy0 master br0 type dummy
bridge vlan add dev dummy0 vid 100

./bridge/bridge -d vlan show dev dummy0
[infinite loop]

	diff --git a/bridge/vlan.c b/bridge/vlan.c
	index 8300f353..f206a671 100644
	--- a/bridge/vlan.c
	+++ b/bridge/vlan.c
	@@ -1128,7 +1128,8 @@ static int vlan_show(int argc, char **argv, int subject)
		if (show_details && subject == VLAN_SHOW_VLAN) {
			__u32 dump_flags = show_stats ? BRIDGE_VLANDB_DUMPF_STATS : 0;
	 
	-		if (rtnl_brvlandump_req(&rth, PF_BRIDGE, dump_flags) < 0) {
	+		if (rtnl_brvlandump_req(&rth, PF_BRIDGE, dump_flags,
	+					filter_index) < 0) {
				perror("Cannot send dump request");
				exit(1);
			}
	@@ -1240,7 +1241,8 @@ static int vlan_global_show(int argc, char **argv)
	 
		new_json_obj(json);
	 
	-	if (rtnl_brvlandump_req(&rth, PF_BRIDGE, dump_flags) < 0) {
	+	if (rtnl_brvlandump_req(&rth, PF_BRIDGE, dump_flags, filter_index)
	+	    < 0) {
			perror("Cannot send dump request");
			exit(1);
		}
	diff --git a/include/libnetlink.h b/include/libnetlink.h
	index 9e4cc101..276b7fbf 100644
	--- a/include/libnetlink.h
	+++ b/include/libnetlink.h
	@@ -69,7 +69,8 @@ int rtnl_neightbldump_req(struct rtnl_handle *rth, int family)
		__attribute__((warn_unused_result));
	 int rtnl_mdbdump_req(struct rtnl_handle *rth, int family)
		__attribute__((warn_unused_result));
	-int rtnl_brvlandump_req(struct rtnl_handle *rth, int family, __u32 dump_flags)
	+int rtnl_brvlandump_req(struct rtnl_handle *rth, int family, __u32 dump_flags,
	+			int ifindex)
		__attribute__((warn_unused_result));
	 int rtnl_netconfdump_req(struct rtnl_handle *rth, int family)
		__attribute__((warn_unused_result));
	diff --git a/lib/libnetlink.c b/lib/libnetlink.c
	index 7e977a67..e0fce8e5 100644
	--- a/lib/libnetlink.c
	+++ b/lib/libnetlink.c
	@@ -450,7 +450,8 @@ int rtnl_mdbdump_req(struct rtnl_handle *rth, int family)
		return send(rth->fd, &req, sizeof(req), 0);
	 }
	 
	-int rtnl_brvlandump_req(struct rtnl_handle *rth, int family, __u32 dump_flags)
	+int rtnl_brvlandump_req(struct rtnl_handle *rth, int family, __u32 dump_flags,
	+			int ifindex)
	 {
		struct {
			struct nlmsghdr nlh;
	@@ -462,6 +463,7 @@ int rtnl_brvlandump_req(struct rtnl_handle *rth, int family, __u32 dump_flags)
			.nlh.nlmsg_flags = NLM_F_DUMP | NLM_F_REQUEST,
			.nlh.nlmsg_seq = rth->dump = ++rth->seq,
			.bvm.family = family,
	+		.bvm.ifindex = ifindex,
		};
	 
		addattr32(&req.nlh, sizeof(req), BRIDGE_VLANDB_DUMP_FLAGS, dump_flags);
	-- 

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 84ba456a78cc..2e606f2b9a4d 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -2013,7 +2013,7 @@ static int br_vlan_rtm_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		dump_flags = nla_get_u32(dtb[BRIDGE_VLANDB_DUMP_FLAGS]);
 
 	rcu_read_lock();
-	if (bvm->ifindex) {
+	if (bvm->ifindex && !s_idx) {
 		dev = dev_get_by_index_rcu(net, bvm->ifindex);
 		if (!dev) {
 			err = -ENODEV;
@@ -2022,7 +2022,9 @@ static int br_vlan_rtm_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		err = br_vlan_dump_dev(dev, skb, cb, dump_flags);
 		if (err && err != -EMSGSIZE)
 			goto out_err;
-	} else {
+		else if (!err)
+			idx++;
+	} else if (!bvm->ifindex) {
 		for_each_netdev_rcu(net, dev) {
 			if (idx < s_idx)
 				goto skip;
-- 
2.34.1

