Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD3BD6165B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C879561656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idQAA3su+OjiYiO4q6bH1uj+J+94UC8KjOQwOLnM8q4=;
 b=qiZPqYbAf/xyR7k2sZ8pXfy1JYHj3nKwWteMhG5cM2TZBhI9DrWTsN+rrx9Ufdj0PE/4p5Y6nWr/fCKN4PHVfSsDgFGEUXb/J6n69yfcDevZSXf9YO5qoRLk1uY414n+vmsW+H4PVmgqnItgQ6PJZNJeA9IGfbK2JkTVDnzcjJWURpg+hWlX8aBh7DgB7Dz0HSRVqp8hR1i8cy84mmGp+Wyfd5zz2CzjQZm8lQGuqYuNcT1Y14ZzHz2EHmxSjeRXa2RJuUq9QWHeFsA26vvVvFZR4PSMInGGQ3WPfPWQfixd2n8SRWKo9hyJ80wQDbrf+F1ou8vzA6UagB4f8sb6/g==
Date: Wed, 19 Apr 2023 15:49:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZD/jaASktd2cBlnI@shredder>
References: <20230418155902.898627-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418155902.898627-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
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
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, "Hans J. Schultz" <netdev@kapio-technology.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, Apr 18, 2023 at 06:59:02PM +0300, Vladimir Oltean wrote:
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index de18e9c1d7a7..ba95c4d74a60 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -148,6 +148,17 @@ br_switchdev_fdb_notify(struct net_bridge *br,
>  	if (test_bit(BR_FDB_LOCKED, &fdb->flags))
>  		return;

Thanks for the patch. Ran a few tests and looks fine. Will report full
results tomorrow morning.

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
>  	br_switchdev_fdb_populate(br, &item, fdb, NULL);
>  
>  	switch (type) {
> -- 
> 2.34.1
> 
