Message-ID: <4B572FCA.8080905@kpi.ua>
Date: Wed, 20 Jan 2010 18:31:06 +0200
From: Yavetskiy Yuriy <yavetskiy@kpi.ua>
MIME-Version: 1.0
References: <20100119214451.72637a94rn0biysz@mx.kpi.ua>
In-Reply-To: <20100119214451.72637a94rn0biysz@mx.kpi.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: bridge@lists.linux-foundation.org

Hello.

I solve my problem without ebtables.
Just add to net/bridge/br_input.c next strings (with +):

        if (unlikely(is_link_local(dest))) {
                /* Pause frames shouldn't be passed up by driver anyway */
                if (skb->protocol == htons(ETH_P_PAUSE))
                        goto drop;

+                /* Don't touch SLOW frames (LACP, etc.) */
+               if (skb->protocol == htons(ETH_P_SLOW))
+                        goto forward;

                /* If STP is turned off, then forward */
                if (p->br->stp_enabled == BR_NO_STP && dest[5] == 0)
                        goto forward;

                if (NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, skb->dev,
                            NULL, br_handle_local_finish))
                        return NULL;    /* frame consumed by filter */
                else
                        return skb;     /* continue processing */
        }

and after I've compiled it to kernel 802.3ad frames became pass through 
linux bridge.


yavetskiy@kpi.ua wrote:
> Hello.
>
> I have the same problem with bridging 802.3ad frames.
>
> But rules:
> ebtables -A INPUT -p 0x8809 -j ACCEPT
> ebtables -A FORWARD -p 0x8809 -j ACCEPT
> are not enough to solve this problem, it still doesn't work for me.
> I have vanila kernel 2.6.32 with no patches, Debian squeeze, eth1 and  
> eth2 interfaces in bridge with stp disabled.
> Maybe I've missed something? Do you have any ideas?
> Thank you.
>
>
> --
> WBR
> Yavetkiy Yuriy
>
> ----------------------------------------------------------------
> This message was sent using IMP, the Internet Messaging Program.
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>   


-- 
WBR
Yavetskiy Yuriy
ULTI-RIPE

