Date: Sun, 17 May 2009 21:13:48 -0700 (PDT)
Message-Id: <20090517.211348.115670295.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090515091158.55090cd0@nehalam>
References: <20090515091013.44b624d7@nehalam> <20090515091158.55090cd0@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 2/2] bridge: fix initial packet flood if !STP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@vyatta.com
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Fri, 15 May 2009 09:11:58 -0700

> If bridge is configured with no STP and forwarding delay of 0 (which
> is typical for virtualization) then when link starts it will flood all
> packets for the first 20 seconds. 
> 
> This bug was introduced by a combination of earlier changes:
>   * forwarding database uses hold time of zero to indicate 
>     user wants to always flood packets
>   * optimzation of the case of forwarding delay of 0 avoids the initial
>     timer tick
> 
> The fix is to just skip all the topology change detection code if
> kernel STP is not being used.
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

Also applied, thanks Stephen.

To avoid confusion, I did apply these to net-2.6 since they
are fixes.

Thanks!
