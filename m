Return-Path: <nikolay@nvidia.com>
References: <1611542381-91178-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <4c68f49c-a537-3f8f-73ed-5f243cb142a9@nvidia.com>
Date: Mon, 25 Jan 2021 10:23:00 +0200
In-Reply-To: <1611542381-91178-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611562990; bh=PIRuWXZCFHS5EcypCfN7alZbx+dHw8KfVNzh7RiZl98=;
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
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=MmD/eIM6JGtlNoaOOoP0+gYYHKGdqmH2PsZDqw8VTfowbQpflMj1OcOCW58d5eMHS
 BzkKVHBZOW2MwLBqtftcuOcac3dVAvdyrSfIOG+eVSeRmpc62RcmNnwlgt+XocK8fK
 JtCC1JhGDeofkQFK4b0mw4rJmN+5L/I8zCNF/vR/j7U0QVFAydsXMLavcDOOG++u/7
 BHSDklBT3VTk8am0ONzJPHPdM/AJelooD5JpWknWdtTwaiNHgECsim91FRvMhHyHs1
 uu+4haYcG1ttLlzmjJA64QT32LSPLUAG4iG+0lsDfGVCDBgzLprNv2x2k9jHj5/YXi
 wR1zwP2AveBAw==
Subject: Re: [Bridge] [PATCH] bridge: Use PTR_ERR_OR_ZERO instead
 if(IS_ERR(...)) + PTR_ERR
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>, roopa@nvidia.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, ndesaulniers@google.com, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, kuba@kernel.org, natechancellor@gmail.com, davem@davemloft.net

On 25/01/2021 04:39, Jiapeng Zhong wrote:
> coccicheck suggested using PTR_ERR_OR_ZERO() and looking at the code.
> 
> Fix the following coccicheck warnings:
> 
> ./net/bridge/br_multicast.c:1295:7-13: WARNING: PTR_ERR_OR_ZERO can be
> used.
> 
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> ---
>  net/bridge/br_multicast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 257ac4e..2229d10 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1292,7 +1292,7 @@ static int br_multicast_add_group(struct net_bridge *br,
>  	pg = __br_multicast_add_group(br, port, group, src, filter_mode,
>  				      igmpv2_mldv1, false);
>  	/* NULL is considered valid for host joined groups */
> -	err = IS_ERR(pg) ? PTR_ERR(pg) : 0;
> +	err = PTR_ERR_OR_ZERO(pg);
>  	spin_unlock(&br->multicast_lock);
>  
>  	return err;
> 

This should be targeted at net-next.
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>



