Return-Path: <nikolay@nvidia.com>
References: <1610530584-48554-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <f5fe3b09-44e5-939b-3969-3b9136aa4ed5@nvidia.com>
Date: Wed, 13 Jan 2021 14:31:23 +0200
In-Reply-To: <1610530584-48554-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1610541092; bh=zKrsCjGyunzwe9D9aC9OxipbEWiN3GxgGL1YdD/4WFA=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
 Authentication-Results:Subject:To:CC:References:From:Message-ID:
 Date:User-Agent:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
 X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=jl6S2K4iBPuVImDicHsRVEsoiA5vUptS+9xfUTc5T5oU58pKwkriovut4QE/bpSXx
 sclrd42pOmx7RbJvHXFoevvnLq4A+QnZFdfscLv8NWWt+FTv97oOIbayU/UnyYWMSJ
 hhdNAIFsPCaeKDZB5ODF9rrjrK4ZzQYudaSNlJoLTxkwVIthr7EmIsUUApdg4fbebI
 qhFHia/FmISo7FESVnNJYpt0GLOoZ1NY9zEeFsSriWmJhdUNs8ow+5IklOqCW1qB82
 29BTX4GE+p4oQpP6iIcE/pquKGziYbEfp0LhqXKYD4zaZxxPOYxsJtMCM3t8Nq8M5E
 +rz8MoCXsB7sw==
Subject: Re: [Bridge] [PATCH] net/bridge: Fix inconsistent format argument
	types
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>, roopa@nvidia.com
Cc: kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

On 13/01/2021 11:36, Jiapeng Zhong wrote:
> Fix the following warnings:
> 
> net/bridge/br_sysfs_br.c(833): warning: %u in format string (no. 1)
> requires 'unsigned int' but the argument type is 'signed int'.
> net/bridge/br_sysfs_br.c(817): warning: %u in format string (no. 1)
> requires 'unsigned int' but the argument type is 'signed int'.
> net/bridge/br_sysfs_br.c(261): warning: %ld in format string (no. 1)
> requires 'long' but the argument type is 'unsigned long'.
> net/bridge/br_sysfs_br.c(253): warning: %ld in format string (no. 1)
> requires 'long' but the argument type is 'unsigned long'.
> net/bridge/br_sysfs_br.c(244): warning: %ld in format string (no. 1)
> requires 'long' but the argument type is 'unsigned long'.
> net/bridge/br_sysfs_br.c(236): warning: %ld in format string (no. 1)
> requires 'long' but the argument type is 'unsigned long'.
> 
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> ---
>  net/bridge/br_sysfs_br.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Hi,
You have sent 2 patches with the same subject.. Please squash them into a single
patch and target it to net-next, these don't need to be backported.

Thanks,
 Nik

> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index 7db06e3..7512921 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -233,7 +233,7 @@ static ssize_t hello_timer_show(struct device *d,
>  				struct device_attribute *attr, char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%ld\n", br_timer_value(&br->hello_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&br->hello_timer));
>  }
>  static DEVICE_ATTR_RO(hello_timer);
>  
> @@ -241,7 +241,7 @@ static ssize_t tcn_timer_show(struct device *d, struct device_attribute *attr,
>  			      char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%ld\n", br_timer_value(&br->tcn_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&br->tcn_timer));
>  }
>  static DEVICE_ATTR_RO(tcn_timer);
>  
> @@ -250,7 +250,7 @@ static ssize_t topology_change_timer_show(struct device *d,
>  					  char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%ld\n", br_timer_value(&br->topology_change_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&br->topology_change_timer));
>  }
>  static DEVICE_ATTR_RO(topology_change_timer);
>  
> @@ -258,7 +258,7 @@ static ssize_t gc_timer_show(struct device *d, struct device_attribute *attr,
>  			     char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%ld\n", br_timer_value(&br->gc_work.timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&br->gc_work.timer));
>  }
>  static DEVICE_ATTR_RO(gc_timer);
>  
> @@ -814,7 +814,7 @@ static ssize_t vlan_stats_enabled_show(struct device *d,
>  				       char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_VLAN_STATS_ENABLED));
> +	return sprintf(buf, "%d\n", br_opt_get(br, BROPT_VLAN_STATS_ENABLED));
>  }
>  
>  static ssize_t vlan_stats_enabled_store(struct device *d,
> @@ -830,7 +830,7 @@ static ssize_t vlan_stats_per_port_show(struct device *d,
>  					char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_VLAN_STATS_PER_PORT));
> +	return sprintf(buf, "%d\n", br_opt_get(br, BROPT_VLAN_STATS_PER_PORT));
>  }
>  
>  static ssize_t vlan_stats_per_port_store(struct device *d,
> 

