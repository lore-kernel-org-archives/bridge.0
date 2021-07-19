Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aoEErOZcjbmHWVyzLSCzQUjB6elXDaTEJvEABHsrA1M=;
 b=bzvxh2eiwKELuviYlOC1eGgVdhFqWCsqPbiUXmpkLc0D1ZacxIwLvPrxY8Fp7R5m5N
 ttgFG+u4izjrVKW92j7JDSkyzhUS88RHmNMS5mSCDWaiDcIaZMlrgNaO90mxBxBWEe58
 YjI56tfnQwEjPpweuWe1b1228SZXkGJPkCEqX1VD3P1H7b0Dtxy4rSNq6qdyEVfVuM9I
 bqlyGVb+S/8bVlXftiLUAbT1agg7toIjPSz70zEZFndGxumwEDS4gceMXXdiDWGY6MXD
 MX3fDo+LcPHlh+Q0Tt3tkJVIsq80h+umUkUg/If5lGkQM+e1iStBT8DTQMS564KoW5+6
 3v2w==
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-13-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <42519a8c-65e8-34c6-6513-21e115b08005@gmail.com>
Date: Sun, 18 Jul 2021 19:54:11 -0700
MIME-Version: 1.0
In-Reply-To: <20210718214434.3938850-13-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 12/15] net: dsa: track the number
 of switches in a tree
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>



On 7/18/2021 2:44 PM, Vladimir Oltean wrote:
> In preparation of supporting data plane forwarding on behalf of a
> software bridge, some drivers might need to view bridges as virtual
> switches behind the CPU port in a cross-chip topology.
> 
> Give them some help and let them know how many physical switches there
> are in the tree, so that they can count the virtual switches starting
> from that number on.
> 
> Note that the first dsa_switch_ops method where this information is
> reliably available is .setup(). This is because of how DSA works:
> in a tree with 3 switches, each calling dsa_register_switch(), the first
> 2 will advance until dsa_tree_setup() -> dsa_tree_setup_routing_table()
> and exit with error code 0 because the topology is not complete. Since
> probing is parallel at this point, one switch does not know about the
> existence of the other. Then the third switch comes, and for it,
> dsa_tree_setup_routing_table() returns complete = true. This switch goes
> ahead and calls dsa_tree_setup_switches() for everybody else, calling
> their .setup() methods too. This acts as the synchronization point.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
