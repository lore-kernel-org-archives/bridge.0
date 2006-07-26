Message-ID: <44C77FD2.2030208@seskion.de>
Date: Wed, 26 Jul 2006 16:44:34 +0200
From: Juergen Pfeiffer <j.pfeiffer@seskion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Is bridgeing possible with kernel 2.6.10
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org, uclinux-dev@uclinux.org

Hi

I didn't get bridgeing to work with Linux kernel 2.6.10 (coldfire 5485)=20
yet. When i try to configure bridgeing
with "brctl", everything seems to be ok, but i if i try to ping through=20
my bridge, i see ARP-Request arriving on the other side, but the
ARP-Responses do not go back through the bridge.
Now i could read in=20
"http://www.tldp.org/HOWTO/Ethernet-Bridge-netfilter-HOWTO-2.html#ss2.1"
that "Use of kernel 2.6 is not yet a good idea".
So do i have a change to get it working?

Thank You
--=20
------------------------------------------------------------------------
J=FCrgen Pfeiffer =09
=09
	* _mailto:j.pfeiffer@seskion.de_
SesKion Softwareentwicklung und System Konzeption GmbH =09
=09
	( : +49-711-9905814
Karlsruher Str. 11/1 =09
=09
	Fax: +49-711-9905827
D-70771 Leinfelden-Echterdingen =09
=09
	1 _http://www.seskion.de_

------------------------------------------------------------------------
