Return-Path: <fw@strlen.de>
From: Florian Westphal <fw@strlen.de>
Message-ID: <20140428131646.GP31953@breakpoint.cc>
References: <534FB7D2.3020705@parallels.com> <53535C35.7070108@parallels.com>
	<20140424163243.GN31953@breakpoint.cc>
	<535E4B74.4050107@parallels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <535E4B74.4050107@parallels.com>
Subject: Re: [Bridge] [PATCH 1/1] superfluous skb->nfct check in
	br_nf_dev_queue_xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 28 Apr 2014 13:16:55 -0000
To: Vasily Averin <vvs@parallels.com>
Cc: bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, Patrick McHardy <kaber@trash.net>, Stephen Hemminger <stephen@networkplumber.org>, netfilter-devel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Vasily Averin <vvs@parallels.com> wrote:
> We got report about problem on RHEL6-based OpenVZ kernel:
> large UDP and ICMP packets was dropped on bridge without incrementing of any failcounters.
> Connection tracking was disabled on this node , nf_conntrack module was unloaded
> Ftrace pointed that it was happen because nfct check.

Right.  If you unload the conntrack module this bug triggers
since nf_defrag_ipv4 will still defragment ipv4 packets (and
thus needs refragmentation).

> Therefore I believe that my patch is still correct, however now I think we also need 
> to remove #if IS_ENABLED(CONFIG_NF_CONNTRACK_IPV4) in br_nf_dev_queue_xmit().

I don't think so, DEFRAG_IPV4 is dependency glue, so it shouldn't be
possible to build kernel with CONNTRACK_IPV4=n and DEFRAG_IPV4=(m|y).

Could you please formally submit your patch for inclusion in nf.git?
For some reason I don't see your patch in
http://patchwork.ozlabs.org/project/netfilter-devel/list/

Thanks!
