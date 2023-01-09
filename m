Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E63381B7B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 085F681BB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1673251558; x=1673337958; bh=hObozgfzpCa4NJkSvRz0TIjGKTPe
 jFUvHPU4Z0aahqk=; b=mzxOVgnYUmn1wqkvAoWZNnNN7BUjMblm39y8OWSvfmWq
 v3yc/JIaIn8ehELmCz5BW/SbUKx2+l3nl8SWKpCptAqZMqDNQOm3f7oWtNk0fnIf
 cECuWF/EThU6YipnukTdmxsSz4VKplC3izMcBUceGP/Y+gmYAb0yTWaYYCRDi2eL
 CBxayCahGbY3xW9Sc9ZabOZ/mg4/DS3OoljyhOOBV6f+mqAvs5BXAtWy8Y2X4Xtc
 QlKNITAK0OyTqIPwNTH9e8rLr/t+Drpov8608l6NgFpFHyn4X885BThpWUDNMXDU
 izE8b3OI056CdOZBeSGeMDY5JT72dwD9sWtT/qp7/Q==
Date: Mon, 9 Jan 2023 10:05:53 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <Y7vK4T18pOZ9KAKE@shredder>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-2-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316150857.2442916-2-tobias@waldekranz.com>
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
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 04:08:43PM +0100, Tobias Waldekranz wrote:
> +DEFINE_STATIC_KEY_FALSE(br_mst_used);

[...]

> +int br_mst_set_enabled(struct net_bridge *br, bool on,
> +		       struct netlink_ext_ack *extack)
> +{
> +	struct net_bridge_vlan_group *vg;
> +	struct net_bridge_port *p;
> +
> +	list_for_each_entry(p, &br->port_list, list) {
> +		vg = nbp_vlan_group(p);
> +
> +		if (!vg->num_vlans)
> +			continue;
> +
> +		NL_SET_ERR_MSG(extack,
> +			       "MST mode can't be changed while VLANs exist");
> +		return -EBUSY;
> +	}
> +
> +	if (br_opt_get(br, BROPT_MST_ENABLED) == on)
> +		return 0;
> +
> +	if (on)
> +		static_branch_enable(&br_mst_used);
> +	else
> +		static_branch_disable(&br_mst_used);
> +
> +	br_opt_toggle(br, BROPT_MST_ENABLED, on);
> +	return 0;
> +}

Hi,

I'm not actually using MST, but I ran into this code and was wondering
if the static key usage is correct. The static key is global (not
per-bridge), so what happens when two bridges have MST enabled and then
it is disabled on one? I believe it would be disabled for both. If so,
maybe use static_branch_inc() / static_branch_dec() instead?

Thanks
