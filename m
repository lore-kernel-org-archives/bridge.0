Return-Path: <leon@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 659924176E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 361C6402F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674796950;
 bh=m2iagu5CoxQcuS9/5fRga1nwz/j2ClImu0ojZzZlsAA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u32G2mL+UTO8LhM9W2FwjlI1fdq+nDqO2EosoWBfnLNRlSjQIE9TpMqueVejLyFOY
 IQQmfvLU1druPVdO9xVfrOwbsE8Qi0jGaLJeOQCJ1ApNYwrc0ZrlrHTldn41SDIcof
 o54CTb765BJoZqi1liaozfGIIT8yhn1bsnUWdksGbML/y287YPddaqsVuT5vxVLjJc
 e9q42tNc260SY627J8h84Szkqtn+2ufbpU1VIMufaKq/0E/gFDkrSAeDp7lVxNQ3Q9
 GBoTAxAu5mcPtvar2u++uA3gPj9NM4/klmAXjIZKOJzwSIHnF2RY4/VDW2EMpR3iNB
 HY6YKPR5sP5GQ==
Date: Fri, 27 Jan 2023 07:22:26 +0200
From: Leon Romanovsky <leon@kernel.org>
Message-ID: <Y9NfkgRbWAbrxQ1G@unreal>
References: <2919eb55e2e9b92265a3ba600afc8137a901ae5f.1674760340.git.leon@kernel.org>
 <20230126223213.riq6i2gdztwuinwi@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126223213.riq6i2gdztwuinwi@skbuf>
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>

On Fri, Jan 27, 2023 at 12:32:13AM +0200, Vladimir Oltean wrote:
> On Thu, Jan 26, 2023 at 09:15:03PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > In netdev common pattern, xxtack pointer is forwarded to the drivers
>                             ~~~~~~
>                             extack
> 
> > to be filled with error message. However, the caller can easily
> > overwrite the filled message.
> > 
> > Instead of adding multiple "if (!extack->_msg)" checks before any
> > NL_SET_ERR_MSG() call, which appears after call to the driver, let's
> > add this check to common code.
> > 
> > [1] https://lore.kernel.org/all/Y9Irgrgf3uxOjwUm@unreal
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> 
> I would somewhat prefer not doing this, and instead introducing a new
> NL_SET_ERR_MSG_WEAK() of sorts.

It means changing ALL error unwind places where extack was forwarded
before to subfunctions.

Places like this:
 ret = func(..., extack)
 if (ret) {
   NL_SET_ERR_MSG_MOD...
   return ret;
 }

will need to be changed to something like this:
 ret = func(..., extack)
 if (ret) {
   NL_SET_ERR_MSG_WEAK...
   return ret;
 }

> 
> The reason has to do with the fact that an extack is sometimes also
> used to convey warnings rather than hard errors, for example right here
> in net/dsa/slave.c:
> 
> 	if (err == -EOPNOTSUPP) {
> 		if (extack && !extack->_msg)
> 			NL_SET_ERR_MSG_MOD(extack,
> 					   "Offloading not supported");
> 		NL_SET_ERR_MSG_MOD(extack,
> 				   "Offloading not supported");
> 		err = 0;
> 	}
> 
> Imagine (not the case here) that below such a "warning extack" lies
> something like this:
> 
> 	if (arg > range) {
> 		NL_SET_ERR_MSG_MOD(extack, "Argument outside expected range");
> 		return -ERANGE;
> 	}
> 
> What you'll get is:
> 
> Error: Offloading not supported (error code -ERANGE).
> 
> whereas before, we relied on any NL_SET_ERR_MSG_MOD() call to overwrite
> the "warning" extack, and that to only be shown on error code 0.

Can we please discuss current code and not over-engineered case which
doesn't exist in the reality?

Even for your case, I would like to see NL_SET_ERR_MSG_FORCE() to
explicitly say that message will be overwritten.

Thanks
