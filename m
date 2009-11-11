Message-ID: <4AFAD9E6.2020109@trash.net>
Date: Wed, 11 Nov 2009 16:36:06 +0100
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <20091110222632.24100.14884.stgit@mimic.site>
	<20091110222812.24100.42756.stgit@mimic.site>
In-Reply-To: <20091110222812.24100.42756.stgit@mimic.site>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 4/4] venet-macvlan: add new driver to connect a
 venet to a	macvlan netdevice
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick Mullaney <pmullaney@novell.com>
Cc: arnd@arndb.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alacrityvm-devel@lists.sourceforge.net, evb@yahoogroups.com

Patrick Mullaney wrote:
> This driver implements a macvlan device as a venet device that can
> be connected to vbus. Since it is a macvlan device, it provides
> a more direct path to the underlying adapter by avoiding the
> bridge.

> --- /dev/null
> +++ b/kernel/vbus/devices/venet/macvlan.c
> ...
> +struct venetmacv {
> +	struct macvlan_dev mdev;
> +	unsigned char ll_ifname[IFNAMSIZ];
> +	struct venetdev dev;
> +	const struct net_device_ops *macvlan_netdev_ops;
> +};

macvlan might destroy the device below you when the underlying
device is unregistered. You need to handle this by releasing
the venetmacv device. Check out the NETDEV_UNREGISTER case in
macvlan_device_event().
