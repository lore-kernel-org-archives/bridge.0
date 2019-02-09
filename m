Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=R2CFd4nT6s5U7WPDk/xbX2i/XkxjBZlNWJin67NFxFA=;
	b=HHajEVXOHW8tgLlm8sM6zc4xvBkSpBkbNS5QojxFUlnMwIZ46QKPPPK++Om6xSGL7c
	zijf9nI6QbvJD9vE42Q0PgrKHN9cRW9HpAXiHWli0k8OOBYZ8MxDAf3h/IQFuLD/5NRy
	1dVafTXgJCjhMbuhD4XTpzwRedjP+Z2oYe5VSxuz0T7tfeqSzxUQtt6WZzCIvsxhFPHK
	x192NlonVNCKSmbsBlCzniRIirJ5+0HjReHJYrX5JCo2vqfJUKH6e4r6mLq31ynvqQQ0
	YHSmv4O9NnF+dkyUMlpScV7oWhrluEKqXm7UO6CHDwcuxOJFbvh4VVtBHaDs5GZo+PFG
	+z1w==
References: <20190209003248.31088-1-f.fainelli@gmail.com>
	<20190209003248.31088-16-f.fainelli@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <83d8f16f-a73d-5aa7-4718-fc45e0fed226@gmail.com>
Date: Fri, 8 Feb 2019 16:36:18 -0800
MIME-Version: 1.0
In-Reply-To: <20190209003248.31088-16-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 15/16] net: switchdev: Replace port
 attr set SDO with a notification
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, vivien.didelot@gmail.com, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>

On 2/8/19 4:32 PM, Florian Fainelli wrote:
> Drop switchdev_ops.switchdev_port_attr_set. Drop the uses of this field
> from all clients, which were migrated to use switchdev notification in
> the previous patches.
> 
> Add a new function switchdev_port_attr_notify() that sends the switchdev
> notifications SWITCHDEV_PORT_ATTR_SET.
> 
> Drop __switchdev_port_attr_set() and update switchdev_port_attr_set()
> likewise.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  include/net/switchdev.h   | 18 --------
>  net/switchdev/switchdev.c | 92 ++++++++++-----------------------------
>  2 files changed, 22 insertions(+), 88 deletions(-)
> 
> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index 4c5f7e5430cf..5387ff6f41c5 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -111,21 +111,6 @@ void *switchdev_trans_item_dequeue(struct switchdev_trans *trans);
>  
>  typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
>  
> -/**
> - * struct switchdev_ops - switchdev operations
> - *
> - * @switchdev_port_attr_get: Get a port attribute (see switchdev_attr).
> - *
> - * @switchdev_port_attr_set: Set a port attribute (see switchdev_attr).
> - */
> -struct switchdev_ops {
> -	int	(*switchdev_port_attr_get)(struct net_device *dev,
> -					   struct switchdev_attr *attr);
> -	int	(*switchdev_port_attr_set)(struct net_device *dev,
> -					   const struct switchdev_attr *attr,
> -					   struct switchdev_trans *trans);
> -};
> -

This and the hunk below bisection, I will move that into patch #16 after
receiving feedback on this.
-- 
Florian
