MIME-Version: 1.0
Message-ID: <458B7ADF.000035.18540@bj163app11.163.com>
Date: Fri, 22 Dec 2006 14:27:43 +0800 (CST)
From: "llsherry" <llsherry@163.com>
Content-Type: multipart/alternative;
	boundary="Boundary-=_cmNeVYVzQyuAIQMxAmKRkPWSgZcO"
Subject: [Bridge] Can bridge be  'seen'  by ip6tables?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge <bridge@lists.osdl.org>

This is a multi-part message in MIME format...

--Boundary-=_cmNeVYVzQyuAIQMxAmKRkPWSgZcO
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


     Hello!=20=20=20=20
     Recently,I=A1=AFm doing a security project based upon ipv6.I have buil=
t up a bridge to support a transparent firewall.(my system is Fedora Core 2=
,kernel 2.6.5).In this system ,the version of the iptables is 1.2.7,which d=
oes not support ipv6(I have tried it).Thus,I download a new version and tes=
t it.
     The iptables functions in bridge mode,but the ipv6 doesn't work well.I=
n the bridge mode,ip6tables can=A1=AFt prevent the packet when I use =A1=B0=
ip6tables =A8CA FORWARD =A8Cj DROP=A1=B1. I use the command"ls/proc/sys/net=
/bridge",it shows bridge-nf-call-iptables,bridge-nf-call-arptables,bridge-n=
f-filter-vlan-tagged.The problem is I can't find bridge-nf-call-ip6tables.
     I have searched a lot of information,all said that the kernel2.6 have =
the bridge-nf code.Could you please tell me how to let the bridged packets =
be 'seen' by ip6tables?
     Thank you very much!
                                                                    sherry
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20
=20

--Boundary-=_cmNeVYVzQyuAIQMxAmKRkPWSgZcO
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<DIV >
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3D=
EN-US><FONT face=3D"Times New Roman">&nbsp;&nbsp;&nbsp;&nbsp;</FONT><FONT D=
EFANGED_face=3D"=CB=CE=CC=E5"> Hello!&nbsp;&nbsp;&nbsp; </FONT></SPAN></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3D=
EN-US>&nbsp;&nbsp;&nbsp;&nbsp; Recently,I=A1=AFm doing a security project b=
ased upon ipv6.I have built up a bridge to support a transparent firewall.(=
my system is Fedora Core 2,kernel <?xml:namespace prefix =3D st1 ns =3D "ur=
n:schemas-microsoft-com:office:smarttags" /><DEFANGED_st1:chsdate w:st=3D"o=
n" IsROCDate=3D"False" IsLunarDate=3D"False" Day=3D"30" Month=3D"12" Year=
=3D"1899">2.6.5</DEFANGED_st1:chsdate>).In this system ,the version of the =
iptables is 1.2.7,which does not support ipv6(I have tried it).Thus,I downl=
oad a new version and test it.</SPAN></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3D=
EN-US>&nbsp;&nbsp;&nbsp;&nbsp; The iptables functions in bridge mode,but th=
e ipv6 doesn't work well.In the bridge mode,ip6tables can=A1=AFt prevent th=
e packet when I use =A1=B0ip6tables =A8CA FORWARD =A8Cj DROP=A1=B1. I use t=
he command"ls/proc/sys/net/bridge",it shows bridge-nf-call-iptables,bridge-=
nf-call-arptables,bridge-nf-filter-vlan-tagged.</SPAN><SPAN lang=3DEN-US>Th=
e problem is I can't find bridge-nf-call-ip6tables.</SPAN></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3D=
EN-US>&nbsp;&nbsp;&nbsp;&nbsp; I have searched a lot of information,all sai=
d that the kernel2.6 have the bridge-nf code.Could you please tell me how t=
o let the bridged packets be 'seen' by ip6tables?</SPAN></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3D=
EN-US>&nbsp;&nbsp;&nbsp;&nbsp; Thank you very much!</SPAN></P></DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sherry</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV ></DIV><br><!-- footer --><br><hr>
<a DEFANGED_style=3D"font-size:12px;line-height:15px; color:#000; text-deco=
ration:none" href=3D"http://www.126.com/">=CF=EB=C3=E2=B7=D1=BB=F1=B5=C3=B8=
=DF=CB=D9=CE=C8=B6=A8=B5=C43G=D3=CA=CF=E4=C2=F0=A3=BF <span DEFANGED_style=
=3D"font-family:Tahoma; text-decoration:underline; color:blue">www.126.com<=
/span> </a>
--Boundary-=_cmNeVYVzQyuAIQMxAmKRkPWSgZcO--
