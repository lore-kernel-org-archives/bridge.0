Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F93C40256
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F5DA401B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFtX7f56EAJ2GK79rUwPSBrE9QN6y3cP519VS14ZrEE=;
 b=jvmq3wPXLTB7VaUGnhFdDN2JZyVrcfAUyW8BSIgkQyzSsqjhK74Wg3ztndfjTXAF59NaECuTgneE+NsdK7J7pN5yfERY+hffTkV5bEwloVeXcP7/we6VX/9N9aJA/8h1q3R1gYg3zvA081Uo9uOnH0GZECwgKqFOokx3r2K0iSjvTTU3KKIijekleTd1wir1t6XPdNP6Z8hHFZJ1Hc4pbEqsT109uffZaMRZFLjll/wQ2OUVNa61ZN2vm3wuZAkbXEpoY45FIJTiPbm/5txfbQAVBL1EK7YFtaUtLxqKGO6VXva6TLCbWqqjykgxmm3Rh6vrcQw7o4XMEzldVzJORw==
Date: Sun, 21 Aug 2022 10:08:04 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YwHZ1J9DZW00aJDU@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
 <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
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

On Fri, Aug 19, 2022 at 11:51:11AM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-14 16:55, Ido Schimmel wrote:
> > On Fri, Aug 12, 2022 at 02:29:48PM +0200, netdev@kapio-technology.com
> > wrote:
> > > On 2022-08-11 13:28, Ido Schimmel wrote:
> > > 
> > > > > > I'm talking about roaming, not forwarding. Let's say you have a locked
> > > > > > entry with MAC X pointing to port Y. Now you get a packet with SMAC X
> > > > > > from port Z which is unlocked. Will the FDB entry roam to port Z? I
> > > > > > think it should, but at least in current implementation it seems that
> > > > > > the "locked" flag will not be reset and having locked entries pointing
> > > > > > to an unlocked port looks like a bug.
> 
> I have made the locked entries sticky in the bridge, so that they don't move
> to other ports.

Please make sure that this design choice is explained in the commit
message. To be clear, it cannot be "this is how device X happens to
work".

> 
> > > > > >
> > > > >
> > > 
> > > In general I have been thinking that the said setup is a network
> > > configuration error as I was arguing in an earlier conversation with
> > > Vladimir. In this setup we must remember that SMAC X becomes DMAC X
> > > in the
> > > return traffic on the open port. But the question arises to me why
> > > MAC X
> > > would be behind the locked port without getting authed while being
> > > behind an
> > > open port too?
> > > In a real life setup, I don't think you would want random hosts
> > > behind a
> > > locked port in the MAB case, but only the hosts you will let
> > > through. Other
> > > hosts should be regarded as intruders.
> > > 
> > > If we are talking about a station move, then the locked entry will
> > > age out
> > > and MAC X will function normally on the open port after the timeout,
> > > which
> > > was a case that was taken up in earlier discussions.
> > > 
> > > But I will anyhow do some testing with this 'edge case' (of being
> > > behind
> > > both a locked and an unlocked port) if I may call it so, and see to
> > > that the
> > > offloaded and non-offloaded cases correspond to each other, and will
> > > work
> > > satisfactory.
> > 
> > It would be best to implement these as additional test cases in the
> > current selftest. Then you can easily test with both veth pairs and
> > loopbacks and see that the hardware and software data paths behave the
> > same.
> > 
> 
> How many loops would be needed to have a selftest with a HUB and a MAC on
> both a locked and an unlocked port?

I assume you want a hub to simulate multiple MACs behind the same port.
You don't need a hub for that. You can set the MAC using mausezahn. See
'-a' option:

"
   -a <src-mac|keyword>
       Use specified source MAC address with hexadecimal notation such as 00:00:aa:bb:cc:dd.  By default the interface MAC address will be used. The  keywords  ''rand''
       and  ''own''  refer to a random MAC address (only unicast addresses are created) and the own address, respectively. You can also use the keywords mentioned below
       although broadcast-type source addresses are officially invalid.
"

> 
> > > 
> > > I think it will be good to have a flag to enable the mac-auth/MAB
> > > feature,
> > > and I suggest just calling the flag 'mab', as it is short.
> 
> I have now created the flag to enable Mac-Auth/MAB with iproute2:
> bridge link set dev DEV macauth on|off

You have 'macauth' here, but 'mab' in the output below. They need to
match. I prefer the latter unless you have a good reason to use
'macauth'.

> 
> with the example output from 'bridge -d link show dev DEV' when macauth is
> enabled:
> 1: ethX: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state
> forwarding priority 32 cost 19
>     hairpin off guard off root_block off fastleave off learning on flood off
> mcast_flood on bcast_flood on mcast_router 1 mcast_to_unicast off
> neigh_suppress off vlan_tunnel off isolated off locked mab on
> 
> The flag itself in the code is called BR_PORT_MACAUTH.
> 
> > 
> > Fine by me, but I'm not sure everyone agrees.
