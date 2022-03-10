Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=60uYG3ckY3WcYm8l3Wrv4qJH3dnlWFZqsAvB7+3ByW0=;
 b=is2XzSK4nxrutLs8h20VyMU7x3CVgv/M56eIif7Nnfl/h77xnTU4TVvx9LJTFzKN54
 xbtUokAT0kbf6nUHZtgHz/6JxBbVHaLSg/9d9GyglRPJ1M8rmXT93D6Ia3I20/0uVnH1
 ps7cvKs1J4WQejow2+4miwnHu6jgg1GmqAuYOg9S6VloqH9t2uZZf3VtE1cYOrcRu8hZ
 JREp9V1GIqrHrWRAQyEZtTJYQ9DReztp52i9TlhxQGZzkMOgWVGGI2BxEBQAaIUfDkja
 rWtxHH/RJEDz7foPphypKWHQ2Jc1MBc3vJ0SsOulZBRqlED9CK+f8AojLcU7sNF955TG
 8Wcg==
Date: Thu, 10 Mar 2022 17:07:17 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220310150717.h7gaxamvzv47e5zc@skbuf>
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
 <20220310142320.611738-4-schultz.hans+netdev@gmail.com>
 <20220310142836.m5onuelv4jej5gvs@skbuf> <865yolg8d7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865yolg8d7.fsf@gmail.com>
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
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

On Thu, Mar 10, 2022 at 04:00:52PM +0100, Hans Schultz wrote:
> >> +	brport = dsa_port_to_bridge_port(dp);
> >
> > Since this is threaded interrupt context, I suppose it could race with
> > dsa_port_bridge_leave(). So it is best to check whether "brport" is NULL
> > or not.
> >
> Would something like:
> if (dsa_is_unused_port(chip->ds, port))
>         return -ENODATA;
> 
> be appropriate and sufficient for that?

static inline
struct net_device *dsa_port_to_bridge_port(const struct dsa_port *dp)
{
	if (!dp->bridge)
		return NULL;

	if (dp->lag)
		return dp->lag->dev;
	else if (dp->hsr_dev)
		return dp->hsr_dev;

	return dp->slave;
}

Notice the "dp->bridge" check. The assignments are in dsa_port_bridge_create()
and in dsa_port_bridge_destroy(). These functions assume rtnl_mutex protection.
The question was how do you serialize with that, and why do you assume
that dsa_port_to_bridge_port() returns non-NULL.

So no, dsa_is_unused_port() would do absolutely nothing to help.
