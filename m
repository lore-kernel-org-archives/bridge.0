Return-Path: <sasikanth.v19@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=UxpfjAW/TvymWCWm/4bl26J4FqkmrBNkdrWUSf7OEPU=;
	b=P5rUM4HZlbJwW6/xnlQM0TZqzq/xVDrNaHE8Y/Yy57V9PnQ2MIeMRq0Ode/hiEAOUl
	MIASmppwl6t9mqfdcy+mi412I2nAlUbJ46hAKiGFii6nWivduShEriRig+o81DL623uJ
	1lZL3WpxDU2f5ufp4e09HuNSMVHkYuxNx+s6ofLOBfFuBNgjzIYnW5rKtX5WL6vji0kb
	+4nq/EZPOFW8eWkE54Iurrh+b8V0k54q9vGD4D8KQodg3IlDCbV8wtB/oeY4m8/J2YkK
	zeFOO1hn678JZ7/WL2fvprKqAJFat1lr5yLby3q3TBOBgsQGy4HjRRCraU1zarw9H6jZ
	5AWg==
MIME-Version: 1.0
In-Reply-To: <1340012128.42375.YahooMailClassic@web121305.mail.ne1.yahoo.com>
References: <CAOJFanVMn4Dx+Ue1-7yS8Lk_pkVP3ra8uZcV9MQbfqOKhHq1Ng@mail.gmail.com>
	<1340012128.42375.YahooMailClassic@web121305.mail.ne1.yahoo.com>
Date: Mon, 18 Jun 2012 21:25:26 +0530
Message-ID: <CAOJFanURN8_LfYLWHFEtACc9_8mNb1vZ=mENnNR=0v6ZXTk=Tg@mail.gmail.com>
From: Sasikanth babu <sasikanth.v19@gmail.com>
Content-Type: multipart/alternative; boundary=047d7b33d8a6cb5c6f04c2c131ae
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
To: Sujata Verma <sujataverma3@yahoo.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

--047d7b33d8a6cb5c6f04c2c131ae
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jun 18, 2012 at 3:05 PM, Sujata Verma <sujataverma3@yahoo.com>wrote:

