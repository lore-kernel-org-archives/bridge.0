Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=FxJqrHhg0G0ncHUrHEuIRffmrZYQGuHLCnGks1j1bQM=;
 b=TqSa14w7dWnNYezldSLiuWoHhgo2zcjASexkPXEh+2iGpB2nAcR54Vdz6cuj8Oz9B0
 atzp+jjuGO56jmDKvCcRCNrZPIRHALoy+bV3oqGvUCCyB/SO9HPvF1qSUL8iyjwiM2ZN
 r950qHEUsa//TUKVU5SBVVDe1V/hqHRyghU+A=
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-6-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <622d77e3-6ea0-9a5e-2745-4231dd40b1e8@cumulusnetworks.com>
Date: Tue, 14 Jul 2020 16:15:47 +0300
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-6-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 05/12] bridge: mrp: Rename
 br_mrp_port_open to br_mrp_ring_port_open
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org

On 14/07/2020 10:34, Horatiu Vultur wrote:
> This patch renames the function br_mrp_port_open to
> br_mrp_ring_port_open. In this way is more clear that a ring port lost
> the continuity because there will be also a br_mrp_in_port_open.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp.c         | 6 +++---
>  net/bridge/br_mrp_netlink.c | 2 +-
>  net/bridge/br_private_mrp.h | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index 90592af9db619..fe7cf1446b58a 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -213,7 +213,7 @@ static void br_mrp_test_work_expired(struct work_struct *work)
>  		}
>  
>  		if (notify_open && !mrp->ring_role_offloaded)
> -			br_mrp_port_open(p->dev, true);
> +			br_mrp_ring_port_open(p->dev, true);
>  	}
>  
>  	p = rcu_dereference(mrp->s_port);
> @@ -229,7 +229,7 @@ static void br_mrp_test_work_expired(struct work_struct *work)
>  		}
>  
>  		if (notify_open && !mrp->ring_role_offloaded)
> -			br_mrp_port_open(p->dev, true);
> +			br_mrp_ring_port_open(p->dev, true);
>  	}
>  
>  out:
> @@ -537,7 +537,7 @@ static void br_mrp_mrm_process(struct br_mrp *mrp, struct net_bridge_port *port,
>  	 * not closed
>  	 */
>  	if (mrp->ring_state != BR_MRP_RING_STATE_CLOSED)
> -		br_mrp_port_open(port->dev, false);
> +		br_mrp_ring_port_open(port->dev, false);
>  }
>  
>  /* Determin if the test hdr has a better priority than the node */
> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index c4f5c356811f3..acce300c0cc29 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -368,7 +368,7 @@ int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
>  	return -EMSGSIZE;
>  }
>  
> -int br_mrp_port_open(struct net_device *dev, u8 loc)
> +int br_mrp_ring_port_open(struct net_device *dev, u8 loc)
>  {
>  	struct net_bridge_port *p;
>  	int err = 0;
> diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
> index 8841ba847fb29..e93c8f9d4df58 100644
> --- a/net/bridge/br_private_mrp.h
> +++ b/net/bridge/br_private_mrp.h
> @@ -74,6 +74,6 @@ int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
>  				   enum br_mrp_port_role_type role);
>  
>  /* br_mrp_netlink.c  */
> -int br_mrp_port_open(struct net_device *dev, u8 loc);
> +int br_mrp_ring_port_open(struct net_device *dev, u8 loc);
>  
>  #endif /* _BR_PRIVATE_MRP_H */
> 

