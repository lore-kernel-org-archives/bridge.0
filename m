MIME-Version: 1.0
In-Reply-To: <4AA1703A.9070800@free.fr>
References: <f0a957c30909032014y2076c54ek9fc34c2842124321@mail.gmail.com>
	<4AA1703A.9070800@free.fr>
Date: Fri, 4 Sep 2009 23:01:31 +0200
Message-ID: <f0a957c30909041401w5c031c6en90aac78f1b58a268@mail.gmail.com>
From: Gustavo Martin <gu.martinm@gmail.com>
Content-Type: multipart/alternative; boundary=00032555a9a2f751740472c6cd65
Subject: Re: [Bridge] Bridge and VLANs. Strange behaviour.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org

--00032555a9a2f751740472c6cd65
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thank you very much Nicolas,

     Your answer was very clear.

Thank you again for your help.

Gustavo Martin Morcuende


2009/9/4 Nicolas de Peslo=FCan <nicolas.2p.debian@free.fr>

> Gustavo Martin wrote:
>
>> Hello list,
>>
>>      I am trying to understand how the linux-based bridges work but I am
>> watching very strange things.
>>
>>      For example, if I have this configuration for the bridge BR0 with 2
>> physical interfaces eth0 and eth1:
>>
>> trying1.jpg
>>
>>     If PC1 sends an ARP REQUEST, PC2 receives this ARP REQUEST but they
>> are in different VLANs!
>>     Why the VLAN 20 can receive ARP REQUEST messages from the VLAN 10 an=
d
>> why the VLAN 10 can receive ARP REPLY messages from VLAN 20 if they are
>> different VLANs? This is crazy for me.
>>     I think linux-based bridges don't work very well with VLANs (probabl=
y
>> I am wrong because I am just a beginner)
>>     Can someone help me to understand that? Your help would be very
>> appreciated. :-)
>>
>
> The behavior you describe is normal and exactly the one you asked for.
>
> You have put eth0.10 and eth1.20 in the same bridge, so you asked to brid=
ge
> between eth0.10 and eth1.20.
>
> When a 802.1Q tagged packet is received on eth0, the kernel removes the
> 802.1Q header, having VLAN ID=3D10, then deliver the packet to eth0.10. T=
hen,
> the kernel deliver the packet to the bridge, because eth0.10 is a member =
of
> the bridge.
>
> At this time, the bridge code has no knowledge of the original VLAN ID
> because this VLAN ID was removed before the bridge code has an opportunit=
y
> to look at it.
>
> The bridge code send the un tagged packet to the right output port if it
> can find a suitable destination mac address entry in its mac_to_port tabl=
e.
> Else, it simply send the untagged packet to all ports except the one wher=
e
> the packet was received on.
>
> So the untagged packet is sent to eth1.20. Then, the kernel add a 802.1Q
> header to the packet, with VLAN ID=3D20, then deliver the packet to eth1,=
 to
> be sent on the wire.
>
> And you end up with the behavior you describe.
>
> If you want to bridge all ports in VLAN 10 together, all ports in VLAN 20
> together, and route between VLAN 10 and VLAN 20, you need to setup two
> different bridges :
>
> br10 : eth0.10 + eth1.10 + ... + ethN.10 and possibly some non-802.1Q
> ports.
> br20 : eth0.20 + eth1.20 + ... + ethN.20 and possibly some non-802.1Q
> ports.
>
> Then setup an IP address in the right subnet on br10 (192.168.1.1) and br=
20
> (172.16.1.1).
>
> Then ensure that routing is enabled :
>
> echo 1 > /proc/sys/net/ipv4/ip_forward
>
> Feel free to ask, if all this is not clear enough.
>
>        Nicolas.
>
>
>> Thanks in advance and sorry for my English.
>>
>> --
>> Gustavo Mart=EDn Morcuende
>>
>
>


--=20
Gustavo Mart=EDn Morcuende

