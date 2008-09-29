Date: Mon, 29 Sep 2008 12:36:55 +0530 (IST)
From: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32FA42C@exchange.pacwire.local>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-941890410-1222672015=:88372"
Message-ID: <958219.88372.qm@web8806.mail.in.yahoo.com>
Subject: Re: [Bridge] bridge is not forwarding the packet
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, Leigh Sharpe <lsharpe@pacificwireless.com.au>
Cc: Stephen Hemminger <shemminger@vyatta.com>

--0-941890410-1222672015=:88372
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Leigh,

Thanks a lot for your reply,

Leigh, your suggestion solves the current problem. But it might not=20
be exactly we what we want.I just want know like, is it possible to get the=
 same behavior when=20
eth0 and eth0.15 are on different bridges?
=C2=A0With Regards=20

Rahul Bhardwaj=20

=C2=A0

--- On Wed, 24/9/08, Leigh Sharpe <lsharpe@pacificwireless.com.au> wrote:
From: Leigh Sharpe <lsharpe@pacificwireless.com.au>
Subject: RE: [Bridge] bridge is not forwarding the packet
To: "rahul bhardwaj" <rahul_bhardwaj36in@yahoo.co.in>, bridge@lists.linux-f=
oundation.org
Cc: "Stephen Hemminger" <shemminger@vyatta.com>
Date: Wednesday, 24 September, 2008, 4:23 PM



=20
Hi Rahul,
=C2=A0If you're certain that your problem isn't as Stephen suggested, you=
=20
might want to have a look at this:
=C2=A0

---
(From http://ebtables.sourceforge.net/brnf-faq.html )
How do I let vlan-tagged traffic go through a vlan=20
bridge port and the other traffic through=20
a non-vlan bridge port?=20
Suppose eth0 and eth0.15 are ports of br0. Without=20
countermeasures all traffic, including=20
traffic vlan-tagged with tag 15, entering the
physical device eth0 will go through the bridge port=20
eth0. To make the 15-tagged traffic go=20
through the eth0.15 bridge port, use the following
ebtables rule:=20
ebtables -t broute -A BROUTING -i eth0 --vlan-id 15=20
-j DROP
With the above rule, 15-tagged traffic will enter the=20
bridge on the physical device eth0, will=20
then be brouted and enter the bridge port=20
eth0.15, the vlan header will be stripped, after which the packet is bridge=
d. The packet thus enters the BROUTING=20
chain twice, the first time with input=20
device eth0 and the second time with input device eth0.15.
The other chains are only traversed once. All other=20
traffic will be bridged with input device=20
eth0.=20
----
This=C2=A0describes=C2=A0how=C2=A0to=C2=A0make=C2=A0sure=C2=A0your=C2=A0VLA=
N=C2=A0tagged=C2=A0traffic=C2=A0ends=C2=A0up=C2=A0on=C2=A0the=C2=A0bridge=
=C2=A0you=C2=A0want.

=C2=A0


From: bridge-bounces@lists.linux-foundation.org=20
[mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of rahul=20
bhardwaj
Sent: Tuesday, 23 September 2008 11:32 PM
To:=20
bridge@lists.linux-foundation.org
Cc: Stephen=20
Hemminger
Subject: Re: [Bridge] bridge is not forwarding the=20
packet




 =20
 =20
    Hi Stephen,

Thanks for your very prompt=20
      response!


     =20
     =20



     =20
       _filtered #yiv972948746 {margin:1.0in 1.25in 1.0in 1.25in;}
#yiv972948746 P.MsoNormal {
FONT-SIZE:12pt;MARGIN:0in 0in 0pt;FONT-FAMILY:"Times New Roman";}
#yiv972948746 LI.MsoNormal {
FONT-SIZE:12pt;MARGIN:0in 0in 0pt;FONT-FAMILY:"Times New Roman";}
#yiv972948746 DIV.MsoNormal {
FONT-SIZE:12pt;MARGIN:0in 0in 0pt;FONT-FAMILY:"Times New Roman";}
#yiv972948746 SPAN.EmailStyle15 {
COLOR:windowtext;FONT-FAMILY:Arial;}
#yiv972948746 DIV.Section1 {
}


      Actually my problem is not=20
      related to MAC address restrictions from wireless interface/driver. T=
