Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D81481819
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E90D8183D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAzUnFYPTTXluzRylKeqzYDi4FW5J5JLhIbJmA72FVM=;
 b=PKXKOeniXiGCQ7nDQR5Q7qIbLbHN//gM4Obk6a4ywa4z2/SvVcP/4RjVI6UofUl/xYkK9BWVmKuDgemgQFwAh7exrj3jBYbC9dusAQPUnXQdAkhOelMCS/4HUrOwJfmQ0HiVgF1HjX18/sB0IaNuqcKmNhy8hT5L7kXfG1rcLir8/Z6L2gRae+Q21QTqEZ2YTbkDGj7sA81nTzG4iGpwSKSbYyy6V0K/VutCzaWAGRjQ5x3blPqajVQSIlRoBQDGWliIaTW5+Lad3proswUFLIRr2bHFcIoBwxCcO78FA47fiq2v5FNKqZ8/j0fgOiKqovTTQH+W7S/az3OTh3OUSg==
Date: Mon, 22 Aug 2022 08:40:50 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YwMW4iGccDu6jpaZ@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
 <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
 <YwHZ1J9DZW00aJDU@shredder>
 <ce4266571b2b47ae8d56bd1f790cb82a@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce4266571b2b47ae8d56bd1f790cb82a@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v4 net-next 3/6] drivers: net: dsa: add locked
 fdb entry flag to drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Sun, Aug 21, 2022 at 03:43:04PM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-21 09:08, Ido Schimmel wrote:
> > On Fri, Aug 19, 2022 at 11:51:11AM +0200, netdev@kapio-technology.com
> > wrote:
> > > On 2022-08-14 16:55, Ido Schimmel wrote:
> > > > On Fri, Aug 12, 2022 at 02:29:48PM +0200, netdev@kapio-technology.com
> > > > wrote:
> > > > > On 2022-08-11 13:28, Ido Schimmel wrote:
> > > > >
> > > > > > > > I'm talking about roaming, not forwarding. Let's say you have a locked
> > > > > > > > entry with MAC X pointing to port Y. Now you get a packet with SMAC X
> > > > > > > > from port Z which is unlocked. Will the FDB entry roam to port Z? I
> > > > > > > > think it should, but at least in current implementation it seems that
> > > > > > > > the "locked" flag will not be reset and having locked entries pointing
> > > > > > > > to an unlocked port looks like a bug.
> > > 
> > > I have made the locked entries sticky in the bridge, so that they
> > > don't move
> > > to other ports.
> > 
> > Please make sure that this design choice is explained in the commit
> > message. To be clear, it cannot be "this is how device X happens to
> > work".
> > 
> 
> The real issue I think is that the locked entry should mask the MAC address
> involved (as the description I gave for zero-DPV entries and actually also
> storm prevention entries ensure), so that there is no forwarding to the
> address on any port, otherwise it will allow one-way traffic to a host that
> is not trusted. Thus flooding of unknown unicast on a locked port should of
> course be disabled ('flood off'), so that there is no way of sending to an
> unauthorized silent host behind the locked port.
> 
> The issue with the locked entry appearing on another SW bridge port from
> where it originated, I think is more of a cosmetic bug, though I could be
> mistaken. But adding the sticky flag to locked entries ensures that they do
> not move to another port.
> 
> This of course does that instant roaming is not possible, but I think that
> the right approach is to use the ageing out of entries to allow the station
> move/roaming.

I personally think that the mv88e6xxx semantics are very weird (e.g., no
roaming, traffic blackhole) and I don't want them to determine how the
feature works in the pure software bridge or other hardware
implementations. On the other hand, I understand your constraints and I
don't want to create a situation where user space is unable to
understand how the data path works from the bridge FDB dump with
mv88e6xxx.

My suggestion is to have mv88e6xxx report the "locked" entry to the
bridge driver with additional flags that describe its behavior in terms
of roaming, ageing and forwarding.

In terms of roaming, since in mv88e6xxx the entry can't roam you should
report the entry with the "sticky" flag. In terms of ageing, since
mv88e6xxx is the one doing the ageing and not the bridge driver, report
the entry with the "extern_learn" flag. In terms of forwarding, in
mv88e6xxx the entry discards all matching packets. We can introduce a
new FDB flag that instructs the entry to silently discard all matching
packets. Like we have with blackhole routes and nexthops.

I believe that the above suggestion allows you to fully describe how
these entries work in mv88e6xxx while keeping the bridge driver in sync
with complete visibility towards user space.

It also frees the pure software implementation from the constraints of
mv88e6xxx, allowing "locked" entries to behave like any other
dynamically learned entries modulo the fact that they cannot "unlock" a
locked port.

Yes, it does mean that user space will get a bit different behavior with
mv88e6xxx compared to a pure software solution, but a) It's only the
corner cases that act a bit differently. As a whole, the feature works
largely the same. b) User space has complete visibility to understand
the behavior of the offloaded data path.

> 
> The case of unwanted traffic to a MAC behind a locked port with a locked
> entry is what I would regard as more worthy of a selftest. The sticky flag I
> know will ensure that the locked entries do not move to other ports, and
> since it is only in the bridge this can be tested (e.g. using 'bridge fdb
> show dev DEV'), I think that the test would be superfluos. What do you think
> of that and my other consideration for a test?

If we go with the above suggestion, then you can have a
mv88e6xxx-specific selftest that tests the corner cases where mv88e6xxx
acts a bit differently from the pure software bridge.

> 
> 
> > > I have now created the flag to enable Mac-Auth/MAB with iproute2:
> > > bridge link set dev DEV macauth on|off
> > 
> > You have 'macauth' here, but 'mab' in the output below. They need to
> > match. I prefer the latter unless you have a good reason to use
> > 'macauth'.
> > 
> > > 
> > > with the example output from 'bridge -d link show dev DEV' when
> > > macauth is
> > > enabled:
> > > 1: ethX: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state
> > > forwarding priority 32 cost 19
> > >     hairpin off guard off root_block off fastleave off learning on
> > > flood off
> > > mcast_flood on bcast_flood on mcast_router 1 mcast_to_unicast off
> > > neigh_suppress off vlan_tunnel off isolated off locked mab on
> > > 
> > > The flag itself in the code is called BR_PORT_MACAUTH.
> > > 
> > > >
> > > > Fine by me, but I'm not sure everyone agrees.
> 
> I will change it in iproute2 to:
> bridge link set dev DEV mab on|off

And s/BR_PORT_MACAUTH/BR_PORT_MAB/ ?
