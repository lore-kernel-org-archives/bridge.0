Return-Path: <sujataverma3@yahoo.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1340012128; bh=41GCcwfrooFMipx21498nfwiw+SIaynLLdkVmGZ8UrI=;
	h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
	b=aqzTQL1dMErC4PE4R4AgHkQDmG8paEE1ec3jZ4ANxE9JA/ZszKXSPk/ZjGPSZqQF42bGlnnQ4xHhMcgJ1Z3stBlSONg5LwXk/KLzaJYEPnwBht3uEiMOMPngykZU4LXkSs3nEIaZCbV/ofK6FCOOsOx4KOrm6XPdFjw8PH2kQGs=
Message-ID: <1340012128.42375.YahooMailClassic@web121305.mail.ne1.yahoo.com>
Date: Mon, 18 Jun 2012 02:35:28 -0700 (PDT)
From: Sujata Verma <sujataverma3@yahoo.com>
In-Reply-To: <CAOJFanVMn4Dx+Ue1-7yS8Lk_pkVP3ra8uZcV9MQbfqOKhHq1Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="1521818054-454116840-1340012128=:42375"
Subject: Re: [Bridge] Query on Sapnning tree implementation from standard
	point of view
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sasikanth babu <sasikanth.v19@gmail.com>
Cc: bridge@lists.linux-foundation.org

--1521818054-454116840-1340012128=:42375
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Ok.=20

=A0 I don't think STP std has mentioned this propagation, As far as I know=
=0A this prorogation is wrong. I think this must be a bug in Netgear =0Aswi=
tch.

>>> My setup is=A0=20

=A0=A0=A0 PC1( Windows PC) ----Switch------PC2 ( Windows PC)

Using Colasoft builder tool, i captured one STP packet modified the bridge =
priority such that it becomes root bridge , put all invalid values for time=
rs as 255 and sent to the switch. My switch is linux PC, netgear switch and=
 dlink switch for comparison purposes.=20

As switch receives the better BID packet it stop advertising it self as bri=
dge and take values of timers from root bridge which is 255 for bridge, hel=
lo and forward delay in my case.

So the switch receives this packet and updates its cost, root information a=
nd sends out on another port on which PC2 is connected and where i am seein=
g it on wireshark with all timer values as received from root bridge. This =
is all fine, the only problem is, its not validating the timer values which=
 seems a bug to me , as the timer values are defined within the limit in st=
andard.

If Netgear is doing validation of the hello timer and is putting the maximu=
m allowed value seems fine to me and not a bug. But still, i think forward =
delay and max age should also be validated before accepting new BPDU as roo=
t bridge.

As in linux/dlink it is not doing any validation and sending bpdu with=A0 2=
55 values, which is not correct as it could lead to delay of convergence ti=
me in case of root failure.

In netgear switch the command display before and after are as follows:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
(FSM726V3) #show spanning-tree

Bridge Priority................................ 32768
Bridge Identifier.............................. 80:00:00:26:F2:AF:93:A5
Time Since Topology Change..................... 0 day 0 hr 42 min 14 sec
Topology Change Count.......................... 1
Topology Change in progress.................... FALSE
Designated Root................................ 80:00:00:26:F2:AF:93:A5
Root Path Cost................................. 0
Root Port Identifier........................... 00:00
Bridge Max Age................................. 20
Bridge Max Hops................................ 20
Bridge Tx Hold Count........................... 6
Bridge Forwarding Delay........................ 15
Hello Time..................................... 2
Bridge Hold Time............................... 6
CST Regional Root.............................. 80:00:00:26:F2:AF:93:A5
Regional Root Path Cost........................ 0
--More-- or (q)uit



=A0=A0=A0=A0 Associated FIDs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Associated VLANs
=A0=A0=A0=A0 ---------------=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ----------------
=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 1
=A0=A0=A0=A0 100=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 100
=A0=A0=A0=A0 200=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 200

