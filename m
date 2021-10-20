Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtQhH49jeATDSvrb0XMHhnj5RIAkMJRsgiVpXriwb38=;
 b=AnLum5ggDi67tMcrVtFvtnjcxHkAKtDun+xFwqmxdwjJsid1NcqhzBpM+4kbWEOKeCGQCYBpsXcxrpn0uu/0rnBzrO9x373t4wM+Ceqjltwe5YU1hDJcJzUUsliqmki5zGkwgCz+zAx7koB2ZA83B1D26b1L2OU+mklf3cAkOnr5ejZKsWrA67snKSWB0gQy4CdYAsy1TeYBHJI59x5xqjP+qEYpd70lzCGZLGlEQQRycHJYIbqmcqd9zLXDWrF7fur+uQVpI/oz/VXXJxd4nI5jg5YIg1PElQYtQN7IvNQC6mtr3G7k/C4+3qlxM5czmarfS7FUK1wNY8PN861KSg==
Message-ID: <c041a184-92cb-0ebd-25e9-13bfc6413fc9@nvidia.com>
Date: Wed, 20 Oct 2021 12:49:17 +0300
Content-Language: en-US
References: <20211020023604.695416-1-liuhangbin@gmail.com>
 <20211020024016.695678-1-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20211020024016.695678-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCHv2 net] net: bridge: mcast: QRI must be less
	than QI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On 20/10/2021 05:40, Hangbin Liu wrote:
> Based on RFC3376 8.3:
> The number of seconds represented by the [Query Response Interval]
> must be less than the [Query Interval].
> 
> Fixes: d902eee43f19 ("bridge: Add multicast count/interval sysfs entries")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/bridge/br_multicast.c    | 27 +++++++++++++++++++++++++++
>  net/bridge/br_netlink.c      |  8 ++++++--
>  net/bridge/br_private.h      |  4 ++++
>  net/bridge/br_sysfs_br.c     |  6 ++----
>  net/bridge/br_vlan_options.c |  8 ++++++--
>  5 files changed, 45 insertions(+), 8 deletions(-)
> 

Nacked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

I think we just discussed this a day ago? It is the same problem -
while we all agree the values should follow the RFC, users have had
the option to set any values forever (even non-RFC compliant ones).
This change risks breaking user-space.

Users are free to follow the RFC or not, we can't force them at this
point. This should've been done when the config option was added long
time ago.

Thanks,
 Nik
