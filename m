Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F08E6113C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 542E860B2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674804378;
 bh=YRpZqCUJGzHFe4qMsVOvMtBYuFuPJtP4nCTJvR/19U8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TboVLCAn/Zgr2F7n0/AWrfYqTJoIjiwQXuMqPI/rMzBWMMMY41XC3lh+wsQQwm8kH
 saxjDHpJssdcWWb/dQl8Fs5jwfdyMT3AvgMEFIH1mp8Tm6sTW+CohoYlS5Q/y/JXwx
 yasy5MHQLb1UMpUYLxZ5uV5ahWTNJQkPLkxg/VCfPFtUYqatgb7HHo2PMp86J6pzmJ
 zgpc3CeOgWvNvyTCMyxJUGCxQun96LF6aaMEDRqzKWzAucAIhS7SU4t3Qbm0v2uZVP
 WqnklZYL9zqOEQ7UefYCpZkjd6ZyzA26cNWBXW6ji2QNnb+IUYbQz7zm5BulHpDExR
 Q9AtJluRXF+Tg==
Date: Thu, 26 Jan 2023 23:26:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230126232615.1901128c@kernel.org>
In-Reply-To: <Y9NgdXk3NLtjG3Mj@unreal>
References: <2919eb55e2e9b92265a3ba600afc8137a901ae5f.1674760340.git.leon@kernel.org>
 <20230126223213.riq6i2gdztwuinwi@skbuf>
 <20230126143723.7593ce0b@kernel.org> <Y9NgdXk3NLtjG3Mj@unreal>
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
To: Leon Romanovsky <leon@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>

On Fri, 27 Jan 2023 07:26:13 +0200 Leon Romanovsky wrote:
> > That'd be my preference too, FWIW. It's only the offload cases which
> > need this sort of fallback.  
> 
> Of course not, almost any error unwind path which sets extack will need it.

I guess we can come up with scenarios where the new behavior would 
be useful. But the fact is - your patch changes 4 places...

> See devlink as an example

I don't know what part of devlink you mean at a quick scroll.
