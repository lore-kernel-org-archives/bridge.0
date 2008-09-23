Date: Tue, 23 Sep 2008 19:01:41 +0530 (IST)
From: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>
In-Reply-To: <20080922083322.22fcc415@extreme>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-638661803-1222176701=:58969"
Message-ID: <694310.58969.qm@web8804.mail.in.yahoo.com>
Subject: Re: [Bridge] bridge is not forwarding the packet
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Stephen Hemminger <shemminger@vyatta.com>

--0-638661803-1222176701=:58969
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

Thanks for your very prompt response!





Actually my
problem is not related to MAC address restrictions from wireless
interface/driver. The problem lies mainly in multiple bridges for different=
 vlans.
Since bridging happens first, the packet ends up on wrong bridge and gets
discarded form that bridge. =C2=A0If Vlan
handling is done prior to bridge handling, my setup will work fine.=20

=C2=A0

There is
also another thing which I did not understand. When we add an interface to
vlan, the newly created interface=E2=80=99s hard_header is set to vlan_dev_=
hard_header
function. This vlan_dev_hard_header adds the vlan tag for outing packet.

Interestingly
this happens after bridging code hand over the packet to interface. Convers=
ely when
the packet is received, interface should remove the vlan tag and hand over =
the
packet to bridge. But we are seeing that bridge code is executing prior to =
vlan
handling.

=C2=A0

Regards,

=C2=A0

Rahul Bhardwaj

=C2=A0

=C2=A0

--- On Mon, 22/9/08, Stephen Hemminger <shemminger@vyatta.com> wrote:
From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: [Bridge] bridge is not forwarding the packet <Urgent, Please r=
eply ASAP>
To: "rahul bhardwaj" <rahul_bhardwaj36in@yahoo.co.in>
Cc: bridge@lists.linux-foundation.org
Date: Monday, 22 September, 2008, 8:33 AM

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
port as eth0.100 with the help of vconfig (vconfig add eth 100).=C2=A0 Now =
I have
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
> Now I don't know but this response is not reaching to ath0. I have
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

Full bridging to wireless requires WDS which Linux wireless does not suppor=
t
(yet).

http://www.linuxfoundation.org/en/Net:Bridge#It_doesn.27t_work_with_my_Wire=
less_card.21
_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge=0A=0A=0A      Co=
nnect with friends all over the world. Get Yahoo! India Messenger at http:/=
/in.messenger.yahoo.com/?wm=3Dn/
--0-638661803-1222176701=:58969
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi Stephen,<br><br>Thanks for your very promp=
t response!<br><br><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"><meta name=3D"ProgId" content=3D"Word.Document"><meta name=
=3D"Generator" content=3D"Microsoft Word 11"><meta name=3D"Originator" cont=
ent=3D"Microsoft Word 11"><link rel=3D"File-List" href=3D"file:///C:%5CDOCU=
ME%7E1%5Crbhardwa%5CLOCALS%7E1%5CTemp%5Cmsohtml1%5C01%5Cclip_filelist.xml">=
<o:smarttagtype namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"=
 name=3D"PersonName"></o:smarttagtype><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" LatentStyleCount=3D"156">
 </w:LatentStyles>
</xml><![endif]--><!--[if !mso]><object
 classid=3D"clsid:38481807-CA0E-42D2-BF39-B33AF135CC4D" id=3Dieooui></objec=
