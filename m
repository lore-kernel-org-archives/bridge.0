Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=I8mmJvRg7W4veTXIGZziV631NmsLBu2FyDbjZDRt0fE=;
	b=rybNtOwm1eqNY1QFcG73F+KMHqcE5HSOgLNaa39X11LjgoE8OFQsXSfWMI8ENgWl11
	XzmNJPmLchVzYxiOrvB1AH5Dmofd1yklIyZETgil1V3CzgSfWEy//ZBKU1xkWvTYRHze
	U2xhGf+lqfNFj+L5erYSrx8YTDtP0HLGVz1kOZzz7Adj0uJzsYHIYd9X7MOH0Asq+iTT
	6t3dWqTKSV96y6EA6zKuEcVe6CjnF23z6ooElvQOGALC/cMHesUAbgfKV33iomu2Fls1
	zLVxnNiLWfrlkfMHjNJLieB1OjNJxktzXGfCnE1xXyhZN4ZJndGY9Fj/fWpnwNIzC4Lq
	9XLw==
Date: Fri, 20 Jul 2018 08:57:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180720085725.6dc1743d@xeon-e3>
In-Reply-To: <20180720144826.29892-2-nikolay@cumulusnetworks.com>
References: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
	<20180720144826.29892-2-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: add support for raw
 sysfs port options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

On Fri, 20 Jul 2018 17:48:25 +0300
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> This patch adds a new alternative store callback for port sysfs options
> which takes a raw value (buf) and can use it directly. It is needed for the
> backup port sysfs support since we have to pass the device by its name.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> There are a few checkpatch warnings here because of the old code, I've
> noted them in my todo and will send separate patch for simple_strtoul
> and the function prototypes.
> 
>  net/bridge/br_sysfs_if.c | 49 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index f99c5bf5c906..38c58879423d 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -25,6 +25,15 @@ struct brport_attribute {
>  	struct attribute	attr;
>  	ssize_t (*show)(struct net_bridge_port *, char *);
>  	int (*store)(struct net_bridge_port *, unsigned long);
> +	int (*store_raw)(struct net_bridge_port *, char *);
> +};
> +
> +#define BRPORT_ATTR_RAW(_name, _mode, _show, _store)			\
> +const struct brport_attribute brport_attr_##_name = {			\
> +	.attr		= {.name = __stringify(_name),			\
> +			   .mode = _mode },				\
> +	.show		= _show,					\
> +	.store_raw	= _store,					\
>  };
>  
>  #define BRPORT_ATTR(_name, _mode, _show, _store)		\
> @@ -270,27 +279,37 @@ static ssize_t brport_store(struct kobject *kobj,
>  	struct brport_attribute *brport_attr = to_brport_attr(attr);
>  	struct net_bridge_port *p = to_brport(kobj);
>  	ssize_t ret = -EINVAL;
> -	char *endp;
>  	unsigned long val;
> +	char *endp;
>  
>  	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
>  		return -EPERM;
>  
> -	val = simple_strtoul(buf, &endp, 0);
> -	if (endp != buf) {
> -		if (!rtnl_trylock())
> -			return restart_syscall();
> -		if (p->dev && p->br && brport_attr->store) {
> -			spin_lock_bh(&p->br->lock);
> -			ret = brport_attr->store(p, val);
> -			spin_unlock_bh(&p->br->lock);
> -			if (!ret) {
> -				br_ifinfo_notify(RTM_NEWLINK, NULL, p);
> -				ret = count;
> -			}
> -		}
> -		rtnl_unlock();
> +	if (!rtnl_trylock())
> +		return restart_syscall();
> +
> +	if (!p->dev || !p->br)
> +		goto out_unlock;
> +
> +	if (brport_attr->store_raw) {
> +		spin_lock_bh(&p->br->lock);
> +		ret = brport_attr->store_raw(p, (char *)buf);
> +		spin_unlock_bh(&p->br->lock);
> +	} else if (brport_attr->store) {
> +		val = simple_strtoul(buf, &endp, 0);
> +		if (endp == buf)
> +			goto out_unlock;
> +		spin_lock_bh(&p->br->lock);
> +		ret = brport_attr->store(p, val);
> +		spin_unlock_bh(&p->br->lock);
> +	}
> +	if (!ret) {
> +		br_ifinfo_notify(RTM_NEWLINK, NULL, p);
> +		ret = count;
>  	}
> +out_unlock:
> +	rtnl_unlock();
> +
>  	return ret;
>  }
>  

I see where you are going with this. You want a sysfs attribute where is a string
not a number. This makes sense.

The code might be simpler if you always acquired  the lock. Or maybe
move the locking into the store functions.

Casting away the const on the buf variable is going to cause warnings
and should not be necessary.

You might also want an error case if neither store or store_raw are defined.

