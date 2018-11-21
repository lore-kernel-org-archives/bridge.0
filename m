Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=f5XQHhHepRHrn5X/rFzXWlGPsxW1OlMswrAS+foPKkc=;
	b=MVJNxODZJ8CF1+H0FAkvUP2LcQF8huwFjNpMyuQQlEceP00H7rtCJ8DiirSLlH64TZuqF1y3P2eamJ+8VgAX4rMrtgkZkC0b3JWn7J2+BA6R+T+huAX0L4yzThL4VG8jGUfffwScnmDRbo22Eo1mf7DVid09Pu3Ic+mygcIAIIE=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:40 +0000
Message-ID: <20181121080141.16676-7-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 06/16] vxlan: Allow changing ageing time
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, Ido Schimmel <idosch@mellanox.com>, mlxsw <mlxsw@mellanox.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

In a similar fashion to the bridge device, allow changing the ageing
time of the VxLAN device by scheduling its timer to fire if the ageing
time changed.

One use case is selftests where learning / ageing of VxLAN FDB entries
is tested. The default ageing time is 5 minutes, which is too long for a
simple selftest.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/vxlan.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 03ba1b56ba6d..911066299a83 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -3458,11 +3458,8 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct=
 nlattr *data[],
 		conf->flags |=3D VXLAN_F_LEARN;
 	}
=20
-	if (data[IFLA_VXLAN_AGEING]) {
-		if (changelink)
-			return -EOPNOTSUPP;
+	if (data[IFLA_VXLAN_AGEING])
 		conf->age_interval =3D nla_get_u32(data[IFLA_VXLAN_AGEING]);
-	}
=20
 	if (data[IFLA_VXLAN_PROXY]) {
 		if (changelink)
@@ -3607,6 +3604,7 @@ static int vxlan_changelink(struct net_device *dev, s=
truct nlattr *tb[],
 {
 	struct vxlan_dev *vxlan =3D netdev_priv(dev);
 	struct vxlan_rdst *dst =3D &vxlan->default_dst;
+	unsigned long old_age_interval;
 	struct vxlan_rdst old_dst;
 	struct vxlan_config conf;
 	struct vxlan_fdb *f =3D NULL;
@@ -3617,12 +3615,16 @@ static int vxlan_changelink(struct net_device *dev,=
 struct nlattr *tb[],
 	if (err)
 		return err;
=20
+	old_age_interval =3D vxlan->cfg.age_interval;
 	memcpy(&old_dst, dst, sizeof(struct vxlan_rdst));
=20
 	err =3D vxlan_dev_configure(vxlan->net, dev, &conf, true, extack);
 	if (err)
 		return err;
=20
+	if (old_age_interval !=3D vxlan->cfg.age_interval)
+		mod_timer(&vxlan->age_timer, jiffies);
+
 	/* handle default dst entry */
 	if (!vxlan_addr_equal(&dst->remote_ip, &old_dst.remote_ip)) {
 		spin_lock_bh(&vxlan->hash_lock);
--=20
2.19.1

