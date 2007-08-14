Date: Tue, 14 Aug 2007 13:21:45 -0700 (PDT)
Message-Id: <20070814.132145.36923740.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070814145052.2d135d2f@oldman.hamilton.local>
References: <20070814141105.0a4b8dde@oldman.hamilton.local>
	<20070814131822.GA13676@xi.wantstofly.org>
	<20070814145052.2d135d2f@oldman.hamilton.local>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] bridge: sysfs locking fix.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: netdev@vger.kernel.org, akpm@linux-foundation.org, bridge@linux-foundation.org, buytenh@wantstofly.org

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Tue, 14 Aug 2007 14:50:52 +0100

> Forget earlier patch, it is wrong...
> 
> The stp change code generates "sleeping function called from invalid context"
> because rtnl_lock() called with BH disabled. This fixes it by not acquiring then
> dropping the bridge lock.
> 
> Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

Applied, thanks Stephen.