> Ok.
>
>   I don't think STP std has mentioned this propagation, As far as I know
> this prorogation is wrong. I think this must be a bug in Netgear switch.
>
> >>> My setup is
>
>     PC1( Windows PC) ----Switch------PC2 ( Windows PC)
>
> Using Colasoft builder tool, i captured one STP packet modified the bridge
> priority such that it becomes root bridge , put all invalid values for
> timers as 255 and sent to the switch. My switch is linux PC, netgear switch
> and dlink switch for comparison purposes.
>
> As switch receives the better BID packet it stop advertising it self as
> bridge and take values of timers from root bridge which is 255 for bridge,
> hello and forward delay in my case.
>
> So the switch receives this packet and updates its cost, root information
> and sends out on another port on which PC2 is connected and where i am
> seeing it on wireshark with all timer values as received from root bridge.
> This is all fine, the only problem is, its not validating the timer values
> which seems a bug to me , as the timer values are defined within the limit
> in standard.
>
> If Netgear is doing validation of the hello timer and is putting the
> maximum allowed value seems fine to me and not a bug. But still, i think
> forward delay and max age should also be validated before accepting new
> BPDU as root bridge.
>
> As in linux/dlink it is not doing any validation and sending bpdu with
> 255 values, which is not correct as it could lead to delay of convergence
> time in case of root failure.
>
> In netgear switch the command display before and after are as follows:
>
> =========================================
> (FSM726V3) #show spanning-tree
>
> Bridge Priority................................ 32768
> Bridge Identifier.............................. 80:00:00:26:F2:AF:93:A5
> Time Since Topology Change..................... 0 day 0 hr 42 min 14 sec
> Topology Change Count.......................... 1
> Topology Change in progress.................... FALSE
> Designated Root................................ 80:00:00:26:F2:AF:93:A5
> Root Path Cost................................. 0
> Root Port Identifier........................... 00:00
> Bridge Max Age................................. 20
> Bridge Max Hops................................ 20
> Bridge Tx Hold Count........................... 6
> Bridge Forwarding Delay........................ 15
> Hello Time..................................... 2
> Bridge Hold Time............................... 6
> CST Regional Root.............................. 80:00:00:26:F2:AF:93:A5
> Regional Root Path Cost........................ 0
> --More-- or (q)uit
>
>
>
>      Associated FIDs           Associated VLANs
>      ---------------           ----------------
>      1                         1
>      100                        100
>      200                        200
>
> (FSM726V3) #show spanning-tree summary
>
> Spanning Tree Adminmode........... Enabled
> Spanning Tree Version............. IEEE 802.1d
> BPDU Guard Mode................... Disabled
> BPDU Filter Mode.................. Disabled
> Configuration Name................ 00-26-F2-AF-93-A5
> Configuration Revision Level...... 0
> Configuration Digest Key.......... 0xac36177f50283cd4b83821d8ab26de62
> Configuration Format Selector..... 0
> No MST instances to display.
>
> =======================================
> After sending the invalid timer packet:
>
> (FSM726V3) #
> (FSM726V3) #
> (FSM726V3) #show spanning-tree summary
>
> Spanning Tree Adminmode........... Enabled
> Spanning Tree Version............. IEEE 802.1d
> BPDU Guard Mode................... Disabled
> BPDU Filter Mode.................. Disabled
> Configuration Name................ 00-26-F2-AF-93-A5
> Configuration Revision Level...... 0
> Configuration Digest Key.......... 0xac36177f50283cd4b83821d8ab26de62
> Configuration Format Selector..... 0
> No MST instances to display.
>
> (FSM726V3) #show spanning-tree
>
> Bridge Priority................................ 32768
> Bridge Identifier.............................. 80:00:00:26:F2:AF:93:A5
> Time Since Topology Change..................... 0 day 0 hr 0 min 12 sec
> Topology Change Count.......................... 2
> Topology Change in progress.................... TRUE
> Designated Root................................ 10:00:00:20:A1:F0:88:50
> Root Path Cost................................. 200004
> Root Port Identifier........................... 80:01
> Bridge Max Age................................. 255
> Bridge Max Hops................................ 20
> Bridge Tx Hold Count........................... 6
> Bridge Forwarding Delay........................ 255
> Hello Time..................................... 10
> Bridge Hold Time............................... 6
> CST Regional Root.............................. 80:00:00:26:F2:AF:93:A5
> Regional Root Path Cost........................ 0
> --More-- or (q)uit
>
>
>
>      Associated FIDs           Associated VLANs
>      ---------------           ----------------
>      1                          1
>      100                        100
>      200                        200
>
> (FSM726V3) #
>
>
> =========================================
> As Cisco doesnt accept this type of BPDU it means that it is a bug to be
> fixed on Linux, as i conclude.
>
>
    The Linux bridge does not do BPDU validations. And most of the
implementations don't do validations, since STD doesn't mentioned anything
about developers started ignoring it.
    The way people use linux bridges are different from Cisco or Brocade or
Juniper routers. Bridge maintainer may have the right answer for this
(Adding him in CC)


