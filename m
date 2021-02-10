Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QQ6ibbCKatXHbmogp1EYUWCfgYRqjn+iKPBMKIlVQ9Y=;
 b=OkJLE9Z6va0hGpYeZtIu0b6Wy37PWF448S8/SjiY1YwifTyTSCGyrf8vP3VuzJhXd1
 BKN95vIGZ0/+gbavKal1KBQKQdB3ZaRKur+vj8sqClkSST3DEdCtAtwirYgQUdQ58+Dc
 pthI/LlvvBEWvwPtcsKOLF8FPsPT1Kr0SBfl3uQZEqjdnKGZqenIo5nneu+75/k9NCZ8
 gGQAESEpycLRXJpav6xndQBQlyVKQ1TuBqZI3SBkRN5q2teM1/dNOJXeqK4FUh7avo26
 6FKcCdariok/z2pdUMdr2L4ysXMcBTnVzieWTdRKyENiEY7tgAhbEbwibXo5bTffHb+8
 zLDQ==
Date: Wed, 10 Feb 2021 12:23:28 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210210102328.7jpzlobpwotdo63z@skbuf>
References: <20210210091445.741269-1-olteanv@gmail.com>
 <20210210091445.741269-8-olteanv@gmail.com>
 <20210210101257.GA287766@shredder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210101257.GA287766@shredder.lan>
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
To: Ido Schimmel <idosch@idosch.org>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Taras Chornyi <tchornyi@marvell.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>

On Wed, Feb 10, 2021 at 12:12:57PM +0200, Ido Schimmel wrote:
> On Wed, Feb 10, 2021 at 11:14:41AM +0200, Vladimir Oltean wrote:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > 
> > Because the bridge will start offloading SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
> > while not serialized by any lock such as the br->lock spinlock, existing
> > drivers that treat that attribute and cache the brport flags might no
> > longer work correctly.
> 
> Can you explain the race? This notification is sent from sysfs/netlink
> call path, both of which take rtnl.

Replying here to both you and Nikolay: there isn't any race, sorry, I
missed the fact that brport_store takes the rtnl_mutex and by extension
I thought that RTM_SETLINK runs unlocked too, without really checking.
Well, at least that's good news, the implementation can be a lot more
straightforward then...
