Return-Path: <fw@strlen.de>
Date: Sat, 31 Aug 2019 10:43:15 +0200
From: Florian Westphal <fw@strlen.de>
Message-ID: <20190831084315.GU20113@breakpoint.cc>
References: <20190830181354.26279-1-leonardo@linux.ibm.com>
	<20190830181354.26279-3-leonardo@linux.ibm.com>
	<20190830205541.GR20113@breakpoint.cc>
	<2ba876f9ad6597e640df68f09659dce3c4b5ce03.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ba876f9ad6597e640df68f09659dce3c4b5ce03.camel@linux.ibm.com>
Subject: Re: [Bridge] [PATCH v4 2/2] net: br_netfiler_hooks: Drops IPv6
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
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

Leonardo Bras <leonardo@linux.ibm.com> wrote:
> > There are two solutions:
> > 1. The above patch, but use NF_ACCEPT instead
> > 2. keep the DROP, but move it below the call_ip6tables test,
> >    so that users can tweak call-ip6tables to accept packets.
> 
> Q: Does 2 mean that it will only be dropped if bridge intents to use
> host's ip6tables? Else, it will be accepted by previous if?

Yes, thats the idea: Let users decide if ipv6.disable or call-ip6tables
is more important to them.
