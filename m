Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibWjDYu68BL98//0lJA5+SS6IB70lIF2mPax0NjfKPM=;
 b=QL8UHmjxl8PqvyBmdp3yo1u5zoSip2zxMS2l7++g7zHSFKl1x7FS9aXYQIobTnHqwE7cTMWOUub6Xb2x5T8KOG5MeNK1UplM6BpcbgG0I32a036p/WIpwMDKMx79f3E/fBaFMqUA/WgKqT5UkuxCLXHXJQEnvngLOp6YGd1puoY=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 3 Aug 2021 23:15:23 +0000
Message-ID: <20210803231523.fgddxdurgg4x5u4e@skbuf>
References: <20210803203409.1274807-1-vladimir.oltean@nxp.com>
 <20210803204329.534dpqxrlk64kqqi@skbuf>
In-Reply-To: <20210803204329.534dpqxrlk64kqqi@skbuf>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <015063BB9F45144CB1B42C9FF9BEC493@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v2 net-next 0/2] Convert
 switchdev_bridge_port_{, un}offload to notifiers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Arnd Bergmann <arnd@kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>

On Tue, Aug 03, 2021 at 11:43:29PM +0300, Vladimir Oltean wrote:
> Obsoleted by v2:
> https://patchwork.kernel.org/project/netdevbpf/cover/20210803203409.12748=
07-1-vladimir.oltean@nxp.com/

Sorry, this is in fact v2, the most up to date version currently, it is
not obsoleted by anything.=
