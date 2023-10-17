Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D89681065
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94D0381000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533495; x=1698138295;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GLkwIKpccGDhl2g/IAel1atWebFPpXTz7dxlcfet/9o=;
 b=U8Qbso5jZ5daFm9jwzXj5Xydw0+nens/Kf4+P3Tr9YC7yVyunTLys39dOrLT6b7aaq
 9nFQxRSDzxgdrE2EviRU8lj5aF78ZDuQwthyRvRqp6Q2yDeO3O+XujRbHLbMaBpfCiDZ
 gk+WWBc/M3IDKx7on0R4/DdlZgnVAtAyOho+YRuhcuz+xjm+IUDbqUtMMwX7hEmflzf7
 a83F0v9ZCSdUvpJ3u5qn+w2Gp3XqWoigowBT1bwekCZ5ZiWJ/6fB7yXxc/ue0TxoWd45
 4z4Spn3prccWUz+/nGkgvzLlEucQXU6j6k8FUKsVBUniRwKXLWytij77EEJKjqmBGMt6
 BRsg==
Message-ID: <6a6a2919-c414-0b13-9488-2c81655c2b8a@blackwall.org>
Date: Tue, 17 Oct 2023 12:04:52 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-2-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 01/13] bridge: mcast: Dump MDB entries
 even when snooping is disabled
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
> Currently, the bridge driver does not dump MDB entries when multicast
> snooping is disabled although the entries are present in the kernel:
> 
>   # bridge mdb add dev br0 port swp1 grp 239.1.1.1 permanent
>   # bridge mdb show dev br0
>   dev br0 port swp1 grp 239.1.1.1 permanent
>   dev br0 port br0 grp ff02::6a temp
>   dev br0 port br0 grp ff02::1:ff9d:e61b temp
>   # ip link set dev br0 type bridge mcast_snooping 0
>   # bridge mdb show dev br0
>   # ip link set dev br0 type bridge mcast_snooping 1
>   # bridge mdb show dev br0
>   dev br0 port swp1 grp 239.1.1.1 permanent
>   dev br0 port br0 grp ff02::6a temp
>   dev br0 port br0 grp ff02::1:ff9d:e61b temp
> 
> This behavior differs from other netlink dump interfaces that dump
> entries regardless if they are used or not. For example, VLANs are
> dumped even when VLAN filtering is disabled:
> 
>   # ip link set dev br0 type bridge vlan_filtering 0
>   # bridge vlan show dev swp1
>   port              vlan-id
>   swp1              1 PVID Egress Untagged
> 
> Remove the check and always dump MDB entries:
> 
>   # bridge mdb add dev br0 port swp1 grp 239.1.1.1 permanent
>   # bridge mdb show dev br0
>   dev br0 port swp1 grp 239.1.1.1 permanent
>   dev br0 port br0 grp ff02::6a temp
>   dev br0 port br0 grp ff02::1:ffeb:1a4d temp
>   # ip link set dev br0 type bridge mcast_snooping 0
>   # bridge mdb show dev br0
>   dev br0 port swp1 grp 239.1.1.1 permanent
>   dev br0 port br0 grp ff02::6a temp
>   dev br0 port br0 grp ff02::1:ffeb:1a4d temp
>   # ip link set dev br0 type bridge mcast_snooping 1
>   # bridge mdb show dev br0
>   dev br0 port swp1 grp 239.1.1.1 permanent
>   dev br0 port br0 grp ff02::6a temp
>   dev br0 port br0 grp ff02::1:ffeb:1a4d temp
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_mdb.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 7305f5f8215c..fb58bb1b60e8 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -323,9 +323,6 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
>   	struct net_bridge_mdb_entry *mp;
>   	struct nlattr *nest, *nest2;
>   
> -	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
> -		return 0;
> -
>   	nest = nla_nest_start_noflag(skb, MDBA_MDB);
>   	if (nest == NULL)
>   		return -EMSGSIZE;

Finally! Thanks :) this has been a long-standing annoyance.
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

