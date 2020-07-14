Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=4HmbsAMObqZGkcA7hG2xxjCG9/cCH7z4XX9t73gu4dA=;
 b=CKze1TiGSjQXnD3dI9mZXRtyO4KfBx8rTKNJ8UMhhZQSrGx+pjmc9KjDpI7Cc0kSq/
 Tal5/+YoT/X7tfFnhfBVNm1c4dJgWaW+ELwMYSS9B3sZrVr4mYAZo+MDrc55iDGVlEiV
 Lye0yBzgrwUHplVBuYa9OjhsyborjclEK4lWo=
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-13-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <9eeb89c5-865f-2b21-c7c6-7f4479bf4175@cumulusnetworks.com>
Date: Tue, 14 Jul 2020 16:29:33 +0300
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-13-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 12/12] net: bridge: Add port
 attribute IFLA_BRPORT_MRP_IN_OPEN
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
> This patch adds a new port attribute, IFLA_BRPORT_MRP_IN_OPEN, which
> allows to notify the userspace when the node lost the contiuity of
> MRP_InTest frames.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/uapi/linux/if_link.h       | 1 +
>  net/bridge/br_netlink.c            | 3 +++
>  tools/include/uapi/linux/if_link.h | 1 +
>  3 files changed, 5 insertions(+)
> 

It's kind of late by now, but I'd wish these were contained in a nested MRP attribute. :)
Horatiu, do you expect to have many more MRP attributes outside of MRP netlink code?

Perhaps we should at least dump them only for MRP-aware ports, that should be easy.
They make no sense outside of MRP anyway, but increase the size of the dump for all
right now.

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index cc185a007ade8..26842ffd0501d 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -344,6 +344,7 @@ enum {
>  	IFLA_BRPORT_ISOLATED,
>  	IFLA_BRPORT_BACKUP_PORT,
>  	IFLA_BRPORT_MRP_RING_OPEN,
> +	IFLA_BRPORT_MRP_IN_OPEN,
>  	__IFLA_BRPORT_MAX
>  };
>  #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index c532fa65c9834..147d52596e174 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -152,6 +152,7 @@ static inline size_t br_port_info_size(void)
>  #endif
>  		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_GROUP_FWD_MASK */
>  		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MRP_RING_OPEN */
> +		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MRP_IN_OPEN */
>  		+ 0;
>  }
>  
> @@ -216,6 +217,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
>  		       !!(p->flags & BR_NEIGH_SUPPRESS)) ||
>  	    nla_put_u8(skb, IFLA_BRPORT_MRP_RING_OPEN, !!(p->flags &
>  							  BR_MRP_LOST_CONT)) ||
> +	    nla_put_u8(skb, IFLA_BRPORT_MRP_IN_OPEN,
> +		       !!(p->flags & BR_MRP_LOST_IN_CONT)) ||
>  	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)))
>  		return -EMSGSIZE;
>  
> diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
> index cafedbbfefbe9..781e482dc499f 100644
> --- a/tools/include/uapi/linux/if_link.h
> +++ b/tools/include/uapi/linux/if_link.h
> @@ -344,6 +344,7 @@ enum {
>  	IFLA_BRPORT_ISOLATED,
>  	IFLA_BRPORT_BACKUP_PORT,
>  	IFLA_BRPORT_MRP_RING_OPEN,
> +	IFLA_BRPORT_MRP_IN_OPEN,
>  	__IFLA_BRPORT_MAX
>  };
>  #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
> 

