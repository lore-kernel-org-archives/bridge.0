Return-Path: <nikolay@nvidia.com>
References: <1610531059-56212-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <0c4ef6ac-3d6f-121a-51bd-1abed4a75da4@nvidia.com>
Date: Wed, 13 Jan 2021 14:33:10 +0200
In-Reply-To: <1610531059-56212-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1610541199; bh=xD7QYIYafM4V9zgOrpdR2+XGHgufqC0863bIYn/71eg=;
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
 b=aNbCLe6XJ1KhQSeT0IK+R6sMxABD2F8/D1ikECD1Zg8G0ecQ0JivHfJyOyaL6y6qV
 55RdStCWyrHN7S6PkOO/6LViAxgjnYRa387BUq4dovoCu1EmQ0VBMRAQ6gm8Rmg4oX
 p52ccp3evC6VevGLHRxuzFUH3ECLE5vLO97RUKNHdOr8X+HskbyqHG6gIsAvGVJOQg
 s4rF7S1FmWMpy47DYvb2gaXYgF8pJF4OV5vUl2QCSWxAr8IV4Psu84aDFuLxh8VXU7
 nMjDeQZMThcXqwfGlj8Pa8n9LkkoZYAG7g5xgNpGA9/3cbJNGrWZhKXapKlrnnBD8c
 d0MrA/HNosMbQ==
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

On 13/01/2021 11:44, Jiapeng Zhong wrote:
> Fix the following warnings:
> 
> net/bridge/br_sysfs_if.c(162): warning: %ld in format string (no. 1)
> requires 'long' but the argument type is 'unsigned long'.
> net/bridge/br_sysfs_if.c(155): warning: %ld in format string (no. 1)
> requires 'long' but the argument type is 'unsigned long'.
> net/bridge/br_sysfs_if.c(148): warning: %ld in format string (no. 1)
> requires 'long' but the argument type is 'unsigned long'.
> 
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> ---
>  net/bridge/br_sysfs_if.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

As I replied to your other patch with the same subject please squash them
together and send them targeted at net-next.

Thanks.

> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 7a59cdd..16a7d41 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -145,21 +145,21 @@ static ssize_t show_port_state(struct net_bridge_port *p, char *buf)
>  static ssize_t show_message_age_timer(struct net_bridge_port *p,
>  					    char *buf)
>  {
> -	return sprintf(buf, "%ld\n", br_timer_value(&p->message_age_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&p->message_age_timer));
>  }
>  static BRPORT_ATTR(message_age_timer, 0444, show_message_age_timer, NULL);
>  
>  static ssize_t show_forward_delay_timer(struct net_bridge_port *p,
>  					    char *buf)
>  {
> -	return sprintf(buf, "%ld\n", br_timer_value(&p->forward_delay_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&p->forward_delay_timer));
>  }
>  static BRPORT_ATTR(forward_delay_timer, 0444, show_forward_delay_timer, NULL);
>  
>  static ssize_t show_hold_timer(struct net_bridge_port *p,
>  					    char *buf)
>  {
> -	return sprintf(buf, "%ld\n", br_timer_value(&p->hold_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&p->hold_timer));
>  }
>  static BRPORT_ATTR(hold_timer, 0444, show_hold_timer, NULL);
>  
> 

