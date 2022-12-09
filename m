Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B7DDA4023F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE9294014B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U7fC1syZtXHLgbpou3o4m3NT/tshVkaTSTf4nVD7gqQ=;
 b=w4kjIdlfb7CW4KRPyj0jUIA9uzCSD+/hYcGIYgGZrhaYcfs53qI/OoQgTYBV8W21IE
 67YLi4aKQMjDbFs0ntZOqB0/TCbF7uPc8qoPqFaOD5oFmdUhzjtm6BMe05SH6zX4Jd+q
 ImY50nTkuE7VU/00XTlwyJ6JMt3v/QhmbdCRZ6zJ55mS+TWJ45F8vo6+acNk02vEixhJ
 fKCmtITBJ9BXp6W5L40cvhXMEV5s2UjAl1LLRbl2vbzglXPUmaq+fvzeRDfGL43z62Vn
 hGnfL7kURf82TtyFBJ2pL8fgQ5ASGkTXabJFrVSyzQjKrMDp4ikyhKNjzIoNkLh+iIRP
 2CoQ==
Message-ID: <455ce972-3b48-4ec3-92c8-3a50f7d96918@blackwall.org>
Date: Fri, 9 Dec 2022 09:30:45 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-6-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-6-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 05/14] bridge: mcast: Expose
 br_multicast_new_group_src()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 08/12/2022 17:28, Ido Schimmel wrote:
> Currently, new group source entries are only created in response to
> received Membership Reports. Subsequent patches are going to allow user
> space to install (*, G) entries with a source list.
> 
> As a preparatory step, expose br_multicast_new_group_src() so that it
> could later be invoked from the MDB code (i.e., br_mdb.c) that handles
> RTM_NEWMDB messages.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_multicast.c | 2 +-
>  net/bridge/br_private.h   | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index db4c3900ae95..b2bc23fdcee5 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1232,7 +1232,7 @@ br_multicast_find_group_src(struct net_bridge_port_group *pg, struct br_ip *ip)
>  	return NULL;
>  }
>  
> -static struct net_bridge_group_src *
> +struct net_bridge_group_src *
>  br_multicast_new_group_src(struct net_bridge_port_group *pg, struct br_ip *src_ip)
>  {
>  	struct net_bridge_group_src *grp_src;
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 3997e16c15fc..183de6c57d72 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -974,6 +974,9 @@ void br_multicast_sg_add_exclude_ports(struct net_bridge_mdb_entry *star_mp,
>  				       struct net_bridge_port_group *sg);
>  struct net_bridge_group_src *
>  br_multicast_find_group_src(struct net_bridge_port_group *pg, struct br_ip *ip);
> +struct net_bridge_group_src *
> +br_multicast_new_group_src(struct net_bridge_port_group *pg,
> +			   struct br_ip *src_ip);
>  void br_multicast_del_group_src(struct net_bridge_group_src *src,
>  				bool fastleave);
>  void br_multicast_ctx_init(struct net_bridge *br,

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

