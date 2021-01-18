Return-Path: <nikolay@nvidia.com>
References: <20210112135903.3730765-1-horatiu.vultur@microchip.com>
 <32bf6a72-6aff-5e36-fb02-333f3c450f49@nvidia.com> <8735z0zyab.fsf@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <b54644f6-b559-b13b-adf8-d95f7b2a6885@nvidia.com>
Date: Mon, 18 Jan 2021 13:53:11 +0200
In-Reply-To: <8735z0zyab.fsf@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1610970803; bh=4Vm7Hkswa56DY+yAtX2oNmnN888f4LYixzf+BYvI4lQ=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
 Authentication-Results:Subject:To:References:From:Message-ID:Date:
 User-Agent:In-Reply-To:Content-Type:Content-Language:
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
 b=k86O0TXGa727usO8x5KFBTRv5ipULY+mHMX/x5IzUBWYdsoZpwMJvP4JpwgZ9cAlV
 lHNkWUXiWdEZV0Y2KsHozCo2r/j40ENqgiqBK0zUCNmGoUhMEDcCjjpJCqPoBaZGd5
 V9c4Mn1AKmFIqg6TTjB66dNd+q/Zh6je/vHOQqNNU8u60onOcb7vSQC2DXQ2t/J9kI
 S57QPxbw8efSdI2NQaYS93WN7wUUKEp77fV905WSBi1Cc2fY9GubyPZdrqAamcqLX8
 5TqP/POhL3CnMey8qPUa/1ovIdfgPTp3ZJ3CMuGvd9eIWolOGRZY2NgGhjMZA6W6to
 srtWaKFGpy/vg==
Subject: Re: [Bridge] [RFC PATCH v2] net: bridge: igmp: Extend IGMP query to
 be per vlan
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joachim Wiberg <troglobit@gmail.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, allan.nielsen@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org

On 16/01/2021 17:39, Joachim Wiberg wrote:
> On Wed, Jan 13, 2021 at 14:15, Nikolay Aleksandrov <nikolay@nvidia.com> wrote:
>> On 12/01/2021 15:59, Horatiu Vultur wrote:
>>> Based on the comments of the previous version, we started to work on a
>>> new version, so it would be possible to enable/disable queries per vlan.
>>> [snip]
>>> We were wondering if this what you had in mind when you proposed to have
>>> this per vlan? Or we are completely off? Or we should fix some of the
>>> issues that I mentioned, before you can see more clearly the direction?
>> No, unfortunately not even close. We already have per-port per-vlan and global per-vlan
>> contexts which are also linked together for each vlan, those must be used for any vlan
>> configuration and state. The problem is that you'd have to mix igmp and vlan code and
>> those two live under two different kconfig options, and worse rely on different locks, so
>> extra care must be taken.
>> [snip]
>> If you don't need this asap, I'll probably get to it in two months
>> after EHT and the new bridge flush api, even we are still carrying an out-of-tree patch
>> for this which someone (not from cumulus) tried to upstream a few years back, but it also has
>> wrong design in general. :)
> 
> Hi,
> 
> very interesting thread this!  I believe I may be the one who posted the
> patch[1] a few years ago, and I fully agree with Nik here.  We developed
> the basic concepts further at Westermo, but it's been really difficult
> to get it stable.
> 
> We have discussed at length at work if an IGMP snooping implementation
> really belongs in the bridge, or if it's better suited as a user space
> daemon?  Similar to what was decided for RSTP/MSTP support, i.e., the
> bridge only has STP and RSTP/MSTP is handled by mstpd[2].
> 
> Most of what's required for a user space implementation is available,
> but it would've been nice if a single AF_PACKET socket on br0 could be
> used to catch what brport (ifindex) a query or report comes in on.  As
> it is now that information is lost/replaced with the ifindex of br0.
> And then there's the issue of detecting and forwarding to a multicast
> routing daemon on top of br0.  That br0 is not a brport in the MDB, or
> that host_joined cannot be set/seen with iproute2 is quite limiting.
> These issues can of course be addressed, but are they of interest to
> the community at large?
> 
> 
> Best regards
>  /Joachim
> 
> [1]: https://lore.kernel.org/netdev/20180418120713.GA10742@troglobit/
> [2]: https://github.com/mstpd/mstpd
> 

Hi Joachim,
I actually had started implementing IGMPv3/MLDv2 as a user-space daemon part of
FRRouting (since it already has a lot of the required infra to talk to the kernel).
It also has IGMPv3/MLDv2 support within pimd, so a lot of code can be shared.
Obviously there are pros and cons to each choice, but I'd be interested to see a
full user-space implementation. I decided to make the kernel support more complete
since it already did IGMPv2 and so stopped with the new FRR daemon. If needed I'd be
happy to help with the kernel support for a new user-space daemon, and also can
contribute to the daemon itself if time permits.

Thanks,
 Nik

