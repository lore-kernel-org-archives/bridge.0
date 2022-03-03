Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Q3KMKlNL1UmXA+3fpqyraxkBiFVYfDRSUjKE3l3RuVk=;
 b=MDnX4bgCQ/oEW0UhmojxOqONfN9vQW6YLWXvJiTN9ZgftqcQr1HntMOS2g3/z2DPmE
 8m33ZJNdMHy5QvE34NBHTPyrFtQvSqNCX42VcKXLUA28fVVOjSENDm9kkQb1YrThCzCw
 4mhs+Ja7G4trf5TymB8l8SBevLF4w8Cx1wjasWV1OlHemYMPolDQEc3m40FjuotYMIpW
 V6ohRAT19l0vMqSS6sFnNBHePLzvjUzcp24j5GeZvNTFfz0x9TD2VOYGM0sWaQzurbAG
 VnZd3CbpCGqvfBGxVJoFWuMNGVRlf0X0sqsXMbKEppdV4jwy/kqgzP0I0ikBXbUVso/Z
 hbtg==
Date: Fri, 4 Mar 2022 00:28:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220303222848.4e2s2zrbzfckmiqw@skbuf>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-2-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301100321.951175-2-tobias@waldekranz.com>
Subject: Re: [Bridge] [PATCH v2 net-next 01/10] net: bridge: mst: Multiple
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 11:03:12AM +0100, Tobias Waldekranz wrote:
> Allow the user to switch from the current per-VLAN STP mode to an MST
> mode.
> 
> Up to this point, per-VLAN STP states where always isolated from each
> other. This is in contrast to the MSTP standard (802.1Q-2018, Clause
> 13.5), where VLANs are grouped into MST instances (MSTIs), and the
> state is managed on a per-MSTI level, rather that at the per-VLAN
> level.
> 
> Perhaps due to the prevalence of the standard, many switching ASICs
> are built after the same model. Therefore, add a corresponding MST
> mode to the bridge, which we can later add offloading support for in a
> straight-forward way.
> 
> For now, all VLANs are fixed to MSTI 0, also called the Common
> Spanning Tree (CST). That is, all VLANs will follow the port-global
> state.
> 
> Upcoming changes will make this actually useful by allowing VLANs to
> be mapped to arbitrary MSTIs and allow individual MSTI states to be
> changed.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
> +void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_vlan *v,
> +			   u8 state)

Function can be static.

> +{
> +	struct net_bridge_vlan_group *vg = nbp_vlan_group(p);
> +
> +	if (v->state == state)
> +		return;
> +
> +	br_vlan_set_state(v, state);
> +
> +	if (v->vid == vg->pvid)
> +		br_vlan_set_pvid_state(vg, state);
> +}
