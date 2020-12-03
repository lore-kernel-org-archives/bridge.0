Return-Path: <nikolay@nvidia.com>
References: <20201201140114.67455-1-wanghai38@huawei.com>
 <20201202170359.19330bda@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <3d3c0206-c8c4-8a19-c821-2a0cbb941c6b@nvidia.com>
Date: Thu, 3 Dec 2020 12:34:14 +0200
In-Reply-To: <20201202170359.19330bda@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1606991669; bh=+y/0+N9NwpUl6dFJRCFrASL5EjS0UIZ75SWw0EFsyio=;
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
 b=Wf8ULNWTIyI1s5AIUK1APLOM1YbVCO8FqNQ9vQ86XP1Ihe+a0UP3JLlajBFhDiXmb
 vSVyiG9vC+i7ACFlEhu86LvBFWGuc/qzlF8Pc4/9Pz1t+0l4Fh2I9cbjeRfGNpZCit
 28i2qAKMVuiLQKamBWYcvdPyFwTqMAwXhyX9dzpwq/Qw/InoRMqh7xJJJJzXh7A3OO
 2T+IUwJFXM0qYvsbuyNx6NZRUnI7ELGCYdjct0x1Pgik1xkhrILw9NUa401MhikDlS
 UAMGFMFewgSJf3Bm6Y6yA97D0coSG+cyCUK/38hCfzJZnAik+zaZ/+C+B8H4gX/JRm
 ILdTy4sOb4jHg==
Subject: Re: [Bridge] [PATCH net] net: bridge: Fix a warning when del bridge
	sysfs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, Wang Hai <wanghai38@huawei.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, linux-kernel@vger.kernel.org, roopa@nvidia.com

On 03/12/2020 03:03, Jakub Kicinski wrote:
> On Tue, 1 Dec 2020 22:01:14 +0800 Wang Hai wrote:
>> If adding bridge sysfs fails, br->ifobj will be NULL, there is no
>> need to delete its non-existent sysfs when deleting the bridge device,
>> otherwise, it will cause a warning. So, when br->ifobj == NULL,
>> directly return can fix this bug.
>>
>> br_sysfs_addbr: can't create group bridge4/bridge
>> ------------[ cut here ]------------
>> sysfs group 'bridge' not found for kobject 'bridge4'
>> WARNING: CPU: 2 PID: 9004 at fs/sysfs/group.c:279 sysfs_remove_group fs/sysfs/group.c:279 [inline]
>> WARNING: CPU: 2 PID: 9004 at fs/sysfs/group.c:279 sysfs_remove_group+0x153/0x1b0 fs/sysfs/group.c:270
>> Modules linked in: iptable_nat
>> ...
>> Call Trace:
>>   br_dev_delete+0x112/0x190 net/bridge/br_if.c:384
>>   br_dev_newlink net/bridge/br_netlink.c:1381 [inline]
>>   br_dev_newlink+0xdb/0x100 net/bridge/br_netlink.c:1362
>>   __rtnl_newlink+0xe11/0x13f0 net/core/rtnetlink.c:3441
>>   rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3500
>>   rtnetlink_rcv_msg+0x385/0x980 net/core/rtnetlink.c:5562
>>   netlink_rcv_skb+0x134/0x3d0 net/netlink/af_netlink.c:2494
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>>   netlink_unicast+0x4a0/0x6a0 net/netlink/af_netlink.c:1330
>>   netlink_sendmsg+0x793/0xc80 net/netlink/af_netlink.c:1919
>>   sock_sendmsg_nosec net/socket.c:651 [inline]
>>   sock_sendmsg+0x139/0x170 net/socket.c:671
>>   ____sys_sendmsg+0x658/0x7d0 net/socket.c:2353
>>   ___sys_sendmsg+0xf8/0x170 net/socket.c:2407
>>   __sys_sendmsg+0xd3/0x190 net/socket.c:2440
>>   do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> 
> Nik, is this the way you want to handle this?
> 
> Should the notifier not fail if sysfs files cannot be created?
> Currently br_sysfs_addbr() returns an int but the only caller 
> ignores it.
> 

Hi,
The fix is wrong because this is not the only user of ifobj. The bridge
port sysfs code also uses it and br_sysfs_addif() will create the new
symlink in sysfs_root_kn due to NULL kobj passed which basically means
only one port will be enslaved, the others will fail in creating their
sysfs entries and thus fail to be added as ports.

I'd prefer to just fail from the notifier based on the return value.
The only catch would be to test it with br_vlan_bridge_event() which
is called on bridge master device events, it should be fine as
br_vlan_find() deals with NULL vlan groups but at least a comment
above it in br.c's notifier would be good so if anyone decides to add
any NETDEVICE_UNREGISTER handling would be warned about it.

Also please add proper fixes tag, the bug seems to be since:
bb900b27a2f4 ("bridge: allow creating bridge devices with netlink")

It actually changed the behaviour, before that the return value of br_sysfs_addbr()
was checked and the device got unregistered on failure.

Thanks,
 Nik


