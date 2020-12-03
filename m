Return-Path: <nikolay@nvidia.com>
References: <20201201214047.128948-1-Joseph.Huang@garmin.com>
 <20201203102802.62bc86ba@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <bd84ca4c-c694-6fd2-81ef-08e9253c18a4@nvidia.com>
Date: Thu, 3 Dec 2020 22:46:57 +0200
In-Reply-To: <20201203102802.62bc86ba@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1607028428; bh=bzc7tc2zewgI6SWogj6d3NxIJGvvB66309VQ8/Hva1k=;
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
 b=D74LeTiQlmejx7WKTvtyVU9XzsQAp87BDlR2RsYehxAv3UzDtWSbki/nKqAds/+sm
 aj+lKAb1Kj+5U16QL/RZHaIKMuhXoPznZT5baBe2mfz9pNwzxsxavlYfATAP+BWpQv
 GjtIi+ffi6om1jJ/kQLJ9B4qJGGQRElM9t9idSpXS491xHeV35QR44bHsfltT+1Mkt
 XSfB7df6kCL47P3qcrFfdr1IXzsNCi5wQUyPS1RKl45vIjb+DLywjOj5ryvFw0nJyS
 joIvfmbg7+GYpojw718R/J4GerOfpodpyw0gYZoeEW2pxjCdrLwl7AfGTl1HgFmMU+
 B2F0fDUOwk9cQ==
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
To: Jakub Kicinski <kuba@kernel.org>, Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>

On 03/12/2020 20:28, Jakub Kicinski wrote:
> On Tue, 1 Dec 2020 16:40:47 -0500 Joseph Huang wrote:
>> When enabling multicast snooping, bridge module deadlocks on multicast_lock
>> if 1) IPv6 is enabled, and 2) there is an existing querier on the same L2
>> network.
>>
>> The deadlock was caused by the following sequence: While holding the lock,
>> br_multicast_open calls br_multicast_join_snoopers, which eventually causes
>> IP stack to (attempt to) send out a Listener Report (in igmp6_join_group).
>> Since the destination Ethernet address is a multicast address, br_dev_xmit
>> feeds the packet back to the bridge via br_multicast_rcv, which in turn
>> calls br_multicast_add_group, which then deadlocks on multicast_lock.
>>
>> The fix is to move the call br_multicast_join_snoopers outside of the
>> critical section. This works since br_multicast_join_snoopers only deals
>> with IP and does not modify any multicast data structures of the bridge,
>> so there's no need to hold the lock.
>>
>> Fixes: 4effd28c1245 ("bridge: join all-snoopers multicast address")
>>
>> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> 
> Nik, Linus - how does this one look?
> 

Hi,
Thanks, somehow I missed this one too. Need to check my email config. :)
I believe I see how it can happen, although it's not straight-forward to follow.
A selftest for this case would be great, and any traces (e.g. hung task) would
help a lot as well.
Correct me if I'm wrong but the sequence is something like:
br_multicast_join_snoopers -> ipv6_dev_mc_inc -> __ipv6_dev_mc_inc -> igmp6_group_added
-> MLDv1 (mode) igmp6_join_group() -> Again MLDv1 mode igmp6_join_group() -> igmp6_join_group
-> igmp6_send() on the bridge device -> br_dev_xmit and onto the bridge mcast processing code
which uses the multicast_lock spinlock. Right?

One question - shouldn't leaving have the same problem? I.e. br_multicast_toggle -> br_multicast_leave_snoopers
-> br_ip6_multicast_leave_snoopers -> ipv6_dev_mc_dec -> igmp6_group_dropped -> igmp6_leave_group ->
MLDv1 mode && last reporter -> igmp6_send() ?

I think it was saved by the fact that !br_opt_get(br, BROPT_MULTICAST_ENABLED) would be true and the
multicast lock won't be acquired in the br_dev_xmit path? If so, I'd appreciate a comment about that
because it's not really trivial to find out. :)

Anyhow, the patch is fine as-is too:
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

Thanks,
 Nik

