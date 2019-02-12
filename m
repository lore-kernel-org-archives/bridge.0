Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=BppXVa/dmDTUOKLFEo7WizMgmZk4QhbPlPOeKYW5Jk0=;
	b=udlinu8HytGMN8j4vt8WUaiewdodpHbBJO106bjRBAxSlPn+fQuwxnqAWdPNBf14EsUimk7O+DgV7+r3SnZzj+4cxRfNSRQFjOX3NQBoCLKdo2Nd9iO6iKIlbfXHDaxYHKTZzFa1nTsFrZ4zodXlSMnOsyqfkAn01iH0j/A9dMA=
From: Ido Schimmel <idosch@mellanox.com>
Date: Tue, 12 Feb 2019 13:55:54 +0000
Message-ID: <20190212135551.GA16850@splinter>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
	<20190211191001.8623-3-f.fainelli@gmail.com>
In-Reply-To: <20190211191001.8623-3-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1194120A8552E7488A4F91C5FFD590AF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 2/9] switchdev: Add
 SWITCHDEV_PORT_ATTR_SET, SWITCHDEV_PORT_ATTR_GET
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "moderated
	list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "David S. Miller" <davem@davemloft.net>

On Mon, Feb 11, 2019 at 11:09:54AM -0800, Florian Fainelli wrote:
> In preparation for allowing switchdev enabled drivers to veto specific
> attribute settings from within the context of the caller, introduce a
> new switchdev notifier type for port attributes.
>=20
> Suggested-by: Ido Schimmel <idosch@mellanox.com>
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  include/net/switchdev.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index 5e87b54c5dc5..b8becabbef38 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -143,6 +143,9 @@ enum switchdev_notifier_type {
>  	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
>  	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
>  	SWITCHDEV_VXLAN_FDB_OFFLOADED,
> +
> +	SWITCHDEV_PORT_ATTR_SET, /* Blocking. */
> +	SWITCHDEV_PORT_ATTR_GET, /* Blocking. */

As I wrote in the cover letter, I don't believe GET is needed.

>  };
> =20
>  struct switchdev_notifier_info {
> @@ -165,6 +168,13 @@ struct switchdev_notifier_port_obj_info {
>  	bool handled;
>  };
> =20
> +struct switchdev_notifier_port_attr_info {
> +	struct switchdev_notifier_info info; /* must be first */
> +	struct switchdev_attr *attr;
> +	struct switchdev_trans *trans;
> +	bool handled;
> +};
> +
>  static inline struct net_device *
>  switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *inf=
o)
>  {
> --=20
> 2.17.1
>=20
