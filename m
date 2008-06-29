Message-ID: <2e59e6970806281708g27565670i424515b7d13704ca@mail.gmail.com>
Date: Sat, 28 Jun 2008 19:08:28 -0500
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <4866aa6f.27b.64f3.364538521@webmaildh1.aruba.it>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4000_12893261.1214698108986"
References: <4866aa6f.27b.64f3.364538521@webmaildh1.aruba.it>
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

------=_Part_4000_12893261.1214698108986
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Jun 28, 2008 at 4:17 PM, Fulvio Ricciardi <
fulvio.ricciardi@zeroshell.net> wrote:

>
> > > > > > Hi,
> > > > > >
> > > > > > I notice that with the Kernel 2.6.25.9 the 802.1q
> > > > > > VLAN tagged packets larger than 1470 bytes are not
> > > > > > forwarded at all by a bridge.
> > > > > > I think there is a bad interaction between bridge
> > > > > > and netfilter codes. Any chance to a have a patch
> > > > > > to solve this problem that limit the possibility
> > > > > > to use the Linux bridges in a environment with
> > > > VLANs? >
> > > > > With the following command it works:
> > > > >
> > > > > echo 0 >
> > > > /proc/sys/net/bridge/bridge-nf-call-iptables >
> > > > > but this disable the iptables support that it's
> > > > > important for obtaining complex bridge-firewall
> > > > > scenarios.
> > > > > Regards
> > > > > Fulvio Ricciardi
> > > >
> > > > Your iptables need to know about VLAN's as well.
> > > > I bet your default action is to DROP.
> > > >
> > > No, the default policy is ACCEPT for the FORWARD chain.
> > > In any case the problem takes place only with large
> > > packets. For example if I try
> > >
> > > ping -s 1472 192.168.99.74
> > >
> > > it works, but
> > >
> > > ping -s 1473 192.168.99.74
> > >
> > > it does not.
> > > I am sure that the network cards are VLAN 802.1q aware
> > > because only the forwarding process is broken. If
> > > instead I just ping the IP of the bridge interface it
> > works fine.
> >
> >
> > Are the other nodes directly connected to the netfilter
> > bridge, or are there ethernet switches involved?   Are
> > these switches managed, smart, or dumb? Are jumbo frames
> > enabled on all devices in the path?
> >
>
>
> One host is directly connected with a cross cable to the
> bridge and the other one with an unmanaged switch that works
> fine because if I issue the command
>
> echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables
>
> to disable the Netfilter action for the bridge there is no
> problem for the large packets on VLAN.


That mostly rules out other devices in the path as the cause of the
problem.  There's just one chance of a netfilter interaction that I can
think of: netfilter may cause fragments to be recombined, without netfilter
the fragments could be bridged.  Are you running the ping command from the
bridge itself, or across the bridge? (I presume across the bridge because
you are discussing the FORWARD chain only)

Do the large ping requests show up in the iptables counters?

What happens if you set no fragmentation when you run ping?


>
>
>
> --------------------------------------------------------------------
> Fulvio Ricciardi
> web: http://www.zeroshell.net/eng/
> skype: zeroshellnet
> Phone: +3908321835630
>

------=_Part_4000_12893261.1214698108986
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Sat, Jun 28, 2008 at 4:17 PM, Fulvio Ricciardi &lt;<a href="mailto:fulvio.ricciardi@zeroshell.net">fulvio.ricciardi@zeroshell.net</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class="Wj3C7c"><br>
&gt; &gt; &gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; I notice that with the Kernel <a href="http://2.6.25.9" target="_blank">2.6.25.9</a> the 802.1q<br>
&gt; &gt; &gt; &gt; &gt; VLAN tagged packets larger than 1470 bytes are not<br>
&gt; &gt; &gt; &gt; &gt; forwarded at all by a bridge.<br>
&gt; &gt; &gt; &gt; &gt; I think there is a bad interaction between bridge<br>
&gt; &gt; &gt; &gt; &gt; and netfilter codes. Any chance to a have a patch<br>
&gt; &gt; &gt; &gt; &gt; to solve this problem that limit the possibility<br>
&gt; &gt; &gt; &gt; &gt; to use the Linux bridges in a environment with<br>
&gt; &gt; &gt; VLANs? &gt;<br>
&gt; &gt; &gt; &gt; With the following command it works:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; echo 0 &gt;<br>
&gt; &gt; &gt; /proc/sys/net/bridge/bridge-nf-call-iptables &gt;<br>
&gt; &gt; &gt; &gt; but this disable the iptables support that it&#39;s<br>
&gt; &gt; &gt; &gt; important for obtaining complex bridge-firewall<br>
&gt; &gt; &gt; &gt; scenarios.<br>
&gt; &gt; &gt; &gt; Regards<br>
&gt; &gt; &gt; &gt; Fulvio Ricciardi<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Your iptables need to know about VLAN&#39;s as well.<br>
&gt; &gt; &gt; I bet your default action is to DROP.<br>
&gt; &gt; &gt;<br>
&gt; &gt; No, the default policy is ACCEPT for the FORWARD chain.<br>
&gt; &gt; In any case the problem takes place only with large<br>
&gt; &gt; packets. For example if I try<br>
&gt; &gt;<br>
&gt; &gt; ping -s 1472 <a href="http://192.168.99.74" target="_blank">192.168.99.74</a><br>
&gt; &gt;<br>
&gt; &gt; it works, but<br>
&gt; &gt;<br>
&gt; &gt; ping -s 1473 <a href="http://192.168.99.74" target="_blank">192.168.99.74</a><br>
&gt; &gt;<br>
&gt; &gt; it does not.<br>
&gt; &gt; I am sure that the network cards are VLAN 802.1q aware<br>
&gt; &gt; because only the forwarding process is broken. If<br>
&gt; &gt; instead I just ping the IP of the bridge interface it<br>
&gt; works fine.<br>
&gt;<br>
&gt;<br>
&gt; Are the other nodes directly connected to the netfilter<br>
&gt; bridge, or are there ethernet switches involved? &nbsp; Are<br>
&gt; these switches managed, smart, or dumb? Are jumbo frames<br>
&gt; enabled on all devices in the path?<br>
&gt;<br>
<br>
<br>
</div></div>One host is directly connected with a cross cable to the<br>
bridge and the other one with an unmanaged switch that works<br>
fine because if I issue the command<br>
<div class="Ih2E3d"><br>
echo 0 &gt; /proc/sys/net/bridge/bridge-nf-call-iptables<br>
<br>
</div>to disable the Netfilter action for the bridge there is no<br>
problem for the large packets on VLAN.</blockquote><div><br>That mostly rules out other devices in the path as the cause of the problem.&nbsp; There&#39;s just one chance of a netfilter interaction that I can think of: netfilter may cause fragments to be recombined, without netfilter the fragments could be bridged.&nbsp; Are you running the ping command from the bridge itself, or across the bridge? (I presume across the bridge because you are discussing the FORWARD chain only)<br>
&nbsp;<br>Do the large ping requests show up in the iptables counters?<br><br>What happens if you set no fragmentation when you run ping?<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
<div><div></div><div class="Wj3C7c"><br>
<br>
<br>
--------------------------------------------------------------------<br>
Fulvio Ricciardi<br>
web: <a href="http://www.zeroshell.net/eng/" target="_blank">http://www.zeroshell.net/eng/</a><br>
skype: zeroshellnet<br>
Phone: +3908321835630<br>
</div></div></blockquote></div><br>

------=_Part_4000_12893261.1214698108986--
