Return-Path: <davem@davemloft.net>
Date: Fri, 27 Apr 2018 20:28:00 -0400 (EDT)
Message-Id: <20180427.202800.1778798756850411051.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180427151111.22099-1-idosch@mellanox.com>
References: <20180427151111.22099-1-idosch@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/6] mlxsw: SPAN: Support routes
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
Date: Fri, 27 Apr 2018 18:11:05 +0300

> Changes from v1 to v2:
> 
> - Change the suite of bridge accessor functions to br_vlan_pvid_rtnl(),
>   br_vlan_info_rtnl(), br_fdb_find_port_rtnl().

Please address Stephen Hemminger's feedback, otherwise this series
looks good to go.

Thanks.
