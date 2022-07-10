Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1106341619
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A65B4161A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aOSOUd9RBEHqOP1XcSOPcC/VbZMbNhD9MrOCZg4pkA=;
 b=cYCXhwwFC+6mNEoVFRjlhKGEOUKSpAD6VIWtM1VoiCy0C57G6Uj6RMrW3N9BFCnnZO3F6PxS/TOHVweKZ0pYViulJd6WGMYW36xuD9hva/ykV/qSPCUL0TnsQ72rnaIcgmRvQUZlJcFV6Y+Sg27P5AaxwzjSBf8MByHVjdduJHr7ul71c+DjlYQOxtLPnQh1/Pv30ygmXWE9xqvusUv7bjKaOmbYD+I3KPBugezScCKQ0Jy9/lTS0C6SAPqVo1ZvBNDOWRgcHH0VzE0UORPDPGlQoZwibHFD00bMK/2hYeNPDt2BLZ1hJVu3lI1q/1xMTbAbd9Swc/Mbyz4OqDto1Q==
Date: Sun, 10 Jul 2022 11:20:27 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YsqLyxTRtUjzDj6D@shredder>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
 <20220707152930.1789437-2-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707152930.1789437-2-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v4 net-next 1/6] net: bridge: add locked entry
 fdb flag to extend locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Thu, Jul 07, 2022 at 05:29:25PM +0200, Hans Schultz wrote:
> Add an intermediate state for clients behind a locked port to allow for
> possible opening of the port for said clients. The clients mac address
> will be added with the locked flag set, denying access through the port
> for the mac address, but also creating a new FDB add event giving
> userspace daemons the ability to unlock the mac address. This feature
> corresponds to the Mac-Auth and MAC Authentication Bypass (MAB) named
> features. The latter defined by Cisco.
> 
> Only the kernel can set this FDB entry flag, while userspace can read
> the flag and remove it by replacing or deleting the FDB entry.
> 
> Signed-off-by: Hans Schultz <netdev@kapio-technology.com>
> ---
>  include/uapi/linux/neighbour.h |  1 +
>  net/bridge/br_fdb.c            | 12 ++++++++++++
>  net/bridge/br_input.c          | 10 +++++++++-
>  net/bridge/br_private.h        |  3 ++-
>  4 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
> index 39c565e460c7..76d65b481086 100644
> --- a/include/uapi/linux/neighbour.h
> +++ b/include/uapi/linux/neighbour.h
> @@ -53,6 +53,7 @@ enum {
>  #define NTF_ROUTER	(1 << 7)
>  /* Extended flags under NDA_FLAGS_EXT: */
>  #define NTF_EXT_MANAGED	(1 << 0)
> +#define NTF_EXT_LOCKED	(1 << 1)
>  
>  /*
>   *	Neighbor Cache Entry States.
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index e7f4fccb6adb..ee9064a536ae 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -105,6 +105,7 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
>  	struct nda_cacheinfo ci;
>  	struct nlmsghdr *nlh;
>  	struct ndmsg *ndm;
> +	u32 ext_flags = 0;
>  
>  	nlh = nlmsg_put(skb, portid, seq, type, sizeof(*ndm), flags);
>  	if (nlh == NULL)
> @@ -125,11 +126,16 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
>  		ndm->ndm_flags |= NTF_EXT_LEARNED;
>  	if (test_bit(BR_FDB_STICKY, &fdb->flags))
>  		ndm->ndm_flags |= NTF_STICKY;
> +	if (test_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags))
> +		ext_flags |= NTF_EXT_LOCKED;
>  
>  	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->key.addr))
>  		goto nla_put_failure;
>  	if (nla_put_u32(skb, NDA_MASTER, br->dev->ifindex))
>  		goto nla_put_failure;
> +	if (nla_put_u32(skb, NDA_FLAGS_EXT, ext_flags))
> +		goto nla_put_failure;
> +
>  	ci.ndm_used	 = jiffies_to_clock_t(now - fdb->used);
>  	ci.ndm_confirmed = 0;
>  	ci.ndm_updated	 = jiffies_to_clock_t(now - fdb->updated);
> @@ -171,6 +177,7 @@ static inline size_t fdb_nlmsg_size(void)
>  	return NLMSG_ALIGN(sizeof(struct ndmsg))
>  		+ nla_total_size(ETH_ALEN) /* NDA_LLADDR */
>  		+ nla_total_size(sizeof(u32)) /* NDA_MASTER */
> +		+ nla_total_size(sizeof(u32)) /* NDA_FLAGS_EXT */

Need to add validation that 'NTF_EXT_LOCKED' is not set in
'NDA_FLAGS_EXT' in entries installed by user space.

>  		+ nla_total_size(sizeof(u16)) /* NDA_VLAN */
>  		+ nla_total_size(sizeof(struct nda_cacheinfo))
>  		+ nla_total_size(0) /* NDA_FDB_EXT_ATTRS */
> @@ -1082,6 +1089,11 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>  		modified = true;
>  	}
>  
> +	if (test_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags)) {
> +		clear_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags);
> +		modified = true;
> +	}
> +
>  	if (fdb_handle_notify(fdb, notify))
>  		modified = true;
>  
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 68b3e850bcb9..3d15548cfda6 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -110,8 +110,16 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
>  
>  		if (!fdb_src || READ_ONCE(fdb_src->dst) != p ||
> -		    test_bit(BR_FDB_LOCAL, &fdb_src->flags))
> +		    test_bit(BR_FDB_LOCAL, &fdb_src->flags) ||
> +		    test_bit(BR_FDB_ENTRY_LOCKED, &fdb_src->flags)) {
> +			if (!fdb_src) {
> +				unsigned long flags = 0;
> +
> +				__set_bit(BR_FDB_ENTRY_LOCKED, &flags);
> +				br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, flags);
> +			}

We need a better definition of what 'BR_FDB_ENTRY_LOCKED' means. An
entry marked with this flag is not good enough to let traffic with this
SA ingress from a locked port, but if traffic is received from a
different port with this DA, the bridge will forward it as known
unicast.

If we are going to tell switchdev drivers to ignore locked entries,
packets with this DA will be flooded as unknown unicast in hardware. For
mv88e6xxx you write "The mac address triggering the ATU miss violation
will be added to the ATU with a zero-DPV". What does it mean? Traffic
with this DA will be blackholed?

It would be good to agree on one consistent behavior for all hardware
implementations and the bridge driver. Do you know what happens in other
implementations (e.g., Cisco)?

FWIW, to me it makes sense to have the bridge ignore locked entries and
let traffic be flooded. If user space does not want traffic to egress a
locked port, then it can turn off flooding on the port while it is
locked.

>  			goto drop;
> +		}
>  	}
>  
>  	nbp_switchdev_frame_mark(p, skb);
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 06e5f6faa431..47a3598d25c8 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -251,7 +251,8 @@ enum {
>  	BR_FDB_ADDED_BY_EXT_LEARN,
>  	BR_FDB_OFFLOADED,
>  	BR_FDB_NOTIFY,
> -	BR_FDB_NOTIFY_INACTIVE
> +	BR_FDB_NOTIFY_INACTIVE,
> +	BR_FDB_ENTRY_LOCKED,
>  };
>  
>  struct net_bridge_fdb_key {
> -- 
> 2.30.2
> 
