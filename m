Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v2eXKPHVpTGWQBn4atDle/vMS0emj77aI3df3rtNZnA=;
 b=fb9/VEayTTjcPHY/YFefn3hXmbwkIW7AbJUab6yCFZL1ELWRkBfvzk1rHQAWNiMMRH
 rDMV2vEkTSEjRy14RE75QHsO0PV6f6S0S/FMeJeK/qxXk7uExR85nRLGqUYVNY2W8frk
 RdAiFtPjHlFWxfloLKHKf2RjXweu5vZoJ+yJ15XpIFw1nt5WqwVMjHVoDVz4HB5gqe2J
 O5ygDDW0AdSbVqwSxRyESQRVuYRn173FLlZdL1D9y7eQ3xwoMTMmtpOPd/BOzBgilkMz
 RUc4q0Y0Og4xC1z2e8dxRnIAubc80858XFsNHN9aYTn0PuJhrVdnTL/HUS1ZHsaFBr3e
 +HSQ==
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-14-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f6918f62-0482-f89a-61c6-c4d8071192a8@gmail.com>
Date: Sun, 18 Jul 2021 19:51:08 -0700
MIME-Version: 1.0
In-Reply-To: <20210718214434.3938850-14-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 13/15] net: dsa: add support for
 bridge TX forwarding offload
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
> For a DSA switch, to offload the forwarding process of a bridge device
> means to send the packets coming from the software bridge as data plane
> packets. This is contrary to everything that DSA has done so far,
> because the current taggers only know to send control packets (ones that
> target a specific destination port), whereas data plane packets are
> supposed to be forwarded according to the FDB lookup, much like packets
> ingressing on any regular ingress port. If the FDB lookup process
> returns multiple destination ports (flooding, multicast), then
> replication is also handled by the switch hardware - the bridge only
> sends a single packet and avoids the skb_clone().
> 
> DSA plays a substantial role in backing the forwarding offload, and
> leaves relatively few things up to the switch driver. In particular, DSA
> keeps for each bridge port a zero-based index (the number of the
> bridge). Multiple ports enslaved to the same bridge have a pointer to
> the same accel_priv structure.
> 
> The tagger can check if the packet that is being transmitted on has
> skb->offload_fwd_mark = true or not. If it does, it can be sure that the
> packet belongs to the data plane of a bridge, further information about
> which can be obtained based on dp->bridge_dev and dp->bridge_num.
> It can then compose a DSA tag for injecting a data plane packet into
> that bridge number.
> 
> For the switch driver side, we offer two new dsa_switch_ops methods,
> called .port_bridge_fwd_offload_{add,del}, which are modeled after
> .port_bridge_{join,leave}.
> These methods are provided in case the driver needs to configure the
> hardware to treat packets coming from that bridge software interface as
> data plane packets. The switchdev <-> bridge interaction happens during
> the netdev_master_upper_dev_link() call, so to switch drivers, the
> effect is that the .port_bridge_fwd_offload_add() method is called
> immediately after .port_bridge_join().
> 
> If the bridge number exceeds the number of bridges for which the switch
> driver can offload the TX data plane (and this includes the case where
> the driver can offload none), DSA falls back to simply returning
> tx_fwd_offload = false in the switchdev_bridge_port_offload() call.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
