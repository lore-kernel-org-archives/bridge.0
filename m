Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1653C6108E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A54761033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OScVKXBFx0PGgNxDsW0PI1/fpjTd06DrYTq/VBuYPDo=;
 b=3wdeSMrsOlQbCU0LGgDZBIDA9jEsyURuUKe3Lg6q6xWd8Pc/G9xmy85O7u1troTO8J
 YirhL8X9T7NBSRsRX+aDCwlGcXrHwWQzAGppBJAsedYuVYfMX+gbulfqS/Lb68/Xgd1P
 jSenRPB3//w2ckzFLw9iUpgReHF4NeBvMLpuayq0D/GAuduuMATMBjrYYsGKD7SZYHLy
 ScqByJb1Eg+hpYbQntj6/4OicwqRkiahzjA5VetgJ1nHAslk0Ry/iwXTdevvx+KtWVh9
 zLcJDiTB5x5C58zONjba+pvPA49bBFh6mTiQsT94axpLwROMefcIpO6RXP9jUV/qHYyg
 sT9g==
Message-ID: <ca8740bc-0c72-efd9-670e-617dfd46f0f6@blackwall.org>
Date: Thu, 9 Feb 2023 09:19:00 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230209071852.613102-1-idosch@nvidia.com>
 <20230209071852.613102-3-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230209071852.613102-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/4] bridge: mcast: Remove pointless
 sequence generation counter assignment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 2/9/23 09:18, Ido Schimmel wrote:
> The purpose of the sequence generation counter in the netlink callback
> is to identify if a multipart dump is consistent or not by calling
> nl_dump_check_consistent() whenever a message is generated.
> 
> The function is not invoked by the MDB code, rendering the sequence
> generation counter assignment pointless. Remove it.
> 
> Note that even if the function was invoked, we still could not
> accurately determine if the dump is consistent or not, as there is no
> sequence generation counter for MDB entries, unlike nexthop objects, for
> example.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_mdb.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 13076206e497..96f36febfb30 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -421,8 +421,6 @@ static int br_mdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
>   
>   	rcu_read_lock();
>   
> -	cb->seq = net->dev_base_seq;
> -
>   	for_each_netdev_rcu(net, dev) {
>   		if (netif_is_bridge_master(dev)) {
>   			struct net_bridge *br = netdev_priv(dev);


Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
