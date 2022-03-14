Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OYV4LpH4D3agxsG3V7VyzstSf+lDz7EM5vQa2UkEP7w=;
 b=MOiHh0CsD3q+iNPxoPSXwT3iZzcB0ZcSFhKkrzBOMCkYSu7aKHbORB3emZtHnfBxYu
 v3dtH3qbNNm3Vi2nNIdfDrruOItemfOdVViSojC3sXZBM1YHKxbEtvfbb13NoFonpDil
 IMh6xGHEWuHI6yHyAYaLWJkI7K9IMXYWhHoYorlQAxEoMYom6ad0diEKR+HMICp5/tEX
 SP3kbCzP1qFzW5bV2gCgiYpimaqSn+c0SXq0O5OG3Pn4HJErrjdswwuRLYvwS0X1z5bL
 EajKTJDzTYBnw5lZVuhQzYCm25RotqH7PSMdw/AryMk6NHNJaUvcvC/z1eXwAlUn3UGi
 JdKw==
Date: Mon, 14 Mar 2022 16:58:54 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220314145854.shtnvetounjfnu4e@skbuf>
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-4-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314095231.3486931-4-tobias@waldekranz.com>
Subject: Re: [Bridge] [PATCH v3 net-next 03/14] net: bridge: mst: Support
 setting and reporting MST port states
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 10:52:20AM +0100, Tobias Waldekranz wrote:
> +int br_mst_fill_info(struct sk_buff *skb, struct net_bridge_vlan_group *vg)
> +{
> +	struct net_bridge_vlan *v;
> +	struct nlattr *nest;
> +	unsigned long *seen;
> +	int err = 0;
> +
> +	seen = bitmap_zalloc(VLAN_N_VID, 0);

I see there is precedent in the bridge driver for using dynamic
allocation as opposed to on-stack declaration using DECLARE_BITMAP().
I imagine this isn't just to be "heapsters", but why?

I don't have a very good sense of how much on-stack memory is too much
(a lot probably depends on the expected depth of the call stack too, and here it
doesn't appear to be too deep), but I see that mlxsw_sp_bridge_vxlan_vlan_is_valid()
has a DECLARE_BITMAP(vlans, VLAN_N_VID) too.

The comment applies for callers of br_mst_get_info() too.

> +	if (!seen)
> +		return -ENOMEM;
> +
> +	list_for_each_entry(v, &vg->vlan_list, vlist) {
> +		if (test_bit(v->brvlan->msti, seen))
> +			continue;
> +
> +		nest = nla_nest_start_noflag(skb, IFLA_BRIDGE_MST_ENTRY);
> +		if (!nest ||
> +		    nla_put_u16(skb, IFLA_BRIDGE_MST_ENTRY_MSTI, v->brvlan->msti) ||
> +		    nla_put_u8(skb, IFLA_BRIDGE_MST_ENTRY_STATE, v->state)) {
> +			err = -EMSGSIZE;
> +			break;
> +		}
> +		nla_nest_end(skb, nest);
> +
> +		set_bit(v->brvlan->msti, seen);
> +	}
> +
> +	kfree(seen);
> +	return err;
> +}
