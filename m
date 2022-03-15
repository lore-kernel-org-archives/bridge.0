Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=nzL1DPOauY6xrdeyfpwRODojKdw/bFm68FMajovYo6g=;
 b=aPQtqBpjqL26lRUuA67dWSdBYZ+P/OnQD5b5DPaPCNVFC8mllI1F5Z4DrykGC7Nm52
 NYVARAcB6EKihQiU3nR7auLh2RMcX5iG4aZzNurSihePLSCDNafmV6aDnPt7iohqmzPT
 i+1RJQbOuQTUsiLaWuynMdfIp2D0pEXMbRgq3gppylA50fxe/er+TcNS8B7LqPy9DwNd
 xK4POQpl6tAPqXHcYYhL9RoWDsmggj0qIBO3em3KQdtOCCzH995aYYhNiMf7y+PmHirW
 gmes5oNZhwRimfcWiHSC/2oYzvBdzMMM04H84ESMBLL84WRaxdlbwsUak7eTTugCNdve
 PEXA==
Message-ID: <5c05d8b8-9c40-e38d-5c4d-e25526407e51@blackwall.org>
Date: Tue, 15 Mar 2022 11:52:53 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220315002543.190587-1-tobias@waldekranz.com>
 <20220315002543.190587-4-tobias@waldekranz.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220315002543.190587-4-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 03/15] net: bridge: mst: Support
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

On 15/03/2022 02:25, Tobias Waldekranz wrote:
> Make it possible to change the port state in a given MSTI by extending
> the bridge port netlink interface (RTM_SETLINK on PF_BRIDGE).The
> proposed iproute2 interface would be:
> 
>     bridge mst set dev <PORT> msti <MSTI> state <STATE>
> 
> Current states in all applicable MSTIs can also be dumped via a
> corresponding RTM_GETLINK. The proposed iproute interface looks like
> this:
> 
> $ bridge mst
> port              msti
> vb1               0
> 		    state forwarding
> 		  100
> 		    state disabled
> vb2               0
> 		    state forwarding
> 		  100
> 		    state forwarding
> 
> The preexisting per-VLAN states are still valid in the MST
> mode (although they are read-only), and can be queried as usual if one
> is interested in knowing a particular VLAN's state without having to
> care about the VID to MSTI mapping (in this example VLAN 20 and 30 are
> bound to MSTI 100):
> 
> $ bridge -d vlan
> port              vlan-id
> vb1               10
> 		    state forwarding mcast_router 1
> 		  20
> 		    state disabled mcast_router 1
> 		  30
> 		    state disabled mcast_router 1
> 		  40
> 		    state forwarding mcast_router 1
> vb2               10
> 		    state forwarding mcast_router 1
> 		  20
> 		    state forwarding mcast_router 1
> 		  30
> 		    state forwarding mcast_router 1
> 		  40
> 		    state forwarding mcast_router 1
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/uapi/linux/if_bridge.h |  16 +++++
>  include/uapi/linux/rtnetlink.h |   1 +
>  net/bridge/br_mst.c            | 127 +++++++++++++++++++++++++++++++++
>  net/bridge/br_netlink.c        |  44 +++++++++++-
>  net/bridge/br_private.h        |  23 ++++++
>  5 files changed, 210 insertions(+), 1 deletion(-)
> 
[snip]
> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
> index 78ef5fea4d2b..355ad102d6b1 100644
> --- a/net/bridge/br_mst.c
> +++ b/net/bridge/br_mst.c
> @@ -124,3 +124,130 @@ int br_mst_set_enabled(struct net_bridge *br, bool on,
>  	br_opt_toggle(br, BROPT_MST_ENABLED, on);
>  	return 0;
>  }
> +
> +size_t br_mst_info_size(const struct net_bridge_vlan_group *vg)
> +{
> +	DECLARE_BITMAP(seen, VLAN_N_VID) = { 0 };
> +	const struct net_bridge_vlan *v;
> +	size_t sz;
> +
> +	/* IFLA_BRIDGE_MST */
> +	sz = nla_total_size(0);
> +
> +	list_for_each_entry(v, &vg->vlan_list, vlist) {

Note that rtnl_calcit() (which ends up indirectly using this function) is called
only with rcu so you need to use list_for_each_entry_rcu() here.

> +		if (test_bit(v->brvlan->msti, seen))
> +			continue;
> +
> +		/* IFLA_BRIDGE_MST_ENTRY */
> +		sz += nla_total_size(0) +
> +			/* IFLA_BRIDGE_MST_ENTRY_MSTI */
> +			nla_total_size(sizeof(u16)) +
> +			/* IFLA_BRIDGE_MST_ENTRY_STATE */
> +			nla_total_size(sizeof(u8));
> +
> +		__set_bit(v->brvlan->msti, seen);
> +	}
> +
> +	return sz;
> +}
> +
