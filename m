Date: Mon, 13 Apr 2009 07:49:17 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090413074917.4e317115@nehalam>
In-Reply-To: <20090413084201.GC23734@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090413083729.GA23734@psychotron.englab.brq.redhat.com>
	<20090413084201.GC23734@psychotron.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 2/4] net: introduce a list of device addresses
 dev_addr_list
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jpirko@redhat.com>
Cc: ivecera@redhat.com, fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, bonding-devel@lists.sourceforge.net, dada1@cosmosbay.com, jgarzik@pobox.com, davem@davemloft.net

On Mon, 13 Apr 2009 10:42:02 +0200
Jiri Pirko <jpirko@redhat.com> wrote:

> This patch introduces a new list in struct net_device and brings a set of
> functions to handle the work with device address list. The list is a replacement
> for the original dev_addr field and because in some situations there is need to
> carry several device addresses with the net device. To be backward compatible,
> dev_addr is made to point to the first member of the list so original drivers
> sees no difference.
> 
> Signed-off-by: Jiri Pirko <jpirko@redhat.com>
> ---
>  include/linux/netdevice.h |   51 +++++++++-
>  net/core/dev.c            |  264 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 313 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index ff8db51..8cf62f1 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -210,6 +210,12 @@ struct dev_addr_list
>  #define dmi_users	da_users
>  #define dmi_gusers	da_gusers
>  
> +struct hw_addr {
> +	struct list_head	list;
> +	unsigned char		addr[MAX_ADDR_LEN];
> +	int			refcount;
> +};
> +
>  struct hh_cache
>  {
>  	struct hh_cache *hh_next;	/* Next entry			     */
> @@ -776,8 +782,12 @@ struct net_device
>   */
>  	unsigned long		last_rx;	/* Time of last Rx	*/
>  	/* Interface address info used in eth_type_trans() */
> -	unsigned char		dev_addr[MAX_ADDR_LEN];	/* hw address, (before bcast
> -							   because most packets are unicast) */
> +	unsigned char		*dev_addr;	/* hw address, (before bcast
> +						   because most packets are
> +						   unicast) */
> +
> +	struct list_head	dev_addr_list; /* list of device hw addresses */
> +	spinlock_t              dev_addr_list_lock;
>  
>  	unsigned char		broadcast[MAX_ADDR_LEN];	/* hw bcast add	*/
>  
> @@ -1779,6 +1789,32 @@ static inline void netif_addr_unlock_bh(struct net_device *dev)
>  	spin_unlock_bh(&dev->addr_list_lock);
>  }
>  
> +/* Locking helpers for spinlock guarding dev_addr_list */
> +
> +static inline void netif_dev_addr_lock(struct net_device *dev)
> +{
> +	spin_lock(&dev->dev_addr_list_lock);
> +}
> +
> +static inline void netif_dev_addr_lock_bh(struct net_device *dev)
> +{
> +	spin_lock_bh(&dev->dev_addr_list_lock);
> +}
> +
> +static inline void netif_dev_addr_unlock(struct net_device *dev)
> +{
> +	spin_unlock(&dev->dev_addr_list_lock);
> +}
> +
> +static inline void netif_dev_addr_unlock_bh(struct net_device *dev)
> +{
> +	spin_unlock_bh(&dev->dev_addr_list_lock);
> +}
> +

This lock is unnecessary, use RCU list for read.
Since all changes are under RTNL mutex, there is no chance
for conflict on update.
