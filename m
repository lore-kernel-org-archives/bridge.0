Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 59C5181000
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4DFAF811F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533539; x=1698138339;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZa4jSa9DeYf42hNR0hEqm7HskiNNDncoqwV74WZCOY=;
 b=bBPDx/fWNdYMtSFNXybNiKEErtbZzwa6s39jRZ3R1W39XwNSbIa7SrLDjO8ZjmnvIM
 9jj/4JAhpg9vzLuCk3JJJY7GgoBWAH1z6mI0AqshFtFCFcCBs1oonoLl3wiuDGfdwxUL
 vtoCMuCaaXJdvyiYJ5e1yKFNkqvX8JzXWgQikcP71ImnQRcN2EvvNi3C7Hl4k7Qj9Ddf
 gVtne4e+d488Tw9rmAqt4vaNrDlk2Y4MtEK2XB4+/SafjngERz6V/kr7TrgTpRh18XZE
 27ey1rV4XzuBrhUcWUkOGoRjAtRAW4+xoQoqGcC7MwEocm72CTjVfnyMa75KjWa5xw/P
 G6HQ==
Message-ID: <2ba8e4fd-7dd1-0a6d-fc83-be8595cf7bef@blackwall.org>
Date: Tue, 17 Oct 2023 12:05:37 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-4-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 03/13] bridge: mcast: Factor out a
 helper for PG entry size calculation
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

On 10/16/23 16:12, Ido Schimmel wrote:
> Currently, netlink notifications are sent for individual port group
> entries and not for the entire MDB entry itself.
> 
> Subsequent patches are going to add MDB get support which will require
> the bridge driver to reply with an entire MDB entry.
> 
> Therefore, as a preparation, factor out an helper to calculate the size
> of an individual port group entry. When determining the size of the
> reply this helper will be invoked for each port group entry in the MDB
> entry.
> 
> No functional changes intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_mdb.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 08de94bffc12..42983f6a0abd 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -450,18 +450,13 @@ static int nlmsg_populate_mdb_fill(struct sk_buff *skb,
>   	return -EMSGSIZE;
>   }
>   
> -static size_t rtnl_mdb_nlmsg_size(struct net_bridge_port_group *pg)
> +static size_t rtnl_mdb_nlmsg_pg_size(const struct net_bridge_port_group *pg)
>   {
>   	struct net_bridge_group_src *ent;
>   	size_t nlmsg_size, addr_size = 0;
>   
> -	nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
> -		     /* MDBA_MDB */
> -		     nla_total_size(0) +
> -		     /* MDBA_MDB_ENTRY */
> -		     nla_total_size(0) +
>   		     /* MDBA_MDB_ENTRY_INFO */
> -		     nla_total_size(sizeof(struct br_mdb_entry)) +
> +	nlmsg_size = nla_total_size(sizeof(struct br_mdb_entry)) +
>   		     /* MDBA_MDB_EATTR_TIMER */
>   		     nla_total_size(sizeof(u32));
>   
> @@ -511,6 +506,17 @@ static size_t rtnl_mdb_nlmsg_size(struct net_bridge_port_group *pg)
>   	return nlmsg_size;
>   }
>   
> +static size_t rtnl_mdb_nlmsg_size(const struct net_bridge_port_group *pg)
> +{
> +	return NLMSG_ALIGN(sizeof(struct br_port_msg)) +
> +	       /* MDBA_MDB */
> +	       nla_total_size(0) +
> +	       /* MDBA_MDB_ENTRY */
> +	       nla_total_size(0) +
> +	       /* Port group entry */
> +	       rtnl_mdb_nlmsg_pg_size(pg);
> +}
> +
>   void br_mdb_notify(struct net_device *dev,
>   		   struct net_bridge_mdb_entry *mp,
>   		   struct net_bridge_port_group *pg,

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

