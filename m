Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A25760B50
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 227BF60B46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4CgxZCNJws0j636Fy5T/cCAzlRVsdGEH7eheOE17lVg=;
 b=06BPTj6mlub4bNGZ1y2nuZaPVTBeLJHSocCjSheTHZPY17Kn9HexRVW7MXile1VBLN
 EKxFcIpd7aY7zKxadBB6umGdQ6+kaWVFcJG2UUCU3RPxaZXHtz+dz1ADwAcQr9Kmpv7K
 RfTsCZlK6smY30fAhuFM8af5wZwWcXUgA/91s3q64RWI5RvOxewufDBieZCqB3i0ME3R
 eysAv4R8btVvK7EF5zClnFM3SreAj9U3nbw3gaFTq9iAq4E7hL+RmZautB5oIJBMPAn7
 v9fuSPCe2sqgm123+S9mzWeN/vS2EZg3xLlQKemlAQJz0U9YWQuLUIAHS1wEcUCsKwp7
 iPtg==
Message-ID: <b7933945-0c30-f007-3bea-5f6e5fc448a3@blackwall.org>
Date: Fri, 9 Dec 2022 09:32:51 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-9-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-9-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 08/14] bridge: mcast: Avoid arming
 group timer when (S, G) corresponds to a source
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
> User space will soon be able to install a (*, G) with a source list,
> prompting the creation of a (S, G) entry for each source.
> 
> In this case, the group timer of the (S, G) entry should never be set.
> 
> Solve this by adding a new field to the MDB configuration structure that
> denotes whether the (S, G) corresponds to a source or not.
> 
> The field will be set in a subsequent patch where br_mdb_add_group_sg()
> is called in order to create a (S, G) entry for each user provided
> source.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c     | 2 +-
>  net/bridge/br_private.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 95780652cdbf..7cda9d1c5c93 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -814,7 +814,7 @@ static int br_mdb_add_group_sg(const struct br_mdb_config *cfg,
>  		return -ENOMEM;
>  	}
>  	rcu_assign_pointer(*pp, p);
> -	if (!(flags & MDB_PG_FLAGS_PERMANENT))
> +	if (!(flags & MDB_PG_FLAGS_PERMANENT) && !cfg->src_entry)
>  		mod_timer(&p->timer,
>  			  now + brmctx->multicast_membership_interval);
>  	br_mdb_notify(cfg->br->dev, mp, p, RTM_NEWMDB);
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 74f17b56c9eb..e98bfe3c02e1 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -98,6 +98,7 @@ struct br_mdb_config {
>  	struct net_bridge_port		*p;
>  	struct br_mdb_entry		*entry;
>  	struct br_ip			group;
> +	bool				src_entry;
>  };
>  #endif
>  

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

