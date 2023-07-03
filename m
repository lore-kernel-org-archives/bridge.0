Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E38FC80F55
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E05580C60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfMmwAPMTE2TepUyRH88vBdeIw/bsMvnWZOks/nHhqk=;
 b=YwGu4JMIsTZKViZOYpGPngMHa+L8ONa14MKFyKAHQc3sYHLUC73nlrhE0J4IlQWUbLTwYsKUeOzCnx6zo/ct9NVrGTxkTssXHkJ4XhiTr7kZs1rHjK6F40UKlDDv+3w6ODqpLka5XD7+X+456PkM+lzSPAIGYop8aD3vD5pvcfA=
Date: Mon, 3 Jul 2023 19:08:26 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-ID: <20230703160826.5wx5mmszr67hvjmw@skbuf>
References: <20230630164118.1526679-1-vladimir.oltean@nxp.com>
 <ZKKADtxlXyPmBvbr@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKKADtxlXyPmBvbr@shredder>
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
To: Ido Schimmel <idosch@nvidia.com>
Cc: Vlad Yasevich <vyasevic@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Mon, Jul 03, 2023 at 11:00:14AM +0300, Ido Schimmel wrote:
> On Fri, Jun 30, 2023 at 07:41:18PM +0300, Vladimir Oltean wrote:
> > diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> > index 3f04b40f6056..2450690f98cf 100644
> > --- a/net/bridge/br_if.c
> > +++ b/net/bridge/br_if.c
> > @@ -166,8 +166,9 @@ void br_manage_promisc(struct net_bridge *br)
> >  			 * This lets us disable promiscuous mode and write
> >  			 * this config to hw.
> >  			 */
> > -			if (br->auto_cnt == 0 ||
> > -			    (br->auto_cnt == 1 && br_auto_port(p)))
> > +			if ((p->dev->priv_flags & IFF_UNICAST_FLT) &&
> > +			    (br->auto_cnt == 0 ||
> > +			     (br->auto_cnt == 1 && br_auto_port(p))))
> >  				br_port_clear_promisc(p);
> >  			else
> >  				br_port_set_promisc(p);
> 
> IIUC, you are basically saying "If the port does not support unicast
> filtering, then set it to promiscuous mode right away instead of waiting
> for the addition of the first FDB entry to trigger it."

Correct.

> If so, LGTM.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> Tested using [1].
> 
> Before:
> 
> # ~/tmp/promisc_repo.sh 
> 0
> 
> After:
> 
> # ~/tmp/promisc_repo.sh 
> 1
> 
> [1]
> #!/bin/bash
> 
> ip link add name swp1 type dummy
> ip link add name br1 type bridge vlan_filtering 1
> ip link set dev swp1 master br1
> ip -d -j -p link show dev swp1 | jq '.[]["promiscuity"]'

Thanks for testing.
