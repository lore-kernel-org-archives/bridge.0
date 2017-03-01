Return-Path: <davem@davemloft.net>
Date: Wed, 01 Mar 2017 14:56:20 -0800 (PST)
Message-Id: <20170301.145620.1575285327636466385.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1488379845-38625-1-git-send-email-yotamg@mellanox.com>
References: <1488379845-38625-1-git-send-email-yotamg@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: Fix error path in nbp_vlan_init
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: yotamg@mellanox.com
Cc: idosch@mellanox.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com, eladr@mellanox.com

From: Yotam Gigi <yotamg@mellanox.com>
Date: Wed,  1 Mar 2017 16:50:45 +0200

> Fix error path order in nbp_vlan_init, so if switchdev_port_attr_set
> call failes, the vlan_hash wouldn't be destroyed before inited.
> 
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> CC: Roopa Prabhu <roopa@cumulusnetworks.com>
> Signed-off-by: Yotam Gigi <yotamg@mellanox.com>

Applied, thanks.
