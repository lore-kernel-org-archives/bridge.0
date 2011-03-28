Date: Sun, 27 Mar 2011 18:34:13 -0700 (PDT)
Message-Id: <20110327.183413.229737801.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110324162401.2f322e3e@nehalam>
References: <20110324162401.2f322e3e@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: notify applications if address of
 bridge device changes
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
Date: Thu, 24 Mar 2011 16:24:01 -0700

> The mac address of the bridge device may be changed when a new interface
> is added to the bridge. If this happens, then the bridge needs to call
> the network notifiers to tickle any other systems that care. Since bridge
> can be a module, this also means exporting the notifier function.
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

Applied, thanks Stephen.
