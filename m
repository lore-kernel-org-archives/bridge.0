MIME-Version: 1.0
In-Reply-To: 
References: 
From: Pravin Pardeshi <pravin.pardeshi@tcs.com>
Message-ID: <OFD643E4FF.BA761D6E-ON652577F4.004E3BAB-652577F4.00593751@tcs.com>
Date: Thu, 9 Dec 2010 21:44:28 +0530
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"
Subject: [Bridge] ksoftirqd process
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

<FONT face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" size=
=3D2><DIV>Hi, </DIV><DIV>I want to have bridge for two NICs (eth0 and eth1)=
 with&nbsp;Knoppix 6.2 Live CD on virtualbox. I tried the following command=
s; </DIV><DIV>&nbsp; </DIV><DIV># brctl addbr br0 </DIV><DIV># brctl sethel=
lo 30 </DIV><DIV># brctl stp br0 off </DIV><DIV>&nbsp; </DIV><DIV># ifconfi=
g eth0 0.0.0.0 </DIV><DIV># ifconfig eth1 0.0.0.0 <BR></DIV><DIV># ifconfig=
 eth0 down </DIV><DIV># ifconfig eth1 down </DIV><DIV>&nbsp; </DIV><DIV># b=
rctl addif br0 eth0 </DIV><DIV># brctl addif br0 eth1 </DIV><DIV>&nbsp; </D=
IV><DIV>After the addition of&nbsp;eth0 and eth1 to the bridge, the ksoftir=
q gets kicked off and starts consuming CPU. The connection to network is lo=
st. The CPU utilization never stabilizes even after waiting for 10-15 minut=
es. Knoppix 6.2 has kernel 2.6.32.6 and bridge-utils is the latest version =
from debian repositories. </DIV><DIV>&nbsp; </DIV><DIV>Firstly,&nbsp;am I m=
issing something? </DIV><DIV>Secondly, is it possible to have a setup I am =
attempting with the live cd?&nbsp; </DIV><DIV>&nbsp; </DIV><DIV>Thanks, </D=
IV><DIV>Pravin </DIV></FONT><pre style=3D"white-space:normal">=3D=3D=3D=3D=
=3D-----=3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D<br>Notice: The information cont=
ained in this e-mail<br>message and/or attachments to it may contain <br>co=
nfidential or privileged information. If you are <br>not the intended recip=
ient, any dissemination, use, <br>review, distribution, printing or copying=
 of the <br>information contained in this e-mail message <br>and/or attachm=
ents to it are strictly prohibited. If <br>you have received this communica=
tion in error, <br>please notify us by reply e-mail or telephone and <br>im=
mediately and permanently delete the message <br>and any attachments. Thank=
 you<br><br><br></pre>
