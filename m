Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbzVia14gGixUTi2PiNzvrcGuAixaykfj10i3Izqs/U=;
 b=TTLHoP5fIJNwHZIiBa+NWWapp6joBsfViglzCJoqPeUXScAMEIxapaK2z+k9Q2uq+jyNILAnXPUKgj0nERaXqFK1Koo80cxsf0Z+0N3dfqHhSistCHLKsJDzShd1CY1eH2I8lRGlxNKx9Xy/+IvYYRyjQDzNLpunVYJp+kG0NHd9sGbsvzLlAYKjCGlyOEDxDeivHe+jVGFwYyISRK8TzdYflWT0C8p7XDjTl5CJzxFMnlhVdWQV0yw/2CEbdfFc5SnByPxL6igSeFOkHOfwanO1vCp0ULTGYSAPf/djHg4DGySAFad/wCpVPEJEPQdXnlsnk3OSfJSRV0phsy7cxw==
References: <20210512231941.19211-1-linus.luessing@c0d3.blue>
 <20210512231941.19211-6-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <1e18b246-1efd-98ef-60a9-3bbf2a7f06e7@nvidia.com>
Date: Thu, 13 May 2021 14:32:10 +0300
In-Reply-To: <20210512231941.19211-6-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v3 05/11] net: bridge: mcast: prepare
 is-router function for mcast router split
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>

On 13/05/2021 02:19, Linus Lüssing wrote:
> In preparation for the upcoming split of multicast router state into
> their IPv4 and IPv6 variants make br_multicast_is_router() protocol
> family aware.
> 
> Note that for now br_ip6_multicast_is_router() uses the currently still
> common ip4_mc_router_timer for now. It will be renamed to
> ip6_mc_router_timer later when the split is performed.
> 
> While at it also renames the "1" and "2" constants in
> br_multicast_is_router() to the MDB_RTR_TYPE_TEMP_QUERY and
> MDB_RTR_TYPE_PERM enums.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_input.c     |  2 +-
>  net/bridge/br_multicast.c |  5 +++--
>  net/bridge/br_private.h   | 37 +++++++++++++++++++++++++++++++++----
>  3 files changed, 37 insertions(+), 7 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

