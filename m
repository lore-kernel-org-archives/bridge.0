Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 025F440273
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2067C4014A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6QRPL8jVNR4wcNXjj50aKPMrExKMvKLBoy4ZEO7obgQ=;
 b=DNXFEOJlNom33o3zlOv9nXCjJgm33+jGxiYg6uBYl+0oAIYPq+1z0VwLfipryb4Xg0
 wbH6hAaEGvszxQ7sgqkz0QikMqIzFc+ZK6cE+tQZgUi2H6o05P6k/lORAuD6pwAZtEUH
 jRCdQ10Kw9mxTUIMLbqCVaCUf8Kh1wIvcQzScIWFLZNq8WGK0xix2RTT0tSo+GGNXATC
 5XEhG9ePUTbh5+RJKxW/mA/RfrGZLw0l75kXnhyBH3BYZbiNWClDRy2GWFQ5E+xjqMNR
 ga4Kkfhwtqr/FGS6pyzVYarvhBxM3W7m+LVqUDdvRGdlJADH7f3GRlmqwjoF4/bA7sJi
 E4cA==
Message-ID: <127afe2b-9bbb-57e3-6374-c1df0505ebfb@blackwall.org>
Date: Fri, 9 Dec 2022 09:30:07 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-4-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 03/14] bridge: mcast: Place netlink
 policy before validation functions
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
> Subsequent patches are going to add additional validation functions and
> netlink policies. Some of these functions will need to perform parsing
> using nla_parse_nested() and the new policies.
> 
> In order to keep all the policies next to each other, move the current
> policy to before the validation functions.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index e3bd2122d559..fcdd464cf997 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -663,6 +663,12 @@ void br_rtr_notify(struct net_device *dev, struct net_bridge_mcast_port *pmctx,
>  	rtnl_set_sk_err(net, RTNLGRP_MDB, err);
>  }
>  
> +static const struct nla_policy br_mdbe_attrs_pol[MDBE_ATTR_MAX + 1] = {
> +	[MDBE_ATTR_SOURCE] = NLA_POLICY_RANGE(NLA_BINARY,
> +					      sizeof(struct in_addr),
> +					      sizeof(struct in6_addr)),
> +};
> +
>  static bool is_valid_mdb_entry(struct br_mdb_entry *entry,
>  			       struct netlink_ext_ack *extack)
>  {
> @@ -748,12 +754,6 @@ static bool is_valid_mdb_source(struct nlattr *attr, __be16 proto,
>  	return true;
>  }
>  
> -static const struct nla_policy br_mdbe_attrs_pol[MDBE_ATTR_MAX + 1] = {
> -	[MDBE_ATTR_SOURCE] = NLA_POLICY_RANGE(NLA_BINARY,
> -					      sizeof(struct in_addr),
> -					      sizeof(struct in6_addr)),
> -};
> -
>  static struct net_bridge_mcast *
>  __br_mdb_choose_context(struct net_bridge *br,
>  			const struct br_mdb_entry *entry,

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