(FSM726V3) #show spanning-tree summary

Spanning Tree Adminmode........... Enabled
Spanning Tree Version............. IEEE 802.1d
BPDU Guard Mode................... Disabled
BPDU Filter Mode.................. Disabled
Configuration Name................ 00-26-F2-AF-93-A5
Configuration Revision Level...... 0
Configuration Digest Key.......... 0xac36177f50283cd4b83821d8ab26de62
Configuration Format Selector..... 0
No MST instances to display.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
After sending the invalid timer packet:

(FSM726V3) #
(FSM726V3) #
(FSM726V3) #show spanning-tree summary

Spanning Tree Adminmode........... Enabled
Spanning Tree Version............. IEEE 802.1d
BPDU Guard Mode................... Disabled
BPDU Filter Mode.................. Disabled
Configuration Name................ 00-26-F2-AF-93-A5
Configuration Revision Level...... 0
Configuration Digest Key.......... 0xac36177f50283cd4b83821d8ab26de62
Configuration Format Selector..... 0
No MST instances to display.

(FSM726V3) #show spanning-tree

Bridge Priority................................ 32768
Bridge Identifier.............................. 80:00:00:26:F2:AF:93:A5
Time Since Topology Change..................... 0 day 0 hr 0 min 12 sec
Topology Change Count.......................... 2
Topology Change in progress.................... TRUE
Designated Root................................ 10:00:00:20:A1:F0:88:50
Root Path Cost................................. 200004
Root Port Identifier........................... 80:01
Bridge Max Age................................. 255
Bridge Max Hops................................ 20
Bridge Tx Hold Count........................... 6
Bridge Forwarding Delay........................ 255
Hello Time..................................... 10
Bridge Hold Time............................... 6
CST Regional Root.............................. 80:00:00:26:F2:AF:93:A5
Regional Root Path Cost........................ 0
--More-- or (q)uit



=A0=A0=A0=A0 Associated FIDs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Associated VLANs
=A0=A0=A0=A0 ---------------=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ----------------
=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0 100=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 100
=A0=A0=A0=A0 200=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 200

(FSM726V3) #


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
As Cisco doesnt accept this type of BPDU it means that it is a bug to be fi=
xed on Linux, as i conclude.=20

Please let me know if you think otherwise.

Regards,
Sujata




--- On Fri, 6/15/12, Sasikanth babu <sasikanth.v19@gmail.com> wrote:

From: Sasikanth babu <sasikanth.v19@gmail.com>
Subject: Re: [Bridge] Query on Sapnning tree implementation from standard p=
oint of view
To: "Sujata Verma" <sujataverma3@yahoo.com>
Cc: bridge@lists.linux-foundation.org
Date: Friday, June 15, 2012, 7:25 PM


On Fri, Jun 15, 2012 at 5:55 PM, Sujata Verma <sujataverma3@yahoo.com> wrot=
e:
=0AThanks. I was doing the same experiment on few switches, i could get hol=
d of and this is the result:

Cisco Switch catalyst 2950 : Completely ignoring the packet, so validations=
 are proper.
=0A
Netgear FSM726V3 : Hello timer is validated and is propagated as 10 instead=
 of 255 ( which i sent) other max age and forward delay still it accepts as=
 255.=20

=A0=A0 I don't think STP std has mentioned this propagation, As far as I kn=
ow this prorogation is wrong. I think this must be a bug in Netgear switch.
=0A
=0ADLINK-DES-3026 : No validation done and accepts all as 255 ( max age, fo=
rward delay and hello timer)

In both Netgear and Dlink the message age is changed to 16, which i am not =
sure why it has happened ?=20

my setup is simple
=0A
=A0 PC1------Switch------PC2

From PC1 i am sending invalid timer values and observing on PC2.

=A0 =A0 Are you doing any port mirroring here to capture packets on PC2?. H=
ow are you sending packets from PC1 (running linux bridge?)?
=0A=0A
I am attaching wireshark capture for Dlink and Netgear STP packets.