> Please let me know if you think otherwise.
>
> Regards,
> Sujata
>
>
>
>
>
> --- On *Fri, 6/15/12, Sasikanth babu <sasikanth.v19@gmail.com>* wrote:
>
>
> From: Sasikanth babu <sasikanth.v19@gmail.com>
> Subject: Re: [Bridge] Query on Sapnning tree implementation from standard
> point of view
> To: "Sujata Verma" <sujataverma3@yahoo.com>
> Cc: bridge@lists.linux-foundation.org
> Date: Friday, June 15, 2012, 7:25 PM
>
>
>
> On Fri, Jun 15, 2012 at 5:55 PM, Sujata Verma <sujataverma3@yahoo.com<http://mc/compose?to=sujataverma3@yahoo.com>
> > wrote:
>
> Thanks. I was doing the same experiment on few switches, i could get hold
> of and this is the result:
>
> Cisco Switch catalyst 2950 : Completely ignoring the packet, so
> validations are proper.
>
> Netgear FSM726V3 : Hello timer is validated and is propagated as 10
> instead of 255 ( which i sent) other max age and forward delay still it
> accepts as 255.
>
>    I don't think STP std has mentioned this propagation, As far as I know
> this prorogation is wrong. I think this must be a bug in Netgear switch.
>
> DLINK-DES-3026 : No validation done and accepts all as 255 ( max age,
> forward delay and hello timer)
>
> In both Netgear and Dlink the message age is changed to 16, which i am not
> sure why it has happened ?
>
> my setup is simple
>
>   PC1------Switch------PC2
>
> From PC1 i am sending invalid timer values and observing on PC2.
>
>
>     Are you doing any port mirroring here to capture packets on PC2?. How
> are you sending packets from PC1 (running linux bridge?)?
>
>
> I am attaching wireshark capture for Dlink and Netgear STP packets.
>
>    Can you send out complete packet capture from start of your test to the
> end to analyze
>
>     Thanks
>     Sasi
>
> Please let me know if any one has any idea or comment on this.
>
> Thanks,
> Sujata
>
>
>
>
>
>
>
>
> --- On *Thu, 6/14/12, Sasikanth babu <sasikanth.v19@gmail.com<http://mc/compose?to=sasikanth.v19@gmail.com>
> >* wrote:
>
>
> From: Sasikanth babu <sasikanth.v19@gmail.com<http://mc/compose?to=sasikanth.v19@gmail.com>
> >
> Subject: Re: [Bridge] Query on Sapnning tree implementation from standard
> point of view
> To: "Sujata Verma" <sujataverma3@yahoo.com<http://mc/compose?to=sujataverma3@yahoo.com>
> >
> Cc: bridge@lists.linux-foundation.org<http://mc/compose?to=bridge@lists.linux-foundation.org>
> Date: Thursday, June 14, 2012, 6:09 PM
>
>
>
> On Thu, Jun 14, 2012 at 5:53 PM, Sujata Verma <sujataverma3@yahoo.com<http://mc/compose?to=sujataverma3@yahoo.com>
> > wrote:
>
> Hi ,
>
> I am going through spanning tree protocol and was testing it on Linux. My
> observation is there is no validation of timers for configuration BPDU.
> Lets say Root bridge received another BPDU from new bridge with invalid
> timer values but less priority, the existing bridge is becoming non-root
> bridge and is advertising the invalid timer values.
>
> As i have gone through 802.1D-1998 standard, i understand that 2004 is
> current one but i was looking into STP not RSTP, i preferred to read this
> standard. I find these lines:
>
> ===============================================
> 9.3.3 Validation of received BPDUs
>
> A Bridge Protocol Entity shall process a received BPDU as specified in 8.7
> if and only if the BPDU contains at least four octets and the Protocol
> Identifier has the value specified for BPDUs (9.3.2), and
> a) The BPDU Type denotes a Configuration BPDU and the BPDU contains at
> least 35 octets, and the
> value of the BPDUs Message Age parameter is less than that of its Max Age
> parameter; or
>
> b) The BPDU Type denotes a Topology Change Notification BPDU.
> In case a), any octets that are present beyond Octet 35 are ignored, as
> far as processing according to this
> standard is concerned. Similarly, in case b), any octets beyond Octet 4
> are ignored.
>
> ============================================
>
> Does this implies that any value timer values present within octet 35 is
> valid value and there is no validation done. Even if range for hello timer,
> max age and forward delay is defined and is limited. Is it an issue or fine
> within the standard?
>
>   Not all STP implementation do BPDU validations i.e validates all BPDU
> parameters present within 35 octet. The validation checks for invalid
> values present in the bpdu,
>   if the BPDU validation fails it drops the BPDU. The have seen this
> validations in proprietary software.
>
>
> Please help me understand this issue and thanks for any comments.
>
> Regards,
> Sujata
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org<http://mc/compose?to=Bridge@lists.linux-foundation.org>
> https://lists.linuxfoundation.org/mailman/listinfo/bridge
>
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org<http://mc/compose?to=Bridge@lists.linux-foundation.org>
> https://lists.linuxfoundation.org/mailman/listinfo/bridge
>
>
>

