Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=MATRZxhEsc+WHJSbjAUCV+pGYm1I7g19FKrsEa/0Yf4=;
	b=nMvmHAmepzVjwKgv1spz/NcNnp8/xKxUJjL6aNoLfJK2VMF+ckeYROz40DwGpFpPhO
	MURFAHdTC7MXc7PPoCeo7KaKPI1pNx/qdz/VZi7Wk0TntVuHLp6WA5ws1fYYRK9knwb1
	ht6JARL979VnMk+JNtk2wZV6fJfm19uhMHsYHYBz/9zv1iA9i+XFWk7eHSqLCmElMC37
	v//2l1QReTS3lRG8j3VyQghQxr56BHO1pfz4ll3NT9VmMStqJL4uPE/2CHmlEXSH7kbI
	s0HrmiUdUInrHSeGy2kwcAlEe+rVeqkTNqSPj2RmIFuf7HxV7SnIZmJfF235gNM9S2n8
	dQrw==
Date: Sat, 20 May 2017 13:57:20 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <20170520055720.GA12974@leo.usersys.redhat.com>
References: <20170519173043.10201-1-cera@cera.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170519173043.10201-1-cera@cera.cz>
Subject: Re: [Bridge] [PATCH net-next v2] bridge: fix hello and hold timers
 starting/stopping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ivan Vecera <cera@cera.cz>
Cc: lucien.xin@gmail.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

On Fri, May 19, 2017 at 07:30:43PM +0200, Ivan Vecera wrote:
> Current bridge code incorrectly handles starting/stopping of hello and
> hold timers during STP enable/disable.
> 
> 1. Timers are stopped in br_stp_start() during NO_STP->USER_STP
>    transition. The timers are already stopped in NO_STP state so
>    this is confusing no-op.

Hi Ivan,

Shouldn't we start hello timer in br_stp_start when NO_STP -> BR_KERNEL_STP ?
> 
> 2. During USER_STP->NO_STP transition the timers are started. This
>    does not make sense and is confusion because the timer should not be
>    active in NO_STP state.

Yes, but what about BR_KERNEL_STP -> NO_STP in function br_stp_stop() ?
> 
> Cc: davem@davemloft.net
> Cc: sashok@cumulusnetworks.com
> Cc: stephen@networkplumber.org
> Cc: bridge@lists.linux-foundation.org
> Cc: lucien.xin@gmail.com
> Cc: nikolay@cumulusnetworks.com
> Signed-off-by: Ivan Vecera <cera@cera.cz>
> ---
>  net/bridge/br_stp_if.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 08341d2aa9c9..a05027027513 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -150,7 +150,6 @@ static int br_stp_call_user(struct net_bridge *br, char *arg)
>  
>  static void br_stp_start(struct net_bridge *br)
>  {
> -	struct net_bridge_port *p;
>  	int err = -ENOENT;
>  
>  	if (net_eq(dev_net(br->dev), &init_net))
> @@ -169,11 +168,6 @@ static void br_stp_start(struct net_bridge *br)
>  	if (!err) {
>  		br->stp_enabled = BR_USER_STP;
>  		br_debug(br, "userspace STP started\n");
> -
> -		/* Stop hello and hold timers */
> -		del_timer(&br->hello_timer);
> -		list_for_each_entry(p, &br->port_list, list)
> -			del_timer(&p->hold_timer);

I'm not sure if user space daemon will send bpdu or not? In comment
76b91c32dd86 ("bridge: stp: when using userspace stp stop kernel hello and
hold timers"). Nikolay said we should not handle it with BR_USER_STP.

>  	} else {
>  		br->stp_enabled = BR_KERNEL_STP;
>  		br_debug(br, "using kernel STP\n");
> @@ -187,7 +181,6 @@ static void br_stp_start(struct net_bridge *br)
>  
>  static void br_stp_stop(struct net_bridge *br)
>  {
> -	struct net_bridge_port *p;
>  	int err;
>  
>  	if (br->stp_enabled == BR_USER_STP) {
> @@ -196,10 +189,6 @@ static void br_stp_stop(struct net_bridge *br)
>  			br_err(br, "failed to stop userspace STP (%d)\n", err);
>  
>  		/* To start timers on any ports left in blocking */
> -		mod_timer(&br->hello_timer, jiffies + br->hello_time);
> -		list_for_each_entry(p, &br->port_list, list)
> -			mod_timer(&p->hold_timer,
> -				  round_jiffies(jiffies + BR_HOLD_TIME));

If we do not del hello_timer. after it expired in br_hello_timer_expired(),
Our state is br->dev->flags & IFF_UP and br->stp_enabled == NO_STP, it will
call mod_timer(&br->hello_timer, round_jiffies(jiffies + br->hello_time))
and we will keep sending bpdu message even after stp stoped.

>  		spin_lock_bh(&br->lock);
>  		br_port_state_selection(br);
>  		spin_unlock_bh(&br->lock);
> -- 

So how about just like

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index d8ad73b..0198f62 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -183,6 +183,7 @@ static void br_stp_start(struct net_bridge *br)
        } else {
                br->stp_enabled = BR_KERNEL_STP;
                br_debug(br, "using kernel STP\n");
+               mod_timer(&br->hello_timer, jiffies + br->hello_time);

                /* To start timers on any ports left in blocking */
                br_port_state_selection(br);
@@ -202,7 +203,6 @@ static void br_stp_stop(struct net_bridge *br)
                        br_err(br, "failed to stop userspace STP (%d)\n", err);

                /* To start timers on any ports left in blocking */
-               mod_timer(&br->hello_timer, jiffies + br->hello_time);
                list_for_each_entry(p, &br->port_list, list)
                        mod_timer(&p->hold_timer,
                                  round_jiffies(jiffies + BR_HOLD_TIME));
@@ -211,6 +211,7 @@ static void br_stp_stop(struct net_bridge *br)
                spin_unlock_bh(&br->lock);
        }

+       del_timer_sync(&br->hello_timer);
        br->stp_enabled = BR_NO_STP;
 }

Thanks
Hangbin