=A0=A0 Can you send out complete packet capture from start of your test to =
the end to analyze
=A0=A0=20
=0A=A0=A0=A0 Thanks
=A0=A0=A0 Sasi

=0APlease let me know if any one has any idea or comment on=0A this.

Thanks,
Sujata
=A0=0A




--- On Thu, 6/14/12, Sasikanth babu <sasikanth.v19@gmail.com> wrote:
=0A
From: Sasikanth babu <sasikanth.v19@gmail.com>
Subject: Re: [Bridge] Query on Sapnning tree implementation from standard p=
oint of view
=0ATo: "Sujata Verma" <sujataverma3@yahoo.com>
Cc: bridge@lists.linux-foundation.org
=0ADate: Thursday, June 14, 2012, 6:09 PM


On Thu, Jun 14, 2012 at 5:53 PM, Sujata Verma <sujataverma3@yahoo.com> wrot=
e:
=0A=0AHi ,

I am going through spanning tree protocol and was testing it on Linux. My o=
bservation is there is no validation of timers for configuration BPDU.=A0 L=
ets say Root bridge received another BPDU from new bridge with invalid time=
r values but less priority, the existing bridge is becoming non-root bridge=
 and is advertising the invalid timer values.=20
=0A=0A
As i have gone through 802.1D-1998 standard, i understand that 2004 is curr=
ent one but i was looking into STP not RSTP, i preferred to read this stand=
ard. I find these lines:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=0A=0A9.3.3 Validation of received BPDUs

A Bridge Protocol Entity shall process a received BPDU as specified in 8.7 =
if and only if the BPDU contains at least four octets and the Protocol Iden=
tifier has the value specified for BPDUs (9.3.2), and
=0A=0Aa) The BPDU Type=0A denotes a Configuration BPDU and the BPDU contain=
s at least 35 octets, and the
value of the BPDUs Message Age parameter is less than that of its Max Age p=
arameter; or

b) The BPDU Type denotes a Topology Change Notification BPDU.
=0A=0AIn case a), any octets that are present beyond Octet 35 are ignored, =
as far as processing according to this
standard is concerned. Similarly, in case b), any octets beyond Octet 4 are=
 ignored.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=0A=0A
Does this implies that any value timer values present within octet 35 is va=
lid value and there is no validation done. Even if range for hello timer, m=
ax age and forward delay is defined and is limited. Is it an issue or fine =
within the standard?
=0A=0A
=A0 Not all STP implementation do BPDU validations i.e validates all BPDU p=
arameters present within 35 octet. The validation checks for invalid values=
 present in the bpdu,=20
=0A=0A=A0 if the BPDU validation fails it drops the BPDU. The have seen thi=
s validations in proprietary software.
=A0=20
=0A=0APlease help me understand this issue and thanks for any comments.

Regards,
Sujata

=0A=0A
_______________________________________________
=0ABridge mailing list
=0ABridge@lists.linux-foundation.org
=0Ahttps://lists.linuxfoundation.org/mailman/listinfo/bridge

=0A
_______________________________________________
=0ABridge mailing list
=0ABridge@lists.linux-foundation.org
=0Ahttps://lists.linuxfoundation.org/mailman/listinfo/bridge

=0A
--1521818054-454116840-1340012128=:42375
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Ok. <br><br>&nbsp; I don't think STP std has =
mentioned this propagation, As far as I know=0A this prorogation is wrong. =
I think this must be a bug in Netgear =0Aswitch.<br><br>&gt;&gt;&gt; My set=
up is&nbsp; <br><br>&nbsp;&nbsp;&nbsp; PC1( Windows PC) ----Switch------PC2=
 ( Windows PC)<br><br>Using Colasoft builder tool, i captured one STP packe=
