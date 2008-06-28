Message-ID: <2e59e6970806281406q326adfb5n9a509821454f55f2@mail.gmail.com>
Date: Sat, 28 Jun 2008 16:06:00 -0500
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <48669609.123.61e8.180046555@webmaildh2.aruba.it>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3799_28785095.1214687160419"
References: <48669609.123.61e8.180046555@webmaildh2.aruba.it>
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

------=_Part_3799_28785095.1214687160419
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Jun 28, 2008 at 2:50 PM, Fulvio Ricciardi <
fulvio.ricciardi@zeroshell.net> wrote:

>
> > > > Hi,
> > > >
> > > > I notice that with the Kernel 2.6.25.9 the 802.1q VLAN
> > > > tagged packets larger than 1470 bytes are not
> > > > forwarded at all by a bridge.
> > > > I think there is a bad interaction between bridge and
> > > > netfilter codes. Any chance to a have a patch to solve
> > > > this problem that limit the possibility to use the
> > > > Linux bridges in a environment with VLANs?
> > >
> > > With the following command it works:
> > >
> > > echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables
> > >
> > > but this disable the iptables support that it's
> > > important for obtaining complex bridge-firewall
> > > scenarios.
> > > Regards
> > > Fulvio Ricciardi
> >
> > Your iptables need to know about VLAN's as well.
> > I bet your default action is to DROP.
> >
> No, the default policy is ACCEPT for the FORWARD chain. In
> any case the problem takes place only with large packets.
> For example if I try
>
> ping -s 1472 192.168.99.74
>
> it works, but
>
> ping -s 1473 192.168.99.74
>
> it does not.
> I am sure that the network cards are VLAN 802.1q aware
> because only the forwarding process is broken. If instead I
> just ping the IP of the bridge interface it works fine.


Are the other nodes directly connected to the netfilter bridge, or are there
ethernet switches involved?   Are these switches managed, smart, or dumb?
Are jumbo frames enabled on all devices in the path?


>
>
> Regards
> Fulvio
>
> --------------------------------------------------------------------
> Fulvio Ricciardi
> web: http://www.zeroshell.net/eng/
> skype: zeroshellnet
> Phone: +3908321835630
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

------=_Part_3799_28785095.1214687160419
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Sat, Jun 28, 2008 at 2:50 PM, Fulvio Ricciardi &lt;<a href="mailto:fulvio.ricciardi@zeroshell.net">fulvio.ricciardi@zeroshell.net</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d"><br>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I notice that with the Kernel <a href="http://2.6.25.9" target="_blank">2.6.25.9</a> the 802.1q VLAN<br>
&gt; &gt; &gt; tagged packets larger than 1470 bytes are not<br>
&gt; &gt; &gt; forwarded at all by a bridge.<br>
&gt; &gt; &gt; I think there is a bad interaction between bridge and<br>
&gt; &gt; &gt; netfilter codes. Any chance to a have a patch to solve<br>
&gt; &gt; &gt; this problem that limit the possibility to use the<br>
&gt; &gt; &gt; Linux bridges in a environment with VLANs?<br>
&gt; &gt;<br>
&gt; &gt; With the following command it works:<br>
&gt; &gt;<br>
&gt; &gt; echo 0 &gt; /proc/sys/net/bridge/bridge-nf-call-iptables<br>
&gt; &gt;<br>
&gt; &gt; but this disable the iptables support that it&#39;s<br>
&gt; &gt; important for obtaining complex bridge-firewall<br>
&gt; &gt; scenarios.<br>
&gt; &gt; Regards<br>
&gt; &gt; Fulvio Ricciardi<br>
&gt;<br>
&gt; Your iptables need to know about VLAN&#39;s as well.<br>
&gt; I bet your default action is to DROP.<br>
&gt;<br>
</div>No, the default policy is ACCEPT for the FORWARD chain. In<br>
any case the problem takes place only with large packets.<br>
For example if I try<br>
<br>
ping -s 1472 <a href="http://192.168.99.74" target="_blank">192.168.99.74</a><br>
<br>
it works, but<br>
<br>
ping -s 1473 <a href="http://192.168.99.74" target="_blank">192.168.99.74</a><br>
<br>
it does not.<br>
I am sure that the network cards are VLAN 802.1q aware<br>
because only the forwarding process is broken. If instead I<br>
just ping the IP of the bridge interface it works fine.</blockquote><div><br>Are the other nodes directly connected to the netfilter bridge, or are there ethernet switches involved?&nbsp;&nbsp; Are these switches managed, smart, or dumb?&nbsp; Are jumbo frames enabled on all devices in the path?<br>
&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
Regards<br>
<font color="#888888">Fulvio<br>
</font><div class="Ih2E3d"><br>
--------------------------------------------------------------------<br>
Fulvio Ricciardi<br>
web: <a href="http://www.zeroshell.net/eng/" target="_blank">http://www.zeroshell.net/eng/</a><br>
skype: zeroshellnet<br>
Phone: +3908321835630<br>
_______________________________________________<br>
</div><div><div></div><div class="Wj3C7c">Bridge mailing list<br>
<a href="mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-foundation.org</a><br>
<a href="https://lists.linux-foundation.org/mailman/listinfo/bridge" target="_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a><br>
</div></div></blockquote></div><br>

------=_Part_3799_28785095.1214687160419--