he=20
      problem lies mainly in multiple bridges for different vlans. Since=20
      bridging happens first, the packet ends up on wrong bridge and gets=
=20
      discarded form that bridge. =C2=A0If Vlan handling is=20
      done prior to bridge handling, my setup will work fine. =20
      =20
      There=20
      is also another thing which I did not understand. When we add an inte=
rface=20
      to vlan, the newly created interface=E2=80=99s hard_header is set to=
=20
      vlan_dev_hard_header function. This vlan_dev_hard_header adds the vla=
n tag=20
      for outing packet.=20
      Interestingly this happens=20
      after bridging code hand over the packet to interface. Conversely whe=
n the=20
      packet is received, interface should remove the vlan tag and hand ove=
r the=20
      packet to bridge. But we are seeing that bridge code is executing pri=
or to=20
      vlan handling.=20
      =20
      Regards,=20
      =20
      Rahul=20
      Bhardwaj=20
      =20
      =C2=A0

--- On Mon, 22/9/08, Stephen=20
      Hemminger <shemminger@vyatta.com> wrote:

      From:=20
        Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: [Bridge]=20
        bridge is not forwarding the packet <Urgent, Please reply=20
        ASAP>
To: "rahul bhardwaj"=20
        <rahul_bhardwaj36in@yahoo.co.in>
Cc:=20
        bridge@lists.linux-foundation.org
Date: Monday, 22 September, 2008,=20
        8:33 AM

On Mon, 22 Sep 2008 16:24:00 +0530 (IST)
rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in> wrote:

> Hello to all,
>=20
> I am stating my problem below in detail so that you all can understand it
properly.
>=20
> I am having setup of Linux box. In that box I am having one Ethernet
interface eth0 and one wireless interface ath0. I have also configured one =
vlan
port as eth0.100 with the
 help of vconfig (vconfig add eth 100).=C2=A0 Now I have
created two bridges br1 and br100. I have added eth0 into br1 so br1 is hav=
ing
only one interface. I have added ath0 and eth0.100 into br100. Physically e=
th0
is connected to a switch which is configured to handle vlan 100. DHCP serve=
r is
also running into that switch to provide IP address to wireless stations. T=
his
is all about my setup.
>=20
> After this I am associating one wireless station with the ath0. After
successful association station issues a dhclient to get ip address, which
reaches to ath0 interface of my Linux box. ath0 bridges that request to
eth0.100. Now eth0.100 adds it's vlan tags and forward that request to the
switch. Because switch is configured to support vlan 100, so it process the=
 dhcp
request and send back the dhcp response with vlan tag 100.=20
>=20
> Now I don't know but this response is not reaching to ath0. I
 have
putted wireshark and figured out that those dhcp responses are reaching on =
eth0
and as eth0 is part of br1 so this packet is reaching to br1 which is just
discarding them all. So the wireless station is not getting the ip address.
According to me eth0 should give these packets to eth0.100 port instead of =
br1.
Or what I mean to say first vlan handling should be done priror then=C2=A0 =
bridge
handling. Do I need to change something into Linux kernel for that or there=
 is
some other problem with my setup?
>=20
> Can anybody help me in this? If anybody want more detail I will provide. =
I
am using Linux 2.6.15 kernel. Any kind of help will be much appreciated.=20
>=20
>=20
> With Regards=20
>=20
> Rahul Bhardwaj=20

Full bridging to wireless requires WDS which Linux wireless does not
 support
(yet).

http://www.linuxfoundation.org/en/Net:Bridge#It_doesn.27t_work_with_my_Wire=
less_card.21
_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge


Share files, take polls, and make new friends - all under one roof. Click=
=20
here.=0A=0A=0A      Unlimited freedom, unlimited storage. Get it now, on ht=
tp://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/
--0-941890410-1222672015=:88372
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi Leigh,<br><br>Thanks a lot for your reply,=
<br><br><p class=3D"MsoNormal"><font size=3D"2" face=3D"Arial"><span style=
=3D"font-family: Arial; font-size: 10pt;">Leigh, your suggestion solves the=
 current problem. But it might not=20
