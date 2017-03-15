Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 15 Mar 2017 22:16:19 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170315211619.GA3464@otheros>
References: <20170315031811.22714-1-linus.luessing@c0d3.blue>
	<20170315102608.GB24366@breakpoint.cc>
	<20170315104211.GA24409@salvia> <20170315142720.GU15692@otheros>
	<20170315181539.GA31875@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315181539.GA31875@salvia>
Subject: Re: [Bridge] [PATCH net] bridge: ebtables: fix reception of frames
 DNAT-ed to bridge device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S . Miller" <davem@davemloft.net>

On Wed, Mar 15, 2017 at 07:15:39PM +0100, Pablo Neira Ayuso wrote:
> Could you update ebtables dnat to check if the ethernet address
> matches the one of the input bridge interface, so we mangle the
> ->pkt_type accordingly from there, instead of doing this from the
> core?

Actually, that was the approach I thought about and went for first
(and it would probably work for me). Just checking against the
bridge device's net_device::dev_addr.

I scratched it though, as I was afraid that the issue might still
exist for people using some other upper device on top of the bridge
device. For instance, macvlan? And iterating over the
net_device::dev_addrs list seemed too costly for fast path to me.
