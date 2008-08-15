Message-ID: <48A5F125.2070700@free.fr>
Date: Fri, 15 Aug 2008 23:12:05 +0200
From: Benoit PAPILLAULT <benoit.papillault@free.fr>
MIME-Version: 1.0
References: <48A0B4AD.6030703@free.fr>
	<20080811163159.49cf9980@extreme>	<48A5E1E3.5060907@free.fr>	<alpine.DEB.1.10.0808152114540.27001@callisto.moose.malc.org.uk>
	<20080815133138.587c1005@extreme>
In-Reply-To: <20080815133138.587c1005@extreme>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] frame destinated to individual port MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Bridge@lists.linux-foundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Hemminger a =E9crit :
| On Fri, 15 Aug 2008 21:17:27 +0100 (BST)
| Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk> wrote:
|
|> At 22:06 today, Benoit PAPILLAULT wrote:
|>
|>> I am in a very preliminary phase, trying to learn how to implement
|>> routing and bridging under Linux. In order for the routing protocol to
|>> have proper topology view, it somehow needs to assign a unique IP on all
|>> interfaces and for bridging and those interfaces needs to be in the same
|>> bridge.
|> By my understanding (and it's a while since I read that paper so I
might be
|> wrong) you don't need unique IP addresses on all interfaces;
everything uses
|> MAC addresses.  To quote section 4.2 of the draft:
|>
|>     o  it runs directly over Layer 2, so therefore may be run with zero
|>        configuration (no IP addresses need to be assigned)
|>
|
| It looks an implementation or rbridge would do:
|   1. Set STP to "user mode" similar to user mode RSTP
|   2. Set IP address on bridge device (same as normal)
|   3. Run routing daemon with multiple sockets that use SO_BINDTODEVICE
|      to receive the packets by interface
|   4. Routing daemon would manage bridged interface state (blocking,
forwarding, etc)

I've done 1 (easy, create /sbin/bridge-up) & 4 (using rtnetlink). For IP
address, it seems i'm a beginner in this area (I'm more skilled on
software than routing protocol so far...).

The other point I did is for the bridge to accept a special MAC address
whatever the bridge state is, in order to be able to receive the
equivalent of BPDU.

Now, if my bridge is called br0 and contains eth0 + eth1 for instance,
the routing protocol will add router over br0 right? So, the system can
not know which interface (eth0 or eth1) the routing protocol would like
to us to route packets?

In most case, the next hop router will be reachable through only one
interface only. But let's say 2 adjacent routers are connected through 2
interfaces (like 2 cross over cables between 2 bridges). In this case, I
think, the system might take the wrong decision.

Things are not clear in my mind on this point.

Regards,
Benoit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIpfElOR6EySwP7oIRAqyfAKCbNzoUuQAuZfEV8GrxZRY5xL16cgCeNobJ
t/fpjEOzcp2BtZqyclSNwfo=3D
=3D0PjZ
-----END PGP SIGNATURE-----
