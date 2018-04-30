Return-Path: <davem@davemloft.net>
Date: Mon, 30 Apr 2018 12:44:19 -0400 (EDT)
Message-Id: <20180430.124419.1474600899491240220.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180429075613.10832-1-idosch@mellanox.com>
References: <20180429075613.10832-1-idosch@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 0/6] mlxsw: SPAN: Support routes
 pointing at bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@mellanox.com
Cc: mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jiri@mellanox.com, petrm@mellanox.com

From: Ido Schimmel <idosch@mellanox.com>
Date: Sun, 29 Apr 2018 10:56:07 +0300

> Petr says:
> 
> When mirroring to a gretap or ip6gretap netdevice, the route that
> directs the encapsulated packets can reference a bridge. In that case,
> in the software model, the packet is switched.
> 
> Thus when offloading mirroring like that, take into consideration FDB,
> STP, PVID configured at the bridge, and whether that VLAN ID should be
> tagged on egress.
> 
> Patch #1 introduces functions to get bridge PVID, VLAN flags and to look
> up an FDB entry.
> 
> Patches #2 and #3 refactor some existing code and introduce a new
> accessor function.
> 
> With patches #4 and #5 mlxsw calls mlxsw_sp_span_respin() on switchdev
> events as well. There is no impact yet, because bridge as an underlay
> device is still not allowed.
> 
> That is implemented in patch #6, which uses the new interfaces to figure
> out on which one port the mirroring should be configured, and whether
> the mirrored packets should be VLAN-tagged and how.
> 
> Changes from v2 to v3:
> 
> - Rename the suite of bridge accessor function to br_vlan_get_pvid(),
>   br_vlan_get_info() and br_fdb_find_port(). The _get bit is to avoid
>   clashing with an existing static function.
> 
> Changes from v1 to v2:
> 
> - Change the suite of bridge accessor functions to br_vlan_pvid_rtnl(),
>   br_vlan_info_rtnl(), br_fdb_find_port_rtnl().

Series applied, thank you.