t>
<style>
st1\:*{behavior:url(#ieooui) }
</style>
<![endif]--><style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{mso-style-parent:"";
=09margin:0in;
=09margin-bottom:.0001pt;
=09mso-pagination:widow-orphan;
=09font-size:12.0pt;
=09font-family:"Times New Roman";
=09mso-fareast-font-family:"Times New Roman";}
span.EmailStyle15
=09{mso-style-type:personal;
=09mso-style-noshow:yes;
=09mso-ansi-font-size:10.0pt;
=09mso-bidi-font-size:10.0pt;
=09font-family:Arial;
=09mso-ascii-font-family:Arial;
=09mso-hansi-font-family:Arial;
=09mso-bidi-font-family:Arial;
=09color:windowtext;}
@page Section1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.25in 1.0in 1.25in;
=09mso-header-margin:.5in;
=09mso-footer-margin:.5in;
=09mso-paper-source:0;}
div.Section1
=09{page:Section1;}
-->
</style><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
=09{mso-style-name:"Table Normal";
=09mso-tstyle-rowband-size:0;
=09mso-tstyle-colband-size:0;
=09mso-style-noshow:yes;
=09mso-style-parent:"";
=09mso-padding-alt:0in 5.4pt 0in 5.4pt;
=09mso-para-margin:0in;
=09mso-para-margin-bottom:.0001pt;
=09mso-pagination:widow-orphan;
=09font-size:10.0pt;
=09font-family:"Times New Roman";
=09mso-ansi-language:#0400;
=09mso-fareast-language:#0400;
=09mso-bidi-language:#0400;}
</style>
<![endif]-->

<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: Arial;"=
>Actually my
problem is not related to MAC address restrictions from wireless
interface/driver. The problem lies mainly in multiple bridges for different=
 vlans.
Since bridging happens first, the packet ends up on wrong bridge and gets
discarded form that bridge. <span style=3D"">&nbsp;</span></span>If Vlan
handling is done prior to bridge handling, my setup will work fine. <o:p></=
o:p></p>

<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>

<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: Arial;"=
>There is
also another thing which I did not understand. When we add an interface to
vlan, the newly created interface=E2=80=99s hard_header is set to vlan_dev_=
hard_header
function. This vlan_dev_hard_header adds the vlan tag for outing packet.<o:=
p></o:p></span></p>

<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: Arial;"=
>Interestingly
this happens after bridging code hand over the packet to interface. Convers=
ely when
the packet is received, interface should remove the vlan tag and hand over =
the
packet to bridge. But we are seeing that bridge code is executing prior to =
vlan
handling.<o:p></o:p></span></p>

<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: Arial;"=
><o:p>&nbsp;</o:p></span></p>

<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: Arial;"=
>Regards,<o:p></o:p></span></p>

<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: Arial;"=
><o:p>&nbsp;</o:p></span></p>

<p class=3D"MsoNormal"><st1:personname w:st=3D"on"><span style=3D"font-size=
: 10pt; font-family: Arial;">Rahul Bhardwaj</span></st1:personname><span st=
yle=3D"font-size: 10pt; font-family: Arial;"><o:p></o:p></span></p>

<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: Arial;"=
><o:p>&nbsp;</o:p></span></p>

<div><em>&nbsp;</em></div><br><br>--- On <b>Mon, 22/9/08, Stephen Hemminger=
 <i>&lt;shemminger@vyatta.com&gt;</i></b> wrote:<br><blockquote style=3D"bo=
rder-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;=
">From: Stephen Hemminger &lt;shemminger@vyatta.com&gt;<br>Subject: Re: [Br=
idge] bridge is not forwarding the packet &lt;Urgent, Please reply ASAP&gt;=
<br>To: "rahul bhardwaj" &lt;rahul_bhardwaj36in@yahoo.co.in&gt;<br>Cc: brid=
ge@lists.linux-foundation.org<br>Date: Monday, 22 September, 2008, 8:33 AM<=
br><br><pre>On Mon, 22 Sep 2008 16:24:00 +0530 (IST)<br>rahul bhardwaj &lt;=
rahul_bhardwaj36in@yahoo.co.in&gt; wrote:<br><br>&gt; Hello to all,<br>&gt;=
 <br>&gt; I am stating my problem below in detail so that you all can under=
stand it<br>properly.<br>&gt; <br>&gt; I am having setup of Linux box. In t=
hat box I am having one Ethernet<br>interface eth0 and one wireless interfa=
ce ath0. I have also configured one vlan<br>port as eth0.100 with the
 help of vconfig (vconfig add eth 100).&nbsp; Now I have<br>created two bri=
dges br1 and br100. I have added eth0 into br1 so br1 is having<br>only one=
 interface. I have added ath0 and eth0.100 into br100. Physically eth0<br>i=
s connected to a switch which is configured to handle vlan 100. DHCP server=
 is<br>also running into that switch to provide IP address to wireless stat=
ions. This<br>is all about my setup.<br>&gt; <br>&gt; After this I am assoc=
iating one wireless station with the ath0. After<br>successful association =
station issues a dhclient to get ip address, which<br>reaches to ath0 inter=
face of my Linux box. ath0 bridges that request to<br>eth0.100. Now eth0.10=
0 adds it's vlan tags and forward that request to the<br>switch. Because sw=
itch is configured to support vlan 100, so it process the dhcp<br>request a=
nd send back the dhcp response with vlan tag 100. <br>&gt; <br>&gt; Now I d=
on't know but this response is not reaching to ath0. I
 have<br>putted wireshark and figured out that those dhcp responses are rea=
ching on eth0<br>and as eth0 is part of br1 so this packet is reaching to b=
r1 which is just<br>discarding them all. So the wireless station is not get=
ting the ip address.<br>According to me eth0 should give these packets to e=
th0.100 port instead of br1.<br>Or what I mean to say first vlan handling s=
hould be done priror then&nbsp; bridge<br>handling. Do I need to change som=
ething into Linux kernel for that or there is<br>some other problem with my=
 setup?<br>&gt; <br>&gt; Can anybody help me in this? If anybody want more =
detail I will provide. I<br>am using Linux 2.6.15 kernel. Any kind of help =
will be much appreciated. <br>&gt; <br>&gt; <br>&gt; With Regards <br>&gt; =
<br>&gt; Rahul Bhardwaj <br><br>Full bridging to wireless requires WDS whic=
h Linux wireless does not
 support<br>(yet).<br><br>http://www.linuxfoundation.org/en/Net:Bridge#It_d=
oesn.27t_work_with_my_Wireless_card.21<br>_________________________________=
______________<br>Bridge mailing list<br>Bridge@lists.linux-foundation.org<=
br>https://lists.linux-foundation.org/mailman/listinfo/bridge</pre></blockq=
uote></td></tr></table><br>=0A=0A=0A      <!--8--><hr size=3D1></hr> Share =
files, take polls, and make new friends - all under one roof. <a href=3D"ht=
tp://in.rd.yahoo.com/tagline_groups_8/*http://in.promos.yahoo.com/groups/">=
 Click here.</a>
--0-638661803-1222176701=:58969--