t modified the bridge priority such that it becomes root bridge , put all i=
nvalid values for timers as 255 and sent to the switch. My switch is linux =
PC, netgear switch and dlink switch for comparison purposes. <br><br>As swi=
tch receives the better BID packet it stop advertising it self as bridge an=
d take values of timers from root bridge which is 255 for bridge, hello and=
 forward delay in my case.<br><br>So the switch receives this packet and up=
dates its cost, root information and sends out on another port on which PC2=
 is connected and where i am seeing it on wireshark with all timer values a=
s received from root bridge. This is all fine, the only problem is, its not=
 validating the timer values which seems a bug to me , as the timer values =
are defined within the limit in
 standard.<br><br>If Netgear is doing validation of the hello timer and is =
putting the maximum allowed value seems fine to me and not a bug. But still=
, i think forward delay and max age should also be validated before accepti=
ng new BPDU as root bridge.<br><br>As in linux/dlink it is not doing any va=
lidation and sending bpdu with&nbsp; 255 values, which is not correct as it=
 could lead to delay of convergence time in case of root failure.<br><br>In=
 netgear switch the command display before and after are as follows:<br><br=
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>(FSM726V3) #show spa=
nning-tree<br><br>Bridge Priority................................ 32768<br>=
Bridge Identifier.............................. 80:00:00:26:F2:AF:93:A5<br>=
Time Since Topology Change..................... 0 day 0 hr 42 min 14 sec<br=
>Topology Change Count.......................... 1<br>Topology Change in pr=
ogress.................... FALSE<br>Designated
 Root................................ 80:00:00:26:F2:AF:93:A5<br>Root Path =
Cost................................. 0<br>Root Port Identifier............=
............... 00:00<br>Bridge Max Age................................. 20=
<br>Bridge Max Hops................................ 20<br>Bridge Tx Hold Co=
unt........................... 6<br>Bridge Forwarding Delay................=
........ 15<br>Hello Time..................................... 2<br>Bridge =
Hold Time............................... 6<br>CST Regional Root............=
.................. 80:00:00:26:F2:AF:93:A5<br>Regional Root Path Cost......=
.................. 0<br>--More-- or (q)uit<br><br><br><br>&nbsp;&nbsp;&nbsp=
;&nbsp; Associated FIDs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Associated VLANs<br>&nbsp;&nbsp;&nbsp;&nbsp; ---------------&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----------------<br>=
&nbsp;&nbsp;&nbsp;&nbsp;
 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<b=
r>&nbsp;&nbsp;&nbsp;&nbsp; 100&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 100<br>&nbsp;&nbsp;&nbsp;&nbsp; 200&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 200<br><br>(FSM726V3) #show span=
ning-tree summary<br><br>Spanning Tree Adminmode........... Enabled<br>Span=
ning Tree Version............. IEEE 802.1d<br>BPDU Guard Mode..............=
..... Disabled<br>BPDU Filter Mode.................. Disabled<br>Configurat=
ion Name................ 00-26-F2-AF-93-A5<br>Configuration Revision Level.=
..... 0<br>Configuration Digest Key.......... 0xac36177f50283cd4b83821d8ab2=
6de62<br>Configuration Format Selector..... 0<br>No MST instances to
 display.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>After sendi=
ng the invalid timer packet:<br><br>(FSM726V3) #<br>(FSM726V3) #<br>(FSM726=
V3) #show spanning-tree summary<br><br>Spanning Tree Adminmode........... E=
nabled<br>Spanning Tree Version............. IEEE 802.1d<br>BPDU Guard Mode=
................... Disabled<br>BPDU Filter Mode.................. Disabled=
<br>Configuration Name................ 00-26-F2-AF-93-A5<br>Configuration R=
evision Level...... 0<br>Configuration Digest Key.......... 0xac36177f50283=
cd4b83821d8ab26de62<br>Configuration Format Selector..... 0<br>No MST insta=
nces to display.<br><br>(FSM726V3) #show spanning-tree<br><br>Bridge Priori=
ty................................ 32768<br>Bridge Identifier..............=
................ 80:00:00:26:F2:AF:93:A5<br>Time Since Topology Change.....=
................ 0 day 0 hr 0 min 12 sec<br>Topology Change Count..........=
................ 2<br>Topology Change in progress....................
 TRUE<br>Designated Root................................ 10:00:00:20:A1:F0:=
