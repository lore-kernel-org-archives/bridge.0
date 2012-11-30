Return-Path: <BATV+d5af59120f6e5838f71b+3386+infradead.org+tgraf@casper.srs.infradead.org>
Date: Fri, 30 Nov 2012 10:54:49 +0000
From: Thomas Graf <tgraf@suug.ch>
Message-ID: <20121130105449.GE30697@casper.infradead.org>
References: <1354269514-1863-1-git-send-email-amwang@redhat.com>
	<1354269514-1863-3-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1354269514-1863-3-git-send-email-amwang@redhat.com>
Sender: Thomas Graf <tgr@infradead.org>
Subject: Re: [Bridge] [PATCH iproute2 v1] Add mdb command to bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, Jesper Dangaard Brouer <brouer@redhat.com>, Stephen Hemminger <shemminger@vyatta.com>, "David S. Miller" <davem@davemloft.net>

On 11/30/12 at 05:58pm, Cong Wang wrote:
> diff --git a/bridge/br_common.h b/bridge/br_common.h
> index 718ecb9..83b2b9f 100644
> --- a/bridge/br_common.h
> +++ b/bridge/br_common.h
> @@ -5,6 +5,7 @@ extern int print_fdb(const struct sockaddr_nl *who,
>  		     struct nlmsghdr *n, void *arg);
>  
>  extern int do_fdb(int argc, char **argv);
> +extern int do_mdb(int argc, char **argv);
>  extern int do_monitor(int argc, char **argv);
>  
>  extern int preferred_family;
> @@ -12,3 +13,37 @@ extern int show_stats;
>  extern int show_detail;
>  extern int timestamp;
>  extern struct rtnl_handle rth;
> +
> +/* Bridge multicast database attributes
> + * [MDBA_MDB] = {
> + *    [MDBA_MCADDR]
> + *    [MDBA_BRPORT_NO]
> + * }
> + * [MDBA_ROUTER] = {
> + *    [MDBA_BRPORT_NO]
> + * }
> + */
> +enum {
> +	MDBA_UNSPEC,
> +	MDBA_MDB,
> +	MDBA_ROUTER,
> +	__MDBA_MAX,
> +};
> +#define MDBA_MAX (__MDBA_MAX - 1)
> +
> +enum {
> +	MDBA_MDB_UNSPEC,
> +	MDBA_MCADDR,
> +	MDBA_BRPORT_NO,
> +	__MDBA_MDB_MAX,
> +};
> +#define MDBA_MDB_MAX (__MDBA_MDB_MAX - 1)
> +
> +struct br_port_msg {
> +        int ifindex;
> +};
> +
> +#ifndef MDBA_RTA
> +#define MDBA_RTA(r) \
> +	((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct br_port_msg))))
> +#endif

You shouldn't need to duplicate the attribute ids and struct br_port_msg
in iproute2. Just put these definitions in a uapi kernel header and
include the header from iproute2.
