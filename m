Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DE84402A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FE574013C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693947206;
 bh=McSbLrGFeETjic6sxW1tV/OSWfLMVGkO3zyx6fwzAD8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=UmYaix6CMXspfjsBHFwu9TqeDcbAUtZLSJZhiKGh93y/eTW0vFVZJksebBSqKMjLO
 yIHp6jvY+64Ln8w9tABawpSdI/0EU98HLVDxShMib/n1t5txZ6egG1AnL0vai4ViSu
 bc1R5cApLR25xwhR+9zvoRBDokPdWly7zgnJNoDBsij3zR3yM7k3zlWR5T1GyCoXCg
 yVL+CAHlxjfdsaEbDjhooNsTX5623b7o58ClhAkBbfBcbIDHrVU4YzchWihT7JFr93
 jXgHIN+ALaNkt7RHe3guGRF88dO+XDHjysqWtho5zmrjGIwd42IgWry720IsAq+KNL
 bU8iSehESqm+A==
Date: Tue, 5 Sep 2023 13:53:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230905135324.1b9f7be4@kernel.org>
In-Reply-To: <20230905-fdb_limit-v3-1-7597cd500a82@avm.de>
References: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
 <20230905-fdb_limit-v3-1-7597cd500a82@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 1/6] net: bridge: Set
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>, Vladimir Oltean <vladimir.oltean@nxp.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, David Ahern <dsahern@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Tue, 05 Sep 2023 13:47:18 +0200 Johannes Nixdorf wrote:
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1056,7 +1056,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>  		if (!(flags & NLM_F_CREATE))
>  			return -ENOENT;
>  
> -		fdb = fdb_create(br, source, addr, vid, 0);
> +		fdb = fdb_create(br, source, addr, vid, BIT(BR_FDB_ADDED_BY_USER));

Please try to wrap your code at 80 chars. Also:

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

