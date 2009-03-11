Message-ID: <SNT105-W1906EABDD9187F5D107A1EB99E0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_babf225a-c2d0-475c-b775-9898b62af8ce_"
From: Dharani Koppisetti <dkoppisetti@hotmail.com>
Date: Tue, 10 Mar 2009 22:51:30 -0400
MIME-Version: 1.0
Subject: [Bridge] FW: Selecting a Root port on a bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--_babf225a-c2d0-475c-b775-9898b62af8ce_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


=20


From: dkoppisetti@hotmail.com
To: shemminger@osdl.org
Subject: Selecting a Root port on a bridge
Date: Tue=2C 10 Mar 2009 22:29:38 -0400



Hi=2C
i have setup a bridge which has 5 ethernet ports. 2 of the ethernet ports a=
re on board and 3 are on add boards.
The 2 ports on the ethernet PMC are eth0 and eth1. The onboard ethernet por=
ts are eth2 and eth3. There is a FPGA on the board that has the other ether=
net port.=20
I would like the root port of the bridge to be eth2 instead of eth0. Is the=
re a way to set it up. I am using the following script from=20
http://www.faqs.org/docs/Linux-HOWTO/BRIDGE-STP-HOWTO.html
=20
=20
When I enter ifconfig the bridge shows an ip address of 192.168.100.5 the m=
ac address listed is the address of eth0.=20
What I need is to have the ip address listed on the mac address that is on =
eth2.
=20
Please let me know if there is a way.=20
=20
=20
#! /bin/bash
# Copyright (c) 2000 Uwe B=F6hme.  All rights reserved.
#
# Author: Uwe B=F6hme <uwe@bnhof.de>=2C 2000
#
#
# /sbin/init.d/bridge
#

. /etc/rc.config

return=3D$rc_done
case "$1" in

    start)
        echo "Starting service bridge mueb"
        brctl addbr mueb  ||  return=3D$rc_failed                          =
  =20
        brctl setbridgeprio mueb 0 || return=3D$rc_failed                  =
  =20
        brctl addif mueb eth0  ||  return=3D$rc_failed                     =
  =20
        brctl addif mueb eth1  ||  return=3D$rc_failed                     =
  =20
        brctl addif mueb eth2  ||  return=3D$rc_failed                     =
  =20
        brctl addif mueb eth3  ||  return=3D$rc_failed                     =
  =20
        brctl addif mueb eth4  ||  return=3D$rc_failed                     =
  =20
        brctl addif mueb eth5  ||  return=3D$rc_failed                     =
  =20
        ifconfig eth0 0.0.0.0  ||  return=3D$rc_failed                     =
  =20
        ifconfig eth1 0.0.0.0  ||  return=3D$rc_failed                     =
  =20
        ifconfig eth2 0.0.0.0  ||  return=3D$rc_failed                     =
  =20
        ifconfig eth3 0.0.0.0  ||  return=3D$rc_failed =20

ifconfig eth4 0.0.0.0  ||  return=3D$rc_failed
ifconfig eth5 0.0.0.0  ||  return=3D$rc_failed                     =20
ifconfig meub 192.168.100.5 netmask 255.255.255.0
brctl sethello mueb 1  ||  return=3D$rc_failed                       =20
        brctl setmaxage mueb 4  ||  return=3D$rc_failed                    =
  =20
        brctl setfd mueb 4  ||  return=3D$rc_failed                        =
  =20
        echo -e "$return"
        =3B=3B

    stop)
        echo "Shutting down service bridge mueb"
        brctl delif mueb eth3  ||  return=3D$rc_failed                     =
  =20
        brctl delif mueb eth2  ||  return=3D$rc_failed                     =
  =20
        brctl delif mueb eth1  ||  return=3D$rc_failed                     =
  =20
        brctl delif mueb eth0  ||  return=3D$rc_failed                     =
  =20
        brctl delbr mueb  ||  return=3D$rc_failed                          =
  =20
        rmmod bridge || return=3D$rc_failed                                =
  =20

        echo -e "$return"
        =3B=3B

    status)
        ifconfig mueb
        brctl showbr mueb
=3B=3B

    restart)
        $0 stop && $0 start || return=3D$rc_failed
        =3B=3B

    *)
        echo "Usage: $0 {start|stop|status|restart}"
        exit 1
esac

test "$return" =3D "$rc_done" || exit 1
exit 0
=20
=20
Thanks=2C
DK


--_babf225a-c2d0-475c-b775-9898b62af8ce_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
&nbsp=3B<BR>
<HR id=3DstopSpelling>
From: dkoppisetti@hotmail.com<BR>To: shemminger@osdl.org<BR>Subject: Select=
ing a Root port on a bridge<BR>Date: Tue=2C 10 Mar 2009 22:29:38 -0400<BR><=
BR>
<STYLE>
.ExternalClass .EC_hmmessage P
{padding:0px=3B}
.ExternalClass body.EC_hmmessage
{font-size:10pt=3Bfont-family:Verdana=3B}
</STYLE>
Hi=2C<BR>i have setup a bridge which has&nbsp=3B5 ethernet ports.&nbsp=3B2 =
of the ethernet ports are on board and 3 are on add boards.<BR>The 2 ports&=
nbsp=3Bon the ethernet PMC are&nbsp=3Beth0 and eth1. The onboard ethernet p=
orts are eth2 and eth3. There is a FPGA on the board that has the other eth=
ernet port. <BR>I would like the root port of the bridge&nbsp=3Bto be eth2 =
instead of eth0. Is there a way to set it up. I am using the following scri=
pt from <BR><A href=3D"http://www.faqs.org/docs/Linux-HOWTO/BRIDGE-STP-HOWT=
O.html">http://www.faqs.org/docs/Linux-HOWTO/BRIDGE-STP-HOWTO.html</A><BR>&=
nbsp=3B<BR>&nbsp=3B<BR>When I enter ifconfig the bridge shows an ip address=
 of 192.168.100.5 the mac address listed is the address of eth0. <BR>What I=
 need is to have the ip address listed on the mac address that is on eth2.<=
