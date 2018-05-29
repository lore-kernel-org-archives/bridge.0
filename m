Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=CE7dLIaYKDBUgqKOdYcL+lt9ffMy5NG35XN7SLsCJqM=;
	b=Zv/1UtwGVN/LxvVDyUJMWsWBGU388dwzDUYV243nm2VRmef7ZM/dBUy8ihg096iVO7mJpteitJny6FaTKiHdIK0eL6k/k/zg0450l47GHkdRoAcWucTNxDQnOSZwA0y2Ybi9wIVGBfDTu4RuKkoadd65eHgNu5cs30yxdKA6yPQ=
From: Petr Machata <petrm@mellanox.com>
References: <cover.1527503302.git.petrm@mellanox.com>
	<708f594ac6cef4a63a6f6a28759098c4d7922976.1527503302.git.petrm@mellanox.com>
	<20180529102543.GA1883@apalos>
Date: Tue, 29 May 2018 17:37:30 +0300
In-Reply-To: <20180529102543.GA1883@apalos> (Ilias Apalodimas's message of
	"Tue, 29 May 2018 13:25:43 +0300")
Message-ID: <wihvab6eded.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next v2 3/7] rocker: rocker_main: Ignore
	bridge VLAN events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: devel@driverdev.osuosl.org, f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, davem@davemloft.net

Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:

>> diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
>> index e73e4fe..aeafdb9 100644
>> --- a/drivers/net/ethernet/rocker/rocker_main.c
>> +++ b/drivers/net/ethernet/rocker/rocker_main.c
>> @@ -1632,6 +1632,9 @@ rocker_world_port_obj_vlan_add(struct rocker_port *rocker_port,
>>  {
>>  	struct rocker_world_ops *wops = rocker_port->rocker->wops;
>>  
>> +	if (netif_is_bridge_master(vlan->obj.orig_dev))
>> +		return -EOPNOTSUPP;
>> +
> What will happen to the "bridge vlan add dev br0 vid X pvid untagged self" when
> the lower level (the driver) returns -EOPNOTSUPP? Will it avoid adding a vlan on
> the bridge ?

No, it will still do it. The reasons are:

- that's what currently happens anyway: none of the drivers has any
  support, yet the bridge logic is done

- -EOPNOTSUPP is what switchdev_port_obj_*() return if switchdev is not
  compiled in

In order to suppress the setting, return e.g. -EINVAL:

# bridge vlan add dev br vid 111 self
RTNETLINK answers: Invalid argument
# bridge vlan show dev br
port    vlan ids
br       1 PVID Egress Untagged

Thanks,
Petr
