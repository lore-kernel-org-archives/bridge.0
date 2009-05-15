From: Ian Campbell <Ian.Campbell@eu.citrix.com>
In-Reply-To: <20090514083523.643b640b@nehalam>
References: <1242298904-31325-1-git-send-email-ian.campbell@citrix.com>
	<20090514083523.643b640b@nehalam>
Content-Type: text/plain
Date: Fri, 15 May 2009 10:34:40 +0100
Message-ID: <1242380080.4341.91.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] BRIDGE: Do not suppress FDB learning after
	topology	change when forward_delay is 0.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Thu, 2009-05-14 at 11:35 -0400, Stephen Hemminger wrote:
> Unless STP is enabled, br_topology_change is bogus.  It looks like,
> the following would avoid the problem?

Yes, it does and it looks like a much better fix to me. 

Thanks, Ian.

> 
> --- a/net/bridge/br_stp.c	2009-05-14 08:33:01.795909321 -0700
> +++ b/net/bridge/br_stp.c	2009-05-14 08:34:32.839883992 -0700
> @@ -375,7 +375,8 @@ static void br_make_forwarding(struct ne
>  
>  	if (br->forward_delay == 0) {
>  		p->state = BR_STATE_FORWARDING;
> -		br_topology_change_detection(br);
> +		if (p->br->stp_enable == BR_KERNEL_STP)
> +			br_topology_change_detection(br);
>  		del_timer(&p->forward_delay_timer);
>  	}
>  	else if (p->br->stp_enabled == BR_KERNEL_STP)
> 
> 

