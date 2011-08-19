MIME-Version: 1.0
Date: Fri, 19 Aug 2011 20:20:10 +0530
Message-ID: <CAL1-okbTkQdW7S3k01GU29Xy+WKZnCNxXunAXWVX6w-xd=6hwg@mail.gmail.com>
From: Vikas Dabas <vikas.dabas@trackpeers.com>
Content-Type: multipart/alternative; boundary=000e0cd14efa97b35804aadcd8ae
Subject: [Bridge] Q-in-Q (stacked VLANs) forwarding in bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--000e0cd14efa97b35804aadcd8ae
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have the following setup

ifconfig eth0 0.0.0.0 up
ifconfig eth1 0.0.0.0 up

vconfig add eth0 2
ifconfig eth0.2 0.0.0.0 up
vconfig add eth0.2 4
ifconfig eth0.2.4 0.0.0.0 up

brctl addbr br-lan
brctl addif br-lan eth1
brctl addif br-lan eth0.2.4

Now when I try sending untagged packets from eth1, i get no packets out of
the eth0 interface,  ideally i should get double tagged packets coming out.

However when i add
brctl addif br-lan eth0.2
I can see single tagged packets with VID 2

Further, I removed eth0.2.4 from the bridge and assigned an IP 10.10.10.10
and tried Ping to 10.10.10.11
I was able to get double tagged packets with outer tag being VID 4 and inner
tag Being VID 2

Can some body explain why the interface eth0.2.4 can not send out stacked
VLAn packets in case it is part of a bridge?


REgards
Vikas

--000e0cd14efa97b35804aadcd8ae
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I have the following setup<br><br>ifconfig eth0 0.0.0.0 up<br>if=
config eth1 0.0.0.0 up<br><br>vconfig add eth0 2<br>ifconfig eth0.2 0.0.0.0=
 up<br>vconfig add eth0.2 4<br>ifconfig eth0.2.4 0.0.0.0 up<br><br>brctl ad=
dbr br-lan<br>
brctl addif br-lan eth1<br clear=3D"all">brctl addif br-lan eth0.2.4<br><br=
>Now when I try sending untagged packets from eth1, i get no packets out of=
 the eth0 interface,=A0 ideally i should get double tagged packets coming o=
ut.<br>
<br>However when i add <br>brctl addif br-lan eth0.2<br>I can see single ta=
gged packets with VID 2<br><br>Further, I removed eth0.2.4 from the bridge =
and assigned an IP 10.10.10.10 and tried Ping to 10.10.10.11<br>I was able =
to get double tagged packets with outer tag being VID 4 and inner tag Being=
 VID 2<br>
<br>Can some body explain why the interface eth0.2.4 can not send out stack=
ed VLAn packets in case it is part of a bridge?<br><br><br>REgards<br>Vikas=
<br><br><br><br>
<br><br><br><br><br><br><br>

--000e0cd14efa97b35804aadcd8ae--