BR>&nbsp=3B<BR>Please let me know if there is a way. <BR>&nbsp=3B<BR>&nbsp=
=3B<BR>#! /bin/bash<BR># Copyright (c) 2000 Uwe B=F6hme.&nbsp=3B All rights=
 reserved.<BR>#<BR># Author: Uwe B=F6hme &lt=3Buwe@bnhof.de&gt=3B=2C 2000<B=
R>#<BR>#<BR># /sbin/init.d/bridge<BR>#<BR><BR>. /etc/rc.config<BR><BR>retur=
n=3D$rc_done<BR>case "$1" in<BR><BR>&nbsp=3B&nbsp=3B&nbsp=3B start)<BR>&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B echo "Starting service=
 bridge mueb"<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B b=
rctl addbr mueb&nbsp=3B ||&nbsp=3B return=3D$rc_failed&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B<A name=3DCREA=
TE-BRIDGE></A><BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B =
brctl setbridgeprio mueb 0 || return=3D$rc_failed&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B<A name=
=3DSET-ROOT-BRIDGE></A><BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B brctl addif mueb eth0&nbsp=3B ||&nbsp=3B return=3D$rc_failed&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B<A name=3DADDIF-ETH0></A><BR>&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B brctl addif mueb eth1&nbsp=
=3B ||&nbsp=3B return=3D$rc_failed&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B<A name=3DADDIF-ETH1></A><BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B brctl addif mueb eth2&nbsp=3B ||&nbsp=3B return=3D$rc_failed&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B<A name=3DADDIF-ETH2></A><BR>&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B brctl addif mueb eth3=
&nbsp=3B ||&nbsp=3B return=3D$rc_failed&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B<A name=3DADDIF-ETH3></A><BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B brctl addif mueb eth4&nbsp=3B ||&nbsp=3B return=3D$rc_f=
ailed&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B<BR>&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B brctl addif mueb eth5&nbsp=3B ||&nbsp=
=3B return=3D$rc_failed&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B<A name=
=3DADDIF-ETH3></A><BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B ifconfig eth0 0.0.0.0&nbsp=3B ||&nbsp=3B return=3D$rc_failed&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B<A name=3DUP-ETH0></A><BR>&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B ifconfig eth1 0.0.0.0&nbsp=3B ||&nb=
sp=3B return=3D$rc_failed&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B<A name=
=3DUP-ETH1></A><BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
 ifconfig eth2 0.0.0.0&nbsp=3B ||&nbsp=3B return=3D$rc_failed&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B<A name=3DUP-ETH2></A><BR>&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B ifconfig eth3 0.0.0.0&nbsp=3B ||&nbsp=
=3B return=3D$rc_failed&nbsp=3B&nbsp=3B<BR>
<BLOCKQUOTE dir=3Dltr style=3D"MARGIN-RIGHT: 0px">ifconfig eth4 0.0.0.0&nbs=
p=3B ||&nbsp=3B return=3D$rc_failed<BR>ifconfig eth5 0.0.0.0&nbsp=3B ||&nbs=
p=3B return=3D$rc_failed&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B<A name=3DUP-ETH3></A><B=
R>ifconfig meub 192.168.100.5 netmask 255.255.255.0<BR>brctl sethello mueb =
1&nbsp=3B ||&nbsp=3B return=3D$rc_failed&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B<BR></BLOCKQUOTE>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B brctl setmaxage mueb 4&nbsp=3B ||&nbsp=3B return=3D$rc_failed&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B brctl setfd mueb 4&nbsp=3B ||&nbsp=3B return=3D$rc_failed&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B<BR>&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B echo -e "$return"<BR>&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B =3B=3B<BR><BR>&nbsp=
=3B&nbsp=3B&nbsp=3B stop)<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B echo "Shutting down service bridge mueb"<BR>&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B brctl delif mueb eth3&nbsp=3B ||&nbsp=
=3B return=3D$rc_failed&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B<BR>&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B brctl delif mueb eth2&=
nbsp=3B ||&nbsp=3B return=3D$rc_failed&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B brctl del=
if mueb eth1&nbsp=3B ||&nbsp=3B return=3D$rc_failed&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B brctl delif mueb eth0&nbsp=3B ||&nbsp=3B return=3D$rc_failed&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B brctl delbr mueb&nbsp=3B ||&nbsp=3B return=3D$rc_failed=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B rmmod =
bridge || return=3D$rc_failed&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B<BR><BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
 echo -e "$return"<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B =3B=3B<BR><BR>&nbsp=3B&nbsp=3B&nbsp=3B status)<BR>&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B ifconfig mueb<BR>&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B brctl showbr mueb<BR>=3B=3B<BR><BR>&nbs=
p=3B&nbsp=3B&nbsp=3B restart)<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B $0 stop &amp=3B&amp=3B $0 start || return=3D$rc_failed<BR>&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B =3B=3B<BR><BR>&nbsp=
=3B&nbsp=3B&nbsp=3B *)<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B echo "Usage: $0 {start|stop|status|restart}"<BR>&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B exit 1<BR>esac<BR><BR>test "$return" =
=3D "$rc_done" || exit 1<BR>exit 0<BR>&nbsp=3B<BR>&nbsp=3B<BR>Thanks=2C<BR>=
DK<BR><BR></body>
</html>=

--_babf225a-c2d0-475c-b775-9898b62af8ce_--
