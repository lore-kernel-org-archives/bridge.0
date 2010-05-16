Date: Sat, 15 May 2010 23:12:03 -0700 (PDT)
Message-Id: <20100515.231203.55877701.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100510193320.775633381@vyatta.com>
References: <20100510193107.722574297@vyatta.com>
	<20100510193320.775633381@vyatta.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/4] bridge: netpoll cleanup
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
Date: Mon, 10 May 2010 12:31:08 -0700

> Move code around so that the ifdef for NETPOLL_CONTROLLER don't have to
> show up in main code path. The control functions should be in helpers
> that are only compiled if needed.
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

Applied.
