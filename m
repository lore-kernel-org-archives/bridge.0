Return-Path: <leon@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F07A68264A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 213CA8261C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674797177;
 bh=7cCRW7ZE/dmS2yOLiVK26bi2n3cjM6ODKzo2Y3b/bSA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bSt9/0WoMT+bwdv0Z3z0dHWpEGJV2zcDmAVH2hUHsHcAnrFkLb1dfmXQtmCVU6K/b
 9SDa24o05vD4LofEN4xFK/lv7nQ8e5ld126hWJTajsqO/spGjZ4FDZZFn5XS7ThHtr
 mVh1Jeb9pJrOjDPw2rAKH2p1m5cEqI2hnKSdDFnq3zhhKwBHKhEgvEGAAQ3lAAUQLH
 7V5b4QGHkHOiDYx0zNnay+skEfdarYyA7uxvbGIl4VaubixRBTXjAowQFXdIMF0+2m
 sP8fn4t76BAvlDvh42LpURmfj0UginFuzKNUrvkezreHb1AWWnwOWoS0NsYjSPIHtB
 Dg7VrY0WvquwA==
Date: Fri, 27 Jan 2023 07:26:13 +0200
From: Leon Romanovsky <leon@kernel.org>
Message-ID: <Y9NgdXk3NLtjG3Mj@unreal>
References: <2919eb55e2e9b92265a3ba600afc8137a901ae5f.1674760340.git.leon@kernel.org>
 <20230126223213.riq6i2gdztwuinwi@skbuf>
 <20230126143723.7593ce0b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126143723.7593ce0b@kernel.org>
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
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>

On Thu, Jan 26, 2023 at 02:37:23PM -0800, Jakub Kicinski wrote:
> On Fri, 27 Jan 2023 00:32:13 +0200 Vladimir Oltean wrote:
> > On Thu, Jan 26, 2023 at 09:15:03PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > In netdev common pattern, xxtack pointer is forwarded to the drivers  
> >                             ~~~~~~
> >                             extack
> > 
> > > to be filled with error message. However, the caller can easily
> > > overwrite the filled message.
> > > 
> > > Instead of adding multiple "if (!extack->_msg)" checks before any
> > > NL_SET_ERR_MSG() call, which appears after call to the driver, let's
> > > add this check to common code.
> > > 
> > > [1] https://lore.kernel.org/all/Y9Irgrgf3uxOjwUm@unreal
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---  
> > 
> > I would somewhat prefer not doing this, and instead introducing a new
> > NL_SET_ERR_MSG_WEAK() of sorts.
> 
> That'd be my preference too, FWIW. It's only the offload cases which
> need this sort of fallback.

Of course not, almost any error unwind path which sets extack will need it.
See devlink as an example, but I'm confident that same issue exists in other
places too.

You are suggesting API which is very easy to do wrong.

So I prefer to stay with my proposal if it is possible.

Thanks
