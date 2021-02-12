Return-Path: <nikolay@nvidia.com>
References: <20210212151600.3357121-1-olteanv@gmail.com>
 <20210212151600.3357121-3-olteanv@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <23cc0f12-34a8-7a56-0bba-82bd4b2d3a44@nvidia.com>
Date: Fri, 12 Feb 2021 17:57:53 +0200
In-Reply-To: <20210212151600.3357121-3-olteanv@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1613145507; bh=LSft3buX4w1vCQIlPiRj8m8wbjb175Ig0+OfBdf/5hs=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
 Authentication-Results:Subject:To:CC:References:From:Message-ID:
 Date:User-Agent:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
 X-Microsoft-Antispam-PRVS:X-Header:X-MS-Oob-TLC-OOBClassifiers:
 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=o9BiMKXn7VurEx/LimWb4nyWAJ5BYu0Ko5MJ0SVBI1PkKwM/TD/vHyPfhradzZDrv
 wG7OMIjbUFu6i0ASV/j/LOwMs5mD7yEeTCyYlelLFtQ6qX2qCVgAfd5ufimw/9R6JD
 v5bQjnSq7apNvrN9QBW1Kjavjfne/8JBRLDXN1g07/RkZ/Z94/ocuHRgcfijWr+ifj
 MUnwmdzL7kvbrGO6C9TtKwQiCfIh8U5vaqgiNG8WTqEqYIJOHez1fwEb9gqZJYRCDj
 QIcxH/4dB9eKrOi6D3b3iU6uQYmeZT3Y7kMupEt0kCAzmdiyslpWqSYjPV2gYBRs+V
 V2n/4U+ITS7QA==
Subject: Re: [Bridge] [PATCH v5 net-next 02/10] net: bridge: offload all
 port flags at once in br_setport
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vignesh Raghavendra <vigneshr@ti.com>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

On 12/02/2021 17:15, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> If for example this command:
> 
> ip link set swp0 type bridge_slave flood off mcast_flood off learning off
> 
> succeeded at configuring BR_FLOOD and BR_MCAST_FLOOD but not at
> BR_LEARNING, there would be no attempt to revert the partial state in
> any way. Arguably, if the user changes more than one flag through the
> same netlink command, this one _should_ be all or nothing, which means
> it should be passed through switchdev as all or nothing.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Changes in v5:
> None.
> 
> Changes in v4:
> Leave br->lock alone completely.
> 
> Changes in v3:
> Don't attempt to drop br->lock around br_switchdev_set_port_flag now,
> move that part to a later patch.
> 
> Changes in v2:
> Patch is new.
> 
> Changes in v2:
> Patch is new.
> 
>  net/bridge/br_netlink.c   | 109 ++++++++++++--------------------------
>  net/bridge/br_switchdev.c |   6 ++-
>  2 files changed, 39 insertions(+), 76 deletions(-)
> 

LGTM, thanks!
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

