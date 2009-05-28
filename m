MIME-Version: 1.0
Date: Thu, 28 May 2009 13:58:49 +0530
Message-ID: <1de614680905280128v1d33285fi53a8d2b6ea88d096@mail.gmail.com>
From: Johnnie alan <johnniealan@gmail.com>
Content-Type: multipart/alternative; boundary=0016e644cefacdfdce046af4bf42
Subject: [Bridge] Ethernet Bridging.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@osdl.org, bridge@osdl.org, josh@imagestream.com, nick@fedchik.org.ua

--0016e644cefacdfdce046af4bf42
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all ,

I saw your posts on the net, I need one help from you.

I am creating a bridge br0 for eth0 and tap0 ( virtual ). The bridge will
actually receives the message and routes it to ethernet devices connected.

I was able to route the ethernet frames from tap0 to the outer world via the
bridge. But while receiving the response, all the frames with TCP is routed
to the eth0 device. The network knows only the MAC address of eth0. So while
receiving the ehternet frames, the destination MAC is that of eth0.

I used ebtables to translate the MAC address of the incomming packet using
the Brouting table and nat table . It works fine, but still the ethernet
frame goes to the eth0 device. I am puzzled to see this behaviour.
 Code:
ebtables -t broute -A BROUTING -i br0  -p ipv4 --ip-dst 10.66.67.247   -j
ACCEPT
ebtables -t broute -A BROUTING -i br0   -p ipv4 --ip-dst 10.66.67.247  -j
ACCEPT ebtables -t nat -A PREROUTING -i eth0 -p ipv4 --ip-dst 10.66.67.247
-j dnat --to-dst 72:CC:9B:60:D0:0E
Here  72:CC:9B:60:D0:0E is the MAC address of tap0.

My neccessity is to get only the ethernet frame to a particular IP address
on tap0 device.

Ex: I need to get ethernet frames is destined for 10.66.67.247 on the tap0
device.
I have the enabled the ipv4 forwarding and enabled the

Can you help me out. I am stuck here almost a week.
waiting for your response.

Thanks in advance
Alan J

--0016e644cefacdfdce046af4bf42
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi all ,</div>
<div>=A0</div>
<div>I saw your posts on the net, I need one help from you.</div>
<div>=A0</div>
<div>I am creating a bridge br0 for eth0 and tap0 ( virtual ). The bridge w=
ill actually receives the message and routes it to ethernet devices connect=
ed.<br><br>I was able to route the ethernet frames from tap0 to the outer w=
orld via the bridge. But while receiving the response, all the frames with =
TCP is routed to the eth0 device. The network knows only the MAC address of=
 eth0. So while receiving the ehternet frames, the destination MAC is that =
of eth0.<br>
<br>I used ebtables to translate the MAC address of the incomming packet us=
ing the Brouting table and nat table . It works fine, but still the etherne=
t frame goes to the eth0 device. I am puzzled to see this behaviour.<br>
</div>
<div style=3D"MARGIN: 5px 20px 20px">
<div class=3D"smallfont" style=3D"MARGIN-BOTTOM: 2px">Code:</div>
<div class=3D"smallfont" style=3D"MARGIN-BOTTOM: 2px">ebtables -t broute -A=
 BROUTING -i br0=A0 -p ipv4 --ip-dst 10.66.67.247=A0 =A0-j ACCEPT</div>ebta=
bles -t broute -A BROUTING -i br0=A0=A0 -p ipv4 --ip-dst 10.66.67.247=A0 -j=
 ACCEPT=20
<div class=3D"smallfont" style=3D"MARGIN-BOTTOM: 2px">
<div class=3D"smallfont" style=3D"MARGIN-BOTTOM: 2px">ebtables -t=A0nat -A=
=A0PREROUTING -i eth0 -p ipv4 --ip-dst 10.66.67.247 -j dnat --to-dst 72:CC:=
9B:60:D0:0E</div></div></div>
<div>Here=A0 72:CC:9B:60:D0:0E is the MAC address of tap0.<br><br>My necces=
sity is to get only the ethernet frame to a particular IP address on tap0 d=
evice.<br><br>Ex: I need to get ethernet frames is destined for 10.66.67.24=
7 on the tap0 device.<br>
</div>
<div>I have the enabled the ipv4 forwarding and enabled the </div>
<div><br>Can you help me out. I am stuck here almost a week.<br></div>
<div>waiting for your response.</div>
<div><br>Thanks in advance<br>Alan J</div>
<div>=A0</div>

--0016e644cefacdfdce046af4bf42--
