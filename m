Return-Path: <nikolay@nvidia.com>
References: <20210212151600.3357121-1-olteanv@gmail.com>
 <20210212151600.3357121-2-olteanv@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <87f41037-4c96-b3bc-6753-03959bdd5075@nvidia.com>
Date: Fri, 12 Feb 2021 18:00:54 +0200
In-Reply-To: <20210212151600.3357121-2-olteanv@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1613145683; bh=eoxey4uRaDwnphH3f/Ib4i8PhWfZ6jebVvSmOWQ4hkY=;
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
 b=iAJ0HI2eVn44gvIuMlQpA2t2I4QhKwNKoodW8cRy1dYKcKdodpUabJgZFlrqT4p5N
 JIIMKyMG/mUKQbVSyc6JcFVJHBrnr6ZvMMlpJquMdwED2XvHO7I1cvdir6V6REk1fQ
 AVIZgjSxfZt/LsKIjAaY5IH0Gn86EkcYZ3/Z6k6DN6/3hKCMy5rupmCJKIxT8oLbBJ
 51aqhMD62yuF6wR+61RxDcvrhbS2CEFKx09M+/zODnw3Frq1e6e9ps+Gm7lEjDlrqw
 VzymRT/sCD/PBFYAboik5hG/ESdlv4H5QmyIp6ROtveb4nQppJwBllEeS8iD2gQzCn
 3V2KxQp6gfbRw==
Subject: Re: [Bridge] [PATCH v5 net-next 01/10] net: switchdev: propagate
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vignesh Raghavendra <vigneshr@ti.com>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

On 12/02/2021 17:15, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> When a struct switchdev_attr is notified through switchdev, there is no
> way to report informational messages, unlike for struct switchdev_obj.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v5:
> Rebased on top of AM65 CPSW driver merge.
> 
> Changes in v4:
> None.
> 
> Changes in v3:
> None.
> 
> Changes in v2:
> Patch is new.
> 
>  .../ethernet/marvell/prestera/prestera_switchdev.c    |  3 ++-
>  .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c  |  3 ++-
>  drivers/net/ethernet/mscc/ocelot_net.c                |  3 ++-
>  drivers/net/ethernet/ti/am65-cpsw-switchdev.c         |  3 ++-
>  drivers/net/ethernet/ti/cpsw_switchdev.c              |  3 ++-
>  include/net/switchdev.h                               |  6 ++++--
>  net/dsa/slave.c                                       |  3 ++-
>  net/switchdev/switchdev.c                             | 11 ++++++++---
>  8 files changed, 24 insertions(+), 11 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@nvidia.com>


