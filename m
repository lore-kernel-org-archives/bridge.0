Message-ID: <41B7408C.3040706@twilight-hall.net>
Date: Wed, 08 Dec 2004 18:57:32 +0100
From: =?ISO-8859-1?Q?Rapha=EBl_Rigo_ML?= <ml@twilight-hall.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Bridge and broadcasting (ping)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello,
first please CC me since i did not subscribe.
i am currently setting up a VPN with some friends, using openvpn.
Let's do some ascii art to explain the (basic) network :



  __________                   ___________
| 10.0.4.1 |  <--- VPN --->  | 10.0.0.10 |
  ----------                   -----------
       |                             | eth0
  __________                   __________
| 10.0.4.2 |                 | 10.0.0.1 |
  ----------                   ----------

The VPN is materialized by a tap ethernet interface. I am 10.0.0.10.
I am bridging eth0 (lan) and tap1 (vpn) together. Everything works fine=20
except that broadcast pings from 10.0.4.1 only get a reply from 10.0.0.10.
Here's a tcpdump of the ping on the bridge interface :
18:55:31.683690 IP 10.0.4.1 > 10.0.255.255: icmp 64: echo request seq 30
18:55:31.683733 IP 10.0.0.10 > 10.0.4.1: icmp 64: echo reply seq 30
18:55:31.683841 IP 10.0.0.1 > 10.0.0.10: icmp 64: echo reply seq 30

As you can see .1 answers to .10, which is wrong.

How can I make it work ?

The thing is that it works on 10.0.4.1, I mean, if i ping 10.0.255.255=20
from 10.0.0.10, 10.0.4.2 replies. This gateway is using shorewall, I=20
think the config of iptables has something to do with this but I cannot=20
find what.

I'm using linux 2.6.10-rc3.

Regards,
Rapha=EBl
