Message-ID: <49002b820611191955i1928c129ic93d5ce8b014b5ff@mail.gmail.com>
Date: Mon, 20 Nov 2006 11:55:12 +0800
From: "d tbsky" <tbskyd@gmail.com>
In-Reply-To: <49002b820611191952y208408a7q40d8f0160024c99d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_44217_15717281.1163994912295"
References: <49002b820611170149n645e35e6n76edc98fe6c9596@mail.gmail.com>
	<915136920611180514q663e65d1oec82391ed3fac700@mail.gmail.com>
	<49002b820611180825u628eb95cud9d52b0125a645be@mail.gmail.com>
	<915136920611190902q33930830oe414066422c3d995@mail.gmail.com>
	<49002b820611191952y208408a7q40d8f0160024c99d@mail.gmail.com>
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

------=_Part_44217_15717281.1163994912295
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi:
>    my purpose is to get several ip address  from dhcp server via single
> ethernet card, like xen or vmware can do.
>
> Regards,
> sky_li
>
>
>
> 2006/11/20, Abel Mart=EDn < abel.martin.ruiz@gmail.com>:
> >
> > On 11/18/06, d tbsky < tbskyd@gmail.com> wrote:
> > > Hi:
> > >     thanks for your reply. you say the bridge interface should take
> > the ip
> > > address,
> > > not the nic. that's important. i think i go to the wrong direction. i
> > want
> > > nic
> > > (eth0,dummy0) to have ip address, not br0. it seems not what linux
> > bridge
> > > designed to do...
> > The problem is that a bridge device works at the link layer. A bridge
> > device doesn't know nothing about what is above link layer.
> > > by the way, i found if i set mac address manually :(eg: arp -s
> > > 192.168.10.254 x:x:x:x:x:x),
> > > then i can ping 192.168.10.254 via eth0. but i can never make dummy0
> > work in
> > > any way.
> > >
> > > Regards,
> > > tbsky
> > Could you explain what your actual purpose is? I might be
> > misunderstanding you.
> >
>
>

------=_Part_44217_15717281.1163994912295
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote"></span><blockquote class=3D"gmail_=
quote" DEFANGED_style=3D"border-left: 1px solid rgb(204, 204, 204); margin:=
 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">hi:<br>&nbsp;&nbsp; my purpose is t=
o get several ip address&nbsp; from dhcp server via single ethernet card, l=
ike xen or vmware can do.
<br><br>Regards,<br>sky_li<br><br><br><br><div><span class=3D"gmail_quote">=
2006/11/20, Abel Mart=EDn &lt;<a href=3D"mailto:abel.martin.ruiz@gmail.com"=
 target=3D"_blank" DEFANGED_onclick=3D"return top.js.OpenExtLink(window,eve=
nt,this)">
abel.martin.ruiz@gmail.com</a>&gt;:</span><div><span class=3D"e" id=3D"q_10=
f037ec61537808_1"><blockquote class=3D"gmail_quote" DEFANGED_style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;">On 11/18/06, d tbsky &lt;
<a href=3D"mailto:tbskyd@gmail.com" target=3D"_blank" DEFANGED_onclick=3D"r=
eturn top.js.OpenExtLink(window,event,this)">
tbskyd@gmail.com</a>&gt; wrote:<br>&gt; Hi:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;=
 thanks for your reply. you say the bridge interface should take the ip<br>=
&gt; address,<br>&gt; not the nic. that's important. i think i go to the wr=
ong direction. i want
<br>&gt; nic<br>&gt; (eth0,dummy0) to have ip address, not br0. it seems no=
t what linux bridge<br>&gt; designed to do...<br>The problem is that a brid=
ge device works at the link layer. A bridge<br>device doesn't know nothing =
about what is above link layer.
<br>&gt; by the way, i found if i set mac address manually :(eg: arp -s<br>=
&gt; <a href=3D"http://192.168.10.254" target=3D"_blank" DEFANGED_onclick=
=3D"return top.js.OpenExtLink(window,event,this)">192.168.10.254</a> x:x:x:=
x:x:x),<br>&gt; then i can ping=20
<a href=3D"http://192.168.10.254" target=3D"_blank" DEFANGED_onclick=3D"ret=
urn top.js.OpenExtLink(window,event,this)">192.168.10.254</a> via eth0. but=
 i can never make dummy0 work in
<br>&gt; any way.<br>&gt;<br>&gt; Regards,<br>&gt; tbsky<br>Could you expla=
in what your actual purpose is? I might be misunderstanding you.<br></block=
quote></span></div></div><br>

</blockquote></div><br>

------=_Part_44217_15717281.1163994912295--
