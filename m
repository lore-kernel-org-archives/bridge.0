Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 52536403C4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C451400BB
MIME-Version: 1.0
Date: Sun, 21 Aug 2022 15:43:04 +0200
From: netdev@kapio-technology.com
In-Reply-To: <YwHZ1J9DZW00aJDU@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
 <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
 <YwHZ1J9DZW00aJDU@shredder>
Message-ID: <ce4266571b2b47ae8d56bd1f790cb82a@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 2022-08-21 09:08, Ido Schimmel wrote:
> On Fri, Aug 19, 2022 at 11:51:11AM +0200, netdev@kapio-technology.com 
> wrote:
>> On 2022-08-14 16:55, Ido Schimmel wrote:
>> > On Fri, Aug 12, 2022 at 02:29:48PM +0200, netdev@kapio-technology.com
>> > wrote:
>> > > On 2022-08-11 13:28, Ido Schimmel wrote:
>> > >
>> > > > > > I'm talking about roaming, not forwarding. Let's say you have a locked
>> > > > > > entry with MAC X pointing to port Y. Now you get a packet with SMAC X
>> > > > > > from port Z which is unlocked. Will the FDB entry roam to port Z? I
>> > > > > > think it should, but at least in current implementation it seems that
>> > > > > > the "locked" flag will not be reset and having locked entries pointing
>> > > > > > to an unlocked port looks like a bug.
>> 
>> I have made the locked entries sticky in the bridge, so that they 
>> don't move
>> to other ports.
> 
> Please make sure that this design choice is explained in the commit
> message. To be clear, it cannot be "this is how device X happens to
> work".
> 

The real issue I think is that the locked entry should mask the MAC 
address involved (as the description I gave for zero-DPV entries and 
actually also storm prevention entries ensure), so that there is no 
forwarding to the address on any port, otherwise it will allow one-way 
traffic to a host that is not trusted. Thus flooding of unknown unicast 
on a locked port should of course be disabled ('flood off'), so that 
there is no way of sending to an unauthorized silent host behind the 
locked port.

The issue with the locked entry appearing on another SW bridge port from 
where it originated, I think is more of a cosmetic bug, though I could 
be mistaken. But adding the sticky flag to locked entries ensures that 
they do not move to another port.

This of course does that instant roaming is not possible, but I think 
that the right approach is to use the ageing out of entries to allow the 
station move/roaming.

The case of unwanted traffic to a MAC behind a locked port with a locked 
entry is what I would regard as more worthy of a selftest. The sticky 
flag I know will ensure that the locked entries do not move to other 
ports, and since it is only in the bridge this can be tested (e.g. using 
'bridge fdb show dev DEV'), I think that the test would be superfluos. 
What do you think of that and my other consideration for a test?


>> I have now created the flag to enable Mac-Auth/MAB with iproute2:
>> bridge link set dev DEV macauth on|off
> 
> You have 'macauth' here, but 'mab' in the output below. They need to
> match. I prefer the latter unless you have a good reason to use
> 'macauth'.
> 
>> 
>> with the example output from 'bridge -d link show dev DEV' when 
>> macauth is
>> enabled:
>> 1: ethX: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state
>> forwarding priority 32 cost 19
>>     hairpin off guard off root_block off fastleave off learning on 
>> flood off
>> mcast_flood on bcast_flood on mcast_router 1 mcast_to_unicast off
>> neigh_suppress off vlan_tunnel off isolated off locked mab on
>> 
>> The flag itself in the code is called BR_PORT_MACAUTH.
>> 
>> >
>> > Fine by me, but I'm not sure everyone agrees.

I will change it in iproute2 to:
bridge link set dev DEV mab on|off