be exactly we what we want.I just want know like, is it possible to get the=
 same behavior when=20
eth0 and eth0.15 are on different bridges?<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Arial"><span style=3D"font-=
family: Arial; font-size: 10pt;"><o:p>&nbsp;</o:p></span></font></p>With Re=
gards <br><div><em><br>Rahul Bhardwaj <br></em></div><br><div><em>&nbsp;</e=
m></div><br><br>--- On <b>Wed, 24/9/08, Leigh Sharpe <i>&lt;lsharpe@pacific=
wireless.com.au&gt;</i></b> wrote:<br><blockquote style=3D"border-left: 2px=
 solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;">From: Leigh =
Sharpe &lt;lsharpe@pacificwireless.com.au&gt;<br>Subject: RE: [Bridge] brid=
ge is not forwarding the packet<br>To: "rahul bhardwaj" &lt;rahul_bhardwaj3=
6in@yahoo.co.in&gt;, bridge@lists.linux-foundation.org<br>Cc: "Stephen Hemm=
inger" &lt;shemminger@vyatta.com&gt;<br>Date: Wednesday, 24 September, 2008=
, 4:23 PM<br><br><div id=3D"yiv972948746">

=20
<div dir=3D"ltr" align=3D"left"><span class=3D"501461323-24092008"><font si=
ze=3D"2" face=3D"Arial">Hi Rahul,</font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"501461323-24092008"><font si=
ze=3D"2" face=3D"Arial">&nbsp;If you're certain that your problem isn't as =
Stephen suggested, you=20
might want to have a look at this:</font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"501461323-24092008"><font si=
ze=3D"2" face=3D"Arial"></font></span>&nbsp;</div>
<div dir=3D"ltr" align=3D"left"><span class=3D"501461323-24092008">
<p><font size=3D"2" face=3D"Arial">---</font></p>
<p><font size=3D"2" face=3D"Arial">(From </font><a rel=3D"nofollow" target=
=3D"_blank" href=3D"http://ebtables.sourceforge.net/brnf-faq.html"><u><font=
 color=3D"#0000ff"><font size=3D"2" face=3D"Arial">http://ebtables.sourcefo=
rge.net/brnf-faq.html</font></font></u><font color=3D"#0000ff"></font></a><=
font size=3D"2" face=3D"Arial"> )</font></p>
<p><font size=3D"2" face=3D"Arial">How do I let vlan-tagged traffic go thro=
ugh a vlan=20
bridge port and the<span class=3D"501461323-24092008"> </span>other traffic=
 through=20
a non-vlan bridge port? </font></p>
<p><font size=3D"2" face=3D"Arial">Suppose eth0 and eth0.15 are ports of br=
0. Without=20
countermeasures all<span class=3D"501461323-24092008"> </span>traffic, incl=
uding=20
traffic vlan-tagged with tag 15, entering the</font></p>
<p><font size=3D"2" face=3D"Arial">physical device eth0 will go through the=
 bridge port=20
