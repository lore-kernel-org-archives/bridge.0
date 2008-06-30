From: "John Van Boxtel" <johnvb@broadcom.com>
Date: Mon, 30 Jun 2008 09:29:20 -0700
Message-ID: <AED19734ADE06A4191FFC760030362C705BD6DD410@IRVEXCHCCR01.corp.ad.broadcom.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary=_000_AED19734ADE06A4191FFC760030362C705BD6DD410IRVEXCHCCR01c_
Subject: [Bridge] Flooding before or after NF_BR_LOCAL_OUT hook
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>


--_000_AED19734ADE06A4191FFC760030362C705BD6DD410IRVEXCHCCR01c_
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

Has it been previously discussed whether bridge flooding should be done bef=
ore or after the NF_BR_LOCAL_OUT hook?

Today it is done AFTER but logically it seems like it should be done BEFORE=
 (on "ingress").  I think this would be analogous to operation of the NF_IP=
_LOCAL_OUT hook when IP multicasting.

Regards,

John A. Van Boxtel


--_000_AED19734ADE06A4191FFC760030362C705BD6DD410IRVEXCHCCR01c_
Content-Type: text/html;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3314" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D316225415-30062008><FONT face=3DArial size=3D2>Hi=20
all,</FONT></SPAN></DIV>
<DIV><SPAN class=3D316225415-30062008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D316225415-30062008><FONT face=3DArial size=3D2>Has it be=
en=20
previously&nbsp;discussed&nbsp;whether bridge flooding should be done befor=
e or=20
after the NF_BR_LOCAL_OUT hook?</FONT></SPAN></DIV>
<DIV><SPAN class=3D316225415-30062008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D316225415-30062008><FONT face=3DArial size=3D2>Today it =
is done=20
AFTER&nbsp;but logically it seems like it should be done BEFORE (on=20
"ingress").&nbsp; I think this would be analogous to operation of=20
the&nbsp;NF_IP_LOCAL_OUT hook when IP multicasting.</FONT></SPAN></DIV>
<DIV><SPAN class=3D316225415-30062008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D316225415-30062008><FONT face=3DArial=20
size=3D2>Regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D316225415-30062008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D316225415-30062008><FONT face=3DArial size=3D2>John A. V=
an=20
Boxtel</FONT></SPAN></DIV>
<DIV><SPAN class=3D316225415-30062008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV></BODY></HTML>

--_000_AED19734ADE06A4191FFC760030362C705BD6DD410IRVEXCHCCR01c_--

