Return-Path: <nikolay@nvidia.com>
References: <20201201214047.128948-1-Joseph.Huang@garmin.com>
 <20201204235628.50653-1-Joseph.Huang@garmin.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <f16d76ed-5d93-d15b-e7da-5133e3b6c3e7@nvidia.com>
Date: Sat, 5 Dec 2020 10:56:45 +0200
In-Reply-To: <20201204235628.50653-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1607158619; bh=PDqkbuMglZcW4bQP6ZepiUbAcvVq4qTwQiNmYFLzT6M=;
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
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=ovYiF2rs5Bgz1s5BpmEmhAPe2FCIJX0iNHcVacewMKZqVYsuMPkLm6ruofjXVPiUQ
 gESNY2nzOlcv++DA8KaU7EAVLet4wzJkA7N+3/ImxfB81pxpifffZnHREvEptTQdgT
 GEJ0t5iGZN2RZu8Jsi2OUXtBlrP8zoeZK88VI3mbVA7GJYqdypgUTbHdKXPJrNHSFA
 P5xYcaI0pIhpZOkkZpPRhlztWcvoRE8UoQK4ecQAOva5Pq2rgID9Stacnq4Q9OmznN
 AjyRBk1WwenfEbl1OcvMT+01lisRESLJl9eu2MGeXWLVhW2L9CGvC8w5WowsblrG4M
 EogAL/teB/tkQ==
Subject: Re: [Bridge] [PATCH v3] bridge: Fix a deadlock when enabling
 multicast snooping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joseph Huang <Joseph.Huang@garmin.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/12/2020 01:56, Joseph Huang wrote:
> When enabling multicast snooping, bridge module deadlocks on multicast_lock
> if 1) IPv6 is enabled, and 2) there is an existing querier on the same L2
> network.
> 
> The deadlock was caused by the following sequence: While holding the lock,
> br_multicast_open calls br_multicast_join_snoopers, which eventually causes
> IP stack to (attempt to) send out a Listener Report (in igmp6_join_group).
> Since the destination Ethernet address is a multicast address, br_dev_xmit
> feeds the packet back to the bridge via br_multicast_rcv, which in turn
> calls br_multicast_add_group, which then deadlocks on multicast_lock.
> 
> The fix is to move the call br_multicast_join_snoopers outside of the
> critical section. This works since br_multicast_join_snoopers only deals
> with IP and does not modify any multicast data structures of the bridge,
> so there's no need to hold the lock.
> 
> Steps to reproduce:
> 1. sysctl net.ipv6.conf.all.force_mld_version=1
> 2. have another querier
> 3. ip link set dev bridge type bridge mcast_snooping 0 && \
>    ip link set dev bridge type bridge mcast_snooping 1 < deadlock >
> 
> A typical call trace looks like the following:
> 
> [  936.251495]  _raw_spin_lock+0x5c/0x68
> [  936.255221]  br_multicast_add_group+0x40/0x170 [bridge]
> [  936.260491]  br_multicast_rcv+0x7ac/0xe30 [bridge]
> [  936.265322]  br_dev_xmit+0x140/0x368 [bridge]
> [  936.269689]  dev_hard_start_xmit+0x94/0x158
> [  936.273876]  __dev_queue_xmit+0x5ac/0x7f8
> [  936.277890]  dev_queue_xmit+0x10/0x18
> [  936.281563]  neigh_resolve_output+0xec/0x198
> [  936.285845]  ip6_finish_output2+0x240/0x710
> [  936.290039]  __ip6_finish_output+0x130/0x170
> [  936.294318]  ip6_output+0x6c/0x1c8
> [  936.297731]  NF_HOOK.constprop.0+0xd8/0xe8
> [  936.301834]  igmp6_send+0x358/0x558
> [  936.305326]  igmp6_join_group.part.0+0x30/0xf0
> [  936.309774]  igmp6_group_added+0xfc/0x110
> [  936.313787]  __ipv6_dev_mc_inc+0x1a4/0x290
> [  936.317885]  ipv6_dev_mc_inc+0x10/0x18
> [  936.321677]  br_multicast_open+0xbc/0x110 [bridge]
> [  936.326506]  br_multicast_toggle+0xec/0x140 [bridge]
> 
> Fixes: 4effd28c1245 ("bridge: join all-snoopers multicast address")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  net/bridge/br_device.c    |  6 ++++++
>  net/bridge/br_multicast.c | 34 +++++++++++++++++++++++++---------
>  net/bridge/br_private.h   | 10 ++++++++++
>  3 files changed, 41 insertions(+), 9 deletions(-)
> 

LGTM, thanks!
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>


