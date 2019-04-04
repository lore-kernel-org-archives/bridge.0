Return-Path: <davem@davemloft.net>
Date: Thu, 04 Apr 2019 10:50:26 -0700 (PDT)
Message-Id: <20190404.105026.1392007748486231745.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190404115638.28592-1-pablo@netfilter.org>
References: <20190404115638.28592-1-pablo@netfilter.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: update multicast stats
 from maybe_deliver()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: pablo@netfilter.org
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, nbd@nbd.name

From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Thu,  4 Apr 2019 13:56:38 +0200

> Simplify this code by updating bridge multicast stats from
> maybe_deliver().
> 
> Note that commit 6db6f0eae605 ("bridge: multicast to unicast"), in case
> the port flag BR_MULTICAST_TO_UNICAST is set, never updates the previous
> port pointer, therefore it is always going to be different from the
> existing port in this deduplicated list iteration.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Applied.
