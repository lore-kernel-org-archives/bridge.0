Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 19 Mar 2017 17:55:06 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170319165506.GA15475@otheros>
References: <20170315031811.22714-1-linus.luessing@c0d3.blue>
	<20170315102608.GB24366@breakpoint.cc>
	<20170315104211.GA24409@salvia> <20170315142720.GU15692@otheros>
	<20170315181539.GA31875@salvia> <20170315211619.GA3464@otheros>
	<20170315220605.GA1766@salvia> <20170317131044.GA11995@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170317131044.GA11995@salvia>
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

On Fri, Mar 17, 2017 at 02:10:44PM +0100, Pablo Neira Ayuso wrote:
> Wait.
> 
> May this break local multicast listener that are bound to the bridge
> interface? Assuming the bridge interface got an IP address, and that
> there is local multicast listener.
> 
> Missing anything here?

Hm, for multicast packets usually the code path a few lines
later in br_handle_frame_finish() should be taken instead.

But you might be right for IP multicast packets with a unicast MAC
destination (due to whatever reason, for instance via DNAT'ing
again).

Will check that - thanks!
