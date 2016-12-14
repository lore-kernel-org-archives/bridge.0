Return-Path: <ping2balaji@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=irEJgf5VUXiLuu5ra8LdyADbjvRVEwy6XNC4/bN+8To=;
	b=MbqlaCVTUBIykN0qnYgA/ZbYD6gpksFdIR4/XHfgvVbqCNOhsm3DxMsZI1Hw+u1g6B
	lgce347Mj1eSWR2hdYCj/4Bkj7EJzftroION7X6BDV8tjeultCXy3p5RUmefn2CVmOHx
	aQH8MM2/Ei5+E1Y95uS6G2pxYLOMqKN2hNRxZMREbbGGBcdpZYjtDmiCJkylS+PJzj0W
	bgy1KJqVQLAgpoNn1JDN4XVpancTHJYlncvrACj9SQ/BD2vhmpWM3YWGMJMRogMVGk4c
	2vYrEb16ytIpRwY5Oxn1iK0rddcGmueLo+ql0OUCGWUvrxuMJPF78rjjNpdFF8xGsTNM
	vVkw==
MIME-Version: 1.0
In-Reply-To: <20161213111649.4d983c5f@xeon-e3>
References: <CAAtMjxaGCpd_3axCbinnpDpgR+H3DPn9y+cLabodGiytwckc7A@mail.gmail.com>
	<20161213094128.3fa3f4a5@xeon-e3>
	<CAAtMjxYTtqk3f5ucZuhP=Uv+bJR7NEYPXrB_vUtX+MpzoMt78Q@mail.gmail.com>
	<20161213111649.4d983c5f@xeon-e3>
From: Balaji J <ping2balaji@gmail.com>
Date: Wed, 14 Dec 2016 07:33:44 +0530
Message-ID: <CAAtMjxZGZc6+xDhUqLVGrhVwhy33AHft8DU-Rf+tX3ahzs4iRA@mail.gmail.com>
Content-Type: multipart/alternative; boundary=f403045c479425de9d054394bf8e
Subject: Re: [Bridge] Bridge interface not forwarding DHCP-Broadcast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org

--f403045c479425de9d054394bf8e
Content-Type: text/plain; charset=UTF-8

Thanks Stephen.

In the following article it is quoted that dhclient can be run on the
interface attached to the bridge:
https://wiki.linuxfoundation.org/networking/bridge

So does it not mean against what you have mentioned below?
"You can't and shouldn't try to do anything that assigns an IP address
to a device that is a member of a bridge.  In your case that is eth2."
i have tried to do the same like this as below:
--> brctl addif br0 eth2
--> dhclient eth2

Quoting from the link:
"
Does DHCP work over/through a bridge?

The bridge will forward DHCP traffic (broadcasts) and responses. You can
also use DHCP to set the local IP address of the bridge pseudo-interface.

One common mistake is that the default bridge forwarding delay setting is
30 seconds. This means that for the first 30 seconds after an interface
joins a bridge, it won't send anything. This is because if the bridge is
being used in a complex topology, it needs to discover other bridges and
not create loops. This problem was one of the reasons for the creation of
Rapid Spanning Tree Protocol (RSTP).

If the bridge is being used standalone (no other bridges near by). Then it
is safe to turn the forwarding delay off (set it to zero), before adding
interface to a bridge. Then you can run DHCP client right away.

 # brctl setfd br0 0
 # brctl addif br0 eth0
 # dhclient eth0

"


On Wed, Dec 14, 2016 at 12:46 AM, Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Tue, 13 Dec 2016 23:45:52 +0530
> Balaji J <ping2balaji@gmail.com> wrote:
>
> > Thanks Stephen.
> > Can i attach an interface with IP assigned to it already/statically to a
> > bridge?
> > So if i understand correctly from your response, i should run dhcpclient
> on
> > br0 interface to assign IP for the same? and Lets say br0 gets an IP
> > assigned by DHCP-Server as "12.0.0.1".
> >
> > Now my intention is to assign IP address to the Host(say host1) behind
> > Router-1 using the DHCP-Server running on/behind Router-2 as shown below:
> > Host1 <------> (eth2)[Router-1](eth1:100.1.1.1) <----------EoGRE
> > Tunnel----->(eth0:100.1.1.254)[Router-2](DHCP-Server)
> >
> > So i thought Bridging eth2 to eth1 in Router-1 is the only way to achieve
> > the same as i want the dhcp-broadcast packet from Host-1 to get tunneled
> > over EogRE till Router-2. Is this assumption correct? or i am missing
> > something here?
> >
> > Or i should not assign any IP to eth2 and instead do it in br0 in
> Router-1?
> >
> > Any guidance would be very helpful and greatly appreciated.
> >
> > Thanks,
> > ...Balaji.J
>
> The problem is that the IP address on an enslaved interface is not used
> by the IP stack and packets destined for that address tend to be
> blackholed.
> Packets being sent out get put on the enslaved interface and only sent
> out that interface not bridged.
>
>

