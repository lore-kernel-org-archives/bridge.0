Return-Path: <pablo@netfilter.org>
Date: Thu, 29 Jul 2021 09:24:20 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20210729072420.GA16265@salvia>
References: <20210728161849.GA10433@salvia>
 <20210726035702.11964-1-yajun.deng@linux.dev>
 <eaeec889b3a07cea1347d48269e5964e@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eaeec889b3a07cea1347d48269e5964e@linux.dev>
Subject: Re: [Bridge] [PATCH] netfilter: nf_conntrack_bridge: Fix not free
	when error
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: yajun.deng@linux.dev
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, kadlec@netfilter.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Thu, Jul 29, 2021 at 03:19:01AM +0000, yajun.deng@linux.dev wrote:
> July 29, 2021 12:18 AM, "Pablo Neira Ayuso" <pablo@netfilter.org> wrote:
> 
> > On Mon, Jul 26, 2021 at 11:57:02AM +0800, Yajun Deng wrote:
> > 
> >> It should be added kfree_skb_list() when err is not equal to zero
> >> in nf_br_ip_fragment().
> >> 
> >> Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
> >> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >> ---
> >> net/bridge/netfilter/nf_conntrack_bridge.c | 12 ++++++++----
> >> 1 file changed, 8 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c
> >> b/net/bridge/netfilter/nf_conntrack_bridge.c
> >> index 8d033a75a766..059f53903eda 100644
> >> --- a/net/bridge/netfilter/nf_conntrack_bridge.c
> >> +++ b/net/bridge/netfilter/nf_conntrack_bridge.c
> >> @@ -83,12 +83,16 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
> >> 
> >> skb->tstamp = tstamp;
> >> err = output(net, sk, data, skb);
> >> - if (err || !iter.frag)
> >> - break;
> >> -
> >> + if (err) {
> >> + kfree_skb_list(iter.frag);
> >> + return err;
> >> + }
> >> +
> >> + if (!iter.frag)
> >> + return 0;
> >> +
> >> skb = ip_fraglist_next(&iter);
> >> }
> >> - return err;
> > 
> > Why removing this line above? It enters slow_path: on success.
> > 
> I used return rather than break, it wouldn't enter the slow_path.

Right, your patch is correct.

> > This patch instead will keep this aligned with IPv6.
> > 
> I think err and !iter.frag are not related, there is no need to put
> them in an if statement, We still need to separate them after loop.
> So I separate them in loop and use return instead of break. In
> addition, if you insist, I will accept your patch.

Thanks. Yes, I'd prefer to keep it consistent with existing users of
the fragment iterator, see:

net/ipv4/ip_output.c
net/ipv6/netfilter.c
net/ipv6/ip6_output.c

they are roughly using the same programming idiom to iterate over the
fragments.

Would you send a v2?
