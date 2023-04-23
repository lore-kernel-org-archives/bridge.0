Return-Path: <hans@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1D7040BCB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00BAB403F8
From: Hans Schultz <netdev@kapio-technology.com>
In-Reply-To: <20230418155902.898627-1-vladimir.oltean@nxp.com>
References: <20230418155902.898627-1-vladimir.oltean@nxp.com>
Date: Sun, 23 Apr 2023 10:47:15 +0200
Message-ID: <875y9nt27g.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v2 net] net: bridge: switchdev: don't notify
 FDB entries with "master dynamic"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, Apr 18, 2023 at 18:59, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index de18e9c1d7a7..ba95c4d74a60 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -148,6 +148,17 @@ br_switchdev_fdb_notify(struct net_bridge *br,
>  	if (test_bit(BR_FDB_LOCKED, &fdb->flags))
>  		return;
>  
> +	/* Entries with these flags were created using ndm_state == NUD_REACHABLE,
> +	 * ndm_flags == NTF_MASTER( | NTF_STICKY), ext_flags == 0 by something
> +	 * equivalent to 'bridge fdb add ... master dynamic (sticky)'.
> +	 * Drivers don't know how to deal with these, so don't notify them to
> +	 * avoid confusing them.
> +	 */
> +	if (test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags) &&
> +	    !test_bit(BR_FDB_STATIC, &fdb->flags) &&
> +	    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
> +		return;
> +

I do not understand this patch. It seems to me that it basically blocks
any future use of dynamic fdb entries from userspace towards drivers.

I would have expected that something would be done in the DSA layer,
where (switchcore) drivers would be able to set some flags to indicate
which features are supported by the driver, including non-static
fdb entries. But as the placement here is earlier in the datapath from
userspace towards drivers it's not possible to do any such thing in the
DSA layer wrt non-static fdb entries.
