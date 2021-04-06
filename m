Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 6 Apr 2021 22:49:44 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20210406204944.GH2742@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Bridge] IPv4/IPv6 separation in bridge code for multicast routers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi,

I wanted to add the remaining pieces for batman-adv to support
IPv4 multicast groups in bridged setups, next to the IPv6 support
already in place. For which we'd need MRD support. So once more
I'd tap into the bridge for this information from batman-adv.

Then I realized again that the bridge keeps track of the
IGMP/MLD querier per protocol family but not for the multicast
router ports. For the latter we only have one list right now. For
batman-adv we have the multicast router flags and logic already
separate though.

I started separating the router list for IPv4 and IPv6 in the
bridge, but it seems there are already external users for the
protocol family unaware router list right now: netlink and switchdev.
Now I'm wondering:

A) For netlink:

Would it be fine to just add a MDBA_ROUTER_PATTR_FAMILY with
either the value PF_INET or PF_INET6? The downside would be that
a userspace application which does not know this new attribute
yet would potentially see or list a duplicate.

Another option would be to add two separate attributes:
MDBA_ROUTER_PATTR_{INET,INET6}. Which looks a bit more clumsy and
and inflexible to me. But would have a better compatiblity when
userspace requests a router ports dump. For events there'd still
be the same issue of duplicates though, as IPv4 and IPv6 routers
might appear or disappear asynchronously.

B) For switchdev:

I'm not that familiar with switchdev. Should it generally be
possible to separate the protocol family here? Or would it be
better to add a few more lines to the bridge code to
only call switchdev_port_attr_set() when transitioning between
v4-rtr, v6-rtr: (off, off) <=> (on, on) | (on, off) | (off, on)?
At least for a start, maybe?

C)

Or am I missing something in the MRD RFC (RFC4286) which implies
that a Multicast router Advertisement should be interpreted
across protocol families?


Any ideas what might be the best way to tackle this?

Regards, Linus
