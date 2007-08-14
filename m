Date: Tue, 14 Aug 2007 15:18:22 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
Message-ID: <20070814131822.GA13676@xi.wantstofly.org>
References: <46BCE380.60508@cluded.net>
	<20070812012037.0195b610.akpm@linux-foundation.org>
	<20070814141105.0a4b8dde@oldman.hamilton.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070814141105.0a4b8dde@oldman.hamilton.local>
Subject: [Bridge] Re: BUG: when using 'brctl stp'
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, bridge@linux-foundation.org

On Tue, Aug 14, 2007 at 02:11:05PM +0100, Stephen Hemminger wrote:

> Bridge locking for /sys/class/net/br0/bridge/stp_enabled
> was wrong.  Another bug in bridge utilities makes it such that
> this interface, meant it wasn't being used.  The locking needs
> to be removed from set_stp_state(), the lock is already acquired
> down in br_stp_start()/br_stp_stop.

The 'locking' in set_stp_state() is actually dropping the lock
around the br_stp_set_enabled() invocation, not acquiring it:


> @@ -150,9 +150,7 @@ static ssize_t show_stp_state(struct dev
>  static void set_stp_state(struct net_bridge *br, unsigned long val)
>  {
>  	rtnl_lock();
> -	spin_unlock_bh(&br->lock);
>  	br_stp_set_enabled(br, val);
> -	spin_lock_bh(&br->lock);
>  	rtnl_unlock();
>  }
