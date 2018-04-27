Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=PfHSRzhzi5vZkrA7HOJcdY8HVugskdQDAV6yi3+b7cg=;
	b=x+xWYoKBmkiRwX+VEKnP5an48YXOFOc7x5tq2UGx3l8jr8vBqgXurdGSPgTAKOFBLxoerV7Iulxh5RTdHRv/XC4bVmSVYqKiKYlvxIwCcjSUmXbdEF3OTHjFKj98knJ9vomTOaX6yXyc4A9rar1ltJVRSWySTd74ocaSekpq2yY=
From: Petr Machata <petrm@mellanox.com>
References: <20180427151111.22099-1-idosch@mellanox.com>
	<20180427151111.22099-2-idosch@mellanox.com>
	<1faecfc8-bf75-6ab4-cb7d-44ef27d75bf6@cumulusnetworks.com>
Date: Fri, 27 Apr 2018 19:08:42 +0300
In-Reply-To: <1faecfc8-bf75-6ab4-cb7d-44ef27d75bf6@cumulusnetworks.com>
	(Nikolay Aleksandrov's message of "Fri, 27 Apr 2018 18:38:18 +0300")
Message-ID: <wihd0ykvdh1.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next v2 1/6] net: bridge: Publish bridge
	accessor functions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: mlxsw@mellanox.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, davem@davemloft.net

Nikolay Aleksandrov <nikolay@cumulusnetworks.com> writes:

> On 27/04/18 18:11, Ido Schimmel wrote:
>> From: Petr Machata <petrm@mellanox.com>
>> 
>> Add a couple new functions to allow querying FDB and vlan settings of a
>> bridge.
>> 
>> Signed-off-by: Petr Machata <petrm@mellanox.com>
>> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
>> ---
>>  include/linux/if_bridge.h | 28 ++++++++++++++++++++++++++++
>>  net/bridge/br_fdb.c       | 22 ++++++++++++++++++++++
>>  net/bridge/br_private.h   | 11 +++++++++++
>>  net/bridge/br_vlan.c      | 39 +++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 100 insertions(+)
>> 
>
> Thanks! This looks good to me although the new exported helpers could've
> taken both bridge or port and return the result. Usually when adding a
> port-only functions we name them with nbp_ prefix instead of br_.
>
> Anyway this can be done later since the API is internal,

The idea is that the API would accept both ports and bridges, but
currently there's no user for the parts that I didn't code up--it would
be a dead code. It's super simple to extend these if/when there are
clients, e.g.:

modified   net/bridge/br_vlan.c
@@ -1155,7 +1155,10 @@ int br_vlan_pvid_rtnl(const struct net_device *dev, u16 *p_pvid)
 	struct net_bridge_vlan_group *vg;
 
 	ASSERT_RTNL();
-	if (netif_is_bridge_master(dev))
+	p = br_port_get_check_rtnl(dev);
+	if (p)
+		vg = nbp_vlan_group(p);
+	else if (netif_is_bridge_master(dev))
 		vg = br_vlan_group(netdev_priv(dev));
 	else
 		return -EINVAL;

I can post a follow-up with the renames if you prefer that.

Thanks,
Petr
