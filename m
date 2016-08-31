Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 31 Aug 2016 03:37:26 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160831013726.GD4883@otheros>
References: <1472570588-32503-1-git-send-email-nikolay@cumulusnetworks.com>
	<1472570588-32503-3-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1472570588-32503-3-git-send-email-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next v2 2/2] net: bridge: add per-port
 multicast flood flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On Tue, Aug 30, 2016 at 05:23:08PM +0200, Nikolay Aleksandrov via Bridge wrote:
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index 1da3221845f1..ed0dd3340084 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -362,7 +362,7 @@ static struct net_bridge_port *new_nbp(struct net_bridge *br,
>  	p->path_cost = port_cost(dev);
>  	p->priority = 0x8000 >> BR_PORT_BITS;
>  	p->port_no = index;
> -	p->flags = BR_LEARNING | BR_FLOOD;
> +	p->flags = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD;

I'm discontent with this new flag becoming the default.

Could you elaborate a little more on your use-case, when/why do
you want/need this flag?
