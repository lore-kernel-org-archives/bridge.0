MIME-Version: 1.0
In-Reply-To: <849c76670905271842y4efc0ed8sbbd047ac27572945@mail.gmail.com>
References: <849c76670905271049w76813768v8bce6aed46806c06@mail.gmail.com>
	<849c76670905271842y4efc0ed8sbbd047ac27572945@mail.gmail.com>
Date: Thu, 28 May 2009 07:17:29 +0530
Message-ID: <849c76670905271847ta7bc2a8s4464547125f79028@mail.gmail.com>
From: Thinkstor Inc <thinkstor@gmail.com>
Content-Type: multipart/alternative; boundary=000e0cd32e0a83d09f046aef24ee
Subject: [Bridge] Help Needed On Ethernet Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

--000e0cd32e0a83d09f046aef24ee
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

   Hi All,
           My requirement is as below,

* I have to create a bridge on linux machine (kernel 2.6.23) and it has 2
interfaces(eth0 & eth1)
* I should have the control of Port State Changes
(LISTENING,LEARNING,BLOCKING,FORWARDING,DISABLED) and
   Only BLOCKING & FORWARDING States I Wud Be Using. I have to ensure that
the port state never goes to any other states other than BLOCKING &
FORWARDING.
* Other thing is I have to send the control packets using the llc API's &
NF_HOOK On both the interfaces and I recieve on LLC_SAP_BSPAN (Service
Access Point Of STP)

The Messages I Send Wud be Control Packets Which Have To Pass Through Even
If Port State Is BLOCKING...

I Have to form a ring like this

          NODE 1                NODE 2                NODE 3
 -->eth1        eth0<----->eth1     eth0 <----->eth1      eth0<--
 |--------------------------------------------------------------|


What I have done So far is
 * I have commented the STP port state change code So that Port wont
traverse to any other state.
 * I have IOCTL's to Send My Message And I Use LLC API's& NF_HOOK Which STP
Uses to achieve sending.
 * Recv Part I Do It On STP's stp_bpdu_rcv().

Everything Works Fine But Sometimes It Crashes...
I'm not getting where exactly its breaking Can u please help me with this
regard.

--000e0cd32e0a83d09f046aef24ee
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>
<div class=3D"gmail_quote">
<div>
<div></div>
<div class=3D"h5">
<div class=3D"gmail_quote">
<div dir=3D"ltr"><font face=3D"Tahoma" color=3D"#000000" size=3D"2">Hi All,=
</font></div>
<div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2">=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 My requirement is as below,</font></div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2"></font>=A0</div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2">* I have to create a brid=
ge on linux machine (kernel 2.6.23) and it has 2 interfaces(eth0 &amp; eth1=
)</font></div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2">* I should have the contr=
ol of Port State Changes (LISTENING,LEARNING,BLOCKING,FORWARDING,DISABLED) =
and</font></div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2">=A0=A0 Only BLOCKING &amp=
; FORWARDING States I Wud Be Using. I have to ensure that the port state ne=
ver goes to any other states other than BLOCKING &amp; FORWARDING.</font></=
div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2">* Other thing is I have t=
o send the control packets using the llc API&#39;s &amp; NF_HOOK On both th=
e interfaces and I recieve on LLC_SAP_BSPAN (Service Access Point Of STP)</=
font></div>

<div dir=3D"ltr">=A0</div>
<div dir=3D"ltr">The Messages I Send Wud be Control Packets Which Have To P=
ass Through Even If Port State Is BLOCKING...</div>
<div dir=3D"ltr">=A0</div>
<div dir=3D"ltr"><font face=3D"times new roman">I Have to form a ring like =
this</font></div>
<div dir=3D"ltr"><font face=3D"times new roman"></font>=A0</div>
<div dir=3D"ltr">=A0=A0=A0=A0 =A0=A0=A0=A0 NODE 1=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0NODE 2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 N=
ODE 3</div>
<div dir=3D"ltr">=A0--&gt;eth1=A0=A0=A0=A0=A0=A0=A0 eth0&lt;-----&gt;eth1=
=A0=A0=A0=A0 eth0=A0&lt;-----&gt;eth1=A0=A0=A0=A0=A0 eth0&lt;--</div>
<div dir=3D"ltr">=A0|------------------------------------------------------=
--------|</div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2"></font>=A0</div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2"></font>=A0</div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2">What I have done So far i=
s</font></div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2">=A0* I have commented the=
 STP port state change code So that=A0Port wont traverse to any other state=
.</font></div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2">=A0* I have IOCTL&#39;s t=
o Send My Message And I Use LLC API&#39;s&amp; NF_HOOK=A0Which STP Uses to =
achieve sending.</font></div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2">=A0* Recv Part I Do It On=
 STP&#39;s stp_bpdu_rcv().</font></div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2"></font>=A0</div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2">Everything Works Fine But=
 Sometimes It Crashes... </font></div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2">I&#39;m not getting where=
 exactly its breaking Can u please help me with this regard.</font></div>
<div dir=3D"ltr"><font face=3D"tahoma" size=3D"2"></font>=A0</div></div></d=
iv><br></div></div></div><br>

--000e0cd32e0a83d09f046aef24ee--
