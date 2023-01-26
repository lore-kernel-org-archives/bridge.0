Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 755ED40423
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BC6340194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674776362;
 bh=oUC5Mvm4GEqJrG9gIHdrxl6F610JpQsy0hRbjNPgPIQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nfxBNs6FM7NZKGVV3BMji9ruWlGp1t/3cOBJWL1bDMYEOk49YqHbDgN2af6DRVY/X
 H7E0DM6x9xalxWAFX7/6tcXHgHKmjRm4uH61vFvCBOr7Cx8Ai9w8BVdkz0FfA1u0Q/
 UShPs3Fuvvwk6ZQ3XAdmBoEFn6RgYhUonCYUeENa5RF7+PHd9pJGHHtKSZWH8//b7o
 GDtI8AZBvWAujDOjOnU43xnR1ePR802WZ0t6C43BqRZ3JpLag97b2N2ZQO+tB0qlFi
 7bmlfxJko+/jvOVyPwS8BviEs2+zesWJTKr3xr5syp9LXYR7Ul97pKEBvIe04lFpXL
 azIZVjSHuQC5g==
Date: Thu, 26 Jan 2023 15:39:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230126153921.3823054c@kernel.org>
In-Reply-To: <20230126224457.lc2ly5k77gkhycwa@skbuf>
References: <2919eb55e2e9b92265a3ba600afc8137a901ae5f.1674760340.git.leon@kernel.org>
 <20230126223213.riq6i2gdztwuinwi@skbuf>
 <20230126143723.7593ce0b@kernel.org>
 <20230126224457.lc2ly5k77gkhycwa@skbuf>
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

On Fri, 27 Jan 2023 00:44:57 +0200 Vladimir Oltean wrote:
> On Thu, Jan 26, 2023 at 02:37:23PM -0800, Jakub Kicinski wrote:
> > > I would somewhat prefer not doing this, and instead introducing a new
> > > NL_SET_ERR_MSG_WEAK() of sorts.  
> > 
> > That'd be my preference too, FWIW. It's only the offload cases which
> > need this sort of fallback.
> > 
> > BTW Vladimir, I remember us discussing this. I was searching the
> > archive as you sent this, but can't find the thread. Mostly curious
> > whether I flip flipped on this or I'm not completely useless :)  
> 
> What we discussed was on a patch of mine fixing "if (!extack->_msg)" to
> "if (extack && !extack->_msg)". I never proposed a new macro wrapper
> (you did), but I didn't do it at the time because it was a patch for
> "net", and I forgot to put a reminder for the next net->net-next merge.
> https://lore.kernel.org/netdev/20220822182523.6821e176@kernel.org/
> And from there, out of sight, out of mind.

That explains it, I was running blame the message lines, not the if ().
Thanks for digging it up!
