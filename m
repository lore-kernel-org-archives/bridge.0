Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FAD682FA9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 256D081902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7VGDIlKV6gAV8St0jIFraWnG2EvF6VYrYLOYj9aX/Sc=;
 b=GmdcHEVeVUWW4yGaLtIyHZprjnISw5pW33LwCwJJ7/fDA6Hcfxby9OeEN4idkGEUJr
 tlORqJvsztOQN74ymQ3E4sWlPqW/6bsqHfxN0YB8ADgv1BjiKCRCjYDOh7lZQBb3Tgl5
 BdUozqnyBMsdWXGwJFWBmb35kvsmDF2WLkvQp9mRsWZPmu6EbUWcypm8pcp2H715FnU4
 ipRQuQXENffTeeb6WWoDToEU9RkLs53PtRT5L1YrX7g0bef34vYKUzk1UcPVf5OSAeT5
 XYbuV7KUIBSkcnstqa0uuwHszYv7gMD72sraYPrXUBZl/08SljwdSVHfeHp5mJ+welFO
 bGEg==
MIME-Version: 1.0
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-4-schultz.hans+netdev@gmail.com>
 <20220627180557.xnxud7d6ol22lexb@skbuf>
 <CAKUejP7ugMB9d3MVX3m9Brw12_ocFoT+nuJJucYdQH70kzC7=w@mail.gmail.com>
 <CAKUejP5u9rrH8tODODG0a1PLXfLhk7NLe5LUYkefkbs15uU=BQ@mail.gmail.com>
 <20220706132834.rdw7mmpbwt55kt4r@skbuf>
In-Reply-To: <20220706132834.rdw7mmpbwt55kt4r@skbuf>
From: Hans S <schultz.hans@gmail.com>
Date: Wed, 6 Jul 2022 15:48:16 +0200
Message-ID: <CAKUejP7DjCoEjyzGWs4ZQF3_gfy6tBhCYs+H9Ja7hXcFw09qww@mail.gmail.com>
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

On Wed, Jul 6, 2022 at 3:28 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> On Tue, Jul 05, 2022 at 05:05:52PM +0200, Hans S wrote:
> > Hi, does anybody know what it going on with this variable?
> > struct dsa_port *dp ->ageing_time;
> >
> > I experience that it changes value like a factor ~10 at times.
>
> Could you be a bit more specific? Are you talking about STP Topology
> Change Notification BPDUs, which trigger this code path?
>
> diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
> index 7d27b2e6038f..9b25bc2dcb3e 100644
> --- a/net/bridge/br_stp.c
> +++ b/net/bridge/br_stp.c
> @@ -671,10 +671,10 @@ void __br_set_topology_change(struct net_bridge *br, unsigned char val)
>
>                 if (val) {
>                         t = 2 * br->forward_delay;
> -                       br_debug(br, "decreasing ageing time to %lu\n", t);
> +                       br_info(br, "decreasing ageing time to %lu\n", t);
>                 } else {
>                         t = br->bridge_ageing_time;
> -                       br_debug(br, "restoring ageing time to %lu\n", t);
> +                       br_info(br, "restoring ageing time to %lu\n", t);
>                 }
>
>                 err = __set_ageing_time(br->dev, t);
>
> Coincidentally the default values of 2 * br->forward_delay and br->bridge_ageing_time
> are 1 order of magnitude apart from each other.
>
> [  139.998310] br0: topology change detected, propagating
> [  140.003490] br0: decreasing ageing time to 3000
> [  175.193054] br0: restoring ageing time to 30000
>
> What's the problem anyway?

It might be a topology change as you indicate, though I am not sure.
So I am not using that variable any more for determining the ageing
time for the locked FDB entries, but instead I have made a function to
read the time from the chip instead.

The problem with that, I have mentioned in my latest reply to the
mac-auth patch set...
