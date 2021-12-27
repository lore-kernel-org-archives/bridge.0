Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA+KRUzxcy7EpPkf0jMHQd8Qab3G3ZvhQyKoo+92EPM=;
 b=BR073ALw7LAj2b/jHqFDGfoXJHUCm58pOnl2EDLUcHHsOQRUjGmhBActsCrYMCC4w2EySLQ9cLQcb6arLzA+rReVkyws0g0Zsno8CIkHcr0NogHovW02CUxjFZgMMev5sRG8eG3/YVqK4tHmXQydMxuxwjj/P8/9Uc8glOdPKU43Y8KFyfhtiUV0PXYN28IFfgrnzPUYprmhu+nolZxfT6Peaev2zC0as/MWlmTb6Mo+X4ROHLpUwuKlI2Nqpf536sUJrMXYuhFwyOxCo1TR2VCRKtqY8lNWEBvmvAqxxtFUn1sRaSRr9pCfE4DNLyef2pJ0FDHlL2tbYd00M6SVkw==
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Mon, 27 Dec 2021 19:21:14 +0200
Message-ID: <20211227172116.320768-1-nikolay@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net 0/2] net: bridge: mcast: add and enforce query
	interval minimum
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au, eric.dumazet@gmail.com, bridge@lists.linux-foundation.org, stable@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hi,
This set adds and enforces 1 second minimum value for bridge multicast
query and startup query intervals in order to avoid rearming the timers
too often which could lock and crash the host. I doubt anyone is using
such low values or anything lower than 1 second, so it seems like a good
minimum. In order to be compatible if the value is lower then it is
overwritten and a log message is emitted, since we can't return an error
at this point.

Eric, I looked for the syzbot reports in its dashboard but couldn't find
them so I've added you as the reporter. If you point me to the reports
I can respin to give syzbot the credit.

I've prepared a global bridge igmp rate limiting patch but wasn't
sure if it's ok for -net. It adds a static limit of 32k packets per
second, I plan to send it for net-next with added drop counters for
each bridge so it can be easily debugged.

Original report can be seen at:
https://lore.kernel.org/netdev/e8b9ce41-57b9-b6e2-a46a-ff9c791cf0ba@gmail.com/

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: mcast: add and enforce query interval minimum
  net: bridge: mcast: add and enforce startup query interval minimum

 net/bridge/br_multicast.c    | 32 ++++++++++++++++++++++++++++++++
 net/bridge/br_netlink.c      |  4 ++--
 net/bridge/br_private.h      |  6 ++++++
 net/bridge/br_sysfs_br.c     |  4 ++--
 net/bridge/br_vlan_options.c |  4 ++--
 5 files changed, 44 insertions(+), 6 deletions(-)

-- 
2.33.1

