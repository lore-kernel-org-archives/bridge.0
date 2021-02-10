Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wXYUm5
 sqPqEmEMkn7WH/JtpvQmsaYI2cjrart5PSwqI=; b=AMefiAdY+GroMjfPiYxXzS
 TAUtIPzaM5CiXWePeYtd0vK2JCl9YVzCJ3h0t1XndvC1GOHB0CWjjNgMla7aD0J2
 v+Qx0nVTDlZEjOAGzFLSimljOht1MGVGC1UEGM6mIoG8ya+gj1jreMeZGu9xjOOn
 oP71xyDwP6N/Kpt20CPl+pMOWdk4N3phhDZebdC5zLWQoxZzaeIISboAXCDPVD3F
 wBH4x0UNNtL5ftSWE55HIMkeaPSgOOGPK0riRgW0VY6bfm35sN5cc8pHGGDbPgRk
 BFsjIevyaLl9Yzy6zxIAc8Lg2x/JP6kaKVwlCgc/AvkeXQBfAcf2yZscFXmPA3jw
 ==
Date: Wed, 10 Feb 2021 12:12:57 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20210210101257.GA287766@shredder.lan>
References: <20210210091445.741269-1-olteanv@gmail.com>
 <20210210091445.741269-8-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210091445.741269-8-olteanv@gmail.com>
Subject: Re: [Bridge] [PATCH v3 net-next 07/11] net: prep switchdev drivers
 for concurrent SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Taras Chornyi <tchornyi@marvell.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>

On Wed, Feb 10, 2021 at 11:14:41AM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Because the bridge will start offloading SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
> while not serialized by any lock such as the br->lock spinlock, existing
> drivers that treat that attribute and cache the brport flags might no
> longer work correctly.

Can you explain the race? This notification is sent from sysfs/netlink
call path, both of which take rtnl.
