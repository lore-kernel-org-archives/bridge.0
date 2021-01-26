Return-Path: <nikolay@nvidia.com>
References: <20210126040949.3130937-1-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <8a34f089-204f-aeb1-afc7-26ccc06419eb@nvidia.com>
Date: Tue, 26 Jan 2021 09:40:13 +0200
In-Reply-To: <20210126040949.3130937-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611646830; bh=TokF8fBD1VT3oaASSR4IcURgeAFKFygEzdmLlIccYMs=;
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
 b=el5x9MzrbKb7d1FcYKR3AMmLAosI60rEL9+YZ1NEew/3z688BNaNfzMAM/EY6c/7u
 AJXfNvjTtCLDn/wUV7A3FBGzuIs6sOlQioBkzFmMMoM+OoiFo1ZcYN1f6h9Nqiq5M1
 8XLEfr2lzPei1dxVwtW6GFuRWK8DTFupBxAD3KOziGl9i8mSs3NU2tl+6coXatPcmx
 GB39umThOroCisbXWkzNRDYOtnYcvEduu6b/0qKUT609FeoOJCloEXr0JIbBXkjbVc
 6f2Is7V1dRJtdujeLRwXtJ+MNjUrVeb0eHmnJsvRMFeH3+5EudulV796Av1HEcpRWX
 3FkBbSfQQ5+sA==
Subject: Re: [Bridge] [PATCH net-next] bridge: Propagate NETDEV_NOTIFY_PEERS
	notifier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Jarod Wilson <jarod@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, "David S . Miller" <davem@davemloft.net>

On 26/01/2021 06:09, Hangbin Liu wrote:
> After adding bridge as upper layer of bond/team, we usually clean up the
> IP address on bond/team and set it on bridge. When there is a failover,
> bond/team will not send gratuitous ARP since it has no IP address.
> Then the down layer(e.g. VM tap dev) of bridge will not able to receive
> this notification.
> 
> Make bridge to be able to handle NETDEV_NOTIFY_PEERS notifier.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/bridge/br.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index ef743f94254d..b6a0921bb498 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -125,6 +125,7 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
>  		/* Forbid underlying device to change its type. */
>  		return NOTIFY_BAD;
>  
> +	case NETDEV_NOTIFY_PEERS:
>  	case NETDEV_RESEND_IGMP:
>  		/* Propagate to master device */
>  		call_netdevice_notifiers(event, br->dev);
> 

I'm not convinced this should be done by the bridge, setups usually have multiple ports
which may have link change events and these events are unrelated, i.e. we shouldn't generate
a gratuitous arp for all every time, there might be many different devices present. We have
setups with hundreds of ports which are mixed types of devices.
That seems inefficient, redundant and can potentially cause problems.

Also it seems this was proposed few years back: https://lkml.org/lkml/2018/1/6/135

Thanks,
 Nik
