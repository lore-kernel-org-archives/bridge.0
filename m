Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=VC0/CimE/xOlMXuj2ELK2tKueacQfl/vq/95FAdq/3w=;
	b=dN0Bw8efxNO9aR5kXsAvr/CDYjnL9kqUqA7WP3JtC38L8Pm2Kp4mlPXCNIjhnB08GW
	e7s6B9mhVx7J2cE96VSeDSFchE9Fkc2TjYykU1ekbaASYbRvKmPSWLbrABfVLQFNxWcP
	1+jyq1JgdroWrDuRF1OErP9UG/IyhZYDihNQM=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat, 16 Dec 2017 13:31:36 +0200
Message-Id: <1513423896-30294-1-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <73a472e3-e521-1930-0643-a6f2714db6ce@cumulusnetworks.com>
References: <73a472e3-e521-1930-0643-a6f2714db6ce@cumulusnetworks.com>
Subject: [Bridge] [PATCH net] net: bridge: fix early call to
	br_stp_change_bridge_id
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, avagin@gmail.com, davem@davemloft.net

The early call to br_stp_change_bridge_id in bridge's newlink can cause
a memory leak if an error occurs during the newlink because the fdb
entries are not cleaned up if a different lladdr was specified, also
another minor issue is that it generates fdb notifications with
ifindex = 0. To remove this special case the call is done after netdev
register and we cleanup any bridge fdb entries on changelink error.
That also doesn't slow down normal bridge removal, alternative is to call
it in its ndo_uninit.

To reproduce the issue:
$ ip l add br0 address 00:11:22:33:44:55 type bridge group_fwd_mask 1
RTNETLINK answers: Invalid argument

$ rmmod bridge
[ 1822.142525] =============================================================================
[ 1822.143640] BUG bridge_fdb_cache (Tainted: G           O    ): Objects remaining in bridge_fdb_cache on __kmem_cache_shutdown()
[ 1822.144821] -----------------------------------------------------------------------------

[ 1822.145990] Disabling lock debugging due to kernel taint
[ 1822.146732] INFO: Slab 0x0000000092a844b2 objects=32 used=2 fp=0x00000000fef011b0 flags=0x1ffff8000000100
[ 1822.147700] CPU: 2 PID: 13584 Comm: rmmod Tainted: G    B      O     4.15.0-rc2+ #87
[ 1822.148578] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-20140531_083030-gandalf 04/01/2014
[ 1822.150008] Call Trace:
[ 1822.150510]  dump_stack+0x78/0xa9
[ 1822.151156]  slab_err+0xb1/0xd3
[ 1822.151834]  ? __kmalloc+0x1bb/0x1ce
[ 1822.152546]  __kmem_cache_shutdown+0x151/0x28b
[ 1822.153395]  shutdown_cache+0x13/0x144
[ 1822.154126]  kmem_cache_destroy+0x1c0/0x1fb
[ 1822.154669]  SyS_delete_module+0x194/0x244
[ 1822.155199]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[ 1822.155773]  entry_SYSCALL_64_fastpath+0x23/0x9a
[ 1822.156343] RIP: 0033:0x7f929bd38b17
[ 1822.156859] RSP: 002b:00007ffd160e9a98 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
[ 1822.157728] RAX: ffffffffffffffda RBX: 00005578316ba090 RCX: 00007f929bd38b17
[ 1822.158422] RDX: 00007f929bd9ec60 RSI: 0000000000000800 RDI: 00005578316ba0f0
[ 1822.159114] RBP: 0000000000000003 R08: 00007f929bff5f20 R09: 00007ffd160e8a11
[ 1822.159808] R10: 00007ffd160e9860 R11: 0000000000000202 R12: 00007ffd160e8a80
[ 1822.160513] R13: 0000000000000000 R14: 0000000000000000 R15: 00005578316ba090
[ 1822.161278] INFO: Object 0x000000007645de29 @offset=0
[ 1822.161666] INFO: Object 0x00000000d5df2ab5 @offset=128

Fixes: a4b816d8ba1c ("bridge: Change local fdb entries whenever mac address of bridge device changes")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
Consequently this also would fix the null ptr deref due to the rhashtable
not being initialized in net-next when br_stp_change_bridge_id is called.

Toshiaki, any reason you called br_stp_change_bridge_id before
register_netdevice when you introduced it in 30313a3d5794 ?

 net/bridge/br_netlink.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index d0ef0a8e8831..b0362cadb7c8 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1262,19 +1262,23 @@ static int br_dev_newlink(struct net *src_net, struct net_device *dev,
 	struct net_bridge *br = netdev_priv(dev);
 	int err;
 
+	err = register_netdevice(dev);
+	if (err)
+		return err;
+
 	if (tb[IFLA_ADDRESS]) {
 		spin_lock_bh(&br->lock);
 		br_stp_change_bridge_id(br, nla_data(tb[IFLA_ADDRESS]));
 		spin_unlock_bh(&br->lock);
 	}
 
-	err = register_netdevice(dev);
-	if (err)
-		return err;
-
 	err = br_changelink(dev, tb, data, extack);
-	if (err)
+	if (err) {
+		/* clean possible fdbs from br_stp_change_bridge_id above */
+		br_fdb_delete_by_port(br, NULL, 0, 1);
 		unregister_netdevice(dev);
+	}
+
 	return err;
 }
 
-- 
2.1.4

