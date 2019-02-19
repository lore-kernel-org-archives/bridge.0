Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LvrOqa
	g+6Jztz1Tjeq7O+SbMX0mMaNNpdYwn0CCUW58=; b=gsThpEkkK9kJiQdpAmoiv8
	48upSES/uF1h7N/CpNKwFXjl/Ezk0i/0KXwOrRaywuMpNS9QTT+bTdeHKvg20rlC
	CbuHKFjhEljYdG7dagrKje6hbzuYMaQc9W3JqcrYdI8WV/NdjXMxXdWCf3Es4Xum
	pluAqAHOWKP5dF4gHNUWlwtJ7bNyIeqHH7pzf7niGzCQzqtjx2bAEUsdbK8dIyxP
	9Wm7LuFXaqeSR4P2u1pVdDZGfYQrGbUvFmmu+wxWySVNL4G1Iu8/WNKeCBI3WLmp
	1Bl3MccYj7CPFC8mFstA38m9JSXW07YIesmbtlSH3wOTJNz9w7MW5gk2EfGnJQzQ
	==
Date: Tue, 19 Feb 2019 10:53:01 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20190219085300.GA4105@splinter>
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
	<20190218122107.10097-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218122107.10097-1-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [RFC v2] net: bridge: don't flood known multicast
 traffic when snooping is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: f.fainelli@gmail.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, rmk+kernel@armlinux.org.uk, ilyav@mellanox.com

Hi Nik,

On Mon, Feb 18, 2019 at 02:21:07PM +0200, Nikolay Aleksandrov wrote:
> This is v2 of the RFC patch which aims to forward packets to known
> mdsts' ports only (the no querier case). After v1 I've kept
> the previous behaviour when it comes to unregistered traffic or when
> a querier is present. All of this is of course only with snooping
> enabled. So with this patch the following changes should occur:
>  - No querier: forward known mdst traffic to its registered ports,
>                no change about unknown mcast (flood)
>  - Querier present: no change
> 
> The reason to do this is simple - we want to respect the user's mdb
> configuration in both cases, that is if the user adds static mdb entries
> manually then we should use that information about forwarding traffic.
> 
> What do you think ?
> 
> * Notes
> Traffic that is currently marked as mrouters_only:
>  - IPv4: non-local mcast traffic, igmp reports
>  - IPv6: non-all-nodes-dst mcast traffic, mldv1 reports
> 
> Simple use case:
>  $ echo 1 > /sys/class/net/bridge/bridge/multicast_snooping
>  $ bridge mdb add dev bridge port swp1 grp 239.0.0.1
>  - without a querier currently traffic for 239.0.0.1 will still be flooded,
>    with this change it will be forwarded only to swp1

Looks good to me.

> 
> Ido, I know this doesn't solve the issue you brought up, maybe we should
> have a separate discussion about acting on querier changes in the switch
> driver or alternative solutions (e.g. always-flood-unknown-mcast knob).
> Perhaps the bridge can notify the drivers on querier state changes.

I think we need to reflect querier state to drivers. That's the only way
to sync the two data paths. We can flood different packet types using
different tables. The IPv6 packet types are like in the Linux bridge:

* IPv6 all-hosts (ff02::1)
* IPv6 unregistered multicast

Currently we treat both as broadcast, but in case querier is present, we
can switch the second to use the multicast flood table where we only
flood to mrouter ports.

But I wonder if we can simplify it. I believe that the main reason we
take querier state into account in the data path is because multicast is
enabled by default on the bridge. Users that would otherwise explicitly
enable it would probably make sure they also have a querier in the
network.

The workaround I did in commit 9d45deb04c59 ("mlxsw: spectrum: Treat
IPv6 unregistered multicast as broadcast") was in response to blocked
IPv6 neighbour solicitation packets sent to the solicited-node multicast
address. I now see that Russel (Cc-ed) bumped into the same problem [1].

If we trap such packets at L2 (we need it for ND suppression anyway) and
let the Linux bridge take care of flooding them correctly, will it fix
the problem? I'm basically asking if after the proposed fix we will
still have basic scenarios broken by not taking querier state into
account.

Thanks

[1] https://patchwork.ozlabs.org/patch/1043694/

> 
> This patch is meant about discussing the best way to solve the issue,
> it's not thoroughly tested, in case we settle about the details I'll run
> more tests.
> 
> Thanks,
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
>  net/bridge/br_device.c | 5 +++--
>  net/bridge/br_input.c  | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 013323b6dbe4..e8c01409a7e7 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -96,8 +96,9 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  		}
>  
>  		mdst = br_mdb_get(br, skb, vid);
> -		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
> -		    br_multicast_querier_exists(br, eth_hdr(skb)))
> +		if (mdst ||
> +		    (BR_INPUT_SKB_CB_MROUTERS_ONLY(skb) &&
> +		     br_multicast_querier_exists(br, eth_hdr(skb))))
>  			br_multicast_flood(mdst, skb, false, true);
>  		else
>  			br_flood(br, skb, BR_PKT_MULTICAST, false, true);
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 5ea7e56119c1..8777566f7b6d 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -136,8 +136,9 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  	switch (pkt_type) {
>  	case BR_PKT_MULTICAST:
>  		mdst = br_mdb_get(br, skb, vid);
> -		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
> -		    br_multicast_querier_exists(br, eth_hdr(skb))) {
> +		if (mdst ||
> +		    (BR_INPUT_SKB_CB_MROUTERS_ONLY(skb) &&
> +		     br_multicast_querier_exists(br, eth_hdr(skb)))) {
>  			if ((mdst && mdst->host_joined) ||
>  			    br_multicast_is_router(br)) {
>  				local_rcv = true;
> -- 
> 2.20.1
> 
