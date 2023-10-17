Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 905F840977
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E92FE404F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1697540774; x=1697627174; bh=gk4uH597iCVOZ
 ZIrN/RdNf7XGlip0tVQ+qETf0YnWnM=; b=uub9dAtaSbqCsb5DHt/7NzLuERclT
 ci/W/XwyQ6GgWFzejlhKNAEcIuZ4ZVgq9dUL7DthXYE+X7aBjqhXvIqbq8kGeTXz
 xaQD+E9I1513hcuio8WWpWBhicj9ER/J/7T5dQN+kiRahW5hIFHLfOkaHsi1+Vb1
 /cC1UcSp9TZ+GgrF7sCUWRE2QGVcTRDdS2GEt0EYzFj7/Fb5Xwu3II2IDc+yxs03
 9ZLzu19qbcYUJ2WDf7lJV2JDSAu+6V3qHY+aplIaRSoTPWM/x7BZyr4/Qd8MTV2r
 N45iHMctDsCZharssV6oaB9TFaMQZOOplSOC9ApQl94xCq7lqNiqSuL6g==
Date: Tue, 17 Oct 2023 14:06:07 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <ZS5qn0cv8InB/qn+@shredder>
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
 <20231016-fdb_limit-v5-3-32cddff87758@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-fdb_limit-v5-3-32cddff87758@avm.de>
Subject: Re: [Bridge] [PATCH net-next v5 3/5] net: bridge: Add netlink knobs
 for number / max learned FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>, Vladimir Oltean <vladimir.oltean@nxp.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Oct 16, 2023 at 03:27:22PM +0200, Johannes Nixdorf wrote:
> The previous patch added accounting and a limit for the number of
> dynamically learned FDB entries per bridge. However it did not provide
> means to actually configure those bounds or read back the count. This
> patch does that.
> 
> Two new netlink attributes are added for the accounting and limit of
> dynamically learned FDB entries:
>  - IFLA_BR_FDB_N_LEARNED (RO) for the number of entries accounted for
>    a single bridge.
>  - IFLA_BR_FDB_MAX_LEARNED (RW) for the configured limit of entries for
>    the bridge.
> 
> The new attributes are used like this:
> 
>  # ip link add name br up type bridge fdb_max_learned 256
>  # ip link add name v1 up master br type veth peer v2
>  # ip link set up dev v2
>  # mausezahn -a rand -c 1024 v2
>  0.01 seconds (90877 packets per second
>  # bridge fdb | grep -v permanent | wc -l
>  256
>  # ip -d link show dev br
>  13: br: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 [...]
>      [...] fdb_n_learned 256 fdb_max_learned 256
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
