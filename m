Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 8 Dec 2017 06:46:06 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20171208054606.GE2391@otheros>
References: <20171125074418.16537-1-linus.luessing@c0d3.blue>
	<20171127233008.GA1418@salvia> <20171204045335.GE3307@otheros>
	<20171207002619.GB28145@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171207002619.GB28145@salvia>
Subject: Re: [Bridge] [PATCH net-next] bridge: ebtables: Avoid resetting
 limit rule state
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

On Thu, Dec 07, 2017 at 01:26:19AM +0100, Pablo Neira Ayuso wrote:
> > I also had a quick look at a 4.15-rc1 kernel in a VM now. I still
> > end up in ebt_limit_mt_check() with the variables being reset
> > when editing the table somewhere.
> 
> My question is if your fix would work with 4.15-rc1.

You are absoluetly right, it's not working anymore since the
commit you mentioned initially :-(
("xtables: extend matches and targets with .usersize").
info->prev is always 0 since exactly this commit.

That means, trying tricks in ebt_limit_mt_check() is too
late now, the old values are already overwritten? (or is there
some commit scheme which installs the ebt_limit_info provided
by ebt_limit_check() some time after its call?)

Extending the usersize to include info->prev would probably be too
hackish/ugly, right?
