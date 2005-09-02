Message-ID: <434f7cd7050902102561a0cc84@mail.gmail.com>
Date: Fri, 2 Sep 2005 20:25:35 +0300
From: Daniel Gheorghica <gheodan@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_20119_24048333.1125681935881"
Subject: [Bridge] STP problem
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_20119_24048333.1125681935881
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,=20
 I have to use STP function between too bridges. The network topology are:
 /--------------\ / ------ Wireless Link ----\ /--------------------\
|=3D=3DLAN1=3D=3D| ---- | BRIDGE 1| | BRIDGE 2| -----| =3D=3D=3DLAN 2=3D=3D=
=3D |=20
\---------------/ \ -----TINC vpn tunnel ------/ \---------------------/
 When one of link failed the ping from one to other site stop to works.=20
I use bridge-utils-1.0.6 and tinc-1.0.4=20
 I wait any suggestion about this
 Daniel=20
  The bridege setup script is:=20
=20=20
#! /bin/bash

PATH=3D$PATH:/usr/local/sbin:/sbin
BR=3Dbr0
IP=3D"172.16.3.223 <http://172.16.3.223>"
MASK=3D"255.255.252.0 <http://255.255.252.0>"
BROADCAST=3D"172.16.3.255 <http://172.16.3.255>"

return=3D$rc_done
case "$1" in

start)
echo "Starting service bridge $BR"
tincd -n vpn
brctl addbr $BR
brctl setbridgeprio $BR 0 || return=3D$rc_failed
brctl addif $BR eth0 || return=3D$rc_failed
brctl addif $BR eth1 || return=3D$rc_failed
brctl addif $BR vpn || return=3D$rc_failed
ifconfig eth0 0.0.0.0 <http://0.0.0.0> || return=3D$rc_failed
ifconfig eth1 0.0.0.0 <http://0.0.0.0> || return=3D$rc_failed
ifconfig vpn 0.0.0.0 <http://0.0.0.0> || return=3D$rc_failed
brctl sethello $BR 1 || return=3D$rc_failed
brctl setmaxage $BR 4 || return=3D$rc_failed
brctl setpathcost $BR eth1 100 || return=3D$rc_failed

brctl setpathcost $BR vpn 100 || return=3D$rc_failed
brctl setportprio $BR eth1 20 || return=3D$rc_failed
brctl setportprio $BR vpn 20 || return=3D$rc_failed
# brctl setageing $BR 20 || return=3D$rc_failed
brctl setfd $BR 4 || return=3D$rc_failed
brctl stp $BR on
/sbin/ifconfig $BR inet $IP netmask $MASK broadcast $BROADCAST up
echo -e "$return"
;;

stop)
tincd -k -n vpn
/sbin/ifconfig $BR down
echo "Shutting down service bridge $BR"
brctl delif $BR vpn || return=3D$rc_failed
brctl delif $BR eth0 || return=3D$rc_failed
brctl delif $BR eth1 || return=3D$rc_failed
brctl delbr $BR || return=3D$rc_failed
rmmod bridge || return=3D$rc_failed
echo -e "$return"
;;

status)
ifconfig $BR
brctl showstp $BR
brctl show
;;

restart)
$0 stop && $0 start || return=3D$rc_failed
;;

*)

echo "Usage: $0 {start|stop|status|restart}"
exit 1
esac

test "$return" =3D "$rc_done" || exit 1
exit 0

------=_Part_20119_24048333.1125681935881
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi all, </div>
<div>&nbsp;</div>
<div>I have to use STP function between too bridges. The network topology a=
re:</div>
<div>&nbsp;</div>
<div>/--------------\&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; / ------ Wireless Link ----\&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;/-----------------=
---\</div>
<div>|=3D=3DLAN1=3D=3D| ---- | BRIDGE 1|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | BRIDGE 2| -----| =3D=3D=3DLAN 2=3D=
=3D=3D |&nbsp;</div>
<div>\---------------/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \ -----TINC vpn tunnel ------/&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \---------------------/</di=
v>
<div>&nbsp;</div>
<div>When one of link failed the ping from one to other site stop to works.=
 </div>
