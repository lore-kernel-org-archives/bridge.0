Return-Path: <yangyingliang@huawei.com>
References: <20210809090211.65677-1-yangyingliang@huawei.com>
 <8af55b8a-0844-3fb2-8dd4-f6818c2675db@nvidia.com>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <e3414cc7-b7b3-26b2-95f5-ff92ac73b3ac@huawei.com>
Date: Mon, 9 Aug 2021 17:30:46 +0800
MIME-Version: 1.0
In-Reply-To: <8af55b8a-0844-3fb2-8dd4-f6818c2675db@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Bridge] [PATCH net v2] net: bridge: fix memleak in br_add_if()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: kuba@kernel.org, davem@davemloft.net, roopa@nvidia.com


On 2021/8/9 17:09, Nikolay Aleksandrov wrote:
> On 09/08/2021 12:02, Yang Yingliang wrote:
>> I got a memleak report:
>>
>> BUG: memory leak
>> unreferenced object 0x607ee521a658 (size 240):
>> comm "syz-executor.0", pid 955, jiffies 4294780569 (age 16.449s)
>> hex dump (first 32 bytes, cpu 1):
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>> backtrace:
>> [<00000000d830ea5a>] br_multicast_add_port+0x1c2/0x300 net/bridge/br_multicast.c:1693
>> [<00000000274d9a71>] new_nbp net/bridge/br_if.c:435 [inline]
>> [<00000000274d9a71>] br_add_if+0x670/0x1740 net/bridge/br_if.c:611
>> [<0000000012ce888e>] do_set_master net/core/rtnetlink.c:2513 [inline]
>> [<0000000012ce888e>] do_set_master+0x1aa/0x210 net/core/rtnetlink.c:2487
>> [<0000000099d1cafc>] __rtnl_newlink+0x1095/0x13e0 net/core/rtnetlink.c:3457
>> [<00000000a01facc0>] rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3488
>> [<00000000acc9186c>] rtnetlink_rcv_msg+0x369/0xa10 net/core/rtnetlink.c:5550
>> [<00000000d4aabb9c>] netlink_rcv_skb+0x134/0x3d0 net/netlink/af_netlink.c:2504
>> [<00000000bc2e12a3>] netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
>> [<00000000bc2e12a3>] netlink_unicast+0x4a0/0x6a0 net/netlink/af_netlink.c:1340
>> [<00000000e4dc2d0e>] netlink_sendmsg+0x789/0xc70 net/netlink/af_netlink.c:1929
>> [<000000000d22c8b3>] sock_sendmsg_nosec net/socket.c:654 [inline]
>> [<000000000d22c8b3>] sock_sendmsg+0x139/0x170 net/socket.c:674
>> [<00000000e281417a>] ____sys_sendmsg+0x658/0x7d0 net/socket.c:2350
>> [<00000000237aa2ab>] ___sys_sendmsg+0xf8/0x170 net/socket.c:2404
>> [<000000004f2dc381>] __sys_sendmsg+0xd3/0x190 net/socket.c:2433
>> [<0000000005feca6c>] do_syscall_64+0x37/0x90 arch/x86/entry/common.c:47
>> [<000000007304477d>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> On error path of br_add_if(), p->mcast_stats allocated in
>> new_nbp() need be freed, or it will be leaked.
>>
>> Fixes: 1080ab95e3c7 ("net: bridge: add support for IGMP/MLD stats and export them via netlink")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>> v2:
>>    move free_percpu(p->mcast_stats) in release_nbp() and
>>    fix the compile error when CONFIG_BRIDGE_IGMP_SNOOPING
>>    is disabled.
>> ---
>>   net/bridge/br_if.c        | 5 ++++-
>>   net/bridge/br_multicast.c | 1 -
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
> You can add a helper to free mcast stats and use it in the error path.
> I'd like to keep the port dismantling code as it's currently done, moving
> multicast stats freeing away from br_multicast_del_port is wrong.
>
> In fact I think you can directly use br_multicast_del_port() as it's a noop w.r.t the
> other actions (stopping timers that were never started and walking empty lists).
> You'll have to test it, of course.
OK,  I will send a v3 after my testing.

Thanks,
Yang
>
> For this patch:
> Nacked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
>
> Thanks,
>   Nik
>
> .
