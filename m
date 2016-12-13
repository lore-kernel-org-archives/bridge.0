Return-Path: <ping2balaji@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=wQYOJR/dwE+e8D2PveqQokONqEj9tPrK26Uhr5D8Pk8=;
	b=y9jNDuVfGhwz5zpm2y0QQein9yM8YkHdIZMJa7b2oj9aYyELNIxJLI0pR6FZhig5LE
	fsz7toTkDfrrH3kv+ppouL2Ju8rRUpZVX6XxBkBugFI0P835IXQ5CR5zx7PQpZSD5PyM
	OXgg1s424x6rqika1Ljdr1s0SjefsAtFJXSzAajaAdBccbdkCv9jFATLyP0axngJy3g+
	+3Mz1WQMP+zQlhawZqX7gaO25AutD3MK5eSmauvUJQhfrII820ScwFC+jYP9RAykD1FV
	WRvPD5DnfgHCFKX3WqKONP4EM/shT8i+Ymyp9M4klqBRm6XACuGA3v11HsQhAmUcKoHE
	DWKg==
MIME-Version: 1.0
In-Reply-To: <20161213094128.3fa3f4a5@xeon-e3>
References: <CAAtMjxaGCpd_3axCbinnpDpgR+H3DPn9y+cLabodGiytwckc7A@mail.gmail.com>
	<20161213094128.3fa3f4a5@xeon-e3>
From: Balaji J <ping2balaji@gmail.com>
Date: Tue, 13 Dec 2016 23:45:52 +0530
Message-ID: <CAAtMjxYTtqk3f5ucZuhP=Uv+bJR7NEYPXrB_vUtX+MpzoMt78Q@mail.gmail.com>
Content-Type: multipart/alternative; boundary=001a113fa7bcf7a1c505438e3578
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

--001a113fa7bcf7a1c505438e3578
Content-Type: text/plain; charset=UTF-8

Thanks Stephen.
Can i attach an interface with IP assigned to it already/statically to a
bridge?
So if i understand correctly from your response, i should run dhcpclient on
br0 interface to assign IP for the same? and Lets say br0 gets an IP
assigned by DHCP-Server as "12.0.0.1".

Now my intention is to assign IP address to the Host(say host1) behind
Router-1 using the DHCP-Server running on/behind Router-2 as shown below:
Host1 <------> (eth2)[Router-1](eth1:100.1.1.1) <----------EoGRE
Tunnel----->(eth0:100.1.1.254)[Router-2](DHCP-Server)

So i thought Bridging eth2 to eth1 in Router-1 is the only way to achieve
the same as i want the dhcp-broadcast packet from Host-1 to get tunneled
over EogRE till Router-2. Is this assumption correct? or i am missing
something here?

Or i should not assign any IP to eth2 and instead do it in br0 in Router-1?

Any guidance would be very helpful and greatly appreciated.

Thanks,
...Balaji.J



