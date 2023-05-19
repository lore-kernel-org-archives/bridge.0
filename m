Return-Path: <simon.horman@corigine.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7BDE83A51
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0715F83A4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSvYHf7wsItxPECth4BhNPbkGqh0XgM4W31lp0+BBUM=;
 b=G2WcjxZJFydJbNA8Yr+wYHu7y9BUZp+LVvGJOJV/KnJI0dROjtTJh+4MpAb+QcHhvrtADzG7TkbxqX+lSLIzpOvt+4ea7GWIqclEQAOMev/YUWzfXae7FW9NILukbIatDcJpndpNG/vJE7k5gw+ICgCBkesF2OErl8Xm2W9hTfs=
Date: Fri, 19 May 2023 13:33:00 +0200
From: Simon Horman <simon.horman@corigine.com>
Message-ID: <ZGdebBM8mxGOTovV@corigine.com>
References: <20230518113328.1952135-1-idosch@nvidia.com>
 <20230518113328.1952135-4-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518113328.1952135-4-idosch@nvidia.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 3/5] flow_offload: Reject matching on
 layer 2 miss
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, vladimir.oltean@nxp.com, xiyou.wangcong@gmail.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On Thu, May 18, 2023 at 02:33:26PM +0300, Ido Schimmel wrote:
> Adjust drivers that support the 'FLOW_DISSECTOR_KEY_META' key to reject
> filters that try to match on the newly added layer 2 miss option. Add an
> extack message to clearly communicate the failure reason to user space.

Hi Ido,

FLOW_DISSECTOR_KEY_META is also used in the following.
Perhaps they don't need updating. But perhaps it is worth mentioning why.

 * drivers/net/ethernet/mediatek/mtk_ppe_offload.c
 * drivers/net/ethernet/netronome/nfp/flower/conntrack.c

> 
> Example:
> 
>  # tc filter add dev swp1 egress pref 1 proto all flower skip_sw l2_miss true action drop
>  Error: mlxsw_spectrum: Can't match on "l2_miss".
>  We have an error talking to the kernel
> 
> Acked-by: Elad Nachman <enachman@marvell.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

...
