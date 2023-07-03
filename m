Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C8CC60B51
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7B4560BF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzP8j7FqKxWCkjQov6LxVw8G6n34G9OH4AN7593wq1M=;
 b=tTnqXIiU4bj4cKTcs6tkzF08W3KD+hgcEO8TGzkMO4b7634y/OtmPtj9vsMMrY4JuvDpRHZGzEgY4jap2C3XtLE184iGAWYl31hw8+8+q+abOuIBzFSQQzE3AjavrNTPHBjcYwDMF3Qk39tCDHe7qQaTF0OoLoy/R9AGvm4VvdoKW2a6Kl61mbZvPnB4ZHmVRs4nelboyN/TNFn+BG4nvYrHzLnrupjWAwfYAoNbpNRP65w38PhWDa9zK5aBgPuSywNGjaMp75EBV3JB9d9NbVb7bRcRkD5g64aNbTkfWgLeqtyfwg9FaEuz+Cd82h/43Ee8/TooHpBEn+UoMSgF0A==
Date: Mon, 3 Jul 2023 11:00:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZKKADtxlXyPmBvbr@shredder>
References: <20230630164118.1526679-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630164118.1526679-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] net: bridge: keep ports without
 IFF_UNICAST_FLT in BR_PROMISC mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vlad Yasevich <vyasevic@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Fri, Jun 30, 2023 at 07:41:18PM +0300, Vladimir Oltean wrote:
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index 3f04b40f6056..2450690f98cf 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -166,8 +166,9 @@ void br_manage_promisc(struct net_bridge *br)
>  			 * This lets us disable promiscuous mode and write
>  			 * this config to hw.
>  			 */
> -			if (br->auto_cnt == 0 ||
> -			    (br->auto_cnt == 1 && br_auto_port(p)))
> +			if ((p->dev->priv_flags & IFF_UNICAST_FLT) &&
> +			    (br->auto_cnt == 0 ||
> +			     (br->auto_cnt == 1 && br_auto_port(p))))
>  				br_port_clear_promisc(p);
>  			else
>  				br_port_set_promisc(p);

IIUC, you are basically saying "If the port does not support unicast
filtering, then set it to promiscuous mode right away instead of waiting
for the addition of the first FDB entry to trigger it."

If so, LGTM.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Tested using [1].

Before:

# ~/tmp/promisc_repo.sh 
0

After:

# ~/tmp/promisc_repo.sh 
1

[1]
#!/bin/bash

ip link add name swp1 type dummy
ip link add name br1 type bridge vlan_filtering 1
ip link set dev swp1 master br1
ip -d -j -p link show dev swp1 | jq '.[]["promiscuity"]'
