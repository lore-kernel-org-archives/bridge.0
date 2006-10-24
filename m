Message-ID: <37933.195.55.244.106.1161675548.squirrel@www.arcoscom.com>
In-Reply-To: <20061012112431.0550b252@dxpl.pdx.osdl.net>
References: <20061012112431.0550b252@dxpl.pdx.osdl.net>
Date: Tue, 24 Oct 2006 09:39:08 +0200 (CEST)
From: "ArcosCom Linux User" <linux@arcoscom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] bridge: flush forwarding table when device
 carrier off
Reply-To: linux@arcoscom.com
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@vger.kernel.org, bridge@osdl.org, "David S. Miller" <davem@davemloft.net>

Is this patch submitted into kernel tree? What version of kernel will have
this patch applied (thinking on 2.6.x and 2.4.x branchs)?

Thanks

El Jue, 12 de Octubre de 2006, 20:24, Stephen Hemminger escribi=F3:
> Flush the forwarding table when carrier is lost. This helps for
> availability because we don't want to forward to a downed device and
> new packets may come in on other links.
>
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
> ---
>  net/bridge/br_fdb.c     |    7 ++++++-
>  net/bridge/br_if.c      |    4 ++--
>  net/bridge/br_private.h |    2 +-
>  net/bridge/br_stp_if.c  |    2 ++
>  4 files changed, 11 insertions(+), 4 deletions(-)
>
> --- bridge.orig/net/bridge/br_fdb.c
> +++ bridge/net/bridge/br_fdb.c
> @@ -128,7 +128,10 @@ void br_fdb_cleanup(unsigned long _data)
>  	mod_timer(&br->gc_timer, jiffies + HZ/10);
>  }
>
> -void br_fdb_delete_by_port(struct net_bridge *br, struct net_bridge_port
> *p)
> +
> +void br_fdb_delete_by_port(struct net_bridge *br,
> +			   const struct net_bridge_port *p,
> +			   int do_all)
>  {
>  	int i;
>
> @@ -142,6 +145,8 @@ void br_fdb_delete_by_port(struct net_br
>  			if (f->dst !=3D p)
>  				continue;
>
> +			if (f->is_static & !do_all)
> +				continue;
>  			/*
>  			 * if multiple ports all have the same device address
>  			 * then when one port is deleted, assign
> --- bridge.orig/net/bridge/br_if.c
> +++ bridge/net/bridge/br_if.c
> @@ -163,7 +163,7 @@ static void del_nbp(struct net_bridge_po
>  	br_stp_disable_port(p);
>  	spin_unlock_bh(&br->lock);
>
> -	br_fdb_delete_by_port(br, p);
> +	br_fdb_delete_by_port(br, p, 1);
>
>  	list_del_rcu(&p->list);
>
> @@ -448,7 +448,7 @@ int br_add_if(struct net_bridge *br, str
>
>  	return 0;
>  err2:
> -	br_fdb_delete_by_port(br, p);
> +	br_fdb_delete_by_port(br, p, 1);
>  err1:
>  	kobject_del(&p->kobj);
>  err0:
> --- bridge.orig/net/bridge/br_private.h
> +++ bridge/net/bridge/br_private.h
> @@ -143,7 +143,7 @@ extern void br_fdb_changeaddr(struct net
>  			      const unsigned char *newaddr);
>  extern void br_fdb_cleanup(unsigned long arg);
>  extern void br_fdb_delete_by_port(struct net_bridge *br,
> -			   struct net_bridge_port *p);
> +				  const struct net_bridge_port *p, int do_all);
>  extern struct net_bridge_fdb_entry *__br_fdb_get(struct net_bridge *br,
>  						 const unsigned char *addr);
>  extern struct net_bridge_fdb_entry *br_fdb_get(struct net_bridge *br,
> --- bridge.orig/net/bridge/br_stp_if.c
> +++ bridge/net/bridge/br_stp_if.c
> @@ -113,6 +113,8 @@ void br_stp_disable_port(struct net_brid
>  	del_timer(&p->forward_delay_timer);
>  	del_timer(&p->hold_timer);
>
> +	br_fdb_delete_by_port(br, p, 0);
> +
>  	br_configuration_update(br);
>
>  	br_port_state_selection(br);
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
>