<div>I use bridge-utils-1.0.6 and tinc-1.0.4 </div>
<div>&nbsp;</div>
<div>I wait any suggestion about this</div>
<div>&nbsp;</div>
<div>Daniel </div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>The bridege setup script is: </div>
<div>&nbsp;</div>
<div>
<p>#! /bin/bash<br><br>PATH=3D$PATH:/usr/local/sbin:/sbin<br>BR=3Dbr0<br>IP=
=3D&quot;<a href=3D"http://172.16.3.223">172.16.3.223</a>&quot;<br>MASK=3D&=
quot;<a href=3D"http://255.255.252.0">255.255.252.0</a>&quot;<br>BROADCAST=
=3D&quot;<a href=3D"http://172.16.3.255">
172.16.3.255</a>&quot;</p>
<p>return=3D$rc_done<br>case &quot;$1&quot; in</p>
<p>&nbsp;&nbsp;&nbsp; start)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
echo &quot;Starting service bridge $BR&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; tincd -n vpn<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
brctl addbr $BR<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl setbrid=
geprio $BR 0 || return=3D$rc_failed<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; brctl addif $BR eth0 ||&nbsp; return=3D$rc_failed
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl addif $BR eth1 ||&nbsp=
; return=3D$rc_failed<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl a=
ddif $BR vpn&nbsp; ||&nbsp; return=3D$rc_failed<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ifconfig eth0 <a href=3D"http://0.0.0.0">0.0.0.0</a>&nbs=
p; ||&nbsp; return=3D$rc_failed<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; ifconfig eth1 <a href=3D"http://0.0.0.0">
0.0.0.0</a>&nbsp; ||&nbsp; return=3D$rc_failed<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ifconfig vpn <a href=3D"http://0.0.0.0">0.0.0.0</a>&nbsp;=
 ||&nbsp; return=3D$rc_failed<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 brctl sethello $BR 1&nbsp; ||&nbsp; return=3D$rc_failed<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; brctl setmaxage $BR 4&nbsp; ||&nbsp; return=3D$=
rc_failed
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl setpathcost $BR eth1 1=
00&nbsp; ||&nbsp; return=3D$rc_failed<br></p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl setpathcost $BR vpn 100=
&nbsp; ||&nbsp; return=3D$rc_failed<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; brctl setportprio $BR eth1 20&nbsp; ||&nbsp; return=3D$rc_failed<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl setportprio $BR vpn 20&nbs=
p; ||&nbsp; return=3D$rc_failed<br>#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; brctl setageing $BR 20&nbsp; ||&nbsp; return=3D$rc_failed
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl setfd $BR 4&nbsp; ||&n=
bsp; return=3D$rc_failed<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brct=
l stp $BR on<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sbin/ifconfig $=
BR inet $IP netmask $MASK broadcast $BROADCAST up<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; echo -e &quot;$return&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ;;</p>
<p>&nbsp;&nbsp;&nbsp; stop)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t=
incd -k -n vpn<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sbin/ifconfig=
 $BR down<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo &quot;Shutting=
 down service bridge $BR&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; brctl delif $BR vpn&nbsp; ||&nbsp; return=3D$rc_failed<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; brctl delif $BR eth0&nbsp; ||&nbsp; return=3D$r=
c_failed
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl delif $BR eth1&nbsp; |=
|&nbsp; return=3D$rc_failed<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
rctl delbr $BR&nbsp; ||&nbsp; return=3D$rc_failed<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; rmmod bridge || return=3D$rc_failed<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; echo -e &quot;$return&quot;<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ;;</p>
<p>&nbsp;&nbsp;&nbsp; status)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ifconfig $BR<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl showstp $=
BR<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl show<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;;</p>
<p>&nbsp;&nbsp;&nbsp; restart)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; $0 stop &amp;&amp; $0 start || return=3D$rc_failed<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ;;</p>
<p>&nbsp;&nbsp;&nbsp; *)<br></p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo &quot;Usage: $0 {start|s=
top|status|restart}&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exi=
t 1<br>esac</p>
<p>test &quot;$return&quot; =3D &quot;$rc_done&quot; || exit 1<br>exit 0<br=
></p></div>

------=_Part_20119_24048333.1125681935881--
