Return-Path: <davem@davemloft.net>
Date: Wed, 12 Dec 2018 16:34:39 -0800 (PST)
Message-Id: <20181212.163439.1646657193305662904.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1544632917.git.petrm@mellanox.com>
References: <cover.1544632917.git.petrm@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/9] Pass extack to
	SWITCHDEV_PORT_OBJ_ADD
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: petrm@mellanox.com
Cc: ivecera@redhat.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, dsa@cumulusnetworks.com

From: Petr Machata <petrm@mellanox.com>
Date: Wed, 12 Dec 2018 17:02:46 +0000

> Drivers may need to do validation as a result of port object addition.
> An example is mlxsw, which needs to check the configuration of a VXLAN
> device attached to an offloaded bridge. Without a mapped VLAN, the
> invalidity of the device is not important, but as soon as a pvid,
> untagged VLAN is configured for the device, it has to be validated and
> offloaded. Should the validation fail, there's currently no way to
> communicate details of the failure to the user, beyond an error number.
> 
> Because currently, extack is not available at all in that area of code,
> this patch starts down at the RTNL level and progresses up towards the
> driver(s).
> 
> In patch #1, ndo_bridge_setlink is updated to include extack, and
> callbacks of all clients are updated as well (ignoring the argument).
> 
> In patch #2, the bridge driver is updated to propagate the extack
> through to the switchdev border, br_switchdev_port_vlan_add().
> 
> Patches #3, #4 and #5 then gradually extend switchdev to pass the extack
> argument through to the switchdev blocking notifier chain.
> 
> Patches #6 and #7 then update mlxsw to pass the extack argument from
> VXLAN events resp. port events on to mlxsw_sp_bridge_8021q_vxlan_join().
> 
> Finally in patches #8 and #9, the code paths from the previous two
> patches are verified to yield an error message.
> 
> v2:
> - Patch #1:
>     - In ndo_bridge_setlink(), keep the whole extack declaration on the
>       same line.

Series applied, thanks Petr.
