Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd8xLkRCM6SKISMKJf3NDD+yOFlQIiW4imN9nW+F+S4=;
 b=sxU2550GqGlfdYNTgzbfEOglkpjnxVjJWOmG5N6vPeFvC4J+659A/4oPY9v3TeSGxNm/wBRQEGF31OJtpy+em4bhB33YeY236SkFLHqO+Vz5INcwooHcpQmHzJ7RkzXm44Lv4YzyHL13I3MGeOjfKtNl4Nv/FyVe1xhmUTuC1eUljFUyTuvNMtEWBxthUvgtHLG609voO1F1Okf6KmQicfkMEWRhKnk05aMOQAJel6IOHk1Wo0/BJ1XgGL/9FSRk19mnXjhi/tZAIOYsmdZ208DiIzi8OMiEcyjogx4H37lVCASlsw3erTW/bCI8wn92rwqZN7Sp4Abr6hM+oX8Y7w==
References: <20210702082605.6034-1-w.bumiller@proxmox.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <113d8503-8670-c0a3-54a6-0b18af64632e@nvidia.com>
Date: Fri, 2 Jul 2021 14:16:51 +0300
In-Reply-To: <20210702082605.6034-1-w.bumiller@proxmox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v2] net: bridge: sync fdb to new
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
Cc: Vlad Yasevich <vyasevic@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, bridge@lists.linux-foundation.org, Thomas Lamprecht <t.lamprecht@proxmox.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On 02/07/2021 11:26, Wolfgang Bumiller wrote:
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
> Fixes: 2796d0c648c9 ("bridge: Automatically manage port promiscuous mode.")
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> ---
> Changes to v1:
>   * Added unsync to error case.
>   * Improved error message
>   * Added `Fixes` tag to commit message
> 

Hi,
One comment below..

>  net/bridge/br_if.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index f7d2f472ae24..2fd03a9742c8 100644
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
> +			netdev_err(dev, "failed to sync bridge static fdb addresses to this port\n");
> +	}
>  
>  	netdev_update_features(br->dev);
>  
> @@ -701,6 +713,7 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
>  	return 0;
>  
>  err7:
> +	br_fdb_unsync_static(br, p);

I don't think you should always unsync, but only if they were synced otherwise you
might delete an entry that wasn't added by the bridge (e.g. promisc bond dev with mac A ->
port mac A and if the bridge has that as static fdb it will delete it on error)

I've been thinking some more about this and obviously you can check if the sync happened,
but you could avoid the error path if you move that sync after the vlan init (nbp_vlan_init())
but before the port is STP enabled, that would avoid error handling altogether.

Thanks,
 Nik

>  	list_del_rcu(&p->list);
>  	br_fdb_delete_by_port(br, p, 0, 1);
>  	nbp_update_port_count(br);
> 

