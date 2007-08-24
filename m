Message-ID: <46CE943F.9000308@meiosys.com>
Date: Fri, 24 Aug 2007 10:18:07 +0200
From: Daniel Lezcano <dlezcano@meiosys.com>
MIME-Version: 1.0
References: <46BCE380.60508@cluded.net>
	<20070812012037.0195b610.akpm@linux-foundation.org>
	<20070814141105.0a4b8dde@oldman.hamilton.local>
	<20070814131822.GA13676@xi.wantstofly.org>
	<20070814145052.2d135d2f@oldman.hamilton.local>
In-Reply-To: <20070814145052.2d135d2f@oldman.hamilton.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Lennert Buytenhek <buytenh@wantstofly.org>, bridge@linux-foundation.org

Stephen Hemminger wrote:
> Forget earlier patch, it is wrong...
> 
> The stp change code generates "sleeping function called from invalid context"
> because rtnl_lock() called with BH disabled. This fixes it by not acquiring then
> dropping the bridge lock.
> 
> Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>
> 
> --- a/net/bridge/br_sysfs_br.c	2007-08-06 09:26:48.000000000 +0100
> +++ b/net/bridge/br_sysfs_br.c	2007-08-14 14:29:52.000000000 +0100
> @@ -147,20 +147,26 @@ static ssize_t show_stp_state(struct dev
>  	return sprintf(buf, "%d\n", br->stp_enabled);
>  }
> 
> -static void set_stp_state(struct net_bridge *br, unsigned long val)
> -{
> -	rtnl_lock();
> -	spin_unlock_bh(&br->lock);
> -	br_stp_set_enabled(br, val);
> -	spin_lock_bh(&br->lock);
> -	rtnl_unlock();
> -}
> 
>  static ssize_t store_stp_state(struct device *d,
>  			       struct device_attribute *attr, const char *buf,
>  			       size_t len)
>  {
> -	return store_bridge_parm(d, buf, len, set_stp_state);
> +	struct net_bridge *br = to_bridge(d);
> +	char *endp;
> +	unsigned long val;
> +
> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;
> +
> +	val = simple_strtoul(buf, &endp, 0);
> +	if (endp == buf)
> +		return -EINVAL;
> +
> +	rtnl_lock();
> +	br_stp_set_enabled(br, val);
> +	rtnl_unlock();
> +

Shouldn't len value be returned at the end of the function ?

>  }
>  static DEVICE_ATTR(stp_state, S_IRUGO | S_IWUSR, show_stp_state,
>  		   store_stp_state);
> -

