Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37DD08392C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5915B83925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695206658; x=1695811458;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7O7mWyhJga1IYEYoLQcrmnzYFbmyVRQyHT7Q+TKsjdE=;
 b=pV8qwlB8fvU58k7cqNKv2CnlHhou84aQyWrR1rxqY4FJ5ZPXng5aQVU/FtJGJ2hhdJ
 ikzCskr5gDLYJwm1eMDDjc61VXim5CsQ10DR13OHAHx8fOFIIihu+svRNVNDyRmo9hoH
 SbHjAdX/hXXK6CK43nJAkgt2xYVJCiWomGTQ1qL0L09CjFdkO4OuVk/wVriIOgXokFG8
 fXl4v+Ey0tyyOLDsH6C59V4Z5VQIU50kq800PWR2jl5TQZk6FARDLhUNR1/p2vMoD/le
 Ld0z+qdBD21Gzxss9/IJgKDtEzjP+A2TLCGU2OQryXBSBALTp1AT1/TOxa6nCUiQNMh0
 +lFA==
Message-ID: <a2a5ede9-c93e-915d-61be-c2c2fab18479@blackwall.org>
Date: Wed, 20 Sep 2023 13:44:16 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-1-39f0293807b8@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-1-39f0293807b8@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 1/6] net: bridge: Set
 BR_FDB_ADDED_BY_USER early in fdb_add_entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

On 9/19/23 11:12, Johannes Nixdorf wrote:
> In preparation of the following fdb limit for dynamically learned entries,
> allow fdb_create to detect that the entry was added by the user. This
> way it can skip applying the limit in this case.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   net/bridge/br_fdb.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index e69a872bfc1d..f517ea92132c 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1056,7 +1056,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>   		if (!(flags & NLM_F_CREATE))
>   			return -ENOENT;
>   
> -		fdb = fdb_create(br, source, addr, vid, 0);
> +		fdb = fdb_create(br, source, addr, vid,
> +				 BIT(BR_FDB_ADDED_BY_USER));
>   		if (!fdb)
>   			return -ENOMEM;
>   
> @@ -1069,6 +1070,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>   			WRITE_ONCE(fdb->dst, source);
>   			modified = true;
>   		}
> +
> +		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>   	}
>   
>   	if (fdb_to_nud(br, fdb) != state) {
> @@ -1100,8 +1103,6 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>   	if (fdb_handle_notify(fdb, notify))
>   		modified = true;
>   
> -	set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
> -
>   	fdb->used = jiffies;
>   	if (modified) {
>   		if (refresh)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

