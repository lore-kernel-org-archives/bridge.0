Date: Thu, 20 Aug 2009 09:25:10 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090820092510.20609ed5@nehalam>
In-Reply-To: <f0a957c30908191856x75df858bybfbdac23ad5a01e@mail.gmail.com>
References: <f0a957c30908191856x75df858bybfbdac23ad5a01e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] SPT functions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Gustavo Martin <gu.martinm@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Thu, 20 Aug 2009 03:56:16 +0200
Gustavo Martin <gu.martinm@gmail.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
>      First, sorry for my english. I have to get better it.
>      I am trying to develop a new protocol for the linux kernel 2.6.26
> similar to RSTP by my free time. Because of it I am searching the bridging
> code. I began from the function netif_receive_skb (I don't need to know
> anything about the hardware or the interruptions) looking for the first
> functions connected with the spanning tree protocol implementation.
>      I found this:
> 
> 1- The function netif_receive_skb calls to:  skb = handle_bridge(skb,
> &amp;pt_prev, &amp;ret, orig_dev)
> 2- In handle_bridge(skb, &amp;pt_prev, &amp;ret, orig_dev) I found: return
> br_handle_frame_hook(port, skb)
> 3- In br_handle_frame I found:  if (NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb,
> skb->dev, NULL, br_handle_local_finish))
> 4- In br_handle_local_finish I didn't find anything.
> 
>      I have been reading the book "Understanding Linux Network Internals
> (2005)" but this book (I think) is for the kernel 2.6.16. In this book the
> author speaks about the function br_stp_handle_bpdu. With the kernel 2.6.26
> in spite of that function you can find br_handle_local_finish.
> 
>      I continued searching in netif_receive_skb. In this function after the
> call to handle_bridge I found this code:
> 
> 2016       skb = handle_bridge(skb, &amp;pt_prev, &amp;ret, orig_dev);
> 2107        if (!skb)
> 2108                goto out;
> 2109        skb = handle_macvlan(skb, &amp;pt_prev, &amp;ret, orig_dev);
> 2110        if (!skb)
> 2111                goto out;
> 2112
> 2113        type = skb->protocol;
> 2114        list_for_each_entry_rcu(ptype,
> 2115                        &amp;ptype_base[ntohs(type) &amp;
> PTYPE_HASH_MASK], list) {
> 2116                if (ptype->type == type &amp;&amp;
> 2117                    (!ptype->dev || ptype->dev == skb->dev)) {
> 2118                        if (pt_prev)
> 2119                                ret = deliver_skb(skb, pt_prev,
> orig_dev);
> 2120                        pt_prev = ptype;
> 2121                }
> 2122        }
> 2123
> 2124        if (pt_prev) {
> 2125                ret = pt_prev->func(skb, skb->dev, pt_prev, orig_dev);
> 2126        } else {
> 2127                kfree_skb(skb);
> 2128                /* Jamal, now you will not able to escape explaining
> 2129                 * me how you were going to use this. :-)
> 2130                 */
> 2131                ret = NET_RX_DROP;
> 2132        }
> 
> 
>      My question (probably stupid question, sorry but this is my first time
> with the linux kernel) is:  Where connect the SPANING TREE PROTOCOL
> functions with the bridging code?

net/bridge/br_stp_*.c

You might be better off looking at the RSTP code in user space.
See:
   http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;a=summary

To get:
   git clone git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git

