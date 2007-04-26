Date: Wed, 25 Apr 2007 22:07:21 -0700 (PDT)
Message-Id: <20070425.220721.48395982.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070425234950.699578312@linux-foundation.org>
References: <20070425234737.727790594@linux-foundation.org>
	<20070425234950.699578312@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH 2/4] bridge: drop PAUSE frames
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
Date: Wed, 25 Apr 2007 16:47:39 -0700

> Pause frames should never make it out of the network device into
> the stack. But if a device was misconfigured, it might happen.
> So drop pause frames in bridge.
> 
> Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

It can happen when in promiscuous mode, but that's the only
legal case I can think of.

But that case shouldn't be hitting this path I don't think.

So this change is borderline and if anything we should put
an assertion somewhere maybe, but applied for now.