88:50<br>Root Path Cost................................. 200004<br>Root Por=
t Identifier........................... 80:01<br>Bridge Max Age............=
..................... 255<br>Bridge Max Hops...............................=
. 20<br>Bridge Tx Hold Count........................... 6<br>Bridge Forward=
ing Delay........................ 255<br><span style=3D"color: rgb(255, 0, =
0);">Hello Time..................................... 10</span><br>Bridge Ho=
ld Time............................... 6<br>CST Regional Root..............=
................ 80:00:00:26:F2:AF:93:A5<br>Regional Root Path Cost........=
................ 0<br>--More-- or (q)uit<br><br><br><br>&nbsp;&nbsp;&nbsp;&=
nbsp; Associated FIDs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; Associated VLANs<br>&nbsp;&nbsp;&nbsp;&nbsp; ---------------&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 ----------------<br>&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>&nbsp;&nbsp;&nbsp;&nbs=
p; 100&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100<b=
r>&nbsp;&nbsp;&nbsp;&nbsp; 200&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 200<br><br>(FSM726V3) #<br><br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>As Cisco doesnt accept this type of BPDU it =
means that it is a bug to be fixed on Linux, as i conclude. <br><br>Please =
let me know if you think otherwise.<br><br>Regards,<br>Sujata<br><br><br><b=
r><br>--- On <b>Fri, 6/15/12, Sasikanth babu <i>&lt;sasikanth.v19@gmail.com=
&gt;</i></b> wrote:<br><blockquote style=3D"border-left: 2px solid rgb(16,
 16, 255); margin-left: 5px; padding-left: 5px;"><br>From: Sasikanth babu &=
lt;sasikanth.v19@gmail.com&gt;<br>Subject: Re: [Bridge] Query on Sapnning t=
ree implementation from standard point of view<br>To: "Sujata Verma" &lt;su=
jataverma3@yahoo.com&gt;<br>Cc: bridge@lists.linux-foundation.org<br>Date: =
Friday, June 15, 2012, 7:25 PM<br><br><div id=3D"yiv115092420"><div dir=3D"=
ltr"><br><div class=3D"yiv115092420gmail_quote">On Fri, Jun 15, 2012 at 5:5=
5 PM, Sujata Verma <span dir=3D"ltr">&lt;<a rel=3D"nofollow" ymailto=3D"mai=
lto:sujataverma3@yahoo.com" target=3D"_blank" href=3D"/mc/compose?to=3Dsuja=
taverma3@yahoo.com">sujataverma3@yahoo.com</a>&gt;</span> wrote:<br><blockq=
uote class=3D"yiv115092420gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex;">=0A<table border=3D"0" cellpadding=3D"=
0" cellspacing=3D"0"><tbody><tr><td style=3D"font:inherit;" valign=3D"top">=
Thanks. I was doing the same experiment on few switches, i could get hold o=
f and this is the result:<br><br>Cisco Switch catalyst 2950 : Completely ig=
noring the packet, so validations are proper.<br>=0A<br>Netgear FSM726V3 : =
Hello timer is validated and is propagated as 10 instead of 255 ( which i s=
ent) other max age and forward delay still it accepts as 255. <br><br></td>=
</tr></tbody></table></blockquote><div>&nbsp;&nbsp; I don't think STP std h=
as mentioned this propagation, As far as I know this prorogation is wrong. =
I think this must be a bug in Netgear switch.<br>=0A<br></div><blockquote c=
lass=3D"yiv115092420gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex;"><table border=3D"0" cellp=
adding=3D"0" cellspacing=3D"0"><tbody><tr><td style=3D"font:inherit;" valig=
n=3D"top">=0ADLINK-DES-3026 : No validation done and accepts all as 255 ( m=
ax age, forward delay and hello timer)<br><br>In both Netgear and Dlink the=
 message age is changed to 16, which i am not sure why it has happened ? <b=
