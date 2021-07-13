Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VZLJ586W2PwJd2sivbAeLi0nlzQsGfkkjBmYbr9j5wA=;
 b=Q0dC9RzGsj902Tzs5OsHXueHNW2RKcNs1HQ6Il/WazTI2aiM2ms7l3cK01aB96VdWx
 9S2TFUFphF+bSA8temDFhBxnSYpTzgBF7UCTQkniXEW4SrMZUh9MO9yfDjtvGaa+7aCp
 pa4/rl7ZG3mdkVYhTiYMxRU37sSfOiIQQDMBBpcp881Oo3/9M8yk5bQxGj+/xoMp/V28
 u+4RzGx5ydEW5vjnbsmuR83bVbMr9SfgYYMtX3nSVU/jWOaOnLcApUsp9O6gbjOFsLkH
 zWt/1FBzDMAYnMyD7CToaD6JK42cpAAVeoxpcSoZ5gM2yj2bnHhAoac/ooY4XEn+Unky
 aIkw==
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
 <20210712152142.800651-2-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <48103d5c-9d2e-2cd8-727a-658b0bbab663@gmail.com>
Date: Mon, 12 Jul 2021 19:20:50 -0700
MIME-Version: 1.0
In-Reply-To: <20210712152142.800651-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH v3 net-next 01/24] net: dpaa2-switch: use
 extack in dpaa2_switch_port_bridge_join
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>



On 7/12/2021 8:21 AM, Vladimir Oltean wrote:
> We need to propagate the extack argument for
> dpaa2_switch_port_bridge_join to use it in a future patch, and it looks
> like there is already an error message there which is currently printed
> to the console. Move it over netlink so it is properly transmitted to
> user space.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
