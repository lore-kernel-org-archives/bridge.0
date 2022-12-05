Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D218B60888
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3AA6607CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f1KimoZD/4pavk1dyfC2nM/GPdOAWDB3KJt4OBapbgc=;
 b=vF/EYPE/s4UMEImbM1WcGc2QpHWPUutT4y0hzMF3fU1Z7SKZvXYIwqx6ykqUwVjl8u
 tE5Bx1dI3CNYT2l/Nan1Haaur+FZ6A20v0opucHaJaTBOvq/nW9oMBfdL0JyblInAEMr
 1Rs3tN1qWElrFK0mb4g57VQ9mZ8OwAKr8eQqB1S2/FJXwYnPbgcR9HUy5m0ScLYsVKMy
 rRwkalwWKEIHOQduY1vWyZEk2sG1KUioy1Es4No8994tnN+37yj+AmkjY2pMXw6yGNFH
 x/BRRpviy2neOE5kMGHQWgwdaHlkN6hMDJwkr/dKwREfStJRB2OC+7iIqTbGXJ1JsZAP
 rNyQ==
Message-ID: <06490c08-bf5e-1714-f56c-1a6068fb2ec9@blackwall.org>
Date: Mon, 5 Dec 2022 13:34:08 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221205074251.4049275-1-idosch@nvidia.com>
 <20221205074251.4049275-2-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221205074251.4049275-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/8] bridge: mcast: Centralize netlink
 attribute parsing
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

On 05/12/2022 09:42, Ido Schimmel wrote:
> Netlink attributes are currently passed deep in the MDB creation call
> chain, making it difficult to add new attributes. In addition, some
> validity checks are performed under the multicast lock although they can
> be performed before it is ever acquired.
> 
> As a first step towards solving these issues, parse the RTM_{NEW,DEL}MDB
> messages into a configuration structure, relieving other functions from
> the need to handle raw netlink attributes.
> 
> Subsequent patches will convert the MDB code to use this configuration
> structure.
> 
> This is consistent with how other rtnetlink objects are handled, such as
> routes and nexthops.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c     | 120 ++++++++++++++++++++++++++++++++++++++++
>  net/bridge/br_private.h |   7 +++
>  2 files changed, 127 insertions(+)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 321be94c445a..c53050e47a0f 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -974,6 +974,116 @@ static int __br_mdb_add(struct net *net, struct net_bridge *br,
>  	return ret;
>  }
>  
> +static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
> +				    struct br_mdb_config *cfg,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *mdb_attrs[MDBE_ATTR_MAX + 1];
> +	int err;
> +
> +	err = nla_parse_nested(mdb_attrs, MDBE_ATTR_MAX, set_attrs,
> +			       br_mdbe_attrs_pol, extack);
> +	if (err)
> +		return err;
> +
> +	if (mdb_attrs[MDBE_ATTR_SOURCE] &&
> +	    !is_valid_mdb_source(mdb_attrs[MDBE_ATTR_SOURCE],
> +				 cfg->entry->addr.proto, extack))
> +		return -EINVAL;
> +
> +	__mdb_entry_to_br_ip(cfg->entry, &cfg->group, mdb_attrs);
> +
> +	return 0;
> +}
> +
> +static int br_mdb_config_init(struct net *net, struct sk_buff *skb,
> +			      struct nlmsghdr *nlh, struct br_mdb_config *cfg,
> +			      struct netlink_ext_ack *extack)
> +{

I just noticed the skb argument is unused. Does it get used in a future change?
Also a minor nit - I think nlh can be a const, nlmsg_parse_deprecated already uses a const nlh.


