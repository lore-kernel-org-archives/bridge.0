Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=4BAbC2SrKWiikj9sQCe8GZxvTJd08+U2hgXBpuolPto=;
 b=s8pXpBQeUNug2WzF/0ZLJCiDOoSVGmUqybFpEraPZF/lCgswGicM3tDaouz3TeHrOF
 fBsGbAotjowRZ30ET4SpUOXQgWE9T28ljK8qGn0WnjalcAZoppJweaNPqvC6QXowV8oP
 fdGNJk7/6sv/lUAIGXi/0+qClfMjGhbglUkLcjUljRKSIXvi/os3LiG3/CqUOfEWnp2k
 a34gA/sTvHlyxXDs+nNZXdc+mLT8E/kNVL+VXr4qgu9PzX4CJHxJdZIU69fC+VILbQw4
 rnYIgYPV+7eYuHVFwlTVVsalqXogXw30U7cEAi2EOqTVgP4MnQDfyUQv3eklF8LBtG8l
 G0FA==
Message-ID: <c9374232-00a3-d046-87f6-29f471b50f5c@blackwall.org>
Date: Thu, 10 Feb 2022 10:30:30 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220209130538.533699-1-schultz.hans+netdev@gmail.com>
 <20220209130538.533699-3-schultz.hans+netdev@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220209130538.533699-3-schultz.hans+netdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 2/5] net: bridge: Add support for
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
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>

On 09/02/2022 15:05, Hans Schultz wrote:
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

