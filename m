Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lhX6RB0dmLl0zBx/bSbkGbH0bXRDixWhMm0OMYsDjEU=;
 b=nUcta1pBTg1eBDqSeVWWC7RG7LE4QO9NxqSvWSEBN6avbu3LxoVHgonweXNczxA8MY
 +0Xj6fYsk9kHfFFRpreqU9+GJF2viD2HI+ZdY1mhk/jIuewPSKhu1Irnu+7J7LLQXKVg
 Z//I2qjCq4oVYHYpupnAzHWP6Z2BBlhtBVlzl7AwyiHgequ7CP/pVy8emqV4jZhPxD4Z
 GB9VFg9w4zeY/9P30Hjj0LMeUHKGlVp330zGsWsVAI9UCVxnjvJZgcMcAjywIN65TF8n
 nrg2CurmSd4ZdoOTAw4FVnASk1a5QpYDKtbLcXQHWVlEEj82yA5ezQrcCPbZO32CUuYX
 wRuQ==
Date: Fri, 4 Mar 2022 00:27:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220303222742.si2gksy3tzagsc7r@skbuf>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-3-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301100321.951175-3-tobias@waldekranz.com>
Subject: Re: [Bridge] [PATCH v2 net-next 02/10] net: bridge: mst: Allow
 changing a VLAN's MSTI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 11:03:13AM +0100, Tobias Waldekranz wrote:
> Allow a VLAN to move out of the CST (MSTI 0), to an independent tree.
> 
> The user manages the VID to MSTI mappings via a global VLAN
> setting. The proposed iproute2 interface would be:
> 
>     bridge vlan global set dev br0 vid <VID> msti <MSTI>
> 
> Changing the state in non-zero MSTIs is still not supported, but will
> be addressed in upcoming changes.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

> +static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
> +{
> +	struct net_bridge_vlan_group *vg = nbp_vlan_group(pv->port);
> +	struct net_bridge_vlan *v;
> +
> +	list_for_each_entry(v, &vg->vlan_list, vlist) {
> +		/* If this port already has a defined state in this
> +		 * MSTI (through some other VLAN membership), inherit
> +		 * it.
> +		 */
> +		if (v != pv && v->brvlan->msti == msti) {
> +			br_mst_vlan_set_state(pv->port, pv, v->state);
> +			return;
> +		}
> +	}
> +
> +	/* Otherwise, start out in a new MSTI with all ports disabled. */
> +	return br_mst_vlan_set_state(pv->port, pv, BR_STATE_DISABLED);
> +}
> +
> +int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
> +{
> +	struct net_bridge_vlan_group *vg;
> +	struct net_bridge_vlan *pv;
> +	struct net_bridge_port *p;

No attempt to detect non-changes to the MSTI, and exit early? In a later
patch you will also notify switchdev uselessly because of this.

> +
> +	mv->msti = msti;
> +
> +	list_for_each_entry(p, &mv->br->port_list, list) {
> +		vg = nbp_vlan_group(p);
> +
> +		pv = br_vlan_find(vg, mv->vid);
> +		if (pv)
> +			br_mst_vlan_sync_state(pv, msti);
> +	}
> +
> +	return 0;
> +}
