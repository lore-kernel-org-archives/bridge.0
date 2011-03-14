Date: Mon, 14 Mar 2011 15:07:08 -0700 (PDT)
Message-Id: <20110314.150708.116369703.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110310075704.47f91bd5@nehalam>
References: <20110310075704.47f91bd5@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: skip forwarding delay if not using STP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@vyatta.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Thu, 10 Mar 2011 07:57:04 -0800

> If Spanning Tree Protocol is not enabled, there is no good reason for
> the bridge code to wait for the forwarding delay period before enabling
> the link. The purpose of the forwarding delay is to allow STP to
> learn about other bridges before nominating itself.
> 
> The only possible impact is that when starting up a new port
> the bridge may flood a packet now, where previously it might have
> seen traffic from the other host and preseeded the forwarding table.
> 
> Includes change for local variable br already available in that func.
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

Applied to net-2.6, thanks.
