Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 324184063F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C3B7C405C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W+jlpxCiLxqPrdit5yv1HIE5bJMcahl5oA1vEeJTqc=;
 b=qVh3FVpBNSOcxk66xv0Un6crB47gVcB1/sg5YJyG6P0+nbkFcbJYq0B3hhPldLxsLZEs/RLq4pyhK5zJA7/1exCNuoATqMWL0AmU/nKW9JhXPuFMwGqagXSsrzy2P8Dm2wdmHNlkei5QQLcTTZ6vAKNxcn1iQGsdcGnRbK61knjNO+eS4CR9RqsSt34tGxU8Tgq5RfALV9E9+RNKLjnRy3WgoheNecHIZ1qJbSyG6RckET0b98ZNqkrKbXSodDN6NDsqTwGnMPh8QfM+aT4nNBNMBHrZhr9gxgVS/Fgd2UiWKaiMjuKPRQ7D8+R90XlpqOeWjwWSkckqkG7BfMfMkg==
Date: Fri, 1 Jul 2022 18:44:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Yr8Wb9mTTnHsMQLL@shredder>
References: <20220630111634.610320-1-hans@kapio-technology.com>
 <Yr2LFI1dx6Oc7QBo@shredder>
 <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
 <Yr778K/7L7Wqwws2@shredder> <20220701152700.sf2h6wbxx6dgll7a@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701152700.sf2h6wbxx6dgll7a@skbuf>
MIME-Version: 1.0
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Hans Schultz <hans@kapio-technology.com>, netdev@vger.kernel.org, Hans S <schultz.hans@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, Nikolay Aleksandrov <razor@blackwall.org>

On Fri, Jul 01, 2022 at 06:27:00PM +0300, Vladimir Oltean wrote:
> On Fri, Jul 01, 2022 at 04:51:44PM +0300, Ido Schimmel wrote:
> > On Fri, Jul 01, 2022 at 09:47:24AM +0200, Hans S wrote:
> > > One question though... wouldn't it be an issue that the mentioned
> > > option setting is bridge wide, while the patch applies a per-port
> > > effect?
> > 
> > Why would it be an issue? To me, the bigger issue is changing the
> > semantics of "locked" in 5.20 compared to previous kernels.
> > 
> > What is even the use case for enabling learning when the port is locked?
> > In current kernels, only SAs from link local traffic will be learned,
> > but with this patch, nothing will be learned. So why enable learning in
> > the first place? As an administrator, I mark a port as "locked" so that
> > only traffic with SAs that I configured will be allowed. Enabling
> > learning when the port is locked seems to defeat the purpose?
> 
> I think if learning on a locked port doesn't make sense, the bridge
> should just reject that configuration.

I tend to agree... Let's wait for Hans to explain why learning needs to
be enabled on mv88e6xxx and see how we handle it in mv88e6xxx and the
bridge.
