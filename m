Return-Path: <joakim.tjernlund@transmode.se>
In-Reply-To: <1330454231-23852-2-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1330454231-23852-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1330454231-23852-2-git-send-email-Joakim.Tjernlund@transmode.se>
Message-ID: <OF88E2E08E.AA7395FB-ONC12579B4.0002990A-C12579B4.0002D778@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 1 Mar 2012 01:31:02 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] [PATCH 2/2] bridge: message age needs to increase,
	not decrease.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Cc: bridge@lists.linux-foundation.org

Ping? I think this a fairly big problem and should go to Linus
before next release.
Same for bridge: Adjust min age inc for HZ > 256

 Jocke

Joakim Tjernlund <Joakim.Tjernlund@transmode.se> wrote on 2012/02/28 19:37:11:
>
> commit bridge: send proper message_age in config BPDU
> added this gem:
>   bpdu.message_age = (jiffies - root->designated_age)
>   p->designated_age = jiffies + bpdu->message_age;
> Notice how bpdu->message_age is negated when reassigned to
> bpdu.message_age. This causes message age to decrease breaking the
> STP protocol.
>
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> ---
>  net/bridge/br_stp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
> index 9a8aebd..45331fe 100644
> --- a/net/bridge/br_stp.c
> +++ b/net/bridge/br_stp.c
> @@ -188,7 +188,7 @@ static inline void br_record_config_information(struct net_bridge_port *p,
>     p->designated_cost = bpdu->root_path_cost;
>     p->designated_bridge = bpdu->bridge_id;
>     p->designated_port = bpdu->port_id;
> -   p->designated_age = jiffies + bpdu->message_age;
> +   p->designated_age = jiffies - bpdu->message_age;
>
>     mod_timer(&p->message_age_timer, jiffies
>          + (p->br->max_age - bpdu->message_age));
> --
> 1.7.3.4
>

