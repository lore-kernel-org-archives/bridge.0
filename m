Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=hVVFhf2/dXPU9lHzMmVpd2Vt9v+qbc236IgSLwvvuTE=;
	b=DrgyNlUlpTwj+aUnCh9ZHfmIH6f6wlChOrsy9In7RBGXlAwYBFAjKhenQ0XCCxAMbQXFzS+VvD/JdvtNWztJ0wg1ixoyEqrLMhwEY3iNYw2HXoAf/hL6KL2RPwlrJyGIS8NLicTc6EFWM6UKEr5rfpKlkA/pv1qQyaZsfOrygeQ=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 17 Oct 2018 08:53:20 +0000
Message-ID: <20181017085215.26607-12-idosch@mellanox.com>
References: <20181017085215.26607-1-idosch@mellanox.com>
In-Reply-To: <20181017085215.26607-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 11/18] net: Add netif_is_vxlan()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, mlxsw <mlxsw@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Add the ability to determine whether a netdev is a VxLAN netdev by
calling the above mentioned function that checks the netdev's
rtnl_link_ops.

This will allow modules to identify netdev events involving a VxLAN
netdev and act accordingly. For example, drivers capable of VxLAN
offload will need to configure the underlying device when a VxLAN netdev
is being enslaved to an offloaded bridge.

Convert nfp to use the newly introduced helper.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c | 3 ++-
 include/net/vxlan.h                                     | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/driv=
ers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 30c926c4bc47..8e5bec04d1f9 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -4,6 +4,7 @@
 #include <linux/etherdevice.h>
 #include <linux/inetdevice.h>
 #include <net/netevent.h>
+#include <net/vxlan.h>
 #include <linux/idr.h>
 #include <net/dst_metadata.h>
 #include <net/arp.h>
@@ -187,7 +188,7 @@ static bool nfp_tun_is_netdev_to_offload(struct net_dev=
ice *netdev)
 		return false;
 	if (!strcmp(netdev->rtnl_link_ops->kind, "openvswitch"))
 		return true;
-	if (!strcmp(netdev->rtnl_link_ops->kind, "vxlan"))
+	if (netif_is_vxlan(netdev))
 		return true;
=20
 	return false;
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index dd3d72ce64b6..95227fa925e8 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -5,6 +5,7 @@
 #include <linux/if_vlan.h>
 #include <net/udp_tunnel.h>
 #include <net/dst_metadata.h>
+#include <net/rtnetlink.h>
=20
 /* VXLAN protocol (RFC 7348) header:
  * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
@@ -402,4 +403,10 @@ static inline bool vxlan_addr_multicast(const union vx=
lan_addr *ipa)
=20
 #endif /* IS_ENABLED(CONFIG_IPV6) */
=20
+static inline bool netif_is_vxlan(const struct net_device *dev)
+{
+	return dev->rtnl_link_ops &&
+	       !strcmp(dev->rtnl_link_ops->kind, "vxlan");
+}
+
 #endif
--=20
2.17.2

