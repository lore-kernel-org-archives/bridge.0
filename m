Return-Path: <fuji246@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=/mRuDLew6GJ0LqN25DE6mbdGSzac2Y95/llQbUMdeo4=;
	b=D9LlRyS489nnQcnQVw72IVSozyNXBWbL2HRcFFQ/WzU8ts8KqmwH9U5klXjVaw6RRE
	pYW+hH/TRBwzVzeI/sfLhXS7Lyv39vbHrVEnwkahhlvo73TxtyNba9pYtuHFFv4No0js
	MFkQP7vrIE4W5rGQLNIBHH6oNii6foUgE6rEgYzhG+qFbcQkptv+vS0a2MFwvt3slxu1
	CmzIduRMwa1njMCpZEDooU6mO+VsYd2cMJ1+KBUSDqzGXROfAQqYHgxqHj3SlpHkXl5V
	j15tM8F9pqTMljLVZIsSXDh/RvtmOg22utCQTpyVRbg9KRvwUWZIVnxC1PtuFe2IJ4bk
	lJog==
MIME-Version: 1.0
From: Fu Jiantao <fuji246@gmail.com>
Message-ID: <CAKmxLjUNnNF+zBj43YZ8jKG=HOyETxewr4kq=Atnd4e6SBNkAA@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000000f907c056704bc10"
Subject: [Bridge] Traffic shaping with bridge.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Sat, 10 Mar 2018 01:21:58 -0000
To: bridge@lists.linux-foundation.org

--0000000000000f907c056704bc10
Content-Type: text/plain; charset="UTF-8"

Hi,

  I'm having some problem to make traffic shaping work with bridge, the
topology is below, the same script to set the delay/loss works for
10.34.201.45 and 10.35.201.47, but not working
for 10.35.200.2.

  I use ifb device for traffic control, say for example, adding 300ms delay
for dst 10.35.200.2, and I use tcpdump to capture ifb1, and no packets. And
if I set the dst to 10.35.201.47 or 10.35.201.45, it works.

  I tried to read the code, the "sch_handle_ingress" is before "rx_handle",
and I can capture packets on enp2s0, but can't figure out why the filter is
not working, 10.35.200.2 is in different subnet with 10.35.201.45, but the
bridge works b/c it just use MAC address, even it's not the typical
scenario to put them in different subnet.

  Thanks in advance!

+ tc qdisc add dev enp2s0 ingress

+ tc filter add dev enp2s0 parent ffff: protocol ip prio 1 u32 match ip dst
10.35.200.2 flowid 1:1 action mirred egress redirect dev ifb1

+ tc qdisc add dev ifb1 root netem loss random 0% delay 300ms


    +-------------+ 10.35.200.2
    | jianfu-sx10 +------------------+
    +-------------+                  |
                                     |
    +-------------+ 10.35.201.45  +--------+     +----------+
10.35.201.10 +-------+
    | marcel-sx80 +---------------| switch |-----| emulator
|--------------+ Linus |
    +-------------+               +--------+     +----------+      |
    +-------+
                                     |          enp3s0     enp2s0  |
    +-------------+ 10.35.201.47     |                             |
    | jianfu-win  +------------------+                             |
    +-------------+                                                |
                                                                   |
    +-------------+ 10.22.79.106                                   |
    | anand-sx10  +------------------------------------+-----------+
    +-------------+                                    |
                                                       |
    +-------------+ 10.22.79.170                       |
    | jianfu-ttc7 +------------------------------------+
    +-------------+

--0000000000000f907c056704bc10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>=C2=A0 I&#39;m having some problem =
to make traffic shaping work with bridge, the topology is below, the same s=
cript to set the delay/loss works for 10.34.201.45 and 10.35.201.47, but no=
t working</div><div>for 10.35.200.2.</div><div><br></div><div>=C2=A0 I use =
ifb=C2=A0device for traffic control, say for example, adding 300ms delay fo=
r dst=C2=A010.35.200.2, and I use tcpdump=C2=A0to capture ifb1, and no pack=
ets. And if I set the dst=C2=A0to 10.35.201.47 or 10.35.201.45, it works.</=
div><div><br></div><div>=C2=A0 I tried to read the code, the &quot;sch_hand=
le_ingress&quot; is before &quot;rx_handle&quot;, and I can capture packets=
 on enp2s0<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;f=
