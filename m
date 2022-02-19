Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWBpbLaaOVGpC0chISbecg4jxQMtvFYsdgIyHL2pnGU=;
 b=UxcBmms+tY7y08BN0Je2z1lcAo7Od/pQOzmCRoqsK5Qw7FNjqE3llKYbeO8J0wWD6PFxHi8cvyIAGGT+kkTEBE+3zuwnL1LUCR2EucPZUau8X716EaSZBpN5xY2paskJwtWzMbpPneZrr1qoPaBPSIQN0pePjjnYlXhrH2l2EjiFUGOP3HJojV4vsQ6BJVZtdTstzk8XvhBTdeehqxLykocgtOKTn81qtTOiIMv1Si0psHfLwwyANndRWdJZsbSMSa78FwN1dGqNBbdle1BiNfWby4wL5YOEEz7y3CQwADM6tbvCQgG1H3teQv2igE1zLbss3aXlFHBYWRSfdmgLOA==
Message-ID: <34364248-5c07-6fc6-59e8-ff1a0faf69f3@nvidia.com>
Date: Sat, 19 Feb 2022 11:47:07 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
 <20220218155148.2329797-3-schultz.hans+netdev@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20220218155148.2329797-3-schultz.hans+netdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 2/5] net: bridge: Add support for
 offloading of locked port flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>, davem@davemloft.net, kuba@kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Stephen Suryaputra <ssuryaextr@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

On 18/02/2022 17:51, Hans Schultz wrote:
> Various switchcores support setting ports in locked mode, so that
> clients behind locked ports cannot send traffic through the port
> unless a fdb entry is added with the clients MAC address.
> 
> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> ---
>  net/bridge/br_switchdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index f8fbaaa7c501..bf549fc22556 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -72,7 +72,7 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
>  
>  /* Flags that can be offloaded to hardware */
>  #define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
> -				  BR_MCAST_FLOOD | BR_BCAST_FLOOD)
> +				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PORT_LOCKED)
>  
>  int br_switchdev_set_port_flag(struct net_bridge_port *p,
>  			       unsigned long flags,

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