--00032555a9a2f751740472c6cd65
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thank you very much Nicolas,<br>
<br>
=A0=A0=A0=A0 Your answer was very clear.<br>
<br>
Thank you again for your help.<br>
<br>
Gustavo Martin Morcuende<br><br><br><div class=3D"gmail_quote">2009/9/4 Nic=
olas de Peslo=FCan <span dir=3D"ltr">&lt;<a href=3D"mailto:nicolas.2p.debia=
n@free.fr">nicolas.2p.debian@free.fr</a>&gt;</span><br><blockquote class=3D=
"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0=
pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Gustavo Martin wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>
Hello list,<br>
<br>
 =A0 =A0 =A0I am trying to understand how the linux-based bridges work but =
I am watching very strange things.<br>
<br>
 =A0 =A0 =A0For example, if I have this configuration for the bridge BR0 wi=
th 2 physical interfaces eth0 and eth1:<br>
<br></div><div class=3D"im">
trying1.jpg<br>
<br>
 =A0 =A0 If PC1 sends an ARP REQUEST, PC2 receives this ARP REQUEST but the=
y are in different VLANs!<br>
 =A0 =A0 Why the VLAN 20 can receive ARP REQUEST messages from the VLAN 10 =
and why the VLAN 10 can receive ARP REPLY messages from VLAN 20 if they are=
 different VLANs? This is crazy for me.<br>
 =A0 =A0 I think linux-based bridges don&#39;t work very well with VLANs (p=
robably I am wrong because I am just a beginner)<br>
 =A0 =A0 Can someone help me to understand that? Your help would be very ap=
preciated. :-)<br>
</div></blockquote>
<br>
The behavior you describe is normal and exactly the one you asked for.<br>
<br>
You have put eth0.10 and eth1.20 in the same bridge, so you asked to bridge=
 between eth0.10 and eth1.20.<br>
<br>
When a 802.1Q tagged packet is received on eth0, the kernel removes the 802=
.1Q header, having VLAN ID=3D10, then deliver the packet to eth0.10. Then, =
the kernel deliver the packet to the bridge, because eth0.10 is a member of=
 the bridge.<br>

<br>
At this time, the bridge code has no knowledge of the original VLAN ID beca=
use this VLAN ID was removed before the bridge code has an opportunity to l=
ook at it.<br>
<br>
The bridge code send the un tagged packet to the right output port if it ca=
n find a suitable destination mac address entry in its mac_to_port table. E=
lse, it simply send the untagged packet to all ports except the one where t=
he packet was received on.<br>

<br>
So the untagged packet is sent to eth1.20. Then, the kernel add a 802.1Q he=
ader to the packet, with VLAN ID=3D20, then deliver the packet to eth1, to =
be sent on the wire.<br>
<br>
And you end up with the behavior you describe.<br>
<br>
If you want to bridge all ports in VLAN 10 together, all ports in VLAN 20 t=
ogether, and route between VLAN 10 and VLAN 20, you need to setup two diffe=
rent bridges :<br>
<br>
br10 : eth0.10 + eth1.10 + ... + ethN.10 and possibly some non-802.1Q ports=
.<br>
br20 : eth0.20 + eth1.20 + ... + ethN.20 and possibly some non-802.1Q ports=
.<br>
<br>
Then setup an IP address in the right subnet on br10 (192.168.1.1) and br20=
 (172.16.1.1).<br>
<br>
Then ensure that routing is enabled :<br>
<br>
echo 1 &gt; /proc/sys/net/ipv4/ip_forward<br>
<br>
Feel free to ask, if all this is not clear enough.<br><font color=3D"#88888=
8">
<br>
 =A0 =A0 =A0 =A0Nicolas.</font><div><div></div><div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
Thanks in advance and sorry for my English.<br>
<br>
-- <br>
Gustavo Mart=EDn Morcuende<br>
</blockquote>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Gustavo Mar=
t=EDn Morcuende<br>

--00032555a9a2f751740472c6cd65--
