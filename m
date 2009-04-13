Date: Mon, 13 Apr 2009 15:53:35 -0700 (PDT)
Message-Id: <20090413.155335.248383596.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090413084201.GC23734@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090413083729.GA23734@psychotron.englab.brq.redhat.com>
	<20090413084201.GC23734@psychotron.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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
To: jpirko@redhat.com
Cc: ivecera@redhat.com, fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, jgarzik@pobox.com, dada1@cosmosbay.com, bonding-devel@lists.sourceforge.net

From: Jiri Pirko <jpirko@redhat.com>
Date: Mon, 13 Apr 2009 10:42:02 +0200

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

Please don't pollute the global namespace with a structure name
like this.  Use "netdev_hw_addr" or "net_hw_addr".

> +static inline int __hw_addr_add(struct list_head *list, unsigned char *addr,
> +				int addr_len)

Please let the compiler inline things as it sees fit.  These
aren't routines in some header file or anything like that.
