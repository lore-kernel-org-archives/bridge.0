Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp9c8bteA9/QpO3pIOG/3bTEwmbE25ZhMXj+4SiAIvs=;
 b=hMVTC5Lw/aeMrtkMVlgms07lFnQqVXaDQyIbpT591k8ZodbYobUtxqrbpb0HyEAfeqz2YnnGysFnVrG9jDlI1gXAnauf9vT3FjQxFFq1AmfJMEtFlclZBCEL9JtVz4Iv5BD7ErG5YMyk5Z/RjV830/WYTn/y+4msufXRn5ZJnztfUnEPv7EsyJyAovGj3W6OO2jPbqSW/Yzbux8Rk+H+c/GgES3EjH9D4UjLKFDbyMTdQr+HMdQvfLGm2VMM2ubFhdxCmJoKCe8AEjhl1aFN+OTX6udcv6Bl2QhGcrAxnws4NpC6k3+0YKnD+Sstb+21UvK062nkzceLCBFpeRIl+g==
From: Nikolay Aleksandrov <nikolay@nvidia.com>
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-10-linus.luessing@c0d3.blue>
 <f2f1c811-0502-bde4-8ece-e47b3e30dc66@nvidia.com>
Message-ID: <e784e0e6-8b30-0862-e417-a6ff94790b8e@nvidia.com>
Date: Tue, 11 May 2021 12:33:08 +0300
In-Reply-To: <f2f1c811-0502-bde4-8ece-e47b3e30dc66@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v2 09/11] net: bridge: mcast: split
 multicast router state for IPv4 and IPv6
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>

On 11/05/2021 12:29, Nikolay Aleksandrov wrote:
> On 09/05/2021 22:45, Linus Lüssing wrote:
>> A multicast router for IPv4 does not imply that the same host also is a
>> multicast router for IPv6 and vice versa.
>>
>> To reduce multicast traffic when a host is only a multicast router for
>> one of these two protocol families, keep router state for IPv4 and IPv6
>> separately. Similar to how querier state is kept separately.
>>
>> For backwards compatibility for netlink and switchdev notifications
>> these two will still only notify if a port switched from either no
>> IPv4/IPv6 multicast router to any IPv4/IPv6 multicast router or the
>> other way round. However a full netlink MDB router dump will now also
>> include a multicast router timeout for both IPv4 and IPv6.
>>
>> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
>> ---
>>  net/bridge/br_forward.c   |   8 ++
>>  net/bridge/br_mdb.c       |  10 ++
>>  net/bridge/br_multicast.c | 197 ++++++++++++++++++++++++++++++++++----
>>  net/bridge/br_private.h   |   6 +-
>>  4 files changed, 201 insertions(+), 20 deletions(-)
[snip]
>> +#else
>> +static inline void br_ip6_multicast_add_router(struct net_bridge *br,
>> +					       struct net_bridge_port *port)
>> +{
>> +}
> 
> Actually that goes for multicast_add_router, too.
> 

err, my bad - multicast_add_router is fine as is, sorry about that

> I'm saying all this because soon I'll be adding per-vlan multicast router support
> and these will be reusable there without any modification if they can take any list.
> Also it'll be easier to maintain one set of functions instead of multiple identical ones.
> 