r><br>my setup is simple<br>=0A<br>&nbsp; PC1------Switch------PC2<br><br>F=
rom PC1 i am sending invalid timer values and observing on PC2.<br></td></t=
r></tbody></table></blockquote><div><br>&nbsp; &nbsp; Are you doing any por=
t mirroring here to capture packets on PC2?. How are you sending packets fr=
om PC1 (running linux bridge?)?<br>=0A</div><blockquote class=3D"yiv1150924=
20gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(=
204,204,204);padding-left:1ex;"><table border=3D"0" cellpadding=3D"0" cells=
pacing=3D"0"><tbody><tr><td style=3D"font:inherit;" valign=3D"top">=0A<br>I=
 am attaching wireshark capture for Dlink and Netgear STP packets.<br><br><=
/td></tr></tbody></table></blockquote><div>&nbsp;&nbsp; Can you send out co=
mplete packet capture from start of your test to the end to analyze<br>&nbs=
p;&nbsp; <br>=0A&nbsp;&nbsp;&nbsp; Thanks<br>&nbsp;&nbsp;&nbsp; Sasi<br><br=
></div><blockquote class=3D"yiv115092420gmail_quote" style=3D"margin:0pt 0p=
t 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex;"><tabl=
e border=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody><tr><td style=3D"=
font:inherit;" valign=3D"top">=0APlease let me know if any one has any idea=
 or comment on=0A this.<br><br>Thanks,<br>Sujata<br></td></tr></tbody></tab=
le></blockquote><div>&nbsp;</div><blockquote class=3D"yiv115092420gmail_quo=
te" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0=
">=0A<tbody><tr><td style=3D"font:inherit;" valign=3D"top"><br><br><br><br>=
<br>--- On <b>Thu, 6/14/12, Sasikanth babu <i>&lt;<a rel=3D"nofollow" ymail=
to=3D"mailto:sasikanth.v19@gmail.com" target=3D"_blank" href=3D"/mc/compose=
?to=3Dsasikanth.v19@gmail.com">sasikanth.v19@gmail.com</a>&gt;</i></b> wrot=
e:<br>=0A<blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-l=
eft:5px;padding-left:5px;"><br>From: Sasikanth babu &lt;<a rel=3D"nofollow"=
 ymailto=3D"mailto:sasikanth.v19@gmail.com" target=3D"_blank" href=3D"/mc/c=
ompose?to=3Dsasikanth.v19@gmail.com">sasikanth.v19@gmail.com</a>&gt;<br>Sub=
ject: Re: [Bridge] Query on Sapnning tree implementation from standard poin=
t of view<br>=0ATo: "Sujata Verma" &lt;<a rel=3D"nofollow" ymailto=3D"mailt=
o:sujataverma3@yahoo.com" target=3D"_blank" href=3D"/mc/compose?to=3Dsujata=
verma3@yahoo.com">sujataverma3@yahoo.com</a>&gt;<br>Cc: <a rel=3D"nofollow"=
 ymailto=3D"mailto:bridge@lists.linux-foundation.org" target=3D"_blank" hre=
f=3D"/mc/compose?to=3Dbridge@lists.linux-foundation.org">bridge@lists.linux=
-foundation.org</a><br>=0ADate: Thursday, June 14, 2012, 6:09 PM<div><div c=
lass=3D"yiv115092420h5"><br><br><div><div dir=3D"ltr"><br><div>On Thu, Jun =
14, 2012 at 5:53 PM, Sujata Verma <span dir=3D"ltr">&lt;<a rel=3D"nofollow"=
 target=3D"_blank" href=3D"http://mc/compose?to=3Dsujataverma3@yahoo.com">s=
