Return-Path: <pablo@netfilter.org>
Date: Mon, 2 Sep 2019 23:20:08 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190902212008.gy4ejl4bj5fhdqfm@salvia>
References: <20190831044032.31931-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831044032.31931-1-leonardo@linux.ibm.com>
Subject: Re: [Bridge] [PATCH v5 1/1] net: br_netfiler_hooks: Drops IPv6
 packets if IPv6 module is not loaded
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

On Sat, Aug 31, 2019 at 01:40:33AM -0300, Leonardo Bras wrote:
> A kernel panic can happen if a host has disabled IPv6 on boot and have to
> process guest packets (coming from a bridge) using it's ip6tables.
> 
> IPv6 packets need to be dropped if the IPv6 module is not loaded, and the
> host ip6tables will be used.

Applied, thanks.
