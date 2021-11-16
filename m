Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0IUKmHTdJTD6tF74F4ZaLQhVJlM0wzuFjSzEBs8JlE=;
 b=hDsMiV5PY9dXuHL9fM5HOrfQweVzv+jGI3xdCFJAh1k1p7mLljMTtfIrrWm3IeE8/TsOmoJDurzpXJ8aQioRi81zk5IcqGglKz958mX7W1wX6N+Zaqr3uWtVR8FczeuidOHvP+6zFmNEKzosCGNDpbrgQ8UO+NX0bHNzXoylR9U=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 16 Nov 2021 10:21:39 +0000
Message-ID: <20211116102138.26vkpeh23el6akya@skbuf>
References: <871r3gbdxv.fsf@kurt>
In-Reply-To: <871r3gbdxv.fsf@kurt>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <03C64940AC7E854299C37FF37FDD6646@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] RFC: PTP Boundary Clock over UDPv4/UDPv6 on Linux
	bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>

On Tue, Nov 16, 2021 at 11:19:24AM +0100, Kurt Kanzenbach wrote:
> Hi all,
>=20
> I'm currently trying to setup a PTP Boundary Clock over UDPv4 or UDPv6
> on top of a switch using a Linux bridge. It works fine using PTP Layer 2
> transport, but not for UDP. I'm wondering whether this is supported
> using Linux or if I'm doing something wrong.
>=20
> My setup looks like this:
>=20
> Bridge (DSA):
>=20
> |$ ip link set eth0 up
> |$ ip link set lan0 up
> |$ ip link set lan1 up
> |$ ip link add name br0 type bridge
> |$ ip link set dev lan0 master br0
> |$ ip link set dev lan1 master br0
> |$ ip link set br0 up
> |$ dhclient br0
>=20
> PTP:
>=20
> |$ ptp4l -4 -i lan0 -i lan1 --tx_timestamp_timeout=3D40 -m
>=20
> It seems like ptp4l cannot receive any PTP messages. Tx works fine.
>=20
> The following hack solves the problem for me. However, I'm not sure
> whether that's the correct approach or not. Any opinions, ideas,
> comments?
>=20
> Thanks,
> Kurt
>=20
> |From 2e8b429b3ebabda8e81693b9704dbe5e5205ab09 Mon Sep 17 00:00:00 2001
> |From: Kurt Kanzenbach <kurt@linutronix.de>
> |Date: Wed, 4 Aug 2021 09:33:12 +0200
> |Subject: [PATCH] net: bridge: input: Handle PTP over UDPv4 and UDPv6
> |
> |PTP is considered management traffic. A time aware switch should interce=
pt all
> |PTP messages and handle them accordingly. The corresponding Linux setup =
is like
> |this:
> |
> |         +-- br0 --+
> |        / /   |     \
> |       / /    |      \
> |      /  |    |     / \
> |     /   |    |    /   \
> |   swp0 swp1 swp2 swp3 swp4
> |
> |ptp4l runs on all individual switch ports and needs full control over se=
nding
> |and receiving messages on these ports.
> |
> |However, the bridge code treats PTP messages over UDP transport as regul=
ar IP
> |messages and forwards them to br0. This way, the running ptp4l instances=
 cannot
> |receive these frames on the individual switch port interfaces.
> |
> |Fix it by intercepting PTP UDP traffic in the bridge code and pass them =
to the
> |regular network processing.
> |
> |Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> |---
> | net/bridge/br_input.c | 13 +++++++++++++
> | 1 file changed, 13 insertions(+)
> |
> |diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> |index b50382f957c1..4e12be70a003 100644
> |--- a/net/bridge/br_input.c
> |+++ b/net/bridge/br_input.c
> |@@ -271,6 +271,13 @@ static int br_process_frame_type(struct net_bridge_=
port *p,
> | 	return 0;
> | }
> |=20
> |+static const unsigned char ptp_ip_destinations[][ETH_ALEN] =3D {
> |+	{ 0x01, 0x00, 0x5e, 0x00, 0x01, 0x81 }, /* IPv4 PTP */
> |+	{ 0x01, 0x00, 0x5e, 0x00, 0x00, 0x6b }, /* IPv4 P2P */
> |+	{ 0x33, 0x33, 0x00, 0x00, 0x01, 0x81 }, /* IPv6 PTP */
> |+	{ 0x33, 0x33, 0x00, 0x00, 0x00, 0x6b }, /* IPv6 P2P */
> |+};
> |+
> | /*
> |  * Return NULL if skb is handled
> |  * note: already called with rcu_read_lock
> |@@ -280,6 +287,7 @@ static rx_handler_result_t br_handle_frame(struct sk=
_buff **pskb)
> | 	struct net_bridge_port *p;
> | 	struct sk_buff *skb =3D *pskb;
> | 	const unsigned char *dest =3D eth_hdr(skb)->h_dest;
> |+	int i;
> |=20
> | 	if (unlikely(skb->pkt_type =3D=3D PACKET_LOOPBACK))
> | 		return RX_HANDLER_PASS;
> |@@ -360,6 +368,11 @@ static rx_handler_result_t br_handle_frame(struct s=
k_buff **pskb)
> | 	if (unlikely(br_process_frame_type(p, skb)))
> | 		return RX_HANDLER_PASS;
> |=20
> |+	/* Check for PTP over UDPv4 or UDPv6. */
> |+	for (i =3D 0; i < ARRAY_SIZE(ptp_ip_destinations); ++i)
> |+		if (ether_addr_equal(ptp_ip_destinations[i], dest))
> |+			return RX_HANDLER_PASS;
> |+
> | forward:
> | 	switch (p->state) {
> | 	case BR_STATE_FORWARDING:
> |--=20
> |2.30.2
>

This should do the trick as well?

/sbin/ebtables --table broute --append BROUTING --protocol 0x88F7 --jump DR=
OP

/sbin/ebtables --table broute --append BROUTING --protocol 0x0800 --ip-prot=
ocol udp --ip-destination-port 320 --jump DROP
/sbin/ebtables --table broute --append BROUTING --protocol 0x0800 --ip-prot=
ocol udp --ip-destination-port 319 --jump DROP

/sbin/ebtables --table broute --append BROUTING --protocol 0x86DD --ip6-pro=
tocol udp --ip6-destination-port 320 --jump DROP
/sbin/ebtables --table broute --append BROUTING --protocol 0x86DD --ip6-pro=
tocol udp --ip6-destination-port 319 --jump DROP=
