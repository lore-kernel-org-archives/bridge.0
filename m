Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTiCBd+t8EqWqIv8l2waGzoG4baGX3YkWVnxOmoGZcA=;
 b=knUtXr6C17kyEMKfzcrboga0WmRPMZxZQGdPu4L3lcVHEVx7qmP49dDvdLRmVGCrLoS0QXkKM7yB9FcQuB35nicqrI21L8CP495W7KBXDGvWgNxnp8XPaZrCy5d4UiY04s/N2o6BFWT+4TNOJgid6CtzAdNLQz83pzKYbT1Qp/aCrxe++8R+gPOOsTURjZpd7rPYw3jOISt6cS3+jRFFMEQ4qaxV1ZHoArNiNUFofU7U89DVP+h6yXqiO4FDzUOBOr/IsW5hV9s2L0k/K+QNA7i+sxNbnwRxreAgyOfG8ee3javi6O20nlret59ZC1e900PpWubEmxy201L5JqwREQ==
Message-ID: <a9b7d8d2-da03-42f0-bd16-3446cdcaecc8@nvidia.com>
Date: Wed, 27 Oct 2021 16:54:39 +0300
Content-Language: en-US
References: <20211027134926.1412459-1-ivecera@redhat.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20211027134926.1412459-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] net: bridge: fix uninitialized variables
 when BRIDGE_CFM is disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>

On 27/10/2021 16:49, Ivan Vecera wrote:
> Function br_get_link_af_size_filtered() calls br_cfm_{,peer}_mep_count()
> but does not check their return value. When BRIDGE_CFM is not enabled
> these functions return -EOPNOTSUPP but do not modify count parameter.
> Calling function then works with uninitialized variables.
> 
> Fixes: b6d0425b816e ("bridge: cfm: Netlink Notifications.")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  net/bridge/br_netlink.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 5c6c4305ed23..12d602495ea0 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -126,8 +126,10 @@ static size_t br_get_link_af_size_filtered(const struct net_device *dev,
>  		return vinfo_sz;
>  
>  	/* CFM status info must be added */
> -	br_cfm_mep_count(br, &num_cfm_mep_infos);
> -	br_cfm_peer_mep_count(br, &num_cfm_peer_mep_infos);
> +	if (br_cfm_mep_count(br, &num_cfm_mep_infos) < 0)
> +		num_cfm_mep_infos = 0;
> +	if (br_cfm_peer_mep_count(br, &num_cfm_peer_mep_infos) < 0)
> +		num_cfm_peer_mep_infos = 0;
>  
>  	vinfo_sz += nla_total_size(0);	/* IFLA_BRIDGE_CFM */
>  	/* For each status struct the MEP instance (u32) is added */
> 

Hi,
Could you please rather update the EOPNOTSUPP helpers to set these infos to 0 before
returning? Someone else might decide to use them and hit the same bug.

E.g.
static inline int br_cfm_mep_count(struct net_bridge *br, u32 *count)
{
	*count = 0;
        return -EOPNOTSUPP;
}

We already do the same for br_allowed_ingress, nbp_vlan_add() etc.

Thanks,
 Nik