On Tue, Dec 13, 2016 at 11:11 PM, Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Tue, 13 Dec 2016 21:13:43 +0530
> Balaji J <ping2balaji@gmail.com> wrote:
>
> > Hi all,
> >
> > I am trying to setup a bridge with 2 interfaces attached to it in
> Router-1.
> > Interface-1: eth1 ==> EoGRE Tunnel interface(gretap) connecting to
> another
> > Router-2 where DHCP server is running.
> > Interface-2: eth2 ==> Trying to use DHCP to assign IP for this eth2
> > interface from DHCP-Server running on Router-2.
> >
> > Basically the setup i am expecting is like:
> > (eth2)[Router-1](eth1:100.1.1.1) <----------EoGRE
> > Tunnel----->(eth0:100.1.1.254)[Router-2](DHCP-Server)
> >
> > Following are the setup i did to check the 1st stage to see if the
> > dhcp-discover broadcast is going out of Router-1 over EoGRE tunnel or
> not.
> > But i am not able to achieve the same.
> >
> > Can anyone please let me know what is missing here? Thanks in advance.
> >
> > Router-1:
> > 1) ip link add eogre type gretap local 100.1.1.1 remote 100.1.1.254 ==>
> > created gretap with endpoints.
> > 2) ip link set eogre up ==> brought the eogre interface up.
> > [root@centos]# ifconfig
> > eogre     Link encap:Ethernet  HWaddr 9E:25:FC:54:7F:F2
> >           inet6 addr: fe80::9c25:fcff:fe54:7ff2/64 Scope:Link
> >           UP BROADCAST RUNNING MULTICAST  MTU:1462  Metric:1
> >           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:1000
> >           RX bytes:0 (0.0 b)  TX bytes:492 (492.0 b)
> >
> > eth1      Link encap:Ethernet  HWaddr 08:00:27:3C:FB:14
> >           inet addr:100.1.1.1  Bcast:0.0.0.0  Mask:255.255.255.0
> >           inet6 addr: fe80::a00:27ff:fe3c:fb14/64 Scope:Link
> >           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
> >           RX packets:13 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:40 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:1000
> >           RX bytes:1398 (1.3 KiB)  TX bytes:4103 (4.0 KiB)
> >
> > eth2      Link encap:Ethernet  HWaddr 08:00:27:5E:7F:83
> >           BROADCAST MULTICAST  MTU:1500  Metric:1
> >           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:1000
> >           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
> > 3) brctl addbr br0  ==> created bridge interface
> > 4) brctl addif br0 eogre ==> attach eogre interface to bridge
> > 5) brctl addif br0 eth2 ==> attach eth2 interface to bridge
> > 6) sysctl -w net.ipv6.conf.eth2.disable_ipv6=1 ==> disable ipv6 in eth2
> > just to avoid unwanted ipv6 signalling messages from it.
> > 7) ifconfig eth2 up ==> eth2 iface up with no IP in it yet.
> > 8) ifconfig eogre up ==> eogre iface up
> > 9) ifconfig br0 up ==> Bridge up.
> > 10) brctl show ==>
> > bridge name     bridge id               STP enabled     interfaces
> > br0             8000.0800275e7f83       no              eogre
> >
> >   eth2
> >
> > 11) brctl showstp br0
> >
> > [root@centos-dev ~]# brctl showstp br0
> > br0
> >  bridge id              8000.0800275e7f83
> >  designated root        8000.0800275e7f83
> >  root port                 0                    path cost
>   0
> >  max age                  19.99                 bridge max age
> >  19.99
> >  hello time                1.99                 bridge hello time
> >  1.99
> >  forward delay            14.99                 bridge forward delay
> >  14.99
> >  ageing time             299.95
> >  hello timer               0.50                 tcn timer
> >  0.00
> >  topology change timer     0.00                 gc timer
> > 1.50
> >  hash elasticity           4                    hash max
>  512
> >  mc last member count      2                    mc init query count
>   2
> >  mc router                 1                    mc snooping
>   1
> >  mc last member timer      0.99                 mc membership timer
> >  259.96
> >  mc querier timer        254.96                 mc query interval
> >  124.98
> >  mc response interval      9.99                 mc init query interval
> >  31.24
> >  flags
> >
> >
> > eogre (0)
> >  port id                0000                    state
> >  forwarding
> >  designated root        8000.0800275e7f83       path cost
> 100
> >  designated bridge      8000.0800275e7f83       message age timer
> >  0.00
> >  designated port        8001                    forward delay timer
> >  0.00
> >  designated cost           0                    hold timer
> > 0.00
> >  mc router                 1
> >  flags
> >
> > eth2 (0)
> >  port id                0000                    state
> >  forwarding
> >  designated root        8000.0800275e7f83       path cost
>   4
> >  designated bridge      8000.0800275e7f83       message age timer
> >  0.00
> >  designated port        8002                    forward delay timer
> >  0.00
> >  designated cost           0                    hold timer
> > 0.00
> >  mc router                 1
> >  flags
> >
> > 12) dhclient -i eth2 ==> This command triggers a DHCP-DISCOVER
> > broadcast(both l2/l3 broadcast destination addressed) from eth2 and
> > initiate ip allocation process.
> >
> > Now if i capture packets in wireshark in eth1+br0+eogre interface of
> > Router-1, i don't see the dhcp-discover packet sent from eth2 interface
> > going over EoGRE Tunnel to Router-2.
> > But the same DHCP-Discover packet i can see if i capture in eth2
> > interface(obvious reason).
> >
> > Is it not like whatever packets coming in or originating from eth2 will
> be
> > bridged to eogre interface using bridge "br0"?
> > I am using kernel 2.6 in CentOS
> >
> > Can someone please help here?
> >
> > Regards,
> > ...Balaji
>
> You can't and shouldn't try to do anything that assigns an IP address
> to a device that is a member of a bridge.  In your case that is eth2.
>
>
> The correct thing to do is run DHCP client on the bridge device.
>

