Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C91E9C.9E9E17A0"
Date: Thu, 25 Sep 2008 09:23:58 +1000
Message-ID: <96CF49BD8B56384395D698BA99007FA32FA42C@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Subject: Re: [Bridge] bridge is not forwarding the packet
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>, bridge@lists.linux-foundation.org
Cc: Stephen Hemminger <shemminger@vyatta.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C91E9C.9E9E17A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Rahul,
 If you're certain that your problem isn't as Stephen suggested, you
might want to have a look at this:
=20
---

(From http://ebtables.sourceforge.net/brnf-faq.html
<http://ebtables.sourceforge.net/brnf-faq.html>  )

How do I let vlan-tagged traffic go through a vlan bridge port and the
other traffic through a non-vlan bridge port?=20

Suppose eth0 and eth0.15 are ports of br0. Without countermeasures all
traffic, including traffic vlan-tagged with tag 15, entering the

physical device eth0 will go through the bridge port eth0. To make the
15-tagged traffic go through the eth0.15 bridge port, use the following

ebtables rule:=20

ebtables -t broute -A BROUTING -i eth0 --vlan-id 15 -j DROP

With the above rule, 15-tagged traffic will enter the bridge on the
physical device eth0, will then be brouted and enter the bridge port
eth0.15, the vlan header will be stripped, after which the packet is
bridged. The packet thus enters the BROUTING chain twice, the first time
with input device eth0 and the second time with input device eth0.15.

The other chains are only traversed once. All other traffic will be
bridged with input device eth0.=20

----

This describes how to make sure your VLAN tagged traffic ends up on the
bridge you want.

=20
________________________________

From: bridge-bounces@lists.linux-foundation.org
[mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of rahul
bhardwaj
Sent: Tuesday, 23 September 2008 11:32 PM
To: bridge@lists.linux-foundation.org
Cc: Stephen Hemminger
Subject: Re: [Bridge] bridge is not forwarding the packet


Hi Stephen,

Thanks for your very prompt response!



Actually my problem is not related to MAC address restrictions from
wireless interface/driver. The problem lies mainly in multiple bridges
for different vlans. Since bridging happens first, the packet ends up on
wrong bridge and gets discarded form that bridge.  If Vlan handling is
done prior to bridge handling, my setup will work fine.=20

There is also another thing which I did not understand. When we add an
interface to vlan, the newly created interface's hard_header is set to
vlan_dev_hard_header function. This vlan_dev_hard_header adds the vlan
tag for outing packet.

Interestingly this happens after bridging code hand over the packet to
interface. Conversely when the packet is received, interface should
remove the vlan tag and hand over the packet to bridge. But we are
seeing that bridge code is executing prior to vlan handling.

Regards,

Rahul Bhardwaj

=20


--- On Mon, 22/9/08, Stephen Hemminger <shemminger@vyatta.com> wrote:


	From: Stephen Hemminger <shemminger@vyatta.com>
	Subject: Re: [Bridge] bridge is not forwarding the packet
<Urgent, Please reply ASAP>
	To: "rahul bhardwaj" <rahul_bhardwaj36in@yahoo.co.in>
	Cc: bridge@lists.linux-foundation.org
	Date: Monday, 22 September, 2008, 8:33 AM
=09
=09
	On Mon, 22 Sep 2008 16:24:00 +0530 (IST)
	rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in> wrote:
=09
	> Hello to all,
	>=20
	> I am stating my problem below in detail so that you all can
understand it
	properly.
	>=20
	> I am having setup of Linux box. In that box I am having one
Ethernet
	interface eth0 and one wireless interface ath0. I have also
configured one vlan
	port as eth0.100 with the
	 help of vconfig (vconfig add eth 100).  Now I have
	created two bridges br1 and br100. I have added eth0 into br1 so
br1 is having
	only one interface. I have added ath0 and eth0.100 into br100.
Physically eth0
	is connected to a switch which is configured to handle vlan 100.
DHCP server is
	also running into that switch to provide IP address to wireless
stations. This
	is all about my setup.
	>=20
	> After this I am associating one wireless station with the
ath0. After
	successful association station issues a dhclient to get ip
address, which
	reaches to ath0 interface of my Linux box. ath0 bridges that
request to
	eth0.100. Now eth0.100 adds it's vlan tags and forward that
request to the
	switch. Because switch is configured to support vlan 100, so it
process the dhcp
	request and send back the dhcp response with vlan tag 100.=20
	>=20
	> Now I don't know but this response is not reaching to ath0. I
	 have
	putted wireshark and figured out that those dhcp responses are
reaching on eth0
	and as eth0 is part of br1 so this packet is reaching to br1
which is just
	discarding them all. So the wireless station is not getting the
ip address.
	According to me eth0 should give these packets to eth0.100 port
instead of br1.
	Or what I mean to say first vlan handling should be done priror
then  bridge
	handling. Do I need to change something into Linux kernel for
that or there is
	some other problem with my setup?
	>=20
	> Can anybody help me in this? If anybody want more detail I
will provide. I
	am using Linux 2.6.15 kernel. Any kind of help will be much
appreciated.=20
	>=20
	>=20
	> With Regards=20
	>=20
	> Rahul Bhardwaj=20
=09
	Full bridging to wireless requires WDS which Linux wireless does
not
	 support
	(yet).
=09
=09
http://www.linuxfoundation.org/en/Net:Bridge#It_doesn.27t_work_with_my_W
ireless_card.21
	_______________________________________________
	Bridge mailing list
	Bridge@lists.linux-foundation.org
	https://lists.linux-foundation.org/mailman/listinfo/bridge


________________________________

Share files, take polls, and make new friends - all under one roof.
Click here.
<http://in.rd.yahoo.com/tagline_groups_8/*http://in.promos.yahoo.com/gro
ups/>=20

------_=_NextPart_001_01C91E9C.9E9E17A0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1491" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D501461323-24092008><FONT =
face=3DArial=20
size=3D2>Hi Rahul,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D501461323-24092008><FONT =
face=3DArial=20
size=3D2>&nbsp;If you're certain that your problem isn't as Stephen =
suggested, you=20
might want to have a look at this:</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D501461323-24092008><FONT =
face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D501461323-24092008>
<P><FONT face=3DArial size=3D2>---</FONT></P>
<P><FONT face=3DArial size=3D2>(From </FONT><A=20
href=3D"http://ebtables.sourceforge.net/brnf-faq.html"><U><FONT=20
color=3D#0000ff><FONT face=3DArial=20
size=3D2>http://ebtables.sourceforge.net/brnf-faq.html</FONT></U></FONT><=
/A><FONT=20
face=3DArial size=3D2> )</FONT></P>
<P><FONT face=3DArial size=3D2>How do I let vlan-tagged traffic go =
through a vlan=20
bridge port and the<SPAN class=3D501461323-24092008> </SPAN>other =
traffic through=20
a non-vlan bridge port? </FONT></P>
<P><FONT face=3DArial size=3D2>Suppose eth0 and eth0.15 are ports of =
br0. Without=20
countermeasures all<SPAN class=3D501461323-24092008> </SPAN>traffic, =
including=20
traffic vlan-tagged with tag 15, entering the</FONT></P>
<P><FONT face=3DArial size=3D2>physical device eth0 will go through the =
bridge port=20
eth0. To make the<SPAN class=3D501461323-24092008> </SPAN>15-tagged =
traffic go=20
through the eth0.15 bridge port, use the following</FONT></P>
<P><FONT face=3DArial size=3D2>ebtables rule: </FONT></P>
<P><FONT face=3DArial size=3D2>ebtables -t broute -A BROUTING -i eth0 =
--vlan-id 15=20
-j DROP</FONT></P>
<P><FONT face=3DArial size=3D2>With the above rule, 15-tagged traffic =
will enter the=20
bridge on the<SPAN class=3D501461323-24092008> </SPAN>physical device =
eth0, will=20
then be brouted and enter the bridge port<SPAN =
class=3D501461323-24092008>=20
</SPAN>eth0.15, the vlan header will be stripped, after which the packet =
is<SPAN=20
class=3D501461323-24092008> </SPAN>bridged. The packet thus enters the =
BROUTING=20
chain twice, the first time<SPAN class=3D501461323-24092008> </SPAN>with =
input=20
device eth0 and the second time with input device eth0.15.</FONT></P>
<P><FONT face=3DArial size=3D2>The other chains are only traversed once. =
All other=20
traffic will be<SPAN class=3D501461323-24092008> </SPAN>bridged with =
input device=20
eth0. </FONT></P>
<P><FONT face=3DArial size=3D2>----</FONT></P></SPAN></DIV>
<DIV><SPAN class=3D501461323-24092008></SPAN><FONT face=3DArial=20
size=3D2>This&nbsp;describes&nbsp;how&nbsp;to&nbsp;make&nbsp;sure&nbsp;yo=
ur&nbsp;VLAN&nbsp;tagged&nbsp;traffic&nbsp;ends&nbsp;up&nbsp;on&nbsp;the&=
nbsp;bridge&nbsp;you&nbsp;want.</FONT></DIV>
<DIV><SPAN class=3D501461323-24092008></SPAN><FONT face=3DArial=20
size=3D2></FONT><BR>&nbsp;</DIV>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> =
bridge-bounces@lists.linux-foundation.org=20
[mailto:bridge-bounces@lists.linux-foundation.org] <B>On Behalf Of =
</B>rahul=20
bhardwaj<BR><B>Sent:</B> Tuesday, 23 September 2008 11:32 =
PM<BR><B>To:</B>=20
bridge@lists.linux-foundation.org<BR><B>Cc:</B> Stephen=20
Hemminger<BR><B>Subject:</B> Re: [Bridge] bridge is not forwarding the=20
packet<BR></FONT><BR></DIV>
<DIV></DIV>
<TABLE cellSpacing=3D0 cellPadding=3D0 border=3D0>
  <TBODY>
  <TR>
    <TD vAlign=3Dtop>Hi Stephen,<BR><BR>Thanks for your very prompt=20
      response!<BR><BR>
      <META content=3DWord.Document name=3DProgId>
      <META content=3D"Microsoft Word 11" name=3DGenerator>
      <META content=3D"Microsoft Word 11" name=3DOriginator><LINK=20
      =
href=3D"file:///C:%5CDOCUME%7E1%5Crbhardwa%5CLOCALS%7E1%5CTemp%5Cmsohtml1=
%5C01%5Cclip_filelist.xml"=20
      rel=3DFile-List><O:SMARTTAGTYPE name=3D"PersonName"=20
      =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"></O:SMARTTAGT=
YPE><!--[if gte mso 9]><xml>
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
</xml><![endif]--><!--[if !mso]>
      <OBJECT id=3Dieooui=20
      classid=3Dclsid:38481807-CA0E-42D2-BF39-B33AF135CC4D></OBJECT>
      <STYLE>st1\:* {
	BEHAVIOR: url(#ieooui)
}
</STYLE>
<![endif]-->
      <STYLE>@page Section1 {size: 8.5in 11.0in; margin: 1.0in 1.25in =
1.0in 1.25in; mso-header-margin: .5in; mso-footer-margin: .5in; =
mso-paper-source: 0; }
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
SPAN.EmailStyle15 {
	COLOR: windowtext; FONT-FAMILY: Arial; mso-style-type: personal; =
mso-style-noshow: yes; mso-ansi-font-size: 10.0pt; mso-bidi-font-size: =
10.0pt; mso-ascii-font-family: Arial; mso-hansi-font-family: Arial; =
mso-bidi-font-family: Arial
}
DIV.Section1 {
	page: Section1
}
</STYLE>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]-->
      <P class=3DMsoNormal><SPAN=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Actually my problem =
is not=20
      related to MAC address restrictions from wireless =
interface/driver. The=20
      problem lies mainly in multiple bridges for different vlans. Since =

      bridging happens first, the packet ends up on wrong bridge and =
gets=20
      discarded form that bridge. <SPAN>&nbsp;</SPAN></SPAN>If Vlan =
handling is=20
      done prior to bridge handling, my setup will work fine. =
<O:P></O:P></P>
      <P class=3DMsoNormal><O:P></O:P></P>
      <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">There=20
      is also another thing which I did not understand. When we add an =
interface=20
      to vlan, the newly created interface&#8217;s hard_header is set to =

      vlan_dev_hard_header function. This vlan_dev_hard_header adds the =
vlan tag=20
      for outing packet.<O:P></O:P></SPAN></P>
      <P class=3DMsoNormal><SPAN=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Interestingly this =
happens=20
      after bridging code hand over the packet to interface. Conversely =
when the=20
      packet is received, interface should remove the vlan tag and hand =
over the=20
      packet to bridge. But we are seeing that bridge code is executing =
prior to=20
      vlan handling.<O:P></O:P></SPAN></P>
      <P class=3DMsoNormal><SPAN=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><O:P></O:P></SPAN></P>
      <P class=3DMsoNormal><SPAN=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Regards,<O:P></O:P></SPAN></P>
      <P class=3DMsoNormal><SPAN=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><O:P></O:P></SPAN></P>
      <P class=3DMsoNormal><ST1:PERSONNAME w:st=3D"on"><SPAN=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Rahul=20
      Bhardwaj</SPAN></ST1:PERSONNAME><SPAN=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><O:P></O:P></SPAN></P>
      <P class=3DMsoNormal><SPAN=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><O:P></O:P></SPAN></P>
      <DIV><EM></EM>&nbsp;</DIV><BR><BR>--- On <B>Mon, 22/9/08, Stephen=20
      Hemminger <I>&lt;shemminger@vyatta.com&gt;</I></B> wrote:<BR>
      <BLOCKQUOTE=20
      style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: =
rgb(16,16,255) 2px solid">From:=20
        Stephen Hemminger &lt;shemminger@vyatta.com&gt;<BR>Subject: Re: =
[Bridge]=20
        bridge is not forwarding the packet &lt;Urgent, Please reply=20
        ASAP&gt;<BR>To: "rahul bhardwaj"=20
        &lt;rahul_bhardwaj36in@yahoo.co.in&gt;<BR>Cc:=20
        bridge@lists.linux-foundation.org<BR>Date: Monday, 22 September, =
2008,=20
        8:33 AM<BR><BR><PRE>On Mon, 22 Sep 2008 16:24:00 +0530 =
(IST)<BR>rahul bhardwaj &lt;rahul_bhardwaj36in@yahoo.co.in&gt; =
wrote:<BR><BR>&gt; Hello to all,<BR>&gt; <BR>&gt; I am stating my =
problem below in detail so that you all can understand =
it<BR>properly.<BR>&gt; <BR>&gt; I am having setup of Linux box. In that =
box I am having one Ethernet<BR>interface eth0 and one wireless =
interface ath0. I have also configured one vlan<BR>port as eth0.100 with =
the
 help of vconfig (vconfig add eth 100).&nbsp; Now I have<BR>created two =
bridges br1 and br100. I have added eth0 into br1 so br1 is =
having<BR>only one interface. I have added ath0 and eth0.100 into br100. =
Physically eth0<BR>is connected to a switch which is configured to =
handle vlan 100. DHCP server is<BR>also running into that switch to =
provide IP address to wireless stations. This<BR>is all about my =
setup.<BR>&gt; <BR>&gt; After this I am associating one wireless station =
with the ath0. After<BR>successful association station issues a dhclient =
to get ip address, which<BR>reaches to ath0 interface of my Linux box. =
ath0 bridges that request to<BR>eth0.100. Now eth0.100 adds it's vlan =
tags and forward that request to the<BR>switch. Because switch is =
configured to support vlan 100, so it process the dhcp<BR>request and =
send back the dhcp response with vlan tag 100. <BR>&gt; <BR>&gt; Now I =
don't know but this response is not reaching to ath0. I
 have<BR>putted wireshark and figured out that those dhcp responses are =
reaching on eth0<BR>and as eth0 is part of br1 so this packet is =
reaching to br1 which is just<BR>discarding them all. So the wireless =
station is not getting the ip address.<BR>According to me eth0 should =
give these packets to eth0.100 port instead of br1.<BR>Or what I mean to =
say first vlan handling should be done priror then&nbsp; =
bridge<BR>handling. Do I need to change something into Linux kernel for =
that or there is<BR>some other problem with my setup?<BR>&gt; <BR>&gt; =
Can anybody help me in this? If anybody want more detail I will provide. =
I<BR>am using Linux 2.6.15 kernel. Any kind of help will be much =
appreciated. <BR>&gt; <BR>&gt; <BR>&gt; With Regards <BR>&gt; <BR>&gt; =
Rahul Bhardwaj <BR><BR>Full bridging to wireless requires WDS which =
Linux wireless does not
 =
support<BR>(yet).<BR><BR>http://www.linuxfoundation.org/en/Net:Bridge#It_=
doesn.27t_work_with_my_Wireless_card.21<BR>______________________________=
_________________<BR>Bridge mailing =
list<BR>Bridge@lists.linux-foundation.org<BR>https://lists.linux-foundati=
on.org/mailman/listinfo/bridge</PRE></BLOCKQUOTE></TD></TR></TBODY></TABL=
E><BR><!--8-->
<HR SIZE=3D1>
</HR>Share files, take polls, and make new friends - all under one roof. =
<A=20
href=3D"http://in.rd.yahoo.com/tagline_groups_8/*http://in.promos.yahoo.c=
om/groups/">Click=20
here.</A></BODY></HTML>

------_=_NextPart_001_01C91E9C.9E9E17A0--