--047d7b33d8a6cb5c6f04c2c131ae
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">On Mon, Jun 18, 2012 at=
 3:05 PM, Sujata Verma <span dir=3D"ltr">&lt;<a href=3D"mailto:sujataverma3=
@yahoo.com" target=3D"_blank">sujataverma3@yahoo.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td styl=
e=3D"font:inherit" valign=3D"top">Ok. <br><div class=3D"im"><br>=A0 I don&#=
39;t think STP std has mentioned this propagation, As far as I know
 this prorogation is wrong. I think this must be a bug in Netgear=20
switch.<br><br></div>&gt;&gt;&gt; My setup is=A0 <br><br>=A0=A0=A0 PC1( Win=
dows PC) ----Switch------PC2 ( Windows PC)<br><br>Using Colasoft builder to=
ol, i captured one STP packet modified the bridge priority such that it bec=
omes root bridge , put all invalid values for timers as 255 and sent to the=
 switch. My switch is linux PC, netgear switch and dlink switch for compari=
son purposes. <br>
<br>As switch receives the better BID packet it stop advertising it self as=
 bridge and take values of timers from root bridge which is 255 for bridge,=
 hello and forward delay in my case.<br><br>So the switch receives this pac=
ket and updates its cost, root information and sends out on another port on=
 which PC2 is connected and where i am seeing it on wireshark with all time=
r values as received from root bridge. This is all fine, the only problem i=
s, its not validating the timer values which seems a bug to me , as the tim=
er values are defined within the limit in
 standard.<br><br>If Netgear is doing validation of the hello timer and is =
putting the maximum allowed value seems fine to me and not a bug. But still=
, i think forward delay and max age should also be validated before accepti=
ng new BPDU as root bridge.<br>
<br>As in linux/dlink it is not doing any validation and sending bpdu with=
=A0 255 values, which is not correct as it could lead to delay of convergen=
ce time in case of root failure.<br><br>In netgear switch the command displ=
ay before and after are as follows:<br>
<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>(FSM726V3) #show =
spanning-tree<br><br>Bridge Priority................................ 32768<=
br>Bridge Identifier.............................. 80:00:00:26:F2:AF:93:A5<=
br>Time Since Topology Change..................... 0 day 0 hr 42 min 14 sec=
<br>
Topology Change Count.......................... 1<br>Topology Change in pro=
gress.................... FALSE<br>Designated
 Root................................ 80:00:00:26:F2:AF:93:A5<br>Root Path =
Cost................................. 0<br>Root Port Identifier............=
............... 00:00<br>Bridge Max Age................................. 20=
<br>
Bridge Max Hops................................ 20<br>Bridge Tx Hold Count.=
.......................... 6<br>Bridge Forwarding Delay....................=
.... 15<br>Hello Time..................................... 2<br>Bridge Hold=
 Time............................... 6<br>
CST Regional Root.............................. 80:00:00:26:F2:AF:93:A5<br>=
Regional Root Path Cost........................ 0<br>--More-- or (q)uit<br>=
<br><br><br>=A0=A0=A0=A0 Associated FIDs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Asso=
ciated VLANs<br>=A0=A0=A0=A0 ---------------=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
----------------<br>
=A0=A0=A0=A0
 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
1<br>=A0=A0=A0=A0 100=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 100<br>=A0=A0=A0=A0 200=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 200<br><br>(FSM726V3) #show spanning-tree=
 summary<br><br>Spanning Tree Adminmode........... Enabled<br>Spanning Tree=
 Version............. IEEE 802.1d<br>
BPDU Guard Mode................... Disabled<br>BPDU Filter Mode............=
...... Disabled<br>Configuration Name................ 00-26-F2-AF-93-A5<br>=
Configuration Revision Level...... 0<br>Configuration Digest Key.......... =
0xac36177f50283cd4b83821d8ab26de62<br>
Configuration Format Selector..... 0<br>No MST instances to
 display.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>After sendi=
