Return-Path: <nikolay@nvidia.com>
References: <20201201214047.128948-1-Joseph.Huang@garmin.com>
 <20201203102802.62bc86ba@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <bd84ca4c-c694-6fd2-81ef-08e9253c18a4@nvidia.com>
 <c82ce96d74ed4d3897d2e68a258f7834@garmin.com>
 <2b96b845990e4a84a3b3fd46f4138ac6@garmin.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <75cf7844-8df7-0ea2-1980-ff868a1bc34e@nvidia.com>
Date: Fri, 4 Dec 2020 01:34:57 +0200
In-Reply-To: <2b96b845990e4a84a3b3fd46f4138ac6@garmin.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1607038510; bh=Cn2qwSbJ1wuPSE71xW6agvI9EPtzEZzffNBaWR1UZfw=;
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
 b=D95zEBhJlBlB7Oq+zoaGcKix8QnMrqiv/RKcUsyoyhSe3wPmZYSNFeDLc7NG2qZyp
 AYxQ1HP7eRrC2XLZrzHtJVxDE0unDqIis8KzTDpCVTQ+j8vPjJjpKn0mjiWkqXuKD7
 I/NLrcG8SaxwWNak3x8zze3EOfgAjF81JZ9LXqEopbytj/AvPKsNObrgabkUKieads
 2K3wqmWEQL9Vxi3a/nQvr5qjKKez6MIeYgdVZ8d7ZnX31CG+oyC72tXKTj8SpEyiCL
 TdXNpZoibYaaZoOJmNPImjmtMEeZmUJGlshCoJK9e5j2niwQ5RINvpDlK/LR10NG+b
 GwuhEjnQaO9Fw==
Subject: Re: [Bridge] [PATCH] bridge: Fix a deadlock when enabling multicast
	snooping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Huang, Joseph" <Joseph.Huang@garmin.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>

