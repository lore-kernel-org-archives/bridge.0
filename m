From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Nov 2009 14:09:28 +0100
References: <20091113195201.11184.25766.stgit@mimic.site>
	<20091113195513.11184.63631.stgit@mimic.site>
In-Reply-To: <20091113195513.11184.63631.stgit@mimic.site>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200911271409.28810.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH 1/3] netdevice: provide common routine for
	macvlan and vlan operstate management
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick Mullaney <pmullaney@novell.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alacrityvm-devel@lists.sourceforge.net

On Friday 13 November 2009, Patrick Mullaney wrote:
> @@ -551,7 +532,7 @@ static int macvlan_newlink(struct net_device *dev,
>                 return err;
>  
>         list_add_tail(&vlan->list, &port->vlans);
> -       macvlan_transfer_operstate(dev);
> +       netif_stacked_transfer_operstate(dev, lowerdev);
>         return 0;
>  }
>  
> @@ -591,7 +572,8 @@ static int macvlan_device_event(struct notifier_block *unused,
>         switch (event) {
>         case NETDEV_CHANGE:
>                 list_for_each_entry(vlan, &port->vlans, list)
> -                       macvlan_transfer_operstate(vlan->dev);
> +                       netif_stacked_transfer_operstate(vlan->dev,
> +                                                        vlan->lowerdev);
>                 break;
>         case NETDEV_FEAT_CHANGE:
>                 list_for_each_entry(vlan, &port->vlans, list) {

These have the arguments reversed, lowerdev should come first.

	Arnd <><