ng the invalid timer packet:<br><br>(FSM726V3) #<br>(FSM726V3) #<br>(FSM726=
V3) #show spanning-tree summary<br><br>Spanning Tree Adminmode........... E=
nabled<br>
Spanning Tree Version............. IEEE 802.1d<br>BPDU Guard Mode..........=
......... Disabled<br>BPDU Filter Mode.................. Disabled<br>Config=
uration Name................ 00-26-F2-AF-93-A5<br>Configuration Revision Le=
vel...... 0<br>
Configuration Digest Key.......... 0xac36177f50283cd4b83821d8ab26de62<br>Co=
nfiguration Format Selector..... 0<br>No MST instances to display.<br><br>(=
FSM726V3) #show spanning-tree<br><br>Bridge Priority.......................=
......... 32768<br>
Bridge Identifier.............................. 80:00:00:26:F2:AF:93:A5<br>=
Time Since Topology Change..................... 0 day 0 hr 0 min 12 sec<br>=
Topology Change Count.......................... 2<br>Topology Change in pro=
gress....................
 TRUE<br>Designated Root................................ 10:00:00:20:A1:F0:=
88:50<br>Root Path Cost................................. 200004<br>Root Por=
t Identifier........................... 80:01<br>Bridge Max Age............=
..................... 255<br>
Bridge Max Hops................................ 20<br>Bridge Tx Hold Count.=
.......................... 6<br>Bridge Forwarding Delay....................=
.... 255<br><span style=3D"color:rgb(255,0,0)">Hello Time..................=
................... 10</span><br>
Bridge Hold Time............................... 6<br>CST Regional Root.....=
......................... 80:00:00:26:F2:AF:93:A5<br>Regional Root Path Cos=
t........................ 0<br>--More-- or (q)uit<br><br><br><br>=A0=A0=A0=
=A0 Associated FIDs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Associated VLANs<br>
=A0=A0=A0=A0 ---------------=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
 ----------------<br>=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1<br>=A0=A0=A0=A0 100=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 100<br>=A0=A0=A0=A0 =
200=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 20=
0<br><br>(FSM726V3) #<br><br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>As Cisco doesnt accept this type of BPDU it means that it is a bu=
g to be fixed on Linux, as i conclude. <br>
<br></td></tr></tbody></table></blockquote><div><br>=A0=A0=A0 The Linux bri=
dge does not do BPDU validations. And most of the implementations don&#39;t=
 do validations, since STD doesn&#39;t mentioned anything about developers =
started ignoring it.<br>
=A0=A0=A0 The way people use linux bridges are different from Cisco or Broc=
ade or Juniper routers. Bridge maintainer may have the right answer for thi=
s (Adding him in CC)<br>=A0 <br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td styl=
e=3D"font:inherit" valign=3D"top">Please let me know if you think otherwise=
.<br><br>Regards,<br>Sujata<div class=3D"im"><br><br><br><br><br>--- On <b>=
Fri, 6/15/12, Sasikanth babu <i>&lt;<a href=3D"mailto:sasikanth.v19@gmail.c=
om" target=3D"_blank">sasikanth.v19@gmail.com</a>&gt;</i></b> wrote:<br>
</div><blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-left=
:5px;padding-left:5px"><div class=3D"im"><br>From: Sasikanth babu &lt;<a hr=
ef=3D"mailto:sasikanth.v19@gmail.com" target=3D"_blank">sasikanth.v19@gmail=
.com</a>&gt;<br>
Subject: Re: [Bridge] Query on Sapnning tree implementation from standard p=
oint of view<br>To: &quot;Sujata Verma&quot; &lt;<a href=3D"mailto:sujatave=
rma3@yahoo.com" target=3D"_blank">sujataverma3@yahoo.com</a>&gt;<br>Cc: <a =
href=3D"mailto:bridge@lists.linux-foundation.org" target=3D"_blank">bridge@=
lists.linux-foundation.org</a><br>
</div>Date: Friday, June 15, 2012, 7:25 PM<div><div class=3D"h5"><br><br><d=
iv><div dir=3D"ltr"><br><div>On Fri, Jun 15, 2012 at 5:55 PM, Sujata Verma =
<span dir=3D"ltr">&lt;<a rel=3D"nofollow" href=3D"http://mc/compose?to=3Dsu=
jataverma3@yahoo.com" target=3D"_blank">sujataverma3@yahoo.com</a>&gt;</spa=
n> wrote:<br>
<blockquote style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td styl=
e=3D"font:inherit" valign=3D"top">Thanks. I was doing the same experiment o=
n few switches, i could get hold of and this is the result:<br><br>Cisco Sw=
itch catalyst 2950 : Completely ignoring the packet, so validations are pro=
per.<br>

