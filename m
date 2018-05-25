Return-Path: <davem@davemloft.net>
Date: Fri, 25 May 2018 14:46:37 -0400 (EDT)
Message-Id: <20180525.144637.342618599793988571.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180524085648.5934-1-nikolay@cumulusnetworks.com>
References: <20180524085648.5934-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add support for port
	isolation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 24 May 2018 11:56:48 +0300

> This patch adds support for a new port flag - BR_ISOLATED. If it is set
> then isolated ports cannot communicate between each other, but they can
> still communicate with non-isolated ports. The same can be achieved via
> ACLs but they can't scale with large number of ports and also the
> complexity of the rules grows. This feature can be used to achieve
> isolated vlan functionality (similar to pvlan) as well, though currently
> it will be port-wide (for all vlans on the port). The new test in
> should_deliver uses data that is already cache hot and the new boolean
> is used to avoid an additional source port test in should_deliver.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, thanks Nikolay.
