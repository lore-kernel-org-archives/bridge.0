Message-ID: <49002b820611181042s9405a3ag8a27932b1893197c@mail.gmail.com>
Date: Sun, 19 Nov 2006 02:42:29 +0800
From: "d tbsky" <tbskyd@gmail.com>
In-Reply-To: <915136920611180514q663e65d1oec82391ed3fac700@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_32042_9620648.1163875349838"
References: <49002b820611170149n645e35e6n76edc98fe6c9596@mail.gmail.com>
	<915136920611180514q663e65d1oec82391ed3fac700@mail.gmail.com>
Subject: Re: [Bridge] bridge physical to several dummy interface
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

------=_Part_32042_9620648.1163875349838
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi:
  what i want to do is like this:
http://www.linux.it/~rubini/docs/vinter/vinter.html
  i saw some people like me want to try bridge:
  http://kerneltrap.org/node/6523
  there seems no good way to do..

Regards,
tbskyd


2006/11/18, Abel Mart=EDn <abel.martin.ruiz@gmail.com>:
>
> On 11/17/06, d tbsky <tbskyd@gmail.com> wrote:
> > Hi:
> >     i want to bridge my eth0 interface to several dummy interface, like
> > vmware or xen did,
> > so i can request several dhcp ip address via several mac addresses.
> >    but i am stuck in the first step:
> >    assume my eth0 is 192.168.10.1, and it can ping 192.168.10.254.
> >     ifconfig br0 up
> >     brctl setfd br0 0
> >     brctl addif br0 eth0
> >
> >     now i can not ping 192.168.10.254 anymore.
> You might be having a routing problem. Check your routing table with ip
> route.
> >     but if i set 192.168.10.2 to br0, i can ping 192.168.10.254.
> >     and "dhclient eth0" can get ip addess from dhcp server(that surprise
> > me!!)
> Try dhclient br0.
> >     i try to add dummy interface to br0, but dummy interface can not
> work,
> > like eth0.
> >     "brctl showmac br0" give me may mac addresses, so i think bridging
> is
> > working.
> >
> >     i think i must misunderstanding the brindge concept.
> When a nic is part of a bridge it's not supposed to have an address,
> is the bridge interface which has to.
> >     can i keep eth0 work after it join br0?
> I think it does work, since it's the physical
> >     thanks a lot for your help!!
> >
> One more thing: as you add interfaces to a bridge, the bridge MAC will
> change to the lowest MAC of the attached interfaces.
>
> Regards.
>

------=_Part_32042_9620648.1163875349838
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi:<br>&nbsp; what i want to do is like this: <a href=3D"http://www.linux.i=
t/~rubini/docs/vinter/vinter.html">http://www.linux.it/~rubini/docs/vinter/=
vinter.html</a><br>&nbsp; i saw some people like me want to try bridge:<br>=
&nbsp; <a href=3D"http://kerneltrap.org/node/6523">
http://kerneltrap.org/node/6523</a><br>&nbsp; there seems no good way to do=
..<br><br>Regards,<br>tbskyd<br><br><br><div><span class=3D"gmail_quote">20=
06/11/18, Abel Mart=EDn &lt;<a href=3D"mailto:abel.martin.ruiz@gmail.com">a=
bel.martin.ruiz@gmail.com
</a>&gt;:</span><blockquote class=3D"gmail_quote" DEFANGED_style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">On 11/17/06, d tbsky &lt;<a href=3D"mailto:tbskyd@gmail.com">tbskyd=
@gmail.com</a>
&gt; wrote:<br>&gt; Hi:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; i want to bridge my=
 eth0 interface to several dummy interface, like<br>&gt; vmware or xen did,=
<br>&gt; so i can request several dhcp ip address via several mac addresses=
.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;but i am stuck in the first step:
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;assume my eth0 is <a href=3D"http://192.168=
.10.1">192.168.10.1</a>, and it can ping <a href=3D"http://192.168.10.254">=
192.168.10.254</a>.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; ifconfig br0 up<br>&gt;=
&nbsp;&nbsp;&nbsp;&nbsp; brctl setfd br0 0<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; =
brctl addif br0 eth0
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; now i can not ping <a href=3D"http=
://192.168.10.254">192.168.10.254</a> anymore.<br>You might be having a rou=
ting problem. Check your routing table with ip route.<br>&gt;&nbsp;&nbsp;&n=
bsp;&nbsp; but if i set <a href=3D"http://192.168.10.2">
192.168.10.2</a> to br0, i can ping <a href=3D"http://192.168.10.254">192.1=
68.10.254</a>.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; and &quot;dhclient eth0&quot=
; can get ip addess from dhcp server(that surprise<br>&gt; me!!)<br>Try dhc=
lient br0.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; i try to add dummy interface to =
br0, but dummy interface can not work,
<br>&gt; like eth0.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &quot;brctl showmac br0=
&quot; give me may mac addresses, so i think bridging is<br>&gt; working.<b=
r>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; i think i must misunderstanding the =
brindge concept.<br>When a nic is part of a bridge it's not supposed to hav=
e an address,
<br>is the bridge interface which has to.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; c=
an i keep eth0 work after it join br0?<br>I think it does work, since it's =
the physical<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; thanks a lot for your help!!<b=
r>&gt;<br>One more thing: as you add interfaces to a bridge, the bridge MAC=
 will
<br>change to the lowest MAC of the attached interfaces.<br><br>Regards.<br=
></blockquote></div><br>

------=_Part_32042_9620648.1163875349838--
