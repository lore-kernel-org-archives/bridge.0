Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A97760EA1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E37A607BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1673264630; x=1673351030; bh=bboapEA3vdgSLWm56a8XSVtdTYNt
 0MFJHdjnyOsqZws=; b=Wx0NqN6ygqqa2SxoxoROtpr3/Hkbs+nwqruUtIS5aAHG
 16wXZLBSnARXMXgHHSxdbG2ij4c9Yya9lLt1jOBREFxoQh+M3NJgjcj27pGEzhcn
 YIJcw3o8XqWiGakmWB90s0YiZI0zZ4T9wPRsSy0A1niEpuI+uuIyViMCFnYfZ6/x
 BYDqMF4Up7zindbrNkHZcZqD1Y+38daStRBtr7/c0VBgcoo3PEfHqcC/rXda5Fov
 wom76CULKqAEh5HbBGGHmMuhxiEZYKaKz8kDKDE1osJPHqDf5tqP5/fgHj4K7ddA
 AmEbhnuCFUHqqcH6a0HTR7Hk+6HvVQ3n1TezoqHh6A==
Date: Mon, 9 Jan 2023 13:43:46 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <Y7v98s8lC1WUvsSO@shredder>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-2-tobias@waldekranz.com>
 <Y7vK4T18pOZ9KAKE@shredder> <20230109100236.euq7iaaorqxrun7u@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109100236.euq7iaaorqxrun7u@skbuf>
Subject: Re: [Bridge] [PATCH v5 net-next 01/15] net: bridge: mst: Multiple
 Spanning Tree (MST) mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Jan 09, 2023 at 12:02:36PM +0200, Vladimir Oltean wrote:
> On Mon, Jan 09, 2023 at 10:05:53AM +0200, Ido Schimmel wrote:
> > > +	if (on)
> > > +		static_branch_enable(&br_mst_used);
> > > +	else
> > > +		static_branch_disable(&br_mst_used);
> > 
> > Hi,
> > 
> > I'm not actually using MST, but I ran into this code and was wondering
> > if the static key usage is correct. The static key is global (not
> > per-bridge), so what happens when two bridges have MST enabled and then
> > it is disabled on one? I believe it would be disabled for both. If so,
> > maybe use static_branch_inc() / static_branch_dec() instead?
> 
> Sounds about right. FWIW, br_switchdev_tx_fwd_offload does use
> static_branch_inc() / static_branch_dec().

OK, thanks for confirming. Will send a patch later this week if Tobias
won't take care of it by then. First patch will probably be [1] to make
sure we dump the correct MST state to user space. It will also make it
easier to show the problem and validate the fix.

[1]
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 4f5098d33a46..f02a1ad589de 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -286,7 +286,7 @@ int br_boolopt_get(const struct net_bridge *br, enum br_boolopt_id opt)
 	case BR_BOOLOPT_MCAST_VLAN_SNOOPING:
 		return br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED);
 	case BR_BOOLOPT_MST_ENABLE:
-		return br_opt_get(br, BROPT_MST_ENABLED);
+		return br_mst_is_enabled(br);
 	default:
 		/* shouldn't be called with unsupported options */
 		WARN_ON(1);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 75aff9bbf17e..7f0475f62d45 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1827,7 +1827,7 @@ static inline bool br_vlan_state_allowed(u8 state, bool learn_allow)
 /* br_mst.c */
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 DECLARE_STATIC_KEY_FALSE(br_mst_used);
-static inline bool br_mst_is_enabled(struct net_bridge *br)
+static inline bool br_mst_is_enabled(const struct net_bridge *br)
 {
 	return static_branch_unlikely(&br_mst_used) &&
 		br_opt_get(br, BROPT_MST_ENABLED);
@@ -1845,7 +1845,7 @@ int br_mst_fill_info(struct sk_buff *skb,
 int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
 		   struct netlink_ext_ack *extack);
 #else
-static inline bool br_mst_is_enabled(struct net_bridge *br)
+static inline bool br_mst_is_enabled(const struct net_bridge *br)
 {
 	return false;
 }