On 04/12/2020 00:42, Huang, Joseph wrote:
>> From: Huang, Joseph
>> Sent: Thursday, December 3, 2020 4:53 PM
>> To: Nikolay Aleksandrov <nikolay@nvidia.com>; Jakub Kicinski
>> <kuba@kernel.org>
>> Cc: Roopa Prabhu <roopa@nvidia.com>; David S. Miller
>> <davem@davemloft.net>; bridge@lists.linux-foundation.org;
>> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Linus L=C3=BCssing
>> <linus.luessing@c0d3.blue>
>> Subject: RE: [PATCH] bridge: Fix a deadlock when enabling multicast snoo=
ping
>>
>>> From: Nikolay Aleksandrov <nikolay@nvidia.com>
>>> Sent: Thursday, December 3, 2020 3:47 PM
>>> To: Jakub Kicinski <kuba@kernel.org>; Huang, Joseph
>>> <Joseph.Huang@garmin.com>
>>> Cc: Roopa Prabhu <roopa@nvidia.com>; David S. Miller
>>> <davem@davemloft.net>; bridge@lists.linux-foundation.org;
>>> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Linus L=C3=BCssin=
g
>>> <linus.luessing@c0d3.blue>
>>> Subject: Re: [PATCH] bridge: Fix a deadlock when enabling multicast
>>> snooping
>>>
>>> On 03/12/2020 20:28, Jakub Kicinski wrote:
>>>> On Tue, 1 Dec 2020 16:40:47 -0500 Joseph Huang wrote:
>>>>> When enabling multicast snooping, bridge module deadlocks on
>>>>> multicast_lock if 1) IPv6 is enabled, and 2) there is an existing
>>>>> querier on the same L2 network.
>>>>>
>>>>> The deadlock was caused by the following sequence: While holding the
>>>>> lock, br_multicast_open calls br_multicast_join_snoopers, which
>>>>> eventually causes IP stack to (attempt to) send out a Listener Report=
 (in
>>> igmp6_join_group).
>>>>> Since the destination Ethernet address is a multicast address,
>>>>> br_dev_xmit feeds the packet back to the bridge via br_multicast_rcv,
>>>>> which in turn calls br_multicast_add_group, which then deadlocks on
>>> multicast_lock.
>>>>>
>>>>> The fix is to move the call br_multicast_join_snoopers outside of the
>>>>> critical section. This works since br_multicast_join_snoopers only
>>>>> deals with IP and does not modify any multicast data structures of
>>>>> the bridge, so there's no need to hold the lock.
>>>>>
>>>>> Fixes: 4effd28c1245 ("bridge: join all-snoopers multicast address")
>>>>>
>>>>> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
>>>>
>>>> Nik, Linus - how does this one look?
>>>>
>>>
>>> Hi,
>>> Thanks, somehow I missed this one too. Need to check my email config. :=
) I
>>> believe I see how it can happen, although it's not straight-forward to =
follow.
>>> A selftest for this case would be great, and any traces (e.g. hung task=
)
>> would
>>> help a lot as well.
>>> Correct me if I'm wrong but the sequence is something like:
>>> br_multicast_join_snoopers -> ipv6_dev_mc_inc -> __ipv6_dev_mc_inc ->
>>> igmp6_group_added
>>> -> MLDv1 (mode) igmp6_join_group() -> Again MLDv1 mode
>>> -> igmp6_join_group() -> igmp6_join_group
>>> -> igmp6_send() on the bridge device -> br_dev_xmit and onto the bridge
>>> -> mcast processing code
>>> which uses the multicast_lock spinlock. Right?
>>
>> That is correct.
>>
>> Here's a stack trace from a typical run:
>>
>> echo -n 1 > /sys/devices/virtual/net/gmn0/bridge/multicast_snooping
>> [  936.146754] rcu: INFO: rcu_preempt self-detected stall on CPU
>> [  936.152534] rcu:   0-....: (5594 ticks this GP)
>> idle=3D75a/1/0x4000000000000002 softirq=3D2787/2789 fqs=3D2625
>> [  936.162026]        (t=3D5253 jiffies g=3D4205 q=3D12)
>> [  936.166041] Task dump for CPU 0:
>> [  936.169272] sh              R  running task        0  1315   1295 0x0=
0000002
>> [  936.176332] Call trace:
>> [  936.178797]  dump_backtrace+0x0/0x140
>> [  936.182469]  show_stack+0x14/0x20
>> [  936.185793]  sched_show_task+0x108/0x138
>> [  936.189727]  dump_cpu_task+0x40/0x50
>> [  936.193313]  rcu_dump_cpu_stacks+0x94/0xd0
>> [  936.197420]  rcu_sched_clock_irq+0x75c/0x9c0
>> [  936.201698]  update_process_times+0x2c/0x68
>> [  936.205893]  tick_sched_handle.isra.0+0x30/0x50
>> [  936.210432]  tick_sched_timer+0x48/0x98
>> [  936.214272]  __hrtimer_run_queues+0x110/0x1b0
>> [  936.218635]  hrtimer_interrupt+0xe4/0x240
>> [  936.222656]  arch_timer_handler_phys+0x30/0x40
>> [  936.227106]  handle_percpu_devid_irq+0x80/0x140
>> [  936.231654]  generic_handle_irq+0x24/0x38
>> [  936.235669]  __handle_domain_irq+0x60/0xb8
>> [  936.239774]  gic_handle_irq+0x5c/0x148
>> [  936.243535]  el1_irq+0xb8/0x180
>> [  936.246689]  queued_spin_lock_slowpath+0x118/0x3b0
>> [  936.251495]  _raw_spin_lock+0x5c/0x68
>> [  936.255221]  br_multicast_add_group+0x40/0x170 [bridge]
>> [  936.260491]  br_multicast_rcv+0x7ac/0xe30 [bridge]
>> [  936.265322]  br_dev_xmit+0x140/0x368 [bridge]
>> [  936.269689]  dev_hard_start_xmit+0x94/0x158
>> [  936.273876]  __dev_queue_xmit+0x5ac/0x7f8
>> [  936.277890]  dev_queue_xmit+0x10/0x18
>> [  936.281563]  neigh_resolve_output+0xec/0x198
>> [  936.285845]  ip6_finish_output2+0x240/0x710
>> [  936.290039]  __ip6_finish_output+0x130/0x170
>> [  936.294318]  ip6_output+0x6c/0x1c8
>> [  936.297731]  NF_HOOK.constprop.0+0xd8/0xe8
>> [  936.301834]  igmp6_send+0x358/0x558
>> [  936.305326]  igmp6_join_group.part.0+0x30/0xf0
>> [  936.309774]  igmp6_group_added+0xfc/0x110
>> [  936.313787]  __ipv6_dev_mc_inc+0x1a4/0x290
>> [  936.317885]  ipv6_dev_mc_inc+0x10/0x18
>> [  936.321677]  br_multicast_open+0xbc/0x110 [bridge]
>> [  936.326506]  br_multicast_toggle+0xec/0x140 [bridge]
>>
>>
>>>
>>> One question - shouldn't leaving have the same problem? I.e.
>>> br_multicast_toggle -> br_multicast_leave_snoopers
>>> -> br_ip6_multicast_leave_snoopers -> ipv6_dev_mc_dec ->
>>> -> igmp6_group_dropped -> igmp6_leave_group ->
>>> MLDv1 mode && last reporter -> igmp6_send() ?
>>>
>>> I think it was saved by the fact that !br_opt_get(br,
>>> BROPT_MULTICAST_ENABLED) would be true and the multicast lock won't
>> be
>>> acquired in the br_dev_xmit path? If so, I'd appreciate a comment about
>> that
>>> because it's not really trivial to find out. :)
>>
>> That's a really good point. Leave should have deadlocked as well, but wh=
en I
>> tested the patch, I was able to turn on/off multicast snooping multiple =
times
>> without any problem.
>>
>> Is it because this line in igmp6_leave_group?
>>
>>               if (ma->mca_flags & MAF_LAST_REPORTER)
>>                       igmp6_send(&ma->mca_addr, ma->idev->dev,
>>                               ICMPV6_MGM_REDUCTION);
>>
>> Perhaps MAF_LAST_REPORTER was not set, so igmp6_send was not called?
>>
>>>
>>> Anyhow, the patch is fine as-is too:
>>> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
>>>
>>> Thanks,
>>>  Nik
>>
>> Thanks,
>> Joseph
>=20
> Would it be advisable if we move br_multicast_leave_snoopers out of the c=
ritical
> section as well? Even though I can't really verify that if this is helpfu=
l since I haven't
> seen it deadlock when disabling multicast snooping.
>=20
> Thanks,
> Joseph
>=20
 The reason we're not seeing a deadlock is because the multicast snooping b=
it
is not set and the lock is never acquired when sending the packet through b=
r_multicast_rcv().
Anyway I'd move it out for symmetry and it would be less confusing as you'd=
 just have a standard
if/else in the end. By the way now that I looked again the patch is not ent=
irely correct as you'll
do multiple joins/leaves on every br_multicast_toggle(), i.e. with the patc=
h you bypass the check
for the same value and actually try to change state each time (the
if (!!br_opt_get(br, BROPT_MULTICAST_ENABLED) =3D=3D !!val) check).

We also lose the symmetry between br_dev_open and stop, and expose otherwis=
e
private multicast code, so I'd pull out the snoopers leave for br_dev_stop(=
) as well.

Please add a comment why it's needed, so we won't wonder about it later. An=
d also include the
trace in the commit message so we'd have it.

Edit: I just tried it and it's very easy to reproduce, steps:
1. sysctl net.ipv6.conf.all.force_mld_version=3D1
2. have another querier
3. ip link set dev bridge type bridge mcast_snooping 0 && ip link set dev b=
ridge type bridge mcast_snooping 1
< deadlock >

Thanks,
 Nik

