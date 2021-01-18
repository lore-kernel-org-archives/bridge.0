Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huQKRyF+cPxGTnM5qH6yP4lujS2G2fERkw+bjRcbVXo=;
 b=YQuBD4UMfHDULURXoRJEleZJNqv465Vjw3Ct12e+/HLln0wQ69QYFbX2wwLmhrQYYHb+O4Nf5mherSQ0uhmKd1QY84UKLGt/Wdd+LM6uxmPQQ8JQOJKdHaayg36ORUDMSXNWB3U1ciaggxa/+7l3oo2k+f/s1DL53Vjdm3KAgB8=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 18 Jan 2021 19:46:33 +0000
Message-ID: <20210118194632.zn5yucjfibguemjq@skbuf>
References: <20210118181319.25419-1-rasmus.villemoes@prevas.dk>
 <20210118185618.75h45rjf6qqberic@soft-dev3.localdomain>
In-Reply-To: <20210118185618.75h45rjf6qqberic@soft-dev3.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B34DD5F0C5F73846BE43860E1285F4DC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] net: mrp: use stp state as substitute for
 unimplemented mrp state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Jan 18, 2021 at 07:56:18PM +0100, Horatiu Vultur wrote:
> The reason was to stay away from STP, because you can't run these two
> protocols at the same time. Even though in SW, we reuse port's state.
> In our driver(which is not upstreamed), we currently implement
> SWITCHDEV_ATTR_ID_MRP_PORT_STATE and just call the
> SWITCHDEV_ATTR_ID_PORT_STP_STATE.

And isn't Rasmus's approach reasonable, in that it allows unmodified
switchdev drivers to offload MRP port states without creating
unnecessary code churn?

Also, if it has no in-kernel users, why does it even exist as a
switchdev attribute?=
