Message-ID: <2e59e6970807222051i23e93797kc63688213f75a97a@mail.gmail.com>
Date: Wed, 23 Jul 2008 03:51:38 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <20080722145920.4a8e0cbe@extreme>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_73485_20765033.1216785098935"
References: <48861b90.378.7eff.1867149638@webmaildh6.aruba.it>
	<20080722193546.6b8b4567@polsl.pl> <20080722145920.4a8e0cbe@extreme>
Subject: Re: [Bridge] 802.1q packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Adam Osuchowski <Adam.Osuchowski@polsl.pl>, bridge@linuxfoundation.org

------=_Part_73485_20765033.1216785098935
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Jul 22, 2008 at 9:59 PM, Stephen Hemminger <shemminger@vyatta.com>
wrote:

> On Tue, 22 Jul 2008 21:35:46 +0200
> Adam Osuchowski <Adam.Osuchowski@polsl.pl> wrote:
>
> > Fulvio Ricciardi wrote:
> > > Thanks for the patch
> >
> > This patch has one shortcoming. Better version (with PPPoE support as
> well)
> > is here:
> >
> > https://lists.linux-foundation.org/pipermail/bridge/2007-May/005447.html
> >
> > > that I hope developers will include it in the vanilla Kernel
> > > as soon as possible.
> >
> > Don't be under the illusion that it will be done quickly (if at all).
> > I have been waiting for that since I reported bug.
> >
>
> Problem has been fixed since 2.6.17 (over 2 yrs ago).
> Look before you whine.


If I'm reading that thread correctly, it is a patch against 2.6.21 for a
problem encountered in 2.6.17 and later.


>
> ------------------------------------------------------
>
> commit 85ca719e5756d79ea0f10c469e3762462ac45e22
> Author: Stephen Hemminger <shemminger@osdl.org>
> Date:   Wed Apr 26 02:39:19 2006 -0700
>
>    [BRIDGE]: allow full size vlan packets
>
>    Need to allow for VLAN header when bridging.
>
>    Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
>    Signed-off-by: David S. Miller <davem@davemloft.net>
>
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index 2d24fb4..56f3aa4 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/netdevice.h>
>  #include <linux/skbuff.h>
> +#include <linux/if_vlan.h>
>  #include <linux/netfilter_bridge.h>
>  #include "br_private.h"
>
> @@ -29,10 +30,15 @@ static inline int should_deliver(const struct
> net_bridge_port *p,
>        return 1;
>  }
>
> +static inline unsigned packet_length(const struct sk_buff *skb)
> +{
> +       return skb->len - (skb->protocol == htons(ETH_P_8021Q) ? VLAN_HLEN
> : 0);
> +}
> +
>  int br_dev_queue_push_xmit(struct sk_buff *skb)
>  {
>        /* drop mtu oversized packets except tso */
> -       if (skb->len > skb->dev->mtu && !skb_shinfo(skb)->tso_size)
> +       if (packet_length(skb) > skb->dev->mtu &&
> !skb_shinfo(skb)->tso_size)
>                kfree_skb(skb);
>        else {
>  #ifdef CONFIG_BRIDGE_NETFILTER
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

------=_Part_73485_20765033.1216785098935
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><br><br><div class="gmail_quote">On Tue, Jul 22, 2008 at 9:59 PM, Stephen Hemminger &lt;<a href="mailto:shemminger@vyatta.com">shemminger@vyatta.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Tue, 22 Jul 2008 21:35:46 +0200<br>
Adam Osuchowski &lt;Adam.Osuchowski@polsl.pl&gt; wrote:<br>
<br>
&gt; Fulvio Ricciardi wrote:<br>
&gt; &gt; Thanks for the patch<br>
&gt;<br>
&gt; This patch has one shortcoming. Better version (with PPPoE support as well)<br>
&gt; is here:<br>
&gt;<br>
&gt; <a href="https://lists.linux-foundation.org/pipermail/bridge/2007-May/005447.html" target="_blank">https://lists.linux-foundation.org/pipermail/bridge/2007-May/005447.html</a><br>
&gt;<br>
&gt; &gt; that I hope developers will include it in the vanilla Kernel<br>
&gt; &gt; as soon as possible.<br>
&gt;<br>
&gt; Don&#39;t be under the illusion that it will be done quickly (if at all).<br>
&gt; I have been waiting for that since I reported bug.<br>
&gt;<br>
<br>
</div>Problem has been fixed since 2.6.17 (over 2 yrs ago).<br>
Look before you whine.</blockquote><div><br>If I&#39;m reading that thread correctly, it is a patch against 2.6.21 for a problem encountered in 2.6.17 and later.<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
------------------------------------------------------<br>
<br>
commit 85ca719e5756d79ea0f10c469e3762462ac45e22<br>
Author: Stephen Hemminger &lt;<a href="mailto:shemminger@osdl.org">shemminger@osdl.org</a>&gt;<br>
Date: &nbsp; Wed Apr 26 02:39:19 2006 -0700<br>
<br>
 &nbsp; &nbsp;[BRIDGE]: allow full size vlan packets<br>
<br>
 &nbsp; &nbsp;Need to allow for VLAN header when bridging.<br>
<br>
 &nbsp; &nbsp;Signed-off-by: Stephen Hemminger &lt;<a href="mailto:shemminger@osdl.org">shemminger@osdl.org</a>&gt;<br>
 &nbsp; &nbsp;Signed-off-by: David S. Miller &lt;<a href="mailto:davem@davemloft.net">davem@davemloft.net</a>&gt;<br>
<br>
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c<br>
index 2d24fb4..56f3aa4 100644<br>
--- a/net/bridge/br_forward.c<br>
+++ b/net/bridge/br_forward.c<br>
@@ -16,6 +16,7 @@<br>
&nbsp;#include &lt;linux/kernel.h&gt;<br>
&nbsp;#include &lt;linux/netdevice.h&gt;<br>
&nbsp;#include &lt;linux/skbuff.h&gt;<br>
+#include &lt;linux/if_vlan.h&gt;<br>
&nbsp;#include &lt;linux/netfilter_bridge.h&gt;<br>
&nbsp;#include &quot;br_private.h&quot;<br>
<br>
@@ -29,10 +30,15 @@ static inline int should_deliver(const struct net_bridge_port *p,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;return 1;<br>
&nbsp;}<br>
<br>
+static inline unsigned packet_length(const struct sk_buff *skb)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; return skb-&gt;len - (skb-&gt;protocol == htons(ETH_P_8021Q) ? VLAN_HLEN : 0);<br>
+}<br>
+<br>
&nbsp;int br_dev_queue_push_xmit(struct sk_buff *skb)<br>
&nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* drop mtu oversized packets except tso */<br>
- &nbsp; &nbsp; &nbsp; if (skb-&gt;len &gt; skb-&gt;dev-&gt;mtu &amp;&amp; !skb_shinfo(skb)-&gt;tso_size)<br>
+ &nbsp; &nbsp; &nbsp; if (packet_length(skb) &gt; skb-&gt;dev-&gt;mtu &amp;&amp; !skb_shinfo(skb)-&gt;tso_size)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;kfree_skb(skb);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;else {<br>
&nbsp;#ifdef CONFIG_BRIDGE_NETFILTER<br>
<div><div></div><div class="Wj3C7c"><br>
_______________________________________________<br>
Bridge mailing list<br>
<a href="mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-foundation.org</a><br>
<a href="https://lists.linux-foundation.org/mailman/listinfo/bridge" target="_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a><br>
</div></div></blockquote></div><br></div>

------=_Part_73485_20765033.1216785098935--
