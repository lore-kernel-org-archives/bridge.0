Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC92540AE8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F4E24012D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WPpPFt2vreAvukEchuJ8KcyDhd0FY1gp7qevaVZJpHI=;
 b=MipxUNNv1CuzDomW4TDLl1zhaylRYTrx3HZq9GYsjxdcB9+8zSPYgqHTdiwr1z+vMx
 1FrXYtgFdTKQJAw332y5OtL+a1DSibzdekPFpU8scZF5wsXT5IozNxflL5z/F9J/EOc8
 6fUUAb+3A0iOvdHXB3B0v7vb03sGXtWPoywgxAYh5fGJNL2Gf/akgZZ3o5Q2t/X8AhTv
 oGRsf1z5hI6JAZutJvqwANARqRbZmUNjWEgtE6le0ja1+VhmfDcpIbt7w6NmofsaRELe
 4kHBuQJNq9n9YQUGsOMl/wOhnMFV9A/p892T0cj4Bxeo7uwyANFpUYfIfrchPmUhtkUp
 n2Rw==
MIME-Version: 1.0
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-4-schultz.hans+netdev@gmail.com>
 <20220627180557.xnxud7d6ol22lexb@skbuf>
 <CAKUejP7ugMB9d3MVX3m9Brw12_ocFoT+nuJJucYdQH70kzC7=w@mail.gmail.com>
 <20220706085559.oyvzijcikivemfkg@skbuf>
 <CAKUejP7gmULyrjqd3b3PiWwi7TJzF4HNuEbmAf25Cqh3w7a1mw@mail.gmail.com>
In-Reply-To: <CAKUejP7gmULyrjqd3b3PiWwi7TJzF4HNuEbmAf25Cqh3w7a1mw@mail.gmail.com>
From: Hans S <schultz.hans@gmail.com>
Date: Wed, 6 Jul 2022 16:23:25 +0200
Message-ID: <CAKUejP5modz89PxvgjWxNZ6mwyfdD+e2r_2n0Aj+HF8LFfn9SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH V3 net-next 3/4] net: dsa: mv88e6xxx:
	mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

> >> @@ -919,6 +920,9 @@ static void mv88e6xxx_mac_link_down(struct dsa_switch *ds, int port,
> >>       if (err)
> >>               dev_err(chip->dev,
> >>                       "p%d: failed to force MAC link down\n", port);
> >> +     else
> >> +             if (mv88e6xxx_port_is_locked(chip, port, true))
> >> +                     mv88e6xxx_atu_locked_entry_flush(ds, port);
> >
> >This is superfluous, is it not? The bridge will transition a port whose
> >link goes down to BR_STATE_DISABLED, which will make dsa_port_set_state()
> >fast-age the dynamic FDB entries on the port, which you've already
> >handled below.
>
> I removed this code, but then on link down the locked entries were not
> cleared out. Something not as thought?

I don't see a fast ageing happening on link down. There is the two cases:
1. Soft link down

With iproute2 command the link is brought down and
mv88e6xxx_mac_link_down() is called with rtnl lock taken.

2. Hard link down

I remove the cable from the port and mv88e6xxx_mac_link_down() is
called without rtnl lock.

As the hard link down case calls without rtnl lock, either I trigger
the case you have mentioned or I have to use rtnl_is_locked()
somewhere along the line?
