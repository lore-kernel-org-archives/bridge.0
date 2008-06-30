Message-ID: <2e59e6970806301542t405646das78baa26f0cda8f6e@mail.gmail.com>
Date: Mon, 30 Jun 2008 22:42:51 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <486912e7.a6.3013.6700211@webmaildh6.aruba.it>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11801_9443948.1214865771444"
References: <486912e7.a6.3013.6700211@webmaildh6.aruba.it>
Subject: Re: [Bridge] 802.1q packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fulvio Ricciardi <fulvio.ricciardi@zeroshell.net>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@linuxfoundation.org

------=_Part_11801_9443948.1214865771444
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Jun 30, 2008 at 5:07 PM, Fulvio Ricciardi <
fulvio.ricciardi@zeroshell.net> wrote:

>
> >
> > That mostly rules out other devices in the path as the
> > cause of the problem.  There's just one chance of a
> > netfilter interaction that I can think of: netfilter may
> > cause fragments to be recombined, without netfilter the
> > fragments could be bridged.  Are you running the ping
> > command from the bridge itself, or across the bridge? (I
> > presume across the bridge because you are discussing the
> > FORWARD chain only)
>
> I ping across the bridge. If instead a ping from the bridge
> itself, all works right.
>
> >
> > Do the large ping requests show up in the iptables
> > counters?
>
> Yes, in any case (either ping -s 1472 and ping -s 1473) the
> packets are counted in the FORWARD chain.
>
> >
> > What happens if you set no fragmentation when you run
> > ping?
>
> it's the same


Just to verify, you mean that with no fragmentation, large pings go through
if and only if bridge-nf-call-iptables is disabled?

I would expect large pings to be dropped irregardless of the
bridge-nf-call-iptables option when the no fragmentation bit is set, based
on your scenario.


>
>
> Thanks
> Fulvio
>
> --------------------------------------------------------------------
> Fulvio Ricciardi
> web: http://www.zeroshell.net/eng/
> skype: zeroshellnet
> Phone: +3908321835630
>

------=_Part_11801_9443948.1214865771444
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Mon, Jun 30, 2008 at 5:07 PM, Fulvio Ricciardi &lt;<a href="mailto:fulvio.ricciardi@zeroshell.net">fulvio.ricciardi@zeroshell.net</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d"><br>
&gt;<br>
&gt; That mostly rules out other devices in the path as the<br>
&gt; cause of the problem. &nbsp;There&#39;s just one chance of a<br>
&gt; netfilter interaction that I can think of: netfilter may<br>
&gt; cause fragments to be recombined, without netfilter the<br>
&gt; fragments could be bridged. &nbsp;Are you running the ping<br>
&gt; command from the bridge itself, or across the bridge? (I<br>
&gt; presume across the bridge because you are discussing the<br>
&gt; FORWARD chain only)<br>
<br>
</div>I ping across the bridge. If instead a ping from the bridge<br>
itself, all works right.<br>
<div class="Ih2E3d"><br>
&gt;<br>
&gt; Do the large ping requests show up in the iptables<br>
&gt; counters?<br>
<br>
</div>Yes, in any case (either ping -s 1472 and ping -s 1473) the<br>
packets are counted in the FORWARD chain.<br>
<div class="Ih2E3d"><br>
&gt;<br>
&gt; What happens if you set no fragmentation when you run<br>
&gt; ping?<br>
<br>
</div>it&#39;s the same</blockquote><div><br>Just to verify, you mean that with no fragmentation, large pings go through if and only if bridge-nf-call-iptables is disabled?<br><br>I would expect large pings to be dropped irregardless of the bridge-nf-call-iptables option when the no fragmentation bit is set, based on your scenario.<br>
&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<div><div></div><div class="Wj3C7c"><br>
Thanks<br>
Fulvio<br>
<br>
--------------------------------------------------------------------<br>
Fulvio Ricciardi<br>
web: <a href="http://www.zeroshell.net/eng/" target="_blank">http://www.zeroshell.net/eng/</a><br>
skype: zeroshellnet<br>
Phone: +3908321835630<br>
</div></div></blockquote></div><br>

------=_Part_11801_9443948.1214865771444--
