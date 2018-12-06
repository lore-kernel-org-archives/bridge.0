Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ASvFwOWRR5VQ6udOVrSQXDOeO/rAo3qx1p/M5n+p9Rk=;
	b=PQjv9wiQnd833mfrehdSLlJGLj5hQYVCfuZUhRHNKb/AKUIyf8T/uCsDtQGlqif6pPllODjbHvGM5frrjdSJnMjAVIGUob6DXJgLcxC58XOng8sX9OgxENljeiw1zOanwzErOrqtKlmxeaOjew+KgVWBinphMCoO+XDzPuel/zY=
From: Petr Machata <petrm@mellanox.com>
Date: Thu, 6 Dec 2018 11:42:44 +0000
Message-ID: <wihh8fqvq3q.fsf@dev-r-vrt-156.mtr.labs.mlnx>
References: <20181205154958.20262-1-idosch@mellanox.com>
	<20181205154958.20262-2-idosch@mellanox.com>
	<20181205.201237.1129051335930444731.davem@davemloft.net>
In-Reply-To: <20181205.201237.1129051335930444731.davem@davemloft.net> (David
	Miller's message of "Wed, 5 Dec 2018 20:12:37 -0800")
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 01/12] vxlan: Add a function to init
 switchdev_notifier_vxlan_fdb_info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: mlxsw <mlxsw@mellanox.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>

David Miller <davem@davemloft.net> writes:

> From: Ido Schimmel <idosch@mellanox.com>
> Date: Wed, 5 Dec 2018 15:50:23 +0000
>
>> +static struct switchdev_notifier_vxlan_fdb_info
>> +vxlan_fdb_switchdev_notifier_info(const struct vxlan_dev *vxlan,
>> +				  const struct vxlan_fdb *fdb,
>> +				  const struct vxlan_rdst *rd)
>> +{
>> +	struct switchdev_notifier_vxlan_fdb_info fdb_info =3D {
>> +		.info.dev =3D vxlan->dev,
>> +		.remote_ip =3D rd->remote_ip,
>> +		.remote_port =3D rd->remote_port,
>> +		.remote_vni =3D rd->remote_vni,
>> +		.remote_ifindex =3D rd->remote_ifindex,
>> +		.vni =3D fdb->vni,
>> +		.offloaded =3D rd->offloaded,
>> +		.added_by_user =3D fdb->flags & NTF_VXLAN_ADDED_BY_USER,
>> +	};
>> +
>> +	memcpy(fdb_info.eth_addr, fdb->eth_addr, ETH_ALEN);
>> +	return fdb_info;
>> +}
>
> Never return a structure by value from a function.  Do you have any idea
> how the compiler implement this?
>
> In the one call site in vxlan.c after this patch is applied, _two_
> switchdev_notifier_cxlan_fdb_info objects are allocated on the stack.
>
> vxlan_fdb_swtich_dev_notifier_info() fills in the first one, and
> then the caller copies that into the second one.
>
> A huge waste.
>
> Please just pass "&info" as an argument.

OK
