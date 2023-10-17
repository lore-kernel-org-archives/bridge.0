Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE1AB41528
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AFE9541518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533729; x=1698138529;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=978qXrc9YEW7M0wZEw9ore1peLfv22bFLkhcrdH2ft8=;
 b=WsWzX0a4ey6g+I73/q1JIWrvJjlPDzSNAmdgy+pcFhamvI+C9tEXUO/6YmQQu5x8LS
 SddUKJNeI8wWSKGmF09fnUNxel4xQroBKJYc/oU4t/p2LpJrCB75MNnEut7Gm89yvQh5
 C80CNqOTm4CaDsud64rZy78y993ZoNnYazrQJBSX3V3OA2Qx+HBDyL90K97Fda2AyVaE
 pnTprlkSNQKESHxFQ2QZAVl9RG3luBBU3RtsmcrzVOYMiKSg4b53SRN5iQ7U+9eXczq1
 3MSndBUqfJuN/C3LwyXnY5Oj3KCeajp4rfW/FdUytYceV/DjORtfBaRMoLVWZ5rIk5dT
 jZlg==
Message-ID: <8558d00c-ae0c-54dc-8b41-4feeb991f8f8@blackwall.org>
Date: Tue, 17 Oct 2023 12:08:47 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-9-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-9-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 08/13] net: Add MDB get device
	operation
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
> Add MDB net device operation that will be invoked by rtnetlink code in
> response to received RTM_GETMDB messages. Subsequent patches will
> implement the operation in the bridge and VXLAN drivers.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   include/linux/netdevice.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1c7681263d30..18376b65dc61 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1586,6 +1586,10 @@ struct net_device_ops {
>   	int			(*ndo_mdb_dump)(struct net_device *dev,
>   						struct sk_buff *skb,
>   						struct netlink_callback *cb);
> +	int			(*ndo_mdb_get)(struct net_device *dev,
> +					       struct nlattr *tb[], u32 portid,
> +					       u32 seq,
> +					       struct netlink_ext_ack *extack);
>   	int			(*ndo_bridge_setlink)(struct net_device *dev,
>   						      struct nlmsghdr *nlh,
>   						      u16 flags,

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


