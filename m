Message-ID: <8135BF451955D5119DE200203567D82A060ED6F5@ge-muc-exch-01.azlan.ger>
From: Josef Brunner <Josef.Brunner@azlan.com>
Subject: RE: [Bridge] Bridging VLANs
Date: Fri, 23 Sep 2005 08:00:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'R Harper ' <rharper333@hotmail.com>, "'bridge@lists.osdl.org '" <bridge@lists.osdl.org>

remember the use of the vconfig command. it helps you to define "access
ports" that means that you can tell the system what default vlan (or vlans)
to use for a certain interface (so that it can remove the vlan tag from the
trunked packet)...

if you want to bridge all your  traffic - including vlan traffic - just
confige the bridge in a "normal behaviour".=20

just one question: by saying vlan traffic you mean trunk or trunked or
tagged traffic, right ?=20

josef=20
=20

-----Original Message-----
From: R Harper
To: bridge@lists.osdl.org
Sent: 22.09.2005 14:34
Subject: [Bridge] Bridging VLANs

Hi I have a simple question

I want to bridge both normal ethernet frames and VLAN packets
do I have to explicitly bridge the VLAN packets (e.g. vconfig br0 30)
or=20
are they bridge by default
Is it sufficient to configure a VLAN bridge like this or am I forgetting

something?

regards
R.Harper

_________________________________________________________________
F=E5 alle de nye og sjove ikoner med MSN Messenger
http://messenger.msn.dk/

 <<ATT38976.txt>>=20

___________________________________________________________________________=
____
Disclaimer

This message may contain confidential information solely for its
intended recipients and others may not distribute, copy or use it. If
you have received this communication in error please tell us either by
return e-mail or at the numbers above and delete it, and any copies of
it.


