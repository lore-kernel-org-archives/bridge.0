Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ucGNWVxcRddDN1+ka0dNwUptaDTbn15BT3DH4Hwkw+8=;
 b=k16VEmnWCOJ1z/BCd5eL3yQW1Sh4YHFvAUR4iS02i/18d3V0zTVECjlCChvSz3zkqa
 bRR5izLG+IWEkBK2NjZpl2FBv2Zsk69PqFzlZhBxWJbGGCcvlfd6bkoBCFd19GduBcxg
 Bn6Ls8RxEgUPmomubhvUl3cnzlF/Yr3p5B4/AEOo9auWKfj2buym81OViMmEZs7fE2IQ
 Hk7wDVQhY6BUFjugwwVoCc+bisJWmEtH1sENSUH8wswwwqkuZyZu8vL0EtVBqshxLzhL
 MKT5tDTnYgiQCuNQ1tGEEZp840pi7JCagId5hJY/oXqVd8kOzyvbBkP0yk/Skf6qyfOD
 W1cw==
Date: Fri, 15 Oct 2021 10:51:54 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <YWjsyk/Dzg2/zVbw@Laptop-X1>
References: <20200907095619.11216-1-nikolay@cumulusnetworks.com>
 <20200907095619.11216-11-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907095619.11216-11-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next v4 10/15] net: bridge: mcast: support
 for IGMPv3/MLDv2 ALLOW_NEW_SOURCES report
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com

On Mon, Sep 07, 2020 at 12:56:14PM +0300, Nikolay Aleksandrov wrote:
> This patch adds handling for the ALLOW_NEW_SOURCES IGMPv3/MLDv2 report
> types and limits them only when multicast_igmp_version == 3 or
> multicast_mld_version == 2 respectively. Now that IGMPv3/MLDv2 handling
> functions will be managing timers we need to delay their activation, thus
> a new argument is added which controls if the timer should be updated.
> We also disable host IGMPv3/MLDv2 handling as it's not yet implemented and
> could cause inconsistent group state, the host can only join a group as
> EXCLUDE {} or leave it.
> 
> v4: rename update_timer to igmpv2_mldv1 and use the passed value from
>     br_multicast_add_group's callers
> v3: Add IPv6/MLDv2 support
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
>  net/bridge/br_multicast.c | 152 ++++++++++++++++++++++++++++++++------
>  net/bridge/br_private.h   |   7 ++
>  2 files changed, 137 insertions(+), 22 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index ba2ce875a80e..98600a08114e 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -787,7 +787,8 @@ static int br_multicast_add_group(struct net_bridge *br,
>  				  struct net_bridge_port *port,
>  				  struct br_ip *group,
>  				  const unsigned char *src,
> -				  u8 filter_mode)
> +				  u8 filter_mode,
> +				  bool igmpv2_mldv1)
>  {
>  	struct net_bridge_port_group __rcu **pp;
>  	struct net_bridge_port_group *p;
> @@ -826,7 +827,8 @@ static int br_multicast_add_group(struct net_bridge *br,
>  	br_mdb_notify(br->dev, mp, p, RTM_NEWMDB);
>  
>  found:
> -	mod_timer(&p->timer, now + br->multicast_membership_interval);
> +	if (igmpv2_mldv1)
> +		mod_timer(&p->timer, now + br->multicast_membership_interval);

Hi Nikolay,

Our engineer found that the multicast_membership_interval will not work with
IGMPv3. Is it intend as you said "IGMPv3/MLDv2 handling is not yet
implemented" ?

Thanks
Hangbin