<br>Netgear FSM726V3 : Hello timer is validated and is propagated as 10 ins=
tead of 255 ( which i sent) other max age and forward delay still it accept=
s as 255. <br><br></td></tr></tbody></table></blockquote><div>=A0=A0 I don&=
#39;t think STP std has mentioned this propagation, As far as I know this p=
rorogation is wrong. I think this must be a bug in Netgear switch.<br>

<br></div><blockquote style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><table cellpadding=3D"0" cellspacing=
=3D"0" border=3D"0"><tbody><tr><td style=3D"font:inherit" valign=3D"top">
DLINK-DES-3026 : No validation done and accepts all as 255 ( max age, forwa=
rd delay and hello timer)<br><br>In both Netgear and Dlink the message age =
is changed to 16, which i am not sure why it has happened ? <br><br>my setu=
p is simple<br>

<br>=A0 PC1------Switch------PC2<br><br>From PC1 i am sending invalid timer=
 values and observing on PC2.<br></td></tr></tbody></table></blockquote><di=
v><br>=A0 =A0 Are you doing any port mirroring here to capture packets on P=
C2?. How are you sending packets from PC1 (running linux bridge?)?<br>

</div><blockquote style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><table cellpadding=3D"0" cellspacing=3D"0=
" border=3D"0"><tbody><tr><td style=3D"font:inherit" valign=3D"top">
<br>I am attaching wireshark capture for Dlink and Netgear STP packets.<br>=
<br></td></tr></tbody></table></blockquote><div>=A0=A0 Can you send out com=
plete packet capture from start of your test to the end to analyze<br>=A0=
=A0 <br>

=A0=A0=A0 Thanks<br>=A0=A0=A0 Sasi<br><br></div><blockquote style=3D"margin=
:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td sty=
le=3D"font:inherit" valign=3D"top">

Please let me know if any one has any idea or comment on
 this.<br><br>Thanks,<br>Sujata<br></td></tr></tbody></table></blockquote><=
div>=A0</div><blockquote style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><table cellpadding=3D"0" cellspaci=
ng=3D"0" border=3D"0">

<tbody><tr><td style=3D"font:inherit" valign=3D"top"><br><br><br><br><br>--=
- On <b>Thu, 6/14/12, Sasikanth babu <i>&lt;<a rel=3D"nofollow" href=3D"htt=
p://mc/compose?to=3Dsasikanth.v19@gmail.com" target=3D"_blank">sasikanth.v1=
9@gmail.com</a>&gt;</i></b> wrote:<br>

<blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;p=
adding-left:5px"><br>From: Sasikanth babu &lt;<a rel=3D"nofollow" href=3D"h=
ttp://mc/compose?to=3Dsasikanth.v19@gmail.com" target=3D"_blank">sasikanth.=
v19@gmail.com</a>&gt;<br>
Subject: Re: [Bridge] Query on Sapnning tree implementation from standard p=
oint of view<br>
To: &quot;Sujata Verma&quot; &lt;<a rel=3D"nofollow" href=3D"http://mc/comp=
ose?to=3Dsujataverma3@yahoo.com" target=3D"_blank">sujataverma3@yahoo.com</=
a>&gt;<br>Cc: <a rel=3D"nofollow" href=3D"http://mc/compose?to=3Dbridge@lis=
ts.linux-foundation.org" target=3D"_blank">bridge@lists.linux-foundation.or=
g</a><br>

