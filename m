Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=c7ppvSGFMjXTyAACKzFwqYFiWmXivSzgvL4BwU7SqKc=;
 b=QCrfuyYV9QtWOFIfcgtA1QjB4ZlZXyDB6yb27ilwN40G9t99u9DV7E4YEcS3iDf1D0
 gPu1ja+uAVRP7g21Exws4PuS4fj1pcxNI50VHKPZb2Z2mHEIgIJ0OroTwI2EKT0Jiylq
 Ak303v1ThmTUdWqUhbe5oCVI9WT4PbxF4zRVX6sKNsMV2TKwOxaIBIa5S+J4Mna6/v9s
 gyKPYSH12bfPTStTQn11Vx8CtQihilapqxB4tJbPJIrQ7ZAcQQu7rkfujT38uf4SPJr7
 rodkAP1za+7grryh4416obMSb0Szv7MeOGiLOaqJ06o1m9LL0e4+GX20R28tHNDWJmrn
 SDWQ==
Date: Sun, 10 Apr 2022 23:06:57 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220410200657.cwx7xy3t6jycqqrn@skbuf>
References: <20220410134227.18810-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220410134227.18810-1-arinc.unal@arinc9.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: offload BR_HAIRPIN_MODE,
 BR_ISOLATED, BR_MULTICAST_TO_UNICAST
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>

On Sun, Apr 10, 2022 at 04:42:27PM +0300, Arınç ÜNAL wrote:
> Add BR_HAIRPIN_MODE, BR_ISOLATED and BR_MULTICAST_TO_UNICAST port flags to
> BR_PORT_FLAGS_HW_OFFLOAD so that switchdev drivers which have an offloaded
> data plane have a chance to reject these bridge port flags if they don't
> support them yet.
> 
> It makes the code path go through the
> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS driver handlers, which return
> -EINVAL for everything they don't recognize.
> 
> For drivers that don't catch SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS at
> all, switchdev will return -EOPNOTSUPP for those which is then ignored, but
> those are in the minority.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

> Let me know if this is netdev/net material instead.

The thing with targeting this against "net" is that we've seen the
introduction of BR_PORT_LOCKED fairly recently which has tainted the
BR_PORT_FLAGS_HW_OFFLOAD macro. So backporting would conflict very
quickly down the path. Sure that isn't a decisive problem, but I don't
think it's worth the extra trouble of preparing special patches for the
"stable" trees, and having those diverge from the current master.

> 
> Commit log is heavily quoted from Vladimir Oltean <olteanv@gmail.com>.
> 
> Arınç
> ---
>  net/bridge/br_switchdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 8cc44c367231..81400e0b26ac 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -72,7 +72,8 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
>  
>  /* Flags that can be offloaded to hardware */
>  #define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
> -				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PORT_LOCKED)
> +				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PORT_LOCKED | \
> +				  BR_HAIRPIN_MODE | BR_ISOLATED | BR_MULTICAST_TO_UNICAST)
>  
>  int br_switchdev_set_port_flag(struct net_bridge_port *p,
>  			       unsigned long flags,
> -- 
> 2.25.1
> 
