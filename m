Date: Sun, 17 May 2009 21:13:26 -0700 (PDT)
Message-Id: <20090517.211326.88138889.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090515091013.44b624d7@nehalam>
References: <20090515091013.44b624d7@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/2] bridge: relay bridge multicast pkgs if !STP
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
Date: Fri, 15 May 2009 09:10:13 -0700

> Currently the bridge catches all STP packets; even if STP is turned
> off.  This prevents other systems (which do have STP turned on)
> from being able to detect loops in the network.
> 
> With this patch, if STP is off, then any packet sent to the STP
> multicast group address is forwarded to all ports.
> 
> Based on earlier patch by Joakim Tjernlund with changes
> to go through forwarding (not local chain), and optimization
> that only last octet needs to be checked.
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

Applied.
