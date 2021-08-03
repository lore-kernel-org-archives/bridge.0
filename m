Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naiLnK5Z8Oi+Ea1QkJfEpIzr9B1/OLmKcdpkiIqCX8E=;
 b=ULzfQzbIjDTJmuwYSshczugyMyO0FA7c4WaXprZuMrIG+Tg+Bof4r9AjtZ5VTrDT1UAwOq4KxA3NjOD8rrzOpNbTWKIl92yoxUnW3Sj/rKXXWjdVqsoCu6VNcuOBIR1q/rMhsStBZQZnIx/EaA9lWgwhmMtUxMZzqZJV/PN8W6I=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 3 Aug 2021 20:43:30 +0000
Message-ID: <20210803204329.534dpqxrlk64kqqi@skbuf>
References: <20210803203409.1274807-1-vladimir.oltean@nxp.com>
In-Reply-To: <20210803203409.1274807-1-vladimir.oltean@nxp.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A898D30362C4784185316C9888DBA9D7@eurprd04.prod.outlook.com>
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

Obsoleted by v2:
https://patchwork.kernel.org/project/netdevbpf/cover/20210803203409.1274807=
-1-vladimir.oltean@nxp.com/=
