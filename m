Return-Path: <stephen@networkplumber.org>
Date: Tue, 8 Sep 2015 08:52:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20150908085256.0f3f6b00@urahara>
In-Reply-To: <20150908031122.GB1562@odroid>
References: <20150908031122.GB1562@odroid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Roaming trouble with bridge & multicast snooping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org

On Tue, 8 Sep 2015 05:11:22 +0200
Linus L=C3=BCssing <linus.luessing@c0d3.blue> wrote:

> Hi bridge folks,
>=20
> I'm currently stuck with a simple scenario where enabling bridge
> multicast snooping causes packetloss for some time:
>=20
> ----------
>=20
> (c) <~~~> (A) <---> (B)
>=20
> (c) is a wifi client, connected to a wifi access point (A).
> (B) is another AP connected to (A) via ethernet cable.
> The wifi-ap and ethernet interface are bridged on both (A) and (B).
>=20
>=20
> Now (c) roams from (A) to (B):
>=20
>           (A) <---> (B) <~~~> (c)
>=20
> ----------
>=20
> Until the next multicast query is send (up to 125 seconds), (c)
> will experience multicast packet loss: (B) does not know which
> multicast traffic (c) wants yet and blocks forwarding multicast
> traffic to it.
>=20
> I couldn't find an IETF standard or discussion saying something
> about how to deal with multicast snooping and roaming yet (I still
> have the feeling I must have overlooked something as this scenario
> seems common to me). Does anyone know anything about that or how
> vendors implement that on their snooping switches?
>=20
>=20
> The behaviour of (c) running a 3.16 kernel is:
> After setting its wifi interface up, it stays quiet. After getting
> a link / wifi connects, it sends an IGMP/MLD report first, without
> waiting for a query. It then sends the IPv6 Neighbor Solicitation
> messages for Duplicate Address Detection to be able to claim its
> own IPv6 addresses.
>=20
> However it does not resend reports / Neighbor Solicitations after
> the link goes down and up again while the interface itself stays up.
>=20
>=20
> I could think of two ways to solve the issue:
>=20
> Either let mac80211 (hostapd?) notify the bridge once a new client
> connects. Then let the bridge send a query to the client
> immediately and directly.
>=20
> Or once the bridge adds an fdb entry for a new host, send a query
> to this host (no matter if it's wireless or not) immediately,
> directly.
>=20
>=20
> The "directly" could be implemented by setting the ethernet
> destination to the according unicast MAC instead.
>=20
>=20
> Even though slightly more latency, I'd opt (and would going to
> provide a patch) for the second case.
>=20
>=20
> What do others think about this?

The only entity in this scenario that knows that it has changed
state is (c). Why doesn't the client resend a IGMP when it notes
a connection change?

