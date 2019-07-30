Return-Path: <davem@davemloft.net>
Date: Tue, 30 Jul 2019 10:18:11 -0700 (PDT)
Message-Id: <20190730.101811.1836331521043535108.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190730112100.18156-1-nikolay@cumulusnetworks.com>
References: <20190730112100.18156-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: mcast: don't delete permanent
 entries when fast leave is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 30 Jul 2019 14:21:00 +0300

> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 3d8deac2353d..f8cac3702712 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1388,6 +1388,9 @@ br_multicast_leave_group(struct net_bridge *br,
>  			if (!br_port_group_equal(p, port, src))
>  				continue;
>  
> +			if (p->flags & MDB_PG_FLAGS_PERMANENT)
> +				break;
> +

Like David, I also don't understand why this can be a break.  Is it because
permanent entries are always the last on the list?  Why will there be no
other entries that might need to be processed on the list?
