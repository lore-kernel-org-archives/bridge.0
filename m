Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=5QT8sgurjMmDMiWbUuE5c6ApRwSx97DLuEHrBzA6ub0=;
	b=Gg3HhEw9mk60mxrI9oFvaX2oh/SySqcn5t1C56BOCVBWDOCTk5wey4CeZ5SJnmmWYw
	P82JkpgXIY6KCrmyPXPvDhF2U8nwcKrrfnGT4+bEH8bkn/5KXfs/TOIrFO71sMDhLwG1
	16rDSuGrdu/kyBaEMbX763eK0U4aY4BZsYjfw=
References: <6e78bfea3969ca1a937b37e28e796a3047b82615.1495203629.git.lucien.xin@gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <42f98aed-707c-6f91-8767-ca34004ec730@cumulusnetworks.com>
Date: Fri, 19 May 2017 18:41:26 +0300
MIME-Version: 1.0
In-Reply-To: <6e78bfea3969ca1a937b37e28e796a3047b82615.1495203629.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: start hello_timer when enabling
 KERNEL_STP in br_stp_start
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>
Cc: cera@cera.cz, davem@davemloft.net, bridge@lists.linux-foundation.org

On 5/19/17 5:20 PM, Xin Long wrote:
> Since commit 76b91c32dd86 ("bridge: stp: when using userspace stp stop
> kernel hello and hold timers"), bridge would not start hello_timer if
> stp_enabled is not KERNEL_STP when br_dev_open.
> 
> The problem is even if users set stp_enabled with KERNEL_STP later,
> the timer will still not be started. It causes that KERNEL_STP can
> not really work. Users have to re-ifup the bridge to avoid this.
> 
> This patch is to fix it by starting br->hello_timer when enabling
> KERNEL_STP in br_stp_start.
> 
> As an improvement, it's also to start hello_timer again only when
> br->stp_enabled is KERNEL_STP in br_hello_timer_expired, there is
> no reason to start the timer again when it's NO_STP.
> 
> Fixes: 76b91c32dd86 ("bridge: stp: when using userspace stp stop kernel hello and hold timers")
> Reported-by: Haidong Li <haili@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>   net/bridge/br_stp_if.c    | 1 +
>   net/bridge/br_stp_timer.c | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 08341d2..0db8102 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -179,6 +179,7 @@ static void br_stp_start(struct net_bridge *br)
>   		br_debug(br, "using kernel STP\n");
>   
>   		/* To start timers on any ports left in blocking */
> +		mod_timer(&br->hello_timer, jiffies + br->hello_time);
>   		br_port_state_selection(br);
>   	}
>   
> diff --git a/net/bridge/br_stp_timer.c b/net/bridge/br_stp_timer.c
> index c98b3e5..60b6fe2 100644
> --- a/net/bridge/br_stp_timer.c
> +++ b/net/bridge/br_stp_timer.c
> @@ -40,7 +40,7 @@ static void br_hello_timer_expired(unsigned long arg)
>   	if (br->dev->flags & IFF_UP) {
>   		br_config_bpdu_generation(br);
>   
> -		if (br->stp_enabled != BR_USER_STP)
> +		if (br->stp_enabled == BR_KERNEL_STP)
>   			mod_timer(&br->hello_timer,
>   				  round_jiffies(jiffies + br->hello_time));
>   	}
> 

+CC Bridge maintainers & fixes commit author

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

