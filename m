Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=fqdAl6g8T5b8CCdXDXU4kRWnVjawXTgSM4gnCS0YVDA=;
 b=ZWEgd7vuurDAY2I1OnulI6eiSL8yCLgaJoxMpVzt5uZhruJGgevRtmuMUMEDF/HrhA
 JCzlSUE7nEOuEstZXK1itDK7t2VNObOx8xyy5uxT9r5FS17kwIYw3Cz0wsxWFFE0ybSb
 YvET/f3syD85/VklUOqtDB0b6zfJ17S2Y/MTUHsRfTcabLGRuStz8HvoQ7AgSTZdc1pT
 Nm3ce8YwJ94fV35BlYmiohPT04whu4tCW5+w4L4kcC7z4LX/1nm8ATMQceEk3Bm/Ea9D
 QWN0GR5dVwT5xUq055j/e4Ld2/PAoL4O/cNV6xu9daYhvQwfRzigDSX8GGgcemWmcc9s
 JaXg==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <20220310150717.h7gaxamvzv47e5zc@skbuf>
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
 <20220310142320.611738-4-schultz.hans+netdev@gmail.com>
 <20220310142836.m5onuelv4jej5gvs@skbuf> <865yolg8d7.fsf@gmail.com>
 <20220310150717.h7gaxamvzv47e5zc@skbuf>
Date: Thu, 10 Mar 2022 16:51:15 +0100
Message-ID: <86sfrpergs.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 3/3] net: dsa: mv88e6xxx: mac-auth/MAB
 implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

On tor, mar 10, 2022 at 17:07, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Thu, Mar 10, 2022 at 04:00:52PM +0100, Hans Schultz wrote:
>> >> +	brport = dsa_port_to_bridge_port(dp);
>> >
>> > Since this is threaded interrupt context, I suppose it could race with
>> > dsa_port_bridge_leave(). So it is best to check whether "brport" is NULL
>> > or not.
>> >
>> Would something like:
>> if (dsa_is_unused_port(chip->ds, port))
>>         return -ENODATA;
>> 
>> be appropriate and sufficient for that?
>
> static inline
> struct net_device *dsa_port_to_bridge_port(const struct dsa_port *dp)
> {
> 	if (!dp->bridge)
> 		return NULL;
>
> 	if (dp->lag)
> 		return dp->lag->dev;
> 	else if (dp->hsr_dev)
> 		return dp->hsr_dev;
>
> 	return dp->slave;
> }
>
> Notice the "dp->bridge" check. The assignments are in dsa_port_bridge_create()
> and in dsa_port_bridge_destroy(). These functions assume rtnl_mutex protection.
> The question was how do you serialize with that, and why do you assume
> that dsa_port_to_bridge_port() returns non-NULL.
>
> So no, dsa_is_unused_port() would do absolutely nothing to help.

I was thinking in indirect terms (dangerous I know :-).

But wrt the nl lock, I wonder when other threads could pull the carpet
away under this, and so I might have to wait till after the last call
(mv88e6xxx_g1_atu_loadpurge) to free the nl lock?