--001a113fa7bcf7a1c505438e3578
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Stephen.<div>Can i attach an interface with IP assi=
gned to it already/statically to a bridge?<div><div><div>So if i understand=
 correctly from your response, i should run dhcpclient on br0 interface to =
assign IP for the same? and Lets say br0 gets an IP assigned by DHCP-Server=
 as &quot;12.0.0.1&quot;.</div></div><div><br></div><div>Now my intention i=
s to assign IP address to the Host(say host1) behind Router-1 using the DHC=
P-Server running on/behind Router-2 as shown below:</div><div><div style=3D=
"font-size:12.8px"><span style=3D"font-size:12.8px">Host1 &lt;------&gt; (e=
th2)[Router-1](eth1:100.1.1.</span><wbr style=3D"font-size:12.8px"><span st=
yle=3D"font-size:12.8px">1) &lt;----------EoGRE Tunnel-----&gt;(eth0:100.1.=
1.254)</span><wbr style=3D"font-size:12.8px"><span style=3D"font-size:12.8p=
x">[Router-2](DHCP-Server)</span><br></div></div><div style=3D"font-size:12=
.8px"><span style=3D"font-size:12.8px"><br></span></div><div style=3D"font-=
size:12.8px"><span style=3D"font-size:12.8px">So i thought Bridging eth2 to=
 eth1 in Router-1 is the only way to achieve the same as i want the dhcp-br=
oadcast packet from Host-1 to get tunneled over EogRE till Router-2. Is thi=
s assumption correct? or i am missing something here?=C2=A0</span><br></div=
><div style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"><br></spa=
n></div><div style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">Or=
 i should not assign any IP to eth2 and instead do it in br0 in Router-1?</=
span></div><div style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"=
><br></span></div><div style=3D"font-size:12.8px"><span style=3D"font-size:=
12.8px">Any guidance would be very helpful and greatly appreciated.=C2=A0</=
span><br></div><div style=3D"font-size:12.8px"><br></div><div style=3D"font=
-size:12.8px">Thanks,</div><div style=3D"font-size:12.8px">...Balaji.J</div=
><div style=3D"font-size:12.8px"><br></div><div><br></div></div></div></div=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Dec 13, =
2016 at 11:11 PM, Stephen Hemminger <span dir=3D"ltr">&lt;<a href=3D"mailto=
:stephen@networkplumber.org" target=3D"_blank">stephen@networkplumber.org</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb=
"><div class=3D"h5">On Tue, 13 Dec 2016 21:13:43 +0530<br>
Balaji J &lt;<a href=3D"mailto:ping2balaji@gmail.com">ping2balaji@gmail.com=
</a>&gt; wrote:<br>
<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I am trying to setup a bridge with 2 interfaces attached to it in Rout=
er-1.<br>
&gt; Interface-1: eth1 =3D=3D&gt; EoGRE Tunnel interface(gretap) connecting=
 to another<br>
