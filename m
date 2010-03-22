From: =?UTF-8?Q?Olek?= <ned_wed@o2.pl>
Mime-Version: 1.0
Message-ID: <7515418c.2b6d6e39.4ba7656f.e09eb@o2.pl>
Date: Mon, 22 Mar 2010 13:41:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] =?utf-8?q?Bridge_and_port_forwarding?=
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,
I'm=20stuck=20with=20the=20configuration=20of=20my=20server.
Currently=20my=20network=20is=20set=20up=20like=20this:


Internet=20
=20=20|
=20=20|
Router
(WAN=20192.168.0.99,=20LAN=20192.168.1.99,=20
port=20forwarding=201-65535)
=20=20|
=20=20|
Ubuntu=20Server=2064-bit
(WAN(eth0)=20192.168.1.110,=20LAN-bridge(eth1,eth2)=20192.168.0.110)


Description=20of=20the=20problem:
When=20I=20connect=20my=20desktop=20to=20the=20router=20LAN=20and=20try=20=
to=20access=20FTP,=20SSH=20or=20others=20the=20server=20answers=20correct=
=20(brigde=20enabled).
When=20I=20try=20to=20access=20the=20server=20from=20the=20Internet,=20i=20=
get=20no=20answer.
When=20the=20bridge=20is=20disabled=20I=20can=20easily=20access=20SSH=20o=
r=20FTP=20from=20the=20Internet.

My=20bridge=20config:
ifconfig=20eth1=20promisc=20up
ifconfig=20eth2=20promisc=20up
brctl=20addbr=20mybridge
brctl=20addif=20mybridge=20eth1
brctl=20addif=20mybridge=20eth2

The=20firewall=20is=20disabled,=20to=20get=20sure=20it's=20not=20blocking=
=20network=20traffic.
Maybe=20someone=20knows=20what's=20causing=20this=20problem?

King=20regards
Olek






