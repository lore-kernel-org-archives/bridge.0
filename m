Message-Id: <200506220848.j5M8m2jA000868@smtp.osdl.org>
From: "Osama Abu Elsorour" <osama@wayout.net>
Subject: RE: [Bridge] Help on Brctl
Date: Thu, 23 Jun 2005 11:46:10 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <000801c57621$5a2db370$6800a8c0@asianitg2>
Content-Transfer-Encoding: quoted-printable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Jitendra' <jitendra_k@asianitg.com>, bridge@osdl.org


Looks like you may have misconfigured your interfaces. Remember:
- Enslaved Ethernet interfaces should not have any IP addresses configured
(bridge ports).
- The bridge interface is the one that should be configured with your IP
addresses

The reason is that the Ethernet interfaces are just bridging ports (layer 2)
and the new bridge interface(s) (br0, br1, etc) are the enslaving logical
interfaces.

You may use ifconfig or ip commands to perform IP configuration on the
bridge interface.

________________________________________
From: bridge-bounces@lists.osdl.org [mailto:bridge-bounces@lists.osdl.org]
On Behalf Of Jitendra
Sent: Tuesday, June 21, 2005 8:23 AM
To: bridge@osdl.org
Subject: [Bridge] Help on Brctl

Respected sir,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I have created the Bridge usi=
ng "brctl" utilities and I have
successfully established the Bridge between the two Ethernet card and Its
also working fine but the problem is like ......Its not pinging from the
other machine ( i mean to say that machine is not any more accessible in
network) so can you please help , why these is so happening b'cos the bridge
is still working perfectly but=A0 i want able to access that machine from my
network, so please help
=A0
=A0
=A0
Thanking You=20
Jitendra
=A0
=A0


