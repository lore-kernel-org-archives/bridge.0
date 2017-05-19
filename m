Return-Path: <lucien.xin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Y2OaBJYbK8WpoJLdJ663vYBstT+4040+GZNZceNUbxE=;
	b=gVuvtH7RLwqYDdEzLznAnvnUuc9ew6jelegKrDkbPsCvMC0qy1YcMvsGwKqoy22Zl6
	SiMhF9UxkYexJoBgzCCMsXJFiY/ScPwMU9C6AJ39ME37MoiOa81enzIa2ZlEYzlWX2gQ
	cj8dn28xhS3CgVqwd88Sd9ce2CrhieNsxMtU03b7HitrS/iTIGc06m/su/Tuleox6QCw
	WCHhA5vJizVOkAdsbmkzFSjwUcTd64xf00LybX0ulZ8Q2xmQkm2QP4P/z8kgMVG6nlVa
	ycLhKP4Ip/HHEHTIesI4DjyzNp6n7HjIFa3Hl0S/6yAOvmGFnACybskSywUXyAoNWZxk
	+RxA==
MIME-Version: 1.0
In-Reply-To: <20170519162543.31670-1-cera@cera.cz>
References: <20170519162543.31670-1-cera@cera.cz>
From: Xin Long <lucien.xin@gmail.com>
Date: Sat, 20 May 2017 00:51:42 +0800
Message-ID: <CADvbK_eRRy5bXb1RN6p-DTp9cKp6MvCZGH8oL=gfhTrJ0URFqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net] bridge: fix hello and hold timers
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
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, network dev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, davem <davem@davemloft.net>

On Sat, May 20, 2017 at 12:25 AM, Ivan Vecera <cera@cera.cz> wrote:
> Current bridge code incorrectly handles starting/stopping of hello and
> hold timers during STP enable/disable.
>
> 1. Timers are stopped in br_stp_start() during NO_STP->USER_STP
>    transition. This is not correct as the timers are stopped in NO_STP
>    case.
>
> 2. Timers are started in br_stp_stop() during USER_STP->NO_STP transition.
>    This is not also correct as the timers should be stopped in NO_STP
>    state.
>
> 3. Timers are NOT stopped in br_stp_stop() during KERNEL_STP->NO_STP
>    transition. They should be stopped as they are running in KERNEL_STP
>    state and should not run in NO_STP case.
>
> The patch is a follow-up for "bridge: start hello_timer when enabling
> KERNEL_STP in br_stp_start" patch from Xin Long.
>
> Cc: davem@davemloft.net
> Cc: sashok@cumulusnetworks.com
> Cc: stephen@networkplumber.org
> Cc: bridge@lists.linux-foundation.org
> Cc: lucien.xin@gmail.com
> Cc: nikolay@cumulusnetworks.com
> Signed-off-by: Ivan Vecera <cera@cera.cz>
> ---
>  net/bridge/br_stp_if.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 0db8102995a5..f137ebf27755 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -150,7 +150,6 @@ static int br_stp_call_user(struct net_bridge *br, char *arg)
>
>  static void br_stp_start(struct net_bridge *br)
>  {
> -       struct net_bridge_port *p;
>         int err = -ENOENT;
>
>         if (net_eq(dev_net(br->dev), &init_net))
> @@ -169,11 +168,6 @@ static void br_stp_start(struct net_bridge *br)
>         if (!err) {
>                 br->stp_enabled = BR_USER_STP;
>                 br_debug(br, "userspace STP started\n");
> -
> -               /* Stop hello and hold timers */
> -               del_timer(&br->hello_timer);
> -               list_for_each_entry(p, &br->port_list, list)
> -                       del_timer(&p->hold_timer);
>         } else {
>                 br->stp_enabled = BR_KERNEL_STP;
>                 br_debug(br, "using kernel STP\n");
> @@ -197,13 +191,14 @@ static void br_stp_stop(struct net_bridge *br)
>                         br_err(br, "failed to stop userspace STP (%d)\n", err);
>
>                 /* To start timers on any ports left in blocking */
> -               mod_timer(&br->hello_timer, jiffies + br->hello_time);
> -               list_for_each_entry(p, &br->port_list, list)
> -                       mod_timer(&p->hold_timer,
> -                                 round_jiffies(jiffies + BR_HOLD_TIME));
>                 spin_lock_bh(&br->lock);
>                 br_port_state_selection(br);
>                 spin_unlock_bh(&br->lock);
> +       } else {
> +               /* BR_KERNEL_STP - stop hello and hold timers */
> +               del_timer(&br->hello_timer);
> +               list_for_each_entry(p, &br->port_list, list)
> +                       del_timer(&p->hold_timer);
I'm thinking, what if the timers are running when deleting them ?
del_timer may not be going to delete it, and still have to stop itself
next time when br->stp_enabled = BR_NO_STP.

So do you think it's better to do nothing here and just leave it to be
stopped by itself when checking br->stp_enabled  in
br_hello_timer_expired ?

>         }
>
>         br->stp_enabled = BR_NO_STP;
> --
> 2.13.0
>
