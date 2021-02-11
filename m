Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ofWIvbul8lUQjDjEqyhG2qv/DpTdeTq9suCAukT4VnE=;
 b=cJkf+VIciLaXv1lixjdR8iXxDvJD4ZVrqUo9pLZZOczna0nt6lXw+gvOZNbOiFr9Ax
 xXLtvTJtKB5ICTmJeynxBdn39We/Qj+tzybWJLI+YpQpya8NbF7CEqhU7uDvPD9/+aOb
 X0MP9xdLMPmQZ1cdXlY2M8wEiztJgbsc+o3R1enU36K44psdbuPcp0FECGfnmjGLvkEl
 pbmJ/ca9FeGs5zLyGfHWDyiQ2R41jRN6favzNvY7kfjbXs7nx57QxGt5Mgrp1a/IBocm
 NkcfcU38GSec03drey6h7xPphlkEwIMZIn88AfGtDhxqRP3qliCqabex9N/PNUJs9bvl
 9l8Q==
References: <20210210091445.741269-1-olteanv@gmail.com>
 <20210210091445.741269-11-olteanv@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a5a4e1e8-8370-954f-ab4e-20a52f54d468@gmail.com>
Date: Wed, 10 Feb 2021 20:20:21 -0800
MIME-Version: 1.0
In-Reply-To: <20210210091445.741269-11-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 net-next 10/11] net: mscc: ocelot: offload
 bridge port flags to device
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
> We should not be unconditionally enabling address learning, since doing
> that is actively detrimential when a port is standalone and not offloading
> a bridge. Namely, if a port in the switch is standalone and others are
> offloading the bridge, then we could enter a situation where we learn an
> address towards the standalone port, but the bridged ports could not
> forward the packet there, because the CPU is the only path between the
> standalone and the bridged ports. The solution of course is to not
> enable address learning unless the bridge asks for it.
> 
> We need to set up the initial port flags for no learning and flooding
> everything, then the bridge takes over. The flood configuration was
> already configured ok in ocelot_init, we just need to disable learning
> in ocelot_init_port.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