eth0. To make the<span class=3D"501461323-24092008"> </span>15-tagged traff=
ic go=20
through the eth0.15 bridge port, use the following</font></p>
<p><font size=3D"2" face=3D"Arial">ebtables rule: </font></p>
<p><font size=3D"2" face=3D"Arial">ebtables -t broute -A BROUTING -i eth0 -=
-vlan-id 15=20
-j DROP</font></p>
<p><font size=3D"2" face=3D"Arial">With the above rule, 15-tagged traffic w=
ill enter the=20
bridge on the<span class=3D"501461323-24092008"> </span>physical device eth=
0, will=20
then be brouted and enter the bridge port<span class=3D"501461323-24092008"=
>=20
</span>eth0.15, the vlan header will be stripped, after which the packet is=
<span class=3D"501461323-24092008"> </span>bridged. The packet thus enters =
the BROUTING=20
chain twice, the first time<span class=3D"501461323-24092008"> </span>with =
input=20
device eth0 and the second time with input device eth0.15.</font></p>
<p><font size=3D"2" face=3D"Arial">The other chains are only traversed once=
. All other=20
traffic will be<span class=3D"501461323-24092008"> </span>bridged with inpu=
t device=20
eth0. </font></p>
<p><font size=3D"2" face=3D"Arial">----</font></p></span></div>
<div><span class=3D"501461323-24092008"></span><font size=3D"2" face=3D"Ari=
al">This&nbsp;describes&nbsp;how&nbsp;to&nbsp;make&nbsp;sure&nbsp;your&nbsp=
;VLAN&nbsp;tagged&nbsp;traffic&nbsp;ends&nbsp;up&nbsp;on&nbsp;the&nbsp;brid=
ge&nbsp;you&nbsp;want.</font></div>
<div><span class=3D"501461323-24092008"></span><font size=3D"2" face=3D"Ari=
al"></font><br>&nbsp;</div>
<div class=3D"OutlookMessageHeader" dir=3D"ltr" align=3D"left" lang=3D"en-u=
s">
<hr tabindex=3D"-1">
<font size=3D"2" face=3D"Tahoma"><b>From:</b> bridge-bounces@lists.linux-fo=
undation.org=20
[mailto:bridge-bounces@lists.linux-foundation.org] <b>On Behalf Of </b>rahu=
l=20
bhardwaj<br><b>Sent:</b> Tuesday, 23 September 2008 11:32 PM<br><b>To:</b>=
=20
bridge@lists.linux-foundation.org<br><b>Cc:</b> Stephen=20
Hemminger<br><b>Subject:</b> Re: [Bridge] bridge is not forwarding the=20
packet<br></font><br></div>
<div></div>
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0">
  <tbody>
  <tr>
    <td valign=3D"top">Hi Stephen,<br><br>Thanks for your very prompt=20
      response!<br><br>
     =20
     =20



     =20
      <style> _filtered #yiv972948746 {margin:1.0in 1.25in 1.0in 1.25in;}
#yiv972948746 P.MsoNormal {
FONT-SIZE:12pt;MARGIN:0in 0in 0pt;FONT-FAMILY:"Times New Roman";}
#yiv972948746 LI.MsoNormal {
FONT-SIZE:12pt;MARGIN:0in 0in 0pt;FONT-FAMILY:"Times New Roman";}
#yiv972948746 DIV.MsoNormal {
FONT-SIZE:12pt;MARGIN:0in 0in 0pt;FONT-FAMILY:"Times New Roman";}
#yiv972948746 SPAN.EmailStyle15 {
COLOR:windowtext;FONT-FAMILY:Arial;}
#yiv972948746 DIV.Section1 {
}
</style>

      <p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: A=
rial;">Actually my problem is not=20
      related to MAC address restrictions from wireless interface/driver. T=
he=20
      problem lies mainly in multiple bridges for different vlans. Since=20
      bridging happens first, the packet ends up on wrong bridge and gets=
=20
      discarded form that bridge. <span>&nbsp;</span></span>If Vlan handlin=
g is=20
      done prior to bridge handling, my setup will work fine. </p>=20
      <p class=3D"MsoNormal"></p>=20
      <p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: A=
rial;">There=20
      is also another thing which I did not understand. When we add an inte=
rface=20
      to vlan, the newly created interface=E2=80=99s hard_header is set to=
=20
      vlan_dev_hard_header function. This vlan_dev_hard_header adds the vla=
n tag=20
      for outing packet.</span></p>=20
      <p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: A=
rial;">Interestingly this happens=20
      after bridging code hand over the packet to interface. Conversely whe=
n the=20
      packet is received, interface should remove the vlan tag and hand ove=
r the=20
      packet to bridge. But we are seeing that bridge code is executing pri=
or to=20
      vlan handling.</span></p>=20
      <p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: A=
rial;"></span></p>=20
      <p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: A=
rial;">Regards,</span></p>=20
      <p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: A=
rial;"></span></p>=20
      <p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: A=
rial;">Rahul=20
      Bhardwaj</span><span style=3D"font-size: 10pt; font-family: Arial;"><=
/span></p>=20
      <p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: A=
rial;"></span></p>=20
      <div><em></em>&nbsp;</div><br><br>--- On <b>Mon, 22/9/08, Stephen=20
      Hemminger <i>&lt;shemminger@vyatta.com&gt;</i></b> wrote:<br>
      <blockquote style=3D"border-left: 2px solid rgb(16, 16, 255); padding=