&gt; Router-2 where DHCP server is running.<br>
&gt; Interface-2: eth2 =3D=3D&gt; Trying to use DHCP to assign IP for this =
eth2<br>
&gt; interface from DHCP-Server running on Router-2.<br>
&gt;<br>
&gt; Basically the setup i am expecting is like:<br>
&gt; (eth2)[Router-1](eth1:100.1.1.<wbr>1) &lt;----------EoGRE<br>
&gt; Tunnel-----&gt;(eth0:100.1.1.254)<wbr>[Router-2](DHCP-Server)<br>
&gt;<br>
&gt; Following are the setup i did to check the 1st stage to see if the<br>
&gt; dhcp-discover broadcast is going out of Router-1 over EoGRE tunnel or =
not.<br>
&gt; But i am not able to achieve the same.<br>
&gt;<br>
&gt; Can anyone please let me know what is missing here? Thanks in advance.=
<br>
&gt;<br>
&gt; Router-1:<br>
&gt; 1) ip link add eogre type gretap local 100.1.1.1 remote 100.1.1.254 =
=3D=3D&gt;<br>
&gt; created gretap with endpoints.<br>
&gt; 2) ip link set eogre up =3D=3D&gt; brought the eogre interface up.<br>
&gt; [root@centos]# ifconfig<br>
&gt; eogre=C2=A0 =C2=A0 =C2=A0Link encap:Ethernet=C2=A0 HWaddr 9E:25:FC:54:=
7F:F2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inet6 addr: fe80::9c25:fcff:fe=
54:7ff2/64 Scope:Link<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST=
=C2=A0 MTU:1462=C2=A0 Metric:1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:0 errors:0 dropped:=
0 overruns:0 frame:0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:6 errors:0 dropped:=
0 overruns:0 carrier:0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:1000<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:0 (0.0 b)=C2=A0 TX by=
tes:492 (492.0 b)<br>
&gt;<br>
&gt; eth1=C2=A0 =C2=A0 =C2=A0 Link encap:Ethernet=C2=A0 HWaddr 08:00:27:3C:=
FB:14<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inet addr:100.1.1.1=C2=A0 Bcas=
t:0.0.0.0=C2=A0 Mask:255.255.255.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inet6 addr: fe80::a00:27ff:fe3=
c:fb14/64 Scope:Link<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST=
=C2=A0 MTU:1500=C2=A0 Metric:1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:13 errors:0 dropped=
:0 overruns:0 frame:0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:40 errors:0 dropped=
:0 overruns:0 carrier:0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:1000<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:1398 (1.3 KiB)=C2=A0 =
TX bytes:4103 (4.0 KiB)<br>
&gt;<br>
&gt; eth2=C2=A0 =C2=A0 =C2=A0 Link encap:Ethernet=C2=A0 HWaddr 08:00:27:5E:=
7F:83<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BROADCAST MULTICAST=C2=A0 MTU:=
1500=C2=A0 Metric:1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:0 errors:0 dropped:=
0 overruns:0 frame:0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:0 errors:0 dropped:=
0 overruns:0 carrier:0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:1000<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:0 (0.0 b)=C2=A0 TX by=
tes:0 (0.0 b)<br>
&gt; 3) brctl addbr br0=C2=A0 =3D=3D&gt; created bridge interface<br>
&gt; 4) brctl addif br0 eogre =3D=3D&gt; attach eogre interface to bridge<b=
r>
&gt; 5) brctl addif br0 eth2 =3D=3D&gt; attach eth2 interface to bridge<br>
&gt; 6) sysctl -w net.ipv6.conf.eth2.disable_<wbr>ipv6=3D1 =3D=3D&gt; disab=
le ipv6 in eth2<br>
&gt; just to avoid unwanted ipv6 signalling messages from it.<br>
&gt; 7) ifconfig eth2 up =3D=3D&gt; eth2 iface up with no IP in it yet.<br>
&gt; 8) ifconfig eogre up =3D=3D&gt; eogre iface up<br>
&gt; 9) ifconfig br0 up =3D=3D&gt; Bridge up.<br>
&gt; 10) brctl show =3D=3D&gt;<br>
&gt; bridge name=C2=A0 =C2=A0 =C2=A0bridge id=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0STP enabled=C2=A0 =C2=A0 =C2=A0interfaces<br>
&gt; br0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08000.0800275e7f83=
=C2=A0 =C2=A0 =C2=A0 =C2=A0no=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 eogre<br>
&gt;<br>
&gt;=C2=A0 =C2=A0eth2<br>
&gt;<br>
&gt; 11) brctl showstp br0<br>
&gt;<br>
&gt; [root@centos-dev ~]# brctl showstp br0<br>
&gt; br0<br>
&gt;=C2=A0 bridge id=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8000.0=
800275e7f83<br>
&gt;=C2=A0 designated root=C2=A0 =C2=A0 =C2=A0 =C2=A0 8000.0800275e7f83<br>
&gt;=C2=A0 root port=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 path cost=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0<br>
&gt;=C2=A0 max age=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 19.99=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b=
ridge max age<br>
&gt;=C2=A0 19.99<br>
&gt;=C2=A0 hello time=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1.99=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bridg=
e hello time<br>
&gt;=C2=A0 1.99<br>
&gt;=C2=A0 forward delay=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 14.99=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bridge forward d=
elay<br>
&gt;=C2=A0 14.99<br>
&gt;=C2=A0 ageing time=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0299.9=
5<br>
&gt;=C2=A0 hello timer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00.50=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcn ti=
mer<br>
&gt;=C2=A0 0.00<br>
&gt;=C2=A0 topology change timer=C2=A0 =C2=A0 =C2=A00.00=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gc timer<br>
&gt; 1.50<br>
&gt;=C2=A0 hash elasticity=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hash max=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0512<br>
&gt;=C2=A0 mc last member count=C2=A0 =C2=A0 =C2=A0 2=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mc init query count=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 2<br>
&gt;=C2=A0 mc router=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A01=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mc snooping=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br=
>
&gt;=C2=A0 mc last member timer=C2=A0 =C2=A0 =C2=A0 0.99=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mc membership timer<br>
&gt;=C2=A0 259.96<br>
&gt;=C2=A0 mc querier timer=C2=A0 =C2=A0 =C2=A0 =C2=A0 254.96=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mc query interval<br>
&gt;=C2=A0 124.98<br>
&gt;=C2=A0 mc response interval=C2=A0 =C2=A0 =C2=A0 9.99=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mc init query interval<br>
&gt;=C2=A0 31.24<br>
&gt;=C2=A0 flags<br>
&gt;<br>
&gt;<br>
&gt; eogre (0)<br>
&gt;=C2=A0 port id=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st=
ate<br>
&gt;=C2=A0 forwarding<br>
&gt;=C2=A0 designated root=C2=A0 =C2=A0 =C2=A0 =C2=A0 8000.0800275e7f83=C2=
=A0 =C2=A0 =C2=A0 =C2=A0path cost=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 100<br>
&gt;=C2=A0 designated bridge=C2=A0 =C2=A0 =C2=A0 8000.0800275e7f83=C2=A0 =
=C2=A0 =C2=A0 =C2=A0message age timer<br>
&gt;=C2=A0 0.00<br>
&gt;=C2=A0 designated port=C2=A0 =C2=A0 =C2=A0 =C2=A0 8001=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 forward delay timer<br=
>
&gt;=C2=A0 0.00<br>
&gt;=C2=A0 designated cost=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hold timer<b=
r>
&gt; 0.00<br>
&gt;=C2=A0 mc router=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A01<br>
&gt;=C2=A0 flags<br>
&gt;<br>
&gt; eth2 (0)<br>
&gt;=C2=A0 port id=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st=
ate<br>
&gt;=C2=A0 forwarding<br>
&gt;=C2=A0 designated root=C2=A0 =C2=A0 =C2=A0 =C2=A0 8000.0800275e7f83=C2=
=A0 =C2=A0 =C2=A0 =C2=A0path cost=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 4<br>
&gt;=C2=A0 designated bridge=C2=A0 =C2=A0 =C2=A0 8000.0800275e7f83=C2=A0 =
=C2=A0 =C2=A0 =C2=A0message age timer<br>
&gt;=C2=A0 0.00<br>
&gt;=C2=A0 designated port=C2=A0 =C2=A0 =C2=A0 =C2=A0 8002=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 forward delay timer<br=
>
&gt;=C2=A0 0.00<br>
&gt;=C2=A0 designated cost=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hold timer<b=
r>
&gt; 0.00<br>
&gt;=C2=A0 mc router=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A01<br>
&gt;=C2=A0 flags<br>
&gt;<br>
&gt; 12) dhclient -i eth2 =3D=3D&gt; This command triggers a DHCP-DISCOVER<=
br>
&gt; broadcast(both l2/l3 broadcast destination addressed) from eth2 and<br=
>
&gt; initiate ip allocation process.<br>
&gt;<br>
&gt; Now if i capture packets in wireshark in eth1+br0+eogre interface of<b=
r>
&gt; Router-1, i don&#39;t see the dhcp-discover packet sent from eth2 inte=
rface<br>
&gt; going over EoGRE Tunnel to Router-2.<br>
&gt; But the same DHCP-Discover packet i can see if i capture in eth2<br>
&gt; interface(obvious reason).<br>
&gt;<br>
&gt; Is it not like whatever packets coming in or originating from eth2 wil=
l be<br>
&gt; bridged to eogre interface using bridge &quot;br0&quot;?<br>
&gt; I am using kernel 2.6 in CentOS<br>
&gt;<br>
&gt; Can someone please help here?<br>
&gt;<br>
&gt; Regards,<br>
&gt; ...Balaji<br>
<br>
</div></div>You can&#39;t and shouldn&#39;t try to do anything that assigns=
 an IP address<br>
to a device that is a member of a bridge.=C2=A0 In your case that is eth2.<=
br>
<br>
<br>
The correct thing to do is run DHCP client on the bridge device.<br>
</blockquote></div><br></div>

--001a113fa7bcf7a1c505438e3578--
