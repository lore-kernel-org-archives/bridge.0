Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 183B960E2F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA896606AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1678797310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pVIp7g2q/w3gUgwbSlzaQV0hcNAj9gmmGMjepwJpv3k=;
 b=sdUFUS6f0j2hkY1uaDLCJzh0NMjGoPd/Jat9dLhOac0kesFPsmEk85dxcVzFTs6/30
 3zJzSAMeRm2fZTcJeqGg6SC6MP95smAzjdo6EJttmteQVv66pTDbqoDLSnI4EwGVLgbA
 1pi7GIe9fel8lKxC4TP2RgpUCozojgCf9Lgw9I/al/k3OIaDakqu8EtpgHM0Jz6Q3c8+
 HfhXTq6SmbDOLNZyEorVzPoLF/bCW3O2FnpUrUZT3lbXCzOoCZ7KX9tj9cmWduG5R1Se
 JZw17vISJbZ+dYMJ/w5DdjC2zpzidlbwgNH6EdzeserXDbgeNcjOiB6zMUysol0A0+6U
 Djmw==
Message-ID: <e695257a-58e2-c676-95cd-77df5c2b68cf@blackwall.org>
Date: Tue, 14 Mar 2023 14:35:08 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230313145349.3557231-1-idosch@nvidia.com>
 <20230313145349.3557231-10-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230313145349.3557231-10-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 09/11] vxlan: Add MDB data path support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 13/03/2023 16:53, Ido Schimmel wrote:
> Integrate MDB support into the Tx path of the VXLAN driver, allowing it
> to selectively forward IP multicast traffic according to the matched MDB
> entry.
> 
> If MDB entries are configured (i.e., 'VXLAN_F_MDB' is set) and the
> packet is an IP multicast packet, perform up to three different lookups
> according to the following priority:
> 
> 1. For an (S, G) entry, using {Source VNI, Source IP, Destination IP}.
> 2. For a (*, G) entry, using {Source VNI, Destination IP}.
> 3. For the catchall MDB entry (0.0.0.0 or ::), using the source VNI.
> 
> The catchall MDB entry is similar to the catchall FDB entry
> (00:00:00:00:00:00) that is currently used to transmit BUM (broadcast,
> unknown unicast and multicast) traffic. However, unlike the catchall FDB
> entry, this entry is only used to transmit unregistered IP multicast
> traffic that is not link-local. Therefore, when configured, the catchall
> FDB entry will only transmit BULL (broadcast, unknown unicast,
> link-local multicast) traffic.
> 
> The catchall MDB entry is useful in deployments where inter-subnet
> multicast forwarding is used and not all the VTEPs in a tenant domain
> are members in all the broadcast domains. In such deployments it is
> advantageous to transmit BULL (broadcast, unknown unicast and link-local
> multicast) and unregistered IP multicast traffic on different tunnels.
> If the same tunnel was used, a VTEP only interested in IP multicast
> traffic would also pull all the BULL traffic and drop it as it is not a
> member in the originating broadcast domain [1].
> 
> If the packet did not match an MDB entry (or if the packet is not an IP
> multicast packet), return it to the Tx path, allowing it to be forwarded
> according to the FDB.
> 
> If the packet did match an MDB entry, forward it to the associated
> remote VTEPs. However, if the entry is a (*, G) entry and the associated
> remote is in INCLUDE mode, then skip over it as the source IP is not in
> its source list (otherwise the packet would have matched on an (S, G)
> entry). Similarly, if the associated remote is marked as BLOCKED (can
> only be set on (S, G) entries), then skip over it as well as the remote
> is in EXCLUDE mode and the source IP is in its source list.
> 
> [1] https://datatracker.ietf.org/doc/html/draft-ietf-bess-evpn-irb-mcast#section-2.6
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_core.c    |  15 ++++
>  drivers/net/vxlan/vxlan_mdb.c     | 114 ++++++++++++++++++++++++++++++
>  drivers/net/vxlan/vxlan_private.h |   6 ++
>  3 files changed, 135 insertions(+)
> 
[snip]> diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
> index b32b1fb4a74a..ea63c5178718 100644
> --- a/drivers/net/vxlan/vxlan_mdb.c
> +++ b/drivers/net/vxlan/vxlan_mdb.c
> @@ -1298,6 +1298,120 @@ int vxlan_mdb_del(struct net_device *dev, struct nlattr *tb[],
>  	return err;
>  }
>  
> +struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
> +						struct sk_buff *skb,
> +						__be32 src_vni)
> +{
> +	struct vxlan_mdb_entry *mdb_entry;
> +	struct vxlan_mdb_entry_key group;
> +
> +	if (!is_multicast_ether_addr(eth_hdr(skb)->h_dest) ||
> +	    is_broadcast_ether_addr(eth_hdr(skb)->h_dest))
> +		return NULL;
> +
> +	/* When not in collect metadata mode, 'src_vni' is zero, but MDB
> +	 * entries are stored with the VNI of the VXLAN device.
> +	 */
> +	if (!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA))
> +		src_vni = vxlan->default_dst.remote_vni;
> +
> +	memset(&group, 0, sizeof(group));
> +	group.vni = src_vni;
> +
> +	switch (ntohs(skb->protocol)) {

drop the ntohs and..

> +	case ETH_P_IP:

htons(ETH_P_IP)

> +		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> +			return NULL;
> +		group.dst.sa.sa_family = AF_INET;
> +		group.dst.sin.sin_addr.s_addr = ip_hdr(skb)->daddr;
> +		group.src.sa.sa_family = AF_INET;
> +		group.src.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case ETH_P_IPV6:

htons(ETH_P_IPV6)

> +		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
> +			return NULL;
> +		group.dst.sa.sa_family = AF_INET6;
> +		group.dst.sin6.sin6_addr = ipv6_hdr(skb)->daddr;
> +		group.src.sa.sa_family = AF_INET6;
> +		group.src.sin6.sin6_addr = ipv6_hdr(skb)->saddr;
> +		break;
> +#endif
> +	default:
> +		return NULL;
> +	}
> +
> +	mdb_entry = vxlan_mdb_entry_lookup(vxlan, &group);
> +	if (mdb_entry)
> +		return mdb_entry;
> +
> +	memset(&group.src, 0, sizeof(group.src));
> +	mdb_entry = vxlan_mdb_entry_lookup(vxlan, &group);
> +	if (mdb_entry)
> +		return mdb_entry;
> +
> +	/* No (S, G) or (*, G) found. Look up the all-zeros entry, but only if
> +	 * the destination IP address is not link-local multicast since we want
> +	 * to transmit such traffic together with broadcast and unknown unicast
> +	 * traffic.
> +	 */
> +	switch (ntohs(skb->protocol)) {
> +	case ETH_P_IP:

ditto

> +		if (ipv4_is_local_multicast(group.dst.sin.sin_addr.s_addr))
> +			return NULL;
> +		group.dst.sin.sin_addr.s_addr = 0;
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case ETH_P_IPV6:

ditto

> +		if (ipv6_addr_type(&group.dst.sin6.sin6_addr) &
> +		    IPV6_ADDR_LINKLOCAL)
> +			return NULL;
> +		memset(&group.dst.sin6.sin6_addr, 0,
> +		       sizeof(group.dst.sin6.sin6_addr));
> +		break;
> +#endif
> +	default:
> +		return NULL;
> +	}
> +
> +	return vxlan_mdb_entry_lookup(vxlan, &group);
> +}
> +
[snip]

