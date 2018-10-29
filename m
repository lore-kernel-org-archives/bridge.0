Return-Path: <davem@davemloft.net>
Date: Sun, 28 Oct 2018 19:18:41 -0700 (PDT)
Message-Id: <20181028.191841.1871716142000939243.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181027090747.22104-1-nikolay@cumulusnetworks.com>
References: <90c5f2fe-1743-6b17-2e44-eba58cdbbb35@cumulusnetworks.com>
	<20181027090747.22104-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: remove ipv6 zero address
 check in mcast queries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, yinxu@redhat.com, liuhangbin@gmail.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat, 27 Oct 2018 12:07:47 +0300

> Recently a check was added which prevents marking of routers with zero
> source address, but for IPv6 that cannot happen as the relevant RFCs
> actually forbid such packets:
> RFC 2710 (MLDv1):
> "To be valid, the Query message MUST
>  come from a link-local IPv6 Source Address, be at least 24 octets
>  long, and have a correct MLD checksum."
> 
> Same goes for RFC 3810.
> 
> And also it can be seen as a requirement in ipv6_mc_check_mld_query()
> which is used by the bridge to validate the message before processing
> it. Thus any queries with :: source address won't be processed anyway.
> So just remove the check for zero IPv6 source address from the query
> processing function.
> 
> Fixes: 5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied.