ujataverma3@yahoo.com</a>&gt;</span> wrote:<br>=0A<blockquote style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">=0A<table borde=
r=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody><tr><td style=3D"font:in=
herit;" valign=3D"top">Hi ,<br><br>I am going through spanning tree protoco=
l and was testing it on Linux. My observation is there is no validation of =
timers for configuration BPDU.&nbsp; Lets say Root bridge received another =
BPDU from new bridge with invalid timer values but less priority, the exist=
ing bridge is becoming non-root bridge and is advertising the invalid timer=
 values. <br>=0A=0A<br>As i have gone through 802.1D-1998 standard, i under=
stand that 2004 is current one but i was looking into STP not RSTP, i prefe=
rred to read this standard. I find these lines:<br><br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>=0A=0A9.3.3 Validation =
of received BPDUs<br><br>A Bridge Protocol Entity shall process a received =
BPDU as specified in 8.7 if and only if the BPDU contains at least four oct=
ets and the Protocol Identifier has the value specified for BPDUs (9.3.2), =
and<br>=0A=0Aa) The BPDU Type=0A denotes a Configuration BPDU and the BPDU =
contains at least 35 octets, and the<br>value of the BPDUs Message Age para=
meter is less than that of its Max Age parameter; or<br><br>b) The BPDU Typ=
e denotes a Topology Change Notification BPDU.<br>=0A=0AIn case a), any oct=
ets that are present beyond Octet 35 are ignored, as far as processing acco=
rding to this<br>standard is concerned. Similarly, in case b), any octets b=
eyond Octet 4 are ignored.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>=0A=0A<br>Does this implies that any value timer valu=
es present within octet 35 is valid value and there is no validation done. =
Even if range for hello timer, max age and forward delay is defined and is =
limited. Is it an issue or fine within the standard?<br>=0A=0A<br></td></tr=
></tbody></table></blockquote><div>&nbsp; Not all STP implementation do BPD=
U validations i.e validates all BPDU parameters present within 35 octet. Th=
e validation checks for invalid values present in the bpdu, <br>=0A=0A&nbsp=
; if the BPDU validation fails it drops the BPDU. The have seen this valida=
tions in proprietary software.<br>&nbsp; <br></div><blockquote style=3D"mar=
gin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex;">=0A=0A<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody><=
tr><td style=3D"font:inherit;" valign=3D"top">Please help me understand thi=
s issue and thanks for any comments.<br><br>Regards,<br>Sujata<br><br></td>=
</tr></tbody></table>=0A=0A<br>____________________________________________=
___<br>=0ABridge mailing list<br>=0A<a rel=3D"nofollow" target=3D"_blank" h=
ref=3D"http://mc/compose?to=3DBridge@lists.linux-foundation.org">Bridge@lis=
ts.linux-foundation.org</a><br>=0A<a rel=3D"nofollow" target=3D"_blank" hre=
f=3D"https://lists.linuxfoundation.org/mailman/listinfo/bridge">https://lis=
ts.linuxfoundation.org/mailman/listinfo/bridge</a><br></blockquote></div><b=
r></div>=0A</div></div></div></blockquote></td></tr></tbody></table><br>___=
____________________________________________<br>=0ABridge mailing list<br>=
=0A<a rel=3D"nofollow" ymailto=3D"mailto:Bridge@lists.linux-foundation.org"=
 target=3D"_blank" href=3D"/mc/compose?to=3DBridge@lists.linux-foundation.o=
rg">Bridge@lists.linux-foundation.org</a><br>=0A<a rel=3D"nofollow" target=
=3D"_blank" href=3D"https://lists.linuxfoundation.org/mailman/listinfo/brid=
ge">https://lists.linuxfoundation.org/mailman/listinfo/bridge</a><br></bloc=
kquote></div><br></div>=0A</div></blockquote></td></tr></table>
--1521818054-454116840-1340012128=:42375--
