Return-Path: <pablo@netfilter.org>
Date: Tue, 3 Sep 2019 22:55:34 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190903205534.bxcty7pja5bvru5f@salvia>
References: <20190830181354.26279-1-leonardo@linux.ibm.com>
	<20190830181354.26279-2-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830181354.26279-2-leonardo@linux.ibm.com>
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
To: Leonardo Bras <leonardo@linux.ibm.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Fri, Aug 30, 2019 at 03:13:53PM -0300, Leonardo Bras wrote:
> If IPv6 is disabled on boot (ipv6.disable=1), but nft_fib_inet ends up
> dealing with a IPv6 packet, it causes a kernel panic in
> fib6_node_lookup_1(), crashing in bad_page_fault.
> 
> The panic is caused by trying to deference a very low address (0x38
> in ppc64le), due to ipv6.fib6_main_tbl = NULL.
> BUG: Kernel NULL pointer dereference at 0x00000038
> 
> The kernel panic was reproduced in a host that disabled IPv6 on boot and
> have to process guest packets (coming from a bridge) using it's ip6tables.
> 
> Terminate rule evaluation when packet protocol is IPv6 but the ipv6 module
> is not loaded.

Patch is applied, thanks.
