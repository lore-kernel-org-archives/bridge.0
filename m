Return-Path: <mirq@rere.qmqm.pl>
Date: Wed, 16 Jan 2013 23:03:17 +0100
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Message-ID: <0897958c5d3142f4e0f0ddbb9709e1d017688e72.1358373119.1.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1358360289-23249-2-git-send-email-vyasevic@redhat.com>
Subject: Re: [Bridge] [PATCH net-next V6 01/14] vlan: wrap hw-acceleration
 calls in separate functions.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, shmulik.ladkani@gmail.com, shemminger@vyatta.com, davem@davemloft.net

(resend with proper To:)

> Wrap VLAN hardware acceleration calls into separate functions.  This way
> other code can re-use it.

Maybe instead of jumping aroung bugs that are easily fixed just don't
let them in? See untested patch below. Affected drivers can be either
fixed or have NETIF_F_HW_VLAN_FILTER removed from advertised features.

--cut-here--

net: disallow drivers with buggy VLAN accel to register_netdevice()

Signed-off-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
---
 net/8021q/vlan.c      |    7 -------
 net/8021q/vlan_core.c |    6 ++----
 net/core/dev.c        |    9 +++++++++
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index babfde9..addc578 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -117,19 +117,12 @@ void unregister_vlan_dev(struct net_device *dev, stru=
ct list_head *head)
 int vlan_check_real_dev(struct net_device *real_dev, u16 vlan_id)
 {
 	const char *name =3D real_dev->name;
-	const struct net_device_ops *ops =3D real_dev->netdev_ops;
=20
 	if (real_dev->features & NETIF_F_VLAN_CHALLENGED) {
 		pr_info("VLANs not supported on %s\n", name);
 		return -EOPNOTSUPP;
 	}
=20
-	if ((real_dev->features & NETIF_F_HW_VLAN_FILTER) &&
-	    (!ops->ndo_vlan_rx_add_vid || !ops->ndo_vlan_rx_kill_vid)) {
-		pr_info("Device %s has buggy VLAN hw accel\n", name);
-		return -EOPNOTSUPP;
-	}
-
 	if (vlan_find_dev(real_dev, vlan_id) !=3D NULL)
 		return -EEXIST;
=20
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 380440b..71b64fd 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -224,8 +224,7 @@ static int __vlan_vid_add(struct vlan_info *vlan_info, =
unsigned short vid,
 	if (!vid_info)
 		return -ENOMEM;
=20
-	if ((dev->features & NETIF_F_HW_VLAN_FILTER) &&
-	    ops->ndo_vlan_rx_add_vid) {
+	if (dev->features & NETIF_F_HW_VLAN_FILTER) {
 		err =3D  ops->ndo_vlan_rx_add_vid(dev, vid);
 		if (err) {
 			kfree(vid_info);
@@ -282,8 +281,7 @@ static void __vlan_vid_del(struct vlan_info *vlan_info,
 	unsigned short vid =3D vid_info->vid;
 	int err;
=20
-	if ((dev->features & NETIF_F_HW_VLAN_FILTER) &&
-	     ops->ndo_vlan_rx_kill_vid) {
+	if (dev->features & NETIF_F_HW_VLAN_FILTER) {
 		err =3D ops->ndo_vlan_rx_kill_vid(dev, vid);
 		if (err) {
 			pr_warn("failed to kill vid %d for device %s\n",
diff --git a/net/core/dev.c b/net/core/dev.c
index b6d2b32..f87cdc2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6211,6 +6211,15 @@ int register_netdevice(struct net_device *dev)
 		}
 	}
=20
+	if (((dev->hw_features & NETIF_F_HW_VLAN_FILTER) ||
+             (dev->features & NETIF_F_HW_VLAN_FILTER)) &&
+	    (!dev->netdev_ops->ndo_vlan_rx_add_vid ||
+	     !dev->netdev_ops->ndo_vlan_rx_kill_vid)) {
+		netdev_WARN(dev, "Buggy VLAN acceleration in driver!\n");
+		ret =3D -EINVAL;
+		goto err_uninit;
+	}
+
 	ret =3D -EBUSY;
 	if (!dev->ifindex)
 		dev->ifindex =3D dev_new_index(net);
--=20
1.7.10.4


----- End forwarded message -----
