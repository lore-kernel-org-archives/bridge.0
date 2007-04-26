Date: Wed, 25 Apr 2007 22:08:59 -0700 (PDT)
Message-Id: <20070425.220859.56861479.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070425234950.847694502@linux-foundation.org>
References: <20070425234737.727790594@linux-foundation.org>
	<20070425234950.847694502@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH 4/4] bridge: missing rtnl
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
Date: Wed, 25 Apr 2007 16:47:41 -0700

> Writing to /sys/class/net/brX/bridge/stp_state causes a warning because
> RTNL is not held when call br_stp_if.c
> 
> Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

Applied, thanks Stephen.
