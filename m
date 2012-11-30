Return-Path: <amwang@redhat.com>
Message-ID: <1354287652.19865.10.camel@cr0>
From: Cong Wang <amwang@redhat.com>
Date: Fri, 30 Nov 2012 23:00:52 +0800
In-Reply-To: <20121130112618.GF30697@casper.infradead.org>
References: <1354269514-1863-1-git-send-email-amwang@redhat.com>
	<1354269514-1863-2-git-send-email-amwang@redhat.com>
	<20121130112618.GF30697@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v1 2/2] bridge: export multicast
 database via netlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Thomas Graf <tgraf@suug.ch>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, Jesper Dangaard Brouer <brouer@redhat.com>, Stephen Hemminger <shemminger@vyatta.com>, "David S. Miller" <davem@davemloft.net>

On Fri, 2012-11-30 at 11:26 +0000, Thomas Graf wrote:
> On 11/30/12 at 05:58pm, Cong Wang wrote:
> > +
> > +	nest = nla_nest_start(skb, MDBA_ROUTER);
> > +	if (nest == NULL)
> > +		return -EMSGSIZE;
> > +
> > +	hlist_for_each_entry_rcu(p, n, &br->router_list, rlist) {
> > +		if (p && nla_put_u16(skb, MDBA_BRPORT_NO, p->port_no))
> > +			goto fail;
> > +	}
> 
> port_no 0 is reserved, right?
> 
> We can reduce message size here and make it easier to extend by
> using p->port_no as the attribute id by doing something like this:
> 
> hlist_for_each_entry_rcu(p, n, &br->router_list, rlist)
> 	if (nla_put_flag(skb, p->port_no))
> 		goto fail;
> 
> This will result in an empty attribute body for now and if you ever
> need to include more data you can simply start putting attributes
> insde that empty body and old users will continue to function.


I don't understand this. nla_put_flag() is used to put a flag (only one
bit set) into a netlink message, so why should we use it to put
p->port_no here? And why port_no 0 matters here?

[...]

> > +
> > +	cb->seq = mdb->seq;
> 
> I'm not sure how this is supposed to worl. cb->seq may not change
> throughout the complete dump process or the dump will be interrupted
> and the user is required to restart.
> 
> Each bridge will have its own mdb resulting in a differing seq.
> 

So I should use net->dev_base_seq + mdb->seq ?


All of the rest suggestions are taken by me.

Thanks for your detailed review!

