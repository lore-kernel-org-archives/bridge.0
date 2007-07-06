Date: Fri, 6 Jul 2007 13:46:20 +1000
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Message-ID: <H0000069001d36e5.1183693579.mail.pacificwireless.net.au@MHS>
In-Reply-To: <2e59e6970707051702x7d264db4te7a34f7b6db0a5ee@mail.gmail.com>
Subject: RE: [Bridge] jumpstart stp port to forwarding state
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="2_0_16f_d1fd20MHTML_=_01"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge <bridge@lists.linux-foundation.org>, richardvoigt <richardvoigt@gmail.com>

--2_0_16f_d1fd20MHTML_=_01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

brctl setfd br0 0
=20
Sets the forwarding delay on the bridge to 0, making it forward
immediately, instead of going into 'learning' mode. This affects the
entire bridge, not just a single port.
=20
=20
Regards,
             Leigh
=20
Leigh Sharpe
Network Systems Engineer
Pacific Wireless
Ph +61 3 9584 8966
Mob 0408 009 502
Helpdesk 1300 300 616
email lsharpe@pacificwireless.com.au
web www.pacificwireless.com.au
=20

  _____ =20

From: richardvoigt@gmail.com [mailto:richardvoigt@gmail.com]=20
Sent: Friday, July 06, 2007 10:03 AM
To: bridge@lists.linux-foundation.org
Subject: [Bridge] jumpstart stp port to forwarding state


Sorry if this is a dupe, but the mailing list join email got delayed by
10 or 12 hours and so I think this message wasn't accepted:

----------------

I've googled for this, but since there are so many pages talking about
linux boxes connected to CIsco equipment, I can't find anything
relevant.=20

Does linux bridging support anything like cisco's portfast (port starts
in forwarding state)?  Is there a way (sysfs, ioctl) to at least change
a port to forwarding immediately?  Even bridges with stp disabled take
some time bringing ports up after a topology change.  If the delay can't
be eliminated, can I wait for it somehow in my startup scripts to avoid
initial connection failures?=20

My preference would be to have something like:

brctl portfast br0 bond0.10 on

or

brctl initialstate br0 bond0.10 forwarding



Also, can stp disable all ports in the same bridge?  I would assume not,
a minimum spanning tree needs at least one port forwarding (could that
port somehow be a different interface on the same box, not a member of
the bridge?).  If at least one port is always forwarding, could the
minimum cost port be set to forwarding by default when the bridge is
brought up (ip link set br0 up) irrespective of any portfast-alike
setting?=20

I'm trying to minimize startup time on a firewall.

Thanks for any information you can provide.

Ben Voigt




--2_0_16f_d1fd20MHTML_=_01
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>

<META content=3D"MSHTML 6.00.2800.1491" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D986184703-06072007><FONT face=3D=
Arial=20
size=3D2>brctl setfd br0 0</FONT></SPAN>
</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D986184703-06072007><FONT face=3D=
Arial=20
size=3D2></FONT></SPAN>&nbsp;
</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D986184703-06072007><FONT face=3D=
Arial=20
size=3D2>Sets the forwarding delay on the bridge to 0, making it forward=20
immediately, instead of going into 'learning' mode. This affects the enti=
re=20
bridge, not just a single port.</FONT></SPAN>
</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D986184703-06072007></SPAN>&nbsp=
;
</DIV>
<DIV>&nbsp;
</DIV>
<DIV align=3Dleft>
<DIV align=3Dleft><FONT face=3DArial=20
size=3D2>Regards,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Leigh</FONT>
</DIV>
<DIV>&nbsp;
</DIV>
<DIV><FONT face=3DArial size=3D2>Leigh Sharpe<BR>
Network Systems Engineer<BR>
Pacific=20
Wireless<BR>
Ph +61 3 9584 8966<BR>
Mob 0408 009 502</FONT>
</DIV>
<DIV><FONT face=3DArial size=3D2>Helpdesk 1300 300 616<BR>
email <A=20
title=3Dmailto:lsharpe@pacificwireless.com.au=20
href=3D"blocked::mailto:lsharpe@pacificwireless.com.au">lsharpe@pacificwi=
reless.com.au</A><BR>
web=20
<A title=3Dhttp://www.pacificwireless.com.au/=20
href=3D"blocked::http://www.pacificwireless.com.au/">www.pacificwireless.=
com.au</A></FONT>
</DIV></DIV>
<DIV>&nbsp;
</DIV><BR>

<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>&#160;&#160;


<FONT face=3DTahoma size=3D2><B>From:</B> richardvoigt@gmail.com=20
[mailto:richardvoigt@gmail.com] <BR>
<B>Sent:</B> Friday, July 06, 2007 10:03=20
AM<BR>
<B>To:</B> bridge@lists.linux-foundation.org<BR>
<B>Subject:</B> [Bridge]=20
jumpstart stp port to forwarding state<BR>
</FONT><BR>

</DIV>
<DIV></DIV><SPAN class=3Dgmail_quote>
<P>Sorry if this is a dupe, but the mailing list join email got delayed b=
y 10 or=20
12 hours and so I think this message wasn't=20
accepted:<BR>
<BR>
----------------<BR>
<BR>
</SPAN>I've googled for this, but since=20
there are so many pages talking about linux boxes connected to CIsco equi=
pment,=20
I can't find anything relevant. <BR>
<BR>
Does linux bridging support anything=20
like cisco's portfast (port starts in forwarding state)?&nbsp; Is there a=
 way=20
(sysfs, ioctl) to at least change a port to forwarding immediately?&nbsp;=
 Even=20
bridges with stp disabled take some time bringing ports up after a topolo=
gy=20
change.&nbsp; If the delay can't be eliminated, can I wait for it somehow=
 in my=20
startup scripts to avoid initial connection failures? <BR>
<BR>
My preference=20
would be to have something like:<BR>
<BR>
brctl portfast br0 bond0.10=20
on<BR>
<BR>
or<BR>
<BR>
brctl initialstate br0 bond0.10=20
forwarding<BR>
<BR>
<BR>
<BR>
Also, can stp disable all ports in the same=20
bridge?&nbsp; I would assume not, a minimum spanning tree needs at least o=
ne=20
port forwarding (could that port somehow be a different interface on the s=
ame=20
box, not a member of the bridge?).&nbsp; If at least one port is always=20
forwarding, could the minimum cost port be set to forwarding by default w=
hen the=20
bridge is brought up (ip link set br0 up) irrespective of any portfast-al=
ike=20
setting? <BR>
<BR>
I'm trying to minimize startup time on a=20
firewall.<BR>
<BR>
Thanks for any information you can provide.<BR>
<BR>
Ben=20
Voigt<BR>


</P></BODY></HTML>
--2_0_16f_d1fd20MHTML_=_01--
