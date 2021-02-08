Return-Path: <nikolay@nvidia.com>
References: <20210207194733.1811529-1-olteanv@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <3d1758eb-1aa0-1272-4183-27b14524127f@nvidia.com>
Date: Mon, 8 Feb 2021 13:11:31 +0200
In-Reply-To: <20210207194733.1811529-1-olteanv@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612782702; bh=54eFnTmaGhhT3f7XgVqe3P7OVXl69xXA7g9t9Ic2PyI=;
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
 b=sIAMF3UbE+Ye18EOVZ4r/gWZCDu+GAzjoLu+m1VjvNdxPJx1eF3hlovaWXwuTzen8
 P1Uvwq4BpsyM6gsAG2+jKYcbrnB3EpXbzNZStXuMHr4BFq4Wp6XxBIFcyQ5KDuiALs
 a8mYfZKn3tABOVDg6m3wR9qOmRFK1o9CBl8UL0kdOXK2pIcze7CaDDMlixvGs+6ZrC
 Xku+sT02Du7T/G4rJgraXypJxQDkQmis1yEyXI2XXerGEHUdtm2UEs6EKrGKCEwpnF
 LnTfYHqsmciTfW4qsVE9USw9w86ooB/81ftBqxeoKdr5q18IIfUi/DTunXVpEgT7GT
 XhGD2IA/Pi7pw==
Subject: Re: [Bridge] [PATCH net] net: bridge: use switchdev for port flags
 set through sysfs too
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>

On 07/02/2021 21:47, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Looking through patchwork I don't see that there was any consensus to
> use switchdev notifiers only in case of netlink provided port flags but
> not sysfs (as a sort of deprecation, punishment or anything like that),
> so we should probably keep the user interface consistent in terms of
> functionality.
> 
> http://patchwork.ozlabs.org/project/netdev/patch/20170605092043.3523-3-jiri@resnulli.us/
> http://patchwork.ozlabs.org/project/netdev/patch/20170608064428.4785-3-jiri@resnulli.us/
> 
> Fixes: 3922285d96e7 ("net: bridge: Add support for offloading port attributes")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  net/bridge/br_sysfs_if.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 96ff63cde1be..5aea9427ffe1 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -59,9 +59,8 @@ static BRPORT_ATTR(_name, 0644,					\
>  static int store_flag(struct net_bridge_port *p, unsigned long v,
>  		      unsigned long mask)
>  {
> -	unsigned long flags;
> -
> -	flags = p->flags;
> +	unsigned long flags = p->flags;
> +	int err;
>  
>  	if (v)
>  		flags |= mask;
> @@ -69,6 +68,10 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
>  		flags &= ~mask;
>  
>  	if (flags != p->flags) {
> +		err = br_switchdev_set_port_flag(p, flags, mask);
> +		if (err)
> +			return err;
> +
>  		p->flags = flags;
>  		br_port_flags_change(p, mask);
>  	}
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
