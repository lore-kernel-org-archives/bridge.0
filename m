Return-Path: <joe@perches.com>
Message-ID: <1522521642.11653.19.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Sat, 31 Mar 2018 11:40:42 -0700
In-Reply-To: <20180331182810.or7attmfpjxw4sfm@salvia>
References: <cover.1522479607.git.joe@perches.com>
	<df70bafdca663db034626f4f1525826ea263bf2c.1522479607.git.joe@perches.com>
	<20180331182810.or7attmfpjxw4sfm@salvia>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 04/12] bridge: netfilter: Use the new global
 ether_<foo>_addr arrays
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S.
	Miller" <davem@davemloft.net>

On Sat, 2018-03-31 at 20:28 +0200, Pablo Neira Ayuso wrote:
> Hi Joe,

Hi Pablo.

> On Sat, Mar 31, 2018 at 12:05:19AM -0700, Joe Perches wrote:
> > Remove the local consts and use the new globals.
> 
> This one is already upstream:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git/commit/?id=9124a20d8794663a396b5d6f91f66903848a042b
> 
> I can see you're using is_broadcast_ether_addr(e->destmsk) in this new
> version, we would need an incremental version.

No worries.  I did it against next-20180329
and that other commit wasn't there.

