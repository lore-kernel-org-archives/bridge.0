Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fXM+kDR6BMksJL+pl1kUFKSGzKtPwwl+jc1moEjdY04=;
 b=kRxTN6iGUtZeTLnxMAj6jnynBo6moA+GZjz+GGag4kj1YdOvKYcfzYBwCj+hTr5KHE
 EjtdOmI4LIEqPndFUKUtLqk29l5U9m//mfUu4lvGOTcch2/WqFYkY/OLztEbPKWcII5X
 IOek3ztKicfMd9S7oDpYVd/teDz+RgovyZrqrSm/HKzS9U7MawrVdMje4PZ8w0MG0oqM
 B2eU8T3XKBc6ubiwik6DAFlaf7ZW1RwmvoW2ei3HKWVb5JlaFKNNAzLeR0RF2Qyaup29
 DDKOae++8UqzX/lvAakgchIhYVfAN9qycnU5HjuaqNMhmw7RCBRESzO3GmncadjUVNqn
 T+yg==
References: <20210210091445.741269-1-olteanv@gmail.com>
 <20210210091445.741269-10-olteanv@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <62b8a59d-7856-ba7a-aac5-4b792a2a4a3b@gmail.com>
Date: Wed, 10 Feb 2021 20:19:16 -0800
MIME-Version: 1.0
In-Reply-To: <20210210091445.741269-10-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 net-next 09/11] net: mscc: ocelot: use
 separate flooding PGID for broadcast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>



On 2/10/2021 1:14 AM, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> In preparation of offloading the bridge port flags which have
> independent settings for unknown multicast and for broadcast, we should
> also start reserving one destination Port Group ID for the flooding of
> broadcast packets, to allow configuring it individually.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
