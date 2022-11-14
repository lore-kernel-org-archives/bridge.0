Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D75C260BEE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEA8F60BD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UTiCXgB1B6wtLlzmBFhY9pWbKD6k3duRQDCUPfCyj9o=;
 b=t3S9hiNdawTRHw89T0cSvKsLqtfjAs7aOCJpmgqQTBQom28PQJ5aPp0eHJO6aw+dKp
 29UZdTdzkLtxSdDUF8rGeXOfNXGNE5bO9fKdwbwGASSTTJvHr5lndOuiqFf75v1Ck7hi
 +VZZKUQHUvEf89QrBawSmf1ahdBSSrkHvqgR66fqvmrZvaj0KNC3EdFo2tqz3E3F+XFe
 114fgo21+k2mkXxWAP0osslBvD7krcAcOz8fQ8BCT1bDoeAq+eXjR1INCm/MU9exdLyC
 jgTPW3vqrA1LC3LVlHSJlnyjaGgooR9wr955WqFQXlN9Ah4Etu+/TGzxZLzMPCI9EyI9
 RBsw==
Date: Mon, 14 Nov 2022 11:30:08 +0100
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221114084509.860831-1-idosch@nvidia.com>
References: <20221114084509.860831-1-idosch@nvidia.com>
Message-ID: <8BA53D5E-4B93-4B0D-A6CD-D8067EF6F03B@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net] bridge: switchdev: Fix memory leaks when
	changing VLAN protocol
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, roopa@nvidia.com, edumazet@google.com, vladbu@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 14 November 2022 09:45:09 CET, Ido Schimmel <idosch@nvidia=2Ecom> wrote:
>The bridge driver can offload VLANs to the underlying hardware either
>via switchdev or the 8021q driver=2E When the former is used, the VLAN is
>marked in the bridge driver with the 'BR_VLFLAG_ADDED_BY_SWITCHDEV'
>private flag=2E
>
>To avoid the memory leaks mentioned in the cited commit, the bridge
>driver will try to delete a VLAN via the 8021q driver if the VLAN is not
>marked with the previously mentioned flag=2E
>
>When the VLAN protocol of the bridge changes, switchdev drivers are
>notified via the 'SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL' attribute, but
>the 8021q driver is also called to add the existing VLANs with the new
>protocol and delete them with the old protocol=2E
>
>In case the VLANs were offloaded via switchdev, the above behavior is
>both redundant and buggy=2E Redundant because the VLANs are already
>programmed in hardware and drivers that support VLAN protocol change
>(currently only mlx5) change the protocol upon the switchdev attribute
>notification=2E Buggy because the 8021q driver is called despite these
>VLANs being marked with 'BR_VLFLAG_ADDED_BY_SWITCHDEV'=2E This leads to
>memory leaks [1] when the VLANs are deleted=2E
>
>Fix by not calling the 8021q driver for VLANs that were already
>programmed via switchdev=2E
>
>[1]
>unreferenced object 0xffff8881f6771200 (size 256):
>  comm "ip", pid 446855, jiffies 4298238841 (age 55=2E240s)
>  hex dump (first 32 bytes):
>    00 00 7f 0e 83 88 ff ff 00 00 00 00 00 00 00 00  =2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>  backtrace:
>    [<00000000012819ac>] vlan_vid_add+0x437/0x750
>    [<00000000f2281fad>] __br_vlan_set_proto+0x289/0x920
>    [<000000000632b56f>] br_changelink+0x3d6/0x13f0
>    [<0000000089d25f04>] __rtnl_newlink+0x8ae/0x14c0
>    [<00000000f6276baf>] rtnl_newlink+0x5f/0x90
>    [<00000000746dc902>] rtnetlink_rcv_msg+0x336/0xa00
>    [<000000001c2241c0>] netlink_rcv_skb+0x11d/0x340
>    [<0000000010588814>] netlink_unicast+0x438/0x710
>    [<00000000e1a4cd5c>] netlink_sendmsg+0x788/0xc40
>    [<00000000e8992d4e>] sock_sendmsg+0xb0/0xe0
>    [<00000000621b8f91>] ____sys_sendmsg+0x4ff/0x6d0
>    [<000000000ea26996>] ___sys_sendmsg+0x12e/0x1b0
>    [<00000000684f7e25>] __sys_sendmsg+0xab/0x130
>    [<000000004538b104>] do_syscall_64+0x3d/0x90
>    [<0000000091ed9678>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
>Fixes: 279737939a81 ("net: bridge: Fix VLANs memory leak")
>Reported-by: Vlad Buslov <vladbu@nvidia=2Ecom>
>Tested-by: Vlad Buslov <vladbu@nvidia=2Ecom>
>Signed-off-by: Ido Schimmel <idosch@nvidia=2Ecom>
>---
> net/bridge/br_vlan=2Ec | 17 ++++++++++++++---
> 1 file changed, 14 insertions(+), 3 deletions(-)
>

Acked-by: Nikolay Aleksandrov <razor@blackwall=2Eorg>

>diff --git a/net/bridge/br_vlan=2Ec b/net/bridge/br_vlan=2Ec
>index 6e53dc991409=2E=2E9ffd40b8270c 100644
>--- a/net/bridge/br_vlan=2Ec
>+++ b/net/bridge/br_vlan=2Ec
>@@ -959,6 +959,8 @@ int __br_vlan_set_proto(struct net_bridge *br, __be16=
 proto,
> 	list_for_each_entry(p, &br->port_list, list) {
> 		vg =3D nbp_vlan_group(p);
> 		list_for_each_entry(vlan, &vg->vlan_list, vlist) {
>+			if (vlan->priv_flags & BR_VLFLAG_ADDED_BY_SWITCHDEV)
>+				continue;
> 			err =3D vlan_vid_add(p->dev, proto, vlan->vid);
> 			if (err)
> 				goto err_filt;
>@@ -973,8 +975,11 @@ int __br_vlan_set_proto(struct net_bridge *br, __be1=
6 proto,
> 	/* Delete VLANs for the old proto from the device filter=2E */
> 	list_for_each_entry(p, &br->port_list, list) {
> 		vg =3D nbp_vlan_group(p);
>-		list_for_each_entry(vlan, &vg->vlan_list, vlist)
>+		list_for_each_entry(vlan, &vg->vlan_list, vlist) {
>+			if (vlan->priv_flags & BR_VLFLAG_ADDED_BY_SWITCHDEV)
>+				continue;
> 			vlan_vid_del(p->dev, oldproto, vlan->vid);
>+		}
> 	}
>=20
> 	return 0;
>@@ -983,13 +988,19 @@ int __br_vlan_set_proto(struct net_bridge *br, __be=
16 proto,
> 	attr=2Eu=2Evlan_protocol =3D ntohs(oldproto);
> 	switchdev_port_attr_set(br->dev, &attr, NULL);
>=20
>-	list_for_each_entry_continue_reverse(vlan, &vg->vlan_list, vlist)
>+	list_for_each_entry_continue_reverse(vlan, &vg->vlan_list, vlist) {
>+		if (vlan->priv_flags & BR_VLFLAG_ADDED_BY_SWITCHDEV)
>+			continue;
> 		vlan_vid_del(p->dev, proto, vlan->vid);
>+	}
>=20
> 	list_for_each_entry_continue_reverse(p, &br->port_list, list) {
> 		vg =3D nbp_vlan_group(p);
>-		list_for_each_entry(vlan, &vg->vlan_list, vlist)
>+		list_for_each_entry(vlan, &vg->vlan_list, vlist) {
>+			if (vlan->priv_flags & BR_VLFLAG_ADDED_BY_SWITCHDEV)
>+				continue;
> 			vlan_vid_del(p->dev, proto, vlan->vid);
>+		}
> 	}
>=20
> 	return err;

