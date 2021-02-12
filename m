Return-Path: <nikolay@nvidia.com>
References: <20210212151600.3357121-1-olteanv@gmail.com>
 <20210212151600.3357121-4-olteanv@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <a087531e-59f3-cadb-da69-e6b1e7b521f2@nvidia.com>
Date: Fri, 12 Feb 2021 17:59:24 +0200
In-Reply-To: <20210212151600.3357121-4-olteanv@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1613145591; bh=PGxgvwGmLROjZIYredrYug2Omsu8c9w171ZNtaAEwIQ=;
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
 b=Gz0/u9deOFaO0hRlsx5cOFAR/Ja/dfl44yKe014JHw/oUnxK9jScrhS2hKM1TtYwj
 DcZ9mcUZPOe8FRtPanzHM0l/WR6wyp8Y2MrfXNXwy/El1NDDG4p0neuHFYEpFNtJ94
 3SW7qV34l7mzFLBLySRkdPepBDfKxA/KC7cEb20s9HKHQN/PQZCYKpcYXqAIJ0TYsu
 Ry3Zh62tNq0DmgiKVBhxJKKv/2sHzEptv3TcsOHGTSXP4auaNDcc0CbvcIWR2dosFg
 CEktwIUML/OwToRJT3fW1TAaPiRx2T/lVavHi3RcWTmVDtwoAkgYmRLIX9YWODQHHJ
 Mk/sxXdvYq4CQ==
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vignesh Raghavendra <vigneshr@ti.com>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

On 12/02/2021 17:15, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> For the netlink interface, propagate errors through extack rather than
> simply printing them to the console. For the sysfs interface, we still
> print to the console, but at least that's one layer higher than in
> switchdev, which also allows us to silently ignore the offloading of
> flags if that is ever needed in the future.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Changes in v5:
> None.
> 
> Changes in v4:
> - Adjust the commit message now that we aren't notifying initial and
>   final port flags from the bridge any longer.
> 
> Changes in v3:
> - Deal with the br_switchdev_set_port_flag call from sysfs too.
> 
> Changes in v2:
> - br_set_port_flag now returns void, so no extack there.
> - don't overwrite extack in br_switchdev_set_port_flag if already
>   populated.
> 
>  net/bridge/br_netlink.c   |  9 +++++----
>  net/bridge/br_private.h   |  6 ++++--
>  net/bridge/br_switchdev.c | 13 +++++++------
>  net/bridge/br_sysfs_if.c  |  7 +++++--
>  4 files changed, 21 insertions(+), 14 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>


