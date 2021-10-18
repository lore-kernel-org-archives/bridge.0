Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3h9iP+bpr660/cL/QHyMr/9YPNnb1d7Ml36XvAePJVg=;
 b=QRE2lwB57taADFRUDju+11+ZkNei2GOtjiOKleu9TQ7pn6xlXS7Pmd7NF+eNMErBVltPdr7WWs1Vs3ycBrKBCotO5AqHjWsMsuLsolwF8MJrv8mLT3WjyOjx0ac6G0ZLCHoF7i1IOU6mjqDolG2+ZgKQFLnun3FfJ3ZlsFATi+UHQa3fR+YZqJGJVQY7Zt+3OTnEGNSBsxSRtYK42p2TNt42VC6hmnPRXhH65VB2wzBuIgiKJSq9yH7ABCilrFd84rJ2DKWgePh8SG65/jlOXas98s0pORtImGUP0EylaXAcGDc6JpOi0hPXgcF6s+8nBOGTAmHbXoR3MNRBr1gSeQ==
Message-ID: <ab707f4d-587a-0fae-e673-5da49f5946db@nvidia.com>
Date: Mon, 18 Oct 2021 13:28:14 +0300
Content-Language: en-US
References: <20211018082612.625417-1-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20211018082612.625417-1-liuhangbin@gmail.com>
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
To: Hangbin Liu <liuhangbin@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On 18/10/2021 11:26, Hangbin Liu wrote:
> There is no meaning to set an IGMP counter/timer to 0. Or it will cause
> unexpected behavior. E.g. if set multicast_membership_interval to 0,
> bridge will remove the mdb immediately after adding.
> 
> Fixes: 79b859f573d6 ("bridge: netlink: add support for multicast_last_member_count")
> Fixes: b89e6babad4b ("bridge: netlink: add support for multicast_startup_query_count")
> Fixes: 7e4df51eb35d ("bridge: netlink: add support for igmp's intervals")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/bridge/br_netlink.c  | 73 +++++++++++++++++++++++++++++---------
>  net/bridge/br_sysfs_br.c | 75 +++++++++++++++++++++++++++++++---------
>  2 files changed, 116 insertions(+), 32 deletions(-)
> 

Nacked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

For a few reasons,
I'll start with the obvious that - yes, users are allowed to change the values to non-RFC
compliant, but we cannot change that now as we'd risk breaking user-space which is probably
doing that somewhere with some of the values below. We can fix any issues that might arise
from doing it though, so it doesn't affect normal operation. If changing some of the options
to 0 or to unreasonably high values lead to problems let's fix those and we could discuss
adding constraints there if necessary.

The second issue is that you're mixing different checks below, you say do not allow zero
but you're also checking for RFC compliance between different values.

The third issue is that you haven't done the same change for the same values for per-vlan
multicast options (we have the same options per-vlan as well).

Your fixes tags are wrong, too. Most of these values could be set well before they were
available through netlink.

Note on the style - generally I'd add helpers to set them and add the constraints in those
helpers, so they can be used for both netlink and sysfs. It would definitely target net-next
unless it's an actual bug fix.

Thanks,
 Nik
