Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 8 Sep 2015 05:11:22 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150908031122.GB1562@odroid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Bridge] Roaming trouble with bridge & multicast snooping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org

Hi bridge folks,

I'm currently stuck with a simple scenario where enabling bridge
multicast snooping causes packetloss for some time:

----------

(c) <~~~> (A) <---> (B)

(c) is a wifi client, connected to a wifi access point (A).
(B) is another AP connected to (A) via ethernet cable.
The wifi-ap and ethernet interface are bridged on both (A) and (B).


Now (c) roams from (A) to (B):

          (A) <---> (B) <~~~> (c)

----------

Until the next multicast query is send (up to 125 seconds), (c)
will experience multicast packet loss: (B) does not know which
multicast traffic (c) wants yet and blocks forwarding multicast
traffic to it.

I couldn't find an IETF standard or discussion saying something
about how to deal with multicast snooping and roaming yet (I still
have the feeling I must have overlooked something as this scenario
seems common to me). Does anyone know anything about that or how
vendors implement that on their snooping switches?


The behaviour of (c) running a 3.16 kernel is:
After setting its wifi interface up, it stays quiet. After getting
a link / wifi connects, it sends an IGMP/MLD report first, without
waiting for a query. It then sends the IPv6 Neighbor Solicitation
messages for Duplicate Address Detection to be able to claim its
own IPv6 addresses.

However it does not resend reports / Neighbor Solicitations after
the link goes down and up again while the interface itself stays up.


I could think of two ways to solve the issue:

Either let mac80211 (hostapd?) notify the bridge once a new client
connects. Then let the bridge send a query to the client
immediately and directly.

Or once the bridge adds an fdb entry for a new host, send a query
to this host (no matter if it's wireless or not) immediately,
directly.


The "directly" could be implemented by setting the ethernet
destination to the according unicast MAC instead.


Even though slightly more latency, I'd opt (and would going to
provide a patch) for the second case.


What do others think about this?

Cheers, Linus
