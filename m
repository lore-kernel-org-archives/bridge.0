Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MQUkWK
 w9RCDKfqU9d+QuZkH1t07x/WW5tw+ukNqYQ5A=; b=toVyAOSn7fm87WscwoiYas
 bKbnXw10S1R+2Ar8fKvdRsYuRrQv3vJu23MEiHEKJifJFIrTxwn1AZYB632d7LKw
 nihJhDpGxl/MQyzejdc5CjJyPzw8uHQQEESNw8ImtUXiU3GwA+2o48lHo91E8tPg
 eP0rb+SRGSPzkj0qAr1+SxxhyVBhXnGYwZyRUgBavi2YyjrAPubJLlmCYJi2VCtW
 hERMUnmArPMtoV0xA5dNuFqDc+xbUiyf5oKFcXX7jnb5FQqm2j+aOPe4tmKy0dH5
 sJoefOoNqjcuHJ7avqTzZBxoaYhXrBLKPT7xnZ8DSKs1h5eMDozvz28k/c7458eQ
 ==
Date: Sun, 2 May 2021 18:04:54 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YI6/li9hwHo8GfCm@shredder>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-5-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426170411.1789186-5-tobias@waldekranz.com>
Subject: Re: [Bridge] [RFC net-next 4/9] net: bridge: switchdev: Forward
	offloading
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, olteanv@gmail.com, davem@davemloft.net

On Mon, Apr 26, 2021 at 07:04:06PM +0200, Tobias Waldekranz wrote:
> +static void nbp_switchdev_fwd_offload_add(struct net_bridge_port *p)
> +{
> +	void *priv;
> +
> +	if (!(p->dev->features & NETIF_F_HW_L2FW_DOFFLOAD))
> +		return;
> +
> +	priv = p->dev->netdev_ops->ndo_dfwd_add_station(p->dev, p->br->dev);

Some changes to team/bond/8021q will be needed in order to get this
optimization to work when they are enslaved to the bridge instead of the
front panel port itself?

> +	if (!IS_ERR_OR_NULL(priv))
> +		p->accel_priv = priv;
> +}
> +
> +static void nbp_switchdev_fwd_offload_del(struct net_bridge_port *p)
> +{
> +	if (!p->accel_priv)
> +		return;
> +
> +	p->dev->netdev_ops->ndo_dfwd_del_station(p->dev, p->accel_priv);
> +	p->accel_priv = NULL;
> +}
