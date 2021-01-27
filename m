Return-Path: <nikolay@nvidia.com>
References: <20210126040949.3130937-1-liuhangbin@gmail.com>
 <8a34f089-204f-aeb1-afc7-26ccc06419eb@nvidia.com>
 <20210126132448.GN1421720@Leo-laptop-t470s>
 <90df4fe6-fcc5-f59a-c89c-6f596443af4d@nvidia.com>
 <0b5741b6-48c0-0c34-aed8-257f3e203ac5@nvidia.com>
 <20210127041521.GO1421720@Leo-laptop-t470s>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <e22d0eea-4236-5916-cc42-532a3dfcc9dd@nvidia.com>
Date: Wed, 27 Jan 2021 11:43:30 +0200
In-Reply-To: <20210127041521.GO1421720@Leo-laptop-t470s>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611740651; bh=5jY266hAVgTv4KS2eNpt/f7YT8Uh+6OySEqRuBszyVw=;
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
 b=P+UW28L6HLx8kOpTxL9yv78mf5YqIDJaSUb9D8vJgfjUEVTJL6J68EGYpQ5s4p29k
 YqeUgmGjWhNdbCtPBSpW/H40ZtgOQjyImYidUrCB7ZpsWgfWG+zenf28KsE0IrVE2e
 0p4Evh6jfQMlWf6iWZEXKaBkqFNO3jYsKX2EkJg3W1rKy+qhWDNDw2gWhOD9OYLd53
 TqgAzdYuv4bJ5z4Mz7IQLZ840svOrj9AIaLqcyZIwUoCGp+mc2x1ola2XUfZXSeRBm
 99ebv3DQF5lP7FUnLXYtk9C5qNuFyM3hxkH5DzIzo91C03kLJK3m+xzBMLWCyfaNQO
 ltqGF8hA5QKYg==
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Jarod Wilson <jarod@redhat.com>, Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>, "David S .
 Miller" <davem@davemloft.net>

On 27/01/2021 06:15, Hangbin Liu wrote:
> On Tue, Jan 26, 2021 at 04:55:22PM +0200, Nikolay Aleksandrov wrote:
>>>> Thanks for the reply. There are a few reasons I think the bridge should
>>>> handle NETDEV_NOTIFY_PEERS:
>>>>
>>>> 1. Only a few devices will call NETDEV_NOTIFY_PEERS notifier: bond, team,
>>>>    virtio, xen, 6lowpan. There should have no much notification message.
>>>
>>> You can't send a broadcast to all ports because 1 bond's link status has changed.
>>> That makes no sense, the GARP needs to be sent only on that bond. The bond devices
>>> are heavily used with bridge setups, and in general the bridge is considered a switch
>>> device, it shouldn't be broadcasting GARPs to all ports when one changes link state.
>>>
>>
>> Scratch the last sentence, I guess you're talking about when the bond's mac causes
>> the bridge to change mac address by br_stp_recalculate_bridge_id(). I was wondering
> 
> Yes, that's what I mean. Sorry I didn't make it clear in commit description.
> 
>> at first why would you need to send garp, but in fact, as Ido mentioned privately,
>> it is already handled correctly, but you need to have set arp_notify sysctl.
>> Then if the bridge's mac changes because of the bond flapping a NETDEV_NOTIFY_PEERS will be
>> generated. Check:
>> devinet.c inetdev_event() -> case NETDEV_CHANGEADDR
> 
> Yes, this is a generic work around. It will handle all mac changing instead of
> failover.
> 
> For IGMP, although you said they are different. In my understanding, when
> bridge mac changed, we need to re-join multicast group, while a gratuitous
> ARP is also needed. I couldn't find a reason why IGMP message is OK but GARP
> is not.
> 

I think that's needed more because of port changing rather than mac changing.
Switches need to be updated if the port has changed, all of that is already handled
correctly by the bond. And I also meant that mcast is handled very differently in
the bridge, usually you'd have snooping enabled.

The patch below isn't correct and will actually break some cases when bonding
flaps ports and propagates NETDEV_RESEND_IGMP with a bridge on top.

>>
>> Alternatively you can always set the bridge mac address manually and then it won't be
>> changed by such events.
> 
> Thanks for this tips. I'm not sure if administers like this way.
> 
> This remind me another issue. Should we resend IGMP when got port
> NETDEV_RESEND_IGMP notify, Even the bridge mac address may not changed?
> Shouldn't we only resend IGMP, GARP when bridge mac address changed, e.g.
> 
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 1b169f8e7491..74571f24bb18 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -80,8 +80,11 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
>  		changed_addr = br_stp_recalculate_bridge_id(br);
>  		spin_unlock_bh(&br->lock);
>  
> -		if (changed_addr)
> +		if (changed_addr) {
>  			call_netdevice_notifiers(NETDEV_CHANGEADDR, br->dev);
> +			call_netdevice_notifiers(NETDEV_RESEND_IGMP, br->dev);
> +			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, br->dev);
> +		}
>  
>  		break;
>  
> @@ -124,11 +127,6 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
>  	case NETDEV_PRE_TYPE_CHANGE:
>  		/* Forbid underlaying device to change its type. */
>  		return NOTIFY_BAD;
> -
> -	case NETDEV_RESEND_IGMP:
> -		/* Propagate to master device */
> -		call_netdevice_notifiers(event, br->dev);
> -		break;
>  	}
>  
>  	if (event != NETDEV_UNREGISTER)
> 
> 
> Thanks
> Hangbin
> 

