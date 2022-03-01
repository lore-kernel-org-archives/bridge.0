Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:user-agent:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=hYbmGPDXwLiLffnLhRUHirzgGpJqt5e2FSuKOW1xBuM=;
 b=472q04PHjRq8R7E2KcRKAC5Kr+mDDeUr4QaUdEAj3QOYmjicLUIeh1egdP5JACwutY
 CnvcnAdPcD74LoAE5Ynek9P0BzaYdWyb0qSD+U/srMFDvwakBAmnm3Tfl2TyEPK+qBjB
 Qu3MbDTYD7UxfE1P7wAUPbnEh5192SCMHjahkpUepZEJZZ1UOpFCckYu8xvKkv38DXS6
 Ch0EIcND3lNvi5vNL9oM3jpqpw0XrHwiuPpygWUa/W5B0tb6L3hB50/X1pvZ71mKvgsV
 ZhXhsVP83f2Mm3VG8PziP0BFWq6vzZa0VbZsPBbuYKpTafFVQijocXXI9Y76PotjHso6
 QqQA==
Date: Wed, 02 Mar 2022 00:19:00 +0100
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220301100321.951175-4-tobias@waldekranz.com>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-4-tobias@waldekranz.com>
Message-ID: <53EED92D-FEAC-4CC6-AF2A-52E73F839AB5@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH v2 net-next 03/10] net: bridge: mst: Support
	setting and reporting MST port states
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On 1 March 2022 11:03:14 CET, Tobias Waldekranz <tobias@waldekranz=2Ecom> w=
rote:
>Make it possible to change the port state in a given MSTI=2E This is
>done through a new netlink interface, since the MSTIs are objects in
>their own right=2E The proposed iproute2 interface would be:
>
>    bridge mst set dev <PORT> msti <MSTI> state <STATE>
>
>Current states in all applicable MSTIs can also be dumped=2E The
>proposed iproute interface looks like this:
>
>$ bridge mst
>port              msti
>vb1               0
>		    state forwarding
>		  100
>		    state disabled
>vb2               0
>		    state forwarding
>		  100
>		    state forwarding
>
>The preexisting per-VLAN states are still valid in the MST
>mode (although they are read-only), and can be queried as usual if one
>is interested in knowing a particular VLAN's state without having to
>care about the VID to MSTI mapping (in this example VLAN 20 and 30 are
>bound to MSTI 100):
>
>$ bridge -d vlan
>port              vlan-id
>vb1               10
>		    state forwarding mcast_router 1
>		  20
>		    state disabled mcast_router 1
>		  30
>		    state disabled mcast_router 1
>		  40
>		    state forwarding mcast_router 1
>vb2               10
>		    state forwarding mcast_router 1
>		  20
>		    state forwarding mcast_router 1
>		  30
>		    state forwarding mcast_router 1
>		  40
>		    state forwarding mcast_router 1
>
>Signed-off-by: Tobias Waldekranz <tobias@waldekranz=2Ecom>
>---
> include/uapi/linux/if_bridge=2Eh |  16 +++
> include/uapi/linux/rtnetlink=2Eh |   5 +
> net/bridge/br_mst=2Ec            | 244 +++++++++++++++++++++++++++++++++
> net/bridge/br_netlink=2Ec        |   3 +
> net/bridge/br_private=2Eh        |   4 +
> 5 files changed, 272 insertions(+)
>
>diff --git a/include/uapi/linux/if_bridge=2Eh b/include/uapi/linux/if_bri=
dge=2Eh
>index b68016f625b7=2E=2E784482527861 100644
>--- a/include/uapi/linux/if_bridge=2Eh
>+++ b/include/uapi/linux/if_bridge=2Eh
>@@ -785,4 +785,20 @@ enum {
> 	__BRIDGE_QUERIER_MAX
> };
> #define BRIDGE_QUERIER_MAX (__BRIDGE_QUERIER_MAX - 1)
>+
>+enum {
>+	BRIDGE_MST_UNSPEC,
>+	BRIDGE_MST_ENTRY,
>+	__BRIDGE_MST_MAX,
>+};
>+#define BRIDGE_MST_MAX (__BRIDGE_MST_MAX - 1)
>+
>+enum {
>+	BRIDGE_MST_ENTRY_UNSPEC,
>+	BRIDGE_MST_ENTRY_MSTI,
>+	BRIDGE_MST_ENTRY_STATE,
>+	__BRIDGE_MST_ENTRY_MAX,
>+};
>+#define BRIDGE_MST_ENTRY_MAX (__BRIDGE_MST_ENTRY_MAX - 1)
>+
> #endif /* _UAPI_LINUX_IF_BRIDGE_H */
>diff --git a/include/uapi/linux/rtnetlink=2Eh b/include/uapi/linux/rtnetl=
ink=2Eh
>index 0970cb4b1b88=2E=2E4a48f3ce862c 100644
>--- a/include/uapi/linux/rtnetlink=2Eh
>+++ b/include/uapi/linux/rtnetlink=2Eh
>@@ -192,6 +192,11 @@ enum {
> 	RTM_GETTUNNEL,
> #define RTM_GETTUNNEL	RTM_GETTUNNEL
>=20
>+	RTM_GETMST =3D 124 + 2,
>+#define RTM_GETMST	RTM_GETMST
>+	RTM_SETMST,
>+#define RTM_SETMST	RTM_SETMST
>+

I think you should also update selinux  (see nlmsgtab=2Ec)
I'll think about this one, if there is some nice way to avoid the new rtm =
types=2E

> 	__RTM_MAX,
> #define RTM_MAX		(((__RTM_MAX + 3) & ~3) - 1)
> };
>diff --git a/net/bridge/br_mst=2Ec b/net/bridge/br_mst=2Ec
>index f3b8e279b85c=2E=2E8dea8e7257fd 100644
>--- a/net/bridge/br_mst=2Ec
>+++ b/net/bridge/br_mst=2Ec
>@@ -120,3 +120,247 @@ int br_mst_set_enabled(struct net_bridge *br, unsig=
ned long val)
> 	br_opt_toggle(br, BROPT_MST_ENABLED, !!val);
> 	return 0;
> }
>+
>+static int br_mst_nl_get_one(struct net_bridge_port *p, struct sk_buff *=
skb,
>+			     struct netlink_callback *cb)
>+{
>+	struct net_bridge_vlan_group *vg =3D nbp_vlan_group(p);
>+	int err =3D 0, idx =3D 0, s_idx =3D cb->args[1];
>+	struct net_bridge_vlan *v;
>+	struct br_port_msg *bpm;
>+	struct nlmsghdr *nlh;
>+	struct nlattr *nest;
>+	unsigned long *seen;
>+

Reverse xmas tree

>+	nlh =3D nlmsg_put(skb, NETLINK_CB(cb->skb)=2Eportid, cb->nlh->nlmsg_seq=
,
>+			RTM_GETMST, sizeof(*bpm), NLM_F_MULTI);
>+	if (!nlh)
>+		return -EMSGSIZE;
>+
>+	bpm =3D nlmsg_data(nlh);
>+	memset(bpm, 0, sizeof(*bpm));
>+	bpm->ifindex =3D p->dev->ifindex;
>+
>+	seen =3D bitmap_zalloc(VLAN_N_VID, 0);
>+	if (!seen)
>+		return -ENOMEM;
>+
>+	list_for_each_entry(v, &vg->vlan_list, vlist) {
>+		if (test_bit(v->brvlan->msti, seen))
>+			continue;
>+
>+		if (idx < s_idx)
>+			goto skip;
>+
>+		nest =3D nla_nest_start_noflag(skb, BRIDGE_MST_ENTRY);
>+		if (!nest ||
>+		    nla_put_u16(skb, BRIDGE_MST_ENTRY_MSTI, v->brvlan->msti) ||
>+		    nla_put_u8(skb, BRIDGE_MST_ENTRY_STATE, v->state)) {
>+			err =3D -EMSGSIZE;
>+			break;
>+		}
>+		nla_nest_end(skb, nest);
>+
>+		set_bit(v->brvlan->msti, seen);
>+skip:
>+		idx++;
>+	}
>+
>+	kfree(seen);
>+	nlmsg_end(skb, nlh);
>+	return err;
>+}
>+
>+static struct net_bridge_port *br_mst_nl_get_parse(struct net *net,
>+						   struct netlink_callback *cb)
>+{
>+	struct netlink_ext_ack *extack =3D cb->extack;
>+	const struct nlmsghdr *nlh =3D cb->nlh;
>+	struct net_bridge_port *p;
>+	struct br_port_msg *bpm;
>+	struct net_device *dev;
>+
>+	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*bpm))) {
>+		NL_SET_ERR_MSG_MOD(extack, "Invalid header for mst get request");
>+		return ERR_PTR(-EINVAL);
>+	}
>+
>+	if (nlmsg_attrlen(nlh, sizeof(*bpm))) {
>+		NL_SET_ERR_MSG(extack, "Invalid data after header in mst get request")=
;
>+		return ERR_PTR(-EINVAL);
>+	}
>+
>+	bpm =3D nlmsg_data(nlh);
>+	if (!bpm->ifindex)
>+		return NULL;
>+
>+	dev =3D __dev_get_by_index(net, bpm->ifindex);
>+	if (!dev)
>+		return ERR_PTR(-ENODEV);
>+
>+	if (!netif_is_bridge_port(dev)) {
>+		NL_SET_ERR_MSG_MOD(extack, "The device is not a valid bridge port");
>+		return ERR_PTR(-EINVAL);
>+	}
>+
>+	p =3D br_port_get_rtnl(dev);
>+	if (WARN_ON(!p))
>+		return ERR_PTR(-ENODEV);
>+
>+	if (!br_opt_get(p->br, BROPT_MST_ENABLED)) {
>+		NL_SET_ERR_MSG_MOD(extack, "Can't query MST state when MST is disabled=
");
>+		return ERR_PTR(-EINVAL);
>+	}
>+
>+	return p;
>+}
>+
>+static int br_mst_nl_get(struct sk_buff *skb, struct netlink_callback *c=
b)
>+{
>+	int err =3D 0, idx =3D 0, s_idx =3D cb->args[0];
>+	struct net *net =3D sock_net(skb->sk);
>+	struct net_bridge_port *p;
>+	struct net_device *dev;
>+
>+	p =3D br_mst_nl_get_parse(net, cb);
>+	if (IS_ERR(p))
>+		return PTR_ERR(p);
>+
>+	if (p) {
>+		err =3D br_mst_nl_get_one(p, skb, cb);
>+		if (err !=3D -EMSGSIZE)
>+			return err;
>+	} else {
>+		for_each_netdev(net, dev) {
>+			if (!netif_is_bridge_port(dev))
>+				continue;
>+
>+			if (idx < s_idx)
>+				goto skip;
>+
>+			p =3D br_port_get_rtnl(dev);
>+			if (WARN_ON(!p))
>+				return -ENODEV;
>+
>+			err =3D br_mst_nl_get_one(p, skb, cb);
>+			if (err =3D=3D -EMSGSIZE)
>+				break;
>+skip:
>+			idx++;
>+		}
>+	}
>+
>+	cb->args[0] =3D idx;
>+	return skb->len;
>+}
>+
>+static const struct nla_policy br_mst_nl_policy[BRIDGE_MST_ENTRY_MAX + 1=
] =3D {
>+	[BRIDGE_MST_ENTRY_MSTI] =3D NLA_POLICY_RANGE(NLA_U16,
>+						   1, /* 0 reserved for CST */
>+						   VLAN_N_VID - 1),
>+	[BRIDGE_MST_ENTRY_STATE] =3D NLA_POLICY_RANGE(NLA_U8,
>+						    BR_STATE_DISABLED,
>+						    BR_STATE_BLOCKING),
>+};
>+
>+static int br_mst_nl_set_one(struct net_bridge_port *p,
>+			     const struct nlattr *attr,
>+			     struct netlink_ext_ack *extack)
>+{
>+	struct nlattr *tb[BRIDGE_MST_ENTRY_MAX + 1];
>+	u16 msti;
>+	u8 state;
>+	int err;
>+
>+	err =3D nla_parse_nested(tb, BRIDGE_MST_ENTRY_MAX, attr,
>+			       br_mst_nl_policy, extack);
>+	if (err)
>+		return err;
>+
>+	if (!tb[BRIDGE_MST_ENTRY_MSTI]) {
>+		NL_SET_ERR_MSG_MOD(extack, "MSTI not specified");
>+		return -EINVAL;
>+	}
>+
>+	if (!tb[BRIDGE_MST_ENTRY_STATE]) {
>+		NL_SET_ERR_MSG_MOD(extack, "State not specified");
>+		return -EINVAL;
>+	}
>+
>+	msti =3D nla_get_u16(tb[BRIDGE_MST_ENTRY_MSTI]);
>+	state =3D nla_get_u8(tb[BRIDGE_MST_ENTRY_STATE]);
>+
>+	br_mst_set_state(p, msti, state);
>+	return 0;
>+}
>+
>+static int br_mst_nl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
>+			 struct netlink_ext_ack *extack)
>+{
>+	struct net *net =3D sock_net(skb->sk);
>+	struct net_bridge_port *p;
>+	struct br_port_msg *bpm;
>+	struct net_device *dev;
>+	struct nlattr *attr;
>+	int err, msts =3D 0;
>+	int rem;
>+
>+	err =3D nlmsg_parse(nlh, sizeof(*bpm), NULL, BRIDGE_MST_MAX, NULL,
>+			  extack);
>+	if (err < 0)
>+		return err;
>+
>+	bpm =3D nlmsg_data(nlh);
>+	dev =3D __dev_get_by_index(net, bpm->ifindex);
>+	if (!dev)
>+		return -ENODEV;
>+
>+	if (!netif_is_bridge_port(dev)) {
>+		NL_SET_ERR_MSG_MOD(extack, "The device is not a valid bridge port");
>+		return -EINVAL;
>+	}
>+
>+	p =3D br_port_get_rtnl(dev);
>+	if (WARN_ON(!p))
>+		return -ENODEV;
>+
>+	if (!br_opt_get(p->br, BROPT_MST_ENABLED)) {
>+		NL_SET_ERR_MSG_MOD(extack, "Can't modify MST state when MST is disable=
d");
>+		return -EBUSY;
>+	}
>+
>+	nlmsg_for_each_attr(attr, nlh, sizeof(*bpm), rem) {
>+		switch (nla_type(attr)) {
>+		case BRIDGE_MST_ENTRY:
>+			err =3D br_mst_nl_set_one(p, attr, extack);
>+			break;
>+		default:
>+			continue;
>+		}
>+
>+		msts++;
>+		if (err)
>+			break;
>+	}
>+
>+	if (!msts) {
>+		NL_SET_ERR_MSG_MOD(extack, "Found no MST entries to process");
>+		err =3D -EINVAL;
>+	}
>+
>+	return err;
>+}
>+
>+void br_mst_rtnl_init(void)
>+{
>+	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_GETMST, NULL,
>+			     br_mst_nl_get, 0);
>+	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_SETMST,
>+			     br_mst_nl_set, NULL, 0);
>+}
>+
>+void br_mst_rtnl_uninit(void)
>+{
>+	rtnl_unregister(PF_BRIDGE, RTM_SETMST);
>+	rtnl_unregister(PF_BRIDGE, RTM_GETMST);
>+}
>diff --git a/net/bridge/br_netlink=2Ec b/net/bridge/br_netlink=2Ec
>index a17a0fe25a58=2E=2E6d70d6f9cf17 100644
>--- a/net/bridge/br_netlink=2Ec
>+++ b/net/bridge/br_netlink=2Ec
>@@ -1813,6 +1813,7 @@ int __init br_netlink_init(void)
>=20
> 	br_mdb_init();
> 	br_vlan_rtnl_init();
>+	br_mst_rtnl_init();
> 	rtnl_af_register(&br_af_ops);
>=20
> 	err =3D rtnl_link_register(&br_link_ops);
>@@ -1824,6 +1825,7 @@ int __init br_netlink_init(void)
> out_af:
> 	rtnl_af_unregister(&br_af_ops);
> 	br_mdb_uninit();
>+	br_mst_rtnl_uninit();
> 	return err;
> }
>=20
>@@ -1831,6 +1833,7 @@ void br_netlink_fini(void)
> {
> 	br_mdb_uninit();
> 	br_vlan_rtnl_uninit();
>+	br_mst_rtnl_uninit();
> 	rtnl_af_unregister(&br_af_ops);
> 	rtnl_link_unregister(&br_link_ops);
> }
>diff --git a/net/bridge/br_private=2Eh b/net/bridge/br_private=2Eh
>index 63601043abca=2E=2E7882a65ffb43 100644
>--- a/net/bridge/br_private=2Eh
>+++ b/net/bridge/br_private=2Eh
>@@ -1782,6 +1782,8 @@ void br_mst_set_state(struct net_bridge_port *p, u1=
6 msti, u8 state);
> int br_mst_vlan_set_msti(struct net_bridge_vlan *v, u16 msti);
> void br_mst_vlan_init_state(struct net_bridge_vlan *v);
> int br_mst_set_enabled(struct net_bridge *br, unsigned long val);
>+void br_mst_rtnl_init(void);
>+void br_mst_rtnl_uninit(void);
> #else
> static inline bool br_mst_is_enabled(struct net_bridge *br)
> {
>@@ -1790,6 +1792,8 @@ static inline bool br_mst_is_enabled(struct net_bri=
dge *br)
>=20
> static inline void br_mst_set_state(struct net_bridge_port *p,
> 				    u16 msti, u8 state) {}
>+static inline void br_mst_rtnl_init(void) {}
>+static inline void br_mst_rtnl_uninit(void) {}
> #endif
>=20
> struct nf_br_ops {

