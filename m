Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuhyj2bELkvlA7kAEXVaxaE0yF8ig2xmkHlBfrpogbo=;
 b=SgcjFv2C143mAJPaQ1x4g1Ya1X1fYCGDfrNDhLS320AXf0gnUNdb97qN5hNLD9EBWN0/hRXvXqwAk6h7nOYUlB65a8YkL2QkYGk5B5pGEmNfOLatpFsmE1IUcCHnEJHgbJy2iC6tMTwXrVPaMQ4PgfRhqZ/Y5vWA2ErJ8jmJYzUolh/Us8YMvOuVLKpeKz7loxLqgpQHjRhtU6SRm9WSwYRYoEyMcwZuqB+58yJTyZGZn7PocV1e67/VP+VGI+br44Q27/tKbFDkIPapb2r1Wdym3xdtSGmcozkMCUXQdIUO7l/nXZmJTMB/bQ2f3xKWOIu0YSe+TyVQoSe+QhsKYw==
References: <20210701122830.2652-1-w.bumiller@proxmox.com>
 <20210701122830.2652-2-w.bumiller@proxmox.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <39385134-e499-2444-aa0d-48b0315e1002@nvidia.com>
Date: Thu, 1 Jul 2021 16:49:44 +0300
In-Reply-To: <20210701122830.2652-2-w.bumiller@proxmox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH 1/1] net: bridge: sync fdb to new
	unicast-filtering ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>, netdev@vger.kernel.org
Cc: Vlad Yasevich <vyasevic@redhat.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Thomas Lamprecht <t.lamprecht@proxmox.com>

On 01/07/2021 15:28, Wolfgang Bumiller wrote:
> Since commit 2796d0c648c9 ("bridge: Automatically manage
> port promiscuous mode.")
> bridges with `vlan_filtering 1` and only 1 auto-port don't
> set IFF_PROMISC for unicast-filtering-capable ports.
> 
> Normally on port changes `br_manage_promisc` is called to
> update the promisc flags and unicast filters if necessary,
> but it cannot distinguish between *new* ports and ones
> losing their promisc flag, and new ports end up not
> receiving the MAC address list.
> 
> Fix this by calling `br_fdb_sync_static` in `br_add_if`
> after the port promisc flags are updated and the unicast
> filter was supposed to have been filled.
> 
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> ---
>  net/bridge/br_if.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index f7d2f472ae24..183e72e7b65e 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -652,6 +652,18 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
>  	list_add_rcu(&p->list, &br->port_list);
>  
>  	nbp_update_port_count(br);
> +	if (!br_promisc_port(p) && (p->dev->priv_flags & IFF_UNICAST_FLT)) {
> +		/* When updating the port count we also update all ports'
> +		 * promiscuous mode.
> +		 * A port leaving promiscuous mode normally gets the bridge's
> +		 * fdb synced to the unicast filter (if supported), however,
> +		 * `br_port_clear_promisc` does not distinguish between
> +		 * non-promiscuous ports and *new* ports, so we need to
> +		 * sync explicitly here.
> +		 */
> +		if (br_fdb_sync_static(br, p))
> +			netdev_err(dev, "failed to sync bridge addresses to this port\n");
> +	}
>  
>  	netdev_update_features(br->dev);
>  
> 

Hi,
The patch is wrong because br_add_if() can fail after you sync these entries and
then nothing will unsync them. Out of curiousity what's the use case of a bridge with a
single port only ? Because, as you've also noted, this will be an issue only if there is
a single port and sounds like a corner case, maybe there's a better way to handle it.

To be honest this promisc management has caused us headaches with scale setups with thousands
of permanent and static entries where we don't need to sync uc lists, we've actually thought
about flags to disable this altogether.

Thanks,
 Nik

