Return-Path: <linus.luessing@c0d3.blue>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EEFF0608D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B303460759
Date: Wed, 28 Dec 2022 19:04:55 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <Y6yFR2zS/A57Zui2@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Bridge] MLD proxying between bridge ports, recommendations?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I know that there are implementations for IGMP/MLD proxies between
two interfaces to "pseudo bridge" IGMP/MLD and multicast data
(both itnerfaces have distinct broadcast domains and are routing
unicast packets on layer 3, the IGMP/MLD proxy carries IGMP/MLD
and multicast data over). Like the igmpproxy [0] tool, which is
supported in OpenWrt [1]. And maybe mcproxy [2] (I've never tried
this one, but seems to be based on RFC4605 [3]?).

But I've been wondering, are there vendors who have implemented
IGMP/MLD proxying on their bridges/switches between ports? What I
would like to do with the Linux bridge in particular is:

1) Use the built-in MLD querier towards downstream ports with a
fast querier interval (20-30 seconds? to query mobile wifi clients).
2) Have the bridge respond with one aggregated MLDv2 Report towards a
dedicated upstream port, where an external querier would query
with a slower than default interval.
3) Be able to filter/blacklist/whitelist certain IP multicast ranges
from the proxied report. (I'd have the weird use-case of filtering
out link-local IPv6 multicast ranges and only allowing routable
ones).

Other interesting features / use-cases could be to contain
IGMPv2/MLDv1 to specific ports, to keep the rest of the network on
IGMPv3/MLDv2 and to convert report versions between them. Or to
reduce the overhead of redundantly forwarded multicast groups
you'd otherwise currently have with MLDv2 (no report suppression).

Would it make sense to implement such an IGMP/MLD proxying
mechanism in the Linux bridge?

Other than proxying and tuning querier intervals, is anyone aware
of any other mechanisms to reduce MLD overhead in large broadcast
domains? (large would be about 1000 Linux hosts with bridges +
2000 bridged-in, external hosts sharing a broadcast domain)

Regards, Linus

[0]: https://github.com/pali/igmpproxy
[1]: https://openwrt.org/docs/guide-user/network/wan/udp_multicast
[2]: https://github.com/mcproxy/mcproxy
[3]: http://tools.ietf.org/html/rfc4605