Date: Thursday, June 14, 2012, 6:09 PM<div><div><br><br><div><div dir=3D"lt=
r"><br><div>On Thu, Jun 14, 2012 at 5:53 PM, Sujata Verma <span dir=3D"ltr"=
>&lt;<a rel=3D"nofollow" href=3D"http://mc/compose?to=3Dsujataverma3@yahoo.=
com" target=3D"_blank">sujataverma3@yahoo.com</a>&gt;</span> wrote:<br>

<blockquote style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td styl=
e=3D"font:inherit" valign=3D"top">Hi ,<br><br>I am going through spanning t=
ree protocol and was testing it on Linux. My observation is there is no val=
idation of timers for configuration BPDU.=A0 Lets say Root bridge received =
another BPDU from new bridge with invalid timer values but less priority, t=
he existing bridge is becoming non-root bridge and is advertising the inval=
id timer values. <br>


<br>As i have gone through 802.1D-1998 standard, i understand that 2004 is =
current one but i was looking into STP not RSTP, i preferred to read this s=
tandard. I find these lines:<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>


9.3.3 Validation of received BPDUs<br><br>A Bridge Protocol Entity shall pr=
ocess a received BPDU as specified in 8.7 if and only if the BPDU contains =
at least four octets and the Protocol Identifier has the value specified fo=
r BPDUs (9.3.2), and<br>


a) The BPDU Type
 denotes a Configuration BPDU and the BPDU contains at least 35 octets, and=
 the<br>value of the BPDUs Message Age parameter is less than that of its M=
ax Age parameter; or<br><br>b) The BPDU Type denotes a Topology Change Noti=
fication BPDU.<br>


In case a), any octets that are present beyond Octet 35 are ignored, as far=
 as processing according to this<br>standard is concerned. Similarly, in ca=
se b), any octets beyond Octet 4 are ignored.<br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>


<br>Does this implies that any value timer values present within octet 35 i=
s valid value and there is no validation done. Even if range for hello time=
r, max age and forward delay is defined and is limited. Is it an issue or f=
ine within the standard?<br>


<br></td></tr></tbody></table></blockquote><div>=A0 Not all STP implementat=
ion do BPDU validations i.e validates all BPDU parameters present within 35=
 octet. The validation checks for invalid values present in the bpdu, <br>


=A0 if the BPDU validation fails it drops the BPDU. The have seen this vali=
dations in proprietary software.<br>=A0 <br></div><blockquote style=3D"marg=
in:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">


<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td styl=
e=3D"font:inherit" valign=3D"top">Please help me understand this issue and =
thanks for any comments.<br><br>Regards,<br>Sujata<br><br></td></tr></tbody=
></table>


<br>_______________________________________________<br>
Bridge mailing list<br>
<a rel=3D"nofollow" href=3D"http://mc/compose?to=3DBridge@lists.linux-found=
ation.org" target=3D"_blank">Bridge@lists.linux-foundation.org</a><br>
<a rel=3D"nofollow" href=3D"https://lists.linuxfoundation.org/mailman/listi=
nfo/bridge" target=3D"_blank">https://lists.linuxfoundation.org/mailman/lis=
tinfo/bridge</a><br></blockquote></div><br></div>
</div></div></div></blockquote></td></tr></tbody></table><br>______________=
_________________________________<br>
Bridge mailing list<br>
<a rel=3D"nofollow" href=3D"http://mc/compose?to=3DBridge@lists.linux-found=
ation.org" target=3D"_blank">Bridge@lists.linux-foundation.org</a><br>
<a rel=3D"nofollow" href=3D"https://lists.linuxfoundation.org/mailman/listi=
nfo/bridge" target=3D"_blank">https://lists.linuxfoundation.org/mailman/lis=
tinfo/bridge</a><br></blockquote></div><br></div>
</div></div></div></blockquote></td></tr></tbody></table></blockquote></div=
><br></div>

--047d7b33d8a6cb5c6f04c2c131ae--
