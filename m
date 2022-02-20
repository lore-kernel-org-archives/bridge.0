Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MQZZTj8nabcqXlOJo
 8XpXYmPncZlkb2pDfrS1E/GCWs=; b=KPnK0JrrURZg2WB91bNRyRRM9j3C9wClc
 a9v83tOZN9Uut3wzny0nLKGJ/f70x9a6yywbUUGMcW4inDsa3EjQKwxNIayD6eBZ
 BQba8pBxL95XH2OWwCKBkidPeEatOhwZ1CKtNnrhKbttlBEkf/d9MRkXHubAZMzP
 NW3IW3VFXwVxYJnSZBQQzeaQe8EJnDwWVhUjjHwGt6n1BE/nQAKIfLhoYa4qgqP+
 ngyEPPZ1PeX8qdcWEQzgGvhNC4Tjz6+FvVlzWDO3fzDuGNSFSbW3SgAW7CuyX1Z/
 iWq0qjIqgwNev9+byaMnUftAdHnJANOhwvhtfmOeHZg9j2MBqlAQA==
Date: Sun, 20 Feb 2022 11:21:43 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YhIIJxxXP3JzD60/@shredder>
References: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
 <20220218155148.2329797-5-schultz.hans+netdev@gmail.com>
 <20220219100034.lh343dkmc4fbiad3@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219100034.lh343dkmc4fbiad3@skbuf>
Subject: Re: [Bridge] [PATCH net-next v3 4/5] net: dsa: mv88e6xxx: Add
 support for bridge port locked mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, Hans Schultz <schultz.hans@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, David Ahern <dsahern@kernel.org>, Hans Schultz <schultz.hans+netdev@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Sat, Feb 19, 2022 at 12:00:34PM +0200, Vladimir Oltean wrote:
> On Fri, Feb 18, 2022 at 04:51:47PM +0100, Hans Schultz wrote:
> > diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
> > index ab41619a809b..46b7381899a0 100644
> > --- a/drivers/net/dsa/mv88e6xxx/port.c
> > +++ b/drivers/net/dsa/mv88e6xxx/port.c
> > @@ -1234,6 +1234,39 @@ int mv88e6xxx_port_set_mirror(struct mv88e6xxx_chip *chip, int port,
> >  	return err;
> >  }
> >  
> > +int mv88e6xxx_port_set_lock(struct mv88e6xxx_chip *chip, int port,
> > +			    bool locked)
> > +{
> > +	u16 reg;
> > +	int err;
> > +
> > +	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_CTL0, &reg);
> > +	if (err)
> > +		return err;
> > +
> > +	reg &= ~MV88E6XXX_PORT_CTL0_SA_FILT_MASK;
> > +	if (locked)
> > +		reg |= MV88E6XXX_PORT_CTL0_SA_FILT_DROP_ON_LOCK;
> > +
> > +	err = mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_CTL0, reg);
> > +	if (err)
> > +		return err;
> > +
> > +	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_ASSOC_VECTOR, &reg);
> > +	if (err)
> > +		return err;
> > +
> > +	reg &= ~MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT;
> > +	if (locked)
> > +		reg |= MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT;
> > +
> > +	err = mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_ASSOC_VECTOR, reg);
> 
> 	return mv88e6xxx_port_write(...);

Not familiar with mv88e6xxx, but shouldn't there be a rollback of
previous operations? Specifically mv88e6xxx_port_write()

> 
> > +	if (err)
> > +		return err;
> > +
> > +	return 0;
> > +}
