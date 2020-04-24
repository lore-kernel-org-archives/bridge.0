Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=RGGRDHQXBK1Kdt01wMsi8QUeYk6tmntpaLA8lOBA4Cc=;
 b=AFGvXf/LbemwYbd/hy+qejDSTYCV2URKhbr5e0DiAh1ZiILkYDSFqTBcT5tJYz5/Y8
 tVlneqaJEGCJNVIFOPLB8vA3SkGLzyn26pgKO0KsuH0iVCHuPT9JOGtJ1za0TLc0mXdm
 MG9J4Ep6CknCQScPkd7eE+E+7hCYPtYZzwxPE=
References: <20200422161833.1123-1-horatiu.vultur@microchip.com>
 <20200422161833.1123-5-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <1f2767bf-8ca4-781f-b35a-1ed5a169c206@cumulusnetworks.com>
Date: Fri, 24 Apr 2020 16:12:36 +0300
MIME-Version: 1.0
In-Reply-To: <20200422161833.1123-5-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 04/11] net: bridge: Add port
 attribute IFLA_BRPORT_MRP_RING_OPEN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 22/04/2020 19:18, Horatiu Vultur wrote:
> This patch adds a new port attribute, IFLA_BRPORT_MRP_RING_OPEN, which allows
> to notify the userspace when the port lost the continuite of MRP frames.
> 
> This attribute is set by kernel whenever the SW or HW detects that the ring is
> being open or closed.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/uapi/linux/if_link.h       | 1 +
>  net/bridge/br_netlink.c            | 3 +++
>  tools/include/uapi/linux/if_link.h | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 61e0801c82df..4a295deb933b 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -343,6 +343,7 @@ enum {
>  	IFLA_BRPORT_NEIGH_SUPPRESS,
>  	IFLA_BRPORT_ISOLATED,
>  	IFLA_BRPORT_BACKUP_PORT,
> +	IFLA_BRPORT_MRP_RING_OPEN,
>  	__IFLA_BRPORT_MAX
>  };
>  #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 43dab4066f91..4084f1ef8641 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -151,6 +151,7 @@ static inline size_t br_port_info_size(void)
>  		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MULTICAST_ROUTER */
>  #endif
>  		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_GROUP_FWD_MASK */
> +		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MRP_RING_OPEN */
>  		+ 0;
>  }
>  
> @@ -213,6 +214,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
>  	    nla_put_u16(skb, IFLA_BRPORT_GROUP_FWD_MASK, p->group_fwd_mask) ||
>  	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_SUPPRESS,
>  		       !!(p->flags & BR_NEIGH_SUPPRESS)) ||
> +	    nla_put_u8(skb, IFLA_BRPORT_MRP_RING_OPEN, !!(p->flags &
> +							  BR_MRP_LOST_CONT)) ||
>  	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)))
>  		return -EMSGSIZE;
>  
> diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
> index 024af2d1d0af..70dae9ba16f4 100644
> --- a/tools/include/uapi/linux/if_link.h
> +++ b/tools/include/uapi/linux/if_link.h
> @@ -343,6 +343,7 @@ enum {
>  	IFLA_BRPORT_NEIGH_SUPPRESS,
>  	IFLA_BRPORT_ISOLATED,
>  	IFLA_BRPORT_BACKUP_PORT,
> +	IFLA_BRPORT_MRP_RING_OPEN,
>  	__IFLA_BRPORT_MAX
>  };
>  #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

