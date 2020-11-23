Return-Path: <nikolay@nvidia.com>
References: <20201123111401.136952-1-horatiu.vultur@microchip.com>
 <5ffa6f9f-d1f3-adc7-ddb8-e8107ea78da5@nvidia.com>
 <20201123123132.uxvec6uwuegioc25@soft-dev3.localdomain>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <13cef7c2-cacc-2c24-c0d5-e462b0e3b4df@nvidia.com>
Date: Mon, 23 Nov 2020 16:25:53 +0200
In-Reply-To: <20201123123132.uxvec6uwuegioc25@soft-dev3.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1606141567; bh=t9g/+ANM13Dd7AFIX9QFifJ0Zzs7LGDlOOCaCxD+FV0=;
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
 b=qQjRRjhlQrPEVOY/mUe281ZY7gCs/AXrR1dQ8dm3D8r9EZcUvJios4qoImVIVp79e
 Vl/9BywJKUd57Ug1BfGyVuFxIErXg+RUO/WIuAsnEUuneEwHOg310MqxSpp2VNYZ5h
 sbqeiUv4CJw4FYRMtHAoVbT6E03MgoyFdltTwAFi9ySzs2XYTuZvkCD3IpWVRuzgoD
 TQ305FTCh8Sn//ndkTogQzdNEG3ODpIGRQs5+TR+axdc4x1LGPMQimOP5Odum9ARnp
 TxSL+zFNpuT6asiKEgE3iJk6pj3+NraslDAfbk0CTmLb7oS7QWgAuismJtaD7ACamB
 hf9PFQqA0U33g==
Subject: Re: [Bridge] [PATCH net-next] bridge: mrp: Implement LC mode for MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On 23/11/2020 14:31, Horatiu Vultur wrote:
> The 11/23/2020 14:13, Nikolay Aleksandrov wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 23/11/2020 13:14, Horatiu Vultur wrote:
>>> Extend MRP to support LC mode(link check) for the interconnect port.
>>> This applies only to the interconnect ring.
>>>
>>> Opposite to RC mode(ring check) the LC mode is using CFM frames to
>>> detect when the link goes up or down and based on that the userspace
>>> will need to react.
>>> One advantage of the LC mode over RC mode is that there will be fewer
>>> frames in the normal rings. Because RC mode generates InTest on all
>>> ports while LC mode sends CFM frame only on the interconnect port.
>>>
>>> All 4 nodes part of the interconnect ring needs to have the same mode.
>>> And it is not possible to have running LC and RC mode at the same time
>>> on a node.
>>>
>>> Whenever the MIM starts it needs to detect the status of the other 3
>>> nodes in the interconnect ring so it would send a frame called
>>> InLinkStatus, on which the clients needs to reply with their link
>>> status.
>>>
>>> This patch adds the frame header for the frame InLinkStatus and
>>> extends existing rules on how to forward this frame.
>>>
>>> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
>>> ---
>>>  include/uapi/linux/mrp_bridge.h |  7 +++++++
>>>  net/bridge/br_mrp.c             | 18 +++++++++++++++---
>>>  2 files changed, 22 insertions(+), 3 deletions(-)
>>>
>>
>> Hi Horatiu,
>> The patch looks good overall, just one question below.
> 
> Hi Nik,
> 
> Thanks for taking time to review the patch.
> 
>>
>>> diff --git a/include/uapi/linux/mrp_bridge.h b/include/uapi/linux/mrp_bridge.h
>>> index 6aeb13ef0b1e..450f6941a5a1 100644
>>> --- a/include/uapi/linux/mrp_bridge.h
>>> +++ b/include/uapi/linux/mrp_bridge.h
>>> @@ -61,6 +61,7 @@ enum br_mrp_tlv_header_type {
>>>       BR_MRP_TLV_HEADER_IN_TOPO = 0x7,
>>>       BR_MRP_TLV_HEADER_IN_LINK_DOWN = 0x8,
>>>       BR_MRP_TLV_HEADER_IN_LINK_UP = 0x9,
>>> +     BR_MRP_TLV_HEADER_IN_LINK_STATUS = 0xa,
>>>       BR_MRP_TLV_HEADER_OPTION = 0x7f,
>>>  };
>>>
>>> @@ -156,4 +157,10 @@ struct br_mrp_in_link_hdr {
>>>       __be16 interval;
>>>  };
>>>
>>> +struct br_mrp_in_link_status_hdr {
>>> +     __u8 sa[ETH_ALEN];
>>> +     __be16 port_role;
>>> +     __be16 id;
>>> +};
>>> +
>>
>> I didn't see this struct used anywhere, am I missing anything?
> 
> Yes, you are right, the struct is not used any. But I put it there as I
> put the other frame types for MRP.
> 

I see, we don't usually add unused code. The patch is fine as-is and since
this is already the case for other MRP parts I'm not strictly against it, so:

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

If Jakub decides to adhere to that rule you can keep my acked-by and just remove
the struct for v2.

Thanks,
 Nik

