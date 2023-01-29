Return-Path: <leon@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA86C60BDB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D1AB60BB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674992637;
 bh=TDNIdzHxTsptTuCNlpFYNF7gjfmaOn0rB2AsJX19J5k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hOvSM4U1AJ7KK7hjfc/3LvNG/jlgHahNGjAbnGFqR6QKun/rCMcZr6mXMoXqgtEp1
 mIYGz2skNQJ/bUDvrxqGJsGk8gOukVsHq52r9i3vOZJ2EJDQoCsaIcLieHxOUf8OcC
 1yLqrgt8gC98ZSNqxQUhp6WOeTQIFcMV9FEf3bWliBJo4yUij5k9kqiymP89vayMpV
 62MXB7TfSvuGBHZFijK+dMsQ4ZqwP/KOhXO3Q98lMRL/ZS3S+y7fE2UP9VHR/DI+4r
 MujKSToQUXOktj9Qy+dEE7dEfbak6b7ltI1TLwxcr42tlREZiZyG4vkbTzRwKmFpl7
 YikMf3b9QUg0w==
Date: Sun, 29 Jan 2023 13:43:53 +0200
From: Leon Romanovsky <leon@kernel.org>
Message-ID: <Y9Zb+RU637gLIwgz@unreal>
References: <2919eb55e2e9b92265a3ba600afc8137a901ae5f.1674760340.git.leon@kernel.org>
 <20230126223213.riq6i2gdztwuinwi@skbuf>
 <20230126143723.7593ce0b@kernel.org> <Y9NgdXk3NLtjG3Mj@unreal>
 <20230126232615.1901128c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126232615.1901128c@kernel.org>
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

On Thu, Jan 26, 2023 at 11:26:15PM -0800, Jakub Kicinski wrote:
> On Fri, 27 Jan 2023 07:26:13 +0200 Leon Romanovsky wrote:
> > > That'd be my preference too, FWIW. It's only the offload cases which
> > > need this sort of fallback.  
> > 
> > Of course not, almost any error unwind path which sets extack will need it.
> 
> I guess we can come up with scenarios where the new behavior would 
> be useful. But the fact is - your patch changes 4 places...

ok, I'll rename.

> 
> > See devlink as an example
> 
> I don't know what part of devlink you mean at a quick scroll.

I overlooked "return err" in the middle.
You are right.

Thanks
