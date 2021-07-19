Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=T4ERkVqJZcwb9mf7YWlUyzp+3vyVmdMQC/BK4sjX73w=;
 b=vdhQbeqMeu5Oj0KMv2kIJcn5mjbmuTwDk/tRFXMAF7M0o8XLBjKPzj8Yx6uAAlQncz
 I7ik6Di1US+9Ul/KYgmFHa1eCB862EDGbz4RY9wYGHd/F1642e5/uRvgi9d21HYjA+b3
 KaEVSQ+Ah5U+ffBcwwbF9xY8akNAM2ywNVKQAdJnxew+PpNsVUfAE3s4acsYplIRa/QR
 4+xtLT/pWbLGbzNGwfkL9AStdGQIZ5jJstUtf2UbLCRy9h23uRNVscsFsptZMUVrs34T
 d6Y4X8d4QUBNw+9lc4VwXwZcYxr/CEGX8s53Crw99lQ4Y040ke1jkNMuYjQ+Rq7pBxgs
 yyvw==
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-8-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4191ea0a-09ce-d52f-f40e-2d680ef4b9ca@gmail.com>
Date: Sun, 18 Jul 2021 19:26:45 -0700
MIME-Version: 1.0
In-Reply-To: <20210718214434.3938850-8-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 07/15] net: bridge: disambiguate
 offload_fwd_mark
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
> Before this change, four related - but distinct - concepts where named
> offload_fwd_mark:
> 
> - skb->offload_fwd_mark: Set by the switchdev driver if the underlying
>    hardware has already forwarded this frame to the other ports in the
>    same hardware domain.
> 
> - nbp->offload_fwd_mark: An idetifier used to group ports that share
>    the same hardware forwarding domain.
> 
> - br->offload_fwd_mark: Counter used to make sure that unique IDs are
>    used in cases where a bridge contains ports from multiple hardware
>    domains.
> 
> - skb->cb->offload_fwd_mark: The hardware domain on which the frame
>    ingressed and was forwarded.
> 
> Introduce the term "hardware forwarding domain" ("hwdom") in the
> bridge to denote a set of ports with the following property:
> 
>      If an skb with skb->offload_fwd_mark set, is received on a port
>      belonging to hwdom N, that frame has already been forwarded to all
>      other ports in hwdom N.
> 
> By decoupling the name from "offload_fwd_mark", we can extend the
> term's definition in the future - e.g. to add constraints that
> describe expected egress behavior - without overloading the meaning of
> "offload_fwd_mark".
> 
> - nbp->offload_fwd_mark thus becomes nbp->hwdom.
> 
> - br->offload_fwd_mark becomes br->last_hwdom.
> 
> - skb->cb->offload_fwd_mark becomes skb->cb->src_hwdom. The slight
>    change in naming here mandates a slight change in behavior of the
>    nbp_switchdev_frame_mark() function. Previously, it only set this
>    value in skb->cb for packets with skb->offload_fwd_mark true (ones
>    which were forwarded in hardware). Whereas now we always track the
>    incoming hwdom for all packets coming from a switchdev (even for the
>    packets which weren't forwarded in hardware, such as STP BPDUs, IGMP
>    reports etc). As all uses of skb->cb->offload_fwd_mark were already
>    gated behind checks of skb->offload_fwd_mark, this will not introduce
>    any functional change, but it paves the way for future changes where
>    the ingressing hwdom must be known for frames coming from a switchdev
>    regardless of whether they were forwarded in hardware or not
>    (basically, if the skb comes from a switchdev, skb->cb->src_hwdom now
>    always tracks which one).
> 
>    A typical example where this is relevant: the switchdev has a fixed
>    configuration to trap STP BPDUs, but STP is not running on the bridge
>    and the group_fwd_mask allows them to be forwarded. Say we have this
>    setup:
> 
>          br0
>         / | \
>        /  |  \
>    swp0 swp1 swp2
> 
>    A BPDU comes in on swp0 and is trapped to the CPU; the driver does not
>    set skb->offload_fwd_mark. The bridge determines that the frame should
>    be forwarded to swp{1,2}. It is imperative that forward offloading is
>    _not_ allowed in this case, as the source hwdom is already "poisoned".
> 
>    Recording the source hwdom allows this case to be handled properly.
> 
> v2->v3: added code comments
> v3->v4: none
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
