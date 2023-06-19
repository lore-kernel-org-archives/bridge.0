Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10AF740CB9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 093114014E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3UzyzaT10w+xbRr2SX1Kym5fmfV7tJ8gI/eKNZ0Jf0=;
 b=oAy+oTtoALe8My8z+YmHx5BEv+CtBTOFO17JROH+KdzhKQbOBGoFutOXIpOquXWR9/81ZN/xGIUmzvNQU7YUIOjTviGvZV07MDI29YR1KLLDT3q25fZf/gNkrBJvcIvCkfvXnYPy6RjrZCVhm+SxrutNahNzf4bX2Z8KY5+RXETaqy1gPYgfXPbsIWmZ7jEm/BTkPxztCDJ9wGH/0WXI98goznnwMe1K+XOe4QnsGmnMEpfpF4dc6zNXfqlSF3NMthD2c1psxHSZ9Yp3CKo8Ka66sMQLtmzMFV48gzYAglAU8u00400th8OJCzZYiy4tkPsNM3DOd/ofW/YpYmPXEw==
Date: Mon, 19 Jun 2023 17:50:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZJBrR/ZqZ4AX5Kat@shredder>
References: <20230619071444.14625-1-jnixdorf-oss@avm.de>
 <20230619071444.14625-2-jnixdorf-oss@avm.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619071444.14625-2-jnixdorf-oss@avm.de>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v2 1/3] bridge: Set
 BR_FDB_ADDED_BY_USER early in fdb_add_entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Oleksij Rempel <linux@rempel-privat.de>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Mon, Jun 19, 2023 at 09:14:41AM +0200, Johannes Nixdorf wrote:
> This allows the called fdb_create to detect that the entry was added by
> the user early in the process. This is in preparation to adding limits
> in fdb_create that should not apply to user created fdb entries.

Use imperative mood:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> 

Remove the blank line

> ---
> 
> Changes since v1:
>  - Added this change to ensure user added entries are not limited.
> 
>  net/bridge/br_fdb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index e69a872bfc1d..ac1dc8723b9c 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1056,7 +1056,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>  		if (!(flags & NLM_F_CREATE))
>  			return -ENOENT;
>  
> -		fdb = fdb_create(br, source, addr, vid, 0);
> +		fdb = fdb_create(br, source, addr, vid, BR_FDB_ADDED_BY_USER);

BIT(BR_FDB_ADDED_BY_USER)

>  		if (!fdb)
>  			return -ENOMEM;
>  
> @@ -1069,6 +1069,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>  			WRITE_ONCE(fdb->dst, source);
>  			modified = true;
>  		}
> +
> +		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>  	}
>  
>  	if (fdb_to_nud(br, fdb) != state) {
> @@ -1100,8 +1102,6 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>  	if (fdb_handle_notify(fdb, notify))
>  		modified = true;
>  
> -	set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
> -
>  	fdb->used = jiffies;
>  	if (modified) {
>  		if (refresh)
> -- 
> 2.40.1
> 
