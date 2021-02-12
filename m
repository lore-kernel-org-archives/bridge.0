Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KX9BczQ7HP081Zb6fQayQzqKfWFTa3oP2nKnpxD0UUU=;
 b=dobcntpA4hP7ES4I7J3tbO+Dq/F2O2WJKrVGbRVjnR+nJkpwvHXlG5hFMOfyDKoLj6
 bQ51oQqQRYgJW+y00/jFsqUqSc+dYvdqM2Al1jDQxxYhv7mxHDb/OOaHiVpie75VlH/j
 giYQvWVZx9vsnBCC0g8f96MRmsPPJ+X4JIUCxvbg0RkTR/7CGjsSdU4U4ChmzspeFt3t
 BbebdtgH31J6iTgcWIzke6pj4RT3+x57OPpJxCLi3NDZ3LEEHJ3m5YN7FFK8aull5xiW
 ugo241axW1+tn5MHnPbI4ti49BIoNxgCa9c36t3P0naug02hrgeyS0sKSWiav0rAYfTR
 qFBA==
References: <20210212010531.2722925-1-olteanv@gmail.com>
 <20210212010531.2722925-2-olteanv@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c559a6fc-b436-fc6f-7226-76490033d94c@gmail.com>
Date: Thu, 11 Feb 2021 19:20:33 -0800
MIME-Version: 1.0
In-Reply-To: <20210212010531.2722925-2-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 1/9] net: switchdev: propagate
 extack to port attributes
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



On 2/11/2021 5:05 PM, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> When a struct switchdev_attr is notified through switchdev, there is no
> way to report informational messages, unlike for struct switchdev_obj.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
