Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0A3E8261C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3942825CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674772645;
 bh=BqN63kESite/GwGbcTDZJEsDxlch3Z0ud2s3mGndcWQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=INWR3luDRDneBE1kaIyoqX5ir2ui75Jg1hfTQ4v5uOOb7PPAyGd/tsdnK4frWHqyz
 u14pLVDKx1ficmtrfRaTNGzIS8sZJfhrIH1cMZhiX08qYmPHPt05Lu4JduSIoiZtQk
 Rnil2Mgt65tZ1olfvzo5pNJmOQrtJk3oCE1f6DnyENi5cSk22EZ9LLS3lQvkI4GRGP
 Y+C7+08o61NZaJ5X8rZ3ePGvBr6Rh9CW8Qc9rY9ncc1wA48WL5b+niacMBXnNkfy7A
 IYJj/U+znQsFdJrfLy9Y5SA6oRCcqD4otWDvGOgwzFRS0fOYXn4lh6bNOEy5aMUZLf
 X1KbQzmB+gjVg==
Date: Thu, 26 Jan 2023 14:37:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230126143723.7593ce0b@kernel.org>
In-Reply-To: <20230126223213.riq6i2gdztwuinwi@skbuf>
References: <2919eb55e2e9b92265a3ba600afc8137a901ae5f.1674760340.git.leon@kernel.org>
 <20230126223213.riq6i2gdztwuinwi@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Leon Romanovsky <leonro@nvidia.com>, "David S . Miller" <davem@davemloft.net>

On Fri, 27 Jan 2023 00:32:13 +0200 Vladimir Oltean wrote:
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

That'd be my preference too, FWIW. It's only the offload cases which
need this sort of fallback.

BTW Vladimir, I remember us discussing this. I was searching the
archive as you sent this, but can't find the thread. Mostly curious
whether I flip flipped on this or I'm not completely useless :)

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
