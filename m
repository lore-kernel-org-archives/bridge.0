Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=SIrBFHnbTuEPa/ajYEcIhiOmlZktw1Hu6fSqyhpq2b0=;
	b=XpPdFggfDPDx4t6jZP0BeFWJKp3mv0wnNGzeBnTmpW0dKlTj6qMcTldXyPAtNe6pu7eEZcJonn6wJGHRqxoixv3vpCBCXch+B6Tyj8vrSO/6ZI1ofTAceGj5I9yqLcJTNVcb6J69awI93B+p6Yx7vjkvxxxYK5HQpqtw9veQs8k=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <20180427092829.1673ed74@xeon-e3> (Stephen Hemminger's message of
	"Fri, 27 Apr 2018 09:28:29 -0700")
References: <20180427151111.22099-1-idosch@mellanox.com>
	<20180427151111.22099-2-idosch@mellanox.com>
	<20180427092829.1673ed74@xeon-e3>
Date: Fri, 27 Apr 2018 19:36:45 +0300
Message-ID: <wihy3h8txlu.fsf@dev-r-vrt-156.mtr.labs.mlnx>
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
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, davem@davemloft.net

Stephen Hemminger <stephen@networkplumber.org> writes:

> On Fri, 27 Apr 2018 18:11:06 +0300
> Ido Schimmel <idosch@mellanox.com> wrote:
>
>> +int br_vlan_pvid_rtnl(const struct net_device *dev, u16 *p_pvid)
>> +{
>> +	struct net_bridge_vlan_group *vg;
>> +
>> +	ASSERT_RTNL();
>> +	if (netif_is_bridge_master(dev))
>> +		vg = br_vlan_group(netdev_priv(dev));
>> +	else
>> +		return -EINVAL;
>> +
>> +	*p_pvid = br_get_pvid(vg);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(br_vlan_pvid_rtnl);
>
> Unless there is a RCU version, no need for _rtnl suffix.

All right, I wanted to be explicit, but if you prefer to drop the _rtnl,
no problem.

> Minor style issue, why not make error then go on and return -1 on error.

Basically to make it more straightforward to extend when people want to
add support for the other device kind (bridge / port).

>
>
> int br_vlan_pvid(const struct net_device *dev)
> {
> 	const struct net_bridge_vlan_group *vg;
>
> 	ASSERT_RTNL();
>
> 	if (!netif_is_bridge_master(dev))
> 		return -1;
>
> 	vg = br_vlan_group(netdev_priv(dev));
> 	return br_get_pvid(vg);
> }
