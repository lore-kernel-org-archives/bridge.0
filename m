Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E9E8411C6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42FDB409AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2B6AHJXFALDd5ILm1KFjZGfIO27q+8yVBqX4xszsbU=;
 b=NgOW3f/lmlZ2GN5qLKND9rLiPEdRg/rTae16VdiWAWiFGJTS1Wt9qItdlqeq0UK69dyl8lwn37x3kwHLx/pQ30C324EpHvKcQTRKe7Q1Ag+AO+qZ+MYLxm9COOXMwEfW7pQnAeqacJpPu4HYux5cefDOm7BshfJHuoKKm2kDPo0FKEwTGahHU41NQ/8KYi5QsumDp6QaIpAd/CtH9aBDNQtug4eJH6Rr+JeXxGLRAvgM912zEu0c8r4zNrxDA39BMf/ZjTenM2du48zNJixPeKQf4H++TkGVUjRSFJFcd/i6RmUwORvZrAHzWv4Jra6P5SzE71fhUilnDliMu2Yn2w==
Date: Tue, 6 Dec 2022 11:53:03 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y48Q/xoACOyFaozp@shredder>
References: <20221205074251.4049275-1-idosch@nvidia.com>
 <20221205074251.4049275-2-idosch@nvidia.com>
 <06490c08-bf5e-1714-f56c-1a6068fb2ec9@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06490c08-bf5e-1714-f56c-1a6068fb2ec9@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 1/8] bridge: mcast: Centralize netlink
 attribute parsing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Mon, Dec 05, 2022 at 01:34:08PM +0200, Nikolay Aleksandrov wrote:
> I just noticed the skb argument is unused. Does it get used in a future change?

Nope :)

> Also a minor nit - I think nlh can be a const, nlmsg_parse_deprecated already uses a const nlh.

Removed the 'skb' argument and marked 'nlh' as 'const'.

Thanks!
