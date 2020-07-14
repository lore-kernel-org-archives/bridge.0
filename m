Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=nYoU871Umg8pEf23KuBXa9TezOsCAc9WN1U0Sl9RtIM=;
 b=IKJTtDfzeJQfWdYO3heTD4AUKay2Q9U3WgHKSIs9DMTrGNvvwvNPspmItSSofgH85t
 DeknG4Z2W7z2mUjqPiyM5SdQ4yzp4iuRqD2aT130/Lfl1oBY4MhW/IAltTMHMHlhtD84
 YPNNvDxICENWTM3CaBygQGClu7JAVS22NxZPo=
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-8-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <f0c67d68-b181-4a79-9d7c-a8810c3bfd70@cumulusnetworks.com>
Date: Tue, 14 Jul 2020 16:16:30 +0300
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-8-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 07/12] bridge: switchdev: mrp:
 Extend MRP API for switchdev for MRP Interconnect
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
> Implement the MRP API for interconnect switchdev. Similar with the other
> br_mrp_switchdev function, these function will just eventually call the
> switchdev functions: switchdev_port_obj_add/del.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp_switchdev.c | 62 +++++++++++++++++++++++++++++++++++
>  net/bridge/br_private_mrp.h   |  7 ++++
>  2 files changed, 69 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_mrp_switchdev.c b/net/bridge/br_mrp_switchdev.c
> index 0da68a0da4b5a..ed547e03ace17 100644
> --- a/net/bridge/br_mrp_switchdev.c
> +++ b/net/bridge/br_mrp_switchdev.c
> @@ -107,6 +107,68 @@ int br_mrp_switchdev_set_ring_state(struct net_bridge *br,
>  	return 0;
>  }
>  
> +int br_mrp_switchdev_set_in_role(struct net_bridge *br, struct br_mrp *mrp,
> +				 u16 in_id, u32 ring_id,
> +				 enum br_mrp_in_role_type role)
> +{
> +	struct switchdev_obj_in_role_mrp mrp_role = {
> +		.obj.orig_dev = br->dev,
> +		.obj.id = SWITCHDEV_OBJ_ID_IN_ROLE_MRP,
> +		.in_role = role,
> +		.in_id = mrp->in_id,
> +		.ring_id = mrp->ring_id,
> +		.i_port = rtnl_dereference(mrp->i_port)->dev,
> +	};
> +	int err;
> +
> +	if (role == BR_MRP_IN_ROLE_DISABLED)
> +		err = switchdev_port_obj_del(br->dev, &mrp_role.obj);
> +	else
> +		err = switchdev_port_obj_add(br->dev, &mrp_role.obj, NULL);
> +
> +	return err;
> +}
> +
> +int br_mrp_switchdev_set_in_state(struct net_bridge *br, struct br_mrp *mrp,
> +				  enum br_mrp_in_state_type state)
> +{
> +	struct switchdev_obj_in_state_mrp mrp_state = {
> +		.obj.orig_dev = br->dev,
> +		.obj.id = SWITCHDEV_OBJ_ID_IN_STATE_MRP,
> +		.in_state = state,
> +		.in_id = mrp->in_id,
> +	};
> +	int err;
> +
> +	err = switchdev_port_obj_add(br->dev, &mrp_state.obj, NULL);
> +
> +	if (err && err != -EOPNOTSUPP)
> +		return err;
> +
> +	return 0;
> +}
> +
> +int br_mrp_switchdev_send_in_test(struct net_bridge *br, struct br_mrp *mrp,
> +				  u32 interval, u8 max_miss, u32 period)
> +{
> +	struct switchdev_obj_in_test_mrp test = {
> +		.obj.orig_dev = br->dev,
> +		.obj.id = SWITCHDEV_OBJ_ID_IN_TEST_MRP,
> +		.interval = interval,
> +		.max_miss = max_miss,
> +		.in_id = mrp->in_id,
> +		.period = period,
> +	};
> +	int err;
> +
> +	if (interval == 0)
> +		err = switchdev_port_obj_del(br->dev, &test.obj);
> +	else
> +		err = switchdev_port_obj_add(br->dev, &test.obj, NULL);
> +
> +	return err;
> +}
> +
>  int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
>  				    enum br_mrp_port_state_type state)
>  {
> diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
> index 23da2f956ad0e..0d554ef88db85 100644
> --- a/net/bridge/br_private_mrp.h
> +++ b/net/bridge/br_private_mrp.h
> @@ -72,6 +72,13 @@ int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
>  				    enum br_mrp_port_state_type state);
>  int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
>  				   enum br_mrp_port_role_type role);
> +int br_mrp_switchdev_set_in_role(struct net_bridge *br, struct br_mrp *mrp,
> +				 u16 in_id, u32 ring_id,
> +				 enum br_mrp_in_role_type role);
> +int br_mrp_switchdev_set_in_state(struct net_bridge *br, struct br_mrp *mrp,
> +				  enum br_mrp_in_state_type state);
> +int br_mrp_switchdev_send_in_test(struct net_bridge *br, struct br_mrp *mrp,
> +				  u32 interval, u8 max_miss, u32 period);
>  
>  /* br_mrp_netlink.c  */
>  int br_mrp_ring_port_open(struct net_device *dev, u8 loc);
> 

