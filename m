Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-language:content-transfer-encoding;
	bh=i/EdsYI/6NiYceaHfcMvNiTTD3uzstFla8zXlPjSTKw=;
	b=FS5bk0n5MVq5QbnMIqp8WIwU6z9igdzJqyJ4uiWdN7faliVK58wPhwWgPMAZRTwJpb
	5nxU+FpUsVipXMwsK7FzJ8P4a4td7f8BgtXBzAy1cJD+kaSIe8Go5x3lV9DUdCt6jyEz
	5ZlAFwtpWAzD6+PsrEYCH1WcJHGbeMufd/+06TtknIDoWBwnS9zf6ZfCohtFX8zeNCdi
	ltDtydp5arzFKJpweC2fPXIJzLFjONMiQ6tHMIAKyXseyrwNHiA9PFe6g7rgsnMzQOdN
	SH/Ul9hCPhnzTLSisHuR4FFpcOrNUDs3ADSwTXXaCxDW3lmymHYUc+apAZq9OpSEM7ni
	Dfiw==
References: <20170920162140.369bb198@xeon-e3>
	<20170921100525.20395-1-vincent@bernat.im>
From: David Ahern <dsahern@gmail.com>
Message-ID: <0cdf06b9-e67d-c035-e0f1-c4eb143bf631@gmail.com>
Date: Thu, 21 Sep 2017 10:43:35 -0600
MIME-Version: 1.0
In-Reply-To: <20170921100525.20395-1-vincent@bernat.im>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [net-next v3] bridge: trigger RTM_NEWLINK when
 interface is modified by bridge ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vincent Bernat <vincent@bernat.im>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org

On 9/21/17 4:05 AM, Vincent Bernat wrote:
> Currently, there is a difference in netlink events received when an
> interface is modified through bridge ioctl() or through netlink. This
> patch generates additional events when an interface is added to or
> removed from a bridge via ioctl().
> 
> When adding then removing an interface from a bridge with netlink, we
> get:
> 
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> Deleted 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 
> When using ioctl():
> 
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> Deleted 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 
> Without this patch, the last netlink notification is not sent.
> 
> Signed-off-by: Vincent Bernat <vincent@bernat.im>
> ---
>  net/bridge/br_ioctl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
> index 7970f8540cbb..66cd98772051 100644
> --- a/net/bridge/br_ioctl.c
> +++ b/net/bridge/br_ioctl.c
> @@ -102,6 +102,9 @@ static int add_del_if(struct net_bridge *br, int ifindex, int isadd)
>  	else
>  		ret = br_del_if(br, dev);
>  
> +	if (!ret)
> +		rtmsg_ifinfo(RTM_NEWLINK, dev, IFF_MASTER, GFP_KERNEL);
> +
>  	return ret;
>  }
>  
> 

Agreed that this is needed for userspace to know about the master change
when done through ioctl. The bridge code is emitting a lot of what
appears to be redundant messages for both paths (netlink and ioctl).

Reviewed-by: David Ahern <dsahern@gmail.com>

