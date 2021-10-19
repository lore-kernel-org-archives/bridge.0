Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeVn+3UfkKxZOp00Sa0Ra+gr80KmUXeDuXI3JWLy5vU=;
 b=A/9aLoqM+aK2eWpVDmCPEPx2a7HZW1a4atrdNHifB3nBMkckh9z3wRBsd9HOKFjbTJyD/Y/+jIAoIdzp3bPoTWDs5TsHHBeR5MNzSqPWribKo6GEXgsmRt6+ltFYNy000ALELsb71BWeujJ366lVV3uRJXoYbuUrWzjkoXOIWPb/Mcp5BtEYXzFSTrXhksqOidSsYUn3Xx5ZUGtDvrNsyw5wrRAuC4vgGOt0pjk4bgt0FrkOlnA8kF+8qIQekZcXLieB7Kd9/kAnRGc1k2hGPHCHIqIw+MmEOGAzvf/TpnleXFPFSKz8axp+zk0gZ4US9SRDnST3zHyGl8+HArvwcw==
Message-ID: <a6bbd579-3d5f-6cbd-9523-49226a2b5a7a@nvidia.com>
Date: Tue, 19 Oct 2021 19:09:42 +0300
Content-Language: en-US
References: <20211018082612.625417-1-liuhangbin@gmail.com>
 <ab707f4d-587a-0fae-e673-5da49f5946db@nvidia.com>
 <YW5a9JLnfZc1M8Gh@Laptop-X1>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <YW5a9JLnfZc1M8Gh@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] net: bridge: mcast: Do not allow users to
 set IGMP counter/timer to zero
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: kuba@kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On 19/10/2021 08:43, Hangbin Liu wrote:
> Hi Nikolay,
> 
> On Mon, Oct 18, 2021 at 01:28:14PM +0300, Nikolay Aleksandrov wrote:
>> On 18/10/2021 11:26, Hangbin Liu wrote:
>>> There is no meaning to set an IGMP counter/timer to 0. Or it will cause
>>> unexpected behavior. E.g. if set multicast_membership_interval to 0,
>>> bridge will remove the mdb immediately after adding.
>>>
>>> Fixes: 79b859f573d6 ("bridge: netlink: add support for multicast_last_member_count")
>>> Fixes: b89e6babad4b ("bridge: netlink: add support for multicast_startup_query_count")
>>> Fixes: 7e4df51eb35d ("bridge: netlink: add support for igmp's intervals")
>>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>>> ---
>>>  net/bridge/br_netlink.c  | 73 +++++++++++++++++++++++++++++---------
>>>  net/bridge/br_sysfs_br.c | 75 +++++++++++++++++++++++++++++++---------
>>>  2 files changed, 116 insertions(+), 32 deletions(-)
>>>
>>
>> Nacked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
>>
>> For a few reasons,
>> I'll start with the obvious that - yes, users are allowed to change the values to non-RFC
>> compliant, but we cannot change that now as we'd risk breaking user-space which is probably
>> doing that somewhere with some of the values below. We can fix any issues that might arise
>> from doing it though, so it doesn't affect normal operation. If changing some of the options
>> to 0 or to unreasonably high values lead to problems let's fix those and we could discuss
>> adding constraints there if necessary.
> 
> I started this patch when I saw there is not limit for setting
> multicast_membership_interval to 0, which will cause bridge remove the
> mdb directly after adding. Do you think this is a problem.
> 
> And what about others? I don't think there is a meaning to set other intervals
> to 0.
> 

The problem is not if there is meaning, we cannot start restricting option values now after
they've become uapi (and have been for a very long time) because we can break user-space even
though chances are pretty low. I don't think this patch is acceptable, I commented on the other
patch issues but they don't matter because of this.

Thanks,
 Nik
