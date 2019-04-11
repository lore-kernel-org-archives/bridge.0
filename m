Return-Path: <davem@davemloft.net>
Date: Thu, 11 Apr 2019 11:16:53 -0700 (PDT)
Message-Id: <20190411.111653.1887675087098656430.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190411120825.31221-1-nikolay@cumulusnetworks.com>
References: <20190411120825.31221-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: multicast: use rcu to access
 port list from br_multicast_start_querier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, herbert@gondor.apana.org.au

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 11 Apr 2019 15:08:25 +0300

> br_multicast_start_querier() walks over the port list but it can be
> called from a timer with only multicast_lock held which doesn't protect
> the port list, so use RCU to walk over it.
> 
> Fixes: c83b8fab06fc ("bridge: Restart queries when last querier expires")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied and queued up for -stable, thanks.
