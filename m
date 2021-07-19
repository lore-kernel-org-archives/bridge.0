Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jibvRJ8x4gDFYeeL7+2QzukIzWDDAy7tWepHyOMPSYk=;
 b=WmzljnzfdyCKejRVwaGUTWf32CFVrEe05Hp/D3gKkNwRLzGfz5I2l3tw6eQbc4NgTr
 +B7WFDq93w/dbGeQWaoLroU4EwWddE/Scvdk09ShsO3fS1+SCSOHiYBvm92eRG/vjwy6
 HgfGFB8GGLrzwzuUfLOdXC1B3fux4Vc5ljWM/CDnUStO+0cLMjz/eJbRyh8s1Z/QcQSr
 IQx858KvB/hHrsYxFGFwC46i/pppFrZDHH4bE+2OoczE7ZRTlTQxlHx9i96g3XfQ7p9m
 7ErdnFXVMDI1F66a8bvOZreteFp/MOVfknYym74WMcQJm7RicSF0FkVWmgZoh5wura9B
 5zKg==
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-12-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d81cf0d4-3680-8f87-63ba-d2d843394d5b@gmail.com>
Date: Sun, 18 Jul 2021 19:43:23 -0700
MIME-Version: 1.0
In-Reply-To: <20210718214434.3938850-12-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 11/15] net: bridge: switchdev:
 allow the TX data plane forwarding to be offloaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>



On 7/18/2021 2:44 PM, Vladimir Oltean wrote:
> From: Tobias Waldekranz <tobias@waldekranz.com>
> 
> Allow switchdevs to forward frames from the CPU in accordance with the
> bridge configuration in the same way as is done between bridge
> ports. This means that the bridge will only send a single skb towards
> one of the ports under the switchdev's control, and expects the driver
> to deliver the packet to all eligible ports in its domain.
> 
> Primarily this improves the performance of multicast flows with
> multiple subscribers, as it allows the hardware to perform the frame
> replication.
> 
> The basic flow between the driver and the bridge is as follows:
> 
> - When joining a bridge port, the switchdev driver calls
>    switchdev_bridge_port_offload() with tx_fwd_offload = true.
> 
> - The bridge sends offloadable skbs to one of the ports under the
>    switchdev's control using skb->offload_fwd_mark = true.
> 
> - The switchdev driver checks the skb->offload_fwd_mark field and lets
>    its FDB lookup select the destination port mask for this packet.
> 
> v1->v2:
> - convert br_input_skb_cb::fwd_hwdoms to a plain unsigned long
> - introduce a static key "br_switchdev_fwd_offload_used" to minimize the
>    impact of the newly introduced feature on all the setups which don't
>    have hardware that can make use of it
> - introduce a check for nbp->flags & BR_FWD_OFFLOAD to optimize cache
>    line access
> - reorder nbp_switchdev_frame_mark_accel() and br_handle_vlan() in
>    __br_forward()
> - do not strip VLAN on egress if forwarding offload on VLAN-aware bridge
>    is being used
> - propagate errors from .ndo_dfwd_add_station() if not EOPNOTSUPP
> 
> v2->v3:
> - replace the solution based on .ndo_dfwd_add_station with a solution
>    based on switchdev_bridge_port_offload
> - rename BR_FWD_OFFLOAD to BR_TX_FWD_OFFLOAD
> v3->v4: rebase
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
