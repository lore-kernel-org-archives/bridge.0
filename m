Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=SNHdJl76z2ehagENL+AN2h1cOvqgLwBk3a0803cefDU=;
	b=nOPAa80zbzq+7vhY/a8CZU36DhYkO/p1neGsfwzm+0GNJ2lyVH0HrE0ILltIDhdf4jkmbyURNb+v93rhbNBkvCTRooJFAqvcCejqOlqWuYy45RrqWm3EXrE64OByWqZJMWIhqyEN2tnF5Psqw9faXCRWixBtzNvQUtguMzfwh6U=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <20180529105535.fhap2w4tvj3tesei@mwanda> (Dan Carpenter's message
	of "Tue, 29 May 2018 13:55:35 +0300")
References: <cover.1527519997.git.petrm@mellanox.com>
	<645c0bde19cffebb0dc603872ef6ab45e9fbf0b6.1527519997.git.petrm@mellanox.com>
	<20180529105535.fhap2w4tvj3tesei@mwanda>
Date: Tue, 29 May 2018 16:12:09 +0300
Message-ID: <wih1sdufvx2.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next v3 6/7] net: bridge: Notify about
	bridge VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, davem@davemloft.net

Dan Carpenter <dan.carpenter@oracle.com> writes:

> On Mon, May 28, 2018 at 05:11:04PM +0200, Petr Machata wrote:
>> @@ -580,6 +591,9 @@ int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags, bool *changed)
>>  			vg->num_vlans++;
>>  			*changed = true;
>>  		}
>> +		ret = br_switchdev_port_vlan_add(br->dev, vid, flags);
>> +		if (ret && ret != -EOPNOTSUPP)
>> +			return ret;
>
> We should probably do some error handling instead of returning directly?

I missed that, you are right. There's a bunch of mutations in the block
above.

Thanks,
Petr
