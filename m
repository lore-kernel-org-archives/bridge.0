MIME-Version: 1.0
Message-ID: <48270.1254915796@oleco.net>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 7 Oct 2009 13:43:16 +0200
From: Carsten <fbndd@oleco.net>
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Problem Forwarding Bridge to Tap Device
Reply-To: fbndd@oleco.net
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,
I have a problem with bridge and tap network where I can't find a solution=
=20

first my scenario
=20
[ETHx][PC1] <-> [Switch] <-> [PC2][ETHx][VLANx][BR0][TAP0][VBox]

Switchport of PC1 is untagged in VLANx,  Switchport of PC2 is tagged in the=
 same VLAN. I can see the packets running as I want over all components.=20

Now my Problem

I send a Ping from VBox to PC1 all works fine, while the ping is running I =
restart PC1, as suggested ping now fail.
After PC1 is up again packet transport should work correctly, but it doesn'=
t  (exactly some times is ok, some times problem comes after 5th reboot or =
so but is coming if I have enough reboots of PC1)   .
So find the problem I dump the traffic of VLANx, BR0 and TAP0.=20
What I see:
@VLANx: arp request and reply=20
@ BR0: arp request and reply
@ TAP0: arp request
So I think the bridge stop forwarding packets to the TAP device and I don't=
 understand why.  Have anyone an idea?=20

Thx for help
----=20
versendet mit www.oleco.de Mail - Anmeldung und Nutzung kostenlos!
Oleco www.netlcr.org - jetzt auch mit Spamschutz.
