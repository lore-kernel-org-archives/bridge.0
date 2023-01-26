Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7906611B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1BEFC6118B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iE05OBNMo3ni76Q952FJPiDeCM0tKQpiRcc9yap5LRk=;
 b=OCpuwxPm3MTKC4NFGxVbHE33IbNPBEo1Y6BEUx6MiRbPDf8mc32vn4xArGwTO8Pv5w
 FCo1dJVl/Vppujf9pqTTwrbVpz3WSI3sp2tXZZPoLEnXtNTWe09mYY95dZOo51VDSxFd
 oqDZTQsRpYw2CNEcx5SI80I4CB6Zk28FUL49vE7EfvAWcfAjDd8Yo6wyya+JQ2VMPFU8
 x+ymjnoOGIo6DbUxtKl82JiWneVXFH8Ov2LVnIMLJsSAEwmV/oEwJTBDYvOesW22dQ42
 nTkUbIOOy21HZJ5jLSqJsywOUcdjjSsvuoVQysYpAOVTT8BZYnbPXW9bNUuTwsF7rt6O
 reJA==
Date: Fri, 27 Jan 2023 00:44:57 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230126224457.lc2ly5k77gkhycwa@skbuf>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Leon Romanovsky <leonro@nvidia.com>, "David S . Miller" <davem@davemloft.net>

On Thu, Jan 26, 2023 at 02:37:23PM -0800, Jakub Kicinski wrote:
> > I would somewhat prefer not doing this, and instead introducing a new
> > NL_SET_ERR_MSG_WEAK() of sorts.
> 
> That'd be my preference too, FWIW. It's only the offload cases which
> need this sort of fallback.
> 
> BTW Vladimir, I remember us discussing this. I was searching the
> archive as you sent this, but can't find the thread. Mostly curious
> whether I flip flipped on this or I'm not completely useless :)

What we discussed was on a patch of mine fixing "if (!extack->_msg)" to
"if (extack && !extack->_msg)". I never proposed a new macro wrapper
(you did), but I didn't do it at the time because it was a patch for
"net", and I forgot to put a reminder for the next net->net-next merge.
https://lore.kernel.org/netdev/20220822182523.6821e176@kernel.org/
And from there, out of sight, out of mind.