ont-size:small;font-style:normal;font-variant-ligatures:normal;font-variant=
-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-in=
dent:0px;text-transform:none;white-space:normal;word-spacing:0px;background=
-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color=
:initial;float:none;display:inline">, but can&#39;t figure out why the filt=
er is not working, 10.35.200.2 is in different subnet with 10.35.201.45, bu=
t the bridge works b/c it just use MAC address, even it&#39;s not the typic=
al scenario to put them in different subnet.</span></div><div><span style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial;float:none;d=
isplay:inline"><br></span></div><div><span style=3D"color:rgb(34,34,34);fon=
t-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial;float:none;display:inline">=C2=A0 Thank=
s in advance!</span></div><div><br></div><div>




<span></span>





<p class=3D"gmail-p1" style=3D"margin:0px;font-style:normal;font-variant:no=
rmal;font-weight:normal;font-stretch:normal;font-size:12px;line-height:norm=
al;font-family:&quot;Andale Mono&quot;;color:rgb(40,254,20);background-colo=
r:rgba(0,0,0,0.9)"><span class=3D"gmail-s1" style=3D"font-variant-ligatures=
:no-common-ligatures">+ tc qdisc add dev enp2s0 ingress</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-style:normal;font-variant:no=
rmal;font-weight:normal;font-stretch:normal;font-size:12px;line-height:norm=
al;font-family:&quot;Andale Mono&quot;;color:rgb(40,254,20);background-colo=
r:rgba(0,0,0,0.9)"><span class=3D"gmail-s1" style=3D"font-variant-ligatures=
:no-common-ligatures">+ tc filter add dev enp2s0 parent ffff: protocol ip p=
rio 1 u32 match ip dst 10.35.200.2 flowid 1:1 action mirred egress redirect=
 dev ifb1</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-style:normal;font-variant:no=
rmal;font-weight:normal;font-stretch:normal;font-size:12px;line-height:norm=
al;font-family:&quot;Andale Mono&quot;;color:rgb(40,254,20);background-colo=
r:rgba(0,0,0,0.9)"><span class=3D"gmail-s1" style=3D"font-variant-ligatures=
:no-common-ligatures">+ tc qdisc add dev ifb1 root netem loss random 0% del=
ay 300ms</span></p>


<br></div><div><br></div><div><pre style=3D"box-sizing:border-box;font-fami=
ly:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monosp=
ace;font-size:13.6px;margin-top:0px;margin-bottom:16px;font-style:normal;fo=
nt-variant:normal;font-weight:400;font-stretch:normal;line-height:1.45;word=
-wrap:normal;padding:16px;overflow:auto;background-color:rgb(246,248,250);b=
order-radius:3px;color:rgb(36,41,46);letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;word-spacing:0px;text-decoration-style=
:initial;text-decoration-color:initial"><code style=3D"box-sizing:border-bo=
x;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Cou=
rier,monospace;font-size:13.6px;padding:0px;margin:0px;background:transpare=
nt;border-radius:3px;word-break:normal;white-space:pre;border:0px;display:i=
nline;overflow:visible;line-height:inherit;word-wrap:normal">    +---------=
----+ 10.35.200.2
    | jianfu-sx10 +------------------+
    +-------------+                  |
                                     |
    +-------------+ 10.35.201.45  +--------+     +----------+ 10.35.201.10 =
+-------+
    | marcel-sx80 +---------------| switch |-----| emulator |--------------=
+ Linus |
    +-------------+               +--------+     +----------+      |       =
+-------+
                                     |          enp3s0     enp2s0  |
    +-------------+ 10.35.201.47     |                             |
    | jianfu-win  +------------------+                             |
    +-------------+                                                |
                                                                   |
    +-------------+ 10.22.79.106                                   |
    | anand-sx10  +------------------------------------+-----------+
    +-------------+                                    |
                                                       |
    +-------------+ 10.22.79.170                       |
    | jianfu-ttc7 +------------------------------------+
    +-------------+</code></pre><br></div><div><br></div></div>

--0000000000000f907c056704bc10--
