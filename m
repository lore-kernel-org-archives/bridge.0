Date: Wed, 25 Apr 2007 22:05:17 -0700 (PDT)
Message-Id: <20070425.220517.62667709.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070425234950.610323798@linux-foundation.org>
References: <20070425234737.727790594@linux-foundation.org>
	<20070425234950.610323798@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH 1/4] bridge: don't change packet type
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Wed, 25 Apr 2007 16:47:38 -0700

> The change to forward STP bpdu's (for usermode STP) through normal path,
> changed the packet type in the process. Since link local stuff is multicast, it
> should stay pkt_type = PACKET_MULTICAST.  The code was probably copy/pasted
> incorrectly from the bridge pseudo-device receive path.
> 
> Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

Applied.

