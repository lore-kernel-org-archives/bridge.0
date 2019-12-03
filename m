Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1JlQBMxxT3n3gAP2JXiQSbnDJJNfheSAcd5t6AqVGSo=;
 b=ZNiepIuLIrtejAWnmFt5t5qitJU02H4vfzlitq8/B/tjRfr3LDvPFFcJedFPx4QBj4
 lR9ECyCtLEfeXUwSAaC0s9+RJwXzI8+eRhLfOQF2EGiFfT26AgqdP7Eh6fJCwbAYuzKg
 ZGevXGPdnqQ1mOo+pkzDA+h/Z8Yf+kcd0D9hI=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue,  3 Dec 2019 16:48:06 +0200
Message-Id: <20191203144806.10468-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: deny dev_set_mac_address() when
	unregistering
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, syzbot+2add91c08eb181fea1bf@syzkaller.appspotmail.com, davem@davemloft.net

We have an interesting memory leak in the bridge when it is being
unregistered and is a slave to a master device which would change the
mac of its slaves on unregister (e.g. bond, team). This is a very
unusual setup but we do end up leaking 1 fdb entry because
dev_set_mac_address() would cause the bridge to insert the new mac address
into its table after all fdbs are flushed, i.e. after dellink() on the
bridge has finished and we call NETDEV_UNREGISTER the bond/team would
release it and will call dev_set_mac_address() to restore its original
address and that in turn will add an fdb in the bridge.
One fix is to check for the bridge dev's reg_state in its
ndo_set_mac_address callback and return an error if the bridge is not in
NETREG_REGISTERED.

Easy steps to reproduce:
 1. add bond in mode != A/B
 2. add any slave to the bond
 3. add bridge dev as a slave to the bond
 4. destroy the bridge device

Trace:
 unreferenced object 0xffff888035c4d080 (size 128):
   comm "ip", pid 4068, jiffies 4296209429 (age 1413.753s)
   hex dump (first 32 bytes):
     41 1d c9 36 80 88 ff ff 00 00 00 00 00 00 00 00  A..6............
     d2 19 c9 5e 3f d7 00 00 00 00 00 00 00 00 00 00  ...^?...........
   backtrace:
     [<00000000ddb525dc>] kmem_cache_alloc+0x155/0x26f
     [<00000000633ff1e0>] fdb_create+0x21/0x486 [bridge]
     [<0000000092b17e9c>] fdb_insert+0x91/0xdc [bridge]
     [<00000000f2a0f0ff>] br_fdb_change_mac_address+0xb3/0x175 [bridge]
     [<000000001de02dbd>] br_stp_change_bridge_id+0xf/0xff [bridge]
     [<00000000ac0e32b1>] br_set_mac_address+0x76/0x99 [bridge]
     [<000000006846a77f>] dev_set_mac_address+0x63/0x9b
     [<00000000d30738fc>] __bond_release_one+0x3f6/0x455 [bonding]
     [<00000000fc7ec01d>] bond_netdev_event+0x2f2/0x400 [bonding]
     [<00000000305d7795>] notifier_call_chain+0x38/0x56
     [<0000000028885d4a>] call_netdevice_notifiers+0x1e/0x23
     [<000000008279477b>] rollback_registered_many+0x353/0x6a4
     [<0000000018ef753a>] unregister_netdevice_many+0x17/0x6f
     [<00000000ba854b7a>] rtnl_delete_link+0x3c/0x43
     [<00000000adf8618d>] rtnl_dellink+0x1dc/0x20a
     [<000000009b6395fd>] rtnetlink_rcv_msg+0x23d/0x268

Fixes: 43598813386f ("bridge: add local MAC address to forwarding table (v2)")
Reported-by: syzbot+2add91c08eb181fea1bf@syzkaller.appspotmail.com
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
An alternative is to move the fdb flush to br_dev_uninit() but that
would ruin the symmetry with br_dev_init(). Since this is an extremely
unlikely case I think this fix is safer and easier for backports.

 net/bridge/br_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 434effde02c3..539d55baae78 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -245,6 +245,12 @@ static int br_set_mac_address(struct net_device *dev, void *p)
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
+	/* dev_set_mac_addr() can be called by a master device on bridge's
+	 * NETDEV_UNREGISTER, but since it's being destroyed do nothing
+	 */
+	if (dev->reg_state != NETREG_REGISTERED)
+		return -EBUSY;
+
 	spin_lock_bh(&br->lock);
 	if (!ether_addr_equal(dev->dev_addr, addr->sa_data)) {
 		/* Mac address will be changed in br_stp_change_bridge_id(). */
-- 
2.21.0

