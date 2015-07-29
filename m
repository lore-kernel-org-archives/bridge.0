Return-Path: <davem@davemloft.net>
Date: Wed, 29 Jul 2015 14:57:40 -0700 (PDT)
Message-Id: <20150729.145740.1642510215945079225.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1438079308-25040-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1438079308-25040-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: mcast: give fast leave precedence
 over multicast router and querier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, herbert@gondor.apana.org.au

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 28 Jul 2015 03:28:27 -0700

> From: Satish Ashok <sashok@cumulusnetworks.com>
> 
> When fast leave is configured on a bridge port and an IGMP leave is
> received for a group, the group is not deleted immediately if there is
> a router detected or if multicast querier is configured.
> Ideally the group should be deleted immediately when fast leave is
> configured.
> 
> Signed-off-by: Satish Ashok <sashok@cumulusnetworks.com>

Applied, thanks.
