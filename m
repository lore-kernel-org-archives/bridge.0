Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=aTJ3Rcwa/grjzVIqzKxKgdaenS1CE6YbOTpZIMshk7Q=;
 b=MtRuyZA8wAUOQH0SLfWm2UNNYnjptVw+pJPfiXxotJo3wrtwQRLpbEMxQQTuF8raxF
 WJuJjCmNl4kWnJzBoUNhuKk+AC3ZK/f4GS+Mj00uVX1r+SdtAp5EgcVN11d+gOPUBZw9
 ZJlhE9j2mHJI8UXLBmLsdePeGc7Mp4LXa3RNQ=
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-2-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <a90c8980-fb9f-2bf2-16d2-c9878ce55cf3@cumulusnetworks.com>
Date: Tue, 14 Jul 2020 16:30:00 +0300
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 01/12] switchdev: mrp: Extend
 switchdev API for MRP Interconnect
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
> Extend switchdev API to add support for MRP interconnect. The HW is
> notified in the following cases:
> 
> SWITCHDEV_OBJ_ID_IN_ROLE_MRP: This is used when the interconnect role
>   of the node changes. The supported roles are MIM and MIC.
> 
> SWITCHDEV_OBJ_ID_IN_STATE_MRP: This is used when the interconnect ring
>   changes it states to open or closed.
> 
> SWITCHDEV_OBJ_ID_IN_TEST_MRP: This is used to start/stop sending
>   MRP_InTest frames on all MRP ports. This is called only on nodes that
>   have the interconnect role MIM.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/net/switchdev.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index b8c059b4e06d9..ff22469143013 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -76,6 +76,10 @@ enum switchdev_obj_id {
>  	SWITCHDEV_OBJ_ID_RING_TEST_MRP,
>  	SWITCHDEV_OBJ_ID_RING_ROLE_MRP,
>  	SWITCHDEV_OBJ_ID_RING_STATE_MRP,
> +	SWITCHDEV_OBJ_ID_IN_TEST_MRP,
> +	SWITCHDEV_OBJ_ID_IN_ROLE_MRP,
> +	SWITCHDEV_OBJ_ID_IN_STATE_MRP,
> +
>  #endif
>  };
>  
> @@ -155,6 +159,40 @@ struct switchdev_obj_ring_state_mrp {
>  #define SWITCHDEV_OBJ_RING_STATE_MRP(OBJ) \
>  	container_of((OBJ), struct switchdev_obj_ring_state_mrp, obj)
>  
> +/* SWITCHDEV_OBJ_ID_IN_TEST_MRP */
> +struct switchdev_obj_in_test_mrp {
> +	struct switchdev_obj obj;
> +	/* The value is in us and a value of 0 represents to stop */
> +	u32 interval;
> +	u32 in_id;
> +	u32 period;
> +	u8 max_miss;
> +};
> +
> +#define SWITCHDEV_OBJ_IN_TEST_MRP(OBJ) \
> +	container_of((OBJ), struct switchdev_obj_in_test_mrp, obj)
> +
> +/* SWICHDEV_OBJ_ID_IN_ROLE_MRP */
> +struct switchdev_obj_in_role_mrp {
> +	struct switchdev_obj obj;
> +	struct net_device *i_port;
> +	u32 ring_id;
> +	u16 in_id;
> +	u8 in_role;
> +};
> +
> +#define SWITCHDEV_OBJ_IN_ROLE_MRP(OBJ) \
> +	container_of((OBJ), struct switchdev_obj_in_role_mrp, obj)
> +
> +struct switchdev_obj_in_state_mrp {
> +	struct switchdev_obj obj;
> +	u32 in_id;
> +	u8 in_state;
> +};
> +
> +#define SWITCHDEV_OBJ_IN_STATE_MRP(OBJ) \
> +	container_of((OBJ), struct switchdev_obj_in_state_mrp, obj)
> +
>  #endif
>  
>  typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
> 

