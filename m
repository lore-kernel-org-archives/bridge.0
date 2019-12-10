Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MrD+om9TBkSYCwn014kqk+zdnHlEqjwxKeMsL8n266U=;
 b=SQXE8iHhRMkzKkj40RQZzg7FUgeDG99RoN0Zo2OZmL/O81Q4ALXDkZ7qZbahdEQOGk
 WaZzfwwrVdLqZzRcG2vpKywz4KTTL06plNnhoQYTlr0KIP0TDCcua/0GkKffx0LaxBUX
 u6sGwATVL//MCGSSfZLMvzimqXrZRF7TmgKnY=
References: <20191210212050.1470909-1-vivien.didelot@gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <30e93cfb-cc2c-c484-a743-479cce19d8a9@cumulusnetworks.com>
Date: Tue, 10 Dec 2019 23:45:13 +0200
MIME-Version: 1.0
In-Reply-To: <20191210212050.1470909-1-vivien.didelot@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@gmail.com>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org

On 10/12/2019 23:20, Vivien Didelot wrote:
> This adds rx_bpdu, tx_bpdu, rx_tcn, tx_tcn, transition_blk,
> transition_fwd xstats counters to the bridge ports copied over via
> netlink, providing useful information for STP.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
> ---
>  include/uapi/linux/if_bridge.h | 10 ++++++++++
>  net/bridge/br_netlink.c        | 10 ++++++++++
>  net/bridge/br_private.h        |  2 ++
>  net/bridge/br_stp.c            | 15 +++++++++++++++
>  net/bridge/br_stp_bpdu.c       |  4 ++++
>  5 files changed, 41 insertions(+)
> 

Hi,
I like it! Unfortunately there is one issue still, more below.

> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index 1b3c2b643a02..e7f2bb782006 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -156,6 +156,15 @@ struct bridge_vlan_xstats {
>  	__u32 pad2;
>  };
>  
> +struct bridge_stp_xstats {
> +	__u64 transition_blk;
> +	__u64 transition_fwd;
> +	__u64 rx_bpdu;
> +	__u64 tx_bpdu;
> +	__u64 rx_tcn;
> +	__u64 tx_tcn;
> +};
> +
>  /* Bridge multicast database attributes
>   * [MDBA_MDB] = {
>   *     [MDBA_MDB_ENTRY] = {
> @@ -261,6 +270,7 @@ enum {
>  	BRIDGE_XSTATS_UNSPEC,
>  	BRIDGE_XSTATS_VLAN,
>  	BRIDGE_XSTATS_MCAST,
> +	BRIDGE_XSTATS_STP,
>  	BRIDGE_XSTATS_PAD,
>  	__BRIDGE_XSTATS_MAX
>  };
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index a0a54482aabc..d339cc314357 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1597,6 +1597,16 @@ static int br_fill_linkxstats(struct sk_buff *skb,
>  		}
>  	}
>  
> +	if (p) {
> +		nla = nla_reserve_64bit(skb, BRIDGE_XSTATS_STP,
> +					sizeof(p->stp_xstats),
> +					BRIDGE_XSTATS_PAD);
> +		if (!nla)
> +			goto nla_put_failure;
> +
> +		memcpy(nla_data(nla), &p->stp_xstats, sizeof(p->stp_xstats));

You need to take the STP lock here to get a proper snapshot of the values.

> +	}
> +
>  #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>  	if (++vl_idx >= *prividx) {
>  		nla = nla_reserve_64bit(skb, BRIDGE_XSTATS_MCAST,
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 36b0367ca1e0..f540f3bdf294 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -283,6 +283,8 @@ struct net_bridge_port {
>  #endif
>  	u16				group_fwd_mask;
>  	u16				backup_redirected_cnt;
> +
> +	struct bridge_stp_xstats	stp_xstats;
>  };
>  
>  #define kobj_to_brport(obj)	container_of(obj, struct net_bridge_port, kobj)
> diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
> index 1f1410f8d312..6856a6d9282b 100644
> --- a/net/bridge/br_stp.c
> +++ b/net/bridge/br_stp.c
> @@ -45,6 +45,17 @@ void br_set_state(struct net_bridge_port *p, unsigned int state)
>  		br_info(p->br, "port %u(%s) entered %s state\n",
>  				(unsigned int) p->port_no, p->dev->name,
>  				br_port_state_names[p->state]);
> +
> +	if (p->br->stp_enabled == BR_KERNEL_STP) {
> +		switch (p->state) {
> +		case BR_STATE_BLOCKING:
> +			p->stp_xstats.transition_blk++;
> +			break;
> +		case BR_STATE_FORWARDING:
> +			p->stp_xstats.transition_fwd++;
> +			break;
> +		}
> +	}
>  }
>  
>  /* called under bridge lock */
> @@ -484,6 +495,8 @@ void br_received_config_bpdu(struct net_bridge_port *p,
>  	struct net_bridge *br;
>  	int was_root;
>  
> +	p->stp_xstats.rx_bpdu++;
> +
>  	br = p->br;
>  	was_root = br_is_root_bridge(br);
>  
> @@ -517,6 +530,8 @@ void br_received_config_bpdu(struct net_bridge_port *p,
>  /* called under bridge lock */
>  void br_received_tcn_bpdu(struct net_bridge_port *p)
>  {
> +	p->stp_xstats.rx_tcn++;
> +
>  	if (br_is_designated_port(p)) {
>  		br_info(p->br, "port %u(%s) received tcn bpdu\n",
>  			(unsigned int) p->port_no, p->dev->name);
> diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
> index 7796dd9d42d7..0e4572f31330 100644
> --- a/net/bridge/br_stp_bpdu.c
> +++ b/net/bridge/br_stp_bpdu.c
> @@ -118,6 +118,8 @@ void br_send_config_bpdu(struct net_bridge_port *p, struct br_config_bpdu *bpdu)
>  	br_set_ticks(buf+33, bpdu->forward_delay);
>  
>  	br_send_bpdu(p, buf, 35);
> +
> +	p->stp_xstats.tx_bpdu++;
>  }
>  
>  /* called under bridge lock */
> @@ -133,6 +135,8 @@ void br_send_tcn_bpdu(struct net_bridge_port *p)
>  	buf[2] = 0;
>  	buf[3] = BPDU_TYPE_TCN;
>  	br_send_bpdu(p, buf, 4);
> +
> +	p->stp_xstats.tx_tcn++;
>  }
>  
>  /*
> 