--f403045c479425de9d054394bf8e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Stephen.<div><br></div><div>In the following articl=
e it is quoted that dhclient can be run on the interface attached to the br=
idge:</div><div><a href=3D"https://wiki.linuxfoundation.org/networking/brid=
ge">https://wiki.linuxfoundation.org/networking/bridge</a><br></div><div><b=
r></div><div>So does it not mean against what you have mentioned below?</di=
v><div>&quot;You can&#39;t and shouldn&#39;t try to do anything that assign=
s an IP address</div><div>to a device that is a member of a bridge.=C2=A0 I=
n your case that is eth2.&quot;</div><div>i have tried to do the same like =
this as below:</div><div>--&gt; brctl addif br0 eth2</div><div>--&gt; dhcli=
ent eth2</div><div><br></div><div>Quoting from the link:</div><div>&quot;</=
div><div><h3 class=3D"gmail-sectionedit34" id=3D"gmail-does-dhcp-work-overt=
hrough-a-bridge" style=3D"padding:0px;line-height:1.2;clear:left;font-size:=
1.125em;margin:0px 0px 0.888em;color:rgb(51,51,51);font-family:arial,sans-s=
erif">Does DHCP work over/through a bridge?</h3><div class=3D"gmail-level3"=
 style=3D"margin:0px;padding:0px;color:rgb(51,51,51);font-family:arial,sans=
-serif;font-size:14px"><p style=3D"margin:0px 0px 1.4em;padding:0px">The br=
idge will forward DHCP traffic (broadcasts) and responses. You can also use=
 DHCP to set the local IP address of the bridge pseudo-interface.</p><p sty=
le=3D"margin:0px 0px 1.4em;padding:0px">One common mistake is that the defa=
ult bridge forwarding delay setting is 30 seconds. This means that for the =
first 30 seconds after an interface joins a bridge, it won&#39;t send anyth=
ing. This is because if the bridge is being used in a complex topology, it =
needs to discover other bridges and not create loops. This problem was one =
of the reasons for the creation of Rapid Spanning Tree Protocol (RSTP).</p>=
<p style=3D"margin:0px 0px 1.4em;padding:0px">If the bridge is being used s=
tandalone (no other bridges near by). Then it is safe to turn the forwardin=
g delay off (set it to zero), before adding interface to a bridge. Then you=
 can run DHCP client right away.</p><pre class=3D"gmail-code" style=3D"marg=
in-top:0px;margin-bottom:1.4em;padding:0.7em 1em;font-family:consolas,&quot=
;andale mono wt&quot;,&quot;andale mono&quot;,&quot;bitstream vera sans mon=
o&quot;,&quot;nimbus mono l&quot;,monaco,&quot;courier new&quot;,monospace;=
font-size:1em;direction:ltr;background-color:rgb(251,250,249);border-radius=
:2px;overflow:auto;word-wrap:normal;border:1px solid rgb(204,204,204)"> # b=
rctl setfd br0 0
 # brctl addif br0 eth0
 # dhclient eth0</pre></div></div><div class=3D"gmail_extra">&quot;</div><d=
iv class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Wed, Dec 14, 2016 at 12:46 AM, Stephen Hemminger <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:stephen@networkplumber.org" target=3D"_b=
lank">stephen@networkplumber.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><span class=3D"gmail-">On Tue, 13 Dec 2016=
 23:45:52 +0530<br>
Balaji J &lt;<a href=3D"mailto:ping2balaji@gmail.com">ping2balaji@gmail.com=
</a>&gt; wrote:<br>
<br>
&gt; Thanks Stephen.<br>
&gt; Can i attach an interface with IP assigned to it already/statically to=
 a<br>
&gt; bridge?<br>
&gt; So if i understand correctly from your response, i should run dhcpclie=
nt on<br>
&gt; br0 interface to assign IP for the same? and Lets say br0 gets an IP<b=
r>
&gt; assigned by DHCP-Server as &quot;12.0.0.1&quot;.<br>
&gt;<br>
&gt; Now my intention is to assign IP address to the Host(say host1) behind=
<br>
&gt; Router-1 using the DHCP-Server running on/behind Router-2 as shown bel=
ow:<br>
&gt; Host1 &lt;------&gt; (eth2)[Router-1](eth1:100.1.1.<wbr>1) &lt;-------=
---EoGRE<br>
&gt; Tunnel-----&gt;(eth0:100.1.1.254)<wbr>[Router-2](DHCP-Server)<br>
&gt;<br>
&gt; So i thought Bridging eth2 to eth1 in Router-1 is the only way to achi=
eve<br>
&gt; the same as i want the dhcp-broadcast packet from Host-1 to get tunnel=
ed<br>
&gt; over EogRE till Router-2. Is this assumption correct? or i am missing<=
br>
&gt; something here?<br>
&gt;<br>
&gt; Or i should not assign any IP to eth2 and instead do it in br0 in Rout=
er-1?<br>
&gt;<br>
&gt; Any guidance would be very helpful and greatly appreciated.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; ...Balaji.J<br>
<br>
</span>The problem is that the IP address on an enslaved interface is not u=
sed<br>
by the IP stack and packets destined for that address tend to be blackholed=
.<br>
Packets being sent out get put on the enslaved interface and only sent<br>
out that interface not bridged.<br>
<br>
</blockquote></div><br></div></div>

--f403045c479425de9d054394bf8e--
