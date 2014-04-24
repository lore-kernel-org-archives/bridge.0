Return-Path: <fw@strlen.de>
From: Florian Westphal <fw@strlen.de>
Message-ID: <20140424163243.GN31953@breakpoint.cc>
References: <534FB7D2.3020705@parallels.com> <53535C35.7070108@parallels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53535C35.7070108@parallels.com>
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
Date: Thu, 24 Apr 2014 17:05:36 -0000
To: Vasily Averin <vvs@parallels.com>
Cc: bridge@lists.linux-foundation.org, Patrick McHardy <kaber@trash.net>, Stephen Hemminger <stephen@networkplumber.org>, netfilter-devel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Vasily Averin <vvs@parallels.com> wrote:
> Please do not apply my patch, probably it breaks processing of VLAN packets.

Why would it break VLAN?
In fact, the same dicussion came up couple of days back and I think the
nfct test is wrong.  There is no guarantee that skb->nfct == NULL means
that packet was not defragmented via nf_defrag (e.g. rror in l4 protocol
tracker, nf_defrag_ipv4 loaded but no nf_conntrack_ipv4)

For ipv6 its even worse since we toss all ipv6 defragmented packets...
