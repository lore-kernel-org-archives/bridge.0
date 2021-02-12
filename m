Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jzL26zkMdAnOD2IACVtEn2EhF+H59r0z5RTwLn52Y3M=;
 b=GGYIq9OqvYpdw/0qjHnAVD0LJTXFfZcF0KciroJWpaauQnVLdTBpp/glr+Vy5rULBz
 9VQOkY+RSQu4SXh0pD54mneZPEI8+KptrYQxXK2wDgIv7dRYwDkvBbXidHT29ddo2i9u
 QMWmiWE3Clmpx/3DFGzuaaDPXA8xVqFM8kqIKuoDLbSdppwy39dQhLw6H33A/7tjNqRf
 0rrqJegRUUHMsrSQu0qKnuVbRY376nmZlbdGeyrM4WjUol11Z91O6oXU8BJKwaOIkEeT
 IhbGpgQV/Ev8g2EZ5l6XtPPUyZU1vOrrxCilIU3WEk6hoi9TFj5Gs0+sBMLGJyD7GuOM
 9pEg==
References: <20210212151600.3357121-1-olteanv@gmail.com>
 <20210212151600.3357121-4-olteanv@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6097810e-9b74-df81-ccc4-3a4b47b94b67@gmail.com>
Date: Fri, 12 Feb 2021 10:07:14 -0800
MIME-Version: 1.0
In-Reply-To: <20210212151600.3357121-4-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 03/10] net: bridge: don't print in
 br_switchdev_set_port_flag
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
> For the netlink interface, propagate errors through extack rather than
> simply printing them to the console. For the sysfs interface, we still
> print to the console, but at least that's one layer higher than in
> switchdev, which also allows us to silently ignore the offloading of
> flags if that is ever needed in the future.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

I suppose the slight "loss" of information on which port failed the
operation is okay since it was implied by either the path (sysfs) or the
bridge command.
-- 
Florian
