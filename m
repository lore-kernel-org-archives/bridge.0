From: Diego Liziero <diego.liziero@unimore.it>
In-Reply-To: <20040521154511.1d7b896d@dell_ss3.pdx.osdl.net>
References: <20040521154511.1d7b896d@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1085389690.6767.15.camel@igno>
Mime-Version: 1.0
Date: Mon, 24 May 2004 11:08:11 +0200
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [1/11] bridge - handle delete of multiple devices with
	same address
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bluez-devel@lists.sourceforge.net, bridge@osdl.org, kishoreak@myw.ltindia.com

Great work Stephen, just tested with Bluetooth PAN
and everything works now.

For the bluetooth people, here is the bk link to the patch:
http://linux.bkbits.net:8080/linux-2.5/cset@40afb9c8_3WOgNFCBlahWsksS_5icQ?nav=index.html|ChangeSet@-3d

Thanks to all the people that helped me.
Regards,
Diego.

On Sat, 2004-05-22 at 00:45, Stephen Hemminger wrote:
> This fixes the issue discovered when removing bluetooth devices from a bridge.
> Need to add special case code when forwarding table is being cleaned up to 
> handle the case where several devices share the same hardware address.
> 
> (Could fix on 2.4 if there is demand for it)
>  
> diff -Nru a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> --- a/net/bridge/br_fdb.c	2004-05-20 08:43:46 -07:00
> +++ b/net/bridge/br_fdb.c	2004-05-20 08:43:46 -07:00
> @@ -157,9 +157,28 @@
>  		hlist_for_each_safe(h, g, &br->hash[i]) {
>  			struct net_bridge_fdb_entry *f
>  				= hlist_entry(h, struct net_bridge_fdb_entry, hlist);
> -			if (f->dst == p) {
> -				fdb_delete(f);
> +			if (f->dst != p) 
> +				continue;
> +
> +			/*
> +			 * if multiple ports all have the same device address
> +			 * then when one port is deleted, assign
> +			 * the local entry to other port
> +			 */
> +			if (f->is_local) {
> +				struct net_bridge_port *op;
> +				list_for_each_entry(op, &br->port_list, list) {
> +					if (op != p && 
> +					    !memcmp(op->dev->dev_addr,
> +						    f->addr.addr, ETH_ALEN)) {
> +						f->dst = op;
> +						goto skip_delete;
> +					}
> +				}
>  			}
> +
> +			fdb_delete(f);
> +		skip_delete: ;
>  		}
>  	}
>  	write_unlock_bh(&br->hash_lock);

