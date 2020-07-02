Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=P8VRDASVxiHXInnBJtuHCeHYaC40885qiMW2neBVGgE=;
 b=QS1Ajp3cV7aOZj2W/e8M7r19JKqzcKjR9Nbbui47IRXJsgYLKZYFd18KBNAHM/1Xh6
 kKAurfe2x5ZGNsjp8VGOXf+rzXBnax/oYbBY3V1KXhHZ/Ay6pwqSM9xwHMcsAE2ii8FD
 7mScoEd8ZomV9oC0vYU/2nLHjjQ9QMnePWuo8=
References: <20200702081307.933471-1-horatiu.vultur@microchip.com>
 <20200702081307.933471-2-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <4b46f59a-2676-6efd-fddf-c0fcbebdce0f@cumulusnetworks.com>
Date: Thu, 2 Jul 2020 13:01:26 +0300
MIME-Version: 1.0
In-Reply-To: <20200702081307.933471-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 1/3] bridge: uapi: mrp: Extend MRP
 attributes to get the status
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@mellanox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com

On 02/07/2020 11:13, Horatiu Vultur wrote:
> Add MRP attribute IFLA_BRIDGE_MRP_INFO to allow the userspace to get the
> current state of the MRP instances. This is a nested attribute that
> contains other attributes like, ring id, index of primary and secondary
> port, priority, ring state, ring role.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/uapi/linux/if_bridge.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index caa6914a3e53a..c114c1c2bd533 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -166,6 +166,7 @@ enum {
>  	IFLA_BRIDGE_MRP_RING_STATE,
>  	IFLA_BRIDGE_MRP_RING_ROLE,
>  	IFLA_BRIDGE_MRP_START_TEST,
> +	IFLA_BRIDGE_MRP_INFO,
>  	__IFLA_BRIDGE_MRP_MAX,
>  };
>  
> @@ -228,6 +229,22 @@ enum {
>  
>  #define IFLA_BRIDGE_MRP_START_TEST_MAX (__IFLA_BRIDGE_MRP_START_TEST_MAX - 1)
>  
> +enum {
> +	IFLA_BRIDGE_MRP_INFO_UNSPEC,
> +	IFLA_BRIDGE_MRP_INFO_RING_ID,
> +	IFLA_BRIDGE_MRP_INFO_P_IFINDEX,
> +	IFLA_BRIDGE_MRP_INFO_S_IFINDEX,
> +	IFLA_BRIDGE_MRP_INFO_PRIO,
> +	IFLA_BRIDGE_MRP_INFO_RING_STATE,
> +	IFLA_BRIDGE_MRP_INFO_RING_ROLE,
> +	IFLA_BRIDGE_MRP_INFO_TEST_INTERVAL,
> +	IFLA_BRIDGE_MRP_INFO_TEST_MAX_MISS,
> +	IFLA_BRIDGE_MRP_INFO_TEST_MONITOR,
> +	__IFLA_BRIDGE_MRP_INFO_MAX,
> +};
> +
> +#define IFLA_BRIDGE_MRP_INFO_MAX (__IFLA_BRIDGE_MRP_INFO_MAX - 1)
> +
>  struct br_mrp_instance {
>  	__u32 ring_id;
>  	__u32 p_ifindex;
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

