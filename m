Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=t47wrFTAgDWtc0HC3Ew0hJe0vdM5rX6Xwnmpm8cZSe4=;
	b=OUT0MNw3TNhwmJTo/bys/XU+q/orzMqEtN4rzCr7KoYtehqhJ2m94LojT+EuehPQRb
	YPYMdN/f5x5Gb5Fay2IbBAWFKgo6vF+DOeDphvgXgUt4Vt7JNAT0gMNHVxc3+OkYWNsR
	bgZtV8lC4nRqIoGQiiSZVyxgQjzwty6XCj4vQ=
References: <20180225195906.26399-1-idosch@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <8b00288e-221a-e229-e955-6724651d52b1@cumulusnetworks.com>
Date: Sun, 25 Feb 2018 22:57:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180225195906.26399-1-idosch@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: Fix VLAN reference count problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@mellanox.com, davem@davemloft.net, elena.reshetova@intel.com

On 25/02/18 21:59, Ido Schimmel wrote:
> When a VLAN is added on a port, a reference is taken on the
> corresponding master VLAN entry. If it does not already exist, then it
> is created and a reference taken.
> 
> However, in the second case a reference is not really taken when
> CONFIG_REFCOUNT_FULL is enabled as refcount_inc() is replaced by
> refcount_inc_not_zero().
> 
> Fix this by using refcount_set() on a newly created master VLAN entry.
> 
> Fixes: 251277598596 ("net, bridge: convert net_bridge_vlan.refcnt from atomic_t to refcount_t")
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> ---
>  net/bridge/br_vlan.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 51935270c651..9896f4975353 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -168,6 +168,8 @@ static struct net_bridge_vlan *br_vlan_get_master(struct net_bridge *br, u16 vid
>  		masterv = br_vlan_find(vg, vid);
>  		if (WARN_ON(!masterv))
>  			return NULL;
> +		refcount_set(&masterv->refcnt, 1);
> +		return masterv;
>  	}
>  	refcount_inc(&masterv->refcnt);
>  
> 

Good catch,

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
