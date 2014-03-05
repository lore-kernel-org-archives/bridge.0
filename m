Return-Path: <jstancek@redhat.com>
Date: Wed, 5 Mar 2014 07:10:07 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <521731164.13535687.1394021407825.JavaMail.zimbra@redhat.com>
In-Reply-To: <20140304213757.GJ5090@Linus-Debian>
References: <1566805413.12693479.1393872931017.JavaMail.zimbra@redhat.com>
	<20140303212759.GW5090@Linus-Debian>
	<1808019554.12748658.1393886749190.JavaMail.zimbra@redhat.com>
	<20140304000041.GY5090@Linus-Debian>
	<624414844.12834668.1393920156458.JavaMail.zimbra@redhat.com>
	<20140304105253.GC5090@Linus-Debian>
	<1663332249.12962360.1393931189285.JavaMail.zimbra@redhat.com>
	<20140304213757.GJ5090@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] bridge is not forwaring ICMP6 neighbor solicitation to
 KVM guest
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Cc: netdev@vger.kernel.org, Florian Westphal <fwestpha@redhat.com>, bridge@lists.linux-foundation.org



----- Original Message -----
> From: "Linus L=C3=BCssing" <linus.luessing@web.de>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: netdev@vger.kernel.org, "Florian Westphal" <fwestpha@redhat.com>, bri=
dge@lists.linux-foundation.org
> Sent: Tuesday, 4 March, 2014 10:37:57 PM
> Subject: Re: bridge is not forwaring ICMP6 neighbor solicitation to KVM g=
uest
> > I'm not sure if it's Linux (I'm trying to locate that system by MAC), b=
ut I
> > see
> > packets like these on my network every ~125 seconds:
> >=20
> > No.     Time        Source                Destination           Protoco=
l
> > Length Info
> >   22675 1334.751135 ::                    ff02::1               ICMPv6 =
  86
> >   Multicast Listener Query
>=20
> It's probably the bridge on this ancient kernel, you might want to
> backport the following patch:

Hi,

The example above was from box, which turned out not be running Linux.

>=20
> If these patches on host B xor the sanity check I just submitted applied
> on your host A / VM host fix your issue, then they might be worth
> considering for the stable queue.

Is it necessary to apply same patch also on any (older) kernel running in V=
M?

I applied your sanity check patch [1] on host A only and I wasn't able to r=
eproduce
this issue any longer when I sent this malformed packet from host B:
  Ethernet II, Src: Hewlett-_47:93:1c (00:21:5a:47:93:1c), Dst: IPv6mcast_0=
0:00:00:01 (33:33:00:00:00:01)
  Internet Protocol Version 6, Src: 100:0:600:0:78fb:100:: (100:0:600:0:78f=
b:100::), Dst: ff02::1 (ff02::1)
  Internet Control Message Protocol v6


I hand-crafted one new packet from malformed one used in previous tests.
I modified source address from :: to host B link-scope address and changed
dst address from ff02::1 to ff02::1:ffaa:aaaa

Ethernet II, Src: Hewlett-_47:93:1c (00:21:5a:47:93:1c), Dst: IPv6mcast_00:=
00:00:01 (33:33:00:00:00:01)
Internet Protocol Version 6, Src: fe80::221:5aff:fe47:931c (fe80::221:5aff:=
fe47:931c), Dst: ff02::1:ffaa:aaaa (ff02::1:ffaa:aaaa)
Internet Control Message Protocol v6
    Type: Multicast Listener Query (130)
    Code: 0
    Checksum: 0xe365 [correct]
    Maximum Response Delay [ms]: 1000
    Reserved: 0000
    Multicast Address: :: (::)

When I sent it from host B, guest on host A hit same issue - it stopped see=
ing
neighbor solicitation packets. host A was running 3.14.0-rc5 kernel with
patch [1] applied.

Then I updated kernel on guest to 3.14.0-rc5 + patch [1], but result was th=
e same.
Here is trace from guest: http://jan.stancek.eu/tmp/neigh_solicit_and_bridg=
e_traces2/
host B was sending neigh solicit every 5 seconds:
  frame 134, 135 -> OK
  frame 216, 217 -> OK
  frame 329, 330 -> OK
  frame 432, 433 -> OK
  frame 459 -> new hand-crafted packet
  after 35 second mark, guest doesn't see any longer neigh solicit packets

Regards,
Jan

[1] bridge: multicast: add sanity check for query source addresses
