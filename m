Return-Path: <BATV+52873753120e990d0a27+3393+infradead.org+tgraf@casper.srs.infradead.org>
Date: Fri, 7 Dec 2012 09:31:07 +0000
From: Thomas Graf <tgraf@suug.ch>
Message-ID: <20121207093107.GA2996@casper.infradead.org>
References: <20121207061854.GB18220@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121207061854.GB18220@elgon.mountain>
Sender: Thomas Graf <tgr@infradead.org>
Subject: Re: [Bridge] [patch] bridge: make buffer larger in br_setlink()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On 12/07/12 at 09:18am, Dan Carpenter wrote:
> __IFLA_BRPORT_MAX is one larger than IFLA_BRPORT_MAX.  We pass
> IFLA_BRPORT_MAX to nla_parse_nested() so we need IFLA_BRPORT_MAX + 1
> elements.  Also Smatch complains that we read past the end of the array
> when in br_set_port_flag() when it's called with IFLA_BRPORT_FAST_LEAVE.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Only needed in linux-next.
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 850b7d1..cfc5cfe 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -239,7 +239,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh)
>  	struct ifinfomsg *ifm;
>  	struct nlattr *protinfo;
>  	struct net_bridge_port *p;
> -	struct nlattr *tb[IFLA_BRPORT_MAX];
> +	struct nlattr *tb[__IFLA_BRPORT_MAX];
>  	int err;
>  
>  	ifm = nlmsg_data(nlh);

I know it's nitpicking but could you use IFLA_BRPORT_MAX+1 for
consistency?
