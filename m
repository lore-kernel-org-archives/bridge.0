Date: Fri, 1 Dec 2006 22:34:25 -0800 (PST)
From: kasra kangavari <kasra_kng@yahoo.com>
In-Reply-To: <mailman.5.1165003201.29949.bridge@lists.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1070106378-1165041265=:33495"
Message-ID: <361445.33495.qm@web54209.mail.yahoo.com>
Subject: Re: [Bridge] Bridge Digest, Vol 40, Issue 1
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

--0-1070106378-1165041265=:33495
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Dear Fulvio
 
 I wanna know if your linux box ethernets are 1000 or 100 ?
and are you sure about kernels < 2.6.15 that large tagged packets correctly forward ?
 
 Regards
 KasrA
bridge-request@lists.osdl.org wrote: Send Bridge mailing list submissions to
 bridge@lists.osdl.org

To subscribe or unsubscribe via the World Wide Web, visit
 https://lists.osdl.org/mailman/listinfo/bridge
or, via email, send a message with subject or body 'help' to
 bridge-request@lists.osdl.org

You can reach the person managing the list at
 bridge-owner@lists.osdl.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Bridge digest..."


Today's Topics:

   1. Passing vlan tagged packets through linux bridge
      (Fulvio Ricciardi)
   2. Re: Passing vlan tagged packets through linux bridge
      (Stephen Hemminger)


----------------------------------------------------------------------

Message: 1
Date: Fri, 01 Dec 2006 18:09:14 +0100
From: "Fulvio Ricciardi" 
Subject: [Bridge] Passing vlan tagged packets through linux bridge
To: bridge@lists.osdl.org
Message-ID: <457061ba.3a6.7c77.1170958095@webmailh3.aruba.it>
Content-Type: text/plain; charset="iso-8859-1"

> Use an Intel pro/100 or pro/1000 driver..they are known to
> work with VLANs.
> 
> I guess it's also possible that it's a problem in the
> bridging code, so  try the latest kernel
> as well...

I compiled the latest 2.6.19 kernel and tested it with two
3COM 3c905c fast ethernet interfaces which work fine with
vlan 802.1q tagging, but when I have added the eth0 and eth1
to br0 the bridge doesn't forward tagged packets larger than
1472 bytes. I remember that with older kernels (<2.6.15)
large tagged packets was forwarded. 
What is the problem? Any chance to have a patch?
Thanks in advance for your answers.
 Best Regards
   Fulvio Ricciardi

--------------------------------------------------------------------
Fulvio Ricciardi
web: http://www.zeroshell.net/eng/
skype: zeroshellnet
Phone: +3908321835630


------------------------------

Message: 2
Date: Fri, 1 Dec 2006 10:29:24 -0800
From: Stephen Hemminger 
Subject: Re: [Bridge] Passing vlan tagged packets through linux bridge
To: fulvio.ricciardi@zeroshell.net
Cc: bridge@lists.osdl.org
Message-ID: <20061201102924.7e1045d2@freekitty>
Content-Type: text/plain; charset=US-ASCII

On Fri, 01 Dec 2006 18:09:14 +0100
"Fulvio Ricciardi"  wrote:

> > Use an Intel pro/100 or pro/1000 driver..they are known to
> > work with VLANs.
> > 
> > I guess it's also possible that it's a problem in the
> > bridging code, so  try the latest kernel
> > as well...
> 
> I compiled the latest 2.6.19 kernel and tested it with two
> 3COM 3c905c fast ethernet interfaces which work fine with
> vlan 802.1q tagging, but when I have added the eth0 and eth1
> to br0 the bridge doesn't forward tagged packets larger than
> 1472 bytes. I remember that with older kernels (<2.6.15)
> large tagged packets was forwarded. 
> What is the problem? Any chance to have a patch?
> Thanks in advance for your answers.
>  Best Regards
>    Fulvio Ricciardi
> 


This code might be dropping it, but don't see why because it
is already checking for VLAN

net/bridge/br_forward.c

static inline unsigned packet_length(const struct sk_buff *skb)
{
 return skb->len - (skb->protocol == htons(ETH_P_8021Q) ? VLAN_HLEN : 0);
}

