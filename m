Return-Path: <rdunlap@infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209;
	h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=moytDVJRpqZLFmEX64+WfUMnVcERhOMjomuChmO7lxc=;
	b=XD56jdDwX+Inu8rB3G1N5zk49E
	XJnX0YzQgw4E6iKClYcElReJu1AMLFmApFvQNha2eFprA/9fKhl+BgEdptbMGGzTEkul2x3IMHdS+
	hlYDvZRga4hd5US5ICL7dPTFoQybayP3cJl/wqoDvT5Q8qAu/0u1QswzwjVpgMEz9jnfTis4V9GMN
	2Fu4mDZAu0pUbemPuthoelkwT0sGbEyDmBI3spwnJUjNUoNliNwkMypkVuZa6gYf8ysAfjoMlpAgd
	ZsX+soTto2xPjuAXbh6shydvYD9thMaEu4IrpX/QvNpaH/iKTuTFmpEawFC+ukrTelghE7JP/YXZz
	mPd04WAw==;
References: <20171219181053.86320-1-andriy.shevchenko@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <978985b0-1580-ab62-1dc6-127dac4a1620@infradead.org>
Date: Tue, 19 Dec 2017 11:21:55 -0800
MIME-Version: 1.0
In-Reply-To: <20171219181053.86320-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v1] bridge: Use helpers to handle MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org

On 12/19/2017 10:10 AM, Andy Shevchenko wrote:
> Use
> 	%pM to print MAC
> 	mac_pton() to convert it from ASCII to binary format, and
> 	ether_addr_copy() to copy.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(same)
	select GENERIC_NET_UTILS
?

> ---
>  net/bridge/br_sysfs_br.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index 723f25eed8ea..b1be0dcfba6b 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -272,10 +272,7 @@ static ssize_t group_addr_show(struct device *d,
>  			       struct device_attribute *attr, char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%x:%x:%x:%x:%x:%x\n",
> -		       br->group_addr[0], br->group_addr[1],
> -		       br->group_addr[2], br->group_addr[3],
> -		       br->group_addr[4], br->group_addr[5]);
> +	return sprintf(buf, "%pM\n", br->group_addr);
>  }
>  
>  static ssize_t group_addr_store(struct device *d,
> @@ -284,14 +281,11 @@ static ssize_t group_addr_store(struct device *d,
>  {
>  	struct net_bridge *br = to_bridge(d);
>  	u8 new_addr[6];
> -	int i;
>  
>  	if (!ns_capable(dev_net(br->dev)->user_ns, CAP_NET_ADMIN))
>  		return -EPERM;
>  
> -	if (sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
> -		   &new_addr[0], &new_addr[1], &new_addr[2],
> -		   &new_addr[3], &new_addr[4], &new_addr[5]) != 6)
> +	if (!mac_pton(buf, new_addr))
>  		return -EINVAL;
>  
>  	if (!is_link_local_ether_addr(new_addr))
> @@ -306,8 +300,7 @@ static ssize_t group_addr_store(struct device *d,
>  		return restart_syscall();
>  
>  	spin_lock_bh(&br->lock);
> -	for (i = 0; i < 6; i++)
> -		br->group_addr[i] = new_addr[i];
> +	ether_addr_copy(br->group_addr, new_addr);
>  	spin_unlock_bh(&br->lock);
>  
>  	br->group_addr_set = true;
> 


-- 
~Randy
