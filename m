Return-Path: <nikolay@nvidia.com>
References: <20210126040949.3130937-1-liuhangbin@gmail.com>
 <8a34f089-204f-aeb1-afc7-26ccc06419eb@nvidia.com>
 <20210126132448.GN1421720@Leo-laptop-t470s>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <90df4fe6-fcc5-f59a-c89c-6f596443af4d@nvidia.com>
Date: Tue, 26 Jan 2021 15:56:44 +0200
In-Reply-To: <20210126132448.GN1421720@Leo-laptop-t470s>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611669414; bh=LmRkg/WIddBCdFnNCf1NVTZcwbWeq/78kglAUSRUJPo=;
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
 b=RU8g/HZZ0AKVQwUyd1qki/dM9IQdzh8pSgO9gkKWXbLliQ6jyv7BhXPru+dW9hp0x
 BKD+LQ7Cgvmys2P7wM4wVsn3AJYkPgn02sBeXY5lMcidjSLWVS2Kr8ewuUSdTKZjJv
 ajmM7mlNZmkqZMGE/nYVA8sVy1w0Rec8VEFliaUafs34LfRsn8oNsX5Uce3b5aJLFu
 W7YQIQvXpfGutEC0W7d01rn3AVp1kVtRQcJcKdj5/25SR0jVHFkZsqsbxKOWUFONJW
 JO+fqh7DBv91HV6HvZjUi/zaGuU55XHEXbnGDtUSHwL6aVRFX4ZuoUyabCpUaSEV0c
 1imuL5DFLadpw==
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
Cc: Ivan Vecera <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Jarod Wilson <jarod@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, "David S .
 Miller" <davem@davemloft.net>

On 26/01/2021 15:25, Hangbin Liu wrote:
> On Tue, Jan 26, 2021 at 09:40:13AM +0200, Nikolay Aleksandrov wrote:
>> On 26/01/2021 06:09, Hangbin Liu wrote:
>>> After adding bridge as upper layer of bond/team, we usually clean up the
>>> IP address on bond/team and set it on bridge. When there is a failover,
>>> bond/team will not send gratuitous ARP since it has no IP address.
>>> Then the down layer(e.g. VM tap dev) of bridge will not able to receive
>>> this notification.
>>>
>>> Make bridge to be able to handle NETDEV_NOTIFY_PEERS notifier.
>>>
>>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>>> ---
>>>  net/bridge/br.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/net/bridge/br.c b/net/bridge/br.c
>>> index ef743f94254d..b6a0921bb498 100644
>>> --- a/net/bridge/br.c
>>> +++ b/net/bridge/br.c
>>> @@ -125,6 +125,7 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
>>>  		/* Forbid underlying device to change its type. */
>>>  		return NOTIFY_BAD;
>>>  
>>> +	case NETDEV_NOTIFY_PEERS:
>>>  	case NETDEV_RESEND_IGMP:
>>>  		/* Propagate to master device */
>>>  		call_netdevice_notifiers(event, br->dev);
>>>
>>
>> I'm not convinced this should be done by the bridge, setups usually have multiple ports
>> which may have link change events and these events are unrelated, i.e. we shouldn't generate
>> a gratuitous arp for all every time, there might be many different devices present. We have
>> setups with hundreds of ports which are mixed types of devices.
>> That seems inefficient, redundant and can potentially cause problems.
> 
> Hi Nikolay,
> 
> Thanks for the reply. There are a few reasons I think the bridge should
> handle NETDEV_NOTIFY_PEERS:
> 
> 1. Only a few devices will call NETDEV_NOTIFY_PEERS notifier: bond, team,
>    virtio, xen, 6lowpan. There should have no much notification message.

You can't send a broadcast to all ports because 1 bond's link status has changed.
That makes no sense, the GARP needs to be sent only on that bond. The bond devices
are heavily used with bridge setups, and in general the bridge is considered a switch
device, it shouldn't be broadcasting GARPs to all ports when one changes link state.

> 2. When set bond/team's upper layer to bridge. The bridge's mac will be the
>    same with bond/team. So when the bond/team's mac changed, the bridge's mac
>    will also change. So bridge should send a GARP to notify other's that it's
>    mac has changed.

That is not true, the mac doesn't need to be the same at all. And in many
situations isn't.

> 3. There already has NETDEV_RESEND_IGMP handling in bridge, which is also
>    generated by bond/team and netdev_notify_peers(). So why there is IGMP
>    but no ARP?

Apples and oranges..

> 4. If bridge doesn't have IP address, it will omit GARP sending. So having
>    or not having IP address on bridge doesn't matters.
> 4. I don't see why how many ports affect the bridge sending GARP.

Bridge broadcasts are notoriously slow, they consider every port. We've seen glean
traffic take up 100% CPU with only 10k pps. I have patches that fix the situation for
*some* cases (i.e. where not all ports need to be considered), but in general you can't
optimize it much, so it's best to avoid sending them altogether.
Just imagine having a hundred SVIs on top of the bridge, that would lead to number if SVIs
multipled by the number of ports broadcast packets for each link flap of some bond/team port.
Same thing happens if there are macvlans on top, we have setups with thousands of virtual devices
and this will just kill them, if it was at all correct behaviour then we might look for a solution
but it is not in general. GARPs must be confined only to the bond ports which changed state, and
not broadcast to all every time.

> 
> Please correct me if I missed something.
> 
>> Also it seems this was proposed few years back: https://lkml.org/lkml/2018/1/6/135
> 
> Thanks for this link, cc Stephen for this discuss.
> 
> Hangbin
> 


