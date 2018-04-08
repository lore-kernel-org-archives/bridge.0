Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=WWW3gviP2dkExZ2K5vc2selmPy/gcf1H09UbvYpi+tY=;
	b=V6aY0s6hqmPwb7edLSt3LCFHDCnWBuGONzziLibyUeagyaMdp/YKFtms8FmSEWwDpt
	E3PpRF92qQHOMPduOWjepOToDatFAFkxML/EAW2SOKBZM4bpXFDbu1rRcnIg6WyuFxeV
	XI/boL429G9teUmzSvy3qJTXl1pVMfYYjhr2k=
References: <20180408174934.GA3895@laszlth>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <3db78abd-bc13-528f-9da3-cb9a0ce0f617@cumulusnetworks.com>
Date: Mon, 9 Apr 2018 01:25:41 +0300
MIME-Version: 1.0
In-Reply-To: <20180408174934.GA3895@laszlth>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: add missing NULL checks
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Laszlo Toth <laszlth@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 08/04/18 20:49, Laszlo Toth wrote:
> br_port_get_rtnl() can return NULL
> 
> Signed-off-by: Laszlo Toth <laszlth@gmail.com>
> ---
>   net/bridge/br_netlink.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 

Nacked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
More below.

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 015f465c..cbec11f 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -939,14 +939,17 @@ static int br_port_slave_changelink(struct net_device *brdev,
>   				    struct nlattr *data[],
>   				    struct netlink_ext_ack *extack)
>   {
> +	struct net_bridge_port *port = br_port_get_rtnl(dev);
>   	struct net_bridge *br = netdev_priv(brdev);
>   	int ret;
>   
>   	if (!data)
>   		return 0;
> +	if (!port)
> +		return -EINVAL;
>   

If we're here, it means the master device of dev is a bridge => dev is a bridge port,
since we're running with RTNL that cannot change, so this check is unnecessary.

Have you actually hit a bug with this code ?

>   	spin_lock_bh(&br->lock);
> -	ret = br_setport(br_port_get_rtnl(dev), data);
> +	ret = br_setport(port, data);
>   	spin_unlock_bh(&br->lock);
>   
>   	return ret;
> @@ -956,7 +959,12 @@ static int br_port_fill_slave_info(struct sk_buff *skb,
>   				   const struct net_device *brdev,
>   				   const struct net_device *dev)
>   {
> -	return br_port_fill_attrs(skb, br_port_get_rtnl(dev));
> +	struct net_bridge_port *port = br_port_get_rtnl(dev);
> +
> +	if (!port)
> +		return -EINVAL;
> +
> +	return br_port_fill_attrs(skb, port);

Same rationale here, fill_slave_info is called via a master device's ops
under RTNL, which means dev is a bridge port and that also cannot change.

If you have hit a bug with this code, can we see the trace ?
The problem might be elsewhere.

Thanks,
  Nik

>   }
>   
>   static size_t br_port_get_slave_size(const struct net_device *brdev,
> 

