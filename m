Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5081261442
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 51CAB613F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=K0iZiXinEatv8xEcBISd59Ab8eNplLifK/KFllgmDfA=;
 b=AkKkSH90WBGW9spYSEFDjhuJfRAK1ihCSwwzha9d19mrwuRU2ZUQa5QaL9Mx5vKUSw
 0zHYHRn56sSlCNx6XxWOue2MBL05jvRsk9cfBCwzBROcGgURGosPCaCXTn0qhBMZhfjd
 e8zM93KjwIcl3oNi4eG7snL8BNEFwvunUQkQy7MncYAmYtgHXYDz62fxHPJuALmnTBYX
 27n96hX2Hn5khXgz0InQoSDBO1eb1oxxWeO6toAtc2AKzHG9jRWxxqeOt/NAk+2Gy/Kj
 uSRGoVa/M9Ct/sUVJfLqY1V9us0aLfTaUY8j6xMhhnRUy6h8v6WohYydD5/131WLXu2j
 vTFQ==
Date: Fri, 1 Jul 2022 18:27:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220701152700.sf2h6wbxx6dgll7a@skbuf>
References: <20220630111634.610320-1-hans@kapio-technology.com>
 <Yr2LFI1dx6Oc7QBo@shredder>
 <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
 <Yr778K/7L7Wqwws2@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr778K/7L7Wqwws2@shredder>
Subject: Re: [Bridge] [PATCH net-next v1 1/1] net: bridge: ensure that
 link-local traffic cannot unlock a locked port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Hans Schultz <hans@kapio-technology.com>, netdev@vger.kernel.org, Hans S <schultz.hans@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, Nikolay Aleksandrov <razor@blackwall.org>

On Fri, Jul 01, 2022 at 04:51:44PM +0300, Ido Schimmel wrote:
> On Fri, Jul 01, 2022 at 09:47:24AM +0200, Hans S wrote:
> > One question though... wouldn't it be an issue that the mentioned
> > option setting is bridge wide, while the patch applies a per-port
> > effect?
> 
> Why would it be an issue? To me, the bigger issue is changing the
> semantics of "locked" in 5.20 compared to previous kernels.
> 
> What is even the use case for enabling learning when the port is locked?
> In current kernels, only SAs from link local traffic will be learned,
> but with this patch, nothing will be learned. So why enable learning in
> the first place? As an administrator, I mark a port as "locked" so that
> only traffic with SAs that I configured will be allowed. Enabling
> learning when the port is locked seems to defeat the purpose?

I think if learning on a locked port doesn't make sense, the bridge
should just reject that configuration.
