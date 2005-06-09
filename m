From: "Tomo Ceferin" <tomo@activetools.si>
Subject: RE: [Bridge] Multicast
Date: Thu, 9 Jun 2005 16:33:44 +0200
Message-ID: <046c01c56d00$52945e90$825810ac@amon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <42A8058C.2060408@ya.com>
Content-Transfer-Encoding: quoted-printable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

True. However, allow me to make two assumptions (true in our case):
1) Bridge implements set_multicast_list() and uses it to learn multicast
groups.
2) IPv4 or IPv6 is attached to bridge - both provide IGMP snooping which in
turn feeds bridge with multicast lists through set_multicast_list().

With both above assumptions true, bridge now has awareness of which ports
belong to which multicast groups, hence removing the need to flood all port=
s.

Am I getting something wrong?

Tomo

> -----Original Message-----
> From: Guillermo Ib=E1=F1ez
>=20
> Just an explanation to distinguish processing of layer 3 multicast=20
> packets (by routers) from layer 2 multicast frames (by=20
> bridges).  Due to=20
> the fact that the multicast MAC addresses are not permitted in the=20
> Ethernet frame as source addresses, multicast MAC addresses=20
> can not be=20
> learnt by the bridges, so the processing of multicast addresses by=20
> bridges consists in broadcasting, flooding frames in all but source=20
> port, instead of forwarding them only by ports where these addresses=20
> were learnt.
> Excuse me if it sounds a bit "academic".
> GI


