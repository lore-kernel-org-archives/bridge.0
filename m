Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gufT/iK2lf7MJPAxfpUWJWhox9wRZHztZlXZ+kirlIM=;
 b=nXxAqfusQZ0BdiepXsv78EwHaIByek2G+pPM6JcYQs97KD8He8W8vfctnPm96w+D8HqttVrlY3MW9B+X2kj5INSy/yoDhBT6PYg39vWEUrck4lMO9PBXWS0FDwpsXRvE6Jgg9jA05G4IBSKRepdKq5b75qdS5Aic4lUQDUAvwd9mbxRufDfFi+cBkGT4pKCQRdx9l3Qm7OZPDp2UZTKk9Z1QhMDaAMIwgJq2babh5bfkQ/3xvm/YMYL+JWOcQX+MeIB1xO2drN9pSKffCkNCPfJoJbS4SES0YNXu0jYxlC1EMTZiIzWvnIvxmel/jQSDV6kyXWXaQ16cMDs484GfmQ==
Message-ID: <cc425efa-1e20-286a-ba96-bc9555142c9c@nvidia.com>
Date: Tue, 25 Jan 2022 10:24:32 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220125061903.714509-1-bpoirier@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20220125061903.714509-1-bpoirier@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: vlan: Fix dumping with ifindex
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Roopa Prabhu <roopa@nvidia.com>

On 25/01/2022 08:19, Benjamin Poirier wrote:
> Specifying ifindex in a RTM_GETVLAN dump leads to an infinite repetition
> of the same entries. netlink_dump() normally calls the dump function
> repeatedly until it returns 0 which br_vlan_rtm_dump() never does in
> that case.
> 
> Fixes: 8dcea187088b ("net: bridge: vlan: add rtm definitions and dump support")
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  net/bridge/br_vlan.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
[snip]
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 84ba456a78cc..2e606f2b9a4d 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -2013,7 +2013,7 @@ static int br_vlan_rtm_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		dump_flags = nla_get_u32(dtb[BRIDGE_VLANDB_DUMP_FLAGS]);
>  
>  	rcu_read_lock();
> -	if (bvm->ifindex) {
> +	if (bvm->ifindex && !s_idx) {
>  		dev = dev_get_by_index_rcu(net, bvm->ifindex);
>  		if (!dev) {
>  			err = -ENODEV;
> @@ -2022,7 +2022,9 @@ static int br_vlan_rtm_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		err = br_vlan_dump_dev(dev, skb, cb, dump_flags);
>  		if (err && err != -EMSGSIZE)
>  			goto out_err;
> -	} else {
> +		else if (!err)
> +			idx++;
> +	} else if (!bvm->ifindex) {
>  		for_each_netdev_rcu(net, dev) {
>  			if (idx < s_idx)
>  				goto skip;

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