int br_dev_queue_push_xmit(struct sk_buff *skb)
{
 /* drop mtu oversized packets except gso */
 if (packet_length(skb) > skb->dev->mtu && !skb_is_gso(skb))
  kfree_skb(skb);

-- 
Stephen Hemminger 


------------------------------

_______________________________________________
Bridge mailing list
Bridge@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/bridge


End of Bridge Digest, Vol 40, Issue 1
*************************************


 
---------------------------------
Need a quick answer? Get one in minutes from people who know. Ask your question on Yahoo! Answers.
--0-1070106378-1165041265=:33495
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Dear Fulvio<br> <br> I wanna know if your linux box ethernets are 1000 or 100 ?<br>and are you sure about kernels &lt; 2.6.15 that large tagged packets correctly forward ?<br> <br> Regards<br> KasrA<br><b><i>bridge-request@lists.osdl.org</i></b> wrote:<blockquote class="replbq" DEFANGED_style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Send Bridge mailing list submissions to<br> bridge@lists.osdl.org<br><br>To subscribe or unsubscribe via the World Wide Web, visit<br> https://lists.osdl.org/mailman/listinfo/bridge<br>or, via email, send a message with subject or body 'help' to<br> bridge-request@lists.osdl.org<br><br>You can reach the person managing the list at<br> bridge-owner@lists.osdl.org<br><br>When replying, please edit your Subject line so it is more specific<br>than "Re: Contents of Bridge digest..."<br><br><br>Today's Topics:<br><br>   1. Passing vlan tagged packets through linux bridge<br>      (Fulvio Ricciardi)<br>   2. Re: Passing
 vlan tagged packets through linux bridge<br>      (Stephen Hemminger)<br><br><br>----------------------------------------------------------------------<br><br>Message: 1<br>Date: Fri, 01 Dec 2006 18:09:14 +0100<br>From: "Fulvio Ricciardi" <fulvio.ricciardi @zeroshell.net=""><br>Subject: [Bridge] Passing vlan tagged packets through linux bridge<br>To: bridge@lists.osdl.org<br>Message-ID: &lt;457061ba.3a6.7c77.1170958095@webmailh3.aruba.it&gt;<br>Content-Type: text/plain; charset="iso-8859-1"<br><br>&gt; Use an Intel pro/100 or pro/1000 driver..they are known to<br>&gt; work with VLANs.<br>&gt; <br>&gt; I guess it's also possible that it's a problem in the<br>&gt; bridging code, so  try the latest kernel<br>&gt; as well...<br><br>I compiled the latest 2.6.19 kernel and tested it with two<br>3COM 3c905c fast ethernet interfaces which work fine with<br>vlan 802.1q tagging, but when I have added the eth0 and eth1<br>to br0 the bridge doesn't forward tagged packets larger
 than<br>1472 bytes. I remember that with older kernels (&lt;2.6.15)<br>large tagged packets was forwarded. <br>What is the problem? Any chance to have a patch?<br>Thanks in advance for your answers.<br> Best Regards<br>   Fulvio Ricciardi<br><br>--------------------------------------------------------------------<br>Fulvio Ricciardi<br>web: http://www.zeroshell.net/eng/<br>skype: zeroshellnet<br>Phone: +3908321835630<br><br><br>------------------------------<br><br>Message: 2<br>Date: Fri, 1 Dec 2006 10:29:24 -0800<br>From: Stephen Hemminger <DEFANGED_shemminger @osdl.org=""><br>Subject: Re: [Bridge] Passing vlan tagged packets through linux bridge<br>To: fulvio.ricciardi@zeroshell.net<br>Cc: bridge@lists.osdl.org<br>Message-ID: &lt;20061201102924.7e1045d2@freekitty&gt;<br>Content-Type: text/plain; charset=US-ASCII<br><br>On Fri, 01 Dec 2006 18:09:14 +0100<br>"Fulvio Ricciardi" <fulvio.ricciardi @zeroshell.net=""> wrote:<br><br>&gt; &gt; Use an Intel pro/100 or pro/1000
 driver..they are known to<br>&gt; &gt; work with VLANs.<br>&gt; &gt; <br>&gt; &gt; I guess it's also possible that it's a problem in the<br>&gt; &gt; bridging code, so  try the latest kernel<br>&gt; &gt; as well...<br>&gt; <br>&gt; I compiled the latest 2.6.19 kernel and tested it with two<br>&gt; 3COM 3c905c fast ethernet interfaces which work fine with<br>&gt; vlan 802.1q tagging, but when I have added the eth0 and eth1<br>&gt; to br0 the bridge doesn't forward tagged packets larger than<br>&gt; 1472 bytes. I remember that with older kernels (&lt;2.6.15)<br>&gt; large tagged packets was forwarded. <br>&gt; What is the problem? Any chance to have a patch?<br>&gt; Thanks in advance for your answers.<br>&gt;  Best Regards<br>&gt;    Fulvio Ricciardi<br>&gt; <br><br><br>This code might be dropping it, but don't see why because it<br>is already checking for VLAN<br><br>net/bridge/br_forward.c<br><br>static inline unsigned packet_length(const struct sk_buff *skb)<br>{<br>
 return skb-&gt;len - (skb-&gt;protocol == htons(ETH_P_8021Q) ? VLAN_HLEN : 0);<br>}<br><br>int br_dev_queue_push_xmit(struct sk_buff *skb)<br>{<br> /* drop mtu oversized packets except gso */<br> if (packet_length(skb) &gt; skb-&gt;dev-&gt;mtu &amp;&amp; !skb_is_gso(skb))<br>  kfree_skb(skb);<br><br>-- <br>Stephen Hemminger <DEFANGED_shemminger @osdl.org=""><br><br><br>------------------------------<br><br>_______________________________________________<br>Bridge mailing list<br>Bridge@lists.osdl.org<br>https://lists.osdl.org/mailman/listinfo/bridge<br><br><br>End of Bridge Digest, Vol 40, Issue 1<br>*************************************<br></DEFANGED_shemminger></fulvio.ricciardi></DEFANGED_shemminger></fulvio.ricciardi></blockquote><br><p>&#32;

<hr size=1>Need a quick answer? Get one in minutes from people who know. Ask your question on
 <a href="http://answers.yahoo.com/;_ylc=X3oDMTFvbGNhMGE3BF9TAzM5NjU0NTEwOARfcwMzOTY1NDUxMDMEc2VjA21haWxfdGFnbGluZQRzbGsDbWFpbF90YWcx">Yahoo! Answers</a>.
--0-1070106378-1165041265=:33495--
