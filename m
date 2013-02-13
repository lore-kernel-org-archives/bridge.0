Return-Path: <jitendra.kalsaria@qlogic.com>
From: Jitendra Kalsaria <jitendra.kalsaria@qlogic.com>
Date: Wed, 13 Feb 2013 22:10:39 +0000
Message-ID: <BECD8E8A1B550B48A1BF97C13991F60E2AFC42@avmb2.qlogic.org>
In-Reply-To: <1360792820-14116-11-git-send-email-vyasevic@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CBE76616633824F8BCADF922BF2755F@qlogic.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v11 net-next 10/12] bridge: Add vlan support to
 static neighbors
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>, "shemminger@vyatta.com" <shemminger@vyatta.com>
Cc: netdev <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, David Miller <davem@davemloft.net>


On 2/13/13 2:00 PM, "Vlad Yasevich" <vyasevic@redhat.com> wrote:

>When a user adds bridge neighbors, allow him to specify VLAN id.
>If the VLAN id is not specified, the neighbor will be added
>for VLANs currently in the ports filter list.  If no VLANs are
>configured on the port, we use vlan 0 and only add 1 entry.
>
>Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
>---
>drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |    2 +-
>drivers/net/ethernet/mellanox/mlx4/en_netdev.c   |    1 +
>drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c |    4 +-
>drivers/net/macvlan.c                            |    2 +-
>drivers/net/vxlan.c                              |    3 +-
>include/linux/netdevice.h                        |    4 +-
>include/uapi/linux/neighbour.h                   |    1 +
>net/bridge/br_fdb.c                              |  148
>+++++++++++++++++++---
>net/bridge/br_private.h                          |    6 +-
>net/core/rtnetlink.c                             |   26 +++--
>10 files changed, 162 insertions(+), 35 deletions(-)
>
>diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
>b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
>index b745194..b953168 100644
>--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
>+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
>@@ -247,8 +247,8 @@ static int qlcnic_set_mac(struct net_device *netdev,
>void *p)
>	return 0;
>}
>-static int qlcnic_fdb_del(struct ndmsg *ndm, struct net_device *netdev,
>-			const unsigned char *addr)
>+static int qlcnic_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
>+			struct net_device *netdev, const unsigned char *addr)
>{
>	struct qlcnic_adapter *adapter =3D netdev_priv(netdev);
>	int err =3D -EOPNOTSUPP;

Thanks!

Acked-by: Jitendra Kalsaria <jitendra.kalsaria@qlogic.com>


