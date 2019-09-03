Return-Path: <fw@strlen.de>
Date: Tue, 3 Sep 2019 21:48:09 +0200
From: Florian Westphal <fw@strlen.de>
Message-ID: <20190903194809.GD13660@breakpoint.cc>
References: <20190830181354.26279-1-leonardo@linux.ibm.com>
	<20190830181354.26279-2-leonardo@linux.ibm.com>
	<20190830205802.GS20113@breakpoint.cc>
	<99e3ef9c5ead1c95df697d49ab9cc83a95b0ac7c.camel@linux.ibm.com>
	<20190903164948.kuvtpy7viqhcmp77@salvia>
	<20190903170550.GA13660@breakpoint.cc>
	<20190903193155.v74ws47zcn6zrwpr@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903193155.v74ws47zcn6zrwpr@salvia>
Subject: Re: [Bridge] [PATCH v4 1/2] netfilter: Terminate rule eval if
 protocol=IPv6 and ipv6 module is disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Leonardo Bras <leonardo@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > I was expecting we could find a way to handle this from br_netfilter
> > > alone itself.
> > 
> > We can't because we support ipv6 fib lookups from the netdev family
> > as well.
> > 
> > Alternative is to auto-accept ipv6 packets from the nf_tables eval loop,
> > but I think its worse.
> 
> Could we add a restriction for nf_tables + br_netfilter + !ipv6. I
> mean, if this is an IPv6 packet, nf_tables is on and IPv6 module if
> off, then drop this packet?

We could do that from nft_do_chain_netdev().
