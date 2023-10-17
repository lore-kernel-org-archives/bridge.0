Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4B6A60D58
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A5D660C1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533516; x=1698138316;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cQobCh/g2E6pWLZRUcsnyARFUdw85tRKijfEAX7VrEw=;
 b=ndYyrG+jkTgpf9sbGXdDItdnlyQ++vUWyc0DlynphO8KHXC5+U+A0XIibTdhlt+yj9
 IWgr0bglcHblez3cKw/Y5YoZ7tyGNLQpfeMhxknlcMdwLq06mCAzgcjPJVbCxGmpXQqL
 6XlMRyLVsnruox7fur/iY5KhjVNOUuJ5+aucBvtbqRKK855Ay2cQaQCTouE129cIkWMp
 uUxumasPraeu7ptqgGyHAQuwQVwcg1Ug1UA8EaptTOMNt9agYEA1NpUmSf57694Adwmt
 Ok+RGPzcoJaX2ywI9fPisGisU7UjzcfVBsnnbq53qW2rLQXpF7VZnsX+OrX185dBNB4w
 B+UA==
Message-ID: <48fcf444-f411-b4de-7ece-9ec2dfe89d47@blackwall.org>
Date: Tue, 17 Oct 2023 12:05:14 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-3-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 02/13] bridge: mcast: Account for
 missing attributes
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
> The 'MDBA_MDB' and 'MDBA_MDB_ENTRY' nest attributes are not accounted
> for when calculating the size of MDB notifications. Add them along with
> comments for existing attributes.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_mdb.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index fb58bb1b60e8..08de94bffc12 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -452,11 +452,18 @@ static int nlmsg_populate_mdb_fill(struct sk_buff *skb,
>   
>   static size_t rtnl_mdb_nlmsg_size(struct net_bridge_port_group *pg)
>   {
> -	size_t nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
> -			    nla_total_size(sizeof(struct br_mdb_entry)) +
> -			    nla_total_size(sizeof(u32));
>   	struct net_bridge_group_src *ent;
> -	size_t addr_size = 0;
> +	size_t nlmsg_size, addr_size = 0;
> +
> +	nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
> +		     /* MDBA_MDB */
> +		     nla_total_size(0) +
> +		     /* MDBA_MDB_ENTRY */
> +		     nla_total_size(0) +
> +		     /* MDBA_MDB_ENTRY_INFO */
> +		     nla_total_size(sizeof(struct br_mdb_entry)) +
> +		     /* MDBA_MDB_EATTR_TIMER */
> +		     nla_total_size(sizeof(u32));
>   
>   	if (!pg)
>   		goto out;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

