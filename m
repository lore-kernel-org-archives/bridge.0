Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DYSCyXslW7JpprNOrHc5FjADncBRkdDqs3PWphAwNEU=;
 b=rSedlesAGjgO7MengPEN38iUKrRFhSnQ9IDS57b7dEzmhPwvLXpm4PNrLLqaLDDWGS
 t/bek5mE5JocEFy2hDyqKsNBZ2HCm7vdjEUWKHIkuEsfjaug3X2zFKE1z1uQX7BgqDh9
 TSyV16NxdPZkBIWcjgFH5a5pqLm/LVbULSIs3cD9oaqMfL0gLc3nh/2+2SkAcg7N4tdW
 3vh3jyeQaCtNfInJMcufkK6qZ7z9DHhAYOU60lj9P30xtEjbMkwnQrvpm/CC/LvpzAKW
 IrOHNxRFtakhbjWHauelHwN6T50yg5AWQ8CaK2dr7uBQQRjCJ5qLIF9QvzigTgkd0QlS
 o6Zg==
References: <20210212151600.3357121-1-olteanv@gmail.com>
 <20210212151600.3357121-8-olteanv@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <05a93c4b-2180-afea-d077-3b1c91312b41@gmail.com>
Date: Fri, 12 Feb 2021 10:12:34 -0800
MIME-Version: 1.0
In-Reply-To: <20210212151600.3357121-8-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 07/10] net: dsa: felix: restore
 multicast flood to CPU when NPI tagger reinitializes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, Vignesh Raghavendra <vigneshr@ti.com>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>



On 2/12/2021 7:15 AM, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> ocelot_init sets up PGID_MC to include the CPU port module, and that is
> fine, but the ocelot-8021q tagger removes the CPU port module from the
> unknown multicast replicator. So after a transition from the default
> ocelot tagger towards ocelot-8021q and then again towards ocelot,
> multicast flooding towards the CPU port module will be disabled.
> 
> Fixes: e21268efbe26 ("net: dsa: felix: perform switch setup for tag_8021q")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