-left: 5px; margin-left: 5px;">From:=20
        Stephen Hemminger &lt;shemminger@vyatta.com&gt;<br>Subject: Re: [Br=
idge]=20
        bridge is not forwarding the packet &lt;Urgent, Please reply=20
        ASAP&gt;<br>To: "rahul bhardwaj"=20
        &lt;rahul_bhardwaj36in@yahoo.co.in&gt;<br>Cc:=20
        bridge@lists.linux-foundation.org<br>Date: Monday, 22 September, 20=
08,=20
        8:33 AM<br><br><pre>On Mon, 22 Sep 2008 16:24:00 +0530 (IST)<br>rah=
ul bhardwaj &lt;rahul_bhardwaj36in@yahoo.co.in&gt; wrote:<br><br>&gt; Hello=
 to all,<br>&gt; <br>&gt; I am stating my problem below in detail so that y=
ou all can understand it<br>properly.<br>&gt; <br>&gt; I am having setup of=
 Linux box. In that box I am having one Ethernet<br>interface eth0 and one =
wireless interface ath0. I have also configured one vlan<br>port as eth0.10=
0 with the<br> help of vconfig (vconfig add eth 100).&nbsp; Now I have<br>c=
reated two bridges br1 and br100. I have added eth0 into br1 so br1 is havi=
ng<br>only one interface. I have added ath0 and eth0.100 into br100. Physic=
ally eth0<br>is connected to a switch which is configured to handle vlan 10=
0. DHCP server is<br>also running into that switch to provide IP address to=
 wireless stations. This<br>is all about my setup.<br>&gt; <br>&gt; After t=
his I am associating one wireless station with the ath0.
 After<br>successful association station issues a dhclient to get ip addres=
s, which<br>reaches to ath0 interface of my Linux box. ath0 bridges that re=
quest to<br>eth0.100. Now eth0.100 adds it's vlan tags and forward that req=
uest to the<br>switch. Because switch is configured to support vlan 100, so=
 it process the dhcp<br>request and send back the dhcp response with vlan t=
ag 100. <br>&gt; <br>&gt; Now I don't know but this response is not reachin=
g to ath0. I<br> have<br>putted wireshark and figured out that those dhcp r=
esponses are reaching on eth0<br>and as eth0 is part of br1 so this packet =
is reaching to br1 which is just<br>discarding them all. So the wireless st=
ation is not getting the ip address.<br>According to me eth0 should give th=
ese packets to eth0.100 port instead of br1.<br>Or what I mean to say first=
 vlan handling should be done priror then&nbsp; bridge<br>handling. Do I ne=
ed to change something into Linux kernel for that or there
 is<br>some other problem with my setup?<br>&gt; <br>&gt; Can anybody help =
me in this? If anybody want more detail I will provide. I<br>am using Linux=
 2.6.15 kernel. Any kind of help will be much appreciated. <br>&gt; <br>&gt=
; <br>&gt; With Regards <br>&gt; <br>&gt; Rahul Bhardwaj <br><br>Full bridg=
ing to wireless requires WDS which Linux wireless does not<br> support<br>(=
yet).<br><br>http://www.linuxfoundation.org/en/Net:Bridge#It_doesn.27t_work=
_with_my_Wireless_card.21<br>______________________________________________=
_<br>Bridge mailing list<br>Bridge@lists.linux-foundation.org<br>https://li=
sts.linux-foundation.org/mailman/listinfo/bridge</pre></blockquote></td></t=
r></tbody></table><br>
<hr size=3D"1">
Share files, take polls, and make new friends - all under one roof. <a rel=
=3D"nofollow" target=3D"_blank" href=3D"http://in.rd.yahoo.com/tagline_grou=
ps_8/*http://in.promos.yahoo.com/groups/">Click=20
here.</a></div></blockquote></td></tr></table><br>=0A=0A=0A      <!--6--><h=
r size=3D1></hr> Add more friends to your messenger and enjoy! <a href=3D"h=
ttp://in.rd.yahoo.com/tagline_messenger_6/*http://in.messenger.yahoo.com/in=
vite/"> Invite them now.</a>
--0-941890410-1222672015=:88372--
