Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=lJtjgve15KcPn5Fu9Ouzt1Wk99mJhKfetxwppVZu8NU=;
 b=rwzKJtfJcICD1GmZEURxv1cmkMof2PEdjv5T839FXmnrp5OrFhLyJki6sy+pSUlouq
 FkJcaTnPE0OsYdLxfzl1mZfg32F7cWz3dib3rPMfKtItblXggw3jt/GNeSww2Ef8C0uL
 gyCBWhvKdWplhwbMHUjSVg/A4U3pOa2AEFqs0Phgz4YKo4ofnItLOnnsOFPyfe5tuG9c
 SRp17Nn+DG+7vAp6nAiUeZ0nlmc/T6scQ7SoFo96XmvP3lxxmN6LV8/n9/JTppfaLVe9
 8HNaUTibEAkvzt7SOMwMxVQpx7SIgwmp4x7xJ+DAJcInoaBFW8aYsQ1N6wiUFHnDl3qU
 mGQg==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <53EED92D-FEAC-4CC6-AF2A-52E73F839AB5@blackwall.org>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-4-tobias@waldekranz.com>
 <53EED92D-FEAC-4CC6-AF2A-52E73F839AB5@blackwall.org>
Date: Mon, 07 Mar 2022 16:00:22 +0100
Message-ID: <874k49olix.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Nikolay Aleksandrov <razor@blackwall.org>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On Wed, Mar 02, 2022 at 00:19, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> On 1 March 2022 11:03:14 CET, Tobias Waldekranz <tobias@waldekranz.com> wrote:
>>Make it possible to change the port state in a given MSTI. This is
>>done through a new netlink interface, since the MSTIs are objects in
>>their own right. The proposed iproute2 interface would be:
>>
>>    bridge mst set dev <PORT> msti <MSTI> state <STATE>
>>
>>Current states in all applicable MSTIs can also be dumped. The
>>proposed iproute interface looks like this:
>>
>>$ bridge mst
>>port              msti
>>vb1               0
>>		    state forwarding
>>		  100
>>		    state disabled
>>vb2               0
>>		    state forwarding
>>		  100
>>		    state forwarding
>>
>>The preexisting per-VLAN states are still valid in the MST
>>mode (although they are read-only), and can be queried as usual if one
>>is interested in knowing a particular VLAN's state without having to
>>care about the VID to MSTI mapping (in this example VLAN 20 and 30 are
>>bound to MSTI 100):
>>
>>$ bridge -d vlan
>>port              vlan-id
>>vb1               10
>>		    state forwarding mcast_router 1
>>		  20
>>		    state disabled mcast_router 1
>>		  30
>>		    state disabled mcast_router 1
>>		  40
>>		    state forwarding mcast_router 1
>>vb2               10
>>		    state forwarding mcast_router 1
>>		  20
>>		    state forwarding mcast_router 1
>>		  30
>>		    state forwarding mcast_router 1
>>		  40
>>		    state forwarding mcast_router 1
>>
>>Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>>---
>> include/uapi/linux/if_bridge.h |  16 +++
>> include/uapi/linux/rtnetlink.h |   5 +
>> net/bridge/br_mst.c            | 244 +++++++++++++++++++++++++++++++++
>> net/bridge/br_netlink.c        |   3 +
>> net/bridge/br_private.h        |   4 +
>> 5 files changed, 272 insertions(+)
>>
>>diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
>>index b68016f625b7..784482527861 100644
>>--- a/include/uapi/linux/if_bridge.h
>>+++ b/include/uapi/linux/if_bridge.h
>>@@ -785,4 +785,20 @@ enum {
>> 	__BRIDGE_QUERIER_MAX
>> };
>> #define BRIDGE_QUERIER_MAX (__BRIDGE_QUERIER_MAX - 1)
>>+
>>+enum {
>>+	BRIDGE_MST_UNSPEC,
>>+	BRIDGE_MST_ENTRY,
>>+	__BRIDGE_MST_MAX,
>>+};
>>+#define BRIDGE_MST_MAX (__BRIDGE_MST_MAX - 1)
>>+
>>+enum {
>>+	BRIDGE_MST_ENTRY_UNSPEC,
>>+	BRIDGE_MST_ENTRY_MSTI,
>>+	BRIDGE_MST_ENTRY_STATE,
>>+	__BRIDGE_MST_ENTRY_MAX,
>>+};
>>+#define BRIDGE_MST_ENTRY_MAX (__BRIDGE_MST_ENTRY_MAX - 1)
>>+
>> #endif /* _UAPI_LINUX_IF_BRIDGE_H */
>>diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
>>index 0970cb4b1b88..4a48f3ce862c 100644
>>--- a/include/uapi/linux/rtnetlink.h
>>+++ b/include/uapi/linux/rtnetlink.h
>>@@ -192,6 +192,11 @@ enum {
>> 	RTM_GETTUNNEL,
>> #define RTM_GETTUNNEL	RTM_GETTUNNEL
>> 
>>+	RTM_GETMST = 124 + 2,
>>+#define RTM_GETMST	RTM_GETMST
>>+	RTM_SETMST,
>>+#define RTM_SETMST	RTM_SETMST
>>+
>
> I think you should also update selinux  (see nlmsgtab.c)
> I'll think about this one, if there is some nice way to avoid the new rtm types.
>
>> 	__RTM_MAX,
>> #define RTM_MAX		(((__RTM_MAX + 3) & ~3) - 1)
>> };
>>diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
>>index f3b8e279b85c..8dea8e7257fd 100644
>>--- a/net/bridge/br_mst.c
>>+++ b/net/bridge/br_mst.c
>>@@ -120,3 +120,247 @@ int br_mst_set_enabled(struct net_bridge *br, unsigned long val)
>> 	br_opt_toggle(br, BROPT_MST_ENABLED, !!val);
>> 	return 0;
>> }
>>+
>>+static int br_mst_nl_get_one(struct net_bridge_port *p, struct sk_buff *skb,
>>+			     struct netlink_callback *cb)
>>+{
>>+	struct net_bridge_vlan_group *vg = nbp_vlan_group(p);
>>+	int err = 0, idx = 0, s_idx = cb->args[1];
>>+	struct net_bridge_vlan *v;
>>+	struct br_port_msg *bpm;
>>+	struct nlmsghdr *nlh;
>>+	struct nlattr *nest;
>>+	unsigned long *seen;
>>+
>
> Reverse xmas tree

Both of these lines end at the 28th column. Is there some other
tiebreaking mechanism that forces the reverse ordering of nest and seen?

In a variable-width font, the nest declaration does appear shorter. I
remember that you did not have your laptop with you, could that be it?
