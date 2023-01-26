Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8D4E60E44
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D467960E24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CASC8qHfi6FSsKB7UllTORAfQ+O2NNzwp78HdWbLEwg=;
 b=EnSfpGW2O17/2EGNuqfi0V1fIaK2mHROkGaBzNPIIZ3N06ToM4KKvlJMDAZ8Ermmw6
 ++8WOhuiffljKnWiysqe639ZQwgq8EKSH5K2eH+psEOQBp1Ib0Jq4vxhr4vylFekvF/y
 Fbf5K1gHu+DlnWzh5nugZNqNgE9KvBJXKU2M4JQn0/SKREWTCg+NLF07C/sngK2gLSLN
 4KPk//inZsPdUK2qc2jLxs6X/lHPhiOW+093tRMntXEqJ3GZQSXbZ1ZwmDEMtC5+aYsC
 31vm/4FBXQEJBPivt4Yd9j8j0ZH9BJMD1qkmCOE5nvaw3ci7g6oc/Qw6T8xLB8fpqGln
 2pcg==
Date: Fri, 27 Jan 2023 00:32:13 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230126223213.riq6i2gdztwuinwi@skbuf>
References: <2919eb55e2e9b92265a3ba600afc8137a901ae5f.1674760340.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2919eb55e2e9b92265a3ba600afc8137a901ae5f.1674760340.git.leon@kernel.org>
Subject: Re: [Bridge] [PATCH net-next] netlink: provide an ability to set
 default extack message
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leon Romanovsky <leon@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Leon Romanovsky <leonro@nvidia.com>, "David S . Miller" <davem@davemloft.net>

On Thu, Jan 26, 2023 at 09:15:03PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> In netdev common pattern, xxtack pointer is forwarded to the drivers
                            ~~~~~~
                            extack

> to be filled with error message. However, the caller can easily
> overwrite the filled message.
> 
> Instead of adding multiple "if (!extack->_msg)" checks before any
> NL_SET_ERR_MSG() call, which appears after call to the driver, let's
> add this check to common code.
> 
> [1] https://lore.kernel.org/all/Y9Irgrgf3uxOjwUm@unreal
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---

I would somewhat prefer not doing this, and instead introducing a new
NL_SET_ERR_MSG_WEAK() of sorts.

The reason has to do with the fact that an extack is sometimes also
used to convey warnings rather than hard errors, for example right here
in net/dsa/slave.c:

	if (err == -EOPNOTSUPP) {
		if (extack && !extack->_msg)
			NL_SET_ERR_MSG_MOD(extack,
					   "Offloading not supported");
		NL_SET_ERR_MSG_MOD(extack,
				   "Offloading not supported");
		err = 0;
	}

Imagine (not the case here) that below such a "warning extack" lies
something like this:

	if (arg > range) {
		NL_SET_ERR_MSG_MOD(extack, "Argument outside expected range");
		return -ERANGE;
	}

What you'll get is:

Error: Offloading not supported (error code -ERANGE).

whereas before, we relied on any NL_SET_ERR_MSG_MOD() call to overwrite
the "warning" extack, and that to only be shown on error code 0.

Also, if we make this change this way, there's no going back (just like
there's no going back from kfree(NULL), rtnl_lock() and others).
