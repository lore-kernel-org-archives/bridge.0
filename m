Date: Wed, 20 Jan 2010 09:54:53 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100120095453.09546783@nehalam>
In-Reply-To: <4B572FCA.8080905@kpi.ua>
References: <20100119214451.72637a94rn0biysz@mx.kpi.ua>
	<4B572FCA.8080905@kpi.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Re :Re: Re :Re: Re :Re: Bridging LACP (802.3ad)	frames
 not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Yavetskiy Yuriy <yavetskiy@kpi.ua>
Cc: bridge@lists.linux-foundation.org

On Wed, 20 Jan 2010 18:31:06 +0200
Yavetskiy Yuriy <yavetskiy@kpi.ua> wrote:

> Hello.
> 
> I solve my problem without ebtables.
> Just add to net/bridge/br_input.c next strings (with +):
> 
>         if (unlikely(is_link_local(dest))) {
>                 /* Pause frames shouldn't be passed up by driver anyway */
>                 if (skb->protocol == htons(ETH_P_PAUSE))
>                         goto drop;
> 
> +                /* Don't touch SLOW frames (LACP, etc.) */
> +               if (skb->protocol == htons(ETH_P_SLOW))
> +                        goto forward;
> 

Fine for your case, but in general it is wrong to forward these
frames. 


-- 
